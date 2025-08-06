--!native
local PlantModel = script:FindFirstAncestorOfClass("Model");

local Weight = PlantModel:WaitForChild("Weight");
local ItemSeed = PlantModel:WaitForChild("Item_Seed");
local ProximityPrompt = PlantModel:FindFirstChildWhichIsA("ProximityPrompt", true);

local CalculateWeight = require(game:GetService("ReplicatedStorage").Calculate_Weight)

local item_seed = math.random(1000000, 9999999);
local random = Random.new(item_seed);
function populate_values()
	ItemSeed.Value = item_seed;
	Weight.Value = CalculateWeight.Calculate_Weight(item_seed, PlantModel.Name)
end

populate_values()
ProximityPrompt.Enabled = false
PlantModel:ScaleTo( Weight.Value )

for i,v in PlantModel:GetChildren() do
	if not v:IsA("BasePart") then
		continue
	end
	
	v.Transparency = v:GetAttribute("OG_Transparency") or 1
end