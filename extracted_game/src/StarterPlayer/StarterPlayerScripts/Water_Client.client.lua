-- Farming Game Shovel System
-- Handles plant removal with a shovel tool, including UI prompts and raycasting
-- Original script by UniversalSynSaveInstance (https://discord.gg/wx4ThpAsmw)

-- Services
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- References
local Notification = require(ReplicatedStorage.Modules.Notification)
local WaterEvent = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("Water_RE")
local GetFarmModule = require(ReplicatedStorage.Modules.GetFarm)
local LocalPlayer = game.Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local ShovelPromptGui = LocalPlayer.PlayerGui:WaitForChild("ShovelPrompt")
local ConfirmFrame = ShovelPromptGui:WaitForChild("ConfirmFrame")
local ConfirmButton = ConfirmFrame:WaitForChild("Confirm")
local CancelButton = ConfirmFrame:WaitForChild("Cancel")
local ExitButton = ConfirmFrame:WaitForChild("ExitButton")
local FruitNameLabel = ConfirmFrame:WaitForChild("FruitName")
local SeedData = require(ReplicatedStorage.Data.SeedData)
local ItemModule = require(ReplicatedStorage.Item_Module)
local Highlight = script.Highlight

-- Valuable and restricted plant lists
local VALUABLE_PLANTS = {}
local RESTRICTED_PLANTS = {}

-- State
local targetPlant = nil

-- Utility Functions
local function isValuablePlant(plantName)
	for _, valuablePlant in ipairs(VALUABLE_PLANTS) do
		if string.find(string.lower(plantName), string.lower(valuablePlant)) then
			return true
		end
	end
	return false
end

local function isRestrictedPlant(plantName)
	for _, restrictedPlant in ipairs(RESTRICTED_PLANTS) do
		if string.find(string.lower(plantName), string.lower(restrictedPlant)) then
			return true
		end
	end
	return false
end

local function color3ToHex(color)
	local r = math.floor(color.R * 255)
	local g = math.floor(color.G * 255)
	local b = math.floor(color.B * 255)
	return string.format("#%02X%02X%02X", r, g, b)
end

local function raycastToPosition(position)
	local ray = CurrentCamera:ViewportPointToRay(position.X, position.Y)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = { CollectionService:GetTagged("ShovelIgnore") }

	local result = workspace:Raycast(ray.Origin, ray.Direction * 500, raycastParams)
	return result
end

-- UI Event Handlers
ConfirmButton.MouseButton1Click:Connect(function()
	if targetPlant then
		WaterEvent:FireServer(targetPlant)
		targetPlant = nil
	end
	ShovelPromptGui.Enabled = false
end)

CancelButton.MouseButton1Click:Connect(function()
	targetPlant = nil
	ShovelPromptGui.Enabled = false
end)

ExitButton.MouseButton1Click:Connect(function()
	targetPlant = nil
	ShovelPromptGui.Enabled = false
end)

-- Highlight Update
RunService.RenderStepped:Connect(function()
	if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Watering Can X1") then
		Highlight.Adornee = nil
		return
	end

	local mouseLocation = UserInputService:GetMouseLocation()
	local raycastResult = raycastToPosition(mouseLocation)

	if not raycastResult then
		Highlight.Adornee = nil
		return
	end

	local farm = GetFarmModule(LocalPlayer)
	if not farm or not raycastResult.Instance:IsDescendantOf(farm) then
		Highlight.Adornee = nil
		return
	end

	local plant = raycastResult.Instance.Parent
	if plant and plant:FindFirstChild("Grow") then
		if Highlight.Adornee ~= plant then
			Highlight.FillTransparency = 1
			TweenService:Create(Highlight, TweenInfo.new(0.25), { FillTransparency = 0.65 }):Play()
		end
		Highlight.Adornee = plant
	else
		Highlight.Adornee = nil
	end
end)

-- Shovel Input Handler
local function handleShovelInput(position, isTouch)
	if isTouch or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Watering Can X1") then
		return
	end

	local raycastResult = raycastToPosition(position)
	if not raycastResult then
		return
	end

	local plant = raycastResult.Instance.Parent
	if not plant or not plant:FindFirstChild("Grow") then
		return
	end

	local farm = GetFarmModule(LocalPlayer)
	if not farm or not raycastResult.Instance:IsDescendantOf(farm) then
		return
	end

	local plantName = plant.Name
	if isRestrictedPlant(plantName) then
		Notification:CreateNotification(`You cannot water {plantName}!`)
		return
	end

	if isValuablePlant(plantName) then
		local seedInfo = SeedData[plantName]
		local rarityData = seedInfo and ItemModule.Return_Rarity_Data(seedInfo.SeedRarity)
		local hexColor = rarityData and color3ToHex(rarityData[2]) or "#FFFFFF"

		FruitNameLabel.Text = string.format('<font color="%s">%s</font>', hexColor, plantName)
		targetPlant = raycastResult.Instance
		ShovelPromptGui.Enabled = true
	else
		WaterEvent:FireServer(raycastResult.Instance)
	end
end

-- Input Binding
if UserInputService.TouchEnabled then
	UserInputService.TouchTapInWorld:Connect(function(position)
		handleShovelInput(position, true)
	end)
else
	LocalPlayer:GetMouse().Button1Down:Connect(function()
		handleShovelInput(UserInputService:GetMouseLocation(), false)
	end)
end