-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local v1 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local v2 = TweenInfo.new(0.07, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local l_Hold_Down_Val_0 = script.Parent.Parent.CanvasGroup.TextButton.Hold_Down_Val;
local v4 = l_TweenService_0:Create(l_Hold_Down_Val_0, v1, {
    Size = UDim2.new(1, 0, 1, 0)
});
local v5 = l_TweenService_0:Create(l_Hold_Down_Val_0, v2, {
    BackgroundTransparency = 0.5
});
local v6 = time();
script.Parent:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 8 ]]
    -- upvalues: v6 (ref), v4 (copy), l_Hold_Down_Val_0 (copy), v5 (copy)
    v6 = time();
    if script.Parent.Value == true then
        v4:Cancel();
        l_Hold_Down_Val_0.Size = UDim2.new(0, 0, 1, 0);
        l_Hold_Down_Val_0.BackgroundTransparency = 1;
        v4:Play();
        v5:Play();
        v6 = time();
        return;
    else
        v4:Cancel();
        v5:Cancel();
        l_Hold_Down_Val_0.BackgroundTransparency = 1;
        return;
    end;
end);
local l_Purchase_Object_0 = game.ReplicatedStorage.GameEvents.Purchase_Object;
local l_Object_ID_0 = script.Parent.Parent.Object_ID;
local l_Green_VAL_0 = game.Players.LocalPlayer.PlayerGui.Gradient_UI.Green_VAL;
local l_Red_VAL_0 = game.Players.LocalPlayer.PlayerGui.Gradient_UI.Red_VAL;
local l_Error_0 = game.SoundService.Error;
v4.Completed:Connect(function() --[[ Line: 28 ]]
    -- upvalues: v6 (ref), l_Purchase_Object_0 (copy), l_Object_ID_0 (copy), l_Green_VAL_0 (copy), l_Red_VAL_0 (copy), l_Error_0 (copy)
    if time() - v6 >= 0.95 then
        if script.Parent.Parent.Cost_Val.Value <= game.Players.LocalPlayer.leaderstats["$"].Value then
            l_Purchase_Object_0:FireServer(l_Object_ID_0.Value);
            l_Green_VAL_0.Value = true;
        else
            l_Red_VAL_0.Value = true;
            l_Error_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            l_Error_0.TimePosition = 0;
            l_Error_0.Playing = true;
        end;
        script.Parent.Value = false;
    end;
end);