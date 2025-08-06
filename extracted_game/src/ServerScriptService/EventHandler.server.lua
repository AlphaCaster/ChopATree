--!native

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local HttpService = game:GetService("HttpService")
local Debris = game:GetService("Debris")

local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")

local PlayerData = require(ServerStorage:WaitForChild("PlayerData"))

local SeedData = require(ReplicatedStorage:WaitForChild("Data"):WaitForChild("SeedData"))
local GearData = require(ReplicatedStorage:WaitForChild("Data"):WaitForChild("GearData"))

local Gears = ReplicatedStorage.Gears

local Plants = require(ServerStorage.Plants)
local Remotes = require(ReplicatedStorage.Modules.Remotes)
local EffectController = require(ReplicatedStorage.Modules.EffectController)

local SeedService = require(ServerScriptService:WaitForChild("Modules"):WaitForChild("SeedService"))
local GearService = require(ServerScriptService:WaitForChild("Modules"):WaitForChild("GearService"))
local QuestsService = require(ServerScriptService:WaitForChild("Modules"):WaitForChild("QuestsService"))
local CurrencyService = require(ServerScriptService:WaitForChild("Modules"):WaitForChild("CurrencyService"))

local PlantModule = require(ReplicatedStorage.Plant_Module)
local GetFarm = require(ReplicatedStorage.Modules.GetFarm)
local Maid = require(ReplicatedStorage.Modules.Maid)
local Blink = require(ReplicatedStorage.Blink.Blink.Server)

local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler)
local random = Random.new()

local QuestData = require(ReplicatedStorage.Data.QuestData)

local CalculateValue = require(ReplicatedStorage.Modules.CalculateToolValue)
function CalculateOverallValue(tools)
	local Total = 0
	for _, tool in tools do
		local Value = CalculateValue(tool)
		Total += Value
	end

	return Total
end

function GetInventory(player)
	local character = player.Character
	if not character then return end

	local items = {}

	for _, tool in player.Backpack:GetChildren() do
		if tool:IsA("Tool") then
			table.insert(items, tool)
		end
	end

	for _, tool in player.Character:GetChildren() do
		if tool:IsA("Tool") then
			table.insert(items, tool)
		end
	end

	return items
end

function GetHolding(player)
	local character = player.Character
	if not character then return end

	return character:FindFirstChildWhichIsA("Tool")
end

function isPointInPart(point, part)
	local p = part.CFrame:PointToObjectSpace(point)
	local s = part.Size/2
	return (p.X >= -s.X and p.X <= s.X) and (p.Y >= -1 and p.Y <= 1) and (p.Z >= -s.Z and p.Z <= s.Z)
end

function ValidateFruit(Player,Fruit)
	local Inventory = GetInventory(Player)
	if Inventory then
		for i, v in pairs(Inventory) do
			if v == Fruit then
				return true
			else
				continue
			end
		end
	end
	
	return false
end

function Collect(Player: Player, Value: {Model})
	local plants = Plants[Player]
	for idx, instance in Value do	
		local uuid = instance and instance:GetAttribute("uuid");
		--warn(instance)
		--print(uuid)
		if not uuid then 
			GameEvents.Notification:FireClient(Player, "Unknown error occured (1)")
			continue 
		end;
		--warn(uuid)

		local plant
		for i, v in plants.Fruits do
			if i == uuid then
				plant = v
			end
		end
		for i, v in plants.Plants do
			if i == uuid then
				plant = v
			end
		end

		--warn(plant)
		if plant then
			plant:Collect(Player)

			local profile = PlayerData[Player]
			if profile then
				QuestsService:CheckProgression(Player, profile.Data.DailyQuests.ContainerId, "Harvest", {instance.Name}, true, 1)
			end
		else
			continue 
		end
	end
end

EffectController:Init()

--// Blink is faster by like 10x times btw
Blink.Collect.On(Collect)
ServerScriptService.Collect.Event:Connect(Collect)

Blink.ClaimDailyQuest.On(function(Player: Player, Value: any)  
	local profile = PlayerData[Player]
	if profile then
		if profile.Data.DailyQuests then
			local container = profile.Data.DailyQuests.ContainerId
			if container then
				local Response = QuestsService:RedeemQuest(Player, container)
				if Response == "Redeemed" then
					GameEvents.Notification:FireClient(Player, "Daily Quests claimed!")
					GameEvents.DataStream:FireAllClients("UpdateData", (("%*_DataServiceProfile"):format(Player.Name)), {
						{"ROOT/QuestContainers/"..container, profile.Data.QuestContainers[container]},
					})
					GameEvents.PlaySound:FireClient(Player, "Cash Register")
				elseif Response == "Not completed" then
					GameEvents.Notification:FireClient(Player, "Daily Quests are not completed")
				elseif Response == "Already redeemed" then
					GameEvents.Notification:FireClient(Player, "Already redeemed!")
				else
					GameEvents.Notification:FireClient(Player, "Unknown error occured (3)")
				end
			else
				GameEvents.Notification:FireClient(Player, "Unknown error occured (2)")
			end
		else
			GameEvents.Notification:FireClient(Player, "Unknown error occured (1)")
		end
	end
end)

-- buy seed
GameEvents.BuySeedStock.OnServerEvent:Connect(function(player: Player, seed: string)
	local profile = PlayerData[player]
	if profile.Data.Sheckles and SeedData[seed] then
		if profile.Data.Sheckles >= SeedData[seed].Price and profile.Data.SeedStock.Stocks[seed] and profile.Data.SeedStock.Stocks[seed].Stock and profile.Data.SeedStock.Stocks[seed].Stock > 0 then
			CurrencyService:Add(player, -(SeedData[seed].Price))
			profile.Data.SeedStock.Stocks[seed].Stock -= 1
			local seedUUID = nil

			for UUID, data in profile.Data.InventoryData do
				if data.ItemType == "Seed" and data.ItemData.ItemName == seed then
					data.ItemData.Quantity += 1
					for _,v in GetInventory(player) do
						if v:GetAttribute("ItemType") == "Seed" and string.find(v.Name, seed) then
							v.Name = seed .. " Seed X"..data.ItemData.Quantity
							seedUUID = v:GetAttribute("ITEM_UUID")
							break
						end
					end
					break
				end
			end

			if not seedUUID then 
				seedUUID = SeedService:Create(player, seed) 
			end

			GameEvents.DataStream:FireAllClients("UpdateData", (("%*_DataServiceProfile"):format(player.Name)), {
				{"ROOT/SeedStock/Stocks/"..seed.."/Stock", profile.Data.SeedStock.Stocks[seed].Stock},
				{"ROOT/Inventory/"..seedUUID, profile.Data.InventoryData[seedUUID]},
				{"ROOT/Sheckles", profile.Data.Sheckles}
			})
		end
	end
end)

-- plant seed
GameEvents.Plant_RE.OnServerEvent:Connect(function(player: Player, plantPos: Vector3, seedType: string, plantedOn: string)	
	-- v12 plant name, v13 pos, v14 farm, v15 player, v16 has super
	local Farm = GetFarm(player)
	if Farm and ServerStorage.Collectables:FindFirstChild(seedType) then
		local CanPlant = false
		for _, plantLoc in Farm:FindFirstChild("Plant_Locations", true):GetChildren() do
			if isPointInPart(plantPos, plantLoc) then
				CanPlant = true
			end
		end
		
		if CanPlant then
			local Holding = GetHolding(player)
			if Holding and string.match(Holding.Name, seedType) then
				for UUID, data in PlayerData[player]["Data"]["InventoryData"] do
					if data.ItemType == "Seed" and data.ItemData.ItemName == seedType then
						data.ItemData.Quantity -= 1
						Holding.Name = seedType .. " Seed X"..data.ItemData.Quantity
						PlantModule.PlantItem(seedType, Vector3.new(plantPos.X, 0.111, plantPos.Z), Farm, player, false, nil, nil, nil, nil, nil, nil, plantedOn)
						
						if data.ItemData.Quantity <= 0 then
							Holding:Destroy()
							data.ItemData.Quantity = 0
							PlayerData[player]["Data"]["InventoryData"][Holding:GetAttribute("ITEM_UUID")] = nil
						end
						break
					end
				end
			end
		else
			GameEvents.Notification:FireClient(player, "vro just play normally")
		end
	end
end)

GameEvents.Remove_Item.OnServerEvent:Connect(function(player, inst)
	local plantModel = typeof(inst) == "Model" and inst or inst:FindFirstAncestorOfClass("Model")
	local farm = GetFarm(player)
	if farm and plantModel and plantModel:IsDescendantOf(farm) and plantModel:HasTag("PlantGenerated") then
		plantModel:Destroy()
	else
		if plantModel and not plantModel:IsDescendantOf(farm) then
			GameEvents.Notification:FireClient(player, "Cannot remove other people's plant")
		end
	end
end)

--// Sell
GameEvents.Sell_Item.OnServerEvent:Connect(function(player)
	local Item = GetHolding(player)
	local PlayerData = PlayerData[player]
	if Item and PlayerData then
		local Total = CalculateOverallValue({ Item })
		if Total ~= 0 and Item:FindFirstChild("Item_String") then
			if player:GetAttribute("VIP") then
				Total = Total * 2
				GameEvents.Notification:FireClient(player, "Due to your VIP Status, your plants total value got multiplied by 2")
			end
			
			CurrencyService:Add(player, Total)
			Item:Destroy()
			PlayerData.Data.InventoryData[Item:GetAttribute("UUID")] = nil
		end
	end
end)

GameEvents.Sell_Inventory.OnServerEvent:Connect(function(player)
	local Inventory = GetInventory(player)
	local PlayerData = PlayerData[player]
	if Inventory and PlayerData then
		local Total = CalculateOverallValue(Inventory)
		if Total ~= 0 then
			if player:GetAttribute("VIP") then
				Total = Total * 2
				GameEvents.Notification:FireClient(player, "Due to your VIP Status, your plants total value got multiplied by 2")
			end
			
			for index, tool in Inventory do
				if not tool:FindFirstChild("Item_String") then
					table.remove(Inventory, index)
				end
			end
			
			CurrencyService:Add(player, Total)
			
			for _, tool in Inventory do
				if tool:FindFirstChild("Item_String") then
					tool:Destroy()
					PlayerData.Data.InventoryData[tool:GetAttribute("UUID")] = nil
				end
			end
		end
	end
end)

function MakeBetterOdds(Option, Chosen)
	if Option == "Common" then
		if Chosen == "Common" then return true end
		if Chosen == "Uncommon" then
			local retry = math.random(1,2)
			if retry == 1 then return true end
		end
		return false
	elseif Option == "Uncommon" then
		if Chosen == "Uncommon" then return true end
		if Chosen == "Common" then
			local retry = math.random(1,3)
			if retry == 1 then return true end
		end
		return false
	elseif Option == Chosen then
		return true
	end
	return false
end

GameEvents.SeedPackGiverEvent.OnServerEvent:Connect(function(Player, Action)
	if Action == "DiscoverSeedPackGiver" then
		
	elseif Action == "SubmitHeldPlant" then
		
	else
		return Player:Kick("Bro tryna rollback")
	end
end)

local SprinklerMap = {
	["Basic Sprinkler"] = {
		SpeedMultiplier = 1.5,
		SizeMulti = 1.1,
		MutationChance = 1,
		Range = 20,
		Time = 60 * 5
	},
	["Advanced Sprinkler"] = {
		SpeedMultiplier = 2,
		SizeMulti = 1.25,
		MutationChance = 1.1,
		Range = 25,
		Time = 60 * 5
	},
	["Godly Sprinkler"] = {
		SpeedMultiplier = 2.5,
		SizeMulti = 1.5,
		MutationChance = 1.3,
		Range = 30,
		Time = 60 * 5
	},
	["Master Sprinkler"] = {
		SpeedMultiplier = 3,
		SizeMulti = 2,
		MutationChance = 1.5,
		Range = 60,
		Time = 60 * 10
	},
	["Chocolate Sprinkler"] = {
		SpeedMultiplier = 1,
		SizeMulti = 1,
		MutationChance = 1,
		Range = 60,
		Time = 60 * 1
	},
}
GameEvents.Sprinkler_RE.OnServerEvent:Connect(function(Player, Sprinkler, CF)
	local profile = PlayerData[Player]
	if profile and Sprinkler and CF then
		local Inventory = GetInventory(Player)
		local Farm = GetFarm(Player)
		local SprinklerName = Sprinkler:GetAttribute("ItemName")
		if Farm and SprinklerMap[SprinklerName] and table.find(Inventory, Sprinkler) then
			local CanPlant = false

			for _, plantLoc in Farm:FindFirstChild("Plant_Locations", true):GetChildren() do
				if isPointInPart(CF.Position, plantLoc) then
					CanPlant = true
					break
				end
			end

			if CanPlant then
				local ID = HttpService:GenerateGUID(true)
				local SprinklerData = SprinklerMap[SprinklerName]
				
				local ObjectMaid = Maid.new()
				local PhysicalObject = Instance.new("Part")
				PhysicalObject.Anchored = true
				PhysicalObject.CanCollide = false
				PhysicalObject.Size = Vector3.one
				PhysicalObject.Transparency = 1
				PhysicalObject.CFrame = CFrame.new(Vector3.new(CF.Position.X, 0.111, CF.Position.Z)) * CFrame.Angles(0,0, math.rad(180))
				PhysicalObject.Parent = Farm:FindFirstChild("Objects_Physical", true)
				
				PhysicalObject:SetAttribute("OBJECT_UUID", ID)
				PhysicalObject:SetAttribute("OBJECT_NAME", SprinklerName)
				PhysicalObject:SetAttribute("OBJECT_TYPE", "Sprinkler")
				PhysicalObject:SetAttribute("CASTER_NAME", Player.Name)
				PhysicalObject:SetAttribute("Lifetime", SprinklerData.Time)
				
				GameEvents.EffectRequest:FireAllClients({
					caster = Player,
					name_State = "SprinklerHandler/Create",
					parameters = {
						ID = ID,
						SprinklerCFrame = PhysicalObject.CFrame,
						SprinklerType = SprinklerName,
						
						EndTime = SprinklerData.Time,
						
						OBJECT_UUID = ID,
						OWNER = Player.Name
					}
				})
				
				Debris:AddItem(PhysicalObject, PhysicalObject:GetAttribute("Lifetime"))
				
				ObjectMaid:GiveTask(Farm.Important.Plants_Physical.DescendantAdded:Connect(function(NewPlant)
					local Model: Model = NewPlant:FindFirstAncestorOfClass("Model")
					if Model then
						local Pivot = Model:GetPivot()
						local Name = SprinklerName:gsub(" ", "")
						if Model.PrimaryPart then
							Pivot = Model:GetPrimaryPartCFrame()
						end
						if not Model:GetAttribute("AffectedBy"..Name) and (Pivot.Position - PhysicalObject.Position).Magnitude <= SprinklerData.Range then
							if ReplicatedStorage.Fruit_Spawn:FindFirstChild(Model.Name) then
								Model:SetAttribute("WeightMulti", SprinklerData.SizeMulti)
								Model:SetAttribute("MutationMulti", SprinklerData.MutationChance)
								Model:SetAttribute("AffectedBy"..Name, true)
								if Model:FindFirstAncestor("Fruits") and SprinklerName == "Chocolate Sprinkler" then
									Model:AddTag("Mutatable")
									Model:SetAttribute("Choc", true)
								end

								local plantGrow = Model:FindFirstChild("Grow_Rate", true)
								if plantGrow then
									plantGrow.Value = plantGrow.Value * SprinklerData.SpeedMultiplier
								end
							else
								if SprinklerName == "Chocolate Sprinkler" and (Pivot.Position - PhysicalObject.Position).Magnitude <= 20 then
									Model:AddTag("Mutatable")
									Model:SetAttribute("Choc", true)
								end
							end
						end
					end
				end))
				
				ObjectMaid:GiveTask(PhysicalObject.Destroying:Connect(function()
					ObjectMaid:DoCleaning()
				end))
				
				task.spawn(function()
					while PhysicalObject and PhysicalObject:IsDescendantOf(game) do
						task.wait(1)
						if PhysicalObject and PhysicalObject:IsDescendantOf(game) then
							PhysicalObject:SetAttribute("Lifetime", PhysicalObject:GetAttribute("Lifetime") - 1)
						end
					end
				end)
				
				for UUID, data in profile.Data.InventoryData do
					if data.ItemType == "Gear" and data.ItemData.ItemName == SprinklerName then
						data.ItemData.Quantity -= 1
						for _,v in GetInventory(Player) do
							if v:GetAttribute("ItemType") == "Gear" and string.find(v.Name, SprinklerName) then
								v.Name = SprinklerName .. " X"..data.ItemData.Quantity
								break
							end
						end
						
						if data.ItemData.Quantity <= 0 then
							data.ItemData.Quantity = 0
							profile["Data"]["InventoryData"][Sprinkler:GetAttribute("ITEM_UUID")] = nil
							
							Sprinkler:Destroy()
						end
						break
					end
				end
			end
		end
	end
end)

GameEvents.LightningRodService.OnServerEvent:Connect(function(Player, Action, ...)
	local args = {...}
	local profile = PlayerData[Player]
	if profile and Action == "Create" then
		local CF = args[1]
		local Holding = GetHolding(Player)
		
		local Farm
		local CanPlant = false

		for i, farm in workspace.Farm:GetChildren() do
			for _, plantLoc in farm:FindFirstChild("Plant_Locations", true):GetChildren() do
				if isPointInPart(CF.Position, plantLoc) then
					CanPlant = true
					Farm = farm
					break
				end
			end
		end
		
		if Holding and Holding.Name:find("Lightning Rod") and CanPlant and Farm then
			local ItemName = Holding:GetAttribute("ItemName")
			if ItemName then
				local ID = HttpService:GenerateGUID(true)

				local ObjectMaid = Maid.new()
				local PhysicalObject = Instance.new("Part")
				PhysicalObject.Anchored = true
				PhysicalObject.CanCollide = false
				PhysicalObject.Size = Vector3.one
				PhysicalObject.Transparency = 1
				PhysicalObject.CFrame = CFrame.new(Vector3.new(CF.Position.X, 0.111, CF.Position.Z))
				PhysicalObject.Parent = Farm:FindFirstChild("Objects_Physical", true)

				PhysicalObject:SetAttribute("OBJECT_UUID", ID)
				PhysicalObject:SetAttribute("OBJECT_NAME", ItemName)
				PhysicalObject:SetAttribute("OBJECT_TYPE", "Lightning Rod")
				PhysicalObject:SetAttribute("CASTER_NAME", Player.Name)
				PhysicalObject:SetAttribute("Redirected", 0)
				
				EffectController:Play({
					caster = Player,
					name_State = "LightningRodHandler/Create",
					parameters = {
						ID = ID,
						
						LightningRodType = "Lightning Rod",
						LightningRodCFrame = PhysicalObject.CFrame
					}
				})
				
				ObjectMaid:GiveTask(PhysicalObject:GetAttributeChangedSignal("Redirected"):Connect(function()
					local Count = PhysicalObject:GetAttribute("Redirected")
					if Count >= 3 then
						EffectController.Play(EffectController, {
							caster = Player,
							name_State = "LightningRodHandler/Destroy",
							parameters = {
								ID = ID,

								LightningRodType = "Lightning Rod",
								LightningRodCFrame = PhysicalObject.CFrame
							}
						})
						
						PhysicalObject:Destroy()
					end
				end))
				
				ObjectMaid:GiveTask(PhysicalObject.Destroying:Connect(function()
					ObjectMaid:DoCleaning()
				end))
				
				for UUID, data in profile.Data.InventoryData do
					if data.ItemType == "Gear" and data.ItemData.ItemName == ItemName then
						data.ItemData.Quantity -= 1
						for _,v in GetInventory(Player) do
							if v:GetAttribute("ItemType") == "Gear" and string.find(v.Name, ItemName) then
								v.Name = ItemName .. " X"..data.ItemData.Quantity
								break
							end
						end

						if data.ItemData.Quantity <= 0 then
							data.ItemData.Quantity = 0
							profile["Data"]["InventoryData"][Holding:GetAttribute("ITEM_UUID")] = nil

							Holding:Destroy()
						end
						break
					end
				end
			end
		end
	end
end)

GameEvents.Water_RE.OnServerEvent:Connect(function(Player, Plant)
	local profile = PlayerData[Player]
	local plantModel = typeof(Plant) == "Model" and Plant or Plant:FindFirstAncestorOfClass("Model")
	local farm = GetFarm(Player)
	local Holding = GetHolding(Player)
	if Holding and Holding.Name == "Watering Can X1" and farm and plantModel and plantModel:IsDescendantOf(farm) and plantModel:HasTag("PlantGenerated") then
		local plantGrow = plantModel:FindFirstChild("Grow_Rate", true)
		if plantGrow and Holding:GetAttribute("UsesLeft") > 0 then
			plantGrow.Value = plantGrow.Value * 1.5
			
			Holding:SetAttribute("UsesLeft", Holding:GetAttribute("UsesLeft") - 1)
			
			for UUID, data in profile.Data.InventoryData do
				if data.ItemType == "Gear" and UUID == Holding:GetAttribute("ITEM_UUID") and data.ItemData.ItemName == "Watering Can" then
					data.ItemData.UsesLeft -= 1
					if data.ItemData.UsesLeft <= 0 then
						data.ItemData.UsesLeft = 0
						profile["Data"]["InventoryData"][Holding:GetAttribute("ITEM_UUID")] = nil

						Holding:Destroy()
					end
					break
				end
			end
			
			if Holding:GetAttribute("UsesLeft") <= 0 then
				GameEvents.Notification:FireClient(Player, "Your Watering Can has been destroyed!")
				GameEvents.PlaySound:FireClient(Player, "Break")
			else
				GameEvents.Notification:FireClient(Player, `Watered {plantModel.Name}!`)
				GameEvents.PlaySound:FireClient(Player, "Water")
			end
		else
			GameEvents.Notification:FireClient(Player, "Unknown error occured")
			GameEvents.PlaySound:FireClient(Player, "Error")
		end
	end
end)

local GearMap = {
	["Watering Can"] = 10,
	["Trowel"] = 5
}
GameEvents.BuyGearStock.OnServerEvent:Connect(function(player, gear) 
	local profile = PlayerData[player]
	local UUID = game:GetService("HttpService"):GenerateGUID(true)
	
	if profile.Data.Sheckles and GearData[gear] then
		if profile.Data.Sheckles >= GearData[gear].Price and profile.Data.GearStock.Stocks[gear] and profile.Data.GearStock.Stocks[gear].Stock and profile.Data.GearStock.Stocks[gear].Stock > 0 then
			local GearUUID
			if gear:match("Sprinkler") or gear:match("Lightning Rod") then
				for UUID, data in profile.Data.InventoryData do
					if data.ItemType == "Gear" and data.ItemData.ItemName == gear then
						data.ItemData.Quantity += 1
						for _,v in GetInventory(player) do
							if v:GetAttribute("ItemType") == "Gear" and string.find(v.Name, gear) then
								v.Name = gear .. " X"..data.ItemData.Quantity
								GearUUID = v:GetAttribute("ITEM_UUID")
								break
							end
						end
						break
					end
				end

				if not GearUUID then 
					GearUUID = GearService:Create(player, gear, GearMap[gear] or 1, 1)
				end
			else
				GearUUID = GearService:Create(player, gear, GearMap[gear] or 1, 1)
			end
			
			CurrencyService:Add(player, -GearData[gear].Price)
			profile.Data.GearStock.Stocks[gear].Stock -= 1
			
			GameEvents.DataStream:FireAllClients("UpdateData", (("%*_DataServiceProfile"):format(player.Name)), {
				{"ROOT/GearStock/Stocks/"..gear.."/Stock", profile.Data.GearStock.Stocks[gear].Stock},
				{"ROOT/Inventory/"..GearUUID, profile.Data.InventoryData[GearUUID]},
				{"ROOT/Sheckles", profile.Data.Sheckles}
			})
		end
	end
end)