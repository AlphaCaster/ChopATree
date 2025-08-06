-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
--local _ = require(l_ReplicatedStorage_0.Data.QuestData.Types);
local v2 = require(l_ReplicatedStorage_0.Comma_Module);
return {
    Type = "EarnSheckles", 
    Display = function(_, v4, v5) --[[ Line: 11 ]] --[[ Name: Display ]]
        -- upvalues: v2 (copy)
        local v6 = v2.Comma(v5);
        return {
            Title = ("Earn %*\194\162"):format(v6), 
            Bar = ("%*/%*"):format(v2.Comma((math.min(v4, v5))), v6)
        };
    end, 
    Use = function(v7, v8) --[[ Line: 19 ]] --[[ Name: Use ]]
        local v9 = table.clone(v8);
        v9.Type = v7.Type;
        return v9;
    end
};