-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_GameEvents_0 = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents");
local l_Parent_0 = script.Parent;
local l_RecallWrenchTeleport_0 = l_GameEvents_0:WaitForChild("RecallWrenchTeleport");
local v3 = false;
l_Parent_0.Activated:Connect(function() --[[ Line: 9 ]]
    -- upvalues: v3 (ref), l_RecallWrenchTeleport_0 (copy), l_Parent_0 (copy)
    if v3 then
        return;
    else
        v3 = true;
        local l_Click_0 = game.SoundService.Click;
        l_Click_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        l_Click_0.TimePosition = 0;
        l_Click_0.Playing = true;
        l_RecallWrenchTeleport_0:FireServer();
        task.delay(0.5, function() --[[ Line: 21 ]]
            -- upvalues: l_Parent_0 (ref), v3 (ref)
            local l_Parent_1 = l_Parent_0.Parent;
            if l_Parent_1 and l_Parent_1:FindFirstChild("Humanoid") then
                l_Parent_1.Humanoid:UnequipTools();
            end;
            v3 = false;
        end);
        return;
    end;
end);