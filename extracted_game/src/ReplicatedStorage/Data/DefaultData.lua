local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
-- local _ = require(l_ReplicatedStorage_0.Data.QuestData.Types);
return {
    Backpack = {}, 
    PlantedObjects = {}, 
    SavedFruit = {}, 
    LastSaveTime = 0, 
    FirstTimeUser = true, 
    Migrated = {}, 
    Sheckles =  20_000, 
    LevelData = {}, 
	ClaimedCodes = {}, 
	EquippedSkin = "",
	SkinsData = {},
    SeedStock = {
        Seed = 0, 
        Stocks = {}, 
        ForcedSeed = nil, 
        ForcedSeedEndTimestamp = nil
    }, 
    GearStock = {
        Gear = 0, 
        Stocks = {}, 
        ForcedGear = nil, 
        ForcedGearEndTimestamp = nil
    }, 
    DailyQuests = nil, 
    SavedObjects = {}, 
    InventoryData = {}, 
    QuestContainers = {}, 
    BadgeData = {}, 
    PetsData = {
        MutableStats = {
            MaxEquippedPets = 3, 
            MaxPetsInInventory = 60
        }, 
        EquippedPets = {}, 
        PetInventory = {
            Counter = 0, 
            Data = {}
        }
    }, 
    SeedPackGiverInfo = {
        RequiredPlantInfo = {
            RequiredPlant = nil, 
            RequiredPlantSize = nil, 
            RequiredPlantVariant = nil, 
            RequiredPlantMutation = nil
        }, 
        SeedPackGiverDiscovered = false, 
        Progression = 1, 
        ProgressionSeedPacks = 0
    }, 
    InfinitePack = {
        Depth = 0, 
        Day = 0
    }, 
    StarterPack = {
        Started = false, 
        ContainerId = nil, 
        Timer = nil, 
        ShowTimer = nil
    }, 
    TotalRobuxSpent = 0, 
    Transactions = {}, 
    Gifts = {
        Inventory = {}, 
        History = {
            Sent = {}, 
            Received = {}
        }
    }
};