--!native

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")

local PlayerData = require(ServerStorage:WaitForChild("PlayerData"))
local DataStream = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("DataStream")
local Players = game:GetService("Players")
local SeedData = require(ReplicatedStorage:WaitForChild("Data"):WaitForChild("SeedData"))

repeat wait() until next(PlayerData) ~= nil
local SEED_MULTIPLIER = 25;

function decide_stock_amount(data)
	if not data then return 0 end;
	
	local seedName = data.SeedName;
	local seedRarity = data.SeedRarity;
	local stockChance = data.StockChance;
	local stockMin, stockMax = data.StockAmount[1], data.StockAmount[2];
	
	local stockAmount = math.random(stockMin, stockMax) * SEED_MULTIPLIER;
	return if math.random(1, stockChance) == 1 then stockAmount else 2;
end;

function update_stock()
	local updateTable = {}
	local seedsToUpdate = {}

	if (not PlayerData) then return end;
	
	for name, data in pairs(SeedData) do
		if (not data.DisplayInShop) then continue end;
		
		local stockAmount = decide_stock_amount(data);
		table.insert(updateTable, {`ROOT/SeedStock/Stocks/{name}/Stock`, stockAmount});
		table.insert(seedsToUpdate, {name = name, stockAmount = stockAmount, data = data})
	end

	-- init stock
	for player, playerData in pairs(PlayerData) do
		DataStream:FireAllClients("UpdateData", ("%*_DataServiceProfile"):format(player.Name), updateTable)
		
		if (not playerData.Data.SeedStock) then continue end;
		--print(playerData.Data)
		--warn(updateTable)
		for idx, pack in seedsToUpdate do
			local seedStock = playerData.Data.SeedStock.Stocks[pack.name] or {};
			seedStock.Stock = pack.stockAmount;
			seedStock.MaxStock = pack.data.StockAmount[2];
			playerData.Data.SeedStock.Stocks[pack.name] = seedStock
		end;
	end
end

update_stock()

while task.wait() do
	if math.floor((300 - (workspace:GetServerTimeNow() % 300))) <= 0 then
		update_stock()
	end
end