--!native

local GrowRate = script.Parent.Parent:WaitForChild("Grow_Rate")
local ItemSpeedMult = script.Parent.Parent:WaitForChild("Item_Speed_Mult")
local Plant = script:FindFirstAncestorOfClass("Model");
local GrowTickTime = Plant:GetAttribute("GrowTickTime");
local GrowRateMulti = Plant:GetAttribute("GrowRateMulti")

local MaxAge = Plant:GetAttribute("MaxAge")

local RunService = game:GetService("RunService")
while true do
	local newValue = math.clamp(script.Parent.Value + GrowRate.Value * ItemSpeedMult.Value, 0, MaxAge)

	script.Parent.Value = newValue
	if script.Parent.Value == MaxAge then
		Plant:FindFirstChildWhichIsA("ProximityPrompt", true).Enabled = true
		break
	end

	task.wait(Random.new():NextNumber(GrowTickTime.Min, GrowTickTime.Max) * GrowRateMulti)
end