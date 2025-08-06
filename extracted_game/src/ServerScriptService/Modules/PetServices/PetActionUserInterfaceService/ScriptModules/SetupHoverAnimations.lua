-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
return function(v1) --[[ Line: 4 ]] --[[ Name: SetupHoverAnimations ]]
    -- upvalues: l_TweenService_0 (copy)
    local l_v1_FirstChild_0 = v1:FindFirstChild("SENSOR", true);
    local l_v1_FirstChild_1 = v1:FindFirstChild("UIScale", true);
    local v4 = l_TweenService_0:Create(l_v1_FirstChild_1, TweenInfo.new(0.25), {
        Scale = 1.05
    });
    local v5 = l_TweenService_0:Create(l_v1_FirstChild_1, TweenInfo.new(0.25), {
        Scale = 0.95
    });
    local v6 = l_TweenService_0:Create(l_v1_FirstChild_1, TweenInfo.new(0.25), {
        Scale = 1
    });
    l_v1_FirstChild_0.MouseButton1Down:Connect(function() --[[ Line: 19 ]]
        -- upvalues: v5 (copy)
        v5:Play();
    end);
    l_v1_FirstChild_0.MouseButton1Up:Connect(function() --[[ Line: 23 ]]
        -- upvalues: v5 (copy)
        v5:Play();
    end);
    l_v1_FirstChild_0.MouseEnter:Connect(function() --[[ Line: 27 ]]
        -- upvalues: v4 (copy)
        v4:Play();
    end);
    l_v1_FirstChild_0.MouseLeave:Connect(function() --[[ Line: 31 ]]
        -- upvalues: v6 (copy)
        v6:Play();
    end);
    return l_v1_FirstChild_0;
end;