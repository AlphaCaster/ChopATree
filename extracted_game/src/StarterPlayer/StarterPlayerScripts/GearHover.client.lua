-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("ReplicatedStorage");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
local l_GearHover_UI_0 = l_PlayerGui_0:WaitForChild("GearHover_UI");
local l_Frame_0 = l_GearHover_UI_0:WaitForChild("Frame");
local l_GearName_0 = l_Frame_0:WaitForChild("GearName");
local l_GearInfo_0 = l_Frame_0:WaitForChild("GearInfo");
local l_Frame_1 = l_PlayerGui_0:WaitForChild("PlantHover_UI"):WaitForChild("Frame");
local l_Range_0 = script.Range;
l_GearHover_UI_0.Frame.Visible = false;
local v12 = nil;
local v13 = nil;
local v14 = nil;
local v15 = false;
local v16 = 0;
local v17 = {
    ["Basic Sprinkler"] = Vector3.new(20, 0.10000000149011612, 20, 0), 
    ["Advanced Sprinkler"] = Vector3.new(25, 0.10000000149011612, 25, 0), 
    ["Godly Sprinkler"] = Vector3.new(30, 0.10000000149011612, 30, 0), 
    ["Master Sprinkler"] = Vector3.new(60, 0.10000000149011612, 60, 0), 
    ["Lightning Rod"] = Vector3.new(70, 0.10000000149011612, 70, 0), 
    ["Chocolate Sprinkler"] = Vector3.new(20, 0.10000000149011612, 20, 0)
};
local function _(v18) --[[ Line: 37 ]] --[[ Name: formatTime ]]
    local v19 = math.floor(v18 / 60);
    local v20 = math.floor(v18 % 60);
    return string.format("%d:%02d", v19, v20);
end;
local function _() --[[ Line: 43 ]] --[[ Name: updateUIPosition ]]
    -- upvalues: l_UserInputService_0 (copy), l_GearHover_UI_0 (copy)
    local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
    l_GearHover_UI_0.Frame.Position = UDim2.new(0, l_l_UserInputService_0_MouseLocation_0.X + 20, 0, l_l_UserInputService_0_MouseLocation_0.Y + 10);
end;
local function v26(v24) --[[ Line: 48 ]] --[[ Name: getTaggedModel ]]
    local l_v24_FirstAncestorOfClass_0 = v24:FindFirstAncestorOfClass("Model");
    while true do
        if l_v24_FirstAncestorOfClass_0 then
            if l_v24_FirstAncestorOfClass_0:HasTag("Sprinkler") or l_v24_FirstAncestorOfClass_0:HasTag("LightningRod") then
                return l_v24_FirstAncestorOfClass_0;
            else
                l_v24_FirstAncestorOfClass_0 = l_v24_FirstAncestorOfClass_0:FindFirstAncestorOfClass("Model");
            end;
        else
            return nil;
        end;
    end;
end;
local function v27() --[[ Line: 61 ]] --[[ Name: stopTimeUpdates ]]
    -- upvalues: v13 (ref), v12 (ref), v14 (ref)
    if v13 then
        v13:Disconnect();
        v13 = nil;
    end;
    v12 = nil;
    if v14 then
        v14:Destroy();
        v14 = nil;
    end;
end;
local function v38(v28) --[[ Line: 74 ]] --[[ Name: updateTimeDisplay ]]
    -- upvalues: v12 (ref), v13 (ref), v14 (ref), l_Range_0 (copy), v17 (copy), l_GearName_0 (copy), l_GearInfo_0 (copy), l_RunService_0 (copy)
    if v12 == v28 then
        return;
    else
        if v13 then
            v13:Disconnect();
            v13 = nil;
        end;
        v12 = nil;
        if v14 then
            v14:Destroy();
            v14 = nil;
        end;
        v12 = v28;
        local l_Name_0 = v28.Name;
        local v30 = nil;
        if l_Name_0 == "ServerLightningRod" then
            return;
        else
            if v28:HasTag("Sprinkler") then
                v30 = "";
            elseif v28:HasTag("LightningRod") then
                v30 = "";
            end;
            if not v30 then
                return;
            else
                if v14 then
                    v14:Destroy();
                end;
                v14 = l_Range_0:Clone();
                v14.Parent = workspace.Visuals or workspace;
                v14.Size = v17[v28.Name];
                if v28.PrimaryPart then
                    local l_PrimaryPart_0 = v28.PrimaryPart;
                    local v32 = l_PrimaryPart_0.Position.Y - l_PrimaryPart_0.Size.Y / 2;
                    v14.CFrame = CFrame.new((Vector3.new(l_PrimaryPart_0.Position.X, v32 + 0.05, l_PrimaryPart_0.Position.Z)));
                end;
                l_GearName_0.Text = l_Name_0;
                local function v37() --[[ Line: 110 ]] --[[ Name: updateInfo ]]
                    -- upvalues: v28 (copy), l_GearInfo_0 (ref)
                    if v28:HasTag("Sprinkler") then
                        local v33 = v28:GetAttribute("EndTime") or 0;
                        local v34 = math.floor(v33 / 60);
                        local v35 = v33 % 60;
                        l_GearInfo_0.Text = string.format("%02d:%02d", v34, v35);
                        return;
                    else
                        if v28:HasTag("LightningRod") then
                            local l_v28_Attribute_0 = v28:GetAttribute("Uses");
                            if l_v28_Attribute_0 then
                                l_GearInfo_0.Text = l_v28_Attribute_0 == 1 and "1 Redirect Left" or string.format("%d Redirects Left", l_v28_Attribute_0);
                                return;
                            else
                                l_GearInfo_0.Text = "";
                            end;
                        end;
                        return;
                    end;
                end;
                v37();
                v13 = l_RunService_0.Heartbeat:Connect(v37);
                return;
            end;
        end;
    end;
end;
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local function v43() --[[ Line: 144 ]] --[[ Name: onMouseHover ]]
    -- upvalues: l_Frame_1 (copy), l_Frame_0 (copy), v13 (ref), v12 (ref), v14 (ref), l_l_LocalPlayer_0_Mouse_0 (copy), v26 (copy), v38 (copy), l_UserInputService_0 (copy), l_GearHover_UI_0 (copy)
    if l_Frame_1.Visible then
        l_Frame_0.Visible = false;
        if v13 then
            v13:Disconnect();
            v13 = nil;
        end;
        v12 = nil;
        if v14 then
            v14:Destroy();
            v14 = nil;
        end;
        return;
    else
        local l_Target_0 = l_l_LocalPlayer_0_Mouse_0.Target;
        if l_Target_0 then
            local v41 = v26(l_Target_0);
            if v41 then
                v38(v41);
                l_Frame_0.Visible = true;
                local l_l_UserInputService_0_MouseLocation_1 = l_UserInputService_0:GetMouseLocation();
                l_GearHover_UI_0.Frame.Position = UDim2.new(0, l_l_UserInputService_0_MouseLocation_1.X + 20, 0, l_l_UserInputService_0_MouseLocation_1.Y + 10);
                return;
            else
                if v13 then
                    v13:Disconnect();
                    v13 = nil;
                end;
                v12 = nil;
                if v14 then
                    v14:Destroy();
                    v14 = nil;
                end;
                l_Frame_0.Visible = false;
                return;
            end;
        else
            if v13 then
                v13:Disconnect();
                v13 = nil;
            end;
            v12 = nil;
            if v14 then
                v14:Destroy();
                v14 = nil;
            end;
            l_Frame_0.Visible = false;
            return;
        end;
    end;
end;
l_UserInputService_0.TouchStarted:Connect(function(_, v45) --[[ Line: 171 ]]
    -- upvalues: v15 (ref), v16 (ref)
    if v45 then
        return;
    else
        v15 = true;
        v16 = tick();
        return;
    end;
end);
l_UserInputService_0.TouchEnded:Connect(function() --[[ Line: 177 ]]
    -- upvalues: v15 (ref), v13 (ref), v12 (ref), v14 (ref), l_Frame_0 (copy)
    v15 = false;
    if v13 then
        v13:Disconnect();
        v13 = nil;
    end;
    v12 = nil;
    if v14 then
        v14:Destroy();
        v14 = nil;
    end;
    l_Frame_0.Visible = false;
end);
l_UserInputService_0.InputChanged:Connect(function(v46) --[[ Line: 184 ]]
    -- upvalues: v43 (copy)
    if v46.UserInputType == Enum.UserInputType.MouseMovement then
        v43();
    end;
end);
l_RunService_0.Heartbeat:Connect(function() --[[ Line: 190 ]]
    -- upvalues: l_Frame_0 (copy), l_UserInputService_0 (copy), l_GearHover_UI_0 (copy), v15 (ref), v16 (ref), v43 (copy)
    if l_Frame_0.Visible then
        local l_l_UserInputService_0_MouseLocation_2 = l_UserInputService_0:GetMouseLocation();
        l_GearHover_UI_0.Frame.Position = UDim2.new(0, l_l_UserInputService_0_MouseLocation_2.X + 20, 0, l_l_UserInputService_0_MouseLocation_2.Y + 10);
    end;
    if v15 and tick() - v16 >= 0.5 then
        v43();
    end;
    if l_UserInputService_0.GamepadEnabled then
        v43();
    end;
end);
l_LocalPlayer_0.CharacterRemoving:Connect(v27);