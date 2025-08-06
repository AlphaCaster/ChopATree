-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local localPlayer = game:GetService("Players").LocalPlayer;
local notificationModule = require(replicatedStorageService.Modules.Notification);
local _ = require(replicatedStorageService.Modules.GetFarm);
local tutorialUtilsModule = require(replicatedStorageService.Modules.TutorialController.TutorialUtils);
local arrowModule = require(replicatedStorageService.Arrow_Module);
return function() --[[ Line: 14 ]]
	-- upvalues: v5 (copy), l_LocalPlayer_0 (copy), v4 (copy), v2 (copy), l_ReplicatedStorage_0 (copy)
	local tutorialClickPartClone = nil;
	local arrowList = {};
	local function _(targetPart) --[[ Line: 18 ]] --[[ Name: createArrow ]]
		-- upvalues: v5 (ref), l_LocalPlayer_0 (ref), v7 (copy)
		local tutorialArrow1 = arrowModule.GenerateArrow(localPlayer, targetPart, math.random(1, 1000000));
		table.insert(arrowList, tutorialArrow1);
		return function() --[[ Line: 22 ]]
			-- upvalues: v7 (ref), v9 (copy), v5 (ref)
			local arrowIndex1 = table.find(arrowList, tutorialArrow1);
			if arrowIndex1 then
				arrowModule.Remove_Arrow(tutorialArrow1);
				table.remove(arrowList, arrowIndex1);
			end;
		end;
	end;
	local tutorialCoroutine = task.spawn(function() --[[ Line: 31 ]]
		-- upvalues: v5 (ref), l_LocalPlayer_0 (ref), v7 (copy), v4 (ref), v2 (ref), l_ReplicatedStorage_0 (ref), v6 (ref)
		local tutorialPoint1Position = workspace.Tutorial_Points.Tutorial_Point_1.Position;
		local tutorialArrow2Position = arrowModule.GenerateArrow(localPlayer, tutorialPoint1Position, math.random(1, 1000000));
		table.insert(arrowList, tutorialArrow2Position);
		local tutorialArrow2PositionCopy = tutorialArrow2Position --[[ copy: 2 -> 7 ]];
		local function removeArrow1() --[[ Line: 22 ]]
			-- upvalues: v7 (ref), l_v13_0 (copy), v5 (ref)
			local arrowIndex2 = table.find(arrowList, tutorialArrow2PositionCopy);
			if arrowIndex2 then
				arrowModule.Remove_Arrow(tutorialArrow2PositionCopy);
				table.remove(arrowList, arrowIndex2);
			end;
		end;
		tutorialPoint1Position = tutorialUtilsModule.waitForFarm();
		tutorialUtilsModule.waitForSeed();
		removeArrow1();
		tutorialArrow2Position = (tutorialPoint1Position.Spawn_Point.CFrame * CFrame.new(0, 0, -10)).Position;
		local tutorialClickPart = arrowModule.GenerateArrow(localPlayer, tutorialArrow2Position, math.random(1, 1000000));
		table.insert(arrowList, tutorialClickPart);
		local tutorialClickPartCopy = tutorialClickPart --[[ copy: 4 -> 8 ]];
		local function removeArrow2() --[[ Line: 22 ]]
			-- upvalues: v7 (ref), l_v17_0 (copy), v5 (ref)
			local arrowIndex3 = table.find(arrowList, tutorialClickPartCopy);
			if arrowIndex3 then
				arrowModule.Remove_Arrow(tutorialClickPartCopy);
				table.remove(arrowList, arrowIndex3);
			end;
		end;
		tutorialUtilsModule.waitUntilDistance(tutorialArrow2Position, 30);
		tutorialUtilsModule.waitUntilSeedEquipped();
		removeArrow2();
		notificationModule:CreateNotification("Click on your plot to plant!");
		tutorialClickPart = replicatedStorageService.Tutorial_Parts.Tutorial_Click:Clone();
		tutorialClickPart.Size = Vector3.new(0.0010000000474974513, 0.0010000000474974513, 0.0010000000474974513, 0);
		tutorialClickPart.Position = (tutorialPoint1Position.Spawn_Point.CFrame * CFrame.new(15, -5, -15)).Position;
		tutorialClickPart.Parent = workspace.Click_Points;
		tutorialClickPartClone = tutorialClickPart;
		while #tutorialPoint1Position.Important.Plants_Physical:GetChildren() <= 0 do
			task.wait(0.1);
		end;
		tutorialClickPartClone = nil;
		tutorialClickPart:Destroy();
		tutorialUtilsModule.waitUntilSellableItem();
		local tutorialPoint2Position = workspace.Tutorial_Points.Tutorial_Point_2.Position;
		local tutorialArrow3 = arrowModule.GenerateArrow(localPlayer, tutorialPoint2Position, math.random(1, 1000000));
		table.insert(arrowList, tutorialArrow3);
	end);
	return function() --[[ Line: 68 ]]
		-- upvalues: v23 (copy), v6 (ref), v7 (copy), v5 (ref)
		if coroutine.status(tutorialCoroutine) == "suspended" then
			task.cancel(tutorialCoroutine);
		end;
		if tutorialClickPartClone then
			tutorialClickPartClone:Destroy();
			tutorialClickPartClone = nil;
		end;
		for _, arrow in arrowList do
			arrowModule.Remove_Arrow(arrow);
		end;
		table.clear(arrowList);
	end;
end;