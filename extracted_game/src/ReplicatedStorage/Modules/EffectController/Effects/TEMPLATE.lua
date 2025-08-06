-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = require(l_ReplicatedStorage_0.Modules.EffectController.Types);
return {
    PlayTestEffect = function(_) --[[ Line: 21 ]] --[[ Name: PlayTestEffect ]]

    end, 
    Cancel = function(v3) --[[ Line: 39 ]] --[[ Name: Cancel ]]
        v3.Container:Clean();
        v3.Cache = {};
    end
};