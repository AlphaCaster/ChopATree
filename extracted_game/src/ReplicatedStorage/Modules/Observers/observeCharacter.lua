-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(script.Parent.observePlayer);
return function(v1) --[[ Line: 21 ]] --[[ Name: observeCharacter ]]
    -- upvalues: v0 (copy)
    return v0(function(v2) --[[ Line: 22 ]]
        -- upvalues: v1 (copy)
        local v3 = nil;
        local v4 = nil;
        local function v11(v5) --[[ Line: 27 ]] --[[ Name: OnCharacterAdded ]]
            -- upvalues: v1 (ref), v2 (copy), v4 (ref), v3 (ref)
            local v6 = nil;
            task.defer(function() --[[ Line: 31 ]]
                -- upvalues: v1 (ref), v2 (ref), v5 (copy), v4 (ref), v6 (ref), v3 (ref)
                local v7 = v1(v2, v5);
                if typeof(v7) == "function" then
                    if v4.Connected and v5.Parent then
                        v6 = v7;
                        v3 = v7;
                        return;
                    else
                        task.spawn(v7);
                    end;
                end;
            end);
            local v8 = nil;
            v8 = v5.AncestryChanged:Connect(function(_, v10) --[[ Line: 47 ]]
                -- upvalues: v8 (ref), v6 (ref), v3 (ref)
                if v10 == nil and v8.Connected then
                    v8:Disconnect();
                    if v6 ~= nil then
                        task.spawn(v6);
                        if v3 == v6 then
                            v3 = nil;
                        end;
                        v6 = nil;
                    end;
                end;
            end);
        end;
        v4 = v2.CharacterAdded:Connect(v11);
        task.defer(function() --[[ Line: 65 ]]
            -- upvalues: v2 (copy), v4 (ref), v11 (copy)
            if v2.Character and v4.Connected then
                task.spawn(v11, v2.Character);
            end;
        end);
        return function() --[[ Line: 72 ]]
            -- upvalues: v4 (ref), v3 (ref)
            v4:Disconnect();
            if v3 ~= nil then
                task.spawn(v3);
                v3 = nil;
            end;
        end;
    end);
end;