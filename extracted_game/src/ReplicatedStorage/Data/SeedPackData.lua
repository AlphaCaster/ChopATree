-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("RunService"):IsStudio();
return {
    Packs = table.freeze({
        Normal = {
            DisplayName = "Normal Seed Pack", 
            Items = {
                {
                    Type = "Seed", 
                    RewardId = "Pumpkin", 
                    Chance = 25
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Watermelon", 
                    Chance = 20
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Peach", 
                    Chance = 20
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Raspberry", 
                    Chance = 10
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Dragon Fruit", 
                    Chance = 10
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Cactus", 
                    Chance = 10
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Pineapple", 
                    Chance = 5
                }
            }
        }, 
        Exotic = {
            DisplayName = "Exotic Seed Pack", 
            EndTime = DateTime.fromUniversalTime(2025, 5, 3, 14), 
            Items = {
                {
                    Type = "Seed", 
                    RewardId = "Papaya", 
                    Icon = "rbxassetid://137358951402692", 
                    Chance = 40
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Banana", 
                    Icon = "rbxassetid://118516260773130", 
                    Chance = 38
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Passionfruit", 
                    Icon = "rbxassetid://139621938553116", 
                    Chance = 20
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Soul Fruit", 
                    Icon = "rbxassetid://111245465505679", 
                    Chance = 1.5
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Cursed Fruit", 
                    Icon = "rbxassetid://89675695188581", 
                    Chance = 0.5
                }
            }
        }, 
        SeedSackBasic = {
            DisplayName = "Basic Seed Pack", 
            Items = {
                {
                    Type = "Seed", 
                    RewardId = "Raspberry", 
                    Icon = "rbxassetid://86654246455569", 
                    Chance = 40, 
                    RemoveChance = true
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Cranberry", 
                    Icon = "rbxassetid://84025739268823", 
                    Chance = 30, 
                    RemoveChance = true
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Durian", 
                    Icon = "rbxassetid://80039191190165", 
                    Chance = 21, 
                    RemoveChance = true
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Eggplant", 
                    Icon = "rbxassetid://121511136640913", 
                    Chance = 8.735, 
                    RemoveChance = true
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Lotus", 
                    Icon = "rbxassetid://104511535272743", 
                    Chance = 0.25, 
                    RemoveChance = true
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Venus Fly Trap", 
                    Icon = "rbxassetid://139210236985330", 
                    Chance = 0.01, 
                    RemoveChance = true
                }, 
                {
                    Type = "Pack", 
                    DisplayName = "Rainbow Sack", 
                    RewardId = "RainbowSeedSackBasic", 
                    Icon = "rbxassetid://102551065819622", 
                    Chance = 0.005, 
                    RemoveChance = true
                }
            }
        }, 
        SeedSackPremium = {
            DisplayName = "Premium Seed Pack", 
            Items = {
                {
                    Type = "Seed", 
                    RewardId = "Cranberry", 
                    Icon = "rbxassetid://84025739268823", 
                    Chance = 45
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Durian", 
                    Icon = "rbxassetid://80039191190165", 
                    Chance = 35
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Eggplant", 
                    Icon = "rbxassetid://121511136640913", 
                    Chance = 16
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Lotus", 
                    Icon = "rbxassetid://104511535272743", 
                    Chance = 2.5
                }, 
                {
                    Type = "Seed", 
                    RewardId = "Venus Fly Trap", 
                    Icon = "rbxassetid://139210236985330", 
                    Chance = 1
                }, 
                {
                    Type = "Pack", 
                    DisplayName = "Rainbow Sack", 
                    RewardId = "RainbowSeedSackPremium", 
                    Icon = "rbxassetid://102551065819622", 
                    Chance = 0.5
                }
            }
        }, 
        RainbowSeedSackBasic = {
            DisplayName = "Rainbow Basic Seed Pack", 
            Items = {
                {
                    Type = "RainbowSeed", 
                    RewardId = "Cranberry", 
                    Icon = "rbxassetid://84025739268823", 
                    Chance = 55, 
                    RemoveChance = true
                }, 
                {
                    Type = "RainbowSeed", 
                    RewardId = "Durian", 
                    Icon = "rbxassetid://80039191190165", 
                    Chance = 36, 
                    RemoveChance = true
                }, 
                {
                    Type = "RainbowSeed", 
                    RewardId = "Eggplant", 
                    Icon = "rbxassetid://121511136640913", 
                    Chance = 8.735, 
                    RemoveChance = true
                }, 
                {
                    Type = "RainbowSeed", 
                    RewardId = "Lotus", 
                    Icon = "rbxassetid://104511535272743", 
                    Chance = 0.25, 
                    RemoveChance = true
                }, 
                {
                    Type = "RainbowSeed", 
                    RewardId = "Venus Fly Trap", 
                    Icon = "rbxassetid://139210236985330", 
                    Chance = 0.01, 
                    RemoveChance = true
                }
            }
        }, 
        RainbowSeedSackPremium = {
            DisplayName = "Rainbow Premium Seed Pack", 
            Items = {
                {
                    Type = "RainbowSeed", 
                    RewardId = "Cranberry", 
                    Icon = "rbxassetid://84025739268823", 
                    Chance = 45
                }, 
                {
                    Type = "RainbowSeed", 
                    RewardId = "Durian", 
                    Icon = "rbxassetid://80039191190165", 
                    Chance = 35
                }, 
                {
                    Type = "RainbowSeed", 
                    RewardId = "Eggplant", 
                    Icon = "rbxassetid://121511136640913", 
                    Chance = 16
                }, 
                {
                    Type = "RainbowSeed", 
                    RewardId = "Lotus", 
                    Icon = "rbxassetid://104511535272743", 
                    Chance = 2.5
                }, 
                {
                    Type = "RainbowSeed", 
                    RewardId = "Venus Fly Trap", 
                    Icon = "rbxassetid://139210236985330", 
                    Chance = 1
                }
            }
        }
    }), 
    GetTextDisplayForItem = function(_, v2) --[[ Line: 304 ]] --[[ Name: GetTextDisplayForItem ]]
        if v2.DisplayName then
            return v2.DisplayName;
        else
            return v2.RewardId;
        end;
    end
};