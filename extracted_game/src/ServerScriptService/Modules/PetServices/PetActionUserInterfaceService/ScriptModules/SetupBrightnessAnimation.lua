-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local function _(v1, v2) --[[ Line: 3 ]] --[[ Name: BrightenColorHSV ]]
    local v3, v4, v5 = v1:ToHSV();
    v5 = math.clamp(v5 + v2, 0, 1);
    return Color3.fromHSV(v3, v4, v5);
end;
return function(v7) --[[ Line: 9 ]] --[[ Name: SetupBrightnessAnimation ]]
    -- upvalues: l_TweenService_0 (copy)
    if not v7:GetAttribute("DefaultColor") then
        v7:SetAttribute("DefaultColor", v7.BackgroundColor3);
    end;
    local l_v7_Attribute_0 = v7:GetAttribute("DefaultColor");
    local v9, v10, v11 = l_v7_Attribute_0:ToHSV();
    v11 = math.clamp(v11 + 0.1, 0, 1);
    local v12 = Color3.fromHSV(v9, v10, v11);
    v9 = v7:FindFirstChild("SENSOR", true);
    v10 = v7:FindFirstChild("UIScale", true);
    v11 = l_TweenService_0:Create(v7, TweenInfo.new(0.25), {
        BackgroundColor3 = v12
    });
    local v13 = l_TweenService_0:Create(v7, TweenInfo.new(0.25), {
        BackgroundColor3 = l_v7_Attribute_0
    });
    v9.MouseEnter:Connect(function() --[[ Line: 28 ]]
        -- upvalues: v11 (copy)
        v11:Play();
    end);
    v9.MouseLeave:Connect(function() --[[ Line: 32 ]]
        -- upvalues: v13 (copy)
        v13:Play();
    end);
    return v9;
end;