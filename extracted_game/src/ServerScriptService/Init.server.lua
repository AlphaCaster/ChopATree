--!native

--// Services
local ServerScriptService = game:GetService("ServerScriptService")
local DataStoreService 	  = game:GetService("DataStoreService")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local MarketplaceService  = game:GetService("MarketplaceService")
local ServerStorage 	  = game:GetService("ServerStorage")
local RunService		  = game:GetService("RunService")
local Workspace 		  = game:GetService("Workspace")
local Players 			  = game:GetService("Players")
local HS 				  = game:GetService("HttpService")

--// Folders
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
local S_Modules = ServerScriptService:WaitForChild("Modules")
local Modules = ReplicatedStorage:WaitForChild("Modules")

--// Modules
local Maid = require(Modules:WaitForChild("Maid"))
local Mutation = require(Modules:WaitForChild("MutationHandler"))
local PlantModule = require(ReplicatedStorage:WaitForChild("Plant_Module"))
local GetFarm = require(Modules:WaitForChild("GetFarm"))
local SessionTimeLuck = require(Modules:WaitForChild("SessionTimeLuckController"))
local SessionTimeLuckData = require(ReplicatedStorage.Data:WaitForChild("SessionTimeLuckData"))
local MutationHandler = require(Modules:WaitForChild("MutationHandler"))
local IDS = require(ReplicatedStorage:WaitForChild("PRODUCT_IDS"))

--// Data
local DataStream = GameEvents:WaitForChild("DataStream")
local DefaultData = require(ReplicatedStorage:WaitForChild("Data"):WaitForChild("DefaultData"))
local PlayerData = require(ServerStorage:WaitForChild("PlayerData"))
local Plants = require(ServerStorage.Plants)

--// Game Services
local SeedService = require(S_Modules:WaitForChild("SeedService"))
local GearService = require(S_Modules:WaitForChild("GearService"))
local FarmService = require(S_Modules:WaitForChild("FarmService"))
local ProfileService = require(S_Modules:WaitForChild("ProfileService"))
local QuestsService = require(S_Modules:WaitForChild("QuestsService"))
local Events = require(S_Modules:WaitForChild("GameEvents"))

--// Main data key
local PlayerStore = ProfileService.GetProfileStore("PlayerDataRESET", DefaultData)
local LbStore = DataStoreService:GetOrderedDataStore("Sheckles_LeaderboardRESET")
local PlantsNFruits = DataStoreService:GetDataStore("PlantsNFruitsRESET")

--// Workspace stuff
local Farms = Workspace:WaitForChild("Farm")

local PlayerMaids = {}
local DataAlreadyInit = setmetatable({}, {mode = "k"})

if RunService:IsStudio() then
	--PlayerStore = PlayerStore.Mock
end

--// Stock stuff
local Available = {}
for name, data in require(ReplicatedStorage.Data.SeedData) do
	if not ServerStorage.Collectables:FindFirstChild(name) then
		data.DisplayInShop = false
	else
		table.insert(Available, name)
	end
end

local Value = Instance.new("StringValue", ReplicatedStorage)
Value.Name = "Collectibles"
Value.Value = table.concat(Available, "|")

function GetHolding(player)
	local character = player.Character
	if not character then return end

	return character:FindFirstChildWhichIsA("Tool")
end

function GetInventory(player)
	local character = player.Character
	if not character then return end

	local items = {}

	for _, tool in player.Backpack:GetChildren() do -- boiii pairs is so 2018
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

function onDataLoaded(player)
	local profile = PlayerData[player]
	
	if profile then
		--[[if profile.Data.FirstTimeUser then
			-- set new profile
			local save = External.FetchData(player.UserId)
			if save ~= nil then
				profile = HS:JSONDecode(save)
			end
		end]]
		
		task.spawn(function()
			repeat 
				task.wait() 
			until profile:IsActive()
			player:SetAttribute("DataLoaded", true)
		end)
		
		-- leaderstats
		local leaderstats = Instance.new("Folder")
		leaderstats.Parent = player
		leaderstats.Name = "leaderstats"

		local sheckles = Instance.new("NumberValue")
		sheckles.Parent = leaderstats
		sheckles.Name = "Sheckles"
		sheckles.Value = profile.Data.Sheckles
		--other
		
		local timeNow = os.time()
		local dailyQuests = profile.Data.DailyQuests
		
		local function generateDaily()
			if dailyQuests and dailyQuests.ContainerId then
				QuestsService:RemoveQuest(player, dailyQuests.ContainerId)
			end

			local id, newQuest = QuestsService:CreateQuestContainer(player, true, "Daily", "DailyQuest")
			profile.Data.DailyQuests = {
				ContainerId = id,
				LastJoin = timeNow
			}

			GameEvents.DataStream:FireAllClients("UpdateData", (("%*_DataServiceProfile"):format(player.Name)), {
				{"ROOT/DailyQuests", profile.Data.DailyQuests},
			})
		end
		
		if dailyQuests then
			local oldJoin = timeNow - dailyQuests.LastJoin
			
			if (oldJoin / 36000) >= 24 then
				generateDaily()
			end
		else
			generateDaily()
		end
		
		if not profile.Plants or not profile.Fruits then
			profile.Plants = {}
			profile.Fruits = {}
		end

		local Farm = GetFarm(player)
		local PlantTbl = Plants[player]
		
		local _ , Data = require(ReplicatedStorage.Modules.RetryPcall)(3, 0.5, function()
			return HS:JSONDecode(PlantsNFruits:GetAsync(player.UserId.."Plants"))
		end)
		
		if not Data or typeof(Data) ~= "table" then
			Data = {}
		end
		Data.Plants = Data.Plants or {}
		Data.Fruits = Data.Fruits or {}
		
		for uuid, data in Data.Plants do
			local PlantDown = ServerStorage.Collectables[data[1]].Plant_Down.Value

			local plantedOn = data[10]
			local location = Farm.Important.Plant_Locations[plantedOn]
			local worldPos = location.CFrame:ToWorldSpace(CFrame.new( unpack(data[3]) ))

			--collectibleName, position, farmPlotInstance, playerInstance, attemptSuperVariant, seed, uuid, lastUpd, lastFruit, variant, age, plantedOn
			local inst, Plantdata = PlantModule.PlantItem(
				data[1], 
				Vector3.new(worldPos.X, 0.111, worldPos.Z),
				Farm, 
				player, 
				false, 
				data[2], 
				uuid, 
				data[8], 
				data[9],
				data[5],
				data[4],
				data[10]
			)
			
			inst:WaitForChild("Item_Seed").Value = data[2]

			local mutations = data[6]:split(", ")
			for _, mutation in mutations do
				if mutation ~= "" then
					inst:AddTag("Mutatable")
					inst:SetAttribute(mutation, true)
				end
			end
			
			if data[4] >= Plantdata.maxage then
				Plantdata:GrowFinish()
			end
		end

		for uuid, data in Data.Fruits do
			local fruit = ReplicatedStorage.Fruit_Spawn:FindFirstChild(data[1])
			local PlantHandler = require(ServerStorage.PlantHandler:FindFirstChild(data[1]).FruitHandler)
			if fruit then
				local parentInstance, parentData
				for id, _data in PlantTbl.Plants do
					if id == data[8] then
						parentInstance = _data.model
						parentData = _data
					end
				end
				
				if parentInstance and parentInstance:FindFirstChild("Fruits") and #parentInstance.Fruits:GetChildren() < parentData.maxProduction then
					local newFruit = fruit:Clone()
					newFruit:SetAttribute("Owner", player.Name)
					newFruit:PivotTo(parentInstance:GetPivot():ToWorldSpace(CFrame.new(unpack(data[3]))))
					newFruit.Parent = parentInstance.Fruits
					
					newFruit.Grow.Age.Value = data[4] or 10
					newFruit.Variant.Value = data[5] or "Normal"
					
					local mutations = data[6]:split(", ")
					for _, mutation in mutations do
						if mutation ~= "" then
							newFruit:AddTag("Mutatable")
							newFruit:SetAttribute(mutation, true)
						end
					end
					
					local plantData = PlantHandler.new(uuid, player, newFruit, math.huge, data[2], parentData.weight, parentData.uuid)
					if data[4] >= plantData.maxage then
						plantData:GrowFinish()
					end
				end
			end
		end
	else
		return player:Kick('err/3')
	end
end

Players.PlayerAdded:Connect(function(player: Player)
	local NewMaid = Maid.new()
	PlayerMaids[player] = NewMaid
	
	local Claimed = FarmService:ClaimFarm(player)
	if not Claimed then
		return player:Kick("Unable to claim farm")
	end
	
	local currBiome = Instance.new("StringValue")
	currBiome.Value = "Day_Time"
	currBiome.Name = "Current_Biome"
	currBiome.Parent = player
	player:GetAttributeChangedSignal("VIP"):Connect(function()
		local value = player:GetAttribute("VIP")
		if value then
			for i, v in Claimed:GetDescendants() do
				if v.Name == "Item_Speed_Mult" then
					v.Value *= 5
				end	
			end
			NewMaid:GiveTask(Claimed.DescendantAdded:Connect(function(descendant)
				if descendant.Name == "Item_Speed_Mult" then
					descendant.Value *= 5
				end	
			end))
		end
	end)
	player:SetAttribute("VIP", MarketplaceService:UserOwnsGamePassAsync(player.UserId, IDS.Gamepass.VIP))
	
	Plants[player] = {
		Plants = {},
		Fruits = {}
	}
	
	player:SetAttribute("SessionTime", 1)
	
	task.spawn(function()
		while player and player:IsDescendantOf(game) do
			player:SetAttribute("SessionTime", player:GetAttribute("SessionTime") + 1)
			
			local Index = 1
			for i, v in SessionTimeLuckData.Timer do
				if player:GetAttribute("SessionTime") >= v.Time then
					Index = i
				end
			end
			
			player:SetAttribute("SessionTimeLuckIndex", Index)

			local Luck = SessionTimeLuck:GetCurrentLuck(player)
			player:SetAttribute("SessionTimeLuck", Luck)
			
			task.wait(1)
		end
	end)
	
	do
		task.spawn(function()
			if not player.Character then
				player.CharacterAdded:Wait()
			end
			NewMaid:GiveTask(player.Backpack.ChildAdded:Connect(function(tool)
				task.wait()

				if not tool:IsA("Tool") then 
					return
				end

				local profile = PlayerData[player]
				if tool:FindFirstChild("Item_String") then
					local UUID = tool:GetAttribute("UUID")
					local Seed = tool:GetAttribute("Seed")

					if profile and not profile.Data.InventoryData[UUID] then
						profile.Data.InventoryData[UUID] = { 
							ItemData = {
								ItemName = tool.Item_String.Value,
								Variant = tool.Variant.Value,
								Seed = Seed,
								MutationString = MutationHandler:GetMutationsAsString(tool, false),
								Weight = tool.Weight.Value,
								ParentUUID = tool:GetAttribute("ParentUUID")
							},
							ItemType = "Holdable"
						}
					end
				end
			end))
		end)
		
		local function onChar(Character)
			local SpawnPoint = Claimed:FindFirstChild("Spawn_Point")
			if SpawnPoint then
				task.spawn(function()
					repeat 
						Character:PivotTo(SpawnPoint.CFrame)
						task.wait()
					until Character:GetPivot() == SpawnPoint.CFrame
				end)
			end

			local Prompt = script.ProximityPrompt:Clone()
			Prompt.Parent = Character:WaitForChild("HumanoidRootPart")

			NewMaid:GiveTask(Prompt.Triggered:Connect(function(Player)
				if Player == player then
					return
				end

				local Holding = GetHolding(Player)
				if Holding and Holding:FindFirstChild("Item_String") then
					local Profile = PlayerData[Player]
					if Profile then
						Profile.Data.InventoryData[Holding:GetAttribute("UUID")] = nil
					end
					Holding.Parent = player.Backpack
					GameEvents.Notification:FireClient(Player, `Gift has been sent to @{player.Name}`)
					GameEvents.Notification:FireClient(player, `You have recieved "{Holding.Name}" from @{Player.Name}`)
				end
			end))

			repeat task.wait()
			until PlayerData[player]
			local profile = PlayerData[player]
			if profile then
				repeat task.wait()
				until profile:IsActive()

				if profile.Data.InventoryData then
					for i,v in profile.Data.InventoryData do
						if v.ItemType == "Seed" then
							-- Anti duplication
							local found
							for UUID, data in profile.Data.InventoryData do
								if data.ItemType == "Seed" and UUID ~= i and data.ItemData.ItemName == v.ItemData.ItemName then
									data.ItemData.Quantity += v.ItemData.Quantity
									for _, tool in GetInventory(player) do
										if string.find(tool.Name, data.ItemData.ItemName) then
											tool.Name = data.ItemData.ItemName .. " Seed X"..data.ItemData.Quantity
											found = true
											break
										end
									end
									break
								end
							end

							if not found then 
								SeedService:CreateFromUUID(player, i, v.ItemData.ItemName)
							else
								profile.Data.InventoryData[i] = nil
							end
						elseif v.ItemType == "Holdable" then
							local isHarvest = ReplicatedStorage.Fruit_Spawn:FindFirstChild(v.ItemData.ItemName)
							local toRequire = ServerStorage.PlantHandler:FindFirstChild(v.ItemData.ItemName)
							if isHarvest then
								toRequire = toRequire.FruitHandler

								local newFruit = isHarvest:Clone()
								newFruit:SetAttribute("Owner", player.Name)
								newFruit:SetPrimaryPartCFrame(CFrame.new(0, 10000, 0))
								newFruit.Parent = workspace

								newFruit.Grow.Age.Value = math.huge
								newFruit:WaitForChild("Item_Seed").Value = v.ItemData.Seed
								
								if v.ItemData.Seed == nil then
									v.ItemData.Seed = math.random(1, 10000000)
								end

								local mutations = v.ItemData.MutationString:split(", ")
								for _, mutation in mutations do
									if mutation ~= "" then
										newFruit:AddTag("Mutatable")
										newFruit:SetAttribute(mutation, true)
									end
								end

								task.spawn(function()
									local Response = require(toRequire).new(nil, player, newFruit, math.huge, v.ItemData.Seed, 0, v.ItemData.ParentUUID, v.ItemData.Seed, v.ItemData.Weight)
									if Response then
										Response:GrowFinish()
										Response:Collect(player, i)
									else
										newFruit:Destroy()
									end
								end)

							else
								-- collectibleName, position, farmPlotInstance, playerInstance, attemptSuperVariant, seed, uuid, lastUpd, lastFruit, variant, age, plantedOn
								local inst, res = PlantModule.PlantItem(
									v.ItemData.ItemName, 
									Vector3.new(0, 10000, 0),
									GetFarm(player), 
									player, 
									false, 
									v.ItemData.Seed, 
									i, 
									0, 
									0,
									v.ItemData.Variant,
									math.huge,
									"Can_Plant1"
								)

								local mutations = v.ItemData.MutationString:split(", ")
								for _, mutation in mutations do
									if mutation ~= "" then
										inst:AddTag("Mutatable")
										inst:SetAttribute(mutation, true)
									end
								end

								if res then
									res:GrowFinish()
									res:Collect(player, i)
								else
									inst:Destroy()
								end
							end
						elseif v.ItemType == "Gear" then
							-- Anti duplication
							local found
							for UUID, data in profile.Data.InventoryData do
								if data.ItemType == "Gear" and UUID ~= i and 
									data.ItemData.ItemName ~= "Watering Can" 
										and data.ItemData.ItemName == "Trowel" and data.ItemData.ItemName == v.ItemData.ItemName then
									data.ItemData.Quantity += v.ItemData.Quantity
									for _, tool in GetInventory(player) do
										if string.find(tool.Name, data.ItemData.ItemName) then
											tool.Name = data.ItemData.ItemName .. " X"..data.ItemData.Quantity
											found = true
											break
										end
									end
									break
								end
							end

							if not found then 
								GearService:CreateFromUUID(player, i, v.ItemData.ItemName)
							else
								profile.Data.InventoryData[i] = nil
							end
						end
					end
				end
			end
		end
		NewMaid:GiveTask(player.CharacterAdded:Connect(onChar))
		if player.Character then
			task.spawn(onChar, player.Character)
		end
	end
	
	local Profile = PlayerStore:LoadProfileAsync("PLAYER_"..player.UserId)
	
	if Profile ~= nil then
		Profile:AddUserId(player.UserId)
		Profile:Reconcile()
		Profile:ListenToRelease(function()
			PlayerData[player] = nil
			player:Kick("Error occured during data loading, please try again")
		end)
		
		if player:IsDescendantOf(Players) then
			PlayerData[player] = Profile
			onDataLoaded(player)
		else
			Profile:Release()
		end
	else
		player:Kick("err/1")
	end
end)

function onLeave(player: Player)
	local PlrMaid = PlayerMaids[player]
	if PlrMaid then
		PlrMaid:DoCleaning()
	end

	local Profile = PlayerData[player]

	if Profile ~= nil then
		pcall(function()
			local PlayerPlantData = Plants[player]
			local NewSave = {
				Plants = {},
				Fruits = {}
			}
			for uuid, data in PlayerPlantData.Plants do
				local Offset = data.model:GetAttribute("PlantedOnOffset")
				NewSave.Plants[uuid] = {
					data.model.Name,
					data.seed,
					{Offset.X, Offset.Y, Offset.Z},
					data.age,
					data.model.Variant.Value,
					Mutation:GetMutationsAsString(data.model, false),
					data.model.Variance.Value,
					data.lastUpd,
					data.lastFruit,
					data.model:GetAttribute("PlantedOn")
				}
			end

			for uuid, data in PlayerPlantData.Fruits do
				local parentPlant = PlayerPlantData.Plants[data.parentUUID]
				NewSave.Fruits[uuid] = {
					data.model.Name,
					data.seed,
					{
						parentPlant.model:GetPivot():ToObjectSpace(
							data.model:GetPivot()
						):GetComponents()
					},
					data.age,
					data.model.Variant.Value,
					Mutation:GetMutationsAsString(data.model, false),
					data.model.Variance.Value,
					data.parentUUID
				}
			end

			require(ReplicatedStorage.Modules.RetryPcall)(3, 0.5, function()
				PlantsNFruits:SetAsync(player.UserId.."Plants", HS:JSONEncode(NewSave))
			end)
		end)

		pcall(function()
			LbStore:SetAsync(player.UserId, math.round(Profile.Data.Sheckles))
		end)

		Profile:Release()
	end

	--// Clear claimed farm
	for i, v in Farms:GetChildren() do
		local Owner = v:FindFirstChild("Owner", true)
		if Owner:IsA("StringValue") and Owner.Value == player.Name then
			local Important = Owner.Parent.Parent
			local Farm = Important.Parent
			Owner.Value = "None"

			local Objects_Physical = Important:FindFirstChild("Objects_Physical")
			local Plants_Physical = Important:FindFirstChild("Plants_Physical")
			local Plants_Data = Important:FindFirstChild("Plants_Data")

			if Objects_Physical or Plants_Physical or Plants_Data then
				Objects_Physical:ClearAllChildren()
				Plants_Physical:ClearAllChildren()
				Plants_Data:ClearAllChildren()
			end
			
			break
		end
	end
	
	PlayerData[player] = nil
end
Players.PlayerRemoving:Connect(onLeave)
game:BindToClose(function()
	for _, player in Players:GetPlayers() do
		onLeave(player)
	end
end)

DataStream.OnServerEvent:Connect(function(player: Player, name: string) 
	if name == "InitData" then
		if not DataAlreadyInit[player] then
			DataAlreadyInit[player] = true
			
			while not PlayerData[player] do
				task.wait()
			end
			
			DataStream:FireAllClients("InitData", (("%*_DataServiceProfile"):format(player.Name)), PlayerData[player].Data)
		else
			GameEvents.Notification:FireClient(player, "MANGO MANGO MANGO.... ERR/5")
		end
	end
end)

--// Handle signs
for i, v in Farms:GetChildren() do
	local Important = v:FindFirstChild("Important")
	if not Important then continue end
	
	local Owner = Important:WaitForChild("Data", 1):WaitForChild("Owner", 1)
	
	local Sign = v:FindFirstChild("Sign")
	local SurfaceGui = Sign and Sign:FindFirstChild("SurfaceGui", true)
	if not SurfaceGui then continue end
	
	if Owner then
		Owner.Value = "None"
		Owner.Changed:Connect(function(newValue: string)
			if newValue ~= "None" then
				local UserId = Players:GetUserIdFromNameAsync(newValue)
				if not UserId then
					UserId = 1
					newValue = "Unknown"
				end

				SurfaceGui.TextLabel.Text = newValue .. "'s Garden"
				SurfaceGui.ImageLabel.Image = Players:GetUserThumbnailAsync(UserId, Enum.ThumbnailType.HeadShot,  Enum.ThumbnailSize.Size420x420)
				SurfaceGui.ImageLabel.Visible = true
			else
				SurfaceGui.TextLabel.Text = "Empty Garden"
				SurfaceGui.ImageLabel.Visible = false
			end
		end)
	end
end

Events.SheckleUpdate:Connect(function(plr, amount)
	local leaderstats = plr:FindFirstChild("leaderstats")
	local sheckles = leaderstats and leaderstats:FindFirstChild("Sheckles")
	if not sheckles then return plr:Kick("err/4") end
	
	sheckles.Value = amount
	DataStream:FireAllClients("UpdateData", (("%*_DataServiceProfile"):format(plr.Name)), {
		{"ROOT/Sheckles", amount}
	})
end)

