-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_CollectionService_0 = game:GetService("CollectionService");
observeTag = function(v1, v2, v3) --[[ Line: 56 ]] --[[ Name: observeTag ]]
    -- upvalues: l_CollectionService_0 (copy)
    local v4 = {};
    local v5 = {};
    local v6 = nil;
    local v7 = nil;
    local _ = function(v8) --[[ Line: 63 ]] --[[ Name: IsGoodAncestor ]]
        -- upvalues: v3 (copy)
        if v3 == nil then
            return true;
        else
            for _, v10 in v3 do
                if v8:IsDescendantOf(v10) then
                    return true;
                end;
            end;
            return false;
        end;
    end;
    local function _(v12) --[[ Line: 77 ]] --[[ Name: AttemptStartup ]]
        -- upvalues: v4 (copy), v2 (copy), v1 (copy)
        v4[v12] = "__inflight__";
        task.defer(function() --[[ Line: 82 ]]
            -- upvalues: v4 (ref), v12 (copy), v2 (ref), v1 (ref)
            if v4[v12] ~= "__inflight__" then
                return;
            else
                local v15, v16 = xpcall(function(v13) --[[ Line: 88 ]]
                    -- upvalues: v2 (ref)
                    local v14 = v2(v13);
                    if v14 ~= nil then
                        assert(typeof(v14) == "function", "callback must return a function or nil");
                    end;
                    return v14;
                end, debug.traceback, v12);
                if not v15 then
                    local v17 = "";
                    local v18 = string.split(v16, "\n")[1];
                    local v19 = string.find(v18, ": ");
                    if v19 then
                        v17 = v18:sub(v19 + 1);
                    end;
                    warn((("error while calling observeTag(\"%*\") callback:%*\n%*"):format(v1, v17, v16)));
                    return;
                else
                    if v4[v12] ~= "__inflight__" then
                        if v16 ~= nil then
                            task.spawn(v16);
                            return;
                        end;
                    else
                        v4[v12] = v16;
                    end;
                    return;
                end;
            end;
        end);
    end;
    local function _(v21) --[[ Line: 120 ]] --[[ Name: AttemptCleanup ]]
        -- upvalues: v4 (copy)
        local v22 = v4[v21];
        v4[v21] = "__dead__";
        if typeof(v22) == "function" then
            task.spawn(v22);
        end;
    end;
    local _ = function(v24) --[[ Line: 129 ]] --[[ Name: OnAncestryChanged ]]
        -- upvalues: v3 (copy), v4 (copy), v2 (copy), v1 (copy)
        local v25 = false;
        local v26;
        if v3 == nil then
            v26 = true;
        else
            for _, v28 in v3 do
                if v24:IsDescendantOf(v28) then
                    v26 = true;
                    v25 = true;
                end;
                if v25 then
                    break;
                end;
            end;
            if not v25 then
                v26 = false;
            end;
        end;
        v25 = false;
        if v26 then
            if v4[v24] == "__dead__" then
                v4[v24] = "__inflight__";
                task.defer(function() --[[ Line: 82 ]]
                    -- upvalues: v4 (ref), v24 (copy), v2 (ref), v1 (ref)
                    if v4[v24] ~= "__inflight__" then
                        return;
                    else
                        local v31, v32 = xpcall(function(v29) --[[ Line: 88 ]]
                            -- upvalues: v2 (ref)
                            local v30 = v2(v29);
                            if v30 ~= nil then
                                assert(typeof(v30) == "function", "callback must return a function or nil");
                            end;
                            return v30;
                        end, debug.traceback, v24);
                        if not v31 then
                            local v33 = "";
                            local v34 = string.split(v32, "\n")[1];
                            local v35 = string.find(v34, ": ");
                            if v35 then
                                v33 = v34:sub(v35 + 1);
                            end;
                            warn((("error while calling observeTag(\"%*\") callback:%*\n%*"):format(v1, v33, v32)));
                            return;
                        else
                            if v4[v24] ~= "__inflight__" then
                                if v32 ~= nil then
                                    task.spawn(v32);
                                    return;
                                end;
                            else
                                v4[v24] = v32;
                            end;
                            return;
                        end;
                    end;
                end);
                return;
            end;
        else
            v26 = v4[v24];
            v4[v24] = "__dead__";
            if typeof(v26) == "function" then
                task.spawn(v26);
            end;
        end;
    end;
    local function v61(v37) --[[ Line: 139 ]] --[[ Name: OnInstanceAdded ]]
        -- upvalues: v6 (ref), v4 (copy), v5 (copy), v3 (copy), v2 (copy), v1 (copy)
        local v38 = false;
        if not v6.Connected then
            return;
        elseif v4[v37] ~= nil then
            return;
        else
            v4[v37] = "__dead__";
            v5[v37] = v37.AncestryChanged:Connect(function() --[[ Line: 149 ]]
                -- upvalues: v37 (copy), v3 (ref), v4 (ref), v2 (ref), v1 (ref)
                local v39 = false;
                local l_v37_0 = v37;
                local v41;
                if v3 == nil then
                    v41 = true;
                else
                    for _, v43 in v3 do
                        if l_v37_0:IsDescendantOf(v43) then
                            v41 = true;
                            v39 = true;
                        end;
                        if v39 then
                            break;
                        end;
                    end;
                    if not v39 then
                        v41 = false;
                    end;
                end;
                v39 = false;
                if v41 then
                    if v4[l_v37_0] == "__dead__" then
                        v4[l_v37_0] = "__inflight__";
                        task.defer(function() --[[ Line: 82 ]]
                            -- upvalues: v4 (ref), l_v37_0 (copy), v2 (ref), v1 (ref)
                            if v4[l_v37_0] ~= "__inflight__" then
                                return;
                            else
                                local v46, v47 = xpcall(function(v44) --[[ Line: 88 ]]
                                    -- upvalues: v2 (ref)
                                    local v45 = v2(v44);
                                    if v45 ~= nil then
                                        assert(typeof(v45) == "function", "callback must return a function or nil");
                                    end;
                                    return v45;
                                end, debug.traceback, l_v37_0);
                                if not v46 then
                                    local v48 = "";
                                    local v49 = string.split(v47, "\n")[1];
                                    local v50 = string.find(v49, ": ");
                                    if v50 then
                                        v48 = v49:sub(v50 + 1);
                                    end;
                                    warn((("error while calling observeTag(\"%*\") callback:%*\n%*"):format(v1, v48, v47)));
                                    return;
                                else
                                    if v4[l_v37_0] ~= "__inflight__" then
                                        if v47 ~= nil then
                                            task.spawn(v47);
                                            return;
                                        end;
                                    else
                                        v4[l_v37_0] = v47;
                                    end;
                                    return;
                                end;
                            end;
                        end);
                        return;
                    end;
                else
                    v41 = v4[l_v37_0];
                    v4[l_v37_0] = "__dead__";
                    if typeof(v41) == "function" then
                        task.spawn(v41);
                    end;
                end;
            end);
            local v51;
            if v3 == nil then
                v51 = true;
            else
                for _, v53 in v3 do
                    if v37:IsDescendantOf(v53) then
                        v51 = true;
                        v38 = true;
                    end;
                    if v38 then
                        break;
                    end;
                end;
                if not v38 then
                    v51 = false;
                end;
            end;
            v38 = false;
            if v51 then
                if v4[v37] == "__dead__" then
                    v4[v37] = "__inflight__";
                    task.defer(function() --[[ Line: 82 ]]
                        -- upvalues: v4 (ref), v37 (copy), v2 (ref), v1 (ref)
                        if v4[v37] ~= "__inflight__" then
                            return;
                        else
                            local v56, v57 = xpcall(function(v54) --[[ Line: 88 ]]
                                -- upvalues: v2 (ref)
                                local v55 = v2(v54);
                                if v55 ~= nil then
                                    assert(typeof(v55) == "function", "callback must return a function or nil");
                                end;
                                return v55;
                            end, debug.traceback, v37);
                            if not v56 then
                                local v58 = "";
                                local v59 = string.split(v57, "\n")[1];
                                local v60 = string.find(v59, ": ");
                                if v60 then
                                    v58 = v59:sub(v60 + 1);
                                end;
                                warn((("error while calling observeTag(\"%*\") callback:%*\n%*"):format(v1, v58, v57)));
                                return;
                            else
                                if v4[v37] ~= "__inflight__" then
                                    if v57 ~= nil then
                                        task.spawn(v57);
                                        return;
                                    end;
                                else
                                    v4[v37] = v57;
                                end;
                                return;
                            end;
                        end;
                    end);
                    return;
                end;
            else
                v51 = v4[v37];
                v4[v37] = "__dead__";
                if typeof(v51) == "function" then
                    task.spawn(v51);
                end;
            end;
            return;
        end;
    end;
    local function v64(v62) --[[ Line: 155 ]] --[[ Name: OnInstanceRemoved ]]
        -- upvalues: v4 (copy), v5 (copy)
        local v63 = v4[v62];
        v4[v62] = "__dead__";
        if typeof(v63) == "function" then
            task.spawn(v63);
        end;
        v63 = v5[v62];
        if v63 then
            v63:Disconnect();
            v5[v62] = nil;
        end;
        v4[v62] = nil;
    end;
    v6 = l_CollectionService_0:GetInstanceAddedSignal(v1):Connect(v61);
    v7 = l_CollectionService_0:GetInstanceRemovedSignal(v1):Connect(v64);
    task.defer(function() --[[ Line: 172 ]]
        -- upvalues: v6 (ref), l_CollectionService_0 (ref), v1 (copy), v61 (copy)
        if not v6.Connected then
            return;
        else
            for _, v66 in l_CollectionService_0:GetTagged(v1) do
                task.spawn(v61, v66);
            end;
            return;
        end;
    end);
    return function() --[[ Line: 183 ]]
        -- upvalues: v6 (ref), v7 (ref), v4 (copy), v5 (copy)
        v6:Disconnect();
        v7:Disconnect();
        local v67 = next(v4);
        while v67 do
            local l_v67_0 = v67;
            local v69 = v4[l_v67_0];
            v4[l_v67_0] = "__dead__";
            if typeof(v69) == "function" then
                task.spawn(v69);
            end;
            v69 = v5[l_v67_0];
            if v69 then
                v69:Disconnect();
                v5[l_v67_0] = nil;
            end;
            v4[l_v67_0] = nil;
            v67 = next(v4);
        end;
    end;
end;
return observeTag;