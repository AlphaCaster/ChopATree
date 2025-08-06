local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local playerGui = localPlayer.PlayerGui

local replicateUIContainer = ReplicatedStorage:WaitForChild("ReplicateUI")
for _, uiElement in ipairs(replicateUIContainer:GetChildren()) do
	uiElement.Parent = playerGui
end

local modulesContainer = ReplicatedStorage.Modules
for _, potentialModule in pairs(modulesContainer:GetDescendants()) do
	if potentialModule:IsA("ModuleScript") then
		local moduleScript = potentialModule
		task.spawn(function()
			debug.setmemorycategory(moduleScript.Name)
			local success, resultOrError = pcall(function()
				require(moduleScript)
			end)
			if success then
				return
			else
				warn("Error requiring module:", moduleScript.Name, "-", resultOrError)
				return
			end
		end)
	end
end