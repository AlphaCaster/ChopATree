--!native

local Plant_Module = {}

local TweenService = game:GetService("TweenService")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local SHORT_TWEEN_INFO = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
local LONG_TWEEN_INFO = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)

local PlaySoundEvent = ReplicatedStorage.GameEvents.PlaySound
local DataModule = require(ReplicatedStorage.Data_Module)
local ItemModule = require(ReplicatedStorage.Item_Module)
local QuestsServiceModule = require(ServerScriptService.Modules.QuestsService)
local PlayerLuckModule = require(ReplicatedStorage.Modules.PlayerLuck)
local PlantScriptsContainer = game.ServerStorage.PlantHandler
local QuestsService = require(game.ServerScriptService.Modules.QuestsService)
local PlayerData = require(game.ServerStorage.PlayerData)

Plant_Module.PlantItem = function(collectibleName, position, farmPlotInstance, playerInstance, attemptSuperVariant, seed, uuid, lastUpd, lastFruit, variant, age, plantedOn)
	local plantScriptInstance = PlantScriptsContainer:FindFirstChild(collectibleName)
	if not plantScriptInstance then
		return
	end

	local PlantConstructor = require(plantScriptInstance)

	if attemptSuperVariant then
		local plantSeed = seed or Random.new():NextInteger(1, 10000000)
		local collectibleTemplate = game.ServerStorage.Collectables[collectibleName]
		local newPlantInstance = collectibleTemplate:Clone()

		math.randomseed(newPlantInstance.Item_Seed.Value)
		newPlantInstance.Variant.Value = variant or ItemModule.Return_Random_Super_Rarity()
		newPlantInstance.Grow.Age.Value = age or 0
		newPlantInstance.Grow.Grow_Rate.Value *= 0.75
		newPlantInstance.Item_Seed.Value = plantSeed
		collectibleTemplate.Item_Seed.Value = plantSeed 
		newPlantInstance:AddTag(newPlantInstance.Name)

		local basePlantCFrame = CFrame.new(position - Vector3.new(0, newPlantInstance.Plant_Down.Value, 0))
		local yRotationDegrees = Random.new(seed):NextNumber(-180, 180)
		local finalPlantCFrame = basePlantCFrame * CFrame.Angles(0, math.rad(yRotationDegrees), 0)

		local obj = farmPlotInstance.Important.Plant_Locations:FindFirstChild(plantedOn)
		newPlantInstance:PivotTo(finalPlantCFrame)
		newPlantInstance:SetAttribute("Owner", playerInstance.Name)
		newPlantInstance:SetAttribute("PlantedOn", plantedOn)
		newPlantInstance:SetAttribute("PlantedOnOffset", obj.CFrame:ToObjectSpace(finalPlantCFrame))
		newPlantInstance.Parent = farmPlotInstance.Important.Plants_Physical

		local dirtEffectInstance = ReplicatedStorage.Dirt:Clone()
		dirtEffectInstance.Parent = workspace.Dirt_VFX
		dirtEffectInstance.Position = position - Vector3.new(0, 0.01, 0)
		dirtEffectInstance.Orientation = dirtEffectInstance.Orientation + Vector3.new(0, math.random(-180, 180), 0)
		dirtEffectInstance.Size = Vector3.new(0.1, 1, 1)
		dirtEffectInstance.Transparency = 1
		
		if uuid then
			dirtEffectInstance.Size = ReplicatedStorage
		else
			PlaySoundEvent:FireClient(playerInstance, "Plant_SFX")
			
			local profile = PlayerData[playerInstance]
			if profile then
				QuestsService:CheckProgression(playerInstance, profile.Data.DailyQuests.ContainerId, "Plant", {newPlantInstance.Name}, true, 1)
			end
		end

		TweenService:Create(dirtEffectInstance, SHORT_TWEEN_INFO, {
			Size = Vector3.new(0.1, 2, 2),
			Transparency = 0
		}):Play()

		task.spawn(function()
			task.wait(math.random(7, 11))
			TweenService:Create(dirtEffectInstance, LONG_TWEEN_INFO, {
				Size = Vector3.new(0.1, 1.75, 1.75),
				Transparency = 1
			}):Play()
			Debris:AddItem(dirtEffectInstance, LONG_TWEEN_INFO.Time)
		end)
		
		newPlantInstance:AddTag("PlantGenerated")
		return newPlantInstance, PlantConstructor.new(uuid, position, playerInstance, newPlantInstance, lastUpd, lastFruit)

		-- DataModule.AddPlantedObject(playerInstance, collectibleName, newPlantInstance.Variant.Value, newPlantInstance.Item_Seed.Value, "UnknownProperty?", farmPlotInstance.Owner_Tag.CFrame)
		-- QuestsServiceModule:Progress(playerInstance, "Plant", 1, { collectibleName })
	else
		local plantSeed = seed or Random.new():NextInteger(1, 10000000)
		local collectibleTemplate = game.ServerStorage.Collectables[collectibleName]
		local newPlantInstance = collectibleTemplate:Clone()

		math.randomseed(newPlantInstance.Item_Seed.Value)
		if ReplicatedStorage.Fruit_Spawn:FindFirstChild(newPlantInstance.Name) then
			newPlantInstance.Variant.Value = "Normal"
		else
			newPlantInstance.Variant.Value = ItemModule.Return_Random_Rarity(PlayerLuckModule.GetLuck(playerInstance, newPlantInstance, "Plant"))
		end
		newPlantInstance.Variant.Value = variant or newPlantInstance.Variant.Value

		newPlantInstance.Grow.Age.Value = age or 0
		newPlantInstance.Grow.Grow_Rate.Value *= 0.75
		newPlantInstance.Item_Seed.Value = plantSeed
		collectibleTemplate.Item_Seed.Value = plantSeed

		local plantDownOffset = newPlantInstance.Plant_Down.Value
		local randomYRotationRadians = math.rad(Random.new(seed):NextNumber(-180, 180))
		local finalPlantCFrame = CFrame.new(position - Vector3.new(0, plantDownOffset, 0)) * CFrame.Angles(0, randomYRotationRadians, 0)

		local obj = farmPlotInstance.Important.Plant_Locations:FindFirstChild(plantedOn)
		newPlantInstance:PivotTo(finalPlantCFrame)
		newPlantInstance:SetAttribute("Owner", playerInstance.Name)
		newPlantInstance:SetAttribute("PlantedOn", plantedOn)
		newPlantInstance:SetAttribute("PlantedOnOffset", obj.CFrame:ToObjectSpace(finalPlantCFrame))
		newPlantInstance.Parent = farmPlotInstance.Important.Plants_Physical

		local dirtEffectInstance = ReplicatedStorage.Dirt:Clone()
		dirtEffectInstance.Parent = workspace.Dirt_VFX
		dirtEffectInstance.Position = position - Vector3.new(0, 0.01, 0)
		dirtEffectInstance.Orientation = dirtEffectInstance.Orientation + Vector3.new(0, math.random(-180, 180), 0)
		dirtEffectInstance.Size = Vector3.new(0.1, 1, 1)
		dirtEffectInstance.Transparency = 1
		
		if uuid then
			dirtEffectInstance.Parent = ReplicatedStorage
		else
			PlaySoundEvent:FireClient(playerInstance, "Plant_SFX")
			
			local profile = PlayerData[playerInstance]
			if profile then
				QuestsService:CheckProgression(playerInstance, profile.Data.DailyQuests.ContainerId, "Plant", {newPlantInstance.Name}, true, 1)
			end
		end

		TweenService:Create(dirtEffectInstance, SHORT_TWEEN_INFO, {
			Size = Vector3.new(0.1, 2, 2),
			Transparency = 0
		}):Play()

		task.spawn(function()
			task.wait(math.random(7, 11))
			TweenService:Create(dirtEffectInstance, LONG_TWEEN_INFO, {
				Size = Vector3.new(0.1, 1.75, 1.75),
				Transparency = 1
			}):Play()
			Debris:AddItem(dirtEffectInstance, LONG_TWEEN_INFO.Time)
		end)
		
		newPlantInstance:AddTag("PlantGenerated")
		return newPlantInstance, PlantConstructor.new(uuid, position, playerInstance, newPlantInstance, lastUpd, lastFruit)

		-- DataModule.AddPlantedObject(playerInstance, collectibleName, newPlantInstance.Variant.Value, newPlantInstance.Item_Seed.Value, "UnknownProperty?", farmPlotInstance.Owner_Tag.CFrame)
		-- QuestsServiceModule:Progress(playerInstance, "Plant", 1, { collectibleName })
	end
end

return Plant_Module