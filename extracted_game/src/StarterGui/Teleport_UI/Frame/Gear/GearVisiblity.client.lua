-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_Parent_0 = script.Parent;
local v2 = {
    "Real_RemorsEcoDe", 
    "JexSavron"
};
if game:GetService("RunService"):IsStudio() then
    if table.find(v2, l_LocalPlayer_0.Name) then
        l_Parent_0.Visible = true;
        return;
    else
        l_Parent_0.Visible = false;
        return;
    end;
else
    l_Parent_0.Visible = false;
    return;
end;