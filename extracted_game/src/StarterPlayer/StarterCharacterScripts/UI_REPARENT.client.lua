-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_HumanoidRootPart_0 = script.Parent:WaitForChild("HumanoidRootPart");
local v1 = game.ReplicatedStorage.Billboard_UI:Clone();
v1.Parent = game.Players.LocalPlayer.PlayerGui;
v1.Adornee = l_HumanoidRootPart_0;