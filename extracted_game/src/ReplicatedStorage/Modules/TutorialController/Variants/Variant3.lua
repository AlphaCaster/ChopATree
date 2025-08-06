-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local localPlayer = game:GetService("Players").LocalPlayer;
local playerGui = localPlayer.PlayerGui;
local seedShopGui = playerGui:WaitForChild("Seed_Shop");
local notificationModule = require(replicatedStorageService.Modules.Notification);
local _ = require(replicatedStorageService.Modules.GetFarm);
local troveModule = require(replicatedStorageService.Modules.Trove);
local tutorialUtilsModule = require(replicatedStorageService.Modules.TutorialController.TutorialUtils);
local arrowModule = require(replicatedStorageService.Arrow_Module);
return function() --[[ Line: 18 ]]
	-- upvalues: v6 (copy), v8 (copy), l_LocalPlayer_0 (copy), v7 (copy), v4 (copy), l_Seed_Shop_0 (copy), l_PlayerGui_0 (copy), l_ReplicatedStorage_0 (copy)
	local troveInstance = troveModule.new();
	local function createArrow(arrowTarget) --[[ Line: 21 ]] --[[ Name: createArrow ]]
		-- upvalues: v9 (copy), v8 (ref), l_LocalPlayer_0 (ref)
		local cleanupTrove = troveInstance:Extend();
		local arrowInstance = arrowModule.GenerateArrow(localPlayer, arrowTarget, math.random(1, 1000000));
		cleanupTrove:Add(function() --[[ Line: 25 ]]
			-- upvalues: v8 (ref), v12 (copy)
			arrowModule.Remove_Arrow(arrowInstance);
		end);
		return cleanupTrove:WrapClean();
	end;
	workspace:SetAttribute("InTutorial", true);
	troveInstance:Add(function() --[[ Line: 33 ]]
		workspace:SetAttribute("InTutorial", nil);
	end);
	troveInstance:Add(task.spawn(function() --[[ Line: 37 ]]
		-- upvalues: v7 (ref), v13 (copy), v4 (ref), l_Seed_Shop_0 (ref), l_PlayerGui_0 (ref), l_ReplicatedStorage_0 (ref), v9 (copy)
		local farmInstance = tutorialUtilsModule.waitForFarm();
		local getTutorialPoint1PositionFunction = createArrow(workspace.Tutorial_Points.Tutorial_Point_1.Position);
		tutorialUtilsModule.waitUntilDistance(workspace.Tutorial_Points.Tutorial_Point_1.Position, 5);
		getTutorialPoint1PositionFunction();
		notificationModule:CreateNotification("Talk to Sam!");
		while not seedShopGui.Enabled do
			task.wait(0.1);
		end;
		local carrotFrame = seedShopGui.Frame.ScrollingFrame:WaitForChild("Carrot");
		local pointToCarrotMainFrame = tutorialUtilsModule.pointToUI(function() --[[ Line: 53 ]]
			-- upvalues: l_Carrot_0 (copy)
			local carrotMainFrame = carrotFrame.Main_Frame;
			return carrotMainFrame.AbsolutePosition + carrotMainFrame.AbsoluteSize * 0.5;
		end);
		local seedShopEnabledConnection = seedShopGui:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 58 ]]
			-- upvalues: l_Seed_Shop_0 (ref), v18 (ref), v7 (ref), l_Carrot_0 (copy)
			if not seedShopGui.Enabled then
				pointToCarrotMainFrame();
				return;
			else
				pointToCarrotMainFrame = tutorialUtilsModule.pointToUI(function() --[[ Line: 62 ]]
					-- upvalues: l_Carrot_0 (ref)
					local carrotMainFrame = carrotFrame.Main_Frame;
					return carrotMainFrame.AbsolutePosition + carrotMainFrame.AbsoluteSize * 0.5;
				end);
				return;
			end;
		end);
		while carrotFrame.Frame.Position.Y.Scale < 1 do
			task.wait(0.1);
		end;
		seedShopEnabledConnection:Disconnect();
		pointToCarrotMainFrame();
		local pointToCarrotShecklesBuy = tutorialUtilsModule.pointToUI(function() --[[ Line: 76 ]]
			-- upvalues: l_Carrot_0 (copy)
			local carrotShecklesBuyFrame = carrotFrame.Frame.Sheckles_Buy;
			return carrotShecklesBuyFrame.AbsolutePosition + carrotShecklesBuyFrame.AbsoluteSize * 0.5;
		end);
		local seedShopEnabledConnection2 = seedShopGui:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 81 ]]
			-- upvalues: l_Seed_Shop_0 (ref), v22 (ref), v7 (ref), l_Carrot_0 (copy)
			if not seedShopGui.Enabled then
				pointToCarrotShecklesBuy();
				return;
			else
				pointToCarrotShecklesBuy = tutorialUtilsModule.pointToUI(function() --[[ Line: 85 ]]
					-- upvalues: l_Carrot_0 (ref)
					local carrotShecklesBuyFrame = carrotFrame.Frame.Sheckles_Buy;
					return carrotShecklesBuyFrame.AbsolutePosition + carrotShecklesBuyFrame.AbsoluteSize * 0.5;
				end);
				return;
			end;
		end);
		tutorialUtilsModule.waitForSeed();
		seedShopEnabledConnection2:Disconnect();
		pointToCarrotShecklesBuy();
		local getExitButtonPositionFunction = tutorialUtilsModule.pointToUI(function() --[[ Line: 97 ]]
			-- upvalues: l_Seed_Shop_0 (ref)
			local seedShopExitButton = seedShopGui.Frame.Frame.ExitButton;
			return seedShopExitButton.AbsolutePosition + seedShopExitButton.AbsoluteSize * 0.5;
		end);
		while seedShopGui.Enabled do
			task.wait();
		end;
		getExitButtonPositionFunction();
		local farmSpawnPosition = (farmInstance.Spawn_Point.CFrame * CFrame.new(0, 0, -10)).Position;
		local getPositionFunction = createArrow(farmSpawnPosition);
		tutorialUtilsModule.waitUntilDistance(farmSpawnPosition, 10);
		local getHotbarSlot2PositionFunction = tutorialUtilsModule.pointToUI(function() --[[ Line: 112 ]]
			-- upvalues: l_PlayerGui_0 (ref)
			local hotbarSlot2 = playerGui:WaitForChild("BackpackGui"):WaitForChild("Backpack"):WaitForChild("Hotbar"):WaitForChild("2");
			return hotbarSlot2.AbsolutePosition + Vector2.new(hotbarSlot2.AbsoluteSize.X * 0.5, 0);
		end);
		tutorialUtilsModule.waitUntilSeedEquipped();
		getHotbarSlot2PositionFunction();
		getPositionFunction();
		notificationModule:CreateNotification("Click on your plot to plant!");
		local tutorialClickPart = replicatedStorageService.Tutorial_Parts.Tutorial_Click:Clone();
		tutorialClickPart.Size = Vector3.new(0.0010000000474974513, 0.0010000000474974513, 0.0010000000474974513, 0);
		tutorialClickPart.Position = (farmInstance.Spawn_Point.CFrame * CFrame.new(15, -5, -15)).Position;
		tutorialClickPart.Parent = workspace.Click_Points;
		while #farmInstance.Important.Plants_Physical:GetChildren() <= 0 do
			task.wait();
		end;
		tutorialClickPart:Destroy();
		notificationModule:CreateNotification("Wait for your plant to grow then Collect it");
		tutorialUtilsModule.waitUntilSellableItem();
		local getTutorialPoint2PositionFunction = createArrow(workspace.Tutorial_Points.Tutorial_Point_2.Position);
		tutorialUtilsModule.waitUntilDistance(workspace.Tutorial_Points.Tutorial_Point_2.Position, 5);
		getTutorialPoint2PositionFunction();
		notificationModule:CreateNotification("Talk to Steven!");
		local billboardGuiObject = nil;
		local billboardGuiObject;
		while true do
			local billboardUI = playerGui:FindFirstChild("Billboard_UI");
			billboardGuiObject = billboardUI and billboardUI:FindFirstChildWhichIsA("GuiObject");
			if not billboardGuiObject or billboardGuiObject.Frame.Frame.Text_Element:GetAttribute("Text") ~= "I want to sell my inventory" then
				task.wait(0.1);
			else
				break;
			end;
		end;
		billboardGuiObject = billboardGuiObject;
		if billboardGuiObject then
			local pointToBillboard = tutorialUtilsModule.pointToUI(function() --[[ Line: 156 ]]
				-- upvalues: v33 (ref), l_PlayerGui_0 (ref)
				local billboardGuiObjectLocal = billboardGuiObject;
				local screenPosition = Vector2.zero;
				local billboardUI = playerGui:FindFirstChild("Billboard_UI");
				if billboardUI then
					local billboardAdornee = billboardUI.Adornee or billboardUI.Parent;
					if billboardAdornee:IsA("PVInstance") then
						local screenPointX, isOnScreen = workspace.Camera:WorldToScreenPoint(billboardAdornee:GetPivot().Position);
						screenPosition = if isOnScreen then Vector2.new(screenPointX.X, screenPointX.Y) else screenPosition + Vector2.new(0, 999999999999);
					end;
				end;
				return screenPosition + Vector2.new(billboardGuiObjectLocal.AbsoluteSize.X * 0.5, 0);
			end);
			while true do
				billboardGuiObject = playerGui:FindFirstChild("Billboard_UI");
				if billboardGuiObject and billboardGuiObject:FindFirstChildWhichIsA("GuiObject") then
					task.wait(0.1);
				else
					break;
				end;
			end;
			pointToBillboard();
		end;
		workspace:SetAttribute("InTutorial", nil);
		troveInstance:Clean();
	end));
	return troveInstance:WrapClean();
end;