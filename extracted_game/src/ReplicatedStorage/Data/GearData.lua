-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Modules.Chalk);
return {
    ["Watering Can"] = {
        GearName = "Watering Can", 
        GearRarity = "Common", 
        StockChance = 1, 
        StockAmount = {
            1, 
            3
        }, 
        Price = 50000, 
		PurchaseID = 3286317902, 
        GiftPurchaseID = 0, 
        Stack = 10, 
        LayoutOrder = 1, 
        Asset = "rbxassetid://140223014467344", 
        GearDescription = "Speeds up plant growth. 10 uses"
    }, 
    Trowel = {
        GearName = "Trowel", 
        GearRarity = "Uncommon", 
        StockChance = 1, 
        StockAmount = {
            1, 
            1
        }, 
        Price = math.huge, 
        PurchaseID = 0, 
        Stack = 5, 
        LayoutOrder = 2, 
        Asset = "rbxassetid://115261280019001", 
		GearDescription = v1.red("[NOT AVAILABLE]")
    }, 
    ["Basic Sprinkler"] = {
        GearName = "Basic Sprinkler", 
        GearRarity = "Rare", 
        StockChance = 3, 
        StockAmount = {
            1, 
            3
        }, 
        Price = 25000, 
		PurchaseID = 3286318075, 
        GiftPurchaseID = 0, 
        Stack = 1, 
        LayoutOrder = 3, 
        Asset = "rbxassetid://120314005864914", 
        GearDescription = "Increases growth speed and fruit size. Lasts 5 minutes"
    }, 
    ["Advanced Sprinkler"] = {
        GearName = "Advanced Sprinkler", 
        GearRarity = "Legendary", 
        StockChance = 7, 
        StockAmount = {
            1, 
            2
        }, 
        Price = 50000, 
		PurchaseID = 3286318257, 
        GiftPurchaseID = 0, 
        Stack = 1, 
        LayoutOrder = 4, 
        Asset = "rbxassetid://90193997839883", 
        GearDescription = "Increases growth speed and mutation chances. Lasts 5 minutes"
    }, 
    ["Godly Sprinkler"] = {
        GearName = "Godly Sprinkler", 
        GearRarity = "Mythical", 
        StockChance = 11, 
        StockAmount = {
            1, 
            1
        }, 
        Price = 120000, 
		PurchaseID = 3286318519, 
        GiftPurchaseID = 0, 
        Stack = 1, 
        LayoutOrder = 5, 
        Asset = "rbxassetid://75442797836082", 
        GearDescription = "Increases growth speed, mutation chances and fruit size. Lasts 5 minutes"
    }, 
    ["Lightning Rod"] = {
        GearName = "Lightning Rod", 
        GearRarity = "Mythical", 
        StockChance = 50, 
        StockAmount = {
            1, 
            1
        }, 
        Price = 1000000, 
		PurchaseID = 3286318763, 
        GiftPurchaseID = 0, 
        Stack = 1, 
        LayoutOrder = 6, 
        Asset = "rbxassetid://125433095334047", 
        GearDescription = "Redirects lightning 3 times before being destroyed"
    }, 
    ["Master Sprinkler"] = {
        GearName = "Master Sprinkler", 
        GearRarity = "Divine", 
        StockChance = 100, 
        StockAmount = {
            1, 
            1
        }, 
        Price = 10000000, 
		PurchaseID = 3286318970, 
        GiftPurchaseID = 0, 
        Stack = 1, 
        LayoutOrder = 7, 
        Asset = "rbxassetid://98504519094449", 
        GearDescription = v1.yellow("Greatly increases growth speed, mutation chances and fruit size. Lasts 10 minutes")
	},
	["Chocolate Sprinkler"] = {
		GearName = "Chocolate Sprinkler", 
		GearRarity = "Divine", 
		StockChance = 200, 
		StockAmount = {
			1, 
			1
		}, 
		Price = 500000, 
		PurchaseID = 3286319197, 
		GiftPurchaseID = 0, 
		Stack = 1, 
		LayoutOrder = 8, 
		Asset = "rbxassetid://120657843864615", 
		GearDescription = v1.yellow("Covers Plants in chocolate, making them worth the double of sheckles.")
	}
};