-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
--local _ = require(l_ReplicatedStorage_0.Modules.ABTestExperiments.ABTestTypes);
local function v4(v2, v3) --[[ Line: 8 ]] --[[ Name: setTutorial ]]
    v2:SetAttribute("AB_TutorialVariant", v3);
end;
return {
    RemoteConfig = "TutorialVariant", 
    Disabled = false, 
    DefaultState = "Variant1", 
    States = {
        Variant1 = {
            Client = v4
        }, 
        Variant2 = {
            Client = v4
        }, 
        Variant3 = {
            Client = v4
        }
    }
};