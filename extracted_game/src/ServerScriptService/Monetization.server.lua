local MS = game:GetService("MarketplaceService")
local RS = game:GetService("ReplicatedStorage")
local P = game:GetService("Players")
local HS = game:GetService("HttpService")
local SSS = game:GetService("ServerScriptService")
local SS = game:GetService("ServerStorage")
local GamepassIds = require(RS.PRODUCT_IDS)
local CurrencyService = require(SSS:WaitForChild("Modules"):WaitForChild("CurrencyService"))
local CurrencyService = require(SSS.Modules:WaitForChild("CurrencyService"))
local SeedService = require(SSS:WaitForChild("Modules"):WaitForChild("SeedService"))
local GearService = require(SSS:WaitForChild("Modules"):WaitForChild("GearService"))
local PlayerData = require(SS:WaitForChild("PlayerData"))
local SeedData = require(RS.Data.SeedData)
local GearData = require(RS.Data.GearData)

local GearMap = {
	["Watering Can"] = 10,
	["Trowel"] = 5
}

local GrowAllBought = script.Parent.GrowAllBought

local GameEvents = RS.GameEvents

local itemValues = {
	Blueberry = 10,
	["Candy Blossom"] = 10,
	Bamboo = 25,
	Carrot = 50,
	["Dragon Fruit"] = 10,
	["Orange Tulip"] = 10
}

local randomSeedsList = {"Sigma Seed","Walking Shark","Wooden Statue","Eden Fruit","Candy Blossom","Lotus Seed","Mushroom Seed"}

function GetInventory(player)
	local character = player.Character
	if not character then return end

	local items = {}

	for _, tool in player.Backpack:GetChildren() do -- boiii pairs is so 2018
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

function CreateSeed(Player, seed)
	local seedUUID = nil

	for UUID, data in PlayerData[Player]["Data"]["InventoryData"] do
		if data.ItemType == "Seed" and data.ItemData.ItemName == seed then
			data.ItemData.Quantity += 1
			for _,v in GetInventory(Player) do
				if v:GetAttribute("ItemType") == "Seed" and string.find(v.Name, seed) then
					v.Name = seed .. " Seed X"..data.ItemData.Quantity
					seedUUID = v:GetAttribute("ITEM_UUID")
					break
				end
			end
			break
		end
	end

	if not seedUUID then 
		seedUUID = SeedService:Create(Player, seed) 
	end

	GameEvents.DataStream:FireAllClients("UpdateData", (("%*_DataServiceProfile"):format(Player.Name)), {
		{"ROOT/Inventory/"..seedUUID, PlayerData[Player]["Data"]["InventoryData"][seedUUID]},
	})
end

function CreateGear(Player, gear)
	local GearUUID = nil
	local profile = PlayerData[Player]
	
	if gear:match("Sprinkler") or gear:match("Lightning Rod") then
		for UUID, data in profile.Data.InventoryData do
			if data.ItemType == "Gear" and data.ItemData.ItemName == gear then
				data.ItemData.Quantity += 1
				for _,v in GetInventory(Player) do
					if v:GetAttribute("ItemType") == "Gear" and string.find(v.Name, gear) then
						v.Name = gear .. " X"..data.ItemData.Quantity
						GearUUID = v:GetAttribute("ITEM_UUID")
						break
					end
				end
				break
			end
		end

		if not GearUUID then 
			GearUUID = GearService:Create(Player, gear, GearMap[gear] or 1, 1)
		end
	else
		GearUUID = GearService:Create(Player, gear, GearMap[gear] or 1, 1)
	end

	GameEvents.DataStream:FireAllClients("UpdateData", (("%*_DataServiceProfile"):format(Player.Name)), {
		{"ROOT/Inventory/"..GearUUID, PlayerData[Player]["Data"]["InventoryData"][GearUUID]},
	})
end

local productFunctions = {}
local gamepassFunctions = {}

--productFunctions[] = function(receipt, player)
	
--end
productFunctions[GamepassIds.Scheckles["1000"]] = function(receipt, player)
	CurrencyService:Add(player, 1000)
	--CreateSeed(player, "Walking Shark")
	
	return true
end
productFunctions[GamepassIds.Scheckles["2500"]] = function(receipt, player)
	CurrencyService:Add(player, 2500)

	return true
end
productFunctions[GamepassIds.Scheckles["10000"]] = function(receipt, player)
	CurrencyService:Add(player, 10000)

	return true
end
productFunctions[GamepassIds.Scheckles["100000"]] = function(receipt, player)
	CurrencyService:Add(player, 100000)

	return true
end

productFunctions[GamepassIds.Products.UltimateSeedPack] = function(reciept, Player)
	for i,v in pairs(itemValues) do
		for _  = 1, v do
			CreateSeed(Player, i)
		end
	end

	return true
end

productFunctions[GamepassIds.Products.RandomSeedPack] = function(reciept, Player)
	local random = math.random(1,#randomSeedsList)
	local seedly = randomSeedsList[random]

	for _  = 1, 10 do
		CreateSeed(Player, seedly)
	end


	return true
end


--grow all
productFunctions[GamepassIds.Products.GrowAll] = function(reciept, player)
	GrowAllBought:Fire(player)
	return true
end

productFunctions[GamepassIds.Products.StealPlant] = function(reciept, player)
	script.Parent.StealPlant:Fire(player)
	return true
end

productFunctions[GamepassIds.Products.CollectAll] = function(reciept, player)
	local plants = require(SS.Plants)
	local plrPlants = plants[player]
	
	local toCollect = {}
	if plrPlants then
		for i, v in plrPlants.Plants do
			local model = v.model
			if model then
				if model:FindFirstChild("Fruits") then
					for _, part in model:GetChildren() do
						local proxim = part:FindFirstChild("ProximityPrompt")
						if proxim and proxim.Enabled == true then
							table.insert(toCollect, v.model)
						end
					end
				else
					local proxim = model:FindFirstChild("ProximityPrompt", true)
					if proxim and proxim.Enabled == true then
						table.insert(toCollect, v.model)
					end
				end
			end
		end
		
		for i, v in plrPlants.Fruits do
			local model = v.model
			if model then
				local proxim = model:FindFirstChild("ProximityPrompt", true)
				if proxim and proxim.Enabled == true then
					table.insert(toCollect, v.model)
				end
			end
		end
	end
	
	SSS.Collect:Fire(player, toCollect)
	
	return true
end

local function defaultHandler(receipt, player, productId) 
	for i, v in SeedData do
		if v.PurchaseID == productId then
			CreateSeed(player, i)
			return true
		end
	end
	
	for i,v in GearData do
		if v.PurchaseID == productId then
			CreateGear(player, i)
			return true
		end
	end
	
	return false
end

local function processReceipt(receiptInfo)
	local userId = receiptInfo.PlayerId
	local productId = receiptInfo.ProductId

	local player = P:GetPlayerByUserId(userId)
	if player then
		local handler = productFunctions[productId]
		if not handler then
			handler = defaultHandler
		end
		
		local success, result = pcall(handler, receiptInfo, player, productId)
		if success then
			GameEvents.Notification:FireClient(player, "Successfully bought! Thank you 💖")
			return Enum.ProductPurchaseDecision.PurchaseGranted
		else
			GameEvents.Notification:FireClient(player, "Failed to process receipt: "..tostring(receiptInfo).." / "..tostring(result).." (Show this to developer)")
			warn("Failed to process receipt:", receiptInfo, result)
		end
	end
 --- collect all 
 
	return Enum.ProductPurchaseDecision.NotProcessedYet
end

MS.ProcessReceipt = processReceipt 

local VIPStuff = {
	"Candy Blossom",
	"Lotus",
	"Red Lollipop",
	"Dragon Fruit",
	"Sigma",
	"Wooden Statue",
	"Peach",
	"Mango",
	"Durian",
	"Coconut",
}

gamepassFunctions[GamepassIds.Gamepass.VIP] = function(Player)
	Player:SetAttribute("VIP", true)

	for i,v in pairs(VIPStuff) do
		CreateSeed(Player, v)
	end

	return true
end

MS.PromptGamePassPurchaseFinished:Connect(function(Player, ID, WP)
	if WP == false then return end
	
	if gamepassFunctions[ID] then
		local s, r = pcall(gamepassFunctions[ID], Player)
		if s then
			GameEvents.Notification:FireClient(Player, "Successfully bought! Thank you 💖")
			
			task.spawn(function()
				task.wait(5)
				local res = MS:UserOwnsGamePassAsync(Player.UserId, ID)
				if not game:GetService("RunService"):IsStudio() and not res then
					P:BanAsync({
						UserIds = { Player.UserId },
						Duration = -1,
						DisplayReason = "pls spend robux on my game thanks",
						PrivateReason = "bro",
						ExcludeAltAccounts = false,
						ApplyToUniverse = true,
					})
				end
			end)
		else
			GameEvents.Notification:FireClient(Player, `Unknown error occured (report this to the dev: {r})`)
		end
	end
end)