-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
-- local _ = require(l_ReplicatedStorage_0.Modules.ABTestExperiments.ABTestTypes);
return {
    RemoteConfig = "TestKeyTeleport", 
    Disabled = false, 
    DefaultState = false, 
    States = {
        [true] = {
            Server = function(v2, _) --[[ Line: 15 ]] --[[ Name: Server ]]
                v2:SetAttribute("TestKeyTeleport", true);
            end, 
            Client = function(v4, _) --[[ Line: 19 ]] --[[ Name: Client ]]
                v4:SetAttribute("TestKeyTeleport", true);
            end
        }, 
        [false] = {
            Server = function(v6, _) --[[ Line: 26 ]] --[[ Name: Server ]]
                v6:SetAttribute("TestKeyTeleport", false);
            end, 
            Client = function(v8, _) --[[ Line: 31 ]] --[[ Name: Client ]]
                v8:SetAttribute("TestKeyTeleport", false);
            end
        }
    }
};