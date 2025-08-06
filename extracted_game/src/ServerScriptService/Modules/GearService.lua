	local PlayerData = require(game:GetService("ServerStorage"):WaitForChild("PlayerData"))
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local GetFarm = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("GetFarm"))

-- MEDS GOYIM NOTHING EVER HAPPENED HERE
local GearService = {
	Create = function (self, player, Gear, Uses, Quantity)
		if Gear == "Chocolate Sprinker" then
			return
		end
		
		local GearUUID = game:GetService("HttpService"):GenerateGUID(true)
		
		if not PlayerData[player]["Data"]["InventoryData"] then
			PlayerData[player]["Data"]["InventoryData"] = {}
		end
		
		PlayerData[player]["Data"]["InventoryData"][GearUUID] = { 
			ItemData = {
				ItemName = Gear,
				Quantity = Quantity or 1,
				UsesLeft = Uses or 1,
				Variant = "Normal",
			},
			ItemType = "Gear"
		}
		
		local GearTool = ReplicatedStorage.Gears[Gear]:Clone()
		
		GearTool.Parent = player.Backpack
		GearTool:SetAttribute("UsesLeft", PlayerData[player]["Data"]["InventoryData"][GearUUID]["ItemData"]["UsesLeft"])
		GearTool.Name = Gear .. " X"..PlayerData[player]["Data"]["InventoryData"][GearUUID]["ItemData"]["Quantity"]
		
		GearTool:SetAttribute("ITEM_TYPE", "Gear")
		GearTool:SetAttribute("ITEM_UUID", GearUUID)
		GearTool:SetAttribute("ItemName", Gear)
		GearTool:SetAttribute("ItemType", "Gear")
		GearTool:SetAttribute("OWNER", player.UserId)
		GearTool:SetAttribute("Quantity", 1)
		GearTool:SetAttribute("Gear", Gear)
		
		return GearUUID
	end,
	CreateFromUUID = function(self, player:Player, GearUUID: string, Gear: string) -- used for player init mostly lol
		if Gear == "Chocolate Sprinker" then
			return
		end
		
		if not PlayerData[player]["Data"]["InventoryData"] then
			PlayerData[player]["Data"]["InventoryData"] = {}
		end
		
		local GearTool = ReplicatedStorage.Gears[Gear]:Clone()

		GearTool.Parent = player.Backpack
		GearTool:SetAttribute("UsesLeft", PlayerData[player]["Data"]["InventoryData"][GearUUID]["ItemData"]["UsesLeft"])
		GearTool.Name = Gear .. " X"..PlayerData[player]["Data"]["InventoryData"][GearUUID]["ItemData"]["Quantity"]

		GearTool:SetAttribute("ITEM_TYPE", "Gear")
		GearTool:SetAttribute("ITEM_UUID", GearUUID)
		GearTool:SetAttribute("ItemName", Gear)
		GearTool:SetAttribute("ItemType", "Gear")
		GearTool:SetAttribute("OWNER", player.UserId)
		GearTool:SetAttribute("Quantity", PlayerData[player]["Data"]["InventoryData"][GearUUID]["ItemData"]["Quantity"])
		GearTool:SetAttribute("Gear", Gear)
	end,
}

return GearService
