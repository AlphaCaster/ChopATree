-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_RunService_0 = game:GetService("RunService");
return function(v1, v2, v3) --[[ Line: 3 ]] --[[ Name: WaitForDescendant ]]
    -- upvalues: l_RunService_0 (copy)
    local l_v1_FirstChild_0 = v1:FindFirstChild(v2, true);
    if l_v1_FirstChild_0 then
        return l_v1_FirstChild_0;
    else
        local v5 = 0;
        v3 = v3 or 1e999;
        local v6 = false;
        while true do
            l_v1_FirstChild_0 = v1:FindFirstChild(v2, true);
            if v3 <= v5 then
                return l_v1_FirstChild_0;
            else
                if v5 >= 5 and not v6 then
                    v6 = true;
                    warn((("Infinite yield possible on 'game.%*:WaitForDescendant(\"%*\")'"):format(v1:GetFullName(), v2)));
                end;
                v5 = v5 + l_RunService_0.PreSimulation:Wait();
                if l_v1_FirstChild_0 then
                    return l_v1_FirstChild_0;
                end;
            end;
        end;
    end;
end;