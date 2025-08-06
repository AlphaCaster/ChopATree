-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = {
    "DefaultAdmin", 
    "DefaultDebug", 
    "DefaultUtil", 
    "GameCommands"
};
local v2 = require(l_ReplicatedStorage_0.Data.AuthorizedUsers);
return function(v3) --[[ Line: 12 ]]
    -- upvalues: v2 (copy)
    v3:RegisterHook("BeforeRun", function(v4) --[[ Line: 13 ]]
        -- upvalues: v2 (ref)
        local l_Executor_0 = v4.Executor;
        if not table.find(v2, l_Executor_0.UserId) then
            return "You don't have permission to run this command please verify that your UserId is in \"ReplicatedStorage.Data.AuthorizedUsers\"";
        else
            return;
        end;
    end);
end;