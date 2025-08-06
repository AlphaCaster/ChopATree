local QuestsService = {}
QuestsService.__index = QuestsService

local HttpService = game:GetService("HttpService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage.Modules
local Data = ReplicatedStorage.Data
local GameEvents = ReplicatedStorage.GameEvents

local QuestData = require(Data.QuestData)
local PlayerData = require(ServerStorage.PlayerData)

local function CheckTableEquality(t1,t2)
	if t1 and t2 then
		for i,v in next, t1 do if t2[i]~=v then return false end end
		for i,v in next, t2 do if t1[i]~=v then return false end end
		return true
	end
end

function QuestsService:CreateQuestContainer(Player: Player, Save: boolean, Type: string, Tag: string)
	local questContainer = QuestData.Containers[Type]
	if not questContainer then
		return warn("No quest type:", type)
	end
	
	local id = HttpService:GenerateGUID(true)
	
	local quests = questContainer:Generate()
	for i, v in quests.Quests do
		v.Completed = false
		v.Id = HttpService:GenerateGUID(true)
		v.Progress = 0
	end
	
	local Generation = {
		Container = Type,
		Redeemed = false,
		Quests = quests.Quests,
		Rewards = quests.Rewards,
		Tag = Tag or ""
	}
	
	if Save then
		local profile = PlayerData[Player]
		if profile then
			profile.Data.QuestContainers[id] = Generation
		end
		
		GameEvents.DataStream:FireAllClients("UpdateData", (("%*_DataServiceProfile"):format(Player.Name)), {
			{"ROOT/QuestContainers/"..id, profile.Data.QuestContainers[id]},
		})
	end
	
	return id, Generation
end

function QuestsService:CheckProgression(Player: Player, ContainerId: string, Type: string, Arguments: {any}, Progress: boolean, ProgressBy: number)
	local profile = PlayerData[Player]
	if profile then
		for saveId, data in profile.Data.QuestContainers do
			if saveId == ContainerId then
				local Quests = data.Quests
				for _, Quest in Quests do
					if Quest.Type == Type and not Quest.Completed then
						local Equals = CheckTableEquality(Quest.Arguments, Arguments)
						if Type == "EarnSheckles" or Equals then
							if Progress then
								self:ProgressQuestInContainer(Player, ContainerId, Quest.Id, ProgressBy)
							end
							
							return true
						end
					end
				end

				break
			end
		end
	end
end

function QuestsService:ProgressQuestInContainer(Player: Player, ContainerId: string, QuestId: string, ProgressBy: number)
	local profile = PlayerData[Player]
	if profile then
		for saveId, data in profile.Data.QuestContainers do
			if saveId == ContainerId then
				local Quests = data.Quests
				for _, Quest in Quests do
					if Quest.Id == QuestId then
						local New = Quest.Progress + ProgressBy
						Quest.Progress = math.clamp(New, 0, Quest.Target)
						
						if Quest.Progress >= Quest.Target then
							Quest.Completed = true
						end
						
						break
					end
				end

				break
			end
		end
		
		GameEvents.DataStream:FireAllClients("UpdateData", (("%*_DataServiceProfile"):format(Player.Name)), {
			{"ROOT/QuestContainers/"..ContainerId, profile.Data.QuestContainers[ContainerId]},
		})
	end
end

function QuestsService:RedeemQuest(Player: Player, Id: string)
	local profile = PlayerData[Player]
	if profile then
		for saveId, data in profile.Data.QuestContainers do
			if saveId == Id then
				if data.Redeemed then
					return "Already redeemed"
				end
				
				local completeCount = 0
				
				for _, Quest in data.Quests do
					if Quest.Completed then
						completeCount += 1
					end
				end
				
				if completeCount == 3 then
					local rewards = data.Rewards
					for _, reward in rewards do
						local type = reward.Type
						local module = QuestData.Rewards[type]
						if module then
							module:Give(Player, reward)
						end
					end

					data.Redeemed = true
					return "Redeemed"
				else
					return "Not completed"
				end
			end
		end
	end
end

function QuestsService:RemoveQuest(Player: Player, Id: string)
	local profile = PlayerData[Player]
	if profile then
		profile.Data.QuestContainers[Id] = nil
	end
end

return QuestsService
