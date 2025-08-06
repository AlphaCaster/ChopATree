-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_UserInputService_0 = game:GetService("UserInputService");
if l_UserInputService_0.TouchEnabled == true then
    script.Parent.Visible = false;
    return;
elseif l_UserInputService_0.GamepadEnabled == true then
    script.Parent.PC.Visible = false;
    script.Parent.Console.Visible = true;
    script.Parent.Visible = true;
    return;
else
    script.Parent.PC.Visible = true;
    script.Parent.Console.Visible = false;
    script.Parent.Visible = true;
    return;
end;