-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local costCalculator = {};
costCalculator.__index = costCalculator;
costCalculator.new = function(properties) --[[ Line: 4 ]] --[[ Name: new ]]
	-- upvalues: v0 (copy)
	local costInstance = setmetatable({}, costCalculator);
	costInstance.BaseCost = properties.BaseCost or 100;
	costInstance.ScalingFactor = properties.ScalingFactor or 1.2;
	return costInstance;
end;
costCalculator.GetCost = function(instance, level) --[[ Line: 11 ]] --[[ Name: GetCost ]]
	return instance.BaseCost * math.pow(instance.ScalingFactor, level - 1);
end;
return costCalculator;