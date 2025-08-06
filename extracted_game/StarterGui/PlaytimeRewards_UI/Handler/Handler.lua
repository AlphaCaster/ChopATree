repeat wait() until game:GetService("Players").LocalPlayer:GetAttribute("Rewards") ~= nil

local RS = game:GetService("ReplicatedStorage")
local HS = game:GetService("HttpService")
local P = game:GetService("Players")
local LocalPlayer = P.LocalPlayer
local Main = script.Parent.Frame
local Frame = Main.Container.Rewards
local GameEvents = RS.GameEvents
local Notification = require(RS.Modules.Notification)

local Blur = require(RS.Blur_Module)
local FOV = require(RS.Field_Of_View_Module)
local last = workspace:WaitForChild("Camera").FieldOfView

function Format(Int)
	return string.format("%02i", Int)
end

function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Minutes)..":"..Format(Seconds)
end

function UpdateTimers()
	local pt, t = GameEvents.GetRewardsInfo:InvokeServer()
	for i, v in pairs(Frame:GetChildren()) do
		if v:IsA("ImageLabel") then
			if v.Claim.Txt.Text == "Claim!" then
				local Timer = v.Timer

				local Diff = t[v.Name] - pt
				if Diff <= 0 then 
					Timer.Text = "00:00"
				else
					Timer.Text = convertToHMS(Diff)
				end
			end
		end
	end
end
	
function Generate()
	local Data = HS:JSONDecode(LocalPlayer:GetAttribute("Rewards"))
	for i, v in pairs(Frame:GetChildren()) do
		if v:IsA("ImageLabel") then
			
			if table.find(Data, v.Name) then
				v.Claim.Txt.Text = "Claimed ✅"
			else
				v.Claim.MouseButton1Click:Connect(function()
					local call,msg = GameEvents.ClaimReward:InvokeServer(v.Name)
					if call == false then
						Notification.CreateNotification(1,msg)
					else
						Notification.CreateNotification(1,msg)
						v.Claim.Txt.Text = "Claimed ✅"
					end
				end)
			end
		end
	end
end

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

Generate()

LocalPlayer.PlayerGui:FindFirstChild("Hud_UI").SideBtns.Playtime.MouseButton1Click:Connect(Open)
Main.Top.ExitButton.MouseButton1Click:Connect(Close)

while wait(1) do
	UpdateTimers()
end