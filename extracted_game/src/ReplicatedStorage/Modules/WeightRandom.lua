-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	dict = function(items, randomSeed) --[[ Line: 3 ]] --[[ Name: dict ]]
		local totalWeight = 0;
		for _, weight in items do
			totalWeight = totalWeight + weight;
		end;
		local randomWeight = (randomSeed or Random.new()):NextNumber(0, totalWeight);
		local cumulativeWeight = 0;
		for itemKey, itemWeight in items do
			cumulativeWeight = cumulativeWeight + itemWeight;
			if randomWeight <= cumulativeWeight then
				return itemKey;
			end;
		end;
		return nil;
	end, 
	array = function(weightedItems, randomSeedChance) --[[ Line: 22 ]] --[[ Name: array ]]
		local totalChance = 0;
		for _, weightedItem in weightedItems do
			totalChance = totalChance + weightedItem.Chance;
		end;
		local randomChance = (randomSeedChance or Random.new()):NextNumber(0, totalChance);
		local cumulativeChance = 0;
		for itemKeyChance, selectedItem in weightedItems do
			cumulativeChance = cumulativeChance + selectedItem.Chance;
			if randomChance <= cumulativeChance then
				return selectedItem, itemKeyChance;
			end;
		end;
		return nil, nil;
	end
};