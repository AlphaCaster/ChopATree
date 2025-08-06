local Farm = workspace.Farm

local effect = require(game.ReplicatedStorage.Modules.EffectController)

for i, v in Farm:GetDescendants() do
	if v:FindFirstAncestor("Objects_Physical") then
		if v:GetAttribute("OBJECT_TYPE") == "Sprinkler" then
			effect:Play({
				caster = game.Players.LocalPlayer,
				name_State = "SprinklerHandler/Create",
				parameters = {
					ID = v:GetAttribute("OBJECT_UUID"), 
					SprinklerCFrame = v.CFrame,
					SprinklerType = v:GetAttribute("OBJECT_NAME"),

					EndTime = v:GetAttribute("LifeTime"),

					OBJECT_UUID = v:GetAttribute("OBJECT_UUID"),
					OWNER = v:GetAttribute("CASTER_NAME")
				}
			})
		end
	end
end