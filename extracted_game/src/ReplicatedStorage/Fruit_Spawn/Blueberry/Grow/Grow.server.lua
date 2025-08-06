--!native
-- // Data
local PlantAge = script.Parent:WaitForChild("Age")
local PlantGrowRate = script.Parent:WaitForChild("Grow_Rate")
local PlantModel = script.Parent.Parent
local PlantWeight = PlantModel.Weight
local ServerStorage = game:GetService("ServerStorage")
local SeedGrowData = require(ServerStorage:WaitForChild("SeedGrowData"))

repeat task.wait()
until PlantWeight.Value ~= 0

local Origin = PlantModel:GetPivot()
local Multiplier = 1 -- PURPLE GUY
local OGScale = PlantWeight.Value + 0.2
local Connection = PlantAge.Changed:Connect(function(Age: number) 
	PlantModel:ScaleTo(OGScale + (Age / PlantModel:GetAttribute("MaxAge")) / 1.2)
end)

local Con; Con = script.Destroying:Connect(function()
	Con:Disconnect()
	Connection:Disconnect()
end)