-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("HapticService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_CollectHaptic_0 = l_ReplicatedStorage_0.GameEvents.CollectHaptic;
local v4 = l_UserInputService_0.TouchEnabled and not l_UserInputService_0.MouseEnabled;
l_CollectHaptic_0.OnClientEvent:Connect(function() --[[ Line: 9 ]]
    -- upvalues: v4 (copy)
    if v4 then
        task.spawn(function() --[[ Line: 18 ]]

        end);
    end;
end);