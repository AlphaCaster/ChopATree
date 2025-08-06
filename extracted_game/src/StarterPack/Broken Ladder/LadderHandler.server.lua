local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Tool = script.Parent

local Placed = false
local CurrentLadder
local Ladder = ServerStorage:WaitForChild("Ladder")
local GetFarm  = require(game.ReplicatedStorage.Modules.GetFarm)
local PlaySound = ReplicatedStorage.GameEvents.PlaySound

local Model = Ladder:Clone()
for i, v in Model:GetChildren() do
	v.Massless = true
	v.CanCollide = false
end

Tool.PrimaryPart = Model.PrimaryPart
Model.PrimaryPart.Parent = Tool
Model.Parent = Tool

Tool.Activated:Connect(function()
	local Player = Players:GetPlayerFromCharacter(Tool.Parent)
	if Player then
		local ourFarm = GetFarm(Player)

		if ourFarm and ourFarm:FindFirstChild("Objects_Physical", true) then
			Placed = not Placed

			if Placed then
				PlaySound:FireClient(Player, "PlaceLadder")
				local newLadder = Ladder:Clone()
				CurrentLadder = newLadder

				newLadder:SetPrimaryPartCFrame(Tool:GetPrimaryPartCFrame())
				newLadder.Parent = ourFarm:FindFirstChild("Objects_Physical", true)

				for i, v in Model:GetChildren() do
					if v.Name ~= "Handle" then
						v.Transparency = 1
					end
				end
			else
				if CurrentLadder then
					CurrentLadder:Destroy()
				end

				for i, v in Model:GetChildren() do
					if v.Name ~= "Handle" then
						v.Transparency = 0
					end
				end
			end
		end
	end
end)

script.AncestryChanged:Connect(function(child, parent)
	if (child == Tool or child == script) and parent == nil then
		if CurrentLadder then
			CurrentLadder:Destroy()
		end
	end
end)