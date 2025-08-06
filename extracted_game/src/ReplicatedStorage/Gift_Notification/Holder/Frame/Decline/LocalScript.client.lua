-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Hover_0 = game.SoundService.Hover;
local l_Click_0 = game.SoundService.Click;
script.Parent.MouseEnter:Connect(function() --[[ Line: 3 ]]
    -- upvalues: l_Hover_0 (copy)
    l_Hover_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    l_Hover_0.Playing = true;
    l_Hover_0.TimePosition = 0;
end);
script.Parent.MouseButton1Click:Connect(function() --[[ Line: 8 ]]
    -- upvalues: l_Click_0 (copy)
    l_Click_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    l_Click_0.Playing = true;
    l_Click_0.TimePosition = 0;
end);