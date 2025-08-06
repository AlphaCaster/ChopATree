-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local itemModule = require(replicatedStorageService.Item_Module);
local mutationHandlerModule = require(replicatedStorageService.Modules.MutationHandler);
return function(itemInstance) --[[ Line: 7 ]] --[[ Name: CalculateToolValue ]]
	-- upvalues: v1 (copy), v2 (copy)
	local itemStringValue = itemInstance:FindFirstChild("Item_String");
	if not itemStringValue then
		return 0;
	else
		local variantValue = itemInstance:FindFirstChild("Variant");
		if not variantValue then
			return 0;
		else
			local weightValue = itemInstance:FindFirstChild("Weight");
			if not weightValue then
				return 0;
			else
				local itemData = itemModule.Return_Data(itemStringValue.Value);
				if not itemData or #itemData < 3 then
					return 0;
				else
					local itemValue = itemData[3];
					local itemRarity = itemData[2];
					local variantMultiplier = itemModule.Return_Multiplier(variantValue.Value);
					local calculatedValue = itemValue * mutationHandlerModule:CalcValueMulti(itemInstance) * variantMultiplier;
					local weightMultiplier = math.clamp(weightValue.Value / itemRarity, 0.95, 100000000);
					return (
						math.round(
							calculatedValue * (weightMultiplier * weightMultiplier)
							* 1.5
						)
					);
				end;
			end;
		end;
	end;
end;