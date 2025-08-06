-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
-- local _ = require(l_ReplicatedStorage_0.Modules.ABTestExperiments.ABTestTypes);
return {
    RemoteConfig = "SessionTimeLuck", 
    Disabled = false, 
    DefaultState = false, 
    States = {
        [false] = {
            Server = function(v3, _) --[[ Line: 16 ]] --[[ Name: Server ]]
                v3:SetAttribute("SessionTimeLuckDisabled", true);
            end
        }, 
        [true] = {
            Server = function(v5, _) --[[ Line: 21 ]] --[[ Name: Server ]]
                v5:SetAttribute("SessionTimeLuckDisabled", false);
            end
        }
    }
};