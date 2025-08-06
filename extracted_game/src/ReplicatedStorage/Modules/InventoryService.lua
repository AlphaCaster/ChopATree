-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local dataServiceModule = require(replicatedStorageService.Modules.DataService);
return {
	GetToolData = function(_, tool) --[[ Line: 14 ]] --[[ Name: GetToolData ]]
		-- upvalues: v1 (copy)
		if not tool then
			return warn("InventoryService:GetToolData | Player is Nil!", debug.traceback());
		elseif not tool:IsA("Tool") then
			return warn(("InventoryService:GetToolData | %* is not of 'Tool' type!"):format(tool), debug.traceback());
		else
			local itemUUID = tool:GetAttribute("ITEM_UUID");
			if not itemUUID then
				return warn(tool, "has no attached ITEM_UUID attribute");
			else
				local itemData = dataServiceModule:GetData().InventoryData[itemUUID];
				if not itemData then
					return;
				else
					return itemData;
				end;
			end;
		end;
	end
};