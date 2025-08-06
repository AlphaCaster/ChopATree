
local RS = game:GetService("ReplicatedStorage")
local HS = game:GetService("HttpService")
local P = game:GetService("Players")
local LocalPlayer = P.LocalPlayer
local Main = script.Parent.ConfirmFrame
local GameEvents = RS.GameEvents
local Notification = require(RS.Modules.Notification)

local Blur = require(RS.Blur_Module)
local FOV = require(RS.Field_Of_View_Module)
local last = workspace:WaitForChild("Camera").FieldOfView

function Close()
	Main.Visible = false
	Blur.Blur(0,0.15)
	FOV.Change_FOV(last,0.15)
end

function Open()
	game:GetService("SoundService").Click:Play()
	Main.Visible = true
	Blur.Blur(24,0.15)
	FOV.Change_FOV(60,0.15)
end

Main.Confirm.Activated:Connect(function()
	game:GetService("MarketplaceService"):PromptGamePassPurchase(LocalPlayer, require(game.ReplicatedStorage.PRODUCT_IDS).Gamepass.VIP)
end)

LocalPlayer.PlayerGui:FindFirstChild("Hud_UI").SideBtns.VIP.MouseButton1Click:Connect(Open)
Main.ExitButton.MouseButton1Click:Connect(Close)