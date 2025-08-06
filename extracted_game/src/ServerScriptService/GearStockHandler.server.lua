-- !native

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local Data = ReplicatedStorage:WaitForChild("Data")
local DataStream = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("DataStream")
local GearData = require(Data:WaitForChild("GearData"))
local PlayerData = require(ServerStorage:WaitForChild("PlayerData"))

repeat wait() until next(PlayerData) ~= nil
local SEED_MULTIPLIER = 25

--function decide_stock_amount(data) -- i cba to c hange the names this is for gears and not seeds
--	if not data then return 0 end;

--	local seedName = data.GearName;
--	local seedRarity = data.GearRarity;
--	local stockChance = data.StockChance;
--	local stockMin, stockMax = data.StockAmount[1], data.StockAmount[2];

--	local stockAmount = math.random(stockMin, stockMax) * SEED_MULTIPLIER;
--	return if math.random(1, stockChance) == 1 then stockAmount else 0;
--end;

function update_stock()
	if not PlayerData then return end
	
	for i,v in pairs(PlayerData) do
		for i2,v2 in pairs(GearData) do
			if v.Data.GearStock then
				if not v.Data.GearStock.Stocks[i2] then
					v.Data.GearStock.Stocks[i2] = {}
				end
				v.Data.GearStock.Stocks[i2]["MaxStock"] = v2.StockAmount[2]
				v.Data.GearStock.Stocks[i2]["Stock"] = math.random(v2.StockAmount[1], v2.StockAmount[2]) * 2
			end	
		end

		DataStream:FireAllClients("UpdateData", (("%*_DataServiceProfile"):format(i.Name)), {{"ROOT/GearStock/Stocks", v.Data.GearStock.Stocks}})
	end
end

while task.wait() do
	if math.floor((300 - (workspace:GetServerTimeNow() % 300))) <= 0 then
		update_stock()
	end
end	