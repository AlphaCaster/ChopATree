-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
v0.new = function() --[[ Line: 14 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy)
    return (setmetatable({
        _first = 0, 
        _last = -1, 
        _queue = {}
    }, v0));
end;
v0.isEmpty = function(v1) --[[ Line: 25 ]] --[[ Name: isEmpty ]]
    return v1._first > v1._last;
end;
v0.enqueue = function(v2, v3) --[[ Line: 30 ]] --[[ Name: enqueue ]]
    local v4 = v2._last + 1;
    v2._last = v4;
    v2._queue[v4] = v3;
end;
v0.dequeue = function(v5) --[[ Line: 37 ]] --[[ Name: dequeue ]]
    if v5:isEmpty() then
        error("Cannot dequeue from empty queue");
    end;
    local l__first_0 = v5._first;
    local v7 = v5._queue[l__first_0];
    v5._queue[l__first_0] = nil;
    v5._first = l__first_0 + 1;
    return v7;
end;
return v0;