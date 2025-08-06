-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_DataStore_0 = game:GetService("DataStoreService"):GetDataStore("C_" .. tostring(game.ServerStorage.Data_Set.Value));
local v2 = {};
UPD = function(v3) --[[ Line: 5 ]] --[[ Name: UPD ]]
    -- upvalues: v2 (copy)
    local v4 = nil;
    for _, v6 in pairs(v2) do
        if v6[1] == v3.Name then
            v4 = v6[2];
        end;
    end;
    if v4 ~= nil then
        local l_Finished_Quests_0 = v3.Finished_Quests;
        for _, v9 in pairs(v4) do
            if l_Finished_Quests_0:FindFirstChild(v9[1]) == nil then
                local v10 = script.String_Val:Clone();
                v10.Name = v9[1];
                v10.Value = v9[1];
                v10.Parent = l_Finished_Quests_0;
                local v11 = script.Number_Val:Clone();
                v11.Value = v9[2];
                v11.Name = "Completions";
                v11.Parent = v10;
            end;
        end;
    end;
end;
v0.Setup = function(v12) --[[ Line: 28 ]] --[[ Name: Setup ]]
    -- upvalues: l_DataStore_0 (copy), v2 (copy)
    local l_l_DataStore_0_Async_0 = l_DataStore_0:GetAsync(v12.UserId);
    if l_l_DataStore_0_Async_0 then
        local v14 = {
            v12.Name, 
            l_l_DataStore_0_Async_0
        };
        table.insert(v2, v14);
    else
        local v15 = {
            v12.Name, 
            {}
        };
        table.insert(v2, v15);
    end;
    UPD(v12);
end;
v0.Save = function(v16) --[[ Line: 39 ]] --[[ Name: Save ]]
    -- upvalues: v2 (copy), l_DataStore_0 (copy)
    local v17 = nil;
    for _, v19 in pairs(v2) do
        if v19[1] == v16.Name then
            v17 = v19[2];
        end;
    end;
    if v17 ~= nil then
        l_DataStore_0:SetAsync(v16.UserId, v17);
    end;
end;
v0.Finish_Quest = function(v20, v21) --[[ Line: 50 ]] --[[ Name: Finish_Quest ]]
    -- upvalues: v2 (copy)
    for _, v23 in pairs(v2) do
        if v23[1] == v20.Name then
            local v24 = false;
            for _, v26 in pairs(v23[2]) do
                if v26[1] == v21 then
                    v26[2] = v26[2] + 1;
                    v24 = true;
                end;
            end;
            if v24 == false then
                table.insert(v23[2], {
                    v21, 
                    1
                });
            end;
        end;
    end;
    for _, v28 in pairs(v20.PlayerGui.Quest_Frame.Side_Frame:GetChildren()) do
        if v28:IsA("CanvasGroup") and v28.Quest_Name.Value == v21 then
            v28:Destroy();
        end;
    end;
    UPD(v20);
end;
v0.Completitons = function(v29, v30) --[[ Line: 75 ]] --[[ Name: Completitons ]]
    -- upvalues: v2 (copy)
    local v31 = 0;
    for _, v33 in pairs(v2) do
        if v33[1] == v29.Name then
            for _, v35 in pairs(v33[2]) do
                if v35[1] == v30 then
                    v31 = v35[2];
                end;
            end;
        end;
    end;
    return v31;
end;
return v0;