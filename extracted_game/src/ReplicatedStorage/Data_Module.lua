-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local dataModule = {};
local dataStoreService = game:GetService("DataStoreService");
local _ = game:GetService("ReplicatedStorage");
local serverStorageService = game:GetService("ServerStorage");
local serverScriptService = game:GetService("ServerScriptService");
local replicatedStorage = game:GetService("ReplicatedStorage");
local httpService = game:GetService("HttpService");
local modulesFolder = replicatedStorage:WaitForChild("Modules");
local getFarmFunction = require(modulesFolder:WaitForChild("GetFarm"));
local mutationHandler = require(game.ReplicatedStorage.Modules.MutationHandler);
local _ = require(serverScriptService.Modules.InventoryService);
local _ = serverStorageService:WaitForChild("Tools");
local _ = require(replicatedStorage.Modules.DumpTable);
local remotesModule = require(replicatedStorage.Modules.Remotes);
local inventoryDataStore = dataStoreService:GetDataStore("Inventory_22");
local _ = require(replicatedStorage.Give_Seed);
local _ = require(replicatedStorage.Give_Seed);
local dataService = require(serverScriptService.Modules.DataService);
local gardenBadgeAwarderModule = require(serverScriptService.Modules.GardenBadgeAwarder);
local _ = function(player) --[[ Line: 46 ]] --[[ Name: MigrateData ]]
	-- upvalues: v17 (copy), l_l_DataStoreService_0_DataStore_0 (copy)
	local playerData = dataService:GetPlayerDataAsync(player, 10);
	if not playerData then
		return;
	elseif playerData.Migrated.Data_Module then
		return;
	else
		local dataLoadSuccess = false;
		local dataLoadResult = nil;
		for _ = 1, 10 do
			local dataLoadStatus, dataLoadResultValue = pcall(function() --[[ Line: 55 ]]
				-- upvalues: l_l_DataStoreService_0_DataStore_0 (ref), v19 (copy)
				return inventoryDataStore:GetAsync(player.UserId);
			end);
			dataLoadSuccess = dataLoadStatus;
			dataLoadResult = dataLoadResultValue;
			if not dataLoadSuccess then
				task.wait(2);
			else
				break;
			end;
		end;
		if not dataLoadSuccess then
			return player:Kick();
		elseif not dataLoadResult then
			playerData.Migrated.Data_Module = true;
			return;
		else
			playerData.FirstTimeUser = false;
			playerData.Backpack = dataLoadResult[1];
			playerData.PlantedObjects = dataLoadResult[2];
			playerData.LastSaveTime = dataLoadResult[3];
			playerData.Migrated.Data_Module = true;
			return true;
		end;
	end;
end;
local invalidBackpackItems = {};
dataModule.Setup = function(playerInstance) --[[ Line: 92 ]] --[[ Name: Setup ]]
	-- upvalues: v17 (copy), v13 (copy), v27 (copy)
	task.delay(0, function() --[[ Line: 93 ]]
		-- upvalues: v28 (copy), v17 (ref), v13 (ref), v27 (ref)
		if not playerInstance then
			return;
		elseif not playerInstance.UserId then
			return;
		else
			local playerDataAsync = dataService:GetPlayerDataAsync(playerInstance);
			if not playerInstance.Character then
				local _ = playerInstance.CharacterAdded:Wait();
			end;
			if not playerDataAsync then
				return;
			else
				if playerDataAsync.Sheckles == 20 and playerDataAsync.FirstTimeUser then
					remotesModule.Tutorial.Start.sendTo(nil, playerInstance);
					playerInstance:SetAttribute("FirstTimePlayer", true);
					task.delay(20, function() --[[ Line: 116 ]]
						-- upvalues: l_v17_PlayerDataAsync_1 (copy)
						playerDataAsync.FirstTimeUser = false;
					end);
				end;
				local timeSinceLastSave = DateTime.now().UnixTimestamp - playerDataAsync.LastSaveTime;
				playerInstance:SetAttribute("Grow_Amount", timeSinceLastSave);
				if table.find(invalidBackpackItems, playerInstance.Name) then
					playerDataAsync.Backpack = {};
				end;
				playerInstance:SetAttribute("Setup_Finished", true);
				playerInstance:SetAttribute("Finished_Loading", true);
				return;
			end;
		end;
	end);
end;
dataModule.Remove_Collected_Item = function(_, _, _, _) --[[ Line: 270 ]] --[[ Name: Remove_Collected_Item ]]
	error("DEPRECATED");
end;
dataModule.AddPlantedObject = function(playerAddPlanted, plantName, zCoordinate, touchPosition, plantedVariant, plantModel) --[[ Line: 288 ]] --[[ Name: AddPlantedObject ]]
	-- upvalues: v17 (copy), v18 (copy), v0 (copy)
	local playerDataAsyncAddPlanted = dataService:GetPlayerDataAsync(playerAddPlanted, 10);
	if not playerDataAsyncAddPlanted then
		return;
	else
		for _, plantedObjectData in playerDataAsyncAddPlanted.PlantedObjects do
			if plantedObjectData[1] == plantName and plantedObjectData[2] == zCoordinate then
				return;
			end;
		end;
		local plantPosition = Vector3.new(0, 0, 0, 0);
		local objectSpacePosition = plantModel:ToObjectSpace(touchPosition);
		--v18.Plant(v18, v36, v37);
		plantPosition = Vector3.new(objectSpacePosition.X, objectSpacePosition.Y, objectSpacePosition.Z);
		local _ = plantModel * CFrame.new(plantPosition.X, plantPosition.Y, plantPosition.Z);
		table.insert(playerDataAsyncAddPlanted.PlantedObjects, {
			plantName, 
			zCoordinate, 
			{
				plantPosition.X, 
				plantPosition.Y, 
				plantPosition.Z
			}, 
			0, 
			plantedVariant.Variant.Value, 
			false
		});
		dataModule.Save(playerAddPlanted);
		return;
	end;
end;
dataModule.Update_Plant_CFrame = function(playerUpdatePlant, plantedItem, fruitPosition) --[[ Line: 316 ]] --[[ Name: Update_Plant_CFrame ]]
	-- upvalues: v17 (copy), l_GetFarm_0 (copy)
	local playerDataAsyncUpdatePlant = dataService:GetPlayerDataAsync(playerUpdatePlant);
	if not playerDataAsyncUpdatePlant then
		return;
	else
		local farmInstance = getFarmFunction(playerUpdatePlant);
		if not farmInstance then
			return;
		else
			for _, plantedObject in playerDataAsyncUpdatePlant.PlantedObjects do
				if plantedObject[1] == plantedItem.Name and plantedObject[2] == plantedItem.Item_Seed.Value then
					local relativePosition = farmInstance.Owner_Tag.CFrame:ToObjectSpace(fruitPosition);
					local yOffset = plantedObject[3][2];
					plantedObject[3] = {
						relativePosition.X, 
						yOffset, 
						relativePosition.Z
					};
					return;
				end;
			end;
			return;
		end;
	end;
end;
dataModule.RemovePlantedObject = function(playerRemovePlant, plantedItemName, plantedItemSeed) --[[ Line: 338 ]] --[[ Name: RemovePlantedObject ]]
	-- upvalues: v17 (copy), v0 (copy)
	local playerDataAsyncRemovePlant = dataService:GetPlayerDataAsync(playerRemovePlant, 10);
	if not playerDataAsyncRemovePlant then
		return;
	else
		for plantedObjectIndex, plantedObjectRemove in playerDataAsyncRemovePlant.PlantedObjects do
			if plantedObjectRemove[1] == plantedItemName and plantedObjectRemove[2] == plantedItemSeed then
				table.remove(playerDataAsyncRemovePlant.PlantedObjects, plantedObjectIndex);
				break;
			end;
		end;
		dataModule.Save(playerRemovePlant);
		return;
	end;
end;
dataModule.SaveFruit = function(player, fruit, ancestorModel, playerData) --[[ Line: 351 ]] --[[ Name: SaveFruit ]]
	-- upvalues: v17 (copy), v9 (copy), l_HttpService_0 (copy)
	if not player then
		return warn("Data_Module.SaveFruit | Player is nil!");
	elseif not fruit then
		return warn("Data_Module.SaveFruit | Fruit is nil!");
	elseif not fruit:HasTag("PlantGenerated") then
		return;
	else
		local playerDataSaveFruit = playerData and playerData or dataService:GetPlayerDataAsync(player, 10);
		if not playerDataSaveFruit then
			return;
		else
			local fruitName = fruit.Name;
			if not fruitName or fruitName == "" then
				return warn((("Didn't save fruit %*: No Name"):format(fruit)));
			else
				local itemSeedValue = fruit:FindFirstChild("Item_Seed");
				if not itemSeedValue then
					return warn((("Didn't save fruit %*: No Item_Seed attribute"):format(fruit)));
				else
					local growFolder = fruit:FindFirstChild("Grow");
					if not growFolder then
						return warn((("Didn't save fruit %*: No Grow folder!"):format(fruit)));
					else
						local fruitAge = growFolder:FindFirstChild("Age");
						if not fruitAge then
							return warn((("Didn't save fruit %*: No Age attribute!"):format(fruit)));
						else
							local weightMultiplier = fruit:GetAttribute("WeightMulti") or 1;
							local variantFolder = fruit:FindFirstChild("Variant");
							if not variantFolder then
								return warn((("Didn't save fruit %*: No Variant attribute!"):format(fruit)));
							else
								local fruitMutationsString = mutationHandler:GetMutationsAsString(fruit) or "";
								local fruitSpawnCFrameAttribute = fruit:GetAttribute("FruitSpawnCF");
								local fruitUUID = fruit:GetAttribute("UUID");
								if not fruitUUID or fruitUUID == "" then
									fruitUUID = httpService:GenerateGUID();
									fruit:SetAttribute("UUID", fruitUUID);
								end;
								local parentPlantModel = ancestorModel and ancestorModel or fruit:FindFirstAncestorWhichIsA("Model");
								if not parentPlantModel then
									return warn((("Didn't save fruit %*: No parent plant!"):format(fruit)));
								else
									local parentPlantName = parentPlantModel.Name;
									if not parentPlantName or parentPlantName == "" then
										return warn((("Didn't save fruit %*: No parentType!"):format(fruit)));
									else
										local parentPlantSeed = parentPlantModel:FindFirstChild("Item_Seed");
										if not parentPlantSeed then
											return warn((("Didn't save fruit %*: No Item_Seed attribute!"):format(fruit)));
										else
											local fruitData = {
												ParentType = parentPlantName, 
												ParentSeed = parentPlantSeed.Value, 
												FruitType = fruitName, 
												FruitSeed = itemSeedValue.Value, 
												FruitAge = fruitAge.Value, 
												FruitWeightMulti = weightMultiplier, 
												FruitVariant = variantFolder.Value, 
												FruitMutationString = fruitMutationsString, 
												WorldCFrameString = fruitSpawnCFrameAttribute
											};
											playerDataSaveFruit.SavedFruit[fruitUUID] = fruitData;
											return fruitUUID;
										end;
									end;
								end;
							end;
						end;
					end;
				end;
			end;
		end;
	end;
end;
local farmDataMap = {};
local _ = {};
local function _(key1) --[[ Line: 420 ]] --[[ Name: GetPlantLookupTable ]]
	-- upvalues: v81 (copy)
	local cacheTable = farmDataMap[key1];
	if not cacheTable then
		cacheTable = {};
		farmDataMap[key1] = cacheTable;
	end;
	return cacheTable;
end;
local function _(key2, key3) --[[ Line: 431 ]] --[[ Name: GetPlantTypeLookupTable ]]
	-- upvalues: v81 (copy)
	local farmTypeDataMap = farmDataMap[key2];
	if not farmTypeDataMap then
		farmTypeDataMap = {};
		farmDataMap[key2] = farmTypeDataMap;
	end;
	local cachedValue = farmTypeDataMap;
	farmTypeDataMap = cachedValue[key3];
	if not farmTypeDataMap then
		farmTypeDataMap = {};
		cachedValue[key3] = farmTypeDataMap;
	end;
	return farmTypeDataMap;
end;
local _ = function(farmId, positionData, value) --[[ Line: 444 ]] --[[ Name: RegisterPlant ]]
	-- upvalues: l_GetFarm_0 (copy), v81 (copy)
	if not getFarmFunction(farmId) then
		return;
	else
		local plantTypeId = positionData[1];
		local plantSeedId = positionData[2];
		local plantTypeDataMap = farmDataMap[farmId];
		if not plantTypeDataMap then
			plantTypeDataMap = {};
			farmDataMap[farmId] = plantTypeDataMap;
		end;
		local cachedValue2 = plantTypeDataMap;
		plantTypeDataMap = cachedValue2[plantTypeId];
		if not plantTypeDataMap then
			plantTypeDataMap = {};
			cachedValue2[plantTypeId] = plantTypeDataMap;
		end;
		local _ = plantTypeDataMap;
		farmDataMap[plantSeedId] = value;
		return;
	end;
end;
local function getPlant(farmId, plantData) --[[ Line: 454 ]] --[[ Name: GetPlant ]]
	-- upvalues: l_GetFarm_0 (copy), v81 (copy)
	local farmModel = getFarmFunction(farmId);
	if not farmModel then
		return;
	else
		local plantTypeId = plantData[1];
		local plantSeedId = plantData[2];
		local plantDataMap = farmDataMap[farmId];
		if not plantDataMap then
			plantDataMap = {};
			farmDataMap[farmId] = plantDataMap;
		end;
		local plantSeedData = plantDataMap;
		plantDataMap = plantSeedData[plantTypeId];
		if not plantDataMap then
			plantDataMap = {};
			plantSeedData[plantTypeId] = plantDataMap;
		end;
		local plantTypeSeedDataMap = plantDataMap;
		plantSeedData = plantTypeSeedDataMap[plantSeedId];
		if plantSeedData then
			return plantSeedData;
		else
			for _, physicalPlantInstance in farmModel.Important.Plants_Physical:GetChildren() do
				if physicalPlantInstance.Name == plantTypeId then
					local physicalPlantSeed = physicalPlantInstance:FindFirstChild("Item_Seed");
					if plantSeedId and physicalPlantSeed.Value == plantSeedId then
						plantSeedData = physicalPlantInstance;
						plantTypeSeedDataMap[plantSeedId] = plantSeedData;
						return plantSeedData;
					end;
				end;
			end;
			return plantSeedData;
		end;
	end;
end;
dataModule.Save = function(player) --[[ Line: 481 ]] --[[ Name: Save ]]
	-- upvalues: v17 (copy), l_GetFarm_0 (copy), v111 (copy), v9 (copy), v0 (copy)
	if not player then
		return;
	elseif not player:GetAttribute("Setup_Finished") then
		return;
	else
		local playerData = dataService:GetPlayerDataAsync(player);
		if not playerData then
			return;
		else
			local partialSecond = os.clock() - math.floor((os.clock()));
			playerData.LastSaveTime = os.time() + partialSecond;
			local farm = getFarmFunction(player);
			local savedFruitMap = {};
			if not playerData.FreezeFruit and farm:GetAttribute("Loaded") then
				for savedFruitUUID, _ in playerData.SavedFruit do
					savedFruitMap[savedFruitUUID] = true;
				end;
			end;
			if farm then
				for _, plantedObjectData in playerData.PlantedObjects do
					local plantedObject = getPlant(player, plantedObjectData);
					if plantedObject then
						local growFolder = plantedObject:FindFirstChild("Grow");
						if growFolder then
							local variantValue = plantedObject:FindFirstChild("Variant");
							if variantValue then
								plantedObjectData[4] = growFolder.Age.Value;
								plantedObjectData[5] = variantValue.Value;
								plantedObjectData[6] = mutationHandler:GetMutationsAsString(plantedObject);
								plantedObjectData[7] = plantedObject:GetAttribute("WeightMulti");
								local fruitsFolder = plantedObject:FindFirstChild("Fruits");
								if fruitsFolder then
									for _, fruitInstance in fruitsFolder:GetChildren() do
										local fruitUUID = fruitInstance:GetAttribute("UUID");
										if fruitUUID then
											savedFruitMap[fruitUUID] = nil;
										end;
										fruitUUID = dataModule.SaveFruit(player, fruitInstance, plantedObject, playerData);
										if fruitUUID then
											savedFruitMap[fruitUUID] = nil;
										end;
									end;
								end;
							end;
						end;
					end;
				end;
			end;
			for fruitUuid, _ in savedFruitMap do
				local _ = playerData.SavedFruit[fruitUuid];
				playerData.SavedFruit[fruitUuid] = nil;
			end;
			if #playerData.PlantedObjects <= 0 then
				return;
			else
				playerData.LastSaveTime = DateTime.now().UnixTimestamp;
				return;
			end;
		end;
	end;
end;
task.spawn(function() --[[ Line: 549 ]]
	-- upvalues: v0 (copy)
	while true do
		task.wait(1);
		for _, player in game.Players:GetPlayers() do
			xpcall(function() --[[ Line: 553 ]]
				-- upvalues: v0 (ref), v132 (copy)
				dataModule.Save(player);
			end, warn);
		end;
	end;
end);
game.Players.PlayerRemoving:Connect(function(plantedObjectIndex) --[[ Line: 560 ]]
	-- upvalues: v81 (copy)
	farmDataMap[plantedObjectIndex] = nil;
end);
return dataModule;