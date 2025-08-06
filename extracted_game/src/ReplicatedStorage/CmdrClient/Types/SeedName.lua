-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(script.Parent.Parent.Shared.Util);
local l_Seed_Models_0 = l_ReplicatedStorage_0:WaitForChild("Seed_Models");
local v8 = {
    Transform = function(v3) --[[ Line: 7 ]] --[[ Name: Transform ]]
        -- upvalues: v1 (copy), l_Seed_Models_0 (copy)
        return v1.MakeFuzzyFinder(l_Seed_Models_0:GetChildren())(v3);
    end, 
    Validate = function(v4) --[[ Line: 13 ]] --[[ Name: Validate ]]
        return #v4 > 0, "No seeds could be found.";
    end, 
    Autocomplete = function(v5) --[[ Line: 17 ]] --[[ Name: Autocomplete ]]
        -- upvalues: v1 (copy)
        return v1.GetNames(v5);
    end, 
    Parse = function(v6) --[[ Line: 21 ]] --[[ Name: Parse ]]
        return v6[1];
    end, 
    Default = function(_) --[[ Line: 25 ]] --[[ Name: Default ]]
        return "Carrot";
    end, 
    ArgumentOperatorAliases = {
        me = ".", 
        all = "*", 
        others = "**", 
        random = "?"
    }
};
return function(v9) --[[ Line: 37 ]]
    -- upvalues: v8 (copy)
    v9:RegisterType("seedname", v8);
end;