-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local itemModule = {};
local itemModule = require(game.ReplicatedStorage.Item_Module);
itemModule.Calculate_Weight = function(seed, itemId) --[[ Line: 4 ]] --[[ Name: Calculate_Weight ]]
	-- upvalues: v1 (copy)
	math.randomseed(seed);
	local itemData = itemModule.Return_Data(itemId);
	if itemData then
		local weightMultiplier = math.random(700, 1400) * 0.001;
		-- making all plant huge for testing if it can handle huge plants
		if math.random(1, itemData[4] / 2) == 1 then
			weightMultiplier = weightMultiplier * math.random(3, 5); -- min 3, max 5
		end;
		return itemData[2] * weightMultiplier, weightMultiplier;
	else
		return;
	end;
end;
return itemModule;