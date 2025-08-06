-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(script.Parent.Parent.Shared.Util);
local _ = game:GetService("ReplicatedStorage");
local l_HttpService_0 = game:GetService("HttpService");
local v3 = l_HttpService_0:JSONDecode(workspace:GetAttribute("AllWeather"));
workspace:GetAttributeChangedSignal("AllWeather"):Connect(function() --[[ Line: 8 ]]
    -- upvalues: v3 (ref), l_HttpService_0 (copy)
    v3 = l_HttpService_0:JSONDecode(workspace:GetAttribute("AllWeather"));
end);
local v9 = {
    Transform = function(v4) --[[ Line: 13 ]] --[[ Name: Transform ]]
        -- upvalues: v0 (copy), v3 (ref)
        return v0.MakeFuzzyFinder(v3)(v4);
    end, 
    Validate = function(v5) --[[ Line: 19 ]] --[[ Name: Validate ]]
        return #v5 > 0, "No seeds could be found.";
    end, 
    Autocomplete = function(v6) --[[ Line: 23 ]] --[[ Name: Autocomplete ]]
        -- upvalues: v0 (copy)
        return v0.GetNames(v6);
    end, 
    Parse = function(v7) --[[ Line: 27 ]] --[[ Name: Parse ]]
        return v7[1];
    end, 
    Default = function(_) --[[ Line: 31 ]] --[[ Name: Default ]]
        return "Rain";
    end, 
    ArgumentOperatorAliases = {
        me = ".", 
        all = "*", 
        others = "**", 
        random = "?"
    }
};
return function(v10) --[[ Line: 43 ]]
    -- upvalues: v9 (copy)
    v10:RegisterType("weather", v9);
end;