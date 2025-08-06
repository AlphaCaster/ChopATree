-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local CreateSeed
if game:GetService("RunService"):IsServer() then
	local GameEvents = game.ReplicatedStorage.GameEvents
	local PlayerData = require(game.ServerStorage.PlayerData)
	local SeedService = require(game.ServerScriptService.Modules.SeedService)

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

	CreateSeed = function(Player, seed)
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
end

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
--local _ = require(l_ReplicatedStorage_0.Data.QuestData.Types);
return {
    Type = "Seed", 
    Display = function(_, v3) --[[ Line: 13 ]] --[[ Name: Display ]]
        local l_Amount_0 = v3.Data.Amount;
        return (("+%* %* Seed%*"):format(l_Amount_0, v3.Data.Seed, l_Amount_0 > 1 and "s" or ""));
    end, 
    Give = function(_, v6, v7) --[[ Line: 18 ]] --[[ Name: Give ]]
        -- upvalues: l_ReplicatedStorage_0 (copy)
        for _ = 1, v7.Data.Amount do
            task.spawn(CreateSeed, v6, v7.Data.Seed);
        end;
        return true;
    end, 
    Use = function(v11, v12) --[[ Line: 30 ]] --[[ Name: Use ]]
        return {
            Type = v11.Type, 
            Data = v12
        };
    end
};