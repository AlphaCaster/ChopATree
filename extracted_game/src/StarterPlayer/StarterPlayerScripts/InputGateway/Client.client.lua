-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_UserInputService_0 = game:GetService("UserInputService");
local _ = game:GetService("Debris");
local l_Players_0 = game:GetService("Players");
local l_Parent_0 = script.Parent;
local _ = l_Parent_0.Parent;
local l_Activation_0 = l_Parent_0:WaitForChild("Activation");
local l_Mouse_0 = l_Players_0.LocalPlayer:GetMouse();
local v7 = false;
local function _(v8, v9) --[[ Line: 16 ]] --[[ Name: activate ]]
    -- upvalues: v7 (ref), l_Activation_0 (copy)
    v7 = v8;
    l_Activation_0:FireServer(v8, v9);
end;
local function v16(v11, v12) --[[ Line: 21 ]] --[[ Name: onInputBegan ]]
    -- upvalues: l_Mouse_0 (copy), v7 (ref), l_Activation_0 (copy)
    if not v12 then
        local v13 = false;
        local l_Name_0 = v11.UserInputType.Name;
        if l_Name_0 == "MouseButton1" then
            v13 = true;
        elseif l_Name_0 == "Touch" then
            wait(0.1);
            if v11.UserInputState == Enum.UserInputState.End then
                v13 = true;
            end;
        elseif l_Name_0 == "Gamepad1" and v11.KeyCode.Name == "ButtonR2" then
            v13 = true;
        end;
        if v13 then
            local l_Hit_0 = l_Mouse_0.Hit;
            v7 = true;
            l_Activation_0:FireServer(true, l_Hit_0);
        end;
    end;
end;
local function v21(v17, v18) --[[ Line: 46 ]] --[[ Name: onInputEnded ]]
    -- upvalues: v7 (ref), l_Mouse_0 (copy), l_Activation_0 (copy)
    if not v18 and v7 then
        local l_Name_1 = v17.UserInputType.Name;
        if l_Name_1 == "MouseButton1" or l_Name_1 == "Touch" or l_Name_1 == "Gamepad1" then
            local l_Hit_1 = l_Mouse_0.Hit;
            v7 = false;
            l_Activation_0:FireServer(false, l_Hit_1);
        end;
    end;
end;
l_UserInputService_0.InputBegan:Connect(v16);
l_UserInputService_0.InputEnded:Connect(v21);