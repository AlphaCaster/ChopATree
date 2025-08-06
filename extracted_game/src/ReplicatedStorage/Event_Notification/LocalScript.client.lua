-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local v1 = TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local v2 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local l_CanvasGroup_0 = script.Parent.CanvasGroup;
l_CanvasGroup_0.Position = UDim2.new(0.5, 0, 0.4, 0);
l_TweenService_0:Create(l_CanvasGroup_0, v1, {
    Position = UDim2.new(0.5, 0, 0.5, 0)
}):Play();
l_CanvasGroup_0.GroupTransparency = 1;
l_TweenService_0:Create(l_CanvasGroup_0, v1, {
    GroupTransparency = 0
}):Play();
local l_EVENT_SFX_0 = game.SoundService.EVENT_SFX;
l_EVENT_SFX_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
l_EVENT_SFX_0.TimePosition = 0;
l_EVENT_SFX_0.Playing = true;
task.wait(math.random(5, 7));
l_TweenService_0:Create(l_CanvasGroup_0, v2, {
    Position = UDim2.new(0.5, 0, 0.6, 0)
}):Play();
l_TweenService_0:Create(l_CanvasGroup_0, v2, {
    GroupTransparency = 1
}):Play();
game.Debris:AddItem(script.Parent, v2.Time);