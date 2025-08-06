-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
--local _ = require(l_ReplicatedStorage_0.Data.QuestData.Types);
local v2 = require(l_ReplicatedStorage_0.Data.SeedData);
return {
    Type = "Plant", 
    Display = function(_, v4, v5, v6) --[[ Line: 12 ]] --[[ Name: Display ]]
        -- upvalues: v2 (copy)
        assert(v6, "Quest Plant doesn't have an argument.");
        local v7 = v2[v6[1]];
        return {
            Title = ("Plant %* %*%*"):format(v5, if v7 then v7.SeedName else v6[1], v5 > 1 and "s" or ""), 
            Bar = ("%*/%*"):format(v4, v5)
        };
    end, 
    Use = function(v8, v9) --[[ Line: 23 ]] --[[ Name: Use ]]
        assert(v9.Arguments, "Plant quests needs arguments.");
        local v10 = table.clone(v9);
        v10.Type = v8.Type;
        return v10;
    end
};