-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ServerScriptService_0 = game:GetService("ServerScriptService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v2 = game:GetService("RunService"):IsServer();
local v3 = {
    "Normal", 
    "Gold", 
    "Rainbow"
};
return {
    Give_Seed = function(v4, v5, v6, v7) --[[ Line: 11 ]] --[[ Name: Give_Seed ]]
        -- upvalues: v2 (copy), l_ServerScriptService_0 (copy), v3 (copy), l_ReplicatedStorage_0 (copy)
        assert(v2);
        local v8 = require(l_ServerScriptService_0.Modules.InventoryService);
        if v7 == nil then
            v7 = "Normal";
        end;
        if not table.find(v3, v7) then
            warn((("Invalid variation given in Give_Seed, got \"%*\"\n%*"):format(v7, (debug.traceback()))));
            return;
        elseif v6 ~= nil and (type(v6) ~= "number" or v6 <= 0 or v6 ~= v6) then
            return;
        elseif not l_ReplicatedStorage_0.Seed_Models:FindFirstChild(v5) then
            warn((("Seed \"%*\" does not exists\n%*"):format(v5, (debug.traceback()))));
            return;
        else
            local v9 = v6 or 1;
            local v12 = v8:Find(v4, "Seed", function(v10) --[[ Line: 36 ]]
                -- upvalues: v5 (copy), v7 (ref)
                local v11 = false;
                if v10.ItemName == v5 then
                    v11 = v10.Variant == v7;
                end;
                return v11;
            end);
            local _, v14 = next(v12);
            if v14 then
                local l_ItemData_0 = v14.ItemData;
                l_ItemData_0.Quantity = l_ItemData_0.Quantity + v9;
            else
                v8:CreateItem(v4, "Seed", {
                    ItemName = v5, 
                    Quantity = v9, 
                    Variant = v7
                });
            end;
            return;
        end;
    end
};