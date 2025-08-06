-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local runService = game:GetService("RunService");
local playersService = game:GetService("Players");
local getFarmModule = require(replicatedStorageService.Modules.GetFarm);
local fastTweenModule = require(replicatedStorageService.Modules.FastTween);
local localPlayer = playersService.LocalPlayer;
local tutorialUI = localPlayer.PlayerGui:WaitForChild("Tutorial_UI");
local pointerImage = tutorialUI.Pointer;
local function getTools() --[[ Line: 14 ]] --[[ Name: getTools ]]
	-- upvalues: l_LocalPlayer_0 (copy)
	local toolsList = {};
	for _, toolInstance in localPlayer.Backpack:GetChildren() do
		if toolInstance:IsA("Tool") then
			table.insert(toolsList, toolInstance);
		end;
	end;
	local character = localPlayer.Character;
	local equippedTool = if character then character:FindFirstChildWhichIsA("Tool") else nil;
	if equippedTool then
		table.insert(toolsList, equippedTool);
	end;
	return toolsList;
end;
local function waitForSeed() --[[ Line: 30 ]] --[[ Name: waitForSeed ]]
	-- upvalues: v13 (copy)
	while true do
		for _, toolInstance in getTools() do
			if not string.find(toolInstance.Name, "Seed") then
				continue;
			end;
			return true;
		end;
		task.wait(0.1);
	end;
end;
local function waitUntilSellableItem() --[[ Line: 42 ]] --[[ Name: waitUntilSellableItem ]]
	-- upvalues: v13 (copy)
	while true do
		for _, toolInstance in getTools() do
			if not toolInstance:FindFirstChild("Item_String") then
				continue;
			end;
			return true;
		end;
		task.wait(0.1);
	end;
end;
local function waitUntilNoSellableItems() --[[ Line: 54 ]] --[[ Name: waitUntilNoSellableItems ]]
	-- upvalues: v13 (copy)
	while true do
		local hasSellableItems = false;
		for _, itemInstance in getTools() do
			if itemInstance:FindFirstChild("Item_String") then
				hasSellableItems = true;
			end;
		end;
		if hasSellableItems then
			task.wait(0.1);
		else
			break;
		end;
	end;
	return true;
end;
local function waitForFarm() --[[ Line: 71 ]] --[[ Name: waitForFarm ]]
	-- upvalues: v3 (copy), l_LocalPlayer_0 (copy)
	local farmInstance = nil;
	while not farmInstance do
		farmInstance = getFarmModule(localPlayer);
		if not farmInstance then
			task.wait(0.1);
		else
			break;
		end;
	end;
	return farmInstance;
end;
local function waitUntilDistance(targetPosition, distanceThreshold) --[[ Line: 85 ]] --[[ Name: waitUntilDistance ]]
	-- upvalues: l_LocalPlayer_0 (copy)
	while not localPlayer.Character or localPlayer:DistanceFromCharacter(targetPosition) > distanceThreshold do
		task.wait(0.1);
	end;
end;
local function waitUntilSeedEquipped() --[[ Line: 95 ]] --[[ Name: waitUntilSeedEquipped ]]
	-- upvalues: l_LocalPlayer_0 (copy)
	while true do
		local characterWithSeed = localPlayer.Character;
		local equippedTool = characterWithSeed and characterWithSeed:FindFirstChildWhichIsA("Tool");
		if not equippedTool or equippedTool:GetAttribute("ItemType") ~= "Seed" then
			task.wait(0.1);
		else
			break;
		end;
	end;
end;
local isPointerActive = false;
local function pointToUI(getUIPosition, parentUI, pointerScale) --[[ Line: 108 ]] --[[ Name: pointToUI ]]
	-- upvalues: v32 (ref), l_Pointer_0 (copy), l_Tutorial_UI_0 (copy), v4 (copy), l_RunService_0 (copy)
	while isPointerActive do
		task.wait();
	end;
	isPointerActive = true;
	local function updatePointerPosition() --[[ Line: 115 ]] --[[ Name: updatePosition ]]
		-- upvalues: v33 (copy), l_Pointer_0 (ref)
		local uiPosition = getUIPosition();
		pointerImage.Position = UDim2.fromOffset(uiPosition.X, uiPosition.Y);
	end;
	task.spawn(updatePointerPosition);
	pointerImage.Parent = parentUI or tutorialUI;
	pointerImage.UIScale.Scale = pointerScale or 1;
	pointerImage.Visible = true;
	fastTweenModule(pointerImage, TweenInfo.new(0.3), {
		ImageTransparency = 0
	});
	local scaleTween = fastTweenModule(pointerImage.UIScale, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
		Scale = (pointerScale or 1) * 1.1
	});
	local preRenderConnection = runService.PreRender:Connect(updatePointerPosition);
	return function() --[[ Line: 130 ]]
		-- upvalues: v39 (copy), v4 (ref), l_Pointer_0 (ref), v38 (copy), l_Tutorial_UI_0 (ref), v32 (ref)
		if not preRenderConnection.Connected then
			return;
		else
			preRenderConnection:Disconnect();
			fastTweenModule(pointerImage, TweenInfo.new(0.3), {
				ImageTransparency = 1
			}).Completed:Wait();
			scaleTween:Cancel();
			pointerImage.Visible = false;
			pointerImage.Parent = tutorialUI;
			isPointerActive = false;
			return;
		end;
	end;
end;
return {
	getTools = getTools, 
	waitForSeed = waitForSeed, 
	waitUntilSellableItem = waitUntilSellableItem, 
	waitUntilNoSellableItems = waitUntilNoSellableItems, 
	waitForFarm = waitForFarm, 
	waitUntilDistance = waitUntilDistance, 
	waitUntilSeedEquipped = waitUntilSeedEquipped, 
	pointToUI = pointToUI
};