local tweenService = game:GetService("TweenService");
local replicatedStorage = game:GetService("ReplicatedStorage");
local userInputService = game:GetService("UserInputService");
local players = game:GetService("Players");

local sessionTimeLuckController = require(replicatedStorage.Modules.SessionTimeLuckController);
local playerLuckModule = require(replicatedStorage.Modules.PlayerLuck);

local sendClientWeatherEventsRemote = replicatedStorage.GameEvents:WaitForChild("SendClientWeatherEvents");
local weatherEventStartedRemote = replicatedStorage.GameEvents:WaitForChild("WeatherEventStarted");

local bottomFrame = script.Parent:WaitForChild("BottomFrame");
local eventHolderFrame = bottomFrame:WaitForChild("Holder");
local infoPopupFrame = bottomFrame:WaitForChild("Info");

local eventDisplayDetails = {
	Rain = {
		Title = "Rain",
		Description = "+50% Grow Speed! Higher <font color=\"#0055ff\">WET</font> Fruit Chance!"
	},
	Thunderstorm = {
		Title = "Thunderstorm",
		Description = "+50% Grow Speed! Higher <font color=\"#0055ff\">SHOCKED</font> Fruit Chance!"
	},
	Frost = {
		Title = "Frost",
		Description = "+50% Grow Speed! Higher <font color=\"#66ccff\">CHILLED</font> and <font color=\"#00e5ff\">FROZEN</font> Fruit Chance!"
	},
	Luck = {
		Title = "Luck",
		Description = function()
			return ("+%*%% Playtime Luck"):format((math.floor(sessionTimeLuckController:GetCurrentLuck() * 100)));
		end
	}
};

local isEventHolderVisible = false;
local activeEventNames = {};
local serverEventConfig = {}; -- Populated by SendClientWeatherEvents

local function createTween(guiObject, duration, goalProperties, easingStyle, easingDirection, delayTime)
	local tweenInstance = tweenService:Create(guiObject, TweenInfo.new(duration, easingStyle or Enum.EasingStyle.Linear, easingDirection or Enum.EasingDirection.InOut, 0, false, delayTime or 0), goalProperties);
	tweenInstance:Play();
	return tweenInstance;
end;

local function showPopup(guiObject, offsetPosition, duration)
	guiObject.Position = UDim2.new(guiObject.Position.X.Scale, offsetPosition.X, guiObject.Position.Y.Scale, offsetPosition.Y);
	if not guiObject.Visible then
		guiObject.Visible = true;
	end;
	local tweenDuration = duration or 0.1;
	local goalProperties = {
		Position = UDim2.new(guiObject.Position.X.Scale, 0, guiObject.Position.Y.Scale, 0)
	};
	local quadEasing = Enum.EasingStyle.Quad;
	local outDirection = Enum.EasingDirection.Out;
	tweenService:Create(guiObject, TweenInfo.new(tweenDuration, quadEasing, outDirection, 0, false, 0), goalProperties):Play();
end;

local function updateEventDisplay()
	if #activeEventNames == 0 and isEventHolderVisible then
		isEventHolderVisible = false;
		local goalProperties = {
			Position = UDim2.fromScale(1, 1.2)
		};
		local quintEasing = Enum.EasingStyle.Quint;
		local inDirection = Enum.EasingDirection.In;
		createTween(eventHolderFrame, 0.25, goalProperties, quintEasing, inDirection);
		infoPopupFrame.Visible = false;
		task.delay(0.25, function()
			eventHolderFrame.Visible = false;
		end);
		return;
	else
		if not isEventHolderVisible and #activeEventNames > 0 then -- Added check to prevent showing empty holder
			isEventHolderVisible = true;
			eventHolderFrame.Position = UDim2.fromScale(0.5, -0.25);
			eventHolderFrame.Visible = true;
			for _, childFrame in eventHolderFrame.List:GetChildren() do
				if childFrame:IsA("Frame") then
					childFrame.Visible = false;
				end;
			end;
			local goalProperties = {
				Position = UDim2.fromScale(1, 1)
			};
			local backEasing = Enum.EasingStyle.Back;
			local outDirection = Enum.EasingDirection.Out;
			createTween(eventHolderFrame, 0.5, goalProperties, backEasing, outDirection);
			task.wait(0.4);
		end;

		if isEventHolderVisible then -- Only update children if holder is meant to be visible
			for _, childFrame in eventHolderFrame.List:GetChildren() do
				if childFrame:IsA("Frame") then
					if table.find(activeEventNames, childFrame.Name) then
						if not childFrame.Visible then -- Animate in only if not already visible
							childFrame.UIScale.Scale = 0;
							childFrame.Visible = true;
							local uiScaleInstance = childFrame.UIScale;
							local goalProperties = { Scale = 1 };
							local backEasing = Enum.EasingStyle.Back;
							local outDirection = Enum.EasingDirection.Out;
							createTween(uiScaleInstance, 0.25, goalProperties, backEasing, outDirection);
						end
					else
						if childFrame.Visible then -- Animate out only if currently visible
							local uiScaleInstance = childFrame.UIScale;
							local goalProperties = { Scale = 0 };
							local backEasing = Enum.EasingStyle.Back;
							local inDirection = Enum.EasingDirection.In;
							createTween(uiScaleInstance, 0.25, goalProperties, backEasing, inDirection);
							task.delay(0.25, function()
								childFrame.Visible = false;
							end);
						end
					end;
				end;
			end;
		end
		return;
	end;
end;

local function addTemporaryEvent(eventName, duration)
	if not table.find(activeEventNames, eventName) then -- Prevent duplicates
		table.insert(activeEventNames, eventName);
		updateEventDisplay();
	end
	task.delay(duration, function()
		local foundIndex = table.find(activeEventNames, eventName);
		if not foundIndex then
			return;
		else
			table.remove(activeEventNames, foundIndex);
			updateEventDisplay();
			return;
		end;
	end);
end;


local function getEventTitle(eventName)
	local eventDetails = eventDisplayDetails[eventName];
	if not eventDetails then
		return "Event Not Found";
	else
		local titleValue = eventDetails.Title;
		if type(titleValue) == "function" then
			titleValue = titleValue();
		end;
		return titleValue;
	end;
end;

local function getEventDescription(eventName)
	local eventDetails = eventDisplayDetails[eventName];
	if not eventDetails then
		return "Event Not Found";
	else
		local descriptionValue = eventDetails.Description;
		if type(descriptionValue) == "function" then
			descriptionValue = descriptionValue();
		end;
		return descriptionValue;
	end;
end;

sendClientWeatherEventsRemote.OnClientEvent:Connect(function(eventConfig, activeEventName, eventStartTime)
	serverEventConfig = eventConfig; -- Store the full config
	if not activeEventName or not serverEventConfig[activeEventName] then -- Check if active event exists in config
		return;
	else
		local serverTimeNow = workspace:GetServerTimeNow();
		local remainingDuration = eventStartTime + serverEventConfig[activeEventName].eventLength - serverTimeNow;
		if remainingDuration <= 0 then
			return;
		else
			addTemporaryEvent(activeEventName, remainingDuration); -- Use the addTemporaryEvent function
			return;
		end;
	end;
end);

weatherEventStartedRemote.OnClientEvent:Connect(function(eventName, duration)
	addTemporaryEvent(eventName, duration); -- Use the addTemporaryEvent function
end);


local function setupInfoPopupEvents(eventFrame)
	eventFrame:GetPropertyChangedSignal("Visible"):Connect(function() -- Hide info if frame hides
		if not eventFrame.Visible then
			infoPopupFrame.Visible = false
		end
	end)

	if userInputService.TouchEnabled then
		eventFrame.InputBegan:Connect(function()
			if table.find(activeEventNames, eventFrame.Name) then
				infoPopupFrame.Title.Text = getEventTitle(eventFrame.Name)
				infoPopupFrame.Description.Text = getEventDescription(eventFrame.Name)
				infoPopupFrame.Visible = true;
			end
		end)
		eventFrame.InputEnded:Connect(function()
			infoPopupFrame.Visible = false;
		end)
	else
		eventFrame.MouseEnter:Connect(function()
			if table.find(activeEventNames, eventFrame.Name) then
				infoPopupFrame.Title.Text = getEventTitle(eventFrame.Name)
				infoPopupFrame.Description.Text = getEventDescription(eventFrame.Name)
				infoPopupFrame.Visible = true;
			end
		end)
		eventFrame.MouseLeave:Connect(function()
			infoPopupFrame.Visible = false;
		end)
	end
end


if userInputService.TouchEnabled then
	bottomFrame.Position = UDim2.new(1, 0, 0.1, 0);
	infoPopupFrame.Position = UDim2.new(0.95, 0, 1.8, 0);
end;

for _, eventFrame in eventHolderFrame.List:GetChildren() do
	if eventFrame:IsA("Frame") then
		setupInfoPopupEvents(eventFrame)
	end;
end;


playerLuckModule.Listen(players.LocalPlayer, function()
	-- Check if luck modifiers warrant showing the "Luck" display
	if #playerLuckModule.GetModifiers(players.LocalPlayer, nil, "BottomDisplay") > 0 then -- Logic adjusted slightly to match likely intent (show if ANY luck mod exists)
		if not table.find(activeEventNames, "Luck") then
			table.insert(activeEventNames, "Luck");
			updateEventDisplay();
		end;
	else
		local foundIndex = table.find(activeEventNames, "Luck");
		if foundIndex then
			table.remove(activeEventNames, foundIndex);
			updateEventDisplay();
		end;
	end;
end);

-- Initial check for luck on script start
if #playerLuckModule.GetModifiers(players.LocalPlayer, nil, "BottomDisplay") > 0 then
	if not table.find(activeEventNames, "Luck") then
		table.insert(activeEventNames, "Luck")
	end
end
updateEventDisplay() -- Initial UI update based on current state