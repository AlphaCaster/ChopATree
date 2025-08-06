-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
--local _ = require(l_ReplicatedStorage_0.Data.QuestData.Types);
return {
    Type = "Harvest", 
    Display = function(_, v3, v4, v5) --[[ Line: 10 ]] --[[ Name: Display ]]
        assert(v5, "Quest Harvest doesn't have an argument.");
        return {
            Title = ("Harvest %* %*"):format(v4, v5[1]), 
            Bar = ("%*/%*"):format(v3, v4)
        };
    end, 
    Use = function(v6, v7) --[[ Line: 19 ]] --[[ Name: Use ]]
        assert(v7.Arguments, "Plant quests needs arguments.");
        local v8 = table.clone(v7);
        v8.Type = v6.Type;
        return v8;
    end
};