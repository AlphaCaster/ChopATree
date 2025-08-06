-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = nil;
v0 = false;
local l_BindableEvent_0 = Instance.new("BindableEvent");
local v2 = false;
do
    local l_v2_0 = v2;
    l_BindableEvent_0.Event:Connect(function() --[[ Line: 7 ]]
        -- upvalues: l_v2_0 (ref)
        l_v2_0 = true;
    end);
    l_BindableEvent_0:Fire();
    l_BindableEvent_0:Destroy();
    if l_v2_0 == false then
        v0 = true;
    end;
end;
l_BindableEvent_0 = require(script.Deferred);
v2 = require(script.Immediate);
local v4 = v0 and l_BindableEvent_0 or v2;
v4.Deferred = l_BindableEvent_0;
v4.Immediate = v2;
return v4;