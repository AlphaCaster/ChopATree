-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = require(game.ReplicatedStorage.Code.SolveIK);
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local v3 = {};
local v4 = false;
local function v18(v5) --[[ Line: 9 ]] --[[ Name: ShakeBody ]]
    -- upvalues: l_LocalPlayer_0 (copy), v4 (ref)
    v5 = v5 or l_LocalPlayer_0.Character;
    repeat
        task.wait();
    until v5:IsDescendantOf(workspace);
    if v5:GetAttribute("Shaking") then
        return;
    else
        v5:SetAttribute("Shaking", true);
        local l_Torso_0 = v5:WaitForChild("Torso");
        local l_Neck_0 = l_Torso_0:WaitForChild("Neck");
        local v8 = l_Torso_0:WaitForChild("Left Shoulder");
        local v9 = l_Torso_0:WaitForChild("Right Shoulder");
        local v10 = l_Torso_0:WaitForChild("Left Hip");
        local v11 = l_Torso_0:WaitForChild("Right Hip");
        local l_C0_0 = v8.C0;
        local l_C0_1 = v9.C0;
        local l_C0_2 = v10.C0;
        local l_C0_3 = v11.C0;
        local l_C0_4 = l_Neck_0.C0;
        local v17 = 0;
        while v5:IsDescendantOf(workspace) and v4 do
            task.wait(0);
            v17 = v17 + 1;
            v8.C0 = l_C0_0 * CFrame.Angles(0, math.rad(math.sin(v17) * 1), 0);
            v9.C0 = l_C0_1 * CFrame.Angles(0, math.rad(math.sin(v17) * -1), 0);
            v11.C0 = l_C0_3 * CFrame.Angles(0, math.rad(math.sin(v17) * -1), 0);
            v10.C0 = l_C0_2 * CFrame.Angles(0, math.rad(math.sin(v17) * 1), 0);
            l_Neck_0.C0 = l_C0_4 * CFrame.Angles(0, 0, (math.rad(math.sin(v17) * 1)));
        end;
        v8.C0 = l_C0_0;
        v9.C0 = l_C0_1;
        v10.C0 = l_C0_2;
        v11.C0 = l_C0_3;
        l_Neck_0.C0 = l_C0_4;
        v5:SetAttribute("Shaking", false);
        return;
    end;
end;
v0.EnableShaking = function() --[[ Line: 65 ]] --[[ Name: EnableShaking ]]
    -- upvalues: l_LocalPlayer_0 (copy), v18 (copy), v3 (copy), v4 (ref)
    if l_LocalPlayer_0.Character then
        task.spawn(v18);
    end;
    table.insert(v3, l_LocalPlayer_0.CharacterAdded:Connect(v18));
    v4 = true;
end;
v0.DisableShaking = function() --[[ Line: 74 ]] --[[ Name: DisableShaking ]]
    -- upvalues: v3 (copy), v4 (ref)
    for _, v20 in v3 do
        v20:Disconnect();
    end;
    v4 = false;
end;
return v0;