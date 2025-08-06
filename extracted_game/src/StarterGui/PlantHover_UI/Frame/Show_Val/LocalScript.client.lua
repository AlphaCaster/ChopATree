-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local v1 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0);
local v2 = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local v3 = {};
local v4 = {};
local v5 = {
    script.Parent.Parent.PlantInfo, 
    script.Parent.Parent.PlantName
};
for _, v7 in pairs(v5) do
    local v8 = l_TweenService_0:Create(v7, v1, {
        TextTransparency = 0
    });
    local v9 = l_TweenService_0:Create(v7.UIStroke, v1, {
        Transparency = 0
    });
    table.insert(v3, v8);
    table.insert(v3, v9);
    local v10 = l_TweenService_0:Create(v7, v2, {
        TextTransparency = 1
    });
    local v11 = l_TweenService_0:Create(v7.UIStroke, v2, {
        Transparency = 1
    });
    table.insert(v4, v10);
    table.insert(v4, v11);
end;
script.Parent:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 18 ]]
    -- upvalues: v3 (copy), v4 (copy)
    if script.Parent.Value == true then
        for _, v13 in pairs(v3) do
            v13:Play();
        end;
        return;
    else
        for _, v15 in pairs(v4) do
            v15:Play();
        end;
        return;
    end;
end);