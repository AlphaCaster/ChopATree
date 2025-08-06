-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("ReplicatedStorage");
local _ = game:GetService("HttpService");
local _ = script.Parent;
local l_Signal_0 = require(script:WaitForChild("Signal"));
local _ = {};
local v5 = {};
v5.__index = v5;
v5.new = function(v6) --[[ Line: 11 ]] --[[ Name: new ]]
    -- upvalues: v5 (copy)
    return (setmetatable({
        Table = v6, 
        PathRegistry = {}
    }, v5));
end;
v5.Destroy = function(v7) --[[ Line: 20 ]] --[[ Name: Destroy ]]
    for _, v9 in v7.PathRegistry do
        v9:Destroy();
    end;
end;
v5.GetTable = function(v10) --[[ Line: 26 ]] --[[ Name: GetTable ]]
    return v10.Table;
end;
v5.FindPathSignal = function(v11, v12) --[[ Line: 30 ]] --[[ Name: FindPathSignal ]]
    local l_PathRegistry_0 = v11.PathRegistry;
    if not l_PathRegistry_0[v12] then
        return;
    else
        return l_PathRegistry_0[v12];
    end;
end;
v5.FreePathSignal = function(v14, v15) --[[ Line: 36 ]] --[[ Name: FreePathSignal ]]
    v14.PathRegistry[v15] = nil;
end;
v5.GetPathSignal = function(v16, v17) --[[ Line: 41 ]] --[[ Name: GetPathSignal ]]
    -- upvalues: l_Signal_0 (copy)
    local l_v16_PathSignal_0 = v16:FindPathSignal(v17);
    if l_v16_PathSignal_0 then
        return l_v16_PathSignal_0;
    else
        local l_PathRegistry_1 = v16.PathRegistry;
        local v20 = l_Signal_0.new();
        l_PathRegistry_1[("%*"):format(v17)] = v20;
        return v20;
    end;
end;
return v5;