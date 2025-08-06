-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Hover_0 = game.SoundService.Hover;
local l_Click_0 = game.SoundService.Click;
local l_UserInputService_0 = game:GetService("UserInputService");
l_UserInputService_0.InputBegan:Connect(function(v3, _) --[[ Line: 5 ]]
    -- upvalues: l_Click_0 (copy)
    if v3.KeyCode == Enum.KeyCode.ButtonR2 or v3.KeyCode == Enum.KeyCode.E then
        script.Parent.Parent.Parent.Start_Val.Value = true;
        l_Click_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        l_Click_0.TimePosition = 0;
        l_Click_0.Playing = true;
    end;
end);
l_UserInputService_0.InputEnded:Connect(function(v5, _) --[[ Line: 13 ]]
    if v5.KeyCode == Enum.KeyCode.ButtonR2 or v5.KeyCode == Enum.KeyCode.E then
        script.Parent.Parent.Parent.Start_Val.Value = false;
    end;
end);
script.Parent.MouseButton1Down:Connect(function() --[[ Line: 18 ]]
    -- upvalues: l_Click_0 (copy)
    script.Parent.Parent.Parent.Start_Val.Value = true;
    l_Click_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    l_Click_0.TimePosition = 0;
    l_Click_0.Playing = true;
end);
script.Parent.MouseLeave:Connect(function() --[[ Line: 25 ]]
    script.Parent.Parent.Parent.Start_Val.Value = false;
end);
script.Parent.MouseButton1Up:Connect(function() --[[ Line: 29 ]]
    script.Parent.Parent.Parent.Start_Val.Value = false;
end);
script.Parent.MouseEnter:Connect(function() --[[ Line: 33 ]]
    -- upvalues: l_Hover_0 (copy)
    l_Hover_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    l_Hover_0.TimePosition = 0;
    l_Hover_0.Playing = true;
end);