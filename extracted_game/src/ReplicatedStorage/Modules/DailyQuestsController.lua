-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local playersService = game:GetService("Players");
local _ = require(replicatedStorageService.Modules.Trove);
local remotesModule = require(replicatedStorageService.Blink.Blink.Client);
local numberUtilModule = require(replicatedStorageService.Modules.NumberUtil);
local dataServiceModule = require(replicatedStorageService.Modules.DataService);
local guiControllerModule = require(replicatedStorageService.Modules.GuiController);
local questsControllerModule = require(replicatedStorageService.Modules.QuestsController);
local localPlayer = playersService.LocalPlayer;
local dailyQuestsUI = localPlayer.PlayerGui:WaitForChild("DailyQuests_UI");
local questsScrollingFrame = dailyQuestsUI:WaitForChild("Frame"):WaitForChild("ScrollingFrame");
local claimHolderFrame = questsScrollingFrame:WaitForChild("ClaimHolder");
local claimButton = claimHolderFrame:WaitForChild("Frame"):WaitForChild("Claim");
local claimButton2 = claimHolderFrame:WaitForChild("Frame"):WaitForChild("Claim2");
local completeButton = claimHolderFrame:WaitForChild("Frame"):WaitForChild("Complete");
local claimedFrame = claimHolderFrame:WaitForChild("Frame"):WaitForChild("Claimed");
local questHolderTemplate = questsScrollingFrame:WaitForChild("Holder");
questHolderTemplate.Parent = script;
local dailyQuestsModule = {};
local function _(timeValue) --[[ Line: 40 ]] --[[ Name: getCurrentDay ]]
	return (timeValue + 14400) // 86400;
end;
local function _(timeValue) --[[ Line: 44 ]] --[[ Name: getResetTime ]]
	return ((timeValue + 14400) // 86400 + 1) * 86400 - 14400;
end;
local questsCompleted = false;
dailyQuestsModule.Start = function(_) --[[ Line: 50 ]] --[[ Name: Start ]]
	-- upvalues: v6 (copy), l_DailyQuests_UI_0 (copy), v5 (copy), v7 (copy), l_Holder_0 (copy), l_ScrollingFrame_0 (copy), l_Claimed_0 (copy), l_Claim_0 (copy), l_Claim2_0 (copy), l_Complete_0 (copy), l_ClaimHolder_0 (copy), v22 (ref), l_LocalPlayer_0 (copy), v3 (copy), v4 (copy)
	guiControllerModule:UsePopupAnims(dailyQuestsUI);
	dailyQuestsUI.Frame.Frame.ExitButton.Activated:Connect(function() --[[ Line: 53 ]]
		-- upvalues: v6 (ref), l_DailyQuests_UI_0 (ref)
		guiControllerModule:Close(dailyQuestsUI);
	end);
	local questFramesMap = {};
	local function _(questIndex) --[[ Line: 59 ]] --[[ Name: removeQuestFromRender ]]
		-- upvalues: v24 (copy)
		local questInstance = questFramesMap[questIndex];
		if questInstance then
			questInstance:Destroy();
			questFramesMap[questIndex] = nil;
		end;
	end;
	local function updateQuests() --[[ Line: 68 ]] --[[ Name: updateQuests ]]
		-- upvalues: v5 (ref), v24 (copy), v7 (ref), l_Holder_0 (ref), l_ScrollingFrame_0 (ref), l_Claimed_0 (ref), l_Claim_0 (ref), l_Claim2_0 (ref), l_Complete_0 (ref), l_ClaimHolder_0 (ref), v22 (ref), l_LocalPlayer_0 (ref)
		local dailyQuestsData = dataServiceModule:GetData();
		if not dailyQuestsData then
			return;
		elseif not dailyQuestsData.DailyQuests or not dailyQuestsData.DailyQuests.ContainerId then
			for questIndex in questFramesMap do
				local questInstance = questFramesMap[questIndex];
				if questInstance then
					questInstance:Destroy();
					questFramesMap[questIndex] = nil;
				end;
			end;
			table.clear(questFramesMap);
			return;
		else
			local _ = {};
			local questContainer = questsControllerModule:GetContainerFromId(dailyQuestsData.DailyQuests.ContainerId);
			if not questContainer then
				return;
			else
				local allQuestsCompleted = true;
				for questIndex, questData in questContainer.Quests do
					if not questData.Completed then
						allQuestsCompleted = false;
					end;
					local questInfo = questsControllerModule:GetQuest(questData.Type);
					if questInfo then
						local questFrame = questFramesMap[questData.Id];
						if not questFrame then
							local newQuestFrame = questHolderTemplate:Clone();
							newQuestFrame.LayoutOrder = questIndex + 1;
							newQuestFrame.Parent = questsScrollingFrame;
							questFrame = newQuestFrame;
							questFramesMap[questData.Id] = questFrame;
						end;
						local questDisplayData = questInfo:Display(questData.Progress, questData.Target, questData.Arguments);
						questFrame.QuestFrame.Title.Text = questDisplayData.Title;
						questFrame.QuestFrame.Frame.Fill.Size = UDim2.fromScale(math.clamp(questData.Progress / questData.Target, 0, 1), 1);
						questFrame.QuestFrame.Frame.Progress.Text = questData.Progress >= questData.Target and "Completed!" or questDisplayData.Bar;
					end;
				end;
				for questId in questFramesMap do
					local questExists = false;
					for _, containerQuest in questContainer.Quests do
						if containerQuest.Id == questId then
							questExists = true;
							break;
						end;
					end;
					if not questExists then
						local oldQuestFrame = questFramesMap[questId];
						if oldQuestFrame then
							oldQuestFrame:Destroy();
							questFramesMap[questId] = nil;
						end;
					end;
				end;
				claimedFrame.Visible = questContainer.Redeemed;
				claimButton.Visible = allQuestsCompleted and not questContainer.Redeemed;
				claimButton2.Visible = not allQuestsCompleted and not questContainer.Redeemed;
				completeButton.Visible = not allQuestsCompleted and not questContainer.Redeemed;
				local rewardData = questContainer.Rewards[1];
				local rewardInfo = if rewardData then questsControllerModule:GetRewardInfo(rewardData.Type) else nil;
				if rewardInfo then
					claimHolderFrame:WaitForChild("Frame"):WaitForChild("Title").Text = rewardInfo:Display(rewardData);
				end;
				if allQuestsCompleted and not questContainer.Redeemed and not questsCompleted and not localPlayer:GetAttribute("FirstTimePlayer") then
					questsCompleted = true;
					require(game.ReplicatedStorage.Modules.Notification):CreateNotification("All your quests are completed you can now claim your prize!");
					return;
				else
					if not allQuestsCompleted then
						questsCompleted = false;
					end;
					return;
				end;
			end;
		end;
	end;
	claimButton.Activated:Connect(function() --[[ Line: 162 ]]
		-- upvalues: v3 (ref)
		remotesModule.ClaimDailyQuest.Fire()
	end);
	task.spawn(updateQuests);
	assert(dataServiceModule:GetPathSignal("DailyQuests/@"), "Failed to listen for Daily Quests"):Connect(updateQuests);
	assert(dataServiceModule:GetPathSignal("QuestContainers/@"), "Failed to listen for Quest Containers"):Connect(updateQuests);
	task.spawn(function() --[[ Line: 170 ]]
		-- upvalues: l_DailyQuests_UI_0 (ref), v4 (ref)
		while true do
			local serverTimeNow = workspace:GetServerTimeNow();
			local nextResetTimestamp = ((serverTimeNow + 14400) // 86400 + 1) * 86400 - 14400;
			dailyQuestsUI.Frame.Resets.Text = ("Resets in %*"):format((numberUtilModule.toHMS(nextResetTimestamp - serverTimeNow)));
			task.wait(1);
		end;
	end);
end;
task.spawn(dailyQuestsModule.Start, dailyQuestsModule);
return dailyQuestsModule;