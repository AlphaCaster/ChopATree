-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_CollectionService_0 = game:GetService("CollectionService");
local _ = game:GetService("RunService");
local _ = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
task.spawn(function() --[[ Line: 11 ]]
    -- upvalues: l_CollectionService_0 (copy)
    while true do
        local v3 = Color3.fromHSV(os.clock() % 10 / 10, 1, 1);
        for _, v5 in l_CollectionService_0:GetTagged("RainbowPart") do
            v5.Color = v3;
        end;
        task.wait(0.1);
    end;
end);