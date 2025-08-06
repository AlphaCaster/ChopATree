-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local topNotificationFrame = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Top_Notification"):WaitForChild("Frame");
local tweenService = game:GetService("TweenService");
local _ = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local _ = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local notificationSound = game.SoundService.Notification;
local _ = game:GetService("RunService");
local notificationUIMobileTemplate = game.ReplicatedStorage.Notification_UI_Mobile;
local notificationUITemplate = game.ReplicatedStorage.Notification_UI;
task.spawn(function() --[[ Line: 17 ]]
	-- upvalues: l_Frame_0 (copy), l_TweenService_0 (copy)
	while true do
		for _, notificationUI in (topNotificationFrame:GetChildren()) do
			if notificationUI:IsA("Frame") and (notificationUI.Name == "Notification_UI" or notificationUI.Name == "Notification_UI_Mobile") then
				local notificationTimer = notificationUI:GetAttribute("NotificationTimer");
				if notificationTimer and type(notificationTimer) == "number" then
					notificationTimer = notificationTimer - 1;
					if notificationTimer <= 0 then
						notificationUI:SetAttribute("NotificationTimer", nil);
						local fadeOutTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
						local slideOutTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
						local initialTextPosition = notificationUI.TextLabel.Position;
						tweenService:Create(notificationUI.TextLabel, slideOutTweenInfo, {
							Position = initialTextPosition + UDim2.new(0, 0, 0.2, 0)
						}):Play();
						tweenService:Create(notificationUI.ImageLabel, fadeOutTweenInfo, {
							ImageTransparency = 1
						}):Play();
						tweenService:Create(notificationUI.TextLabel, fadeOutTweenInfo, {
							TextTransparency = 1
						}):Play();
						tweenService:Create(notificationUI.TextLabel, fadeOutTweenInfo, {
							TextStrokeTransparency = 1
						}):Play();
						game.Debris:AddItem(notificationUI, fadeOutTweenInfo.Time);
					else
						notificationUI:SetAttribute("NotificationTimer", notificationTimer);
					end;
				end;
			end;
		end;
		task.wait(1);
	end;
end);
local function createNotification(isMobile, notificationText, canDuplicate) --[[ Line: 47 ]] --[[ Name: CreateNotification ]]
	-- upvalues: l_Notification_UI_Mobile_0 (copy), l_Notification_UI_0 (copy), l_Frame_0 (copy), l_TweenService_0 (copy), l_Notification_0 (copy)
	local fadeInTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
	local slideInTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
	local notificationUIClone = isMobile and notificationUIMobileTemplate or notificationUITemplate;
	local existingNotificationUI = nil;
	if not canDuplicate then
		for _, existingNotification in ipairs(topNotificationFrame:GetChildren()) do
			if existingNotification.Name == "Notification_UI" and existingNotification:GetAttribute("OG") == notificationText then
				existingNotificationUI = existingNotification;
				break;
			end;
		end;
	end;
	if existingNotificationUI then
		local notificationCountValue = existingNotificationUI:FindFirstChild("VAL_OBJ");
		if notificationCountValue then
			notificationCountValue.Value = notificationCountValue.Value + 1;
			existingNotificationUI.TextLabel.Text = notificationText .. " [X" .. notificationCountValue.Value .. "]";
		end;
		local _ = existingNotificationUI:GetAttribute("NotificationTimer") or 0;
		existingNotificationUI:SetAttribute("NotificationTimer", 3.5);
		return;
	else
		local notificationUIInstance = notificationUIClone:Clone();
		notificationUIInstance.TextLabel.Text = notificationText;
		notificationUIInstance:SetAttribute("OG", notificationText);
		notificationUIInstance:SetAttribute("NotificationTimer", 3.5);
		local intValue = Instance.new("IntValue");
		intValue.Name = "VAL_OBJ";
		intValue.Value = 1;
		intValue.Parent = notificationUIInstance;
		local textLabelPosition = notificationUIInstance.TextLabel.Position;
		local textLabel = notificationUIInstance.TextLabel;
		textLabel.Position = textLabel.Position - UDim2.new(0, 0, 0.2, 0);
		notificationUIInstance.ImageLabel.ImageTransparency = 1;
		notificationUIInstance.TextLabel.TextTransparency = 1;
		notificationUIInstance.TextLabel.TextStrokeTransparency = 1;
		notificationUIInstance.Parent = topNotificationFrame;
		tweenService:Create(notificationUIInstance.TextLabel, slideInTweenInfo, {
			Position = textLabelPosition
		}):Play();
		tweenService:Create(notificationUIInstance.ImageLabel, fadeInTweenInfo, {
			ImageTransparency = 0.5
		}):Play();
		tweenService:Create(notificationUIInstance.TextLabel, fadeInTweenInfo, {
			TextTransparency = 0
		}):Play();
		tweenService:Create(notificationUIInstance.TextLabel, fadeInTweenInfo, {
			TextStrokeTransparency = 0
		}):Play();
		notificationSound.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
		notificationSound.Playing = true;
		notificationSound.TimePosition = 0;
		existingNotificationUI = notificationUIInstance;
		return;
	end;
end;
game.ReplicatedStorage:WaitForChild("GameEvents").Notification.OnClientEvent:Connect(function(arg1, arg2) --[[ Line: 115 ]]
	-- upvalues: v29 (copy)
	if arg1 == "Successfully bought! Thank you 💖" then
		game:GetService("SoundService"):PlayLocalSound(game.SoundService.Purchase)
	end
	createNotification(game:GetService("UserInputService").TouchEnabled, arg1, arg2);
end);
return {
	CreateNotification = function(_, arg5) --[[ Line: 127 ]] --[[ Name: CreateNotification ]]
		-- upvalues: v29 (copy)
		local isTouchEnabled = game.UserInputService.TouchEnabled;
		createNotification(isTouchEnabled, arg5);
	end
};