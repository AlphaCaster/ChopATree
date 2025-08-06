local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameEvents = ReplicatedStorage.GameEvents

local Weathers = {
	{
		name = "Rain",
		eventLength = 300,
		attribute = "RainEvent",
		mutations = {["Wet"] = 10}
	},
	{
		name = "Frost",
		eventLength = 300,
		attribute = "FrostEvent",
		mutations = {["Frozen"] = 5, ["Chilled"] = 15}
	},
	{
		name = "Thunderstorm",
		eventLength = 300,
		attribute = "Thunderstorm",
		mutations = {["Wet"] = 10}
	},
}

local WeatherService = { activeEvents = {} }
local this = WeatherService

function WeatherService:getRandomWeather()
	return table.clone(Weathers[math.random(1, #Weathers)])
end

function WeatherService:stopWeather(name)
	for idx, val in this.activeEvents do 
		if val.Name == name then
			table.remove(this.activeEvents, idx)
			GameEvents.SendClientWeatherEvents:FireAllClients(val, val.name, val.startTime)
		end
	end 
end

function WeatherService:startRandomWeather()
	local chosen_weather = this:getRandomWeather()
	
	local name = chosen_weather.name
	local attribute = chosen_weather.attribute
	local eventLength = chosen_weather.eventLength
	local startTime = workspace:GetServerTimeNow()
	chosen_weather.startTime = startTime
	
	local found_event = false
	for idx, val in this.activeEvents do 
		if val.Name == name then
			found_event = true
			val.eventLength += eventLength
		end
	end 
	if not found_event then
		table.insert(this.activeEvents, chosen_weather)
	end
	
	workspace:SetAttribute(attribute, true)
	GameEvents.WeatherEventStarted:FireAllClients(name, eventLength)
end


function WeatherService:getActiveWeathers()
	return this.activeEvents
end

return WeatherService