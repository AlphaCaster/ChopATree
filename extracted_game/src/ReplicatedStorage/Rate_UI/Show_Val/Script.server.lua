-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local v1 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local l_Parent_0 = script.Parent.Parent;
local v3 = l_TweenService_0:Create(l_Parent_0.CanvasGroup, v1, {
    GroupTransparency = 0
});
local v4 = l_TweenService_0:Create(l_Parent_0, v1, {
    StudsOffset = Vector3.new(5.25, 0, 0, 0)
});
local v5 = l_TweenService_0:Create(l_Parent_0, v1, {
    Size = UDim2.new(l_Parent_0.Size.X.Scale * 1.1, 0, l_Parent_0.Size.Y.Scale * 1.1, 0)
});
local v6 = l_TweenService_0:Create(l_Parent_0.CanvasGroup, v1, {
    GroupTransparency = 1
});
l_Parent_0.CanvasGroup.GroupTransparency = 1;
UPD = function() --[[ Line: 9 ]] --[[ Name: UPD ]]
    -- upvalues: l_Parent_0 (copy), v3 (copy), v4 (copy), v5 (copy), v6 (copy), v1 (copy)
    if script.Parent.Value == true then
        l_Parent_0.StudsOffset = Vector3.new(3, 0, 0, 0);
        v3:Play();
        v4:Play();
        return;
    else
        v5:Play();
        v6:Play();
        game.Debris:AddItem(script.Parent.Parent, v1.Time);
        return;
    end;
end;
UPD();
script.Parent:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 21 ]]
    UPD();
end);