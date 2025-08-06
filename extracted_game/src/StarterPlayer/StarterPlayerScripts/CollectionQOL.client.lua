-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_UserInputService_0 = game:GetService("UserInputService");
local l_ProximityPromptService_0 = game:GetService("ProximityPromptService");
local v2 = false;
local v3 = false;
local v4 = true;
local v5 = nil;
local _ = game.Players.LocalPlayer;
l_ProximityPromptService_0.PromptShown:Connect(function(v7) --[[ Line: 12 ]]
    -- upvalues: v5 (ref), v3 (ref), v4 (ref)
    v5 = v7;
    if v3 and v4 then
        v4 = false;
        task.delay(0.25, function() --[[ Line: 16 ]]
            -- upvalues: v4 (ref)
            v4 = true;
        end);
        v7:InputHoldBegin();
        return;
    else
        task.wait(0.28);
        if v3 and v5 == v7 then
            v7:InputHoldBegin();
        end;
        return;
    end;
end);
l_UserInputService_0.InputBegan:Connect(function(v8, _) --[[ Line: 35 ]]
    -- upvalues: v2 (ref), v3 (ref)
    if (v8.UserInputType == Enum.UserInputType.Keyboard or v8.UserInputType == Enum.UserInputType.Gamepad1) and (v8.KeyCode == Enum.KeyCode.E or v8.KeyCode == Enum.KeyCode.ButtonX) then
        v2 = true;
        task.wait(0.1);
        if v2 then
            v3 = true;
        end;
    end;
end);
l_UserInputService_0.InputEnded:Connect(function(v10, _) --[[ Line: 51 ]]
    -- upvalues: v2 (ref), v3 (ref)
    if (v10.UserInputType == Enum.UserInputType.Keyboard or v10.UserInputType == Enum.UserInputType.Gamepad1) and (v10.KeyCode == Enum.KeyCode.E or v10.KeyCode == Enum.KeyCode.ButtonX) then
        v2 = false;
        v3 = false;
    end;
end);