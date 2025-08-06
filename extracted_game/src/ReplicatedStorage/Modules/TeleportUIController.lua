-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v2 = require(l_ReplicatedStorage_0.Modules.GetFarm);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Teleport_UI_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("Teleport_UI");
local v8 = {
    Move = function(_, v6) --[[ Line: 13 ]] --[[ Name: Move ]]
        -- upvalues: l_LocalPlayer_0 (copy)
        local l_Character_0 = l_LocalPlayer_0.Character;
        if not l_Character_0 then
            return;
        else
            l_Character_0:PivotTo(v6);
            return;
        end;
    end
};
v8.Start = function(_) --[[ Line: 22 ]] --[[ Name: Start ]]
    -- upvalues: l_Teleport_UI_0 (copy), v2 (copy), l_LocalPlayer_0 (copy), v8 (copy)
    l_Teleport_UI_0.Frame.Garden.Activated:Connect(function() --[[ Line: 23 ]]
        -- upvalues: v2 (ref), l_LocalPlayer_0 (ref), v8 (ref)
        local v10 = v2(l_LocalPlayer_0);
        if v10 ~= nil then
            v8:Move(v10.Spawn_Point.CFrame);
        end;
    end);
    l_Teleport_UI_0.Frame.Seeds.Activated:Connect(function() --[[ Line: 30 ]]
        -- upvalues: v8 (ref)
        v8:Move(workspace.Tutorial_Points.Tutorial_Point_1.CFrame);
    end);
    l_Teleport_UI_0.Frame.Sell.Activated:Connect(function() --[[ Line: 34 ]]
        -- upvalues: v8 (ref)
        v8:Move(workspace.Tutorial_Points.Tutorial_Point_2.CFrame);
    end);
    l_Teleport_UI_0.Frame.Gear.Activated:Connect(function() --[[ Line: 38 ]]
        -- upvalues: v8 (ref)
        v8:Move(workspace.Tutorial_Points.Tutorial_Point_3.CFrame);
    end);
end;
task.spawn(v8.Start, v8);
return v8;