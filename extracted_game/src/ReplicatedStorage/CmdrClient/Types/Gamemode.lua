-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(script.Parent.Parent.Shared.Util);
local _ = l_ReplicatedStorage_0:WaitForChild("Seed_Models");
local v3 = {
    "Creative", 
    "Adventure", 
    "Spectator"
};
local v9 = {
    Transform = function(v4) --[[ Line: 14 ]] --[[ Name: Transform ]]
        -- upvalues: v1 (copy), v3 (copy)
        return v1.MakeFuzzyFinder(v3)(v4);
    end, 
    Validate = function(v5) --[[ Line: 20 ]] --[[ Name: Validate ]]
        return #v5 > 0, "No seeds could be found.";
    end, 
    Autocomplete = function(v6) --[[ Line: 24 ]] --[[ Name: Autocomplete ]]
        -- upvalues: v1 (copy)
        return v1.GetNames(v6);
    end, 
    Parse = function(v7) --[[ Line: 28 ]] --[[ Name: Parse ]]
        return v7[1];
    end, 
    Default = function(_) --[[ Line: 32 ]] --[[ Name: Default ]]
        return "Creative";
    end, 
    ArgumentOperatorAliases = {
        me = ".", 
        all = "*", 
        others = "**", 
        random = "?"
    }
};
return function(v10) --[[ Line: 44 ]]
    -- upvalues: v9 (copy)
    v10:RegisterType("gamemode", v9);
end;