-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Frame_0 = script.Parent.Parent.Frame;
local l_TweenService_0 = game:GetService("TweenService");
local v2 = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local v3 = {
    l_Frame_0
};
for _, v5 in pairs(l_Frame_0:GetDescendants()) do
    if v5:IsA("TextLabel") or v5:IsA("UIStroke") or v5:IsA("ImageLabel") or v5:IsA("Frame") then
        table.insert(v3, v5);
    end;
end;
local v6 = {};
local v7 = {};
local l_Background_0 = script.Parent.Parent.Frame.Frame.Background;
table.insert(v6, (l_TweenService_0:Create(l_Background_0, v2, {
    Position = UDim2.new(0.5, 0, 0.5, 0)
})));
for _, v10 in pairs(v3) do
    if v10:IsA("TextLabel") then
        table.insert(v7, (l_TweenService_0:Create(v10, v2, {
            TextTransparency = 1
        })));
        if v10.TextTransparency == 0 then
            table.insert(v6, (l_TweenService_0:Create(v10, v2, {
                TextTransparency = 0
            })));
        end;
    elseif v10:IsA("UIStroke") then
        table.insert(v7, (l_TweenService_0:Create(v10, v2, {
            Transparency = 1
        })));
        if v10.Transparency == 0 then
            table.insert(v6, (l_TweenService_0:Create(v10, v2, {
                Transparency = 0
            })));
        end;
    elseif v10:IsA("ImageLabel") then
        table.insert(v7, (l_TweenService_0:Create(v10, v2, {
            ImageTransparency = 1
        })));
        if v10.ImageTransparency == 0 then
            table.insert(v6, (l_TweenService_0:Create(v10, v2, {
                ImageTransparency = 0
            })));
        end;
    end;
end;
script.Parent:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 39 ]]
    -- upvalues: l_Background_0 (copy), v3 (copy), v6 (copy)
    if script.Parent.Value == true then
        l_Background_0.Position = UDim2.new(0.75, 0, 0.5, 0);
        for _, v12 in pairs(v3) do
            if v12:IsA("TextLabel") then
                v12.TextTransparency = 1;
            elseif v12:IsA("UIStroke") then
                v12.Transparency = 1;
            elseif v12:IsA("Frame") then
                v12.BackgroundTransparency = 1;
            elseif v12:IsA("ImageLabel") then
                v12.ImageTransparency = 1;
            end;
        end;
        for _, v14 in pairs(v6) do
            v14:Play();
        end;
        script.Parent.Parent.Frame.Visible = true;
        return;
    else
        script.Parent.Parent.Frame.Visible = false;
        return;
    end;
end);