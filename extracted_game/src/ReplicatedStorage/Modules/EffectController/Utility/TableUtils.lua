-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local function v0(v1) --[[ Line: 2 ]] --[[ Name: deepCopy ]]
    -- upvalues: v0 (copy)
    if typeof(v1) == "table" then
        local v2 = {};
        for v3, v4 in pairs(v1) do
            v2[v3] = v0(v4);
        end;
        return v2;
    else
        return v1;
    end;
end;
local function v5(v6, v7) --[[ Line: 13 ]] --[[ Name: deepEquals ]]
    -- upvalues: v5 (copy)
    if typeof(v6) == "table" and typeof(v7) == "table" then
        for v8, v9 in pairs(v6) do
            if not v5(v9, v7[v8]) then
                return false;
            end;
        end;
        for v10, v11 in pairs(v7) do
            if not v5(v11, v6[v10]) then
                return false;
            end;
        end;
        return true;
    else
        return v6 == v7;
    end;
end;
return {
    deepCopy = v0, 
    deepEquals = v5, 
    getDictionaryLength = function(v12) --[[ Line: 30 ]] --[[ Name: getDictionaryLength ]]
        local v13 = 0;
        for _, _ in v12 do
            v13 = v13 + 1;
        end;
        return v13;
    end
};