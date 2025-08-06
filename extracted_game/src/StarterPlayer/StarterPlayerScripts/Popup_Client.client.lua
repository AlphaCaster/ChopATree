-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(game.ReplicatedStorage.Field_Of_View_Module);
local l_TweenService_0 = game:GetService("TweenService");
local v2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local v3 = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local l_Frame_0 = game.Players.LocalPlayer.PlayerGui:WaitForChild("Pop_Effect"):WaitForChild("Frame");
local v5 = l_TweenService_0:Create(l_Frame_0, v2, {
    BackgroundTransparency = 0
});
local v6 = l_TweenService_0:Create(l_Frame_0, v3, {
    BackgroundTransparency = 1
});
game.ReplicatedStorage.GameEvents.Pop_Effect.OnClientEvent:Connect(function() --[[ Line: 8 ]]
    -- upvalues: v0 (copy), v5 (copy), v6 (copy)
    v0.Change_FOV(120, 0.5);
    v5:Play();
    task.wait(1);
    v0.Change_FOV(70, 4);
    task.wait(1.25);
    v6:Play();
end);