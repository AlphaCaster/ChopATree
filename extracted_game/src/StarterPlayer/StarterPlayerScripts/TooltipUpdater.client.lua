-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
local function v8(_) --[[ Line: 5 ]] --[[ Name: updateToolTips ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    local l_Backpack_0 = l_LocalPlayer_0:FindFirstChild("Backpack");
    if not l_Backpack_0 then
        return;
    else
        local function v4(v3) --[[ Line: 11 ]] --[[ Name: processTool ]]
            if v3:IsA("Tool") and string.find(v3.Name, "(kg)") then
                v3.ToolTip = v3.Name;
                v3:GetPropertyChangedSignal("Name"):Connect(function() --[[ Line: 17 ]]
                    -- upvalues: v3 (copy)
                    if string.find(v3.Name, "(kg)") then
                        v3.ToolTip = v3.Name;
                    end;
                end);
            end;
        end;
        for _, v6 in ipairs(l_Backpack_0:GetChildren()) do
            v4(v6);
        end;
        l_Backpack_0.ChildAdded:Connect(function(v7) --[[ Line: 31 ]]
            -- upvalues: v4 (copy)
            v4(v7);
        end);
        return;
    end;
end;
l_LocalPlayer_0.CharacterAdded:Connect(v8);
if l_LocalPlayer_0.Character then
    v8(l_LocalPlayer_0.Character);
end;