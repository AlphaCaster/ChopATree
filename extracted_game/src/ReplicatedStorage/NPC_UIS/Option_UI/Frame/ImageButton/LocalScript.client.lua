-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local v1 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local l_UIPadding_0 = script.Parent.Parent.Frame.Text_Element.UIPadding;
local v3 = l_TweenService_0:Create(l_UIPadding_0, v1, {
    PaddingLeft = UDim.new(0.04, 0)
});
local v4 = l_TweenService_0:Create(l_UIPadding_0, v1, {
    PaddingLeft = UDim.new(0, 0)
});
local l_ImageLabel_0 = script.Parent.Parent.ImageLabel;
local l_ImageTransparency_0 = script.Parent.Parent.ImageLabel.ImageTransparency;
local v7 = l_TweenService_0:Create(l_ImageLabel_0, v1, {
    ImageTransparency = 0
});
local v8 = l_TweenService_0:Create(l_ImageLabel_0, v1, {
    ImageTransparency = l_ImageTransparency_0
});
local l_Hover_0 = game.SoundService.Hover;
script.Parent.MouseEnter:Connect(function() --[[ Line: 12 ]]
    -- upvalues: l_Hover_0 (copy), v3 (copy), v7 (copy)
    l_Hover_0.PlaybackSpeed = 1 + math.random(-5, 5) / 100;
    l_Hover_0.Playing = true;
    l_Hover_0.TimePosition = 0;
    v3:Play();
    v7:Play();
end);
script.Parent.MouseLeave:Connect(function() --[[ Line: 19 ]]
    -- upvalues: v4 (copy), v8 (copy)
    v4:Play();
    v8:Play();
end);