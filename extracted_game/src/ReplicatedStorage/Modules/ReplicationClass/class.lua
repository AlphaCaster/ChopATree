-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    "Set", 
    "Get", 
    "Private", 
    "ReadOnly", 
    "WriteOnly", 
    "Constructor", 
    "GlobalGetFunction", 
    "GlobalSetFunction"
};
local function v1(v2) --[[ Line: 5 ]] --[[ Name: DeepCopy ]]
    -- upvalues: v1 (copy)
    local v3 = {};
    for v4, v5 in v2 do
        v3[v4] = type(v5) == "table" and v1(v5) or v5;
    end;
    return v3;
end;
return function(v6) --[[ Line: 13 ]] --[[ Name: class ]]
    -- upvalues: v1 (copy), v0 (copy)
    local v7 = {};
    v7.__index = v7;
    v7.__customclass = true;
    local v8 = v1(v6.Set or {});
    local v9 = v1(v6.Get or {});
    local v10 = v1(v6.ReadOnly or {});
    local v11 = v1(v6.WriteOnly or {});
    local v12 = v1(v6.Private or {});
    local l_GlobalGetFunction_0 = v6.GlobalGetFunction;
    local l_GlobalSetFunction_0 = v6.GlobalSetFunction;
    local l_Constructor_0 = v6.Constructor;
    table.freeze(v8);
    table.freeze(v9);
    table.freeze(v10);
    table.freeze(v11);
    table.freeze(v12);
    table.freeze(v6);
    v7.new = function(...) --[[ Line: 35 ]] --[[ Name: new ]]
        -- upvalues: v6 (ref), v1 (ref), v0 (ref), v12 (copy), v11 (copy), v9 (copy), l_GlobalGetFunction_0 (copy), v7 (copy), v10 (copy), v8 (copy), l_GlobalSetFunction_0 (copy), l_Constructor_0 (copy)
        local v16 = {};
        local v17 = {};
        v6 = v1(v6);
        for v18, v19 in v6 do
            if not table.find(v0, v18) then
                v16[v18] = v19;
            end;
        end;
        local v31 = setmetatable({
            RealData = v16
        }, {
            __index = function(v20, v21) --[[ Line: 50 ]] --[[ Name: __index ]]
                -- upvalues: v12 (ref), v17 (copy), v11 (ref), v9 (ref), l_GlobalGetFunction_0 (ref), v7 (ref), v16 (copy)
                local v22 = debug.info(2, "f");
                local v23 = v12[v21];
                if not v17[v22] and v23 then
                    return error((("Cannot access private function %* from %*"):format(v22, (debug.info(2, "f")))));
                elseif v11[v21] then
                    return error((("Cannot read from write only property %*"):format(v21)));
                else
                    local v24 = v9[v21];
                    if l_GlobalGetFunction_0 then
                        l_GlobalGetFunction_0(v20, v21);
                    end;
                    return rawget(v7, v21) or v24 and v24(v20) or rawget(v16, v21);
                end;
            end, 
            __newindex = function(v25, v26, v27) --[[ Line: 73 ]] --[[ Name: __newindex ]]
                -- upvalues: v12 (ref), v17 (copy), v10 (ref), v8 (ref), v16 (copy), l_GlobalSetFunction_0 (ref)
                local v28 = debug.info(2, "f");
                local v29 = v12[v26];
                if not v17[v28] and v29 then
                    return error((("Cannot access private function %* from %*"):format(v28, (debug.info(2, "f")))));
                elseif v10[v26] then
                    return error((("Cannot write to read only property %*"):format(v26)));
                else
                    local v30 = v8[v26];
                    if v30 then
                        v30(v25, v26, v27);
                    else
                        rawset(v16, v26, v27);
                    end;
                    if l_GlobalSetFunction_0 then
                        l_GlobalSetFunction_0(v25, v26, v27);
                    end;
                    return;
                end;
            end
        });
        for _, v33 in v7 do
            if type(v33) == "function" then
                v17[v33] = true;
            end;
        end;
        v17[debug.info(1, "f")] = true;
        if l_Constructor_0 then
            l_Constructor_0(v31, ...);
        end;
        return v31;
    end;
    return v7;
end;