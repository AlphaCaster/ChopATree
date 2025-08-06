-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = Color3.fromRGB(0, 162, 255);
local v1 = Color3.fromRGB(78, 84, 96);
local v2 = Color3.fromRGB(204, 204, 204);
local v3 = Color3.fromRGB(255, 255, 255);
local v4 = Color3.fromRGB(150, 150, 150);
local l_HttpService_0 = game:GetService("HttpService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
local l_RunService_0 = game:GetService("RunService");
local l_PlayerGui_0 = game.Players.LocalPlayer.PlayerGui;
local _ = l_PlayerGui_0:WaitForChild("BackpackGui");
local l_ContextActionService_0 = game:GetService("ContextActionService");
local l_VRService_0 = game:GetService("VRService");
local l_status_0, l_result_0 = pcall(function() --[[ Line: 39 ]]
    return false;
end);
local v15 = l_status_0 and l_result_0;
local v22 = {
    Create = function(v16) --[[ Line: 48 ]] --[[ Name: Create ]]
        return function(v17) --[[ Line: 49 ]]
            -- upvalues: v16 (copy)
            local v18 = Instance.new(v16);
            local v19 = nil;
            for v20, v21 in pairs(v17) do
                if type(v20) == "number" then
                    v21.Parent = v18;
                elseif v20 == "Parent" then
                    v19 = v21;
                else
                    v18[v20] = v21;
                end;
            end;
            if v19 then
                v18.Parent = v19;
            end;
            return v18;
        end;
    end
};
local v23 = {};
setmetatable(v23, {
    __mode = "k"
});
local v24 = v22.Create("ImageLabel")({
    Image = "", 
    BackgroundTransparency = 1
});
clamp = function(v25, v26, v27) --[[ Line: 81 ]] --[[ Name: clamp ]]
    return (math.max(v25, (math.min(v26, v27))));
end;
ClampVector2 = function(v28, v29, v30) --[[ Line: 85 ]] --[[ Name: ClampVector2 ]]
    return Vector2.new(clamp(v28.x, v29.x, v30.x), clamp(v28.y, v29.y, v30.y));
end;
local function v35(v31, v32, v33, v34) --[[ Line: 90 ]] --[[ Name: Linear ]]
    if v34 <= v31 then
        return v32 + v33;
    else
        return v33 * v31 / v34 + v32;
    end;
end;
local function v40(v36, v37, v38, v39) --[[ Line: 98 ]] --[[ Name: EaseOutQuad ]]
    if v39 <= v36 then
        return v37 + v38;
    else
        v36 = v36 / v39;
        return v37 - v38 * v36 * (v36 - 2);
    end;
end;
local function v45(v41, v42, v43, v44) --[[ Line: 107 ]] --[[ Name: EaseInOutQuad ]]
    if v44 <= v41 then
        return v42 + v43;
    else
        v41 = v41 / v44;
        if v41 < 0.5 then
            return 2 * v43 * v41 * v41 + v42;
        else
            return v42 + v43 * (2 * (2 - v41) * v41 - 1);
        end;
    end;
end;
PropertyTweener = function(v46, v47, v48, v49, v50, v51, v52) --[[ Line: 119 ]] --[[ Name: PropertyTweener ]]
    -- upvalues: l_RunService_0 (copy)
    local v53 = {
        StartTime = tick()
    };
    v53.EndTime = v53.StartTime + v50;
    v53.Cancelled = false;
    local v54 = false;
    local v55 = 0;
    local function _() --[[ Line: 128 ]] --[[ Name: finalize ]]
        -- upvalues: v46 (copy), v47 (copy), v51 (copy), v48 (copy), v49 (copy), v54 (ref), v55 (ref), v52 (copy)
        if v46 then
            v46[v47] = v51(1, v48, v49 - v48, 1);
        end;
        v54 = true;
        v55 = 1;
        if v52 then
            v52();
        end;
    end;
    v46[v47] = v51(0, v48, v49 - v48, v50);
    coroutine.wrap(function() --[[ Line: 141 ]]
        -- upvalues: v53 (copy), v46 (copy), v47 (copy), v51 (copy), v48 (copy), v49 (copy), v50 (copy), v55 (ref), l_RunService_0 (ref), v54 (ref), v52 (copy)
        local v57 = tick();
        while true do
            if v57 < v53.EndTime and v46 then
                if v53.Cancelled then
                    return;
                else
                    v46[v47] = v51(v57 - v53.StartTime, v48, v49 - v48, v50);
                    v55 = clamp(0, 1, (v57 - v53.StartTime) / v50);
                    l_RunService_0.RenderStepped:wait();
                    v57 = tick();
                end;
            else
                if v53.Cancelled == false and v46 then
                    if v46 then
                        v46[v47] = v51(1, v48, v49 - v48, 1);
                    end;
                    v54 = true;
                    v55 = 1;
                    if v52 then
                        v52();
                    end;
                end;
                return;
            end;
        end;
    end)();
    v53.GetFinal = function(_) --[[ Line: 157 ]] --[[ Name: GetFinal ]]
        -- upvalues: v49 (copy)
        return v49;
    end;
    v53.GetPercentComplete = function(_) --[[ Line: 161 ]] --[[ Name: GetPercentComplete ]]
        -- upvalues: v55 (ref)
        return v55;
    end;
    v53.IsFinished = function(_) --[[ Line: 165 ]] --[[ Name: IsFinished ]]
        -- upvalues: v54 (ref)
        return v54;
    end;
    v53.Finish = function(v61) --[[ Line: 169 ]] --[[ Name: Finish ]]
        -- upvalues: v54 (ref), v46 (copy), v47 (copy), v51 (copy), v48 (copy), v49 (copy), v55 (ref), v52 (copy)
        if not v54 then
            v61:Cancel();
            if v46 then
                v46[v47] = v51(1, v48, v49 - v48, 1);
            end;
            v54 = true;
            v55 = 1;
            if v52 then
                v52();
            end;
        end;
    end;
    v53.Cancel = function(_) --[[ Line: 176 ]] --[[ Name: Cancel ]]
        -- upvalues: v53 (copy)
        v53.Cancelled = true;
    end;
    return v53;
end;
local function v71() --[[ Line: 185 ]] --[[ Name: CreateSignal ]]
    local v63 = {};
    local l_BindableEvent_0 = Instance.new("BindableEvent");
    local v65 = nil;
    local v66 = nil;
    v63.fire = function(_, ...) --[[ Line: 193 ]] --[[ Name: fire ]]
        -- upvalues: v65 (ref), v66 (ref), l_BindableEvent_0 (copy)
        v65 = {
            ...
        };
        v66 = select("#", ...);
        l_BindableEvent_0:Fire();
    end;
    v63.connect = function(_, v69) --[[ Line: 199 ]] --[[ Name: connect ]]
        -- upvalues: l_BindableEvent_0 (copy), v65 (ref), v66 (ref)
        if not v69 then
            error("connect(nil)", 2);
        end;
        return l_BindableEvent_0.Event:Connect(function() --[[ Line: 201 ]]
            -- upvalues: v69 (copy), v65 (ref), v66 (ref)
            v69(unpack(v65, 1, v66));
        end);
    end;
    v63.wait = function(_) --[[ Line: 206 ]] --[[ Name: wait ]]
        -- upvalues: l_BindableEvent_0 (copy), v65 (ref), v66 (ref)
        l_BindableEvent_0.Event:wait();
        if not v65 then
            error("Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.");
        end;
        return unpack(v65, 1, v66);
    end;
    return v63;
end;
local function v72() --[[ Line: 217 ]] --[[ Name: getViewportSize ]]
    while not workspace.CurrentCamera do
        workspace.Changed:wait();
    end;
    while workspace.CurrentCamera.ViewportSize == Vector2.new(0, 0) or workspace.CurrentCamera.ViewportSize == Vector2.new(1, 1) do
        workspace.CurrentCamera.Changed:wait();
    end;
    return workspace.CurrentCamera.ViewportSize;
end;
local function _() --[[ Line: 232 ]] --[[ Name: isSmallTouchScreen ]]
    -- upvalues: v72 (copy), l_UserInputService_0 (copy)
    local v73 = v72();
    return l_UserInputService_0.TouchEnabled and (v73.Y < 500 or v73.X < 700);
end;
local function _() --[[ Line: 237 ]] --[[ Name: isPortrait ]]
    -- upvalues: v72 (copy)
    local v75 = v72();
    return v75.Y > v75.X;
end;
local function _() --[[ Line: 242 ]] --[[ Name: isTenFootInterface ]]
    return false;
end;
local function _() --[[ Line: 246 ]] --[[ Name: usesSelectedObject ]]
    -- upvalues: l_VRService_0 (copy), l_UserInputService_0 (copy)
    if l_VRService_0.VREnabled then
        return false;
    elseif l_UserInputService_0.TouchEnabled and not l_UserInputService_0.GamepadEnabled then
        return false;
    else
        return true;
    end;
end;
local _ = function(v79, v80, _) --[[ Line: 255 ]] --[[ Name: isPosOverGui ]]
    local l_x_0 = v80.AbsolutePosition.x;
    local l_y_0 = v80.AbsolutePosition.y;
    local l_x_1 = v80.AbsoluteSize.x;
    local l_y_1 = v80.AbsoluteSize.y;
    local v86 = l_x_0 + l_x_1;
    local v87 = l_y_0 + l_y_1;
    local v88 = false;
    if l_x_0 < v79.x then
        v88 = false;
        if v79.x < v86 then
            v88 = false;
            if l_y_0 < v79.y then
                v88 = v79.y < v87;
            end;
        end;
    end;
    return v88;
end;
local function _(v90, v91) --[[ Line: 263 ]] --[[ Name: isPosOverGuiWithClipping ]]
    local l_x_2 = v91.AbsolutePosition.x;
    local l_y_2 = v91.AbsolutePosition.y;
    local l_x_3 = v91.AbsoluteSize.x;
    local l_y_3 = v91.AbsoluteSize.y;
    local v96 = l_x_2 + l_x_3;
    local v97 = l_y_2 + l_y_3;
    local v98 = false;
    if l_x_2 < v90.x then
        v98 = false;
        if v90.x < v96 then
            v98 = false;
            if l_y_2 < v90.y then
                v98 = v90.y < v97;
            end;
        end;
    end;
    if not v98 then
        return false;
    else
        v98 = false;
        l_x_2 = v91;
        while true do
            if l_x_2 == nil or not l_x_2:IsA("GuiObject") and not l_x_2:IsA("LayerCollector") then
                v98 = true;
                if l_x_2 and l_x_2:IsA("CoreGui") then
                    v98 = false;
                    break;
                else
                    break;
                end;
            elseif l_x_2:IsA("GuiObject") and not l_x_2.Visible then
                v98 = true;
                break;
            else
                if l_x_2:IsA("LayerCollector") or l_x_2.ClipsDescendants then
                    l_x_3 = l_x_2;
                    l_y_3 = l_x_3.AbsolutePosition.x;
                    v96 = l_x_3.AbsolutePosition.y;
                    v97 = l_x_3.AbsoluteSize.x;
                    local l_y_4 = l_x_3.AbsoluteSize.y;
                    local v100 = l_y_3 + v97;
                    local v101 = v96 + l_y_4;
                    l_y_2 = false;
                    if l_y_3 < v90.x then
                        l_y_2 = false;
                        if v90.x < v100 then
                            l_y_2 = false;
                            if v96 < v90.y then
                                l_y_2 = v90.y < v101;
                            end;
                        end;
                    end;
                    if not l_y_2 then
                        v98 = true;
                        break;
                    end;
                end;
                l_x_2 = l_x_2.Parent;
            end;
        end;
        return not v98;
    end;
end;
local function _(v103, v104) --[[ Line: 296 ]] --[[ Name: areGuisIntersecting ]]
    local l_x_4 = v103.AbsolutePosition.x;
    local l_y_5 = v103.AbsolutePosition.y;
    local l_x_5 = v103.AbsoluteSize.x;
    local l_y_6 = v103.AbsoluteSize.y;
    local v109 = l_x_4 + l_x_5;
    local v110 = l_y_5 + l_y_6;
    local l_x_6 = v104.AbsolutePosition.x;
    local l_y_7 = v104.AbsolutePosition.y;
    local l_x_7 = v104.AbsoluteSize.x;
    local l_y_8 = v104.AbsoluteSize.y;
    local v115 = l_x_6 + l_x_7;
    local v116 = l_y_7 + l_y_8;
    local v117 = false;
    if l_x_4 < v115 then
        v117 = l_x_6 < v109;
    end;
    local v118 = false;
    if l_y_5 < v116 then
        v118 = l_y_7 < v110;
    end;
    return v117 and v118;
end;
local _ = function(v120, _) --[[ Line: 311 ]] --[[ Name: isGuiVisible ]]
    local v122 = false;
    local l_v120_0 = v120;
    while true do
        if l_v120_0 == nil or not l_v120_0:IsA("GuiObject") and not l_v120_0:IsA("LayerCollector") then
            v122 = true;
            if l_v120_0 and l_v120_0:IsA("CoreGui") then
                v122 = false;
                break;
            else
                break;
            end;
        elseif l_v120_0:IsA("GuiObject") and not l_v120_0.Visible then
            v122 = true;
            break;
        else
            if l_v120_0:IsA("LayerCollector") or l_v120_0.ClipsDescendants then
                local l_l_v120_0_0 = l_v120_0;
                local l_x_8 = l_l_v120_0_0.AbsolutePosition.x;
                local l_y_9 = l_l_v120_0_0.AbsolutePosition.y;
                local l_x_9 = l_l_v120_0_0.AbsoluteSize.x;
                local l_y_10 = l_l_v120_0_0.AbsoluteSize.y;
                local v129 = l_x_8 + l_x_9;
                local v130 = l_y_9 + l_y_10;
                local l_x_10 = v120.AbsolutePosition.x;
                local l_y_11 = v120.AbsolutePosition.y;
                local l_x_11 = v120.AbsoluteSize.x;
                local l_y_12 = v120.AbsoluteSize.y;
                local v135 = l_x_10 + l_x_11;
                local v136 = l_y_11 + l_y_12;
                local v137 = false;
                if l_x_8 < v135 then
                    v137 = l_x_10 < v129;
                end;
                local v138 = false;
                if l_y_9 < v136 then
                    v138 = l_y_11 < v130;
                end;
                if not (v137 and v138) then
                    v122 = true;
                    break;
                end;
            end;
            l_v120_0 = l_v120_0.Parent;
        end;
    end;
    return not v122;
end;
local function v146(v140, v141, v142, v143) --[[ Line: 340 ]] --[[ Name: addHoverState ]]
    local function v144() --[[ Line: 341 ]] --[[ Name: onNormalButtonStateCallback ]]
        -- upvalues: v140 (copy), v142 (copy), v141 (copy)
        if v140.Active then
            v142(v141);
        end;
    end;
    local function v145() --[[ Line: 346 ]] --[[ Name: onHoverButtonStateCallback ]]
        -- upvalues: v140 (copy), v143 (copy), v141 (copy)
        if v140.Active then
            v143(v141);
        end;
    end;
    v140.MouseEnter:Connect(v145);
    v140.SelectionGained:Connect(v145);
    v140.MouseLeave:Connect(v144);
    v140.SelectionLost:Connect(v144);
    v142(v141);
end;
local function v152(v147, v148) --[[ Line: 360 ]] --[[ Name: addOnResizedCallback ]]
    -- upvalues: v23 (copy), v72 (copy)
    v23[v147] = v148;
    local l_v148_0 = v148;
    local v150 = v72();
    local v151 = v72();
    l_v148_0(v150, v151.Y > v151.X);
end;
local v153 = {
    [Enum.UserInputType.Gamepad1] = true, 
    [Enum.UserInputType.Gamepad2] = true, 
    [Enum.UserInputType.Gamepad3] = true, 
    [Enum.UserInputType.Gamepad4] = true, 
    [Enum.UserInputType.Gamepad5] = true, 
    [Enum.UserInputType.Gamepad6] = true, 
    [Enum.UserInputType.Gamepad7] = true, 
    [Enum.UserInputType.Gamepad8] = true
};
local function v183(v154, v155, v156, v157, v158) --[[ Line: 376 ]] --[[ Name: MakeDefaultButton ]]
    -- upvalues: v22 (copy), v153 (copy), l_UserInputService_0 (copy), l_GuiService_0 (copy), l_VRService_0 (copy)
    local v159 = v22.Create("ImageLabel")({
        Image = "", 
        BackgroundTransparency = 1
    });
    local v160 = v22.Create("ImageButton")({
        Name = v154 .. "Button", 
        Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png", 
        ScaleType = Enum.ScaleType.Slice, 
        SliceCenter = Rect.new(8, 6, 46, 44), 
        AutoButtonColor = false, 
        BackgroundTransparency = 1, 
        Size = v155, 
        ZIndex = 2, 
        SelectionImageObject = v159
    });
    local _ = v22.Create("BoolValue")({
        Name = "Enabled", 
        Parent = v160, 
        Value = true
    });
    if v156 then
        v160.MouseButton1Click:Connect(function() --[[ Line: 404 ]]
            -- upvalues: v156 (copy), v153 (ref), l_UserInputService_0 (ref)
            v156(v153[l_UserInputService_0:GetLastInputType()] or false);
        end);
    end;
    local function _(v162) --[[ Line: 409 ]] --[[ Name: isPointerInput ]]
        local v163 = true;
        if v162.UserInputType ~= Enum.UserInputType.MouseMovement then
            v163 = v162.UserInputType == Enum.UserInputType.Touch;
        end;
        return v163;
    end;
    local v165 = nil;
    local function v167(v166) --[[ Line: 414 ]] --[[ Name: setRowRef ]]
        -- upvalues: v165 (ref)
        v165 = v166;
    end;
    local function _() --[[ Line: 418 ]] --[[ Name: selectButton ]]
        -- upvalues: v158 (copy), v157 (copy), v160 (copy), v165 (ref)
        local l_v158_0 = v158;
        if l_v158_0 == nil and v157 then
            l_v158_0 = v157.HubRef;
        end;
        if l_v158_0 and l_v158_0.Active or l_v158_0 == nil then
            v160.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png";
            local l_v160_0 = v160;
            if v165 then
                l_v160_0 = v165;
            end;
            if l_v158_0 then
                l_v158_0:ScrollToFrame(l_v160_0);
            end;
        end;
    end;
    local function _() --[[ Line: 439 ]] --[[ Name: deselectButton ]]
        -- upvalues: v160 (copy)
        v160.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png";
    end;
    v160.InputBegan:Connect(function(v172) --[[ Line: 443 ]]
        -- upvalues: v160 (copy), v158 (copy), v157 (copy), v165 (ref)
        if v160.Selectable then
            local v173 = true;
            if v172.UserInputType ~= Enum.UserInputType.MouseMovement then
                v173 = v172.UserInputType == Enum.UserInputType.Touch;
            end;
            if v173 then
                v173 = v158;
                if v173 == nil and v157 then
                    v173 = v157.HubRef;
                end;
                if v173 and v173.Active or v173 == nil then
                    v160.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png";
                    local l_v160_1 = v160;
                    if v165 then
                        l_v160_1 = v165;
                    end;
                    if v173 then
                        v173:ScrollToFrame(l_v160_1);
                    end;
                end;
            end;
        end;
    end);
    v160.InputEnded:Connect(function(v175) --[[ Line: 448 ]]
        -- upvalues: v160 (copy), l_GuiService_0 (ref)
        if v160.Selectable and l_GuiService_0.SelectedCoreObject ~= v160 then
            local v176 = true;
            if v175.UserInputType ~= Enum.UserInputType.MouseMovement then
                v176 = v175.UserInputType == Enum.UserInputType.Touch;
            end;
            if v176 then
                v160.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png";
            end;
        end;
    end);
    v160.SelectionGained:Connect(function() --[[ Line: 455 ]]
        -- upvalues: v158 (copy), v157 (copy), v160 (copy), v165 (ref)
        local l_v158_1 = v158;
        if l_v158_1 == nil and v157 then
            l_v158_1 = v157.HubRef;
        end;
        if l_v158_1 and l_v158_1.Active or l_v158_1 == nil then
            v160.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png";
            local l_v160_2 = v160;
            if v165 then
                l_v160_2 = v165;
            end;
            if l_v158_1 then
                l_v158_1:ScrollToFrame(l_v160_2);
            end;
        end;
    end);
    v160.SelectionLost:Connect(function() --[[ Line: 458 ]]
        -- upvalues: v160 (copy)
        v160.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png";
    end);
    local _ = l_GuiService_0.Changed:Connect(function(v179) --[[ Line: 462 ]]
        -- upvalues: l_VRService_0 (ref), l_UserInputService_0 (ref), l_GuiService_0 (ref), v160 (copy), v158 (copy), v157 (copy), v165 (ref)
        if v179 ~= "SelectedCoreObject" then
            return;
        elseif not (not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false)) then
            return;
        elseif l_GuiService_0.SelectedCoreObject == nil or l_GuiService_0.SelectedCoreObject ~= v160 then
            v160.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png";
            return;
        else
            if v160.Selectable then
                local l_v158_2 = v158;
                if l_v158_2 == nil and v157 then
                    l_v158_2 = v157.HubRef;
                end;
                if l_v158_2 and l_v158_2.Active or l_v158_2 == nil then
                    v160.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png";
                    local l_v160_3 = v160;
                    if v165 then
                        l_v160_3 = v165;
                    end;
                    if l_v158_2 then
                        l_v158_2:ScrollToFrame(l_v160_3);
                    end;
                end;
            end;
            return;
        end;
    end);
    return v160, v167;
end;
local function v195(v184, v185, v186, v187, v188, v189) --[[ Line: 479 ]] --[[ Name: MakeButton ]]
    -- upvalues: v183 (copy), v22 (copy), v72 (copy), l_UserInputService_0 (copy)
    local v190, v191 = v183(v184, v186, v187, v188, v189);
    local v192 = v22.Create("TextLabel")({
        Name = v184 .. "TextLabel", 
        BackgroundTransparency = 1, 
        BorderSizePixel = 0, 
        Size = UDim2.new(1, 0, 1, -8), 
        Position = UDim2.new(0, 0, 0, 0), 
        TextColor3 = Color3.fromRGB(255, 255, 255), 
        TextYAlignment = Enum.TextYAlignment.Center, 
        Font = Enum.Font.SourceSansBold, 
        TextSize = 24, 
        Text = v185, 
        TextScaled = true, 
        TextWrapped = true, 
        ZIndex = 2, 
        Parent = v190
    });
    local v193 = Instance.new("UITextSizeConstraint", v192);
    local v194 = v72();
    if l_UserInputService_0.TouchEnabled and (v194.Y < 500 or v194.X < 700) then
        v192.TextSize = 18;
    elseif false then
        v192.TextSize = 36;
    end;
    v193.MaxTextSize = v192.TextSize;
    return v190, v192, v191;
end;
local function v205(v196, v197, v198, v199, v200, v201, v202) --[[ Line: 511 ]] --[[ Name: MakeImageButton ]]
    -- upvalues: v183 (copy), v22 (copy)
    local v203, v204 = v183(v196, v198, v200, v201, v202);
    return v203, v22.Create("ImageLabel")({
        Name = v196 .. "ImageLabel", 
        BackgroundTransparency = 1, 
        BorderSizePixel = 0, 
        Size = v199, 
        Position = UDim2.new(0.5, 0, 0.5, 0), 
        AnchorPoint = Vector2.new(0.5, 0.5), 
        Image = v197, 
        ZIndex = 2, 
        Parent = v203
    }), v204;
end;
local function v216(v206, v207, v208, v209, v210, v211) --[[ Line: 530 ]] --[[ Name: AddButtonRow ]]
    -- upvalues: v195 (copy), v22 (copy)
    local v212, v213, v214 = v195(v207, v208, v209, v210, v206, v211);
    local v215 = v22.Create("Frame")({
        Name = v207 .. "Row", 
        BackgroundTransparency = 1, 
        Size = UDim2.new(1, 0, v209.Y.Scale, v209.Y.Offset), 
        Parent = v206.Page
    });
    v212.Parent = v215;
    v212.AnchorPoint = Vector2.new(1, 0);
    v212.Position = UDim2.new(1, -20, 0, 0);
    return v215, v212, v213, v214;
end;
local function v288(v217, v218, v219) --[[ Line: 545 ]] --[[ Name: CreateDropDown ]]
    -- upvalues: l_HttpService_0 (copy), v22 (copy), l_PlayerGui_0 (copy), l_VRService_0 (copy), l_UserInputService_0 (copy), l_GuiService_0 (copy), l_ContextActionService_0 (copy), v195 (copy)
    local v220 = Color3.fromRGB(178, 178, 178);
    local v221 = Color3.fromRGB(229, 229, 229);
    local v222 = Color3.fromRGB(255, 255, 255);
    local v223 = nil;
    local v224 = {
        CurrentIndex = nil
    };
    Instance.new("BindableEvent").Name = "IndexChanged";
    if type(v217) ~= "table" then
        error("CreateDropDown dropDownStringTable (first arg) is not a table", 2);
        return v224;
    else
        local l_BindableEvent_1 = Instance.new("BindableEvent");
        l_BindableEvent_1.Name = "IndexChanged";
        local v226 = true;
        local v227 = l_HttpService_0:GenerateGUID(false);
        local v228 = nil;
        local l_v217_0 = v217;
        local v230 = v22.Create("ImageButton")({
            Name = "DropDownFullscreenFrame", 
            BackgroundTransparency = 0.2, 
            BorderSizePixel = 0, 
            Size = UDim2.new(1, 0, 1, 0), 
            BackgroundColor3 = Color3.fromRGB(0, 0, 0), 
            ZIndex = 10, 
            Active = true, 
            Visible = false, 
            Selectable = false, 
            AutoButtonColor = false, 
            Parent = l_PlayerGui_0.RobloxGui
        });
        local function v232(v231) --[[ Line: 592 ]] --[[ Name: onVREnabled ]]
            -- upvalues: l_VRService_0 (ref), l_PlayerGui_0 (ref), v230 (copy), v224 (copy), l_v217_0 (ref)
            if v231 ~= "VREnabled" then
                return;
            else
                if l_VRService_0.VREnabled then
                    v230.Parent = require(l_PlayerGui_0.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):GetGUI();
                    v230.BackgroundTransparency = 1;
                else
                    v230.Parent = l_PlayerGui_0.RobloxGui;
                    v230.BackgroundTransparency = 0.2;
                end;
                if v224.UpdateDropDownList then
                    v224:UpdateDropDownList(l_v217_0);
                end;
                return;
            end;
        end;
        l_VRService_0.Changed:Connect(v232);
        v232("VREnabled");
        local v233 = v22.Create("ImageLabel")({
            Name = "DropDownSelectionFrame", 
            Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png", 
            ScaleType = Enum.ScaleType.Slice, 
            SliceCenter = Rect.new(8, 6, 46, 44), 
            BackgroundTransparency = 1, 
            Size = UDim2.new(0.6, 0, 0.9, 0), 
            Position = UDim2.new(0.5, 0, 0.5, 0), 
            AnchorPoint = Vector2.new(0.5, 0.5), 
            ZIndex = 10, 
            Parent = v230
        });
        local v234 = v22.Create("ScrollingFrame")({
            Name = "DropDownScrollingFrame", 
            BackgroundTransparency = 1, 
            BorderSizePixel = 0, 
            Size = UDim2.new(1, -20, 1, -25), 
            Position = UDim2.new(0, 10, 0, 10), 
            ZIndex = 10, 
            Parent = v233
        });
        local v235 = nil;
        local v236 = false;
        local function v239(v237, v238) --[[ Line: 640 ]]
            -- upvalues: v224 (copy), v226 (ref), v219 (copy), v230 (copy), l_VRService_0 (ref), l_UserInputService_0 (ref), l_GuiService_0 (ref), v223 (ref), v235 (ref), l_ContextActionService_0 (ref), v227 (copy), v228 (ref), v236 (ref), l_PlayerGui_0 (ref)
            if v237 ~= nil and v238 ~= Enum.UserInputState.Begin then
                return;
            else
                v224.DropDownFrame.Selectable = v226;
                v219:SetActive(true);
                if v230.Visible and not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) then
                    l_GuiService_0.SelectedCoreObject = v223;
                end;
                v230.Visible = false;
                if v235 then
                    v235:Disconnect();
                end;
                l_ContextActionService_0:UnbindAction(v227 .. "Action");
                l_ContextActionService_0:UnbindAction(v227 .. "FreezeAction");
                v228.Value = v226;
                v236 = false;
                if l_VRService_0.VREnabled then
                    require(l_PlayerGui_0.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):SetSubpanelDepth(v230, 0);
                end;
                return;
            end;
        end;
        local function v240() --[[ Line: 664 ]]

        end;
        local function v242() --[[ Line: 666 ]]
            -- upvalues: v226 (ref), v224 (copy), v236 (ref), v230 (copy), l_VRService_0 (ref), l_PlayerGui_0 (ref), v223 (ref), l_GuiService_0 (ref), v235 (ref), v222 (copy), v221 (copy), v220 (copy), l_ContextActionService_0 (ref), v227 (copy), v240 (copy), v239 (copy), v219 (copy), v228 (ref)
            if not v226 then
                return;
            else
                v224.DropDownFrame.Selectable = false;
                v236 = true;
                v230.Visible = true;
                if l_VRService_0.VREnabled then
                    require(l_PlayerGui_0.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):SetSubpanelDepth(v230, 0.5);
                end;
                v223 = v224.DropDownFrame;
                if v224.CurrentIndex and v224.CurrentIndex > 0 then
                    l_GuiService_0.SelectedCoreObject = v224.Selections[v224.CurrentIndex];
                end;
                v235 = l_GuiService_0:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() --[[ Line: 683 ]]
                    -- upvalues: v224 (ref), l_GuiService_0 (ref), v222 (ref), l_VRService_0 (ref), v221 (ref), v220 (ref)
                    for v241 = 1, #v224.Selections do
                        if l_GuiService_0.SelectedCoreObject == v224.Selections[v241] then
                            v224.Selections[v241].TextColor3 = v222;
                        else
                            v224.Selections[v241].TextColor3 = l_VRService_0.VREnabled and v221 or v220;
                        end;
                    end;
                end);
                l_ContextActionService_0:BindActionAtPriority(v227 .. "FreezeAction", v240, false, Enum.ContextActionPriority.High.Value, Enum.UserInputType.Keyboard, Enum.UserInputType.Gamepad1);
                l_ContextActionService_0:BindActionAtPriority(v227 .. "Action", v239, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.ButtonB, Enum.KeyCode.Escape);
                v219:SetActive(false);
                v228.Value = false;
                return;
            end;
        end;
        local v243 = UDim2.new(0.6, 0, 0, 50);
        v224.DropDownFrame = v195("DropDownFrame", "Choose One", v243, v242, nil, v219);
        v224.DropDownFrame.Position = UDim2.new(1, 0, 0.5, 0);
        v224.DropDownFrame.AnchorPoint = Vector2.new(1, 0.5);
        v228 = v224.DropDownFrame.Enabled;
        local l_DropDownFrameTextLabel_0 = v224.DropDownFrame.DropDownFrameTextLabel;
        l_DropDownFrameTextLabel_0.Position = UDim2.new(0, 15, 0, 0);
        l_DropDownFrameTextLabel_0.Size = UDim2.new(1, -50, 1, -8);
        l_DropDownFrameTextLabel_0.ClipsDescendants = true;
        l_DropDownFrameTextLabel_0.TextXAlignment = Enum.TextXAlignment.Left;
        local v245 = v22.Create("ImageLabel")({
            Name = "DropDownImage", 
            Image = "rbxasset://textures/ui/Settings/DropDown/DropDown.png", 
            BackgroundTransparency = 1, 
            AnchorPoint = Vector2.new(1, 0.5), 
            Size = UDim2.new(0, 15, 0, 10), 
            Position = UDim2.new(1, -12, 0.5, 0), 
            ZIndex = 2, 
            Parent = v224.DropDownFrame
        });
        v224.DropDownImage = v245;
        local function v250(v246) --[[ Line: 727 ]] --[[ Name: setSelection ]]
            -- upvalues: v224 (copy), l_DropDownFrameTextLabel_0 (copy), l_BindableEvent_1 (copy)
            local v247 = false;
            for v248, v249 in pairs(v224.Selections) do
                if v248 == v246 then
                    l_DropDownFrameTextLabel_0.Text = v249.Text;
                    v224.CurrentIndex = v248;
                    v247 = true;
                end;
            end;
            if v247 then
                l_BindableEvent_1:Fire(v246);
            end;
        end;
        local function v255(v251) --[[ Line: 743 ]] --[[ Name: setSelectionByValue ]]
            -- upvalues: v224 (copy), l_DropDownFrameTextLabel_0 (copy), l_BindableEvent_1 (copy)
            local v252 = false;
            for v253, v254 in pairs(v224.Selections) do
                if v254.Text == v251 then
                    l_DropDownFrameTextLabel_0.Text = v254.Text;
                    v224.CurrentIndex = v253;
                    v252 = true;
                end;
            end;
            if v252 then
                l_BindableEvent_1:Fire(v224.CurrentIndex);
            end;
            return v252;
        end;
        local v256 = false;
        local function _(v257) --[[ Line: 761 ]] --[[ Name: processInput ]]
            -- upvalues: l_GuiService_0 (ref), v224 (copy), v256 (ref), v242 (copy)
            if v257.UserInputState == Enum.UserInputState.Begin then
                if v257.KeyCode == Enum.KeyCode.Return and (l_GuiService_0.SelectedCoreObject == v224.DropDownFrame or v224.SelectionInfo and v224.SelectionInfo[l_GuiService_0.SelectedCoreObject]) then
                    v256 = true;
                    return;
                end;
            elseif v257.UserInputState == Enum.UserInputState.End and v257.KeyCode == Enum.KeyCode.Return and v256 then
                v256 = false;
                if l_GuiService_0.SelectedCoreObject == v224.DropDownFrame then
                    v242();
                    return;
                elseif v224.SelectionInfo and v224.SelectionInfo[l_GuiService_0.SelectedCoreObject] then
                    v224.SelectionInfo[l_GuiService_0.SelectedCoreObject].Clicked();
                end;
            end;
        end;
        local function _(v259) --[[ Line: 781 ]] --[[ Name: setIsFaded ]]
            -- upvalues: v224 (copy)
            if v259 then
                v224.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0.5;
                v224.DropDownFrame.ImageTransparency = 0.5;
                v224.DropDownImage.ImageTransparency = 0.5;
                return;
            else
                v224.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0;
                v224.DropDownFrame.ImageTransparency = 0;
                v224.DropDownImage.ImageTransparency = 0;
                return;
            end;
        end;
        v224.IndexChanged = l_BindableEvent_1.Event;
        v224.SetSelectionIndex = function(_, v262) --[[ Line: 797 ]] --[[ Name: SetSelectionIndex ]]
            -- upvalues: v250 (copy)
            v250(v262);
        end;
        v224.SetSelectionByValue = function(_, v264) --[[ Line: 801 ]] --[[ Name: SetSelectionByValue ]]
            -- upvalues: v255 (copy)
            return (v255(v264));
        end;
        v224.ResetSelectionIndex = function(_) --[[ Line: 805 ]] --[[ Name: ResetSelectionIndex ]]
            -- upvalues: v224 (copy), l_DropDownFrameTextLabel_0 (copy), v239 (copy)
            v224.CurrentIndex = nil;
            l_DropDownFrameTextLabel_0.Text = "Choose One";
            v239();
        end;
        v224.GetSelectedIndex = function(_) --[[ Line: 811 ]] --[[ Name: GetSelectedIndex ]]
            -- upvalues: v224 (copy)
            return v224.CurrentIndex;
        end;
        v224.SetZIndex = function(_, v268) --[[ Line: 815 ]] --[[ Name: SetZIndex ]]
            -- upvalues: v224 (copy), v245 (copy), l_DropDownFrameTextLabel_0 (copy)
            v224.DropDownFrame.ZIndex = v268;
            v245.ZIndex = v268;
            l_DropDownFrameTextLabel_0.ZIndex = v268;
        end;
        v224.SetInteractable = function(_, v270) --[[ Line: 821 ]] --[[ Name: SetInteractable ]]
            -- upvalues: v226 (ref), v224 (copy), v239 (copy), l_VRService_0 (ref), v228 (ref), v236 (ref)
            v226 = v270;
            v224.DropDownFrame.Selectable = v226;
            if not v226 then
                v239();
                if l_VRService_0.VREnabled then
                    v224.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0.5;
                    v224.DropDownFrame.ImageTransparency = 0.5;
                    v224.DropDownImage.ImageTransparency = 0.5;
                else
                    v224.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0;
                    v224.DropDownFrame.ImageTransparency = 0;
                    v224.DropDownImage.ImageTransparency = 0;
                end;
                if not l_VRService_0.VREnabled then
                    v224:SetZIndex(1);
                end;
            else
                v224.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0;
                v224.DropDownFrame.ImageTransparency = 0;
                v224.DropDownImage.ImageTransparency = 0;
                if not l_VRService_0.VREnabled then
                    v224:SetZIndex(2);
                end;
            end;
            v228.Value = v270 and not v236;
        end;
        v224.UpdateDropDownList = function(_, v272) --[[ Line: 842 ]] --[[ Name: UpdateDropDownList ]]
            -- upvalues: l_v217_0 (ref), v224 (copy), l_VRService_0 (ref), v22 (ref), v221 (copy), v220 (copy), v234 (copy), v218 (copy), l_DropDownFrameTextLabel_0 (copy), v222 (copy), v239 (copy), l_BindableEvent_1 (copy), l_UserInputService_0 (ref), l_GuiService_0 (ref), v227 (copy), v230 (copy), v233 (copy)
            l_v217_0 = v272;
            if v224.Selections then
                for v273 = 1, #v224.Selections do
                    v224.Selections[v273]:Destroy();
                end;
            end;
            v224.Selections = {};
            v224.SelectionInfo = {};
            local l_VREnabled_0 = l_VRService_0.VREnabled;
            local v275 = l_VREnabled_0 and Enum.Font.SourceSansBold or Enum.Font.SourceSans;
            local v276 = l_VREnabled_0 and 36 or 24;
            local v277 = l_VREnabled_0 and 70 or 50;
            local v278 = v277 + 1;
            local v279 = l_VREnabled_0 and 600 or 400;
            for v280, v281 in pairs(v272) do
                local v282 = v22.Create("Frame")({
                    BackgroundTransparency = 0.7, 
                    BorderSizePixel = 0, 
                    Size = UDim2.new(1, 0, 1, 0)
                });
                local v283 = v22.Create("TextButton")({
                    Name = "Selection" .. tostring(v280), 
                    BackgroundTransparency = 1, 
                    BorderSizePixel = 0, 
                    AutoButtonColor = false, 
                    Size = UDim2.new(1, -28, 0, v277), 
                    Position = UDim2.new(0, 14, 0, (v280 - 1) * v278), 
                    TextColor3 = l_VRService_0.VREnabled and v221 or v220, 
                    Font = v275, 
                    TextSize = v276, 
                    Text = v281, 
                    ZIndex = 10, 
                    SelectionImageObject = v282, 
                    Parent = v234
                });
                if v280 == v218 then
                    v224.CurrentIndex = v280;
                    l_DropDownFrameTextLabel_0.Text = v281;
                    v283.TextColor3 = v222;
                elseif not v218 and v280 == 1 then
                    v283.TextColor3 = v222;
                end;
                local function v284() --[[ Line: 896 ]]
                    -- upvalues: l_DropDownFrameTextLabel_0 (ref), v283 (copy), v239 (ref), v224 (ref), v280 (copy), l_BindableEvent_1 (ref)
                    l_DropDownFrameTextLabel_0.Text = v283.Text;
                    v239();
                    v224.CurrentIndex = v280;
                    l_BindableEvent_1:Fire(v280);
                end;
                v283.MouseButton1Click:Connect(v284);
                v283.MouseEnter:Connect(function() --[[ Line: 905 ]]
                    -- upvalues: l_VRService_0 (ref), l_UserInputService_0 (ref), l_GuiService_0 (ref), v283 (copy)
                    if not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) then
                        l_GuiService_0.SelectedCoreObject = v283;
                    end;
                end);
                v224.Selections[v280] = v283;
                v224.SelectionInfo[v283] = {
                    Clicked = v284
                };
            end;
            l_GuiService_0:RemoveSelectionGroup(v227);
            l_GuiService_0:AddSelectionTuple(v227, unpack(v224.Selections));
            v234.CanvasSize = UDim2.new(1, -20, 0, #v272 * v278);
            local function v285() --[[ Line: 920 ]] --[[ Name: updateDropDownSize ]]
                -- upvalues: v234 (ref), v230 (ref), v233 (ref), v279 (copy)
                if v234.CanvasSize.Y.Offset < v230.AbsoluteSize.Y - 10 then
                    v233.Size = UDim2.new(0, v279, 0, v234.CanvasSize.Y.Offset + 25);
                    return;
                else
                    v233.Size = UDim2.new(0, v279, 0.9, 0);
                    return;
                end;
            end;
            v230.Changed:Connect(function(v286) --[[ Line: 929 ]]
                -- upvalues: v285 (copy)
                if v286 ~= "AbsoluteSize" then
                    return;
                else
                    v285();
                    return;
                end;
            end);
            v285();
        end;
        v224:UpdateDropDownList(v217);
        v230.MouseButton1Click:Connect(v239);
        v219.PoppedMenu:Connect(function(v287) --[[ Line: 942 ]]
            -- upvalues: v230 (copy), v239 (copy)
            if v287 == v230 then
                v239();
            end;
        end);
        return v224;
    end;
end;
local function v362(v289, v290) --[[ Line: 952 ]] --[[ Name: CreateSelector ]]
    -- upvalues: v22 (copy), v24 (copy), v2 (copy), l_UserInputService_0 (copy), v3 (copy), v146 (copy), l_VRService_0 (copy), l_GuiService_0 (copy), v40 (copy), v4 (copy), v23 (copy), v72 (copy)
    local v291 = 0;
    local v292 = {
        HubRef = nil
    };
    if type(v289) ~= "table" then
        error("CreateSelector selectionStringTable (first arg) is not a table", 2);
        return v292;
    else
        local l_BindableEvent_2 = Instance.new("BindableEvent");
        l_BindableEvent_2.Name = "IndexChanged";
        local v294 = true;
        v292.CurrentIndex = 0;
        v292.SelectorFrame = v22.Create("ImageButton")({
            Name = "Selector", 
            Image = "", 
            AutoButtonColor = false, 
            NextSelectionLeft = v292.SelectorFrame, 
            NextSelectionRight = v292.SelectorFrame, 
            BackgroundTransparency = 1, 
            Size = UDim2.new(0.6, 0, 0, 50), 
            Position = UDim2.new(1, 0, 0.5, 0), 
            AnchorPoint = Vector2.new(1, 0.5), 
            ZIndex = 2, 
            SelectionImageObject = v24
        });
        local v295 = v22.Create("ImageButton")({
            Name = "LeftButton", 
            BackgroundTransparency = 1, 
            AnchorPoint = Vector2.new(0, 0.5), 
            Position = UDim2.new(0, 0, 0.5, 0), 
            Size = UDim2.new(0, 50, 0, 50), 
            Image = "", 
            ZIndex = 3, 
            Selectable = false, 
            SelectionImageObject = v24, 
            Parent = v292.SelectorFrame
        });
        local v296 = v22.Create("ImageButton")({
            Name = "RightButton", 
            BackgroundTransparency = 1, 
            AnchorPoint = Vector2.new(1, 0.5), 
            Position = UDim2.new(1, 0, 0.5, 0), 
            Size = UDim2.new(0, 50, 0, 50), 
            Image = "", 
            ZIndex = 3, 
            Selectable = false, 
            SelectionImageObject = v24, 
            Parent = v292.SelectorFrame
        });
        local v297 = v22.Create("ImageLabel")({
            Name = "LeftButton", 
            BackgroundTransparency = 1, 
            AnchorPoint = Vector2.new(0.5, 0.5), 
            Position = UDim2.new(0.5, 0, 0.5, 0), 
            Size = UDim2.new(0, 18, 0, 30), 
            Image = "rbxasset://textures/ui/Settings/Slider/Left.png", 
            ImageColor3 = v2, 
            ZIndex = 4, 
            Parent = v295
        });
        local v298 = v22.Create("ImageLabel")({
            Name = "RightButton", 
            BackgroundTransparency = 1, 
            AnchorPoint = Vector2.new(0.5, 0.5), 
            Position = UDim2.new(0.5, 0, 0.5, 0), 
            Size = UDim2.new(0, 18, 0, 30), 
            Image = "rbxasset://textures/ui/Settings/Slider/Right.png", 
            ImageColor3 = v2, 
            ZIndex = 4, 
            Parent = v296
        });
        if not l_UserInputService_0.TouchEnabled then
            local function v300(v299) --[[ Line: 1043 ]]
                -- upvalues: v2 (ref)
                v299.ImageColor3 = v2;
            end;
            local function v302(v301) --[[ Line: 1044 ]]
                -- upvalues: v3 (ref)
                v301.ImageColor3 = v3;
            end;
            v146(v295, v297, v300, v302);
            v146(v296, v298, v300, v302);
        end;
        v292.Selections = {};
        local v303 = {};
        local v304 = {};
        local v305 = v22.Create("ImageButton")({
            Name = "AutoSelectButton", 
            BackgroundTransparency = 1, 
            Image = "", 
            Position = UDim2.new(0, v295.Size.X.Offset, 0, 0), 
            Size = UDim2.new(1, v295.Size.X.Offset * -2, 1, 0), 
            Parent = v292.SelectorFrame, 
            ZIndex = 2, 
            SelectionImageObject = v24
        });
        v305.MouseButton1Click:Connect(function() --[[ Line: 1064 ]]
            -- upvalues: v294 (ref), v292 (copy), l_VRService_0 (ref), l_UserInputService_0 (ref), l_GuiService_0 (ref)
            if not v294 then
                return;
            elseif #v292.Selections <= 1 then
                return;
            else
                local v306 = v292.CurrentIndex + 1;
                if #v292.Selections < v306 then
                    v306 = 1;
                end;
                v292:SetSelectionIndex(v306);
                if not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) then
                    l_GuiService_0.SelectedCoreObject = v292.SelectorFrame;
                end;
                return;
            end;
        end);
        v304[v305] = true;
        local function v314(v307, v308) --[[ Line: 1079 ]] --[[ Name: setSelection ]]
            -- upvalues: v292 (copy), v295 (copy), v303 (ref), v40 (ref), l_BindableEvent_2 (copy)
            for v309, v310 in pairs(v292.Selections) do
                local v311 = v309 == v307;
                local v312 = UDim2.new(0, v295.Size.X.Offset, 0, 0);
                local v313 = UDim2.new(0, v295.Size.X.Offset * v308 * 3, 0, 0);
                if v303[v310] then
                    v313 = UDim2.new(0, v295.Size.X.Offset * -v308 * 3, 0, 0);
                end;
                if v313.X.Offset < 0 then
                    v313 = UDim2.new(0, v313.X.Offset + v310.AbsoluteSize.X / 4, 0, 0);
                end;
                if v311 then
                    v303[v310] = true;
                    v310.Position = v313;
                    v310.Visible = true;
                    PropertyTweener(v310, "TextTransparency", 1, 0, 0.165, v40);
                    if v310:IsDescendantOf(game) then
                        v310:TweenPosition(v312, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.15, true);
                    else
                        v310.Position = v312;
                    end;
                    v292.CurrentIndex = v309;
                    l_BindableEvent_2:Fire(v307);
                elseif v303[v310] then
                    v303[v310] = false;
                    PropertyTweener(v310, "TextTransparency", 0, 1, 0.165, v40);
                    if v310:IsDescendantOf(game) then
                        v310:TweenPosition(v313, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.135, true);
                    else
                        v310.Position = UDim2.new(v313);
                    end;
                end;
            end;
        end;
        local function v319(v315, v316) --[[ Line: 1118 ]] --[[ Name: stepFunc ]]
            -- upvalues: v294 (ref), l_VRService_0 (ref), l_UserInputService_0 (ref), l_GuiService_0 (ref), v292 (copy), v314 (copy)
            if not v294 then
                return;
            elseif v315 ~= nil and v315.UserInputType ~= Enum.UserInputType.MouseButton1 and v315.UserInputType ~= Enum.UserInputType.Gamepad1 and v315.UserInputType ~= Enum.UserInputType.Gamepad2 and v315.UserInputType ~= Enum.UserInputType.Gamepad3 and v315.UserInputType ~= Enum.UserInputType.Gamepad4 and v315.UserInputType ~= Enum.UserInputType.Keyboard then
                return;
            else
                if not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) then
                    l_GuiService_0.SelectedCoreObject = v292.SelectorFrame;
                end;
                local v317 = v316 + v292.CurrentIndex;
                local v318 = 0;
                v318 = v292.CurrentIndex < v317 and 1 or -1;
                if #v292.Selections < v317 then
                    v317 = 1;
                elseif v317 < 1 then
                    v317 = #v292.Selections;
                end;
                v314(v317, v318);
                return;
            end;
        end;
        local v320 = nil;
        local function _() --[[ Line: 1149 ]] --[[ Name: connectToGuiService ]]
            -- upvalues: v320 (ref), l_GuiService_0 (ref), v292 (copy), v304 (copy), l_VRService_0 (ref)
            v320 = l_GuiService_0:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() --[[ Line: 1150 ]]
                -- upvalues: v292 (ref), l_GuiService_0 (ref), v304 (ref), l_VRService_0 (ref)
                if #v292.Selections <= 0 then
                    return;
                elseif l_GuiService_0.SelectedCoreObject == v292.SelectorFrame then
                    v292.Selections[v292.CurrentIndex].TextTransparency = 0;
                    return;
                elseif l_GuiService_0.SelectedCoreObject ~= nil and v304[l_GuiService_0.SelectedCoreObject] then
                    if l_VRService_0.VREnabled then
                        v292.Selections[v292.CurrentIndex].TextTransparency = 0;
                        return;
                    else
                        l_GuiService_0.SelectedCoreObject = v292.SelectorFrame;
                        return;
                    end;
                else
                    v292.Selections[v292.CurrentIndex].TextTransparency = 0.5;
                    return;
                end;
            end);
        end;
        v292.IndexChanged = l_BindableEvent_2.Event;
        v292.SetSelectionIndex = function(_, v323) --[[ Line: 1174 ]] --[[ Name: SetSelectionIndex ]]
            -- upvalues: v314 (copy)
            v314(v323, 1);
        end;
        v292.GetSelectedIndex = function(_) --[[ Line: 1178 ]] --[[ Name: GetSelectedIndex ]]
            -- upvalues: v292 (copy)
            return v292.CurrentIndex;
        end;
        v292.SetZIndex = function(_, v326) --[[ Line: 1182 ]] --[[ Name: SetZIndex ]]
            -- upvalues: v295 (copy), v296 (copy), v297 (copy), v298 (copy), v292 (copy)
            v295.ZIndex = v326;
            v296.ZIndex = v326;
            v297.ZIndex = v326;
            v298.ZIndex = v326;
            for v327 = 1, #v292.Selections do
                v292.Selections[v327].ZIndex = v326;
            end;
        end;
        v292.SetInteractable = function(_, v329) --[[ Line: 1193 ]] --[[ Name: SetInteractable ]]
            -- upvalues: v294 (ref), v292 (copy), v295 (copy), v296 (copy), v297 (copy), v4 (ref), v298 (copy), v2 (ref)
            v294 = v329;
            v292.SelectorFrame.Selectable = v294;
            v295.Active = v294;
            v296.Active = v294;
            if not v294 then
                for _, v331 in pairs(v292.Selections) do
                    v331.TextColor3 = Color3.fromRGB(49, 49, 49);
                end;
                v297.ImageColor3 = v4;
                v298.ImageColor3 = v4;
                return;
            else
                for _, v333 in pairs(v292.Selections) do
                    v333.TextColor3 = Color3.fromRGB(255, 255, 255);
                end;
                v297.ImageColor3 = v2;
                v298.ImageColor3 = v2;
                return;
            end;
        end;
        v292.UpdateOptions = function(_, v335) --[[ Line: 1215 ]] --[[ Name: UpdateOptions ]]
            -- upvalues: v292 (copy), v303 (ref), v22 (ref), v295 (copy), v290 (copy), v296 (copy)
            for _, v337 in pairs(v292.Selections) do
                v337:Destroy();
            end;
            v303 = {};
            v292.Selections = {};
            for v338, v339 in pairs(v335) do
                local v340 = v22.Create("TextLabel")({
                    Name = "Selection" .. tostring(v338), 
                    BackgroundTransparency = 1, 
                    BorderSizePixel = 0, 
                    Size = UDim2.new(1, v295.Size.X.Offset * -2, 1, 0), 
                    Position = UDim2.new(1, 0, 0, 0), 
                    TextColor3 = Color3.fromRGB(255, 255, 255), 
                    TextYAlignment = Enum.TextYAlignment.Center, 
                    TextTransparency = 0.5, 
                    Font = Enum.Font.SourceSans, 
                    TextSize = 24, 
                    Text = v339, 
                    ZIndex = 2, 
                    Visible = false, 
                    Parent = v292.SelectorFrame
                });
                if false then
                    v340.TextSize = 36;
                end;
                if v338 == v290 then
                    v292.CurrentIndex = v338;
                    v340.Position = UDim2.new(0, v295.Size.X.Offset, 0, 0);
                    v340.Visible = true;
                    v303[v340] = true;
                else
                    v303[v340] = false;
                end;
                v292.Selections[v338] = v340;
            end;
            local v341 = #v292.Selections > 1;
            v295.Visible = v341;
            v296.Visible = v341;
        end;
        local function v344(v342) --[[ Line: 1264 ]] --[[ Name: onVREnabled ]]
            -- upvalues: l_VRService_0 (ref), v295 (copy), v296 (copy), v305 (copy)
            if v342 ~= "VREnabled" then
                return;
            else
                local l_VREnabled_1 = l_VRService_0.VREnabled;
                v295.Selectable = l_VREnabled_1;
                v296.Selectable = l_VREnabled_1;
                v305.Selectable = l_VREnabled_1;
                return;
            end;
        end;
        l_VRService_0.Changed:Connect(v344);
        local l_VREnabled_2 = l_VRService_0.VREnabled;
        v295.Selectable = l_VREnabled_2;
        v296.Selectable = l_VREnabled_2;
        v305.Selectable = l_VREnabled_2;
        v295.InputBegan:Connect(function(v346) --[[ Line: 1276 ]]
            -- upvalues: v319 (copy)
            if v346.UserInputType == Enum.UserInputType.Touch then
                v319(nil, -1);
            end;
        end);
        v295.MouseButton1Click:Connect(function() --[[ Line: 1281 ]]
            -- upvalues: l_UserInputService_0 (ref), v319 (copy)
            if not l_UserInputService_0.TouchEnabled then
                v319(nil, -1);
            end;
        end);
        v296.InputBegan:Connect(function(v347) --[[ Line: 1286 ]]
            -- upvalues: v319 (copy)
            if v347.UserInputType == Enum.UserInputType.Touch then
                v319(nil, 1);
            end;
        end);
        v296.MouseButton1Click:Connect(function() --[[ Line: 1291 ]]
            -- upvalues: l_UserInputService_0 (ref), v319 (copy)
            if not l_UserInputService_0.TouchEnabled then
                v319(nil, 1);
            end;
        end);
        l_VREnabled_2 = true;
        v292:UpdateOptions(v289);
        l_UserInputService_0.InputBegan:Connect(function(v348) --[[ Line: 1300 ]]
            -- upvalues: v294 (ref), l_VREnabled_2 (ref), l_GuiService_0 (ref), v292 (copy), v319 (copy)
            if not v294 then
                return;
            elseif not l_VREnabled_2 then
                return;
            elseif v348.UserInputType ~= Enum.UserInputType.Gamepad1 and v348.UserInputType ~= Enum.UserInputType.Keyboard then
                return;
            elseif l_GuiService_0.SelectedCoreObject ~= v292.SelectorFrame then
                return;
            elseif v348.KeyCode == Enum.KeyCode.DPadLeft or v348.KeyCode == Enum.KeyCode.Left or v348.KeyCode == Enum.KeyCode.A then
                v319(v348, -1);
                return;
            else
                if v348.KeyCode == Enum.KeyCode.DPadRight or v348.KeyCode == Enum.KeyCode.Right or v348.KeyCode == Enum.KeyCode.D then
                    v319(v348, 1);
                end;
                return;
            end;
        end);
        l_UserInputService_0.InputChanged:Connect(function(v349) --[[ Line: 1314 ]]
            -- upvalues: v294 (ref), l_VREnabled_2 (ref), v291 (ref), l_GuiService_0 (ref), v292 (copy), v319 (copy)
            if not v294 then
                return;
            elseif not l_VREnabled_2 then
                v291 = 0;
                return;
            elseif v349.UserInputType ~= Enum.UserInputType.Gamepad1 then
                return;
            else
                local l_SelectedCoreObject_0 = l_GuiService_0.SelectedCoreObject;
                if not l_SelectedCoreObject_0 or not l_SelectedCoreObject_0:IsDescendantOf(v292.SelectorFrame.Parent) then
                    return;
                elseif v349.KeyCode ~= Enum.KeyCode.Thumbstick1 then
                    return;
                elseif v349.Position.X > 0.8 and v349.Delta.X > 0 and v291 ~= 1 then
                    v291 = 1;
                    v319(v349, v291);
                    return;
                elseif v349.Position.X < -0.8 and v349.Delta.X < 0 and v291 ~= -1 then
                    v291 = -1;
                    v319(v349, v291);
                    return;
                else
                    if math.abs(v349.Position.X) < 0.8 then
                        v291 = 0;
                    end;
                    return;
                end;
            end;
        end);
        v292.SelectorFrame.AncestryChanged:Connect(function(_, v352) --[[ Line: 1337 ]]
            -- upvalues: l_VREnabled_2 (ref), v320 (ref), l_GuiService_0 (ref), v292 (copy), v304 (copy), l_VRService_0 (ref)
            l_VREnabled_2 = v352;
            if not l_VREnabled_2 then
                if v320 then
                    v320:Disconnect();
                    return;
                end;
            else
                v320 = l_GuiService_0:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() --[[ Line: 1150 ]]
                    -- upvalues: v292 (ref), l_GuiService_0 (ref), v304 (ref), l_VRService_0 (ref)
                    if #v292.Selections <= 0 then
                        return;
                    elseif l_GuiService_0.SelectedCoreObject == v292.SelectorFrame then
                        v292.Selections[v292.CurrentIndex].TextTransparency = 0;
                        return;
                    elseif l_GuiService_0.SelectedCoreObject ~= nil and v304[l_GuiService_0.SelectedCoreObject] then
                        if l_VRService_0.VREnabled then
                            v292.Selections[v292.CurrentIndex].TextTransparency = 0;
                            return;
                        else
                            l_GuiService_0.SelectedCoreObject = v292.SelectorFrame;
                            return;
                        end;
                    else
                        v292.Selections[v292.CurrentIndex].TextTransparency = 0.5;
                        return;
                    end;
                end);
            end;
        end);
        local function v358(_, v354) --[[ Line: 1346 ]] --[[ Name: onResized ]]
            -- upvalues: v292 (copy)
            local v355 = 0;
            v355 = v354 and 16 or false and 36 or 24;
            for _, v357 in pairs(v292.Selections) do
                v357.TextSize = v355;
            end;
        end;
        v23[v292.SelectorFrame] = v358;
        local l_v358_0 = v358;
        local v360 = v72();
        local v361 = v72();
        l_v358_0(v360, v361.Y > v361.X);
        v320 = l_GuiService_0:GetPropertyChangedSignal("SelectedCoreObject"):Connect(function() --[[ Line: 1150 ]]
            -- upvalues: v292 (copy), l_GuiService_0 (ref), v304 (copy), l_VRService_0 (ref)
            if #v292.Selections <= 0 then
                return;
            elseif l_GuiService_0.SelectedCoreObject == v292.SelectorFrame then
                v292.Selections[v292.CurrentIndex].TextTransparency = 0;
                return;
            elseif l_GuiService_0.SelectedCoreObject ~= nil and v304[l_GuiService_0.SelectedCoreObject] then
                if l_VRService_0.VREnabled then
                    v292.Selections[v292.CurrentIndex].TextTransparency = 0;
                    return;
                else
                    l_GuiService_0.SelectedCoreObject = v292.SelectorFrame;
                    return;
                end;
            else
                v292.Selections[v292.CurrentIndex].TextTransparency = 0.5;
                return;
            end;
        end);
        return v292;
    end;
end;
local function v387(v363, v364, v365, v366, v367) --[[ Line: 1365 ]] --[[ Name: ShowAlert ]]
    -- upvalues: l_PlayerGui_0 (copy), l_VRService_0 (copy), v22 (copy), l_HttpService_0 (copy), l_ContextActionService_0 (copy), l_GuiService_0 (copy), v195 (copy), l_UserInputService_0 (copy)
    local l_RobloxGui_0 = l_PlayerGui_0.RobloxGui;
    if l_RobloxGui_0:FindFirstChild("AlertViewFullScreen") then
        return;
    else
        local v369 = nil;
        local function v373(v370) --[[ Line: 1374 ]] --[[ Name: onVREnabled ]]
            -- upvalues: l_VRService_0 (ref), l_PlayerGui_0 (ref), l_RobloxGui_0 (ref), v369 (ref)
            if v370 ~= "VREnabled" then
                return;
            else
                local _ = nil;
                local v372 = nil;
                if l_VRService_0.VREnabled then
                    v372 = require(l_PlayerGui_0.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu");
                    l_RobloxGui_0 = v372:GetGUI();
                else
                    l_RobloxGui_0 = l_PlayerGui_0.RobloxGui;
                end;
                if v369 and v369.Parent ~= nil then
                    v369.Parent = l_RobloxGui_0;
                    if l_VRService_0.VREnabled then
                        v372:SetSubpanelDepth(v369, 0.5);
                    end;
                end;
                return;
            end;
        end;
        local v374 = l_VRService_0.Changed:Connect(v373);
        local _ = Color3.fromRGB(59, 166, 241);
        local _ = Color3.fromRGB(255, 255, 255);
        v369 = v22.Create("ImageLabel")({
            Name = "AlertViewBacking", 
            Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png", 
            ScaleType = Enum.ScaleType.Slice, 
            SliceCenter = Rect.new(8, 6, 46, 44), 
            BackgroundTransparency = 1, 
            ImageTransparency = 1, 
            Size = UDim2.new(0, 400, 0, 350), 
            Position = UDim2.new(0.5, -200, 0.5, -175), 
            ZIndex = 9, 
            Parent = l_RobloxGui_0
        });
        v373("VREnabled");
        if v367 or l_VRService_0.VREnabled then
            v369.ImageTransparency = 0;
        else
            v369.Size = UDim2.new(0.8, 0, 0, 350);
            v369.Position = UDim2.new(0.1, 0, 0.1, 0);
        end;
        if l_PlayerGui_0.RobloxGui.AbsoluteSize.Y <= v369.Size.Y.Offset then
            v369.Size = UDim2.new(v369.Size.X.Scale, v369.Size.X.Offset, v369.Size.Y.Scale, l_PlayerGui_0.RobloxGui.AbsoluteSize.Y);
            v369.Position = UDim2.new(v369.Position.X.Scale, -v369.Size.X.Offset / 2, 0.5, -v369.Size.Y.Offset / 2);
        end;
        local _ = v22.Create("TextLabel")({
            Name = "AlertViewText", 
            BackgroundTransparency = 1, 
            Size = UDim2.new(0.95, 0, 0.6, 0), 
            Position = UDim2.new(0.025, 0, 0.05, 0), 
            Font = Enum.Font.SourceSansBold, 
            TextSize = 36, 
            Text = v363, 
            TextWrapped = true, 
            TextColor3 = Color3.fromRGB(255, 255, 255), 
            TextXAlignment = Enum.TextXAlignment.Center, 
            TextYAlignment = Enum.TextYAlignment.Center, 
            ZIndex = 10, 
            Parent = v369
        });
        local _ = v22.Create("ImageLabel")({
            Image = "", 
            BackgroundTransparency = 1
        });
        local v379 = l_HttpService_0:GenerateGUID(false);
        local function v382(_, v381) --[[ Line: 1449 ]]
            -- upvalues: l_VRService_0 (ref), v369 (ref), l_PlayerGui_0 (ref), v366 (copy), l_ContextActionService_0 (ref), v379 (copy), l_GuiService_0 (ref), v365 (copy), v374 (copy)
            if l_VRService_0.VREnabled and (v381 == Enum.UserInputState.Begin or v381 == Enum.UserInputState.Cancel) then
                return;
            elseif not v369 then
                return;
            else
                if l_VRService_0.VREnabled then
                    require(l_PlayerGui_0.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu"):SetSubpanelDepth(v369, 0);
                end;
                v369:Destroy();
                v369 = nil;
                if v366 then
                    v366();
                end;
                l_ContextActionService_0:UnbindAction(v379);
                l_GuiService_0.SelectedCoreObject = nil;
                if v365 then
                    v365:ShowBar();
                end;
                if v374 then
                    v374:Disconnect();
                end;
                return;
            end;
        end;
        local v383 = UDim2.new(1, -20, 0, 60);
        local v384 = UDim2.new(0, 10, 0.65, 0);
        if not v367 then
            v383 = UDim2.new(0, 200, 0, 50);
            v384 = UDim2.new(0.5, -100, 0.65, 0);
        end;
        local v385, v386 = v195("AlertViewButton", v364, v383, v382);
        v385.Position = v384;
        v385.NextSelectionLeft = v385;
        v385.NextSelectionRight = v385;
        v385.NextSelectionUp = v385;
        v385.NextSelectionDown = v385;
        v385.ZIndex = 9;
        v386.ZIndex = v385.ZIndex;
        v385.Parent = v369;
        if not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) then
            l_GuiService_0.SelectedCoreObject = v385;
        end;
        l_GuiService_0.SelectedCoreObject = v385;
        l_ContextActionService_0:BindActionAtPriority(v379, v382, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Escape, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonA);
        if v365 and not l_VRService_0.VREnabled then
            v365:HideBar();
            v365.Pages.CurrentPage:Hide(1, 1);
        end;
        return;
    end;
end;
local function v482(v388, v389, v390) --[[ Line: 1506 ]] --[[ Name: CreateNewSlider ]]
    -- upvalues: l_HttpService_0 (copy), v22 (copy), v24 (copy), l_UserInputService_0 (copy), v3 (copy), v2 (copy), v3 (copy), v146 (copy), v72 (copy), v0 (copy), v1 (copy), l_VRService_0 (copy), l_GuiService_0 (copy), l_RunService_0 (copy)
    local v391 = {};
    local v392 = tonumber(v388);
    local l_v389_0 = v389;
    local v394 = 0;
    local v395 = nil;
    local v396 = true;
    local v397 = l_HttpService_0:GenerateGUID(false);
    v388 = "";
    v389 = "";
    if v392 <= 0 then
        error("CreateNewSlider failed because numOfSteps (first arg) is 0 or negative, please supply a positive integer", 2);
        return;
    else
        local l_BindableEvent_3 = Instance.new("BindableEvent");
        l_BindableEvent_3.Name = "ValueChanged";
        v391.SliderFrame = v22.Create("ImageButton")({
            Name = "Slider", 
            Image = "", 
            AutoButtonColor = false, 
            NextSelectionLeft = v391.SliderFrame, 
            NextSelectionRight = v391.SliderFrame, 
            BackgroundTransparency = 1, 
            Size = UDim2.new(0.6, 0, 0, 50), 
            Position = UDim2.new(1, 0, 0.5, 0), 
            AnchorPoint = Vector2.new(1, 0.5), 
            SelectionImageObject = v24, 
            ZIndex = 2
        });
        v391.StepsContainer = v22.Create("Frame")({
            Name = "StepsContainer", 
            Position = UDim2.new(0.5, 0, 0.5, 0), 
            Size = UDim2.new(1, -100, 1, 0), 
            AnchorPoint = Vector2.new(0.5, 0.5), 
            BackgroundTransparency = 1, 
            Parent = v391.SliderFrame
        });
        local v399 = v22.Create("ImageButton")({
            Name = "LeftButton", 
            BackgroundTransparency = 1, 
            AnchorPoint = Vector2.new(0, 0.5), 
            Position = UDim2.new(0, 0, 0.5, 0), 
            Size = UDim2.new(0, 50, 0, 50), 
            Image = "", 
            ZIndex = 3, 
            Selectable = false, 
            SelectionImageObject = v24, 
            Active = true, 
            Parent = v391.SliderFrame
        });
        local v400 = v22.Create("ImageButton")({
            Name = "RightButton", 
            BackgroundTransparency = 1, 
            AnchorPoint = Vector2.new(1, 0.5), 
            Position = UDim2.new(1, 0, 0.5, 0), 
            Size = UDim2.new(0, 50, 0, 50), 
            Image = "", 
            ZIndex = 3, 
            Selectable = false, 
            SelectionImageObject = v24, 
            Active = true, 
            Parent = v391.SliderFrame
        });
        local v401 = v22.Create("ImageLabel")({
            Name = "LeftButton", 
            BackgroundTransparency = 1, 
            AnchorPoint = Vector2.new(0.5, 0.5), 
            Position = UDim2.new(0.5, 0, 0.5, 0), 
            Size = UDim2.new(0, 30, 0, 30), 
            Image = "rbxasset://textures/ui/Settings/Slider/Less.png", 
            ZIndex = 4, 
            Parent = v399, 
            ImageColor3 = l_UserInputService_0.TouchEnabled and v3 or v2
        });
        local v402 = v22.Create("ImageLabel")({
            Name = "RightButton", 
            BackgroundTransparency = 1, 
            AnchorPoint = Vector2.new(0.5, 0.5), 
            Position = UDim2.new(0.5, 0, 0.5, 0), 
            Size = UDim2.new(0, 30, 0, 30), 
            Image = "rbxasset://textures/ui/Settings/Slider/More.png", 
            ZIndex = 4, 
            Parent = v400, 
            ImageColor3 = l_UserInputService_0.TouchEnabled and v3 or v2
        });
        if not l_UserInputService_0.TouchEnabled then
            local function v404(v403) --[[ Line: 1615 ]]
                -- upvalues: v2 (ref)
                v403.ImageColor3 = v2;
            end;
            local function v406(v405) --[[ Line: 1616 ]]
                -- upvalues: v3 (ref)
                v405.ImageColor3 = v3;
            end;
            v146(v399, v401, v404, v406);
            v146(v400, v402, v404, v406);
        end;
        v391.Steps = {};
        local v407 = 35;
        local v408 = v72();
        if l_UserInputService_0.TouchEnabled and (v408.Y < 500 or v408.X < 700) then
            v407 = 25;
        end;
        local v409 = 1 / v392;
        v407 = 0;
        for v410 = 1, v392 do
            local v411 = v22.Create("ImageButton")({
                Name = "Step" .. tostring(v410), 
                BackgroundColor3 = v0, 
                BackgroundTransparency = 0.36, 
                BorderSizePixel = 0, 
                AutoButtonColor = false, 
                Active = false, 
                AnchorPoint = Vector2.new(0, 0.5), 
                Position = UDim2.new((v410 - 1) * v409, 2, 0.5, 0), 
                Size = UDim2.new(v409, -4, 0.48, 0), 
                Image = "", 
                ZIndex = 3, 
                Selectable = false, 
                ImageTransparency = 0.36, 
                Parent = v391.StepsContainer, 
                SelectionImageObject = v24
            });
            if l_v389_0 < v410 then
                v411.BackgroundColor3 = v1;
            end;
            if v410 == 1 or v410 == v392 then
                v411.BackgroundTransparency = 1;
                v411.ScaleType = Enum.ScaleType.Slice;
                v411.SliceCenter = Rect.new(3, 3, 32, 21);
                if v410 <= l_v389_0 then
                    if v410 == 1 then
                        v411.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png";
                    else
                        v411.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png";
                    end;
                elseif v410 == 1 then
                    v411.Image = "rbxasset://textures/ui/Settings/Slider/BarLeft.png";
                else
                    v411.Image = "rbxasset://textures/ui/Settings/Slider/BarRight.png";
                end;
            end;
            v391.Steps[#v391.Steps + 1] = v411;
        end;
        v408 = function() --[[ Line: 1680 ]] --[[ Name: hideSelection ]]
            -- upvalues: v392 (copy), v391 (copy), v1 (ref)
            for v412 = 1, v392 do
                v391.Steps[v412].BackgroundColor3 = v1;
                if v412 == 1 then
                    v391.Steps[v412].Image = "rbxasset://textures/ui/Settings/Slider/BarLeft.png";
                elseif v412 == v392 then
                    v391.Steps[v412].Image = "rbxasset://textures/ui/Settings/Slider/BarRight.png";
                end;
            end;
        end;
        local function v414() --[[ Line: 1690 ]] --[[ Name: showSelection ]]
            -- upvalues: v392 (copy), l_v389_0 (ref), v391 (copy), v0 (ref)
            for v413 = 1, v392 do
                if l_v389_0 >= v413 then
                    v391.Steps[v413].BackgroundColor3 = v0;
                    if v413 == 1 then
                        v391.Steps[v413].Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png";
                    elseif v413 == v392 then
                        v391.Steps[v413].Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png";
                    end;
                else
                    break;
                end;
            end;
        end;
        local function v417(v415) --[[ Line: 1701 ]] --[[ Name: modifySelection ]]
            -- upvalues: v392 (copy), v391 (copy)
            for v416 = 1, v392 do
                if v416 == 1 or v416 == v392 then
                    v391.Steps[v416].ImageTransparency = v415;
                else
                    v391.Steps[v416].BackgroundTransparency = v415;
                end;
            end;
        end;
        local function v419(v418) --[[ Line: 1711 ]] --[[ Name: setCurrentStep ]]
            -- upvalues: v390 (ref), v399 (copy), v400 (copy), v392 (copy), l_v389_0 (ref), v408 (copy), v414 (copy), v395 (ref), l_BindableEvent_3 (copy)
            if not v390 then
                v390 = 0;
            end;
            v399.Visible = true;
            v400.Visible = true;
            if v418 <= v390 then
                v418 = v390;
                v399.Visible = false;
            end;
            if v392 <= v418 then
                v418 = v392;
                v400.Visible = false;
            end;
            if l_v389_0 == v418 then
                return;
            else
                l_v389_0 = v418;
                v408();
                v414();
                v395 = tick();
                l_BindableEvent_3:Fire(l_v389_0);
                return;
            end;
        end;
        local function _(v420) --[[ Line: 1737 ]] --[[ Name: isActivateEvent ]]
            if not v420 then
                return false;
            else
                local v421 = true;
                if v420.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    v421 = true;
                    if v420.UserInputType ~= Enum.UserInputType.Touch then
                        v421 = false;
                        if v420.UserInputType == Enum.UserInputType.Gamepad1 then
                            v421 = v420.KeyCode == Enum.KeyCode.ButtonA;
                        end;
                    end;
                end;
                return v421;
            end;
        end;
        local function v436(v423, v424, v425) --[[ Line: 1741 ]] --[[ Name: mouseDownFunc ]]
            -- upvalues: v396 (ref), l_VRService_0 (ref), l_UserInputService_0 (ref), l_GuiService_0 (ref), v391 (copy), v394 (ref), l_v389_0 (ref), v392 (copy), v419 (copy)
            if not v396 then
                return;
            elseif v423 == nil then
                return;
            elseif not (not not v423 and (v423.UserInputType == Enum.UserInputType.MouseButton1 or v423.UserInputType == Enum.UserInputType.Touch or v423.UserInputType == Enum.UserInputType.Gamepad1 and v423.KeyCode == Enum.KeyCode.ButtonA)) then
                return;
            else
                if not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) and not l_VRService_0.VREnabled then
                    l_GuiService_0.SelectedCoreObject = v391.SliderFrame;
                end;
                if not l_VRService_0.VREnabled then
                    if v425 then
                        v394 = v424 - l_v389_0;
                    else
                        v394 = 0;
                        local v426 = nil;
                        local v427 = nil;
                        v426 = l_UserInputService_0.InputChanged:Connect(function(v428) --[[ Line: 1761 ]]
                            -- upvalues: v392 (ref), v391 (ref), v419 (ref)
                            if v428.UserInputType ~= Enum.UserInputType.MouseMovement then
                                return;
                            else
                                local l_X_0 = v428.Position.X;
                                for v430 = 1, v392 do
                                    local l_X_1 = v391.Steps[v430].AbsolutePosition.X;
                                    local l_X_2 = v391.Steps[v430].AbsoluteSize.X;
                                    if l_X_1 <= l_X_0 and l_X_0 <= l_X_1 + l_X_2 then
                                        v419(v430);
                                        return;
                                    elseif v430 == 1 and l_X_0 < l_X_1 then
                                        v419(0);
                                        return;
                                    elseif v430 == v392 and l_X_1 <= l_X_0 then
                                        v419(v430);
                                        return;
                                    end;
                                end;
                                return;
                            end;
                        end);
                        do
                            local l_v426_0, l_v427_0 = v426, v427;
                            l_v427_0 = l_UserInputService_0.InputEnded:Connect(function(v435) --[[ Line: 1780 ]]
                                -- upvalues: v394 (ref), l_v427_0 (ref), l_v426_0 (ref)
                                if not (not not v435 and (v435.UserInputType == Enum.UserInputType.MouseButton1 or v435.UserInputType == Enum.UserInputType.Touch or v435.UserInputType == Enum.UserInputType.Gamepad1 and v435.KeyCode == Enum.KeyCode.ButtonA)) then
                                    return;
                                else
                                    v394 = 0;
                                    l_v427_0:Disconnect();
                                    l_v426_0:Disconnect();
                                    return;
                                end;
                            end);
                        end;
                    end;
                else
                    v394 = 0;
                end;
                v419(v424);
                return;
            end;
        end;
        local function _(v437) --[[ Line: 1795 ]] --[[ Name: mouseUpFunc ]]
            -- upvalues: v396 (ref), v394 (ref)
            if not v396 then
                return;
            elseif not (not not v437 and (v437.UserInputType == Enum.UserInputType.MouseButton1 or v437.UserInputType == Enum.UserInputType.Touch or v437.UserInputType == Enum.UserInputType.Gamepad1 and v437.KeyCode == Enum.KeyCode.ButtonA)) then
                return;
            else
                v394 = 0;
                return;
            end;
        end;
        local function _(v439, v440, v441) --[[ Line: 1802 ]] --[[ Name: touchClickFunc ]]
            -- upvalues: v436 (copy)
            v436(v439, v440, v441);
        end;
        v391.ValueChanged = l_BindableEvent_3.Event;
        v391.SetValue = function(_, v444) --[[ Line: 1809 ]] --[[ Name: SetValue ]]
            -- upvalues: v419 (copy)
            v419(v444);
        end;
        v391.GetValue = function(_) --[[ Line: 1813 ]] --[[ Name: GetValue ]]
            -- upvalues: l_v389_0 (ref)
            return l_v389_0;
        end;
        v391.SetInteractable = function(_, v447) --[[ Line: 1817 ]] --[[ Name: SetInteractable ]]
            -- upvalues: v394 (ref), v396 (ref), v391 (copy), v408 (copy), v414 (copy)
            v394 = 0;
            v396 = v447;
            v391.SliderFrame.Selectable = v447;
            if not v396 then
                v408();
                return;
            else
                v414();
                return;
            end;
        end;
        v391.SetZIndex = function(_, v449) --[[ Line: 1828 ]] --[[ Name: SetZIndex ]]
            -- upvalues: v399 (copy), v400 (copy), v401 (copy), v402 (copy), v391 (copy)
            v399.ZIndex = v449;
            v400.ZIndex = v449;
            v401.ZIndex = v449;
            v402.ZIndex = v449;
            for v450 = 1, #v391.Steps do
                v391.Steps[v450].ZIndex = v449;
            end;
        end;
        v391.SetMinStep = function(_, v452) --[[ Line: 1839 ]] --[[ Name: SetMinStep ]]
            -- upvalues: v392 (copy), v390 (ref), l_v389_0 (ref), v399 (copy), v400 (copy)
            if v452 >= 0 and v452 <= v392 then
                v390 = v452;
            end;
            if l_v389_0 <= v390 then
                l_v389_0 = v390;
                v399.Visible = false;
            end;
            if v392 <= l_v389_0 then
                l_v389_0 = v392;
                v400.Visible = false;
            end;
        end;
        v399.InputBegan:Connect(function(v453) --[[ Line: 1856 ]]
            -- upvalues: v436 (copy), l_v389_0 (ref)
            v436(v453, l_v389_0 - 1, true);
        end);
        v399.InputEnded:Connect(function(v454) --[[ Line: 1857 ]]
            -- upvalues: v396 (ref), v394 (ref)
            if not v396 then
                return;
            elseif not (not not v454 and (v454.UserInputType == Enum.UserInputType.MouseButton1 or v454.UserInputType == Enum.UserInputType.Touch or v454.UserInputType == Enum.UserInputType.Gamepad1 and v454.KeyCode == Enum.KeyCode.ButtonA)) then
                return;
            else
                v394 = 0;
                return;
            end;
        end);
        v400.InputBegan:Connect(function(v455) --[[ Line: 1858 ]]
            -- upvalues: v436 (copy), l_v389_0 (ref)
            v436(v455, l_v389_0 + 1, true);
        end);
        v400.InputEnded:Connect(function(v456) --[[ Line: 1859 ]]
            -- upvalues: v396 (ref), v394 (ref)
            if not v396 then
                return;
            elseif not (not not v456 and (v456.UserInputType == Enum.UserInputType.MouseButton1 or v456.UserInputType == Enum.UserInputType.Touch or v456.UserInputType == Enum.UserInputType.Gamepad1 and v456.KeyCode == Enum.KeyCode.ButtonA)) then
                return;
            else
                v394 = 0;
                return;
            end;
        end);
        local function v460(v457) --[[ Line: 1861 ]] --[[ Name: onVREnabled ]]
            -- upvalues: l_VRService_0 (ref), v399 (copy), v396 (ref), v400 (copy), v391 (copy), v392 (copy)
            if v457 ~= "VREnabled" then
                return;
            elseif l_VRService_0.VREnabled then
                v399.Selectable = v396;
                v400.Selectable = v396;
                v391.SliderFrame.Selectable = v396;
                for v458 = 1, v392 do
                    v391.Steps[v458].Selectable = v396;
                    v391.Steps[v458].Active = v396;
                end;
                return;
            else
                v399.Selectable = false;
                v400.Selectable = false;
                v391.SliderFrame.Selectable = v396;
                for v459 = 1, v392 do
                    v391.Steps[v459].Selectable = false;
                    v391.Steps[v459].Active = false;
                end;
                return;
            end;
        end;
        l_VRService_0.Changed:Connect(v460);
        v460("VREnabled");
        for v461 = 1, v392 do
            v391.Steps[v461].InputBegan:Connect(function(v462) --[[ Line: 1888 ]]
                -- upvalues: v436 (copy), v461 (copy)
                v436(v462, v461);
            end);
            v391.Steps[v461].InputEnded:Connect(function(v463) --[[ Line: 1891 ]]
                -- upvalues: v396 (ref), v394 (ref)
                if not v396 then
                    return;
                elseif not (not not v463 and (v463.UserInputType == Enum.UserInputType.MouseButton1 or v463.UserInputType == Enum.UserInputType.Touch or v463.UserInputType == Enum.UserInputType.Gamepad1 and v463.KeyCode == Enum.KeyCode.ButtonA)) then
                    return;
                else
                    v394 = 0;
                    return;
                end;
            end);
        end;
        v391.SliderFrame.InputBegan:Connect(function(v464) --[[ Line: 1895 ]]
            -- upvalues: l_VRService_0 (ref), l_GuiService_0 (ref), v391 (copy), v436 (copy), l_v389_0 (ref)
            if l_VRService_0.VREnabled then
                local l_SelectedCoreObject_1 = l_GuiService_0.SelectedCoreObject;
                if not l_SelectedCoreObject_1 or not l_SelectedCoreObject_1:IsDescendantOf(v391.SliderFrame.Parent) then
                    return;
                end;
            end;
            v436(v464, l_v389_0);
        end);
        v391.SliderFrame.InputEnded:Connect(function(v466) --[[ Line: 1902 ]]
            -- upvalues: l_VRService_0 (ref), l_GuiService_0 (ref), v391 (copy), v396 (ref), v394 (ref)
            if l_VRService_0.VREnabled then
                local l_SelectedCoreObject_2 = l_GuiService_0.SelectedCoreObject;
                if not l_SelectedCoreObject_2 or not l_SelectedCoreObject_2:IsDescendantOf(v391.SliderFrame.Parent) then
                    return;
                end;
            end;
            if not v396 then
                return;
            elseif not (not not v466 and (v466.UserInputType == Enum.UserInputType.MouseButton1 or v466.UserInputType == Enum.UserInputType.Touch or v466.UserInputType == Enum.UserInputType.Gamepad1 and v466.KeyCode == Enum.KeyCode.ButtonA)) then
                return;
            else
                v394 = 0;
                return;
            end;
        end);
        local function v468() --[[ Line: 1911 ]]
            -- upvalues: v395 (ref), v419 (copy), l_v389_0 (ref), v394 (ref)
            if v395 == nil then
                return;
            else
                if tick() - v395 >= 0.2 then
                    v419(l_v389_0 + v394);
                end;
                return;
            end;
        end;
        local v469 = true;
        local v470 = {
            [Enum.KeyCode.Thumbstick1] = true, 
            [Enum.KeyCode.DPadLeft] = -1, 
            [Enum.KeyCode.DPadRight] = 1, 
            [Enum.KeyCode.Left] = -1, 
            [Enum.KeyCode.Right] = 1, 
            [Enum.KeyCode.A] = -1, 
            [Enum.KeyCode.D] = 1, 
            [Enum.KeyCode.ButtonA] = true
        };
        l_UserInputService_0.InputBegan:Connect(function(v471) --[[ Line: 1935 ]]
            -- upvalues: v396 (ref), v469 (ref), l_GuiService_0 (ref), v391 (copy), v470 (copy), v394 (ref), v419 (copy), l_v389_0 (ref)
            if not v396 then
                return;
            elseif not v469 then
                return;
            elseif v471.UserInputType ~= Enum.UserInputType.Gamepad1 and v471.UserInputType ~= Enum.UserInputType.Keyboard then
                return;
            else
                local l_SelectedCoreObject_3 = l_GuiService_0.SelectedCoreObject;
                if not l_SelectedCoreObject_3 or not l_SelectedCoreObject_3:IsDescendantOf(v391.SliderFrame.Parent) then
                    return;
                elseif v470[v471.KeyCode] == -1 then
                    v394 = -1;
                    v419(l_v389_0 - 1);
                    return;
                else
                    if v470[v471.KeyCode] == 1 then
                        v394 = 1;
                        v419(l_v389_0 + 1);
                    end;
                    return;
                end;
            end;
        end);
        l_UserInputService_0.InputEnded:Connect(function(v473) --[[ Line: 1952 ]]
            -- upvalues: v396 (ref), l_GuiService_0 (ref), v391 (copy), v470 (copy), v394 (ref)
            if not v396 then
                return;
            elseif v473.UserInputType ~= Enum.UserInputType.Gamepad1 and v473.UserInputType ~= Enum.UserInputType.Keyboard then
                return;
            else
                local l_SelectedCoreObject_4 = l_GuiService_0.SelectedCoreObject;
                if not l_SelectedCoreObject_4 or not l_SelectedCoreObject_4:IsDescendantOf(v391.SliderFrame.Parent) then
                    return;
                else
                    if v470[v473.KeyCode] then
                        v394 = 0;
                    end;
                    return;
                end;
            end;
        end);
        l_UserInputService_0.InputChanged:Connect(function(v475) --[[ Line: 1964 ]]
            -- upvalues: v396 (ref), v394 (ref), v469 (ref), l_GuiService_0 (ref), v391 (copy), v419 (copy), l_v389_0 (ref)
            if not v396 then
                v394 = 0;
                return;
            elseif not v469 then
                v394 = 0;
                return;
            elseif v475.UserInputType ~= Enum.UserInputType.Gamepad1 then
                return;
            else
                local l_SelectedCoreObject_5 = l_GuiService_0.SelectedCoreObject;
                if not l_SelectedCoreObject_5 or not l_SelectedCoreObject_5:IsDescendantOf(v391.SliderFrame.Parent) then
                    return;
                elseif v475.KeyCode ~= Enum.KeyCode.Thumbstick1 then
                    return;
                elseif v475.Position.X > 0.8 and v475.Delta.X > 0 and v394 ~= 1 then
                    v394 = 1;
                    v419(l_v389_0 + 1);
                    return;
                elseif v475.Position.X < -0.8 and v475.Delta.X < 0 and v394 ~= -1 then
                    v394 = -1;
                    v419(l_v389_0 - 1);
                    return;
                else
                    if math.abs(v475.Position.X) < 0.8 then
                        v394 = 0;
                    end;
                    return;
                end;
            end;
        end);
        local v477 = false;
        l_GuiService_0.Changed:Connect(function(v478) --[[ Line: 1991 ]]
            -- upvalues: l_GuiService_0 (ref), v391 (copy), v417 (copy), v477 (ref), v395 (ref), l_RunService_0 (ref), v397 (copy), v468 (copy)
            if v478 ~= "SelectedCoreObject" then
                return;
            else
                local l_SelectedCoreObject_6 = l_GuiService_0.SelectedCoreObject;
                if l_SelectedCoreObject_6 and l_SelectedCoreObject_6:IsDescendantOf(v391.SliderFrame.Parent) then
                    v417(0);
                    if not v477 then
                        v477 = true;
                        v395 = tick();
                        l_RunService_0:BindToRenderStep(v397, Enum.RenderPriority.Input.Value + 1, v468);
                        return;
                    end;
                else
                    v417(0.36);
                    if v477 then
                        v477 = false;
                        l_RunService_0:UnbindFromRenderStep(v397);
                    end;
                end;
                return;
            end;
        end);
        v391.SliderFrame.AncestryChanged:Connect(function(_, v481) --[[ Line: 2012 ]]
            -- upvalues: v469 (ref)
            v469 = v481;
        end);
        v419(l_v389_0);
        return v391;
    end;
end;
local v483 = 50;
if false then
    v483 = 90;
end;
local v484 = {};
local function v540(v485, v486, v487, v488, v489, v490) --[[ Line: 2025 ]] --[[ Name: AddNewRow ]]
    -- upvalues: v484 (copy), v22 (copy), v483 (ref), v24 (copy), v15 (copy), v72 (copy), v23 (copy), v482 (copy), v362 (copy), v288 (copy), l_VRService_0 (copy), l_UserInputService_0 (copy), l_GuiService_0 (copy), l_PlayerGui_0 (copy)
    local v491 = 0;
    local v492 = v487 ~= "TextBox";
    if v484[v485] then
        v491 = v484[v485];
    end;
    local v493 = nil;
    v493 = v22.Create("ImageButton")({
        Name = v486 .. "Frame", 
        BackgroundTransparency = 1, 
        BorderSizePixel = 0, 
        Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png", 
        ScaleType = Enum.ScaleType.Slice, 
        SliceCenter = Rect.new(2, 2, 18, 18), 
        ImageTransparency = 1, 
        Active = false, 
        AutoButtonColor = false, 
        Size = UDim2.new(1, 0, 0, v483), 
        Position = UDim2.new(0, 0, 0, v491), 
        ZIndex = 2, 
        Selectable = false, 
        SelectionImageObject = v24, 
        Parent = v485.Page
    });
    v493.ImageColor3 = v493.BackgroundColor3;
    if v493 and v490 then
        v493.Position = UDim2.new(v493.Position.X.Scale, v493.Position.X.Offset, v493.Position.Y.Scale, v493.Position.Y.Offset + v490);
    end;
    local v494 = nil;
    v494 = v22.Create("TextLabel")({
        Name = v486 .. "Label", 
        Text = v486, 
        Font = Enum.Font.SourceSansBold, 
        TextSize = 16, 
        TextColor3 = Color3.fromRGB(255, 255, 255), 
        TextXAlignment = Enum.TextXAlignment.Left, 
        BackgroundTransparency = 1, 
        Size = UDim2.new(0, 200, 1, 0), 
        Position = UDim2.new(0, 10, 0, 0), 
        ZIndex = 2, 
        Parent = v493
    });
    local l_UITextSizeConstraint_0 = Instance.new("UITextSizeConstraint");
    if v15 then
        v494.Size = UDim2.new(0.35, 0, 1, 0);
        v494.TextScaled = true;
        v494.TextWrapped = true;
        l_UITextSizeConstraint_0.Parent = v494;
        l_UITextSizeConstraint_0.MaxTextSize = 16;
    end;
    if not v492 then
        v494.Text = "";
    end;
    local function v498(_, v497) --[[ Line: 2088 ]] --[[ Name: onResized ]]
        -- upvalues: v494 (ref), l_UITextSizeConstraint_0 (copy)
        if v497 then
            v494.TextSize = 16;
        else
            v494.TextSize = false and 36 or 24;
        end;
        l_UITextSizeConstraint_0.MaxTextSize = v494.TextSize;
    end;
    local v499 = v72();
    local v500 = v72();
    if v500.Y > v500.X then
        v494.TextSize = 16;
    else
        v494.TextSize = false and 36 or 24;
    end;
    l_UITextSizeConstraint_0.MaxTextSize = v494.TextSize;
    v23[v493] = v498;
    local l_v498_0 = v498;
    v500 = v72();
    local v502 = v72();
    l_v498_0(v500, v502.Y > v502.X);
    v499 = nil;
    l_v498_0 = nil;
    if v487 == "Slider" then
        l_v498_0 = v482(v488, v489);
        l_v498_0.SliderFrame.Parent = v493;
        v499 = l_v498_0.SliderFrame;
    elseif v487 == "Selector" then
        l_v498_0 = v362(v488, v489);
        l_v498_0.SelectorFrame.Parent = v493;
        v499 = l_v498_0.SelectorFrame;
    elseif v487 == "DropDown" then
        l_v498_0 = v288(v488, v489, v485.HubRef);
        l_v498_0.DropDownFrame.Parent = v493;
        v499 = l_v498_0.DropDownFrame;
    elseif v487 == "TextBox" then
        v500 = false;
        local v503 = false;
        v502 = v22.Create("ImageLabel")({
            Image = "", 
            BackgroundTransparency = 1
        });
        l_v498_0 = {
            HubRef = nil
        };
        local v504 = v22.Create("TextBox")({
            AnchorPoint = Vector2.new(1, 0.5), 
            Size = UDim2.new(0.6, 0, 1, 0), 
            Position = UDim2.new(1, 0, 0.5, 0), 
            Text = v486, 
            TextColor3 = Color3.fromRGB(49, 49, 49), 
            BackgroundTransparency = 0.5, 
            BorderSizePixel = 0, 
            TextYAlignment = Enum.TextYAlignment.Top, 
            TextXAlignment = Enum.TextXAlignment.Left, 
            TextWrapped = true, 
            Font = Enum.Font.SourceSans, 
            TextSize = 24, 
            ZIndex = 2, 
            SelectionImageObject = v502, 
            ClearTextOnFocus = false, 
            Parent = v493
        });
        v499 = v504;
        v504.Focused:Connect(function() --[[ Line: 2146 ]]
            -- upvalues: l_VRService_0 (ref), l_UserInputService_0 (ref), l_GuiService_0 (ref), v504 (copy), v486 (copy)
            if not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) then
                l_GuiService_0.SelectedCoreObject = v504;
            end;
            if v504.Text == v486 then
                v504.Text = "";
            end;
        end);
        do
            local l_v500_0, l_v503_0 = v500, v503;
            v504.FocusLost:Connect(function(_, _) --[[ Line: 2155 ]]
                -- upvalues: l_v503_0 (ref)
                l_v503_0 = false;
            end);
            if v490 then
                v504.Position = UDim2.new(v504.Position.X.Scale, v504.Position.X.Offset, v504.Position.Y.Scale, v504.Position.Y.Offset + v490);
            end;
            v499.SelectionGained:Connect(function() --[[ Line: 2163 ]]
                -- upvalues: l_VRService_0 (ref), l_UserInputService_0 (ref), v504 (copy), l_v498_0 (ref), v499 (ref)
                if not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) then
                    v504.BackgroundTransparency = 0.1;
                    if l_v498_0.HubRef then
                        l_v498_0.HubRef:ScrollToFrame(v499);
                    end;
                end;
            end);
            v499.SelectionLost:Connect(function() --[[ Line: 2172 ]]
                -- upvalues: l_VRService_0 (ref), l_UserInputService_0 (ref), v504 (copy)
                if not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) then
                    v504.BackgroundTransparency = 0.5;
                end;
            end);
            local function v511() --[[ Line: 2178 ]]
                -- upvalues: l_PlayerGui_0 (ref), v499 (ref), l_VRService_0 (ref), l_UserInputService_0 (ref), v485 (copy), l_GuiService_0 (ref), l_v500_0 (ref)
                local l_DropDownFullscreenFrame_0 = l_PlayerGui_0.RobloxGui:FindFirstChild("DropDownFullscreenFrame");
                if l_DropDownFullscreenFrame_0 and l_DropDownFullscreenFrame_0.Visible then
                    return;
                else
                    local l_v499_0 = v499;
                    if l_v499_0 and l_v499_0.Visible and l_v499_0.ZIndex > 1 and not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) and v485.Active then
                        l_GuiService_0.SelectedCoreObject = l_v499_0;
                        l_v500_0 = true;
                    end;
                    return;
                end;
            end;
            local function v513(v512) --[[ Line: 2189 ]] --[[ Name: processInput ]]
                -- upvalues: l_GuiService_0 (ref), v499 (ref), l_v503_0 (ref), v504 (copy)
                if v512.UserInputState == Enum.UserInputState.Begin and v512.KeyCode == Enum.KeyCode.Return and l_GuiService_0.SelectedCoreObject == v499 then
                    l_v503_0 = true;
                    v504:CaptureFocus();
                end;
            end;
            v504.MouseEnter:Connect(v511);
            l_UserInputService_0.InputBegan:Connect(v513);
        end;
    elseif v487 == "TextEntry" then
        v500 = false;
        local v514 = false;
        v502 = v22.Create("ImageLabel")({
            Image = "", 
            BackgroundTransparency = 1
        });
        l_v498_0 = {
            HubRef = nil
        };
        local v515 = v22.Create("TextBox")({
            AnchorPoint = Vector2.new(1, 0.5), 
            Size = UDim2.new(0.4, -10, 0, 40), 
            Position = UDim2.new(1, 0, 0.5, 0), 
            Text = v486, 
            TextColor3 = Color3.fromRGB(178, 178, 178), 
            BackgroundTransparency = 1, 
            BorderSizePixel = 0, 
            TextYAlignment = Enum.TextYAlignment.Center, 
            TextXAlignment = Enum.TextXAlignment.Center, 
            TextWrapped = false, 
            Font = Enum.Font.SourceSans, 
            TextSize = 24, 
            ZIndex = 2, 
            SelectionImageObject = v502, 
            ClearTextOnFocus = false, 
            Parent = v493
        });
        v499 = v515;
        v515.Focused:Connect(function() --[[ Line: 2236 ]]
            -- upvalues: l_VRService_0 (ref), l_UserInputService_0 (ref), l_GuiService_0 (ref), v515 (copy), v486 (copy)
            if not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) then
                l_GuiService_0.SelectedCoreObject = v515;
            end;
            if v515.Text == v486 then
                v515.Text = "";
            end;
        end);
        do
            local l_v500_1, l_v514_0 = v500, v514;
            v515.FocusLost:Connect(function(_, _) --[[ Line: 2245 ]]
                -- upvalues: l_v514_0 (ref)
                l_v514_0 = false;
            end);
            if v490 then
                v515.Position = UDim2.new(v515.Position.X.Scale, v515.Position.X.Offset, v515.Position.Y.Scale, v515.Position.Y.Offset + v490);
            end;
            v499.SelectionGained:Connect(function() --[[ Line: 2253 ]]
                -- upvalues: l_VRService_0 (ref), l_UserInputService_0 (ref), v515 (copy), l_v498_0 (ref), v499 (ref)
                if not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) then
                    v515.BackgroundTransparency = 0.8;
                    if l_v498_0.HubRef then
                        l_v498_0.HubRef:ScrollToFrame(v499);
                    end;
                end;
            end);
            v499.SelectionLost:Connect(function() --[[ Line: 2262 ]]
                -- upvalues: l_VRService_0 (ref), l_UserInputService_0 (ref), v515 (copy)
                if not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) then
                    v515.BackgroundTransparency = 1;
                end;
            end);
            local function v522() --[[ Line: 2268 ]]
                -- upvalues: l_PlayerGui_0 (ref), v499 (ref), l_VRService_0 (ref), l_UserInputService_0 (ref), v485 (copy), l_GuiService_0 (ref), l_v500_1 (ref)
                local l_DropDownFullscreenFrame_1 = l_PlayerGui_0.RobloxGui:FindFirstChild("DropDownFullscreenFrame");
                if l_DropDownFullscreenFrame_1 and l_DropDownFullscreenFrame_1.Visible then
                    return;
                else
                    local l_v499_1 = v499;
                    if l_v499_1 and l_v499_1.Visible and l_v499_1.ZIndex > 1 and not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) and v485.Active then
                        l_GuiService_0.SelectedCoreObject = l_v499_1;
                        l_v500_1 = true;
                    end;
                    return;
                end;
            end;
            local function v524(v523) --[[ Line: 2279 ]] --[[ Name: processInput ]]
                -- upvalues: l_GuiService_0 (ref), v499 (ref), l_v514_0 (ref), v515 (copy)
                if v523.UserInputState == Enum.UserInputState.Begin and v523.KeyCode == Enum.KeyCode.Return and l_GuiService_0.SelectedCoreObject == v499 then
                    l_v514_0 = true;
                    v515:CaptureFocus();
                end;
            end;
            v493.MouseEnter:Connect(v522);
            l_v498_0.SetZIndex = function(_, v526) --[[ Line: 2291 ]] --[[ Name: SetZIndex ]]
                -- upvalues: v515 (copy)
                v515.ZIndex = v526;
            end;
            l_v498_0.SetInteractable = function(_, v528) --[[ Line: 2295 ]] --[[ Name: SetInteractable ]]
                -- upvalues: v515 (copy)
                v515.Selectable = v528;
                if not v528 then
                    v515.TextColor3 = Color3.fromRGB(49, 49, 49);
                    v515.ZIndex = 1;
                    return;
                else
                    v515.TextColor3 = Color3.fromRGB(178, 178, 178);
                    v515.ZIndex = 2;
                    return;
                end;
            end;
            l_v498_0.SetValue = function(_, v530) --[[ Line: 2306 ]] --[[ Name: SetValue ]]
                -- upvalues: v515 (copy)
                v515.Text = v530;
            end;
            local l_BindableEvent_4 = Instance.new("BindableEvent");
            l_BindableEvent_4.Name = "ValueChanged";
            v515.FocusLost:Connect(function() --[[ Line: 2313 ]]
                -- upvalues: l_BindableEvent_4 (copy), v515 (copy)
                l_BindableEvent_4:Fire(v515.Text);
            end);
            l_v498_0.ValueChanged = l_BindableEvent_4.Event;
            l_UserInputService_0.InputBegan:Connect(v524);
        end;
    end;
    v500 = v486 .. "ValueChanger";
    l_v498_0.Name = v500;
    v491 = v491 + v483;
    if v490 then
        v491 = v491 + v490;
    end;
    v484[v485] = v491;
    if v492 then
        v500 = function() --[[ Line: 2332 ]]
            -- upvalues: l_PlayerGui_0 (ref), l_v498_0 (ref), l_VRService_0 (ref), l_UserInputService_0 (ref), v485 (copy), l_GuiService_0 (ref)
            local l_DropDownFullscreenFrame_2 = l_PlayerGui_0.RobloxGui:FindFirstChild("DropDownFullscreenFrame");
            if l_DropDownFullscreenFrame_2 and l_DropDownFullscreenFrame_2.Visible then
                return;
            else
                local v533 = l_v498_0.SliderFrame or l_v498_0.SliderFrame or l_v498_0.DropDownFrame or l_v498_0.SelectorFrame;
                if v533 and v533.Visible and v533.ZIndex > 1 and not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) and v485.Active then
                    l_GuiService_0.SelectedCoreObject = v533;
                end;
                return;
            end;
        end;
        v493.MouseEnter:Connect(v500);
        local function v537(v534) --[[ Line: 2354 ]] --[[ Name: onVREnabled ]]
            -- upvalues: l_VRService_0 (ref), v493 (ref), v499 (ref), l_GuiService_0 (ref)
            if v534 == "VREnabled" then
                if l_VRService_0.VREnabled then
                    v493.Selectable = true;
                    v493.Active = true;
                    v499.Active = true;
                    l_GuiService_0.Changed:Connect(function(v535) --[[ Line: 2360 ]]
                        -- upvalues: l_GuiService_0 (ref), v493 (ref)
                        if v535 == "SelectedCoreObject" then
                            local l_SelectedCoreObject_7 = l_GuiService_0.SelectedCoreObject;
                            if l_SelectedCoreObject_7 and (l_SelectedCoreObject_7 == v493 or l_SelectedCoreObject_7:IsDescendantOf(v493)) then
                                v493.ImageTransparency = 0.5;
                                v493.BackgroundTransparency = 1;
                                return;
                            else
                                v493.ImageTransparency = 1;
                                v493.BackgroundTransparency = 1;
                            end;
                        end;
                    end);
                    return;
                else
                    v493.Selectable = false;
                    v493.Active = false;
                end;
            end;
        end;
        l_VRService_0.Changed:Connect(v537);
        if l_VRService_0.VREnabled then
            v493.Selectable = true;
            v493.Active = true;
            v499.Active = true;
            l_GuiService_0.Changed:Connect(function(v538) --[[ Line: 2360 ]]
                -- upvalues: l_GuiService_0 (ref), v493 (ref)
                if v538 == "SelectedCoreObject" then
                    local l_SelectedCoreObject_8 = l_GuiService_0.SelectedCoreObject;
                    if l_SelectedCoreObject_8 and (l_SelectedCoreObject_8 == v493 or l_SelectedCoreObject_8:IsDescendantOf(v493)) then
                        v493.ImageTransparency = 0.5;
                        v493.BackgroundTransparency = 1;
                        return;
                    else
                        v493.ImageTransparency = 1;
                        v493.BackgroundTransparency = 1;
                    end;
                end;
            end);
        else
            v493.Selectable = false;
            v493.Active = false;
        end;
        v499.SelectionGained:Connect(function() --[[ Line: 2381 ]]
            -- upvalues: l_VRService_0 (ref), l_UserInputService_0 (ref), v493 (ref), l_v498_0 (ref)
            if not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) then
                if l_VRService_0.VREnabled then
                    v493.ImageTransparency = 0.5;
                    v493.BackgroundTransparency = 1;
                else
                    v493.ImageTransparency = 1;
                    v493.BackgroundTransparency = 0.5;
                end;
                if l_v498_0.HubRef then
                    l_v498_0.HubRef:ScrollToFrame(v493);
                end;
            end;
        end);
        v499.SelectionLost:Connect(function() --[[ Line: 2396 ]]
            -- upvalues: l_VRService_0 (ref), l_UserInputService_0 (ref), v493 (ref)
            if not l_VRService_0.VREnabled and (not l_UserInputService_0.TouchEnabled or l_UserInputService_0.GamepadEnabled and true or false) then
                v493.ImageTransparency = 1;
                v493.BackgroundTransparency = 1;
            end;
        end);
    end;
    v485:AddRow(v493, v494, l_v498_0, v490, false);
    l_v498_0.Selection = v499;
    return v493, v494, l_v498_0;
end;
local function v554(v541, v542, v543, v544) --[[ Line: 2411 ]] --[[ Name: AddNewRowObject ]]
    -- upvalues: v484 (copy), v22 (copy), v483 (ref), v24 (copy), v23 (copy), v72 (copy), l_GuiService_0 (copy), l_VRService_0 (copy)
    local v545 = 0;
    if v484[v541] then
        v545 = v484[v541];
    end;
    local v546 = v22.Create("ImageButton")({
        Name = v542 .. "Frame", 
        BackgroundTransparency = 1, 
        BorderSizePixel = 0, 
        Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png", 
        ScaleType = Enum.ScaleType.Slice, 
        SliceCenter = Rect.new(10, 10, 10, 10), 
        ImageTransparency = 1, 
        Active = false, 
        AutoButtonColor = false, 
        Size = UDim2.new(1, 0, 0, v483), 
        Position = UDim2.new(0, 0, 0, v545), 
        ZIndex = 2, 
        Selectable = false, 
        SelectionImageObject = v24, 
        Parent = v541.Page
    });
    v546.ImageColor3 = v546.BackgroundColor3;
    v546.SelectionGained:Connect(function() --[[ Line: 2437 ]]
        -- upvalues: v546 (copy)
        v546.BackgroundTransparency = 0.5;
    end);
    v546.SelectionLost:Connect(function() --[[ Line: 2440 ]]
        -- upvalues: v546 (copy)
        v546.BackgroundTransparency = 1;
    end);
    local v547 = v22.Create("TextLabel")({
        Name = v542 .. "Label", 
        Text = v542, 
        Font = Enum.Font.SourceSansBold, 
        TextSize = 16, 
        TextColor3 = Color3.fromRGB(255, 255, 255), 
        TextXAlignment = Enum.TextXAlignment.Left, 
        BackgroundTransparency = 1, 
        Size = UDim2.new(0, 200, 1, 0), 
        Position = UDim2.new(0, 10, 0, 0), 
        ZIndex = 2, 
        Parent = v546
    });
    local function v550(_, v549) --[[ Line: 2458 ]] --[[ Name: onResized ]]
        -- upvalues: v547 (copy)
        if v549 then
            v547.TextSize = 16;
            return;
        else
            v547.TextSize = false and 36 or 24;
            return;
        end;
    end;
    v23[v546] = v550;
    local l_v550_0 = v550;
    local v552 = v72();
    local v553 = v72();
    l_v550_0(v552, v553.Y > v553.X);
    if v544 then
        v546.Position = UDim2.new(v546.Position.X.Scale, v546.Position.X.Offset, v546.Position.Y.Scale, v546.Position.Y.Offset + v544);
    end;
    v545 = v545 + v483;
    if v544 then
        v545 = v545 + v544;
    end;
    v484[v541] = v545;
    l_v550_0 = function() --[[ Line: 2479 ]]
        -- upvalues: v546 (copy), l_GuiService_0 (ref)
        if v546.Visible then
            l_GuiService_0.SelectedCoreObject = v546;
        end;
    end;
    v546.MouseEnter:Connect(l_v550_0);
    v543.SelectionImageObject = v24;
    v543.SelectionGained:Connect(function() --[[ Line: 2488 ]]
        -- upvalues: l_VRService_0 (ref), v546 (copy)
        if l_VRService_0.VREnabled then
            v546.ImageTransparency = 0.5;
            v546.BackgroundTransparency = 1;
            return;
        else
            v546.ImageTransparency = 1;
            v546.BackgroundTransparency = 0.5;
            return;
        end;
    end);
    v543.SelectionLost:Connect(function() --[[ Line: 2497 ]]
        -- upvalues: v546 (copy)
        v546.ImageTransparency = 1;
        v546.BackgroundTransparency = 1;
    end);
    v543.Parent = v546;
    v541:AddRow(v546, v547, v543, v544, true);
    return v546;
end;
local v638 = {
    Create = function(_, v556) --[[ Line: 2511 ]] --[[ Name: Create ]]
        return function(v557) --[[ Line: 2512 ]]
            -- upvalues: v556 (copy)
            local v558 = Instance.new(v556);
            local v559 = nil;
            for v560, v561 in pairs(v557) do
                if type(v560) == "number" then
                    v561.Parent = v558;
                elseif v560 == "Parent" then
                    v559 = v561;
                else
                    v558[v560] = v561;
                end;
            end;
            if v559 then
                v558.Parent = v559;
            end;
            return v558;
        end;
    end, 
    RayPlaneIntersection = function(_, v563, v564, v565) --[[ Line: 2533 ]] --[[ Name: RayPlaneIntersection ]]
        v564 = v564.unit;
        v563 = v563.Unit;
        local v566 = v564:Dot(v563.Direction);
        if v566 == 0 then
            return nil;
        else
            local v567 = v564:Dot(v565 - v563.Origin) / v566;
            if v567 < 0 then
                return nil;
            else
                return v563.Origin + v563.Direction * v567;
            end;
        end;
    end, 
    GetEaseLinear = function(_) --[[ Line: 2551 ]] --[[ Name: GetEaseLinear ]]
        -- upvalues: v35 (copy)
        return v35;
    end, 
    GetEaseOutQuad = function(_) --[[ Line: 2554 ]] --[[ Name: GetEaseOutQuad ]]
        -- upvalues: v40 (copy)
        return v40;
    end, 
    GetEaseInOutQuad = function(_) --[[ Line: 2557 ]] --[[ Name: GetEaseInOutQuad ]]
        -- upvalues: v45 (copy)
        return v45;
    end, 
    CreateNewSlider = function(_, v572, v573, v574) --[[ Line: 2561 ]] --[[ Name: CreateNewSlider ]]
        -- upvalues: v482 (copy)
        return v482(v572, v573, v574);
    end, 
    CreateNewSelector = function(_, v576, v577) --[[ Line: 2565 ]] --[[ Name: CreateNewSelector ]]
        -- upvalues: v362 (copy)
        return (v362(v576, v577));
    end, 
    CreateNewDropDown = function(_, v579, v580) --[[ Line: 2569 ]] --[[ Name: CreateNewDropDown ]]
        -- upvalues: v288 (copy)
        return (v288(v579, v580, nil));
    end, 
    AddNewRow = function(_, v582, v583, v584, v585, v586, v587) --[[ Line: 2573 ]] --[[ Name: AddNewRow ]]
        -- upvalues: v540 (copy)
        return v540(v582, v583, v584, v585, v586, v587);
    end, 
    AddNewRowObject = function(_, v589, v590, v591, v592) --[[ Line: 2577 ]] --[[ Name: AddNewRowObject ]]
        -- upvalues: v554 (copy)
        return (v554(v589, v590, v591, v592));
    end, 
    ShowAlert = function(_, v594, v595, v596, v597, v598) --[[ Line: 2581 ]] --[[ Name: ShowAlert ]]
        -- upvalues: v387 (copy)
        v387(v594, v595, v596, v597, v598);
    end, 
    IsSmallTouchScreen = function(_) --[[ Line: 2585 ]] --[[ Name: IsSmallTouchScreen ]]
        -- upvalues: v72 (copy), l_UserInputService_0 (copy)
        local v600 = v72();
        return l_UserInputService_0.TouchEnabled and (v600.Y < 500 or v600.X < 700);
    end, 
    IsPortrait = function(_) --[[ Line: 2589 ]] --[[ Name: IsPortrait ]]
        -- upvalues: v72 (copy)
        local v602 = v72();
        return v602.Y > v602.X;
    end, 
    MakeStyledButton = function(_, v604, v605, v606, v607, v608, v609) --[[ Line: 2593 ]] --[[ Name: MakeStyledButton ]]
        -- upvalues: v195 (copy)
        return v195(v604, v605, v606, v607, v608, v609);
    end, 
    MakeStyledImageButton = function(_, v611, v612, v613, v614, v615, v616, v617) --[[ Line: 2597 ]] --[[ Name: MakeStyledImageButton ]]
        -- upvalues: v205 (copy)
        return v205(v611, v612, v613, v614, v615, v616, v617);
    end, 
    AddButtonRow = function(_, v619, v620, v621, v622, v623, v624) --[[ Line: 2601 ]] --[[ Name: AddButtonRow ]]
        -- upvalues: v216 (copy)
        return v216(v619, v620, v621, v622, v623, v624);
    end, 
    CreateSignal = function(_) --[[ Line: 2605 ]] --[[ Name: CreateSignal ]]
        -- upvalues: v71 (copy)
        return (v71());
    end, 
    UsesSelectedObject = function(_) --[[ Line: 2609 ]] --[[ Name: UsesSelectedObject ]]
        -- upvalues: l_VRService_0 (copy), l_UserInputService_0 (copy)
        if l_VRService_0.VREnabled then
            return false;
        elseif l_UserInputService_0.TouchEnabled and not l_UserInputService_0.GamepadEnabled then
            return false;
        else
            return true;
        end;
    end, 
    TweenProperty = function(_, v628, v629, v630, v631, v632, v633, v634) --[[ Line: 2613 ]] --[[ Name: TweenProperty ]]
        return PropertyTweener(v628, v629, v630, v631, v632, v633, v634);
    end, 
    OnResized = function(_, v636, v637) --[[ Line: 2617 ]] --[[ Name: OnResized ]]
        -- upvalues: v152 (copy)
        return v152(v636, v637);
    end
};
v638.FireOnResized = function(_) --[[ Line: 2621 ]] --[[ Name: FireOnResized ]]
    -- upvalues: v72 (copy), v638 (copy), v23 (copy)
    local v640 = v72();
    local v641 = v638:IsPortrait();
    for _, v643 in pairs(v23) do
        v643(v640, v641);
    end;
end;
v638.Lerp = function(_, v645, v646, v647) --[[ Line: 2632 ]] --[[ Name: Lerp ]]
    return (1 - v645) * v646 + v645 * v647;
end;
v638.Round = function(_, v649) --[[ Line: 2637 ]] --[[ Name: Round ]]
    return v649 % 1 >= 0.5 and math.ceil(v649) or math.floor(v649);
end;
return v638;