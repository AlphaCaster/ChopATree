local RS = game:GetService("ReplicatedStorage")
local P = game:GetService("Players")
local HS = game:GetService("HttpService")
local DSS = game:GetService("DataStoreService")
local DS = DSS:GetDataStore("PlaytimeRewards")
local SSS = game:GetService("ServerScriptService")
local SS = game:GetService("ServerStorage")

local PlayerData = require(SS:WaitForChild("PlayerData"))
local CurrencyService = require(SSS.Modules:WaitForChild("CurrencyService"))
local SeedService = require(SSS:WaitForChild("Modules"):WaitForChild("SeedService"))

local GameEvents = RS.GameEvents

local DataTemplate = {
	LastLogin = os.time();
	Claimed = {};
}

local Rewards = {
	["Gift1"] = {
		Item = "Money";
		Amount = 250;
		Time = 60;
	};
	["Gift2"] = {
		Item = "Money";
		Amount = 1000;
		Time = 60 * 2;
	};
	["Gift3"] = {
		Item = "Carrot";
		Amount = 5;
		Time = 60 * 4;
	};
	["Gift4"] = {
		Item = "Bamboo";
		Amount = 5;
		Time = 60 * 7;
	};
	["Gift5"] = {
		Item = "Money";
		Amount = 5000;
		Time = 60 * 10;
	};
	["Gift6"] = {
		Item = "Wooden Statue";
		Amount = 10;
		Time = 60 * 12;
	};
	["Gift7"] = {
		Item = "Dragon Fruit";
		Amount = 5;
		Time = 60 * 14;
	};
	["Gift8"] = {
		Item = "Mango";
		Amount = 7;
		Time = 60 * 16;
	};
	["Gift9"] = {
		Item = "Candy Blossom";
		Amount = 10;
		Time = 60 * 18;
	};
}

local PlayersTime = {}

function GetInventory(player)
	local character = player.Character
	if not character then return end

	local items = {}

	for _, tool in player.Backpack:GetChildren() do
		if tool:IsA("Tool") then
			table.insert(items, tool)
		end
	end

	for _, tool in player.Character:GetChildren() do
		if tool:IsA("Tool") then
			table.insert(items, tool)
		end
	end

	return items
end

GameEvents.GetRewardsInfo.OnServerInvoke = function(Player)
	if PlayersTime[Player] ~= nil then
		local timeTable = {
			["Gift1"] = 0;
			["Gift2"] = 0;
			["Gift3"] = 0;
			["Gift4"] = 0;
			["Gift5"] = 0;
			["Gift6"] = 0;
			["Gift7"] = 0;
			["Gift8"] = 0;
			["Gift9"] = 0;
		}
		
		for i ,v in pairs(Rewards) do
			timeTable[i] = v.Time
		end

		return PlayersTime[Player], timeTable
	end
end

GameEvents.ClaimReward.OnServerInvoke = function(Player, Reward)
	local Data = HS:JSONDecode(Player:GetAttribute("Rewards"))
	
	if table.find(Data, Reward) then return false, "You already claimed this reward" end
	if Rewards[Reward] == nil then return false, "Error: This reward does not exist" end
	if PlayersTime[Player] == nil then return false, "Error: Player not found in PlayersTime table" end
	
	local tbl = Rewards[Reward]
	
	local TimeDifference = tbl.Time - PlayersTime[Player] 
	if TimeDifference <= 0 then
		
		if tbl.Item == "Money" then
			CurrencyService:Add(Player, tbl.Amount)
		else
			local seedUUID = nil

			for UUID, data in PlayerData[Player]["Data"]["InventoryData"] do
				if data.ItemData.ItemName == tbl.Item then
					data.ItemData.Quantity += tbl.Amount
					for _,v in GetInventory(Player) do
						if string.find(v.Name, tbl.Item) then
							v.Name = tbl.Item .. " Seed X"..data.ItemData.Quantity
							seedUUID = v:GetAttribute("ITEM_UUID")
							break
						end
					end
					break
				end
			end

			if not seedUUID then 
				seedUUID = SeedService:Create(Player, tbl.Item, tbl.Amount) 
			end
			
			GameEvents.DataStream:FireAllClients("UpdateData", (("%*_DataServiceProfile"):format(Player.Name)), {
				{"ROOT/Inventory/"..seedUUID, PlayerData[Player]["Data"]["InventoryData"][seedUUID]},
			})
		end
		
		table.insert(Data, Reward)
		
		Player:SetAttribute("Rewards", HS:JSONEncode(Data))
		
		return true, "Successfully claimed"
	else
		return false, "You can't claim this reward yet"
	end
end

--

P.PlayerAdded:Connect(function(Player)
	local success, err = pcall(function()
		local Data = DS:GetAsync(Player.UserId)
		
		if Data then
			local Last = Data.LastLogin
			local CurrentTime = os.time()
			local TimeDifference = CurrentTime - Last
			
			local ClaimedTable = Data.Claimed
			
			if TimeDifference >= 2*60*60 then
				ClaimedTable = {}
			end
			if ClaimedTable == nil then
				ClaimedTable = {}
			end
			
			Player:SetAttribute("Rewards", HS:JSONEncode(ClaimedTable))
		else
			Player:SetAttribute("Rewards", HS:JSONEncode({}))
		end
	end)
	
	if err then
		Player:Kick("Datastore error (Rejoin!): "..err)
	end
	
	if PlayersTime[Player] == nil then
		PlayersTime[Player] = 0
	end
end)

P.PlayerRemoving:Connect(function(Player)
	local Data = {
		LastLogin = os.time();
		Claimed = {};
	}
	Data.Claimed = HS:JSONDecode(Player:GetAttribute("Rewards"))
	
	if PlayersTime[Player] ~= nil then
		PlayersTime[Player] = nil
	end
	
	DS:SetAsync(Player.UserId, Data)
end)

while wait(1) do
	for i, v in pairs(PlayersTime) do
		PlayersTime[i] += 1
	end
end