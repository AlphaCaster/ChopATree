-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_PetAssets_0 = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Models"):WaitForChild("PetAssets");
local v1 = {
    [1] = "Idle", 
    [2] = "FollowPlayer", 
    [3] = "TargetPlant", 
    TargetPlant = 3, 
    FollowPlayer = 2, 
    Idle = 1
};
local v2 = {
    Doge = {
        Description = "A doge pet (admin only)", 
        Actions = {
            "Idle", 
            "PickUp"
        }, 
        Model = l_PetAssets_0:WaitForChild("Doge"), 
        DefaultHunger = 10000, 
        WeldOffset = CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966), 
        ModelScalePerLevel = 0.025, 
        HungerFruitMultipliers = {}
    }
};
local v3 = {
    HUNGER_CONFIG = {
        HUNGER_PER_WEIGHT = 0.25, 
        TOTAL_HUNGER_DEPLETION_TIME = 300
    }, 
    XP_CONFIG = {
        XP_EXPONENTIAL = 1.05, 
        XP_BASE_COST = 13, 
        XP_GAIN_PER_SECOND = 0.5, 
        MAX_LEVEL = 100
    }
};
return {
    PetActionsRegistry = v1, 
    PetList = v2, 
    PetConfig = v3
};