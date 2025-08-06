	local PlayerData = require(game:GetService("ServerStorage"):WaitForChild("PlayerData"))
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local GetFarm = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("GetFarm"))

-- MEDS GOYIM NOTHING EVER HAPPENED HERE
local SeedService = {
	Create = function (self, player, seed, dogwalk)
		local seedUUID = game:GetService("HttpService"):GenerateGUID(true)
		
		if not PlayerData[player]["Data"]["InventoryData"] then
			PlayerData[player]["Data"]["InventoryData"] = {}
		end
		
		PlayerData[player]["Data"]["InventoryData"][seedUUID] = { 
			ItemData = {
				ItemName = seed,
				Quantity = dogwalk or 1,
				Variant = "Normal",
			},
			ItemType = "Seed"
		}
		
		local seedTool = ServerStorage:WaitForChild("Seeds"):WaitForChild("SeedTemplate"):Clone()
		
		seedTool.Parent = player.Backpack
		seedTool.Name = seed .. " Seed X"..PlayerData[player]["Data"]["InventoryData"][seedUUID]["ItemData"]["Quantity"]
		
		seedTool:SetAttribute("ITEM_TYPE", "Seed")
		seedTool:SetAttribute("ITEM_UUID", seedUUID)
		seedTool:SetAttribute("ItemName", seed)
		seedTool:SetAttribute("ItemType", "Seed")
		seedTool:SetAttribute("OWNER", player.UserId)
		seedTool:SetAttribute("Quantity", 1)
		seedTool:SetAttribute("Seed", seed)
		seedTool:SetAttribute("Variant", "Normal")
		
		return seedUUID
	end,
	CreateFromUUID = function(self, player:Player, seedUUID: string, seed: string) -- used for player init mostly lol
		if not PlayerData[player]["Data"]["InventoryData"] then
			PlayerData[player]["Data"]["InventoryData"] = {}
		end
		
		local seedTool = ServerStorage:WaitForChild("Seeds"):WaitForChild("SeedTemplate"):Clone()

		seedTool.Parent = player.Backpack
		seedTool.Name = seed .. " Seed X"..PlayerData[player]["Data"]["InventoryData"][seedUUID]["ItemData"]["Quantity"]

		seedTool:SetAttribute("ITEM_TYPE", "Seed")
		seedTool:SetAttribute("ITEM_UUID", seedUUID)
		seedTool:SetAttribute("ItemName", seed)
		seedTool:SetAttribute("ItemType", "Seed")
		seedTool:SetAttribute("OWNER", player.UserId)
		seedTool:SetAttribute("Quantity", PlayerData[player]["Data"]["InventoryData"][seedUUID]["ItemData"]["Quantity"])
		seedTool:SetAttribute("Seed", seed)
		seedTool:SetAttribute("Variant", "Normal")
	end,
	--Plant = function (self, player: Player, plantPos: Vector3, seed: string)
	--	local plants = ServerStorage:WaitForChild("Plants")
	--	local plantCopy = plants:WaitForChild(seed):Clone()		 -- change this to set plant rrn just forr testing
	--	local plantSpot = plants:WaitForChild("PlantSpot"):Clone()
		
	--	plantSpot.Parent = GetFarm(player).Important.Plants_Physical
	--	plantSpot.Position = plantPos
		
	--	plantCopy.Parent = GetFarm(player).Important.Plants_Physical
	--	plantCopy:MoveTo(plantPos)
		
	--	for i,v in pairs(player.Character:GetChildren()) do
	--		if v:IsA("Tool") then
	--			PlayerData[player]["Data"]["InventoryData"][v:GetAttribute("ITEM_UUID")] = nil
	--			v:Destroy() -- TODO: send data to client to change inventoryData
	--		end
	--	end
	--end
}

return SeedService
