-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
--local _ = require(l_ReplicatedStorage_0.Data.QuestData.Types);
local v2 = require(l_ReplicatedStorage_0.Comma_Module);
return {
    Type = "Sheckles", 
    Display = function(_, v4) --[[ Line: 13 ]] --[[ Name: Display ]]
        -- upvalues: v2 (copy)
        return (("+%*\194\162"):format((v2.Comma(v4.Data.Amount))));
    end, 
    Give = function(_, v6, v7) --[[ Line: 17 ]] --[[ Name: Give ]]
        local l_ServerScriptService_0 = game:GetService("ServerScriptService");
        return require(l_ServerScriptService_0.Modules.CurrencyService):Add(v6, v7.Data.Amount);
    end, 
    Use = function(v9, v10) --[[ Line: 25 ]] --[[ Name: Use ]]
        return {
            Type = v9.Type, 
            Data = v10
        };
    end
};