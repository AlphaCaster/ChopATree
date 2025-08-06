-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.DeepCopy = function(_, v2) --[[ Line: 8 ]] --[[ Name: DeepCopy ]]
    -- upvalues: v0 (copy)
    local v3 = table.clone(v2);
    for v4, v5 in v3 do
        if type(v5) == "table" then
            v3[v4] = v0:DeepCopy(v5);
        end;
    end;
    return v3;
end;
return v0;