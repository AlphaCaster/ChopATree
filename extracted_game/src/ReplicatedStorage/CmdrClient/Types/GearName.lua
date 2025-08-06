-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("ServerStorage");
local v2 = require(script.Parent.Parent.Shared.Util);
local v3 = require(l_ReplicatedStorage_0.Data.GearData);
local v5 = {};
for v6 in v3 do
    table.insert(v5, v6);
end;
local v13 = {
    Transform = function(v8) --[[ Line: 33 ]] --[[ Name: Transform ]]
        -- upvalues: v2 (copy), v5 (copy)
        return v2.MakeFuzzyFinder(v5)(v8);
    end, 
    Validate = function(v9) --[[ Line: 39 ]] --[[ Name: Validate ]]
        return #v9 > 0, "No seeds could be found.";
    end, 
    Autocomplete = function(v10) --[[ Line: 43 ]] --[[ Name: Autocomplete ]]
        -- upvalues: v2 (copy)
        return v2.GetNames(v10);
    end, 
    Parse = function(v11) --[[ Line: 47 ]] --[[ Name: Parse ]]
        return v11[1];
    end, 
    Default = function(_) --[[ Line: 51 ]] --[[ Name: Default ]]
        return "Creative";
    end, 
    ArgumentOperatorAliases = {
        me = ".", 
        all = "*", 
        others = "**", 
        random = "?"
    }
};
return function(v14) --[[ Line: 63 ]]
    -- upvalues: v13 (copy)
    v14:RegisterType("gearname", v13);
end;