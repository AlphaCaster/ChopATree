-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local localPlayer = game:GetService("Players").LocalPlayer;
local notificationModule = require(replicatedStorageService.Modules.Notification);
local _ = require(replicatedStorageService.Modules.GetFarm);
local tutorialUtilsModule = require(replicatedStorageService.Modules.TutorialController.TutorialUtils);
local arrowModule = require(replicatedStorageService.Arrow_Module);
return function() --[[ Line: 14 ]]
	-- upvalues: v5 (copy), l_LocalPlayer_0 (copy), v2 (copy), v4 (copy)
	local arrowList = {};
	local function _(targetPosition) --[[ Line: 16 ]] --[[ Name: createArrow ]]
		-- upvalues: v5 (ref), l_LocalPlayer_0 (ref), v6 (copy)
		local arrowInstance1 = arrowModule.GenerateArrow(localPlayer, targetPosition, math.random(1, 1000000));
		table.insert(arrowList, arrowInstance1);
		return function() --[[ Line: 20 ]]
			-- upvalues: v6 (ref), v8 (copy), v5 (ref)
			local arrowIndex1 = table.find(arrowList, arrowInstance1);
			if arrowIndex1 then
				arrowModule.Remove_Arrow(arrowInstance1);
				table.remove(arrowList, arrowIndex1);
			end;
		end;
	end;
	local tutorialCoroutine = task.spawn(function() --[[ Line: 29 ]]
		-- upvalues: v5 (ref), l_LocalPlayer_0 (ref), v6 (copy), v2 (ref), v4 (ref)
		local tutorialPoint1Position = workspace.Tutorial_Points.Tutorial_Point_1.Position;
		local farmInstance = arrowModule.GenerateArrow(localPlayer, tutorialPoint1Position, math.random(1, 1000000));
		table.insert(arrowList, farmInstance);
		local arrowInstance2 = farmInstance --[[ copy: 2 -> 7 ]];
		local function removeArrow1() --[[ Line: 20 ]]
			-- upvalues: v6 (ref), l_v12_0 (copy), v5 (ref)
			local arrowIndex2 = table.find(arrowList, arrowInstance2);
			if arrowIndex2 then
				arrowModule.Remove_Arrow(arrowInstance2);
				table.remove(arrowList, arrowIndex2);
			end;
		end;
		tutorialPoint1Position = task.delay(5, function() --[[ Line: 31 ]]
			-- upvalues: v2 (ref)
			notificationModule:CreateNotification("Go buy your first seed!");
		end);
		tutorialUtilsModule.waitForSeed();
		if coroutine.status(tutorialPoint1Position) == "suspended" then
			task.cancel(tutorialPoint1Position);
		end;
		removeArrow1();
		farmInstance = tutorialUtilsModule.waitForFarm();
		notificationModule:CreateNotification("Go plant your seed!");
		local removeArrowFunction = (farmInstance.Spawn_Point.CFrame * CFrame.new(0, 0, -10)).Position;
		local tutorialPoint2Position = arrowModule.GenerateArrow(localPlayer, removeArrowFunction, math.random(1, 1000000));
		table.insert(arrowList, tutorialPoint2Position);
		local arrowInstance3 = tutorialPoint2Position --[[ copy: 5 -> 8 ]];
		local function removeArrow2() --[[ Line: 20 ]]
			-- upvalues: v6 (ref), l_v17_0 (copy), v5 (ref)
			local arrowIndex3 = table.find(arrowList, arrowInstance3);
			if arrowIndex3 then
				arrowModule.Remove_Arrow(arrowInstance3);
				table.remove(arrowList, arrowIndex3);
			end;
		end;
		tutorialUtilsModule.waitUntilSellableItem();
		removeArrow2();
		notificationModule:CreateNotification("Go sell your plant!");
		tutorialPoint2Position = workspace.Tutorial_Points.Tutorial_Point_2.Position;
		local arrowInstance4 = arrowModule.GenerateArrow(localPlayer, tutorialPoint2Position, math.random(1, 1000000));
		table.insert(arrowList, arrowInstance4);
		removeArrowFunction = function() --[[ Line: 20 ]]
			-- upvalues: v6 (ref), v21 (copy), v5 (ref)
			local arrowIndex4 = table.find(arrowList, arrowInstance4);
			if arrowIndex4 then
				arrowModule.Remove_Arrow(arrowInstance4);
				table.remove(arrowList, arrowIndex4);
			end;
		end;
		tutorialUtilsModule.waitUntilNoSellableItems();
		removeArrowFunction();
	end);
	return function() --[[ Line: 58 ]]
		-- upvalues: v23 (copy), v6 (copy), v5 (ref)
		if coroutine.status(tutorialCoroutine) == "suspended" then
			task.cancel(tutorialCoroutine);
		end;
		for _, arrowInstance in arrowList do
			arrowModule.Remove_Arrow(arrowInstance);
		end;
		table.clear(arrowList);
	end;
end;