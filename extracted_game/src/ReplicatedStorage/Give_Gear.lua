-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ServerStorage_0 = game:GetService("ServerStorage");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ServerScriptService_0 = game:GetService("ServerScriptService");
local l_Players_0 = game:GetService("Players");
local _ = game:GetService("HttpService");
local _ = l_ServerStorage_0:WaitForChild("SaveableTools");
local _ = l_ServerStorage_0:WaitForChild("Gears");
local l_ObjectModels_0 = l_ReplicatedStorage_0:WaitForChild("ObjectModels");
local _ = require(l_ReplicatedStorage_0.Data.SaveableToolsData);
local _ = require(l_ReplicatedStorage_0.Modules.StringUtils);
local v10 = require(l_ServerScriptService_0.Modules.InventoryService);
local v11 = {};
local v26 = {
    ["Watering Can"] = function(v12, _, v14) --[[ Line: 23 ]]
        -- upvalues: v10 (copy)
        v14 = v14 or 1;
        local v15 = v10:Find(v12, "Watering Can");
        local _, v17 = next(v15);
        if v17 then
            local l_ItemData_0 = v17.ItemData;
            l_ItemData_0.Uses = l_ItemData_0.Uses + v14;
            return;
        else
            v10:CreateItem(v12, "Watering Can", {
                Uses = v14
            });
            return;
        end;
    end, 
    Trowel = function(v19, _, v21) --[[ Line: 37 ]]
        -- upvalues: v10 (copy)
        v21 = v21 or 1;
        local v22 = v10:Find(v19, "Trowel");
        local _, v24 = next(v22);
        if v24 then
            local l_ItemData_1 = v24.ItemData;
            l_ItemData_1.Uses = l_ItemData_1.Uses + v21;
            return;
        else
            v10:CreateItem(v19, "Trowel", {
                Uses = v21
            });
            return;
        end;
    end
};
for _, v28 in l_ObjectModels_0:GetChildren() do
    local l_Name_0 = v28.Name;
    local v30 = l_Name_0:find("Sprinkler");
    local v31 = l_Name_0:find("Lightning Rod");
    if v30 then
        v26[l_Name_0] = function(v32) --[[ Line: 60 ]]
            -- upvalues: v10 (copy), l_Name_0 (copy)
            v10:CreateItem(v32, "Sprinkler", {
                ItemName = l_Name_0
            });
        end;
    elseif v31 then
        v26[l_Name_0] = function(v33) --[[ Line: 66 ]]
            -- upvalues: v10 (copy), l_Name_0 (copy)
            v10:CreateItem(v33, "Lightning Rod", {
                ItemName = l_Name_0
            });
        end;
    end;
end;
v11.Give_Gear = function(v34, v35, v36) --[[ Line: 78 ]] --[[ Name: Give_Gear ]]
    -- upvalues: l_Players_0 (copy), v26 (copy)
    while true do
        if not v34.Character or not v34.Character.PrimaryPart then
            if not v34:IsDescendantOf(l_Players_0) then
                return;
            else
                task.wait();
            end;
        else
            local v37 = v26[v35];
            if not v37 then
                return;
            else
                v37(v34, v35, v36);
                return;
            end;
        end;
    end;
end;
return v11;