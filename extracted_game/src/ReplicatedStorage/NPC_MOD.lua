-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(game.ReplicatedStorage.Field_Of_View_Module);
local v2 = require(game.ReplicatedStorage.Frame_Popup_Module);
v0.Can_Speak = function(_) --[[ Line: 4 ]] --[[ Name: Can_Speak ]]
    -- upvalues: v1 (copy)
    local v4 = v1.Return_Core_FOV();
    local v5 = false;
    if v4 == 70 then
        v5 = true;
    end;
    return v5;
end;
v0.Start_Speak = function(_) --[[ Line: 13 ]] --[[ Name: Start_Speak ]]
    -- upvalues: v1 (copy)
    v1.Change_FOV_CORE(65);
    v1.Change_FOV(65, 2);	
end;
v0.End_Speak = function(_) --[[ Line: 17 ]] --[[ Name: End_Speak ]]
    -- upvalues: v2 (copy), v1 (copy)
    if v2.Can() == true then
        v1.Change_FOV_CORE(70);
        v1.Change_FOV(70, 1);
    end;
end;
return v0;