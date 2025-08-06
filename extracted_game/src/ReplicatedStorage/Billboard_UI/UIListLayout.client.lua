-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_GamepadService_0 = game:GetService("GamepadService");
local v1 = false;
local l_UserInputService_0 = game:GetService("UserInputService");
if l_UserInputService_0.GamepadEnabled and not l_UserInputService_0.KeyboardEnabled and not l_UserInputService_0.MouseEnabled then
    v1 = true;
end;
if v1 == true then
    upd = function() --[[ Line: 9 ]] --[[ Name: upd ]]
        -- upvalues: l_GamepadService_0 (copy)
        if #script.Parent:GetChildren() == 2 then
            l_GamepadService_0:DisableGamepadCursor();
            return;
        else
            l_GamepadService_0:EnableGamepadCursor(script.Parent:FindFirstChildWhichIsA("Frame"));
            return;
        end;
    end;
    script.Parent.ChildAdded:Connect(function() --[[ Line: 17 ]]
        upd();
    end);
    script.Parent.ChildRemoved:Connect(function() --[[ Line: 20 ]]
        upd();
    end);
end;