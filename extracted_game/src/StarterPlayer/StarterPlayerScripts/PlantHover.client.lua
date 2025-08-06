local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local CreateTagArray = require(Modules:WaitForChild("CreateTagArray"))
local GetMouseToWorld = require(Modules:WaitForChild("GetMouseToWorld"))

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local PlantHoverUI = PlayerGui:WaitForChild("PlantHover_UI")
local Frame = PlantHoverUI:WaitForChild("Frame")
local PlantName = Frame:WaitForChild("PlantName")
local PlantInfo = Frame:WaitForChild("PlantInfo")

local function getGrownPercentage(model)
	local totalParts = 0
	local grownParts = 0
	for _, part in model:GetChildren() do
		if part:IsA("BasePart") and not part:IsA("TrussPart") and tonumber(part.Name) then
			totalParts += 1
			if part:GetAttribute("DoneGrowing") then
				grownParts += 1
			end
		end
	end
	return grownParts / totalParts
end

local currentModel = nil
local displayedPercentage = 0
local hoverableTags = CreateTagArray("Hoverable")

local function updateHoverUI(deltaTime)
	local mouseLocation = UserInputService:GetMouseLocation()

	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = hoverableTags
	raycastParams.FilterType = Enum.RaycastFilterType.Include

	local raycastResult = GetMouseToWorld(raycastParams)
	local hitInstance = raycastResult and raycastResult.Instance

	if hitInstance and (hitInstance:FindFirstAncestor("Fruits") or not hitInstance:GetAttribute("DoneGrowing")) then
		hitInstance = nil
		raycastResult = nil
	end

	Frame.Visible = false
	Frame.Show_Val.Value = false
	PlantHoverUI.Frame.Position = UDim2.new(0.01, mouseLocation.X, 0, mouseLocation.Y)

	if not raycastResult or not hitInstance then
		return
	end

	local model = hitInstance:FindFirstAncestorWhichIsA("Model")
	local maxAge = model:GetAttribute("MaxAge")
	local ageValue = model.Grow and model.Grow:FindFirstChild("Age")

	if not maxAge or not ageValue then
		return
	end

	if model ~= currentModel then
		currentModel = model
		displayedPercentage = maxAge > 0 and math.clamp(ageValue.Value / maxAge * 100, 0, 100) or 0
	end

	local targetPercentage = math.clamp(ageValue.Value / maxAge * 100, 0, 100)
	displayedPercentage += (targetPercentage - displayedPercentage) * math.clamp(deltaTime * 10, 0, 1)

	if displayedPercentage ~= displayedPercentage or math.abs(displayedPercentage) >= 1e999 then
		displayedPercentage = 0
	end

	Frame.Visible = true
	Frame.Show_Val.Value = true
	PlantName.Text = model.Name
	PlantInfo.Text = targetPercentage >= 100 and "" or string.format("%.0f%% Grown", displayedPercentage)
end

RunService.RenderStepped:Connect(updateHoverUI)