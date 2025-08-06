--!native

local ServerScriptService = game:GetService("ServerScriptService");
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local GameEvents = ReplicatedStorage.GameEvents

local WeatherService = require(ServerScriptService.Modules.WeatherService)
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler)

local init = {}

local StrikeHere = ReplicatedStorage.StrikeLightningHere

function verify_plant(plant)
	if not plant:FindFirstAncestor('Plants_Physical') then
		return false;
	elseif not (plant:FindFirstChild("Grow") and plant:FindFirstChild("Weight")) then
		return false;
	elseif (plant:FindFirstChild('Fruits') or plant:FindFirstChild("Fruit_Spawn")) then
		return false;
	else
		return true;
	end;
end;

local mutations = MutationHandler.GetMutations()

function get_random_mutation(config, multi)
	for idx, val in config do 
		local random = math.random()
		if (val * (multi or 1))/100 >= random then 
			return mutations[idx]
		end
	end
	return
end

GameEvents.PlayerInit.OnServerEvent:Connect(function(player: Player, ...: any) 
	for idx, event in WeatherService:getActiveWeathers() do
		GameEvents.SendClientWeatherEvents:FireClient(player, event, event.name, event.startTime)
	end
end)

local last_upgrade_loop, last_weather_loop, last_lightningstrike, waittime, lastCheck = 0, 0, 0, 40, 0
while task.wait() do
	local server_time_now = workspace:GetServerTimeNow()
	for idx, event in WeatherService:getActiveWeathers() do 
		if (server_time_now - event.startTime) >= event.eventLength then
			WeatherService:stopWeather(event.name)
		end
	end
	local mutated_plants_in_farms = {}
	if (tick() - last_upgrade_loop) >= 10 then
		if #WeatherService:getActiveWeathers() > 0 then 
			last_upgrade_loop = tick()
			for idx, plant in workspace.Farm:GetDescendants() do 
				if not verify_plant(plant) then continue end
				
				local plants_physical = plant:FindFirstAncestor("Plants_Physical")
				local farm = plants_physical.Parent
				if table.find(mutated_plants_in_farms, farm) then continue end
				
				for idx, val in WeatherService:getActiveWeathers() do
					local random = get_random_mutation(val.mutations, plant:GetAttribute("MutationMulti"));
					if random then
						table.insert(mutated_plants_in_farms, farm)
						MutationHandler:AddMutation(plant, random)
					end
					
					if val.name == "Thunderstorm" then
						if (tick() - last_lightningstrike) >= waittime then
							local x, y, z = 
								StrikeHere.Position.X + math.random(-StrikeHere.Size.X/2, StrikeHere.Size.X/2),
								StrikeHere.Position.Y + math.random(-StrikeHere.Size.Y/2, StrikeHere.Size.Y/2),
								StrikeHere.Position.Z + math.random(-StrikeHere.Size.Z/2, StrikeHere.Size.Z/2)

							local Position = Vector3.new(x, y, z)
							local groundRaycastResult = workspace:Raycast(Position + Vector3.new(0, 200, 0), Vector3.new(0, -300, 0))
							
							local LightningRods = CollectionService:GetTagged("LightningRod")
							
							for i, lightningrod in LightningRods do
								local uuid = lightningrod:GetAttribute("ROD_ID")
								local redirected = false
								for _, obj in plants_physical.Parent.Objects_Physical:GetChildren() do
									if obj:GetAttribute("OBJECT_UUID") == uuid then
										local count =  obj:GetAttribute("Redirected") or 0
										local x, y, z = 
											obj.Position.X + math.random(-20, 20),
											obj.Position.Y + math.random(-20, 20),
											obj.Position.Z + math.random(-20, 20)
										
										obj:SetAttribute("Redirected", count + 1)
										groundRaycastResult = {Position = Vector3.new(x, obj.Position.Y, z)}
										redirected = true
										break
									end
								end
								
								if redirected then
									break
								end
							end

							local plantPos = plant:GetPivot()
							if plant.PrimaryPart then
								plantPos = plant:GetPrimaryPartCFrame()
							end
							if groundRaycastResult then
								last_lightningstrike = tick()
								waittime = math.random(40, 100)
								if (groundRaycastResult.Position - plantPos.Position).Magnitude <= 25 then
									table.insert(mutated_plants_in_farms, farm)
									MutationHandler:AddMutation(plant, {Name = "Shocked"})
								end
								
								GameEvents.LightningBolt:FireAllClients(groundRaycastResult.Position)
							end
						end
					end
				end 
			end
		end
	end
	if (tick() - last_weather_loop) >= 1500 then
		last_weather_loop = tick()
		WeatherService:startRandomWeather()
		
		ReplicatedStorage.Night_Time.Value = if math.random(1, 2) == 1 then false else true
		
		for idx, event in WeatherService:getActiveWeathers() do 
			if event.Name == "Thunderstorm" or event.Name == "Rain" then
				for _, plr in Players:GetPlayers() do
					local currBiome = plr:FindFirstChild("Current_Biome")
					if currBiome then
						currBiome.Value = "Rain_Time"
					end
				end
			end
		end
	end
	
	if (tick() - lastCheck) >= 1 then
		lastCheck = tick()
		
		if #WeatherService:getActiveWeathers() > 0 then 
			for _, plr in Players:GetPlayers() do
				local currBiome = plr:FindFirstChild("Current_Biome")
				if currBiome then
					currBiome.Value = "Day_Time"
				end
			end
		end
	end
end
