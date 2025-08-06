-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("ServerStorage");
--local _ = require(l_ReplicatedStorage_0.Data.QuestData.Types);
return {
    Type = "Seed Pack", 
    Display = function(_, v4) --[[ Line: 13 ]] --[[ Name: Display ]]
        local l_Amount_0 = v4.Data.Amount;
        return (("+%* Seed Pack%*"):format(l_Amount_0, l_Amount_0 > 1 and "s" or ""));
    end, 
    Give = function(_, v7, v8) --[[ Line: 18 ]] --[[ Name: Give ]]
        local l_ServerScriptService_0 = game:GetService("ServerScriptService");
        require(l_ServerScriptService_0.Modules.SeedPackService):Give(v7, "Normal", v8.Data.Amount);
        return true;
    end, 
    Use = function(v10, v11) --[[ Line: 25 ]] --[[ Name: Use ]]
        return {
            Type = v10.Type, 
            Data = v11
        };
    end
};