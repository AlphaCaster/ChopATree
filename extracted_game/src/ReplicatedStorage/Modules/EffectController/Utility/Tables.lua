-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.CopyTable = function(v1) --[[ Line: 3 ]] --[[ Name: CopyTable ]]
    -- upvalues: v0 (copy)
    local v2 = {};
    for v3, v4 in v1 do
        v2[v3] = typeof(v4) == "table" and v0.CopyTable(v4) or v4;
    end;
    return v2;
end;
v0.Reconcile = function(v5, v6, v7) --[[ Line: 13 ]] --[[ Name: Reconcile ]]
    -- upvalues: v0 (copy)
    v5 = v7 and v0.CopyTable(v5) or v5;
    for v8, v9 in v6 do
        if not v5[v8] then
            v5[v8] = typeof(v9) == "table" and v0.CopyTable(v9) or v9;
        end;
    end;
    return v5;
end;
v0.CacheDirectory = function(v10, v11) --[[ Line: 28 ]] --[[ Name: CacheDirectory ]]
    -- upvalues: v0 (copy)
    local v12 = {};
    for _, v14 in v10:GetChildren() do
        local v15 = nil;
        if v14:IsA("ModuleScript") then
            v15 = v11 and v11(v14) or require(v14);
        end;
        v12[v14.Name] = v15 and v15 or (v14:IsA("Instance") or v14:IsA("Model") or v14:IsA("Folder")) and v0.CacheDirectory(v14, v11) or nil;
    end;
    return v12;
end;
v0.DeepCopy = function(v16) --[[ Line: 43 ]] --[[ Name: DeepCopy ]]
    -- upvalues: v0 (copy)
    local v17 = type(v16);
    local v18 = nil;
    if v17 == "table" then
        v18 = {};
        for v19, v20 in next, v16 do
            v18[v0.DeepCopy(v19)] = v0.DeepCopy(v20);
        end;
        setmetatable(v18, v0.DeepCopy((getmetatable(v16))));
        return v18;
    else
        return v16;
    end;
end;
v0.DeepCopyRecursive = function(v21, v22) --[[ Line: 58 ]] --[[ Name: DeepCopyRecursive ]]
    -- upvalues: v0 (copy)
    v22 = v22 or {};
    local v23 = type(v21);
    local v24 = nil;
    if v23 == "table" then
        if v22[v21] then
            return v22[v21];
        else
            v24 = {};
            v22[v21] = v24;
            for v25, v26 in next, v21 do
                v24[v0.DeepCopyRecursive(v25, v22)] = v0.DeepCopyRecursive(v26, v22);
            end;
            setmetatable(v24, v0.DeepCopyRecursive(getmetatable(v21), v22));
            return v24;
        end;
    else
        return v21;
    end;
end;
return v0;