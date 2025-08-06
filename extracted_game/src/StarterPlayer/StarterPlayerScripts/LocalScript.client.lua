-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_LocalPlayer_0 = game.Players.LocalPlayer;
UPD = function() --[[ Line: 2 ]] --[[ Name: UPD ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    for _, v2 in pairs(game.Workspace.Farm:GetChildren()) do
        local l_ProximityPrompt_0 = v2:WaitForChild("Sign").Core_Part.ProximityPrompt;
        local l_Value_0 = v2.Important.Data.Owner.Value;
        if l_Value_0 ~= "" then
            if l_Value_0 == l_LocalPlayer_0.Name then
                l_ProximityPrompt_0.Enabled = false;
            else
                l_ProximityPrompt_0.Enabled = true;
            end;
        else
            l_ProximityPrompt_0.Enabled = false;
        end;
    end;
end;
UPD();
for _, v6 in pairs(game.Workspace.Farm:GetChildren()) do
    v6.Important.Data.Owner:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 20 ]]
        UPD();
    end);
end;