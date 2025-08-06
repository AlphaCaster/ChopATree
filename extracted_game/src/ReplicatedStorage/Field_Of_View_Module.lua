-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_TweenService_0 = game:GetService("TweenService");
local l_LocalPlayer_0 = game.Players.LocalPlayer;
v0.Setup = function() --[[ Line: 4 ]] --[[ Name: Setup ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    l_LocalPlayer_0:SetAttribute("Core_FOV", 70);
end;
v0.Change_FOV_CORE = function(v3) --[[ Line: 7 ]] --[[ Name: Change_FOV_CORE ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    if l_LocalPlayer_0 and v3 then
        l_LocalPlayer_0:SetAttribute("Core_FOV", v3);
    end;
end;
v0.Return_Core_FOV = function() --[[ Line: 12 ]] --[[ Name: Return_Core_FOV ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    return l_LocalPlayer_0:GetAttribute("Core_FOV");
end;
v0.Change_FOV = function(v4, v5) --[[ Line: 15 ]] --[[ Name: Change_FOV ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_TweenService_0 (copy)
    if game.Workspace.CurrentCamera then
        if v5 == nil then
            v5 = 0.5;
        end;
        if v4 == 70 then
            v4 = l_LocalPlayer_0:GetAttribute("Core_FOV");
        end;
        local v6 = TweenInfo.new(v5 * (math.random(95, 105) * 0.01), Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
        local v7 = l_TweenService_0:Create(game.Workspace.CurrentCamera, v6, {
            FieldOfView = v4
        });
        v7:Play();
        game.Debris:AddItem(v7, v6.Time);
    end;
end;
return v0;