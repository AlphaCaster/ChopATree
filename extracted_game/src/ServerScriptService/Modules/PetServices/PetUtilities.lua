-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Data.PetRegistry);
local v2 = require(l_ReplicatedStorage_0.Modules.CalculateToolValue);
local l_PetConfig_0 = v1.PetConfig;
local l_PetList_0 = v1.PetList;
local l_XP_CONFIG_0 = l_PetConfig_0.XP_CONFIG;
local _ = l_XP_CONFIG_0.XP_EXPONENTIAL;
local l_HUNGER_PER_WEIGHT_0 = l_PetConfig_0.HUNGER_CONFIG.HUNGER_PER_WEIGHT;
local v8 = require(l_ReplicatedStorage_0.Modules.ExponentialScaler).new({
    BaseCost = l_XP_CONFIG_0.XP_BASE_COST, 
    ScalingFactor = l_XP_CONFIG_0.XP_EXPONENTIAL
});
local v15 = {
    GetCurrentLevelXPCost = function(_, v10) --[[ Line: 25 ]] --[[ Name: GetCurrentLevelXPCost ]]
        -- upvalues: v8 (copy)
        return v8:GetCost(v10);
    end, 
    GetFruitWorthForAnimal = function(_, v12, v13) --[[ Line: 29 ]] --[[ Name: GetFruitWorthForAnimal ]]
        -- upvalues: l_PetList_0 (copy), v2 (copy), l_HUNGER_PER_WEIGHT_0 (copy)
        local v14 = l_PetList_0[v12].HungerFruitMultipliers[v13:GetAttribute("ItemName")] or 1;
        return v2(v13) * l_HUNGER_PER_WEIGHT_0 * v14;
    end
};
v15.GetFruitWorthPercentageForAnimal = function(_, v17, v18) --[[ Line: 41 ]] --[[ Name: GetFruitWorthPercentageForAnimal ]]
    -- upvalues: v15 (copy), l_PetList_0 (copy)
    return v15:GetFruitWorthForAnimal(v17, v18) / l_PetList_0[v17].DefaultHunger;
end;
return v15;