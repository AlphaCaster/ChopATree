-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local _ = game:GetService("RunService");
local l_Gift_Notification_0 = game.ReplicatedStorage.Gift_Notification;
v0.Gift = function(v3, v4, v5, _, v7) --[[ Line: 6 ]] --[[ Name: Gift ]]
    -- upvalues: l_Gift_Notification_0 (copy)
    local v8 = l_Gift_Notification_0:Clone();
    v8.Parent = v3.PlayerGui.Gift_Notification.Frame;
    v8.Holder.TextLabel.Text = v5.Name;
    v8.Holder.Tool_OBJ.Value = v5;
    v8.Holder.String_OF.Value = v7;
    v8.Holder.PLR_OBJ.Value = v4;
    v8.Holder.PLR_String.Value = v4.Name;
end;
return v0;