-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Hover_0 = game.SoundService.Hover;
local l_Click_0 = game.SoundService.Click;
local l_UserInputService_0 = game:GetService("UserInputService");
local l_TweenService_0 = game:GetService("TweenService");
local v4 = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local v5 = l_TweenService_0:Create(script.Parent.TextLabel, v4, {
    Size = UDim2.new(1, 0, 1, 0)
});
local v6 = l_TweenService_0:Create(script.Parent.TextLabel, v4, {
    Size = UDim2.new(0.9, 0, 0.9, 0)
});
script.Parent.TextLabel.Size = UDim2.new(0.9, 0, 0.9, 0);
if l_UserInputService_0.TouchEnabled == false then
    script.Parent.MouseEnter:Connect(function() --[[ Line: 10 ]]
        -- upvalues: l_Hover_0 (copy), v5 (copy)
        l_Hover_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        l_Hover_0.TimePosition = 0;
        l_Hover_0.Playing = true;
        v5:Play();
    end);
    script.Parent.MouseLeave:Connect(function() --[[ Line: 16 ]]
        -- upvalues: v6 (copy)
        v6:Play();
    end);
end;
script.Parent.MouseButton1Click:Connect(function() --[[ Line: 20 ]]
    -- upvalues: l_Click_0 (copy)
    l_Click_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    l_Click_0.TimePosition = 0;
    l_Click_0.Playing = true;
end);