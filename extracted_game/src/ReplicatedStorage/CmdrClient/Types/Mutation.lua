-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(script.Parent.Parent.Shared.Util);
local v2 = require(l_ReplicatedStorage_0.Modules.MutationHandler);
local _ = require(l_ReplicatedStorage_0.Data.GearData);
local v4 = {
    "Gold", 
    "Rainbow"
};
for v5 in v2:GetMutations() do
    table.insert(v4, v5);
end;
local v11 = {
    Transform = function(v6) --[[ Line: 19 ]] --[[ Name: Transform ]]
        -- upvalues: v1 (copy), v4 (copy)
        return v1.MakeFuzzyFinder(v4)(v6);
    end, 
    Validate = function(v7) --[[ Line: 25 ]] --[[ Name: Validate ]]
        return #v7 > 0, "No seeds could be found.";
    end, 
    Autocomplete = function(v8) --[[ Line: 29 ]] --[[ Name: Autocomplete ]]
        -- upvalues: v1 (copy)
        return v1.GetNames(v8);
    end, 
    Parse = function(v9) --[[ Line: 33 ]] --[[ Name: Parse ]]
        return v9[1];
    end, 
    Default = function(_) --[[ Line: 37 ]] --[[ Name: Default ]]
        return "Gold";
    end, 
    ArgumentOperatorAliases = {
        me = ".", 
        all = "*", 
        others = "**", 
        random = "?"
    }
};
return function(v12) --[[ Line: 49 ]]
    -- upvalues: v11 (copy)
    v12:RegisterType("mutation", v11);
end;