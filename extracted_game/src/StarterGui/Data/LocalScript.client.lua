script.Parent.Frame.Visible = true
repeat task.wait() until game.Players.LocalPlayer:GetAttribute("DataLoaded")
script.Parent:Destroy()
print("Loaded GAG Modded")