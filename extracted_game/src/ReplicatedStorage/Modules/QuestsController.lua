-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local playersService = game:GetService("Players");
local _ = require(replicatedStorageService.Modules.Trove);
local _ = require(replicatedStorageService.Modules.Remotes);
local dataServiceModule = require(replicatedStorageService.Modules.DataService);
local _ = require(replicatedStorageService.Data.QuestData);
local questsDataModule = require(replicatedStorageService.Data.QuestData.Quests);
local questRewardsDataModule = require(replicatedStorageService.Data.QuestData.QuestRewards);
--local _ = require(l_ReplicatedStorage_0.Data.QuestData.Types);
local _ = playersService.LocalPlayer;
return {
	GetQuest = function(_, questId) --[[ Line: 31 ]] --[[ Name: GetQuest ]]
		-- upvalues: v6 (copy)
		return questsDataModule[questId];
	end, 
	GetRewardInfo = function(_, rewardId) --[[ Line: 35 ]] --[[ Name: GetRewardInfo ]]
		-- upvalues: v7 (copy)
		return questRewardsDataModule[rewardId];
	end, 
	GetContainerFromId = function(_, questContainerId) --[[ Line: 39 ]] --[[ Name: GetContainerFromId ]]
		-- upvalues: v4 (copy)
		local playerQuestData = dataServiceModule:GetData();
		if not playerQuestData then
			return nil;
		else
			return playerQuestData.QuestContainers[questContainerId];
		end;
	end, 
	GetQuestFromId = function(_, _) --[[ Line: 48 ]] --[[ Name: GetQuestFromId ]]
		-- upvalues: v4 (copy)
		local playerQuestData = dataServiceModule:GetData();
		if not playerQuestData then
			return nil;
		else
			for questId, questContainer in playerQuestData.QuestContainers do
				for _, quest in questContainer.Quests do
					if quest.Id == questId then
						return quest;
					end;
				end;
			end;
			return nil;
		end;
	end
};