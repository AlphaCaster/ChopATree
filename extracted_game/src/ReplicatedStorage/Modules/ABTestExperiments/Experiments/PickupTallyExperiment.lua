-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
-- local _ = require(l_ReplicatedStorage_0.Modules.ABTestExperiments.ABTestTypes);
return {
    RemoteConfig = "ShowPickupTally", 
    Disabled = false, 
    DefaultState = l_RunService_0:IsStudio(), 
    States = {
        [true] = {
            Client = function(v3, _) --[[ Line: 16 ]] --[[ Name: Client ]]
                v3:SetAttribute("AB_ShowPickupTally", true);
            end
        }
    }
};