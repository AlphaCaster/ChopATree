-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Field_Of_View_Module);
local v2 = require(game.ReplicatedStorage.Blur_Module);
local v3 = {};
v0.Show = function(v4) --[[ Line: 6 ]] --[[ Name: Show ]]
    -- upvalues: v3 (copy), v1 (copy), v2 (copy)
    if table.find(v3, v4) then
        table.insert(v3, v4);
    end;
    v1.Change_FOV(60, 0.3);
    v2.Blur(15, 0.1);
end;
v0.Hide = function(v5) --[[ Line: 17 ]] --[[ Name: Hide ]]
    -- upvalues: v3 (copy), v1 (copy), v2 (copy)
    local v6 = table.find(v3, v5);
    if v6 then
        table.remove(v3, v6);
    end;
    if #v3 == 0 then
        v1.Change_FOV_CORE(70, 0.3);
        v1.Change_FOV(70, 0.3);
        v2.Blur(0, 0.3);
    end;
end;
v0.Can = function() --[[ Line: 31 ]] --[[ Name: Can ]]
    -- upvalues: v3 (copy)
    return #v3 == 0;
end;
return v0;