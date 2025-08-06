-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local stringUtilsModule = require(game.ReplicatedStorage.Modules.StringUtils);
local itemModule = {};
--[[
ItemName
Rarity
Value
Weight Thing
]]
local itemData = {
	{
		"Carrot", -- name 
		0.275, -- base weight
		20,  -- value per kg
		100 -- 1/this = chance to grow huge
	}, 
	{
		"Strawberry", 
		0.3, 
		15, 
		100
	}, 
	{
		"Blueberry", 
		0.2, 
		20, 
		100
	}, 
	{
		"Orange Tulip", 
		0.05, 
		850, 
		55
	}, 
	{
		"Wooden Statue", 
		0.5, 
		25000, 
		40
	}, 
	{
		"Walking Shark", 
		0.275, 
		50000, 
		50
	}, 
	{
		"Eden Fruit", 
		3, 
		200000, 
		40
	}, 
	{
		"Tomato", 
		0.5, 
		30, 
		100
	}, 
	{
		"Sigma", 
		.275, 
		400, 
		20
	}, 
	{
		"Corn", 
		2, 
		40, 
		100
	}, 
	{
		"Daffodil", 
		0.2, 
		1000, 
		45
	}, 
	{
		"Watermelon", 
		7, 
		3000, 
		70
	}, 
	{
		"Pumpkin", 
		8, 
		3400, 
		80
	}, 
	{
		"Apple", 
		3, 
		275, 
		50
	}, 
	{
		"Bamboo", 
		4, 
		4000, 
		35
	}, 
	{
		"Coconut", 
		14, 
		400, 
		70
	}, 
	{
		"Cactus", 
		7, 
		3400, 
		100
	}, 
	{
		"Dragon Fruit", 
		12, 
		4750, 
		100
	}, 
	{
		"Mango", 
		15, 
		6500, 
		200
	}, 
	{
		"Grape", 
		3, 
		7850, 
		200
	}, 
	{
		"Mushroom", 
		25, 
		151000, 
		220
	}, 
	{
		"Chocolate Carrot", 
		0.275, 
		11000, 
		100
	}, 
	{
		"Red Lollipop", 
		4, 
		50000, 
		65
	}, 
	{
		"Blue Lollipop", 
		1, 
		50000, 
		65
	}, 
	{
		"Candy Sunflower", 
		1.5, 
		80000, 
		85
	}, 
	{
		"Candy Blossom", 
		3, 
		100000, 
		40
	}, 
	{
		"Peach", 
		2, 
		300, 
		70
	}, 
	{
		"Raspberry", 
		0.75, 
		100, 
		70
	}, 
	{
		"Pineapple", 
		3, 
		2000, 
		70
	}, 
	{
		"Papaya", 
		3, 
		1000, 
		60
	}, 
	{
		"Banana", 
		1.5, 
		1750, 
		100
	}, 
	{
		"Passionfruit", 
		3, 
		3550, 
		40
	}, 
	{
		"Soul Fruit", 
		25, 
		7750, 
		200
	}, 
	{
		"Cursed Fruit", 
		30, 
		12750, 
		200
	}, 
	{
		"Mega Mushroom", 
		70, 
		500, 
		2000000
	}, 
	{
		"Cherry Blossom", 
		3, 
		500, 
		400
	}, 
	{
		"Purple Cabbage", 
		5, 
		500, 
		70
	}, 
	{
		"Lemon", 
		1, 
		350, 
		50
	}, 
	{
		"Pear", 
		3, 
		500, 
		20
	}, 
	{
		"Crocus", 
		0.05, 
		850, 
		55
	}, 
	{
		"Pink Tulip", 
		0.05, 
		850, 
		55
	}, 
	{
		"Cranberry", 
		1, 
		350, 
		50
	}, 
	{
		"Succulent", 
		3, 
		3500, 
		150
	}, 
	{
		"Durian", 
		8, 
		5000, 
		200
	}, 
	{
		"Eggplant", 
		5, 
		7500, 
		220
	}, 
	{
		"Lotus", 
		20, 
		8000, 
		650
	}, 
	{
		"Venus Fly Trap", 
		10, 
		9500, 
		650
	}
};
local rarityMultipliers = {
	{
		"Normal", 
		1000, -- 1000
		1
	}, 
	{
		"Gold", 
		10,  -- 10
		20
	}, 
	{
		"Rainbow", 
		1,  -- 1
		50
	}
};
local dropRates = {
	{
		"Gold", 
		4, 
		20
	}, 
	{
		"Rainbow", 
		1, 
		50
	}
};
local rarityColors = {
	{
		"Common", 
		Color3.new(0.666667, 0.666667, 0.666667)
	}, 
	{
		"Uncommon", 
		Color3.new(0.32549, 0.666667, 0.384314)
	}, 
	{
		"Rare", 
		Color3.new(0.027451, 0.466667, 1)
	}, 
	{
		"Legendary", 
		Color3.new(1, 1, 0)
	}, 
	{
		"Mythical", 
		Color3.new(0.666667, 0.333333, 1)
	}, 
	{
		"Divine", 
		Color3.fromRGB(255, 85, 0)
	}
};
local seedDataList = {
	{
		"Carrot Seed", 
		"Carrot", 
		1.1, 
		"Common", 
		3248692171, 
		10, 
		5, 
		3269339926
	}, 
	{
		"Strawberry Seed", 
		"Strawberry", 
		2, 
		"Common", 
		3248695947, 
		50, 
		3, 
		3269339924
	}, 
	{
		"Tomato Seed", 
		"Tomato", 
		4, 
		"Rare", 
		3248696942, 
		800, 
		1, 
		3269339929
	}, 
	{
		"Sigma Seed", 
		"Sigma", 
		4, 
		"Mythical", 
		3248696942, 
		800, 
		1, 
		3269339929
	}, 
	{
		"Blueberry Seed", 
		"Blueberry", 
		3, 
		"Uncommon", 
		3248690960, 
		400, 
		3, 
		3269339931
	}, 
	{
		"Orange Tulip Seed", 
		"Orange Tulip", 
		3, 
		"Common", 
		3265927408, 
		100, 
		0, 
		3269339925
	}, 
	{
		"Wooden Statue Seed", 
		"Wooden Statue", 
		3, 
		"Divine", 
		3265927408, 
		100, 
		0, 
		3269339925
	},
	{
		"Walking Shark Seed", 
		"Walking Shark", 
		3, 
		"Divine", 
		3265927408, 
		100, 
		0, 
		3269339925
	},
	{
		"Corn Seed", 
		"Corn", 
		5, 
		"Rare", 
		3248692845, 
		1300, 
		0, 
		3269339919
	}, 
	{
		"Pumpkin Seed", 
		"Pumpkin", 
		10, 
		"Legendary", 
		3248695199, 
		3000, 
		0, 
		3269339934
	}, 
	{
		"Daffodil Seed", 
		"Daffodil", 
		10, 
		"Common", 
		3265927978, 
		100, 
		0, 
		3269339921
	}, 
	{
		"Watermelon Seed", 
		"Watermelon", 
		7, 
		"Legendary", 
		3248697546, 
		2500, 
		0, 
		3269339904
	}, 
	{
		"Apple Seed", 
		"Apple", 
		14, 
		"Legendary", 
		3248716238, 
		3250, 
		0, 
		3269339923
	}, 
	{
		"Bamboo Seed", 
		"Bamboo", 
		3, 
		"Uncommon", 
		3261009117, 
		4000, 
		3, 
		3269339922
	}, 
	{
		"Purple Cabbage Seed", 
		"Purple Cabbage", 
		40, 
		"Mythical", 
		3273005969, 
		5250, 
		0, 
		3273008000
	}, 
	{
		"Coconut Seed", 
		"Coconut", 
		20, 
		"Mythical", 
		3248744789, 
		4750, 
		0, 
		3269339918
	}, 
	{
		"Cactus Seed", 
		"Cactus", 
		100, 
		"Legendary", 
		3260940714, 
		17000, 
		0, 
		3269339920
	}, 
	{
		"Eggplant Seed", 
		"Eggplant", 
		16, 
		"Mythical", 
		3273006109, 
		30000, 
		0, 
		3273007733
	}, 
	{
		"Dragon Fruit Seed", 
		"Dragon Fruit", 
		40, 
		"Mythical", 
		3253012192, 
		27000, 
		0, 
		3269339909
	}, 
	{
		"Mango Seed", 
		"Mango", 
		70, 
		"Mythical", 
		3259333414, 
		50000, 
		0, 
		3269339912
	}, 
	{
		"Grape Seed", 
		"Grape", 
		20, 
		"Mythical", 
		3261068725, 
		4750, 
		0, 
		3269339905
	}, 
	{
		"Pink Tulip Seed", 
		"Pink Tulip", 
		15, 
		"Common", 
		3265927598, 
		100, 
		0, 
		nil
	}, 
	{
		"Crocus Seed", 
		"Crocus", 
		10, 
		"Common", 
		3265927895, 
		100, 
		0, 
		nil
	}, 
	{
		"Red Lollipop Seed", 
		"Red Lollipop", 
		1.5, 
		"Rare", 
		3268186603, 
		100, 
		0, 
		nil
	}, 
	{
		"Blue Lollipop Seed", 
		"Blue Lollipop", 
		1.5, 
		"Rare", 
		3268186832, 
		100, 
		0, 
		nil
	}, 
	{
		"Candy Sunflower Seed", 
		"Candy Sunflower", 
		1.5, 
		"Legendary", 
		3268187175, 
		500, 
		0, 
		nil
	}, 
	{
		"Candy Blossom Seed", 
		"Candy Blossom", 
		10, 
		"Rare", 
		3268187638, 
		8000, 
		0, 
		nil
	}, 
	{
		"Eden Fruit Seed", 
		"Eden Fruit", 
		10, 
		"Divine", 
		3268187638, 
		8000, 
		0, 
		nil
	}, 
	{
		"Peach Seed", 
		"Peach", 
		10, 
		"Rare", 
		0, 
		10000, 
		0, 
		nil
	}, 
	{
		"Raspberry Seed", 
		"Raspberry", 
		10, 
		"Rare", 
		0, 
		10000, 
		0, 
		nil
	}, 
	{
		"Pineapple Seed", 
		"Pineapple", 
		10, 
		"Rare", 
		0, 
		10000, 
		0, 
		nil
	}, 
	{
		"Papaya Seed", 
		"Papaya", 
		10, 
		"Rare", 
		3265927598, 
		10000, 
		0, 
		nil
	}, 
	{
		"Banana Seed", 
		"Banana", 
		10, 
		"Rare", 
		3269001250, 
		8000, 
		0, 
		nil
	}, 
	{
		"Passionfruit Seed", 
		"Passionfruit", 
		10, 
		"Rare", 
		3265927598, 
		10000, 
		0, 
		nil
	}, 
	{
		"Soul Fruit Seed", 
		"Soul Fruit", 
		10000000, 
		"Robux", 
		1, 
		0, 
		0, 
		nil
	}, 
	{
		"Cursed Fruit Seed", 
		"Cursed Fruit", 
		10000000, 
		"Robux", 
		1, 
		0, 
		0, 
		nil
	}, 
	{
		"Cranberry Seed", 
		"Cranberry", 
		10, 
		"Rare", 
		0, 
		10000, 
		0, 
		nil
	}, 
	{
		"Durian Seed", 
		"Durian", 
		2, 
		"Common", 
		0, 
		50, 
		3, 
		nil
	}, 
	{
		"Lotus Seed", 
		"Lotus", 
		2, 
		"Common", 
		0, 
		50, 
		3, 
		nil
	}, 
	{
		"Venus Fly Trap Seed", 
		"Venus Fly Trap", 
		10, 
		"Rare", 
		0, 
		10000, 
		0, 
		nil
	}, 
	{
		"Mega Mushroom Seed", 
		"Mega Mushroom", 
		10, 
		"Rare", 
		0, 
		10000, 
		0, 
		nil
	}, 
	{
		"Mushroom Seed", 
		"Mushroom", 
		10, 
		"Rare", 
		3273973729, 
		10000, 
		0, 
		3273973524
	}, 
	{
		"Succulent Seed", 
		"Succulent", 
		2, 
		"Common", 
		0, 
		50, 
		3, 
		nil
	}, 
	{
		"Lemon Seed", 
		"Lemon", 
		4, 
		"Rare", 
		0, 
		800, 
		1, 
		nil
	}, 
	{
		"Cherry Blossom Seed", 
		"Cherry Blossom", 
		2, 
		"Common", 
		0, 
		50, 
		3, 
		nil
	}
};
itemModule.Return_All_Data = function() --[[ Line: 734 ]] --[[ Name: Return_All_Data ]]
	-- upvalues: v2 (copy)
	return itemData;
end;
itemModule.Return_All_Seeds = function() --[[ Line: 737 ]] --[[ Name: Return_All_Seeds ]]
	-- upvalues: v6 (copy)
	return seedDataList;
end;
itemModule.Return_Seed_Data = function(seedName) --[[ Line: 740 ]] --[[ Name: Return_Seed_Data ]]
	-- upvalues: v6 (copy)
	for _, seedData in pairs(seedDataList) do
		if seedData[1] == seedName then
			return seedData;
		end;
	end;
end;
itemModule.Return_Rarity_Data = function(rarityName) --[[ Line: 747 ]] --[[ Name: Return_Rarity_Data ]]
	-- upvalues: v5 (copy)
	for _, rarityData in pairs(rarityColors) do
		if rarityData[1] == rarityName then
			return rarityData;
		end;
	end;
end;
itemModule.Return_Multiplier = function(rarity) --[[ Line: 754 ]] --[[ Name: Return_Multiplier ]]
	-- upvalues: v3 (copy)
	for _, multiplierData in pairs(rarityMultipliers) do
		if multiplierData[1] == rarity then
			return multiplierData[3];
		end;
	end;
	return 0;
end;
itemModule.Return_Random_Rarity = function(normalRarityWeight) --[[ Line: 767 ]] --[[ Name: Return_Random_Rarity ]]
	-- upvalues: v3 (copy)
	local totalWeight = 0;
	for _, rarityMultiplier in rarityMultipliers do
		totalWeight = totalWeight + rarityMultiplier[2] / (rarityMultiplier[1] == "Normal" and normalRarityWeight or 1);
	end;
	local randomNumber = math.random(1, totalWeight);
	local cumulativeWeight = 0;
	local _ = nil;
	for _, rarityDataEntry in rarityMultipliers do
		cumulativeWeight = cumulativeWeight + rarityDataEntry[2] / (rarityDataEntry[1] == "Normal" and normalRarityWeight or 1);
		if randomNumber <= cumulativeWeight then
			return rarityDataEntry[1];
		end;
	end;
end;
itemModule.Return_Random_Super_Rarity = function() --[[ Line: 787 ]] --[[ Name: Return_Random_Super_Rarity ]]
	-- upvalues: v4 (copy)
	local totalDropRate = 0;
	for _, dropRate in ipairs(dropRates) do
		totalDropRate = totalDropRate + dropRate[2];
	end;
	local randomDropNumber = math.random(1, totalDropRate);
	local cumulativeDropRate = 0;
	local _ = nil;
	for _, dropRateEntry in ipairs(dropRates) do
		cumulativeDropRate = cumulativeDropRate + dropRateEntry[2];
		if randomDropNumber <= cumulativeDropRate then
			return dropRateEntry[1];
		end;
	end;
end;
itemModule.Return_Data = function(itemName) --[[ Line: 805 ]] --[[ Name: Return_Data ]]
	-- upvalues: v0 (copy), v2 (copy)
	local strippedItemName = stringUtilsModule:StipFlavourText(itemName);
	for _, item in itemData do
		if item[1] == strippedItemName then
			return item;
		end;
	end;
	warn((("Item_Module.Return_Data | Could not find data for item:\"%*\""):format(itemName)));
end;
return itemModule;