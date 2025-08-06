local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerData = require(ServerStorage:WaitForChild("PlayerData"))
local QuestsService = require(script.Parent.QuestsService)

local GameEvents = require(script.Parent.GameEvents)

local CurrencyService = {
	Add = function(self, player, amount)
		local Data = PlayerData[player].Data
		Data.Sheckles += amount
		GameEvents.SheckleUpdate:Fire(player, Data.Sheckles)
		
		local profile = PlayerData[player]
		if profile and amount > 0 then
			QuestsService:CheckProgression(player, profile.Data.DailyQuests.ContainerId, "EarnSheckles", nil, true, math.clamp(amount, 0, 25_000))
		end
	end,
}

return CurrencyService
