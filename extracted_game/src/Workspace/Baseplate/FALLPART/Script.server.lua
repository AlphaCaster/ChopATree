local GetFarm = require(game.ReplicatedStorage.Modules.GetFarm)
script.Parent.Touched:Connect(function(part)
	local plr = game.Players:GetPlayerFromCharacter(part.Parent) 
	if plr then
		local farm = GetFarm(plr)
		if farm then
			part.Parent:PivotTo(farm.Spawn_Point.CFrame)
		end
	end
end)