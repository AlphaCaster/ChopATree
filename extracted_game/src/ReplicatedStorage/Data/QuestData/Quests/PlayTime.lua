-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
--local _ = require(l_ReplicatedStorage_0.Data.QuestData.Types);
local v2 = require(l_ReplicatedStorage_0.Modules.TimeHelper);
return {
    Type = "PlayTime", 
    Display = function(_, v4, v5) --[[ Line: 11 ]] --[[ Name: Display ]]
        -- upvalues: v2 (copy)
        local v6 = v2:GenerateColonFormatFromTime(v5);
        return {
            Title = ("Play for %*"):format(v6), 
            Bar = ("%*/%*"):format(v2:GenerateColonFormatFromTime(v4), v6)
        };
    end, 
    Use = function(v7, v8) --[[ Line: 20 ]] --[[ Name: Use ]]
        local v9 = table.clone(v8);
        v9.Type = v7.Type;
        return v9;
    end
};