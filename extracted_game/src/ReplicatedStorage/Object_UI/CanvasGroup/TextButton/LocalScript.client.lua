-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Hover_0 = game.SoundService.Hover;
local l_Click_0 = game.SoundService.Click;
local l_BackgroundColor3_0 = script.Parent.BackgroundColor3;
local l_UserInputService_0 = game:GetService("UserInputService");
l_UserInputService_0.InputBegan:Connect(function(v4, _) --[[ Line: 6 ]]
    -- upvalues: l_Click_0 (copy)
    if v4.KeyCode == Enum.KeyCode.ButtonR2 or v4.KeyCode == Enum.KeyCode.E then
        script.Parent.Parent.Parent.Start_Val.Value = true;
        l_Click_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        l_Click_0.TimePosition = 0;
        l_Click_0.Playing = true;
        script.Parent.BackgroundColor3 = Color3.new(0, 0.7, 0);
    end;
end);
l_UserInputService_0.InputEnded:Connect(function(v6, _) --[[ Line: 15 ]]
    -- upvalues: l_BackgroundColor3_0 (copy)
    if v6.KeyCode == Enum.KeyCode.ButtonR2 or v6.KeyCode == Enum.KeyCode.E then
        script.Parent.Parent.Parent.Start_Val.Value = false;
        script.Parent.BackgroundColor3 = l_BackgroundColor3_0;
    end;
end);
script.Parent.MouseButton1Down:Connect(function() --[[ Line: 21 ]]
    -- upvalues: l_Click_0 (copy)
    script.Parent.Parent.Parent.Start_Val.Value = true;
    l_Click_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    l_Click_0.TimePosition = 0;
    l_Click_0.Playing = true;
    script.Parent.BackgroundColor3 = Color3.new(0, 0.7, 0);
end);
script.Parent.MouseLeave:Connect(function() --[[ Line: 29 ]]
    -- upvalues: l_BackgroundColor3_0 (copy)
    script.Parent.Parent.Parent.Start_Val.Value = false;
    script.Parent.BackgroundColor3 = l_BackgroundColor3_0;
end);
script.Parent.MouseButton1Up:Connect(function() --[[ Line: 34 ]]
    -- upvalues: l_BackgroundColor3_0 (copy)
    script.Parent.Parent.Parent.Start_Val.Value = false;
    script.Parent.BackgroundColor3 = l_BackgroundColor3_0;
end);
script.Parent.MouseEnter:Connect(function() --[[ Line: 39 ]]
    -- upvalues: l_Hover_0 (copy)
    l_Hover_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    l_Hover_0.TimePosition = 0;
    l_Hover_0.Playing = true;
    script.Parent.BackgroundColor3 = Color3.new(0.3, 1, 0.3);
end);