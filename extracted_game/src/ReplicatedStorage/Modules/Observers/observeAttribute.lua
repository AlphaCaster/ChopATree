-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local function v1(_) --[[ Line: 20 ]] --[[ Name: defaultGuard ]]
    return true;
end;
return function(v2, v3, v4, v5) --[[ Line: 61 ]] --[[ Name: observeAttribute ]]
    -- upvalues: v1 (copy)
    local v6 = nil;
    local v7 = nil;
    local v8 = 0;
    local v9 = if v5 ~= nil then v5 else v1;
    local function v13() --[[ Line: 74 ]] --[[ Name: OnAttributeChanged ]]
        -- upvalues: v6 (ref), v8 (ref), v2 (copy), v3 (copy), v9 (copy), v4 (copy), v7 (ref)
        if v6 ~= nil then
            task.spawn(v6);
            v6 = nil;
        end;
        v8 = v8 + 1;
        local l_v8_0 = v8;
        local l_v2_Attribute_0 = v2:GetAttribute(v3);
        if l_v2_Attribute_0 ~= nil and v9(l_v2_Attribute_0) then
            task.spawn(function() --[[ Line: 86 ]]
                -- upvalues: v4 (ref), l_v2_Attribute_0 (copy), l_v8_0 (copy), v8 (ref), v7 (ref), v6 (ref)
                local v12 = v4(l_v2_Attribute_0);
                if l_v8_0 == v8 and v7.Connected then
                    v6 = v12;
                    return;
                else
                    task.spawn(v12);
                    return;
                end;
            end);
        end;
    end;
    v7 = v2:GetAttributeChangedSignal(v3):Connect(v13);
    task.defer(function() --[[ Line: 101 ]]
        -- upvalues: v7 (ref), v13 (copy)
        if not v7.Connected then
            return;
        else
            v13();
            return;
        end;
    end);
    return function() --[[ Line: 110 ]]
        -- upvalues: v7 (ref), v6 (ref)
        v7:Disconnect();
        if v6 ~= nil then
            task.spawn(v6);
            v6 = nil;
        end;
    end;
end;