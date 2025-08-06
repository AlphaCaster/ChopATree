-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

for _, v1 in (game:GetDescendants()) do
    if v1.ClassName == "RemoteEvent" then
        v1.OnClientEvent:Connect(function(...) --[[ Line: 3 ]]
            -- upvalues: v1 (copy)
            print(v1.Name, ...);
        end);
    elseif v1:IsA("RemoteFunction") then
        v1.OnClientInvoke = function() --[[ Line: 7 ]]
            -- upvalues: v1 (copy)
            print(v1.Name);
        end;
    end;
end;
local v2 = {};
task.delay(10, function() --[[ Line: 16 ]]
    -- upvalues: v2 (copy)
    for _, v4 in game:GetDescendants() do
        for v5 in (v4:GetAttributes()) do
            v4:GetAttributeChangedSignal(v5):Connect(function() --[[ Line: 23 ]]
                -- upvalues: v2 (ref), v5 (copy)
                v2[v5] = (v2[v5] or 0) + 1;
            end);
        end;
    end;
end);
task.spawn(function() --[[ Line: 33 ]]
    -- upvalues: v2 (copy)
    while true do
        task.wait(0.25);
        if next(v2) then
            print(v2);
        end;
        table.clear(v2);
    end;
end);