-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_TweenService_0 = game:GetService("TweenService");
local l_Blur_0 = game.Lighting.Blur;
v0.Blur = function(v3, v4) --[[ Line: 4 ]] --[[ Name: Blur ]]
    -- upvalues: l_TweenService_0 (copy), l_Blur_0 (copy)
    local v5 = TweenInfo.new(v4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
    local v6 = l_TweenService_0:Create(l_Blur_0, v5, {
        Size = v3
    });
    v6:Play();
    game.Debris:AddItem(v6, v4);
end;
return v0;