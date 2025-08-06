-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    OpenClose = nil, 
    IsOpen = false, 
    StateChanged = Instance.new("BindableEvent"), 
    ModuleName = "Backpack", 
    KeepVRTopbarOpen = true, 
    VRIsExclusive = true, 
    VRClosesNonExclusive = true
};
local v1 = 60;
local l_script_Attribute_0 = script:GetAttribute("TextSize");
local l_script_Attribute_1 = script:GetAttribute("BackgroundTransparency");
local l_script_Attribute_2 = script:GetAttribute("BackgroundColor");
local l_script_Attribute_3 = script:GetAttribute("DraggableColor");
local l_script_Attribute_4 = script:GetAttribute("EquippedColor");
local l_script_Attribute_5 = script:GetAttribute("SlotLockedTransparency");
local l_script_Attribute_6 = script:GetAttribute("BorderColor");
local v9 = {
    Enum.KeyCode.Backquote
};
local l_script_Attribute_7 = script:GetAttribute("FullSlots");
local l_script_Attribute_8 = script:GetAttribute("EmptySlots");
local l_script_Attribute_9 = script:GetAttribute("SearchBoxColor");
local l_script_Attribute_10 = script:GetAttribute("SearchBoxTransparency");
local l_Api_0 = script:WaitForChild("Api");
l_Api_0.Parent = game.ReplicatedStorage;
local l_Favorite_Item_0 = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Favorite_Item");
local v16 = nil;
local v17 = true;
local function v21() --[[ Line: 72 ]]
    local v18 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui);
    local v19 = Instance.new("Frame", v18);
    v19.BackgroundTransparency = 1;
    v19.Size = UDim2.new(1, 0, 1, 0);
    local l_AbsoluteSize_0 = v19.AbsoluteSize;
    v18:Destroy();
    return l_AbsoluteSize_0;
end;
local l_Value_0 = Enum.KeyCode.Zero.Value;
local l_Value_1 = Enum.KeyCode.Backspace.Value;
local v24 = {
    [Enum.UserInputType.Gamepad1] = true, 
    [Enum.UserInputType.Gamepad2] = true, 
    [Enum.UserInputType.Gamepad3] = true, 
    [Enum.UserInputType.Gamepad4] = true, 
    [Enum.UserInputType.Gamepad5] = true, 
    [Enum.UserInputType.Gamepad6] = true, 
    [Enum.UserInputType.Gamepad7] = true, 
    [Enum.UserInputType.Gamepad8] = true
};
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_StarterGui_0 = game:GetService("StarterGui");
local l_GuiService_0 = game:GetService("GuiService");
local l_PlayerGui_0 = l_Players_0.LocalPlayer.PlayerGui;
local v31 = Instance.new("ScreenGui", l_PlayerGui_0);
v31.DisplayOrder = 120;
v31.IgnoreGuiInset = true;
v31.ResetOnSpawn = false;
v31.Name = "BackpackGui";
local l_ContextActionService_0 = game:GetService("ContextActionService");
local l_RunService_0 = game:GetService("RunService");
local l_VRService_0 = game:GetService("VRService");
local v35 = require(script.Utility);
local _ = require(script.GameTranslator);
local v37 = require(l_ReplicatedStorage_0.Modules.Icon);
local v38 = l_GuiService_0:IsTenFootInterface();
if v38 then
    v1 = 100;
    l_script_Attribute_0 = 24;
end;
local v39 = false;
local v40 = l_UserInputService_0.TouchEnabled and v21().X < 1024;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v42 = nil;
local v43 = nil;
local v44 = nil;
local v45 = nil;
local v46 = nil;
local v47 = nil;
local v48 = nil;
local v49 = nil;
local v50 = nil;
local v51 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
local l_Humanoid_0 = v51:FindFirstChildOfClass("Humanoid");
local l_Backpack_0 = l_LocalPlayer_0:WaitForChild("Backpack");
local v54 = v37.new();
v54:setImage("rbxasset://textures/ui/TopBar/inventoryOff.png", "deselected");
v54:setImage("rbxasset://textures/ui/TopBar/inventoryOn.png", "selected");
v54:bindToggleKey(v9[1], v9[2]);
v54:setName("InventoryIcon");
v54:setImageScale(1.12);
v54:setOrder(-5);
v54:setCaption("Toggle the backpack.");
v54.deselectWhenOtherIconSelected = false;
local v55 = {};
local v56 = nil;
local v57 = {};
local v58 = {};
local v59 = {};
local v60 = 0;
local v61 = false;
local v62 = false;
local v63 = false;
local v64 = false;
local v65 = {};
local v66 = {};
local v67 = false;
local v68 = 0;
local l_VREnabled_0 = l_VRService_0.VREnabled;
local v70 = l_VREnabled_0 and l_script_Attribute_8 or v40 and 5 or l_script_Attribute_7;
local v71 = l_VREnabled_0 and 3 or v40 and 2 or 4;
local v72 = nil;
local function _(v73) --[[ Line: 178 ]] --[[ Name: EvaluateBackpackPanelVisibility ]]
    -- upvalues: v54 (copy), v17 (ref), l_VRService_0 (copy)
    return v73 and v54.enabled and v17 and l_VRService_0.VREnabled;
end;
local function _() --[[ Line: 182 ]] --[[ Name: ShowVRBackpackPopup ]]

end;
local function v79(v76, v77) --[[ Line: 188 ]] --[[ Name: NewGui ]]
    -- upvalues: l_script_Attribute_0 (ref)
    local v78 = Instance.new(v76);
    v78.Name = v77;
    v78.BackgroundColor3 = Color3.new(0, 0, 0);
    v78.BackgroundTransparency = 1;
    v78.BorderColor3 = Color3.new(0, 0, 0);
    v78.BorderSizePixel = 0;
    v78.Size = UDim2.new(1, 0, 1, 0);
    if v76:match("Text") then
        v78.TextColor3 = Color3.new(1, 1, 1);
        v78.Text = "";
        v78.FontFace = script:GetAttribute("LabelFont");
        v78.TextSize = l_script_Attribute_0;
        v78.TextWrapped = true;
        if v76 == "TextButton" then
            v78.FontFace = script:GetAttribute("SlotFont");
        end;
    end;
    return v78;
end;
local function _() --[[ Line: 209 ]] --[[ Name: FindLowestEmpty ]]
    -- upvalues: v70 (copy), v55 (copy)
    for v80 = 1, v70 do
        local v81 = v55[v80];
        if not v81.Tool then
            return v81;
        end;
    end;
    return nil;
end;
local function _() --[[ Line: 219 ]] --[[ Name: isInventoryEmpty ]]
    -- upvalues: v70 (copy), v55 (copy)
    for v83 = v70 + 1, #v55 do
        local v84 = v55[v83];
        if v84 and v84.Tool then
            return false;
        end;
    end;
    return true;
end;
local function _() --[[ Line: 229 ]] --[[ Name: UseGazeSelection ]]
    -- upvalues: l_UserInputService_0 (copy)
    return l_UserInputService_0.VREnabled;
end;
local function v93() --[[ Line: 233 ]] --[[ Name: AdjustHotbarFrames ]]
    -- upvalues: v44 (ref), v70 (copy), v60 (ref), v55 (copy)
    local l_Visible_0 = v44.Visible;
    local v88 = l_Visible_0 and v70 or v60;
    local v89 = 0;
    local _ = v88 >= 1;
    for v91 = 1, v70 do
        local v92 = v55[v91];
        if v92.Tool or l_Visible_0 then
            v89 = v89 + 1;
            v92:Readjust(v89, v88);
            v92.Frame.Visible = true;
        else
            v92.Frame.Visible = false;
        end;
    end;
end;
local function v96() --[[ Line: 251 ]] --[[ Name: UpdateScrollingFrameCanvasSize ]]
    -- upvalues: v46 (ref), v1 (ref), v47 (ref)
    local v94 = math.floor(v46.AbsoluteSize.X / (v1 + 5));
    local v95 = math.ceil((#v47:GetChildren() - 1) / v94) * (v1 + 5) + 5;
    v46.CanvasSize = UDim2.new(0, 0, 0, v95);
end;
local function v99() --[[ Line: 258 ]] --[[ Name: AdjustInventoryFrames ]]
    -- upvalues: v70 (copy), v55 (copy), v96 (copy)
    for v97 = v70 + 1, #v55 do
        local v98 = v55[v97];
        v98.Frame.LayoutOrder = v98.Index;
        v98.Frame.Visible = v98.Tool ~= nil;
    end;
    v96();
end;
local function v100() --[[ Line: 267 ]] --[[ Name: UpdateBackpackLayout ]]
    -- upvalues: v43 (ref), v70 (copy), v1 (ref), v44 (ref), v71 (copy), l_VREnabled_0 (copy), v46 (ref), v93 (copy), v99 (copy)
    v43.Size = UDim2.new(0, 5 + v70 * (v1 + 5), 0, v1 + 5 + 5);
    v43.Position = UDim2.new(0.5, -v43.Size.X.Offset / 2, 1, -v43.Size.Y.Offset);
    v44.Size = UDim2.new(0, v43.Size.X.Offset, 0, v43.Size.Y.Offset * v71 + 40 + (l_VREnabled_0 and 80 or 0));
    v44.Position = UDim2.new(0.5, -v44.Size.X.Offset / 2, 1, v43.Position.Y.Offset - v44.Size.Y.Offset);
    v46.Size = UDim2.new(1, v46.ScrollBarThickness + 1, 1, -40 - (l_VREnabled_0 and 80 or 0));
    v46.Position = UDim2.new(0, 0, 0, 40 + (l_VREnabled_0 and 40 or 0));
    v93();
    v99();
end;
local function _(v101, v102, v103) --[[ Line: 279 ]] --[[ Name: Clamp ]]
    return (math.min(v102, (math.max(v101, v103))));
end;
local function _(v105, v106, v107) --[[ Line: 283 ]] --[[ Name: CheckBounds ]]
    local l_AbsolutePosition_0 = v105.AbsolutePosition;
    local l_AbsoluteSize_1 = v105.AbsoluteSize;
    local v110 = false;
    if l_AbsolutePosition_0.X < v106 then
        v110 = false;
        if v106 <= l_AbsolutePosition_0.X + l_AbsoluteSize_1.X then
            v110 = false;
            if l_AbsolutePosition_0.Y < v107 then
                v110 = v107 <= l_AbsolutePosition_0.Y + l_AbsoluteSize_1.Y;
            end;
        end;
    end;
    return v110;
end;
local function _(v112, v113) --[[ Line: 289 ]] --[[ Name: GetOffset ]]
    return (v112.AbsolutePosition + v112.AbsoluteSize / 2 - v113).magnitude;
end;
local function _() --[[ Line: 294 ]] --[[ Name: UnequipAllTools ]]
    -- upvalues: l_Humanoid_0 (ref)
    if l_Humanoid_0 then
        l_Humanoid_0:UnequipTools();
    end;
end;
local function _(v116) --[[ Line: 300 ]] --[[ Name: EquipNewTool ]]
    -- upvalues: l_Humanoid_0 (ref), v51 (ref)
    if l_Humanoid_0 then
        l_Humanoid_0:UnequipTools();
    end;
    v116.Parent = v51;
end;
local function _(v118) --[[ Line: 306 ]] --[[ Name: ToggleFavoriteTool ]]
    -- upvalues: l_Favorite_Item_0 (copy)
    local l_Tool_0 = v118.Tool;
    if not l_Tool_0 then
        return;
    else
        l_Favorite_Item_0:FireServer(l_Tool_0);
        return;
    end;
end;
local function _(v121) --[[ Line: 315 ]] --[[ Name: IsEquipped ]]
    -- upvalues: v51 (ref)
    return v121 and v121.Parent == v51;
end;
local _ = os.clock();
local function v124(v125, v126) --[[ Line: 321 ]] --[[ Name: MakeSlot ]]
    -- upvalues: v55 (copy), l_VRService_0 (copy), l_script_Attribute_5 (copy), l_script_Attribute_3 (copy), l_script_Attribute_2 (copy), v43 (ref), v1 (ref), v70 (copy), v44 (ref), l_UserInputService_0 (copy), v60 (ref), v62 (ref), v39 (ref), l_ContextActionService_0 (copy), v57 (copy), v56 (ref), v51 (ref), v72 (ref), v79 (copy), l_script_Attribute_4 (copy), v96 (copy), v16 (ref), l_Humanoid_0 (ref), l_Backpack_0 (ref), l_script_Attribute_6 (copy), l_Favorite_Item_0 (copy), v124 (copy), v47 (ref), v64 (ref), v58 (copy), l_Value_0 (copy), v59 (copy), v54 (copy), v46 (ref)
    v126 = v126 or #v55 + 1;
    local v127 = {
        Tool = nil, 
        Index = v126, 
        Frame = nil
    };
    local _ = nil;
    local _ = nil;
    local v130 = nil;
    local v131 = nil;
    local v132 = nil;
    local v133 = nil;
    local v134 = nil;
    local v135 = nil;
    local v136 = nil;
    local v137 = nil;
    local v138 = nil;
    local v139 = nil;
    local function v141() --[[ Line: 350 ]] --[[ Name: UpdateSlotFading ]]
        -- upvalues: l_VRService_0 (ref), v130 (ref), l_script_Attribute_5 (ref), l_script_Attribute_3 (ref), l_script_Attribute_2 (ref)
        local _ = l_VRService_0.VREnabled;
        v130.SelectionImageObject = nil;
        v130.BackgroundTransparency = v130.Draggable and 0 or l_script_Attribute_5;
        v130.BackgroundColor3 = v130.Draggable and l_script_Attribute_3 or l_script_Attribute_2;
    end;
    v127.Readjust = function(_, v143, v144) --[[ Line: 377 ]] --[[ Name: Readjust ]]
        -- upvalues: v43 (ref), v1 (ref), v130 (ref)
        local v145 = v43.Size.X.Offset / 2;
        local v146 = v1 + 5;
        local v147 = v143 - (v144 / 2 + 0.5);
        v130.Position = UDim2.new(0, v145 - v1 / 2 + v146 * v147, 0, 5);
    end;
    v127.Fill = function(v148, v149) --[[ Line: 385 ]] --[[ Name: Fill ]]
        -- upvalues: v135 (ref), v127 (copy), v132 (ref), v133 (ref), v138 (ref), v134 (ref), v70 (ref), v44 (ref), l_UserInputService_0 (ref), v130 (ref), v60 (ref), v62 (ref), v39 (ref), l_ContextActionService_0 (ref), v57 (ref), v56 (ref), v55 (ref)
        local v150 = false;
        if v135 then
            v135:Disconnect();
            v135 = nil;
        end;
        if not v149 then
            return v148:Clear();
        else
            v148.Tool = v149;
            v135 = v149:GetAttributeChangedSignal("Favorite"):Connect(function() --[[ Line: 397 ]]
                -- upvalues: v127 (ref), v149 (copy)
                v127.Frame.FavIcon.Visible = v149:GetAttribute("Favorite");
            end);
            xpcall(function() --[[ Line: 401 ]]
                -- upvalues: v127 (ref), v149 (copy)
                v127.Frame.FavIcon.Visible = v149:GetAttribute("Favorite");
            end, warn);
            local function v153() --[[ Line: 405 ]] --[[ Name: assignToolData ]]
                -- upvalues: v149 (copy), v132 (ref), v133 (ref), v138 (ref)
                local l_TextureId_0 = v149.TextureId;
                v132.Image = l_TextureId_0;
                if l_TextureId_0 ~= "" then
                    v133.Visible = false;
                end;
                if string.find(v149.Name, "Strawberry") then
                    v133.TextSize = 12;
                end;
                v133.Text = v149.Name;
                if v138 and v149:IsA("Tool") then
                    v138.Text = v149.ToolTip;
                    local v152 = v138.TextBounds.X + 24;
                    v138.Size = UDim2.new(0, v152, 0, 24);
                    v138.Position = UDim2.new(0.5, -v152 / 2, 0, -28);
                end;
            end;
            v153();
            if v134 then
                v134:disconnect();
                v134 = nil;
            end;
            v134 = v149.Changed:connect(function(v154) --[[ Line: 455 ]]
                -- upvalues: v153 (copy)
                if v154 == "TextureId" or v154 == "Name" or v154 == "ToolTip" then
                    v153();
                end;
            end);
            local v155 = v148.Index <= v70;
            local l_Visible_1 = v44.Visible;
            if (not v155 or l_Visible_1) and not l_UserInputService_0.VREnabled then
                v130.Draggable = true;
            end;
            v148:UpdateEquipView();
            if v155 then
                v60 = v60 + 1;
                if v62 and v60 >= 1 and not v39 then
                    v39 = true;
                    l_ContextActionService_0:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
                end;
            end;
            v57[v149] = v148;
            local v157;
            for v158 = 1, v70 do
                local v159 = v55[v158];
                if not v159.Tool then
                    v157 = v159;
                    v150 = true;
                end;
                if v150 then
                    break;
                end;
            end;
            if not v150 then
                v157 = nil;
            end;
            v150 = false;
            v56 = v157;
            return;
        end;
    end;
    v127.Clear = function(v160) --[[ Line: 486 ]] --[[ Name: Clear ]]
        -- upvalues: v134 (ref), v135 (ref), v132 (ref), v133 (ref), v138 (ref), v130 (ref), v70 (ref), v60 (ref), v39 (ref), l_ContextActionService_0 (ref), v57 (ref), v56 (ref), v55 (ref)
        local v161 = false;
        if not v160.Tool then
            return;
        else
            if v134 then
                v134:disconnect();
                v134 = nil;
            end;
            if v135 then
                v135:disconnect();
                v135 = nil;
            end;
            v132.Image = "";
            v133.Text = "";
            if v138 then
                v138.Text = "";
                v138.Visible = false;
            end;
            v130.Draggable = false;
            v130.FavIcon.Visible = false;
            v160:UpdateEquipView(true);
            if v160.Index <= v70 then
                v60 = v60 - 1;
                if v60 < 1 then
                    v39 = false;
                    l_ContextActionService_0:UnbindAction("RBXHotbarEquip");
                end;
            end;
            v57[v160.Tool] = nil;
            v160.Tool = nil;
            local v162;
            for v163 = 1, v70 do
                local v164 = v55[v163];
                if not v164.Tool then
                    v162 = v164;
                    v161 = true;
                end;
                if v161 then
                    break;
                end;
            end;
            if not v161 then
                v162 = nil;
            end;
            v161 = false;
            v56 = v162;
            return;
        end;
    end;
    v127.UpdateEquipView = function(v165, v166) --[[ Line: 524 ]] --[[ Name: UpdateEquipView ]]
        -- upvalues: v51 (ref), v72 (ref), v127 (copy), v136 (ref), v79 (ref), v130 (ref), l_script_Attribute_4 (ref), v141 (copy)
        local v167 = false;
        if not v166 then
            local l_Tool_1 = v165.Tool;
            if l_Tool_1 and l_Tool_1.Parent == v51 then
                v72 = v127;
                if not v136 then
                    v136 = v79("Frame", "Equipped");
                    v136.ZIndex = v130.ZIndex;
                    local l_UICorner_0 = Instance.new("UICorner");
                    l_UICorner_0.CornerRadius = script:GetAttribute("CornerRadius");
                    l_UICorner_0.Parent = v136;
                    l_Tool_1 = Instance.new("UIStroke");
                    l_Tool_1.Color = l_script_Attribute_4;
                    l_Tool_1.Thickness = 3;
                    l_Tool_1.Parent = v136;
                end;
                v136.Parent = v130;
                v167 = true;
            end;
        end;
        if not v167 then
            if v136 then
                v136.Parent = nil;
            end;
        end;
        v167 = false;
        v141();
    end;
    v127.IsEquipped = function(v170) --[[ Line: 550 ]] --[[ Name: IsEquipped ]]
        -- upvalues: v51 (ref)
        local l_Tool_2 = v170.Tool;
        return l_Tool_2 and l_Tool_2.Parent == v51;
    end;
    v127.Delete = function(v172) --[[ Line: 554 ]] --[[ Name: Delete ]]
        -- upvalues: v130 (ref), v55 (ref), v96 (ref)
        v130:Destroy();
        table.remove(v55, v172.Index);
        local v173 = #v55;
        for v174 = v172.Index, v173 do
            v55[v174]:SlideBack();
        end;
        v96();
    end;
    v127.Swap = function(v175, v176) --[[ Line: 567 ]] --[[ Name: Swap ]]
        local l_Tool_3 = v175.Tool;
        local l_Tool_4 = v176.Tool;
        v175:Clear();
        if l_Tool_4 then
            v176:Clear();
            v175:Fill(l_Tool_4);
        end;
        if l_Tool_3 then
            v176:Fill(l_Tool_3);
            return;
        else
            v176:Clear();
            return;
        end;
    end;
    v127.SlideBack = function(v179) --[[ Line: 581 ]] --[[ Name: SlideBack ]]
        -- upvalues: v130 (ref)
        v179.Index = v179.Index - 1;
        v130.Name = v179.Index;
        v130.LayoutOrder = v179.Index;
    end;
    v127.TurnNumber = function(_, v181) --[[ Line: 587 ]] --[[ Name: TurnNumber ]]
        -- upvalues: v139 (ref)
        if v139 then
            v139.Visible = v181;
        end;
    end;
    v127.SetClickability = function(v182, v183) --[[ Line: 593 ]] --[[ Name: SetClickability ]]
        -- upvalues: l_UserInputService_0 (ref), v130 (ref), v141 (copy)
        if v182.Tool then
            if l_UserInputService_0.VREnabled then
                v130.Draggable = false;
            else
                v130.Draggable = not v183;
            end;
            v141();
        end;
    end;
    v127.CheckTerms = function(v184, v185) --[[ Line: 604 ]] --[[ Name: CheckTerms ]]
        -- upvalues: v133 (ref), v138 (ref)
        local v186 = 0;
        local _ = function(v187, v188) --[[ Line: 606 ]] --[[ Name: checkEm ]]
            -- upvalues: v186 (ref)
            local _, v190 = v187:lower():gsub(v188, "");
            v186 = v186 + v190;
        end;
        local l_Tool_5 = v184.Tool;
        if l_Tool_5 then
            for v193 in pairs(v185) do
                local v194, v195 = v133.Text:lower():gsub(v193, "");
                v186 = v186 + v195;
                if l_Tool_5:IsA("Tool") then
                    v194, v195 = (v138 and v138.Text or ""):lower():gsub(v193, "");
                    v186 = v186 + v195;
                end;
            end;
        end;
        return v186;
    end;
    v127.Select = function(v196) --[[ Line: 632 ]] --[[ Name: Select ]]
        -- upvalues: v127 (copy), v16 (ref), v51 (ref), l_Humanoid_0 (ref), l_Backpack_0 (ref)
        local l_Tool_6 = v127.Tool;
        if l_Tool_6 then
            v16 = v196;
            if l_Tool_6 and l_Tool_6.Parent == v51 then
                v16 = nil;
                if l_Humanoid_0 then
                    l_Humanoid_0:UnequipTools();
                    return;
                end;
            elseif l_Tool_6.Parent == l_Backpack_0 then
                if l_Humanoid_0 then
                    l_Humanoid_0:UnequipTools();
                end;
                l_Tool_6.Parent = v51;
            end;
        end;
    end;
    v130 = v79("TextButton", v126);
    local l_UIStroke_0 = Instance.new("UIStroke");
    l_UIStroke_0.Parent = v130;
    local l_UICorner_1 = Instance.new("UICorner");
    l_UICorner_1.CornerRadius = script:GetAttribute("CornerRadius");
    l_UICorner_1.Parent = v130;
    l_UIStroke_0.Thickness = 0;
    v130.BackgroundColor3 = l_script_Attribute_2;
    l_UIStroke_0.Color = l_script_Attribute_6;
    v130.Text = "";
    v130.AutoButtonColor = false;
    v130.BorderSizePixel = 0;
    v130.Size = UDim2.new(0, v1, 0, v1);
    v130.Active = true;
    v130.Draggable = false;
    v130.BackgroundTransparency = l_script_Attribute_5;
    v130.MouseButton1Click:Connect(function() --[[ Line: 670 ]]
        -- upvalues: v127 (copy)
        changeSlot(v127);
    end);
    local v200 = os.clock();
    if l_UserInputService_0.TouchEnabled then
        v130.MouseButton1Click:Connect(function() --[[ Line: 677 ]]
            -- upvalues: v200 (ref), v127 (copy), l_Favorite_Item_0 (ref)
            if os.clock() > v200 + 0.25 then
                v200 = os.clock();
                return;
            else
                local l_Tool_7 = v127.Tool;
                if not l_Tool_7 then
                    return;
                else
                    l_Favorite_Item_0:FireServer(l_Tool_7);
                    return;
                end;
            end;
        end);
        v130.TouchLongPress:Connect(function(_, v203, _) --[[ Line: 685 ]]
            -- upvalues: v127 (copy), l_Favorite_Item_0 (ref)
            if v203 == Enum.UserInputState.End then
                local l_Tool_8 = v127.Tool;
                if not l_Tool_8 then
                    return;
                else
                    l_Favorite_Item_0:FireServer(l_Tool_8);
                end;
            end;
        end);
    else
        v130.MouseButton2Click:Connect(function() --[[ Line: 691 ]]
            -- upvalues: v127 (copy), l_Favorite_Item_0 (ref)
            local l_Tool_9 = v127.Tool;
            if not l_Tool_9 then
                return;
            else
                l_Favorite_Item_0:FireServer(l_Tool_9);
                return;
            end;
        end);
    end;
    v127.Frame = v130;
    local v207 = v79("Frame", "SelectionObjectClipper");
    v207.Visible = false;
    v207.Parent = v130;
    v137 = v79("ImageLabel", "Selector");
    v137.Size = UDim2.new(1, 0, 1, 0);
    v137.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png";
    v137.ScaleType = Enum.ScaleType.Slice;
    v137.SliceCenter = Rect.new(12, 12, 52, 52);
    v137.Parent = v207;
    v132 = v79("ImageLabel", "Icon");
    v132.Size = UDim2.new(0.8, 0, 0.8, 0);
    v132.Position = UDim2.new(0.1, 0, 0.1, 0);
    v132.Parent = v130;
    v207 = v79("ImageLabel", "FavIcon");
    v207.Size = UDim2.new(0.2, 0, 0.2, 0);
    v207.Position = UDim2.new(0.8, 0, 0.8, 0);
    v207.Parent = v130;
    v207.Visible = false;
    v207.Image = "rbxassetid://80131230547874";
    v207.ImageColor3 = Color3.fromRGB(255, 0, 0);
    v207.ZIndex = 10;
    v133 = v79("TextLabel", "ToolName");
    v133.Size = UDim2.new(1, -2, 1, -2);
    v133.Position = UDim2.new(0, 1, 0, 1);
    v133.Parent = v130;
    v127.Frame.LayoutOrder = v127.Index;
    if v126 <= v70 then
        v138 = v79("TextLabel", "ToolTip");
        v138.ZIndex = 2;
        v138.FontFace = script:GetAttribute("ToolTipFont");
        v138.TextWrapped = false;
        v138.TextYAlignment = Enum.TextYAlignment.Center;
        v138.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4);
        v138.BackgroundTransparency = 0;
        v138.Visible = false;
        v138.Parent = v130;
        local l_UICorner_2 = Instance.new("UICorner");
        l_UICorner_2.CornerRadius = script:GetAttribute("CornerRadius");
        l_UICorner_2.Parent = v138;
        v130.MouseEnter:Connect(function() --[[ Line: 749 ]]
            -- upvalues: v138 (ref)
            if v138.Text ~= "" then
                v138.Visible = true;
            end;
        end);
        v130.MouseLeave:Connect(function() --[[ Line: 754 ]]
            -- upvalues: v138 (ref)
            v138.Visible = false;
        end);
        v127.MoveToInventory = function(v209) --[[ Line: 758 ]] --[[ Name: MoveToInventory ]]
            -- upvalues: v127 (copy), v70 (ref), v124 (ref), v47 (ref), v51 (ref), l_Humanoid_0 (ref), v64 (ref), v44 (ref)
            if v127.Index <= v70 then
                local l_Tool_10 = v127.Tool;
                v209:Clear();
                local v211 = v124(v47);
                v211:Fill(l_Tool_10);
                if l_Tool_10 and l_Tool_10.Parent == v51 and l_Humanoid_0 then
                    l_Humanoid_0:UnequipTools();
                end;
                if v64 then
                    v211.Frame.Visible = false;
                    v211.Parent = v44;
                end;
            end;
        end;
        if v126 < 10 or v126 == v70 then
            local v212 = v126 < 10 and v126 or 0;
            v139 = v79("TextLabel", "Number");
            v139.Text = v212;
            v139.Size = UDim2.new(0, 15, 0, 15);
            v139.Visible = false;
            v139.Parent = v130;
            v58[l_Value_0 + v212] = v127.Select;
        end;
    end;
    local l_Position_0 = v130.Position;
    local v214 = 0;
    local v215 = nil;
    do
        local l_l_Position_0_0, l_v214_0, l_v215_0 = l_Position_0, v214, v215;
        v130.DragBegin:connect(function(v219) --[[ Line: 793 ]]
            -- upvalues: v59 (ref), v130 (ref), l_l_Position_0_0 (ref), l_UIStroke_0 (copy), v54 (ref), v132 (ref), v133 (ref), v139 (ref), v136 (ref), l_v215_0 (ref), v47 (ref), v44 (ref), v131 (ref), v79 (ref)
            v59[v130] = true;
            l_l_Position_0_0 = v219;
            l_UIStroke_0.Thickness = 2;
            v54:lock();
            v130.ZIndex = 2;
            v132.ZIndex = 2;
            v133.ZIndex = 2;
            v130.Parent.ZIndex = 2;
            if v139 then
                v139.ZIndex = 2;
            end;
            if v136 then
                v136.ZIndex = 2;
                for _, v221 in pairs(v136:GetChildren()) do
                    if not v221:IsA("UICorner") and not v221:IsA("UIStroke") then
                        v221.ZIndex = 2;
                    end;
                end;
            end;
            l_v215_0 = v130.Parent;
            if l_v215_0 == v47 then
                local _ = v130.AbsolutePosition;
                local v223 = UDim2.new(0, v130.AbsolutePosition.X - v44.AbsolutePosition.X, 0, v130.AbsolutePosition.Y - v44.AbsolutePosition.Y);
                v130.Parent = v44;
                v130.Position = v223;
                v131 = v79("Frame", "FakeSlot");
                v131.LayoutOrder = v130.LayoutOrder;
                v131.Size = v130.Size;
                v131.BackgroundTransparency = 1;
                v131.Parent = v47;
            end;
        end);
        v130.DragStopped:connect(function(v224, v225) --[[ Line: 835 ]]
            -- upvalues: v131 (ref), v130 (ref), l_l_Position_0_0 (ref), l_v215_0 (ref), l_UIStroke_0 (copy), v54 (ref), v132 (ref), v133 (ref), v139 (ref), v136 (ref), v59 (ref), v127 (copy), v44 (ref), v70 (ref), l_v214_0 (ref), v56 (ref), v43 (ref), v55 (ref), v51 (ref), l_Humanoid_0 (ref), v64 (ref)
            if v131 then
                v131:Destroy();
            end;
            local v226 = tick();
            v130.Position = l_l_Position_0_0;
            v130.Parent = l_v215_0;
            l_UIStroke_0.Thickness = 0;
            v54:unlock();
            v130.ZIndex = 1;
            v132.ZIndex = 1;
            v133.ZIndex = 1;
            l_v215_0.ZIndex = 1;
            if v139 then
                v139.ZIndex = 1;
            end;
            if v136 then
                v136.ZIndex = 1;
                for _, v228 in pairs(v136:GetChildren()) do
                    if not v228:IsA("UICorner") and not v228:IsA("UIStroke") then
                        v228.ZIndex = 1;
                    end;
                end;
            end;
            v59[v130] = nil;
            if not v127.Tool then
                return;
            else
                local l_v44_0 = v44;
                local l_AbsolutePosition_2 = l_v44_0.AbsolutePosition;
                local l_AbsoluteSize_2 = l_v44_0.AbsoluteSize;
                local v232 = false;
                if l_AbsolutePosition_2.X < v224 then
                    v232 = false;
                    if v224 <= l_AbsolutePosition_2.X + l_AbsoluteSize_2.X then
                        v232 = false;
                        if l_AbsolutePosition_2.Y < v225 then
                            v232 = v225 <= l_AbsolutePosition_2.Y + l_AbsoluteSize_2.Y;
                        end;
                    end;
                end;
                if v232 then
                    if v127.Index <= v70 then
                        v127:MoveToInventory();
                    end;
                    if v127.Index > v70 and v226 - l_v214_0 < 0.5 then
                        if v56 then
                            v232 = v127.Tool;
                            v127:Clear();
                            v56:Fill(v232);
                            v127:Delete();
                        end;
                        v226 = 0;
                    end;
                else
                    l_v44_0 = v43;
                    l_AbsolutePosition_2 = l_v44_0.AbsolutePosition;
                    l_AbsoluteSize_2 = l_v44_0.AbsoluteSize;
                    v232 = false;
                    if l_AbsolutePosition_2.X < v224 then
                        v232 = false;
                        if v224 <= l_AbsolutePosition_2.X + l_AbsoluteSize_2.X then
                            v232 = false;
                            if l_AbsolutePosition_2.Y < v225 then
                                v232 = v225 <= l_AbsolutePosition_2.Y + l_AbsoluteSize_2.Y;
                            end;
                        end;
                    end;
                    if v232 then
                        v232 = {
                            1e999, 
                            nil
                        };
                        for v233 = 1, v70 do
                            local v234 = v55[v233];
                            local l_Frame_0 = v234.Frame;
                            local v236 = Vector2.new(v224, v225);
                            local l_magnitude_0 = (l_Frame_0.AbsolutePosition + l_Frame_0.AbsoluteSize / 2 - v236).magnitude;
                            if l_magnitude_0 < v232[1] then
                                v232 = {
                                    l_magnitude_0, 
                                    v234
                                };
                            end;
                        end;
                        l_v44_0 = v232[2];
                        if l_v44_0 ~= v127 then
                            v127:Swap(l_v44_0);
                            if v127.Index > v70 then
                                l_AbsolutePosition_2 = v127.Tool;
                                if not l_AbsolutePosition_2 then
                                    v127:Delete();
                                else
                                    if l_AbsolutePosition_2 and l_AbsolutePosition_2.Parent == v51 and l_Humanoid_0 then
                                        l_Humanoid_0:UnequipTools();
                                    end;
                                    if v64 then
                                        v127.Frame.Visible = false;
                                        v127.Frame.Parent = v44;
                                    end;
                                end;
                            end;
                        end;
                    elseif v127.Index <= v70 then
                        v127:MoveToInventory();
                    end;
                end;
                l_v214_0 = v226;
                return;
            end;
        end);
    end;
    v130.Parent = v125;
    v55[v126] = v127;
    if v70 < v126 then
        v96();
        if v44.Visible and not v64 then
            l_Position_0 = v46.CanvasSize.Y.Offset - v46.AbsoluteSize.Y;
            v46.CanvasPosition = Vector2.new(0, (math.max(0, l_Position_0)));
        end;
    end;
    return v127;
end;
local function v247(v238) --[[ Line: 947 ]] --[[ Name: OnChildAdded ]]
    -- upvalues: v51 (ref), l_Humanoid_0 (ref), v68 (ref), v61 (ref), v57 (copy), l_LocalPlayer_0 (ref), v56 (ref), v124 (copy), v47 (ref), v55 (copy), l_Backpack_0 (ref), v93 (copy), v70 (copy), v44 (ref)
    if not v238:IsA("Tool") then
        if v238:IsA("Humanoid") and v238.Parent == v51 then
            l_Humanoid_0 = v238;
        end;
        return;
    else
        if v238.Parent == v51 then
            v68 = tick();
        end;
        if not v61 and v238.Parent == v51 and not v57[v238] then
            local l_StarterGear_0 = l_LocalPlayer_0:FindFirstChild("StarterGear");
            if l_StarterGear_0 and l_StarterGear_0:FindFirstChild(v238.Name) then
                v61 = true;
                local v240 = v56 or v124(v47);
                for v241 = v240.Index, 1, -1 do
                    local v242 = v55[v241];
                    local v243 = v241 - 1;
                    if v243 > 0 then
                        v55[v243]:Swap(v242);
                    else
                        v242:Fill(v238);
                    end;
                end;
                for _, v245 in pairs(v51:GetChildren()) do
                    if v245:IsA("Tool") and v245 ~= v238 then
                        v245.Parent = l_Backpack_0;
                    end;
                end;
                v93();
                return;
            end;
        end;
        local v246 = v57[v238];
        if v246 then
            v246:UpdateEquipView();
            return;
        else
            v246 = v56 or v124(v47);
            v246:Fill(v238);
            if v246.Index <= v70 and not v44.Visible then
                v93();
            end;
            return;
        end;
    end;
end;
local function v251(v248) --[[ Line: 1003 ]] --[[ Name: OnChildRemoved ]]
    -- upvalues: v68 (ref), v51 (ref), l_Backpack_0 (ref), v57 (copy), v70 (copy), v44 (ref), v93 (copy)
    if not v248:IsA("Tool") then
        return;
    else
        v68 = tick();
        local l_Parent_0 = v248.Parent;
        if l_Parent_0 == v51 or l_Parent_0 == l_Backpack_0 then
            return;
        else
            local v250 = v57[v248];
            if v250 then
                v250:Clear();
                if v250.Index > v70 then
                    v250:Delete();
                    return;
                elseif not v44.Visible then
                    v93();
                end;
            end;
            return;
        end;
    end;
end;
local function v261(v252) --[[ Line: 1029 ]] --[[ Name: OnCharacterAdded ]]
    -- upvalues: v55 (copy), v70 (copy), v66 (ref), v51 (ref), v251 (copy), v247 (copy), l_Backpack_0 (ref), l_LocalPlayer_0 (ref), v93 (copy)
    for v253 = #v55, 1, -1 do
        local v254 = v55[v253];
        if v254.Tool then
            v254:Clear();
        end;
        if v70 < v253 then
            v254:Delete();
        end;
    end;
    for _, v256 in pairs(v66) do
        v256:Disconnect();
    end;
    v66 = {};
    v51 = v252;
    table.insert(v66, v252.ChildRemoved:Connect(v251));
    table.insert(v66, v252.ChildAdded:Connect(v247));
    for _, v258 in pairs(v252:GetChildren()) do
        task.spawn(v247, v258);
    end;
    l_Backpack_0 = l_LocalPlayer_0:WaitForChild("Backpack");
    table.insert(v66, l_Backpack_0.ChildRemoved:Connect(v251));
    table.insert(v66, l_Backpack_0.ChildAdded:Connect(v247));
    for _, v260 in pairs(l_Backpack_0:GetChildren()) do
        task.spawn(v247, v260);
    end;
    v93();
end;
local function v266(v262, v263) --[[ Line: 1067 ]] --[[ Name: OnInputBegan ]]
    -- upvalues: v63 (ref), v62 (ref), l_Value_1 (copy), v58 (copy), v44 (ref), v54 (copy)
    if v263 == false then
        if v262.KeyCode == Enum.KeyCode.ButtonL2 or v262.UserInputType == Enum.UserInputType.Keyboard and not v63 and (v62 or v262.KeyCode.Value == l_Value_1) then
            local v264 = v58[v262.KeyCode.Value];
            if v264 then
                v264(v263);
            end;
        end;
        local l_UserInputType_0 = v262.UserInputType;
        if (l_UserInputType_0 == Enum.UserInputType.MouseButton1 or l_UserInputType_0 == Enum.UserInputType.Touch) and v44.Visible then
            v54:deselect();
        end;
    end;
end;
local function v270(v267) --[[ Line: 1086 ]] --[[ Name: OnUISChanged ]]
    -- upvalues: l_UserInputService_0 (copy), v70 (copy), v55 (copy)
    if v267 == "KeyboardEnabled" or v267 == "VREnabled" then
        local v268 = l_UserInputService_0.KeyboardEnabled and not l_UserInputService_0.VREnabled;
        for v269 = 1, v70 do
            v55[v269]:TurnNumber(v268);
        end;
    end;
end;
local v271 = nil;
local v272 = nil;
local function v273() --[[ Line: 1098 ]]

end;
local v274 = Vector2.new(0, 0);
unbindAllGamepadEquipActions = function() --[[ Line: 1102 ]] --[[ Name: unbindAllGamepadEquipActions ]]
    -- upvalues: l_ContextActionService_0 (copy)
    l_ContextActionService_0:UnbindAction("RBXBackpackHasGamepadFocus");
    l_ContextActionService_0:UnbindAction("RBXCloseInventory");
end;
local function _(v275, v276) --[[ Line: 1107 ]] --[[ Name: setHotbarVisibility ]]
    -- upvalues: v70 (copy), v55 (copy)
    for v277 = 1, v70 do
        local v278 = v55[v277];
        if v278 and v278.Frame and (v276 or v278.Tool) then
            v278.Frame.Visible = v275;
        end;
    end;
end;
local function v283(v280) --[[ Line: 1116 ]] --[[ Name: getInputDirection ]]
    -- upvalues: v274 (ref)
    local v281 = 1;
    if v280.UserInputState == Enum.UserInputState.End then
        v281 = -1;
    end;
    if v280.KeyCode == Enum.KeyCode.Thumbstick1 then
        local l_magnitude_1 = v280.Position.magnitude;
        if l_magnitude_1 > 0.98 then
            v274 = Vector2.new(v280.Position.x / l_magnitude_1, -v280.Position.y / l_magnitude_1);
        else
            v274 = Vector2.new(0, 0);
        end;
    elseif v280.KeyCode == Enum.KeyCode.DPadLeft then
        v274 = Vector2.new(v274.x - v281 * 1, v274.y);
    elseif v280.KeyCode == Enum.KeyCode.DPadRight then
        v274 = Vector2.new(v274.x + v281 * 1, v274.y);
    elseif v280.KeyCode == Enum.KeyCode.DPadUp then
        v274 = Vector2.new(v274.x, v274.y - v281 * 1);
    elseif v280.KeyCode == Enum.KeyCode.DPadDown then
        v274 = Vector2.new(v274.x, v274.y + v281 * 1);
    else
        v274 = Vector2.new(0, 0);
    end;
    return v274;
end;
local _ = function(_, _, v286) --[[ Line: 1147 ]]
    -- upvalues: v283 (copy), v70 (copy), v55 (copy), l_Humanoid_0 (ref)
    local v287 = v283(v286);
    if v287 == Vector2.new(0, 0) then
        return;
    else
        local v288 = math.atan2(v287.y, v287.x) - -1.5707963267948966;
        if v288 < 0 then
            v288 = v288 + 6.283185307179586;
        end;
        local v289 = math.floor(v288 / 0.7853981633974483 + 1 + 0.5);
        if v70 < v289 then
            v289 = 1;
        end;
        if v289 > 0 then
            local v290 = v55[v289];
            if v290 and v290.Tool and not v290:IsEquipped() then
                v290:Select();
                return;
            end;
        elseif l_Humanoid_0 then
            l_Humanoid_0:UnequipTools();
        end;
        return;
    end;
end;
changeToolFunc = function(_, v293, v294) --[[ Line: 1177 ]]
    -- upvalues: v271 (ref), v272 (ref), l_Humanoid_0 (ref), v70 (copy), v55 (copy), v72 (ref)
    if v293 ~= Enum.UserInputState.Begin then
        return;
    elseif v271 and (v271.KeyCode == Enum.KeyCode.ButtonR1 and v294.KeyCode == Enum.KeyCode.ButtonL1 or v271.KeyCode == Enum.KeyCode.ButtonL1 and v294.KeyCode == Enum.KeyCode.ButtonR1) and tick() - v272 <= 0.06 then
        if l_Humanoid_0 then
            l_Humanoid_0:UnequipTools();
        end;
        v271 = v294;
        v272 = tick();
        return;
    else
        v271 = v294;
        v272 = tick();
        delay(0.06, function() --[[ Line: 1197 ]]
            -- upvalues: v271 (ref), v294 (copy), v70 (ref), v55 (ref), l_Humanoid_0 (ref), v72 (ref)
            if v271 ~= v294 then
                return;
            else
                local v295 = 0;
                v295 = v294.KeyCode == Enum.KeyCode.ButtonL1 and -1 or 1;
                for v296 = 1, v70 do
                    if v55[v296]:IsEquipped() then
                        local v297 = v295 + v296;
                        local v298 = false;
                        if v70 < v297 then
                            v297 = 1;
                            v298 = true;
                        elseif v297 < 1 then
                            v297 = v70;
                            v298 = true;
                        end;
                        local l_v297_0 = v297;
                        while true do
                            if not v55[v297].Tool then
                                v297 = v297 + v295;
                                if v297 == l_v297_0 then
                                    return;
                                elseif v70 < v297 then
                                    v297 = 1;
                                    v298 = true;
                                elseif v297 < 1 then
                                    v297 = v70;
                                    v298 = true;
                                end;
                            elseif v298 then
                                if l_Humanoid_0 then
                                    l_Humanoid_0:UnequipTools();
                                end;
                                v72 = nil;
                                return;
                            else
                                v55[v297]:Select();
                                return;
                            end;
                        end;
                    end;
                end;
                if v72 and v72.Tool then
                    v72:Select();
                    return;
                else
                    local v300 = v295 == -1 and v70 or 1;
                    local v301 = v295 == -1 and 1 or v70;
                    for v302 = v300, v301, v295 do
                        if v55[v302].Tool then
                            v55[v302]:Select();
                            return;
                        end;
                    end;
                    return;
                end;
            end;
        end);
        return;
    end;
end;
getGamepadSwapSlot = function() --[[ Line: 1261 ]] --[[ Name: getGamepadSwapSlot ]]
    -- upvalues: v55 (copy)
    for v303 = 1, #v55 do
        if v55[v303].Frame:WaitForChild("UIStroke").Thickness > 0 then
            return v55[v303];
        end;
    end;
end;
changeSlot = function(v304) --[[ Line: 1269 ]] --[[ Name: changeSlot ]]
    -- upvalues: l_VRService_0 (copy), v44 (ref), l_GuiService_0 (copy), v45 (ref), v70 (copy)
    local v305 = not l_VRService_0.VREnabled or v44.Visible;
    if v304.Frame == l_GuiService_0.SelectedObject and v305 then
        local v306 = getGamepadSwapSlot();
        if v306 then
            v306.Frame:WaitForChild("UIStroke").Thickness = 0;
            if v306 ~= v304 then
                v304:Swap(v306);
                v45.SelectionImageObject.Visible = false;
                if v304.Index > v70 and not v304.Tool then
                    if l_GuiService_0.SelectedObject == v304.Frame then
                        l_GuiService_0.SelectedObject = v306.Frame;
                    end;
                    v304:Delete();
                end;
                if v306.Index > v70 and not v306.Tool then
                    if l_GuiService_0.SelectedObject == v306.Frame then
                        l_GuiService_0.SelectedObject = v304.Frame;
                    end;
                    v306:Delete();
                    return;
                end;
            end;
        else
            local l_Size_0 = v304.Frame.Size;
            local l_Position_1 = v304.Frame.Position;
            v304.Frame:TweenSizeAndPosition(l_Size_0 + UDim2.new(0, 10, 0, 10), l_Position_1 - UDim2.new(0, 5, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function() --[[ Line: 1298 ]]
                -- upvalues: v304 (copy), l_Size_0 (copy), l_Position_1 (copy)
                v304.Frame:TweenSizeAndPosition(l_Size_0, l_Position_1, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.1, true);
            end);
            v304.Frame:WaitForChild("UIStroke").Thickness = 3;
            v45.SelectionImageObject.Visible = true;
            return;
        end;
    else
        v304:Select();
        v45.SelectionImageObject.Visible = false;
    end;
end;
vrMoveSlotToInventory = function() --[[ Line: 1309 ]] --[[ Name: vrMoveSlotToInventory ]]
    -- upvalues: l_VRService_0 (copy), v45 (ref)
    if not l_VRService_0.VREnabled then
        return;
    else
        local v309 = getGamepadSwapSlot();
        if v309 and v309.Tool then
            v309:WaitForChild("UIStroke").Thickness = 0;
            v309:MoveToInventory();
            v45.SelectionImageObject.Visible = false;
        end;
        return;
    end;
end;
enableGamepadInventoryControl = function() --[[ Line: 1322 ]] --[[ Name: enableGamepadInventoryControl ]]
    -- upvalues: v44 (ref), v54 (copy), l_ContextActionService_0 (copy), v273 (copy), l_UserInputService_0 (copy), l_GuiService_0 (copy), v43 (ref)
    local function v314(_, v311, _) --[[ Line: 1323 ]]
        -- upvalues: v44 (ref), v54 (ref)
        if v311 ~= Enum.UserInputState.Begin then
            return;
        else
            if getGamepadSwapSlot() then
                local v313 = getGamepadSwapSlot();
                if v313 and typeof(v313) == "Instance" then
                    v313:WaitForChild("UIStroke").Thickness = 0;
                    return;
                end;
            elseif v44.Visible then
                v54:deselect();
            end;
            return;
        end;
    end;
    l_ContextActionService_0:BindAction("RBXBackpackHasGamepadFocus", v273, false, Enum.UserInputType.Gamepad1);
    l_ContextActionService_0:BindAction("RBXCloseInventory", v314, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart);
    if not l_UserInputService_0.VREnabled then
        l_GuiService_0.SelectedObject = v43:FindFirstChild("1");
    end;
end;
disableGamepadInventoryControl = function() --[[ Line: 1348 ]] --[[ Name: disableGamepadInventoryControl ]]
    -- upvalues: v70 (copy), v55 (copy), l_GuiService_0 (copy), v42 (ref)
    unbindAllGamepadEquipActions();
    for v315 = 1, v70 do
        local v316 = v55[v315];
        if v316 and v316.Frame then
            v316.Frame:WaitForChild("UIStroke").Thickness = 0;
        end;
    end;
    if l_GuiService_0.SelectedObject and l_GuiService_0.SelectedObject:IsDescendantOf(v42) then
        l_GuiService_0.SelectedObject = nil;
    end;
end;
local function _() --[[ Line: 1364 ]] --[[ Name: bindBackpackHotbarAction ]]
    -- upvalues: v62 (ref), v39 (ref), l_ContextActionService_0 (copy)
    if v62 and not v39 then
        v39 = true;
        l_ContextActionService_0:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
    end;
end;
local function _() --[[ Line: 1371 ]] --[[ Name: unbindBackpackHotbarAction ]]
    -- upvalues: v39 (ref), l_ContextActionService_0 (copy)
    disableGamepadInventoryControl();
    v39 = false;
    l_ContextActionService_0:UnbindAction("RBXHotbarEquip");
end;
gamepadDisconnected = function() --[[ Line: 1377 ]] --[[ Name: gamepadDisconnected ]]
    -- upvalues: v67 (ref)
    v67 = false;
    disableGamepadInventoryControl();
end;
gamepadConnected = function() --[[ Line: 1382 ]] --[[ Name: gamepadConnected ]]
    -- upvalues: v67 (ref), l_GuiService_0 (copy), v42 (ref), v60 (ref), v62 (ref), v39 (ref), l_ContextActionService_0 (copy), v44 (ref)
    v67 = true;
    l_GuiService_0:AddSelectionParent("RBXBackpackSelection", v42);
    if v60 >= 1 and v62 and not v39 then
        v39 = true;
        l_ContextActionService_0:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
    end;
    if v44.Visible then
        enableGamepadInventoryControl();
    end;
end;
local function v322(v319) --[[ Line: 1395 ]] --[[ Name: OnIconChanged ]]
    -- upvalues: l_StarterGui_0 (copy), v54 (copy), l_GuiService_0 (copy), v62 (ref), v42 (ref), v65 (copy), v60 (ref), v39 (ref), l_ContextActionService_0 (copy)
    v319 = v319 and l_StarterGui_0:GetCore("TopbarEnabled");
    v54:setEnabled(v319 and not l_GuiService_0.MenuIsOpen);
    v62 = v319;
    v42.Visible = v319;
    for _, _ in pairs(v65) do
        if not v319 then

        end;
    end;
    if v319 then
        if v60 >= 1 and v62 and not v39 then
            v39 = true;
            l_ContextActionService_0:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1);
            return;
        end;
    else
        disableGamepadInventoryControl();
        v39 = false;
        l_ContextActionService_0:UnbindAction("RBXHotbarEquip");
    end;
end;
local function v328(v323, v324) --[[ Line: 1421 ]] --[[ Name: MakeVRRoundButton ]]
    -- upvalues: v79 (copy)
    local v325 = v79("ImageButton", v323);
    v325.Size = UDim2.new(0, 40, 0, 40);
    v325.Image = "rbxasset://textures/ui/Keyboard/close_button_background.png";
    local v326 = v79("ImageLabel", "Icon");
    v326.Size = UDim2.new(0.5, 0, 0.5, 0);
    v326.Position = UDim2.new(0.25, 0, 0.25, 0);
    v326.Image = v324;
    v326.Parent = v325;
    local v327 = v79("ImageLabel", "Selection");
    v327.Size = UDim2.new(0.9, 0, 0.9, 0);
    v327.Position = UDim2.new(0.05, 0, 0.05, 0);
    v327.Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png";
    v325.SelectionImageObject = v327;
    return v325, v326, v327;
end;
v42 = v79("Frame", "Backpack");
v42.Visible = false;
v42.Parent = v31;
v43 = v79("Frame", "Hotbar");
v43.Parent = v42;
for v329 = 1, v70 do
    local v330 = v124(v43, v329);
    v330.Frame.Visible = false;
    if not v56 then
        v56 = v330;
    end;
end;
v54.selected:Connect(function() --[[ Line: 1461 ]]
    -- upvalues: l_GuiService_0 (copy), v0 (copy)
    if not l_GuiService_0.MenuIsOpen then
        v0.OpenClose();
    end;
end);
v54.deselected:Connect(function() --[[ Line: 1466 ]]
    -- upvalues: v44 (ref), v0 (copy)
    if v44.Visible then
        v0.OpenClose();
    end;
end);
LeftBumperButton = v79("ImageLabel", "LeftBumper");
LeftBumperButton.Size = UDim2.new(0, 40, 0, 40);
LeftBumperButton.Position = UDim2.new(0, -LeftBumperButton.Size.X.Offset, 0.5, -LeftBumperButton.Size.Y.Offset / 2);
RightBumperButton = v79("ImageLabel", "RightBumper");
RightBumperButton.Size = UDim2.new(0, 40, 0, 40);
RightBumperButton.Position = UDim2.new(1, 0, 0.5, -RightBumperButton.Size.Y.Offset / 2);
v44 = v79("Frame", "Inventory");
local l_UICorner_3 = Instance.new("UICorner");
l_UICorner_3.CornerRadius = script:GetAttribute("CornerRadius");
l_UICorner_3.Parent = v44;
v44.BackgroundTransparency = l_script_Attribute_1;
v44.BackgroundColor3 = l_script_Attribute_2;
v44.Active = true;
v44.Visible = false;
v44.Parent = v42;
v45 = v79("TextButton", "VRInventorySelector");
v45.Position = UDim2.new(0, 0, 0, 0);
v45.Size = UDim2.new(1, 0, 1, 0);
v45.BackgroundTransparency = 1;
v45.Text = "";
v45.Parent = v44;
local v332 = v79("ImageLabel", "Selector");
v332.Size = UDim2.new(1, 0, 1, 0);
v332.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png";
v332.ScaleType = Enum.ScaleType.Slice;
v332.SliceCenter = Rect.new(12, 12, 52, 52);
v332.Visible = false;
v45.SelectionImageObject = v332;
v45.MouseButton1Click:Connect(function() --[[ Line: 1506 ]]
    vrMoveSlotToInventory();
end);
v46 = v79("ScrollingFrame", "ScrollingFrame");
v46.Selectable = false;
v46.CanvasSize = UDim2.new(0, 0, 0, 0);
v46.Parent = v44;
v47 = v79("Frame", "UIGridFrame");
v47.Selectable = false;
v47.Size = UDim2.new(1, -10, 1, 0);
v47.Position = UDim2.new(0, 5, 0, 0);
v47.Parent = v46;
v48 = Instance.new("UIGridLayout");
v48.SortOrder = Enum.SortOrder.LayoutOrder;
v48.CellSize = UDim2.new(0, v1, 0, v1);
v48.CellPadding = UDim2.new(0, 5, 0, 5);
v48.Parent = v47;
v49 = v328("ScrollUpButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png");
v49.Size = UDim2.new(0, 34, 0, 34);
v49.Position = UDim2.new(0.5, -v49.Size.X.Offset / 2, 0, 43);
v49.Icon.Position = v49.Icon.Position - UDim2.new(0, 0, 0, 2);
v49.MouseButton1Click:Connect(function() --[[ Line: 1532 ]]
    -- upvalues: v46 (ref), v1 (ref)
    v46.CanvasPosition = Vector2.new(v46.CanvasPosition.X, (math.min(v46.CanvasSize.Y.Offset - v46.AbsoluteWindowSize.Y, (math.max(0, v46.CanvasPosition.Y - (v1 + 5))))));
end);
v50 = v328("ScrollDownButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png");
v50.Rotation = 180;
v50.Icon.Position = v50.Icon.Position - UDim2.new(0, 0, 0, 2);
v50.Size = UDim2.new(0, 34, 0, 34);
v50.Position = UDim2.new(0.5, -v50.Size.X.Offset / 2, 1, -v50.Size.Y.Offset - 3);
v50.MouseButton1Click:Connect(function() --[[ Line: 1543 ]]
    -- upvalues: v46 (ref), v1 (ref)
    v46.CanvasPosition = Vector2.new(v46.CanvasPosition.X, (math.min(v46.CanvasSize.Y.Offset - v46.AbsoluteWindowSize.Y, (math.max(0, v46.CanvasPosition.Y + (v1 + 5))))));
end);
v46.Changed:Connect(function(v333) --[[ Line: 1549 ]]
    -- upvalues: v46 (ref), v49 (ref), v50 (ref)
    if v333 == "AbsoluteWindowSize" or v333 == "CanvasPosition" or v333 == "CanvasSize" then
        local v334 = v46.CanvasPosition.Y ~= 0;
        local v335 = v46.CanvasPosition.Y < v46.CanvasSize.Y.Offset - v46.AbsoluteWindowSize.Y;
        v49.Visible = v334;
        v50.Visible = v335;
    end;
end);
v100();
local v336 = v35:Create("Frame")({
    Name = "GamepadHintsFrame", 
    Size = UDim2.new(0, v43.Size.X.Offset, 0, v38 and 95 or 60), 
    BackgroundTransparency = 1, 
    Visible = false, 
    Parent = v42
});
local function v343(v337, v338, v339) --[[ Line: 1572 ]] --[[ Name: addGamepadHint ]]
    -- upvalues: v35 (copy), v336 (copy), v38 (copy)
    local v340 = v35:Create("Frame")({
        Name = "HintFrame", 
        Size = UDim2.new(1, 0, 1, -5), 
        Position = UDim2.new(0, 0, 0, 0), 
        BackgroundTransparency = 1, 
        Parent = v336
    });
    local _ = v35:Create("ImageLabel")({
        Name = "HintImage", 
        Size = v38 and UDim2.new(0, 90, 0, 90) or UDim2.new(0, 60, 0, 60), 
        BackgroundTransparency = 1, 
        Image = v38 and v338 or v337, 
        Parent = v340
    });
    local v342 = v35:Create("TextLabel")({
        Name = "HintText", 
        Position = UDim2.new(0, v38 and 100 or 70, 0, 0), 
        Size = UDim2.new(1, -(v38 and 100 or 70), 1, 0), 
        Font = Enum.Font.SourceSansBold, 
        FontSize = v38 and Enum.FontSize.Size36 or Enum.FontSize.Size24, 
        BackgroundTransparency = 1, 
        Text = v339, 
        TextColor3 = Color3.new(1, 1, 1), 
        TextXAlignment = Enum.TextXAlignment.Left, 
        TextWrapped = true, 
        Parent = v340
    });
    Instance.new("UITextSizeConstraint", v342).MaxTextSize = v342.TextSize;
end;
local function v349() --[[ Line: 1609 ]] --[[ Name: resizeGamepadHintsFrame ]]
    -- upvalues: v336 (copy), v43 (ref), v38 (copy), v44 (ref)
    v336.Size = UDim2.new(v43.Size.X.Scale, v43.Size.X.Offset, 0, v38 and 95 or 60);
    v336.Position = UDim2.new(v43.Position.X.Scale, v43.Position.X.Offset, v44.Position.Y.Scale, v44.Position.Y.Offset - v336.Size.Y.Offset);
    local v344 = 0;
    local l_v336_Children_0 = v336:GetChildren();
    for v346 = 1, #l_v336_Children_0 do
        l_v336_Children_0[v346].Size = UDim2.new(1, 0, 1, -5);
        l_v336_Children_0[v346].Position = UDim2.new(0, 0, 0, 0);
        v344 = v344 + (l_v336_Children_0[v346].HintText.Position.X.Offset + l_v336_Children_0[v346].HintText.TextBounds.X);
    end;
    local v347 = (v336.AbsoluteSize.X - v344) / (#l_v336_Children_0 - 1);
    for v348 = 1, #l_v336_Children_0 do
        l_v336_Children_0[v348].Position = v348 == 1 and UDim2.new(0, 0, 0, 0) or UDim2.new(0, l_v336_Children_0[v348 - 1].Position.X.Offset + l_v336_Children_0[v348 - 1].Size.X.Offset + v347, 0, 0);
        l_v336_Children_0[v348].Size = UDim2.new(0, l_v336_Children_0[v348].HintText.Position.X.Offset + l_v336_Children_0[v348].HintText.TextBounds.X, 1, -5);
    end;
end;
v343("rbxasset://textures/ui/Settings/Help/XButtonDark.png", "rbxasset://textures/ui/Settings/Help/XButtonDark@2x.png", "Remove From Hotbar");
v343("rbxasset://textures/ui/Settings/Help/AButtonDark.png", "rbxasset://textures/ui/Settings/Help/AButtonDark@2x.png", "Select/Swap");
v343("rbxasset://textures/ui/Settings/Help/BButtonDark.png", "rbxasset://textures/ui/Settings/Help/BButtonDark@2x.png", "Close Backpack");
local v350 = v79("Frame", "Search");
local l_UICorner_4 = Instance.new("UICorner");
l_UICorner_4.CornerRadius = script:GetAttribute("CornerRadius");
l_UICorner_4.Parent = v350;
v350.BackgroundColor3 = l_script_Attribute_9;
v350.BackgroundTransparency = l_script_Attribute_10;
v350.Size = UDim2.new(0, 190, 0, 30);
v350.Position = UDim2.new(1, -v350.Size.X.Offset - 5, 0, 5);
v350.Parent = v44;
local v352 = v79("TextBox", "TextBox");
v352.PlaceholderText = "Search";
v352.ClearTextOnFocus = false;
v352.FontSize = Enum.FontSize.Size24;
v352.TextXAlignment = Enum.TextXAlignment.Left;
local l_UIPadding_0 = Instance.new("UIPadding");
l_UIPadding_0.Parent = v352;
l_UIPadding_0.PaddingLeft = UDim.new(0, 8);
v352.Size = v350.Size - UDim2.fromOffset(0, 0);
v352.Position = UDim2.new(0, 0, 0, 0);
v352.Parent = v350;
local v354 = v79("TextButton", "X");
local l_UICorner_5 = Instance.new("UICorner");
l_UICorner_5.CornerRadius = script:GetAttribute("CornerRadius");
l_UICorner_5.Parent = v354;
v354.Text = "X";
v354.ZIndex = 10;
v354.TextColor3 = Color3.new(1, 1, 1);
v354.FontSize = Enum.FontSize.Size24;
v354.TextYAlignment = Enum.TextYAlignment.Bottom;
v354.BackgroundTransparency = 1;
v354.Size = UDim2.new(0, v350.Size.Y.Offset - 10, 0, v350.Size.Y.Offset - 10);
v354.Position = UDim2.new(1, -v354.Size.X.Offset - 10, 0.5, -v354.Size.Y.Offset / 2);
v354.Visible = false;
v354.BorderSizePixel = 0;
v354.Parent = v350;
local function v367() --[[ Line: 1674 ]] --[[ Name: search ]]
    -- upvalues: v352 (copy), v70 (copy), v55 (copy), v44 (ref), v64 (ref), v47 (ref), v46 (ref), v96 (copy), v354 (copy)
    local v356 = {};
    for v357 in v352.Text:gmatch("%S+") do
        v356[v357:lower()] = true;
    end;
    local v358 = {};
    for v359 = v70 + 1, #v55 do
        local v360 = v55[v359];
        table.insert(v358, {
            v360, 
            (v360:CheckTerms(v356))
        });
        v360.Frame.Visible = false;
        v360.Frame.Parent = v44;
    end;
    table.sort(v358, function(v361, v362) --[[ Line: 1689 ]]
        return v361[2] > v362[2];
    end);
    v64 = true;
    local v363 = 0;
    for _, v365 in ipairs(v358) do
        local v366 = v365[1];
        if v365[2] > 0 then
            v366.Frame.Visible = true;
            v366.Frame.Parent = v47;
            v366.Frame.LayoutOrder = v70 + v363;
            v363 = v363 + 1;
        end;
    end;
    v46.CanvasPosition = Vector2.new(0, 0);
    v96();
    v354.ZIndex = 3;
end;
local function v370() --[[ Line: 1711 ]] --[[ Name: clearResults ]]
    -- upvalues: v354 (copy), v64 (ref), v70 (copy), v55 (copy), v47 (ref), v96 (copy)
    if v354.ZIndex > 0 then
        v64 = false;
        for v368 = v70 + 1, #v55 do
            local v369 = v55[v368];
            v369.Frame.LayoutOrder = v369.Index;
            v369.Frame.Parent = v47;
            v369.Frame.Visible = true;
        end;
        v354.ZIndex = 0;
    end;
    v96();
end;
local function v371() --[[ Line: 1725 ]] --[[ Name: reset ]]
    -- upvalues: v370 (copy), v352 (copy)
    v370();
    v352.Text = "";
end;
local function v376(v372) --[[ Line: 1730 ]] --[[ Name: onChanged ]]
    -- upvalues: v352 (copy), v370 (copy), v367 (copy), v354 (copy)
    if v372 == "Text" then
        local l_Text_0 = v352.Text;
        if l_Text_0 == "" then
            v370();
        elseif l_Text_0 ~= "Search" then
            v367();
        end;
        local l_v354_0 = v354;
        local v375 = false;
        if l_Text_0 ~= "" then
            v375 = l_Text_0 ~= "Search";
        end;
        l_v354_0.Visible = v375;
    end;
end;
local function v378(v377) --[[ Line: 1742 ]] --[[ Name: focusLost ]]
    -- upvalues: v367 (copy)
    if v377 then
        v367();
    end;
end;
v354.MouseButton1Click:Connect(v371);
v352.Changed:Connect(v376);
v352.FocusLost:Connect(v378);
v0.StateChanged.Event:Connect(function(v379) --[[ Line: 1753 ]]
    -- upvalues: v370 (copy), v352 (copy), v44 (ref), v54 (copy)
    if not v379 then
        v370();
        v352.Text = "";
        if not v44.Visible then
            v54:deselect();
        end;
    end;
end);
v58[Enum.KeyCode.Escape.Value] = function(v380) --[[ Line: 1763 ]]
    -- upvalues: v370 (copy), v352 (copy), v44 (ref), v54 (copy)
    if v380 then
        v370();
        v352.Text = "";
        return;
    else
        if v44.Visible then
            v54:deselect();
        end;
        return;
    end;
end;
v58[Enum.KeyCode.ButtonL2.Value] = function(_) --[[ Line: 1771 ]]
    -- upvalues: v16 (ref), l_Favorite_Item_0 (copy)
    if not v16 then
        return;
    else
        local l_Tool_11 = v16.Tool;
        if not l_Tool_11 then
            return;
        else
            l_Favorite_Item_0:FireServer(l_Tool_11);
            return;
        end;
    end;
end;
local l_v350_0 = v350 --[[ copy: 112 -> 123 ]];
l_UserInputService_0.LastInputTypeChanged:Connect(function(v384) --[[ Line: 1777 ]] --[[ Name: detectGamepad ]]
    -- upvalues: l_UserInputService_0 (copy), l_v350_0 (copy)
    if v384 == Enum.UserInputType.Gamepad1 and not l_UserInputService_0.VREnabled then
        l_v350_0.Visible = false;
        return;
    else
        l_v350_0.Visible = true;
        return;
    end;
end);
l_GuiService_0.MenuOpened:Connect(function() --[[ Line: 1787 ]]
    -- upvalues: v44 (ref), v54 (copy)
    if v44.Visible then
        v54:deselect();
    end;
end);
v350 = function(_, v386, _) --[[ Line: 1795 ]]
    -- upvalues: l_GuiService_0 (copy), v70 (copy), v55 (copy)
    if v386 ~= Enum.UserInputState.Begin then
        return;
    elseif not l_GuiService_0.SelectedObject then
        return;
    else
        for v388 = 1, v70 do
            if v55[v388].Frame == l_GuiService_0.SelectedObject and v55[v388].Tool then
                v55[v388]:MoveToInventory();
                return;
            end;
        end;
        return;
    end;
end;
local l_v350_1 = v350 --[[ copy: 112 -> 124 ]];
l_UICorner_4 = function() --[[ Line: 1807 ]] --[[ Name: openClose ]]
    -- upvalues: v59 (copy), v44 (ref), v93 (copy), v43 (ref), v70 (copy), v55 (copy), v67 (ref), v24 (copy), l_UserInputService_0 (copy), v349 (copy), v336 (copy), l_ContextActionService_0 (copy), l_v350_1 (copy), v0 (copy)
    if not next(v59) then
        v44.Visible = not v44.Visible;
        local l_Visible_2 = v44.Visible;
        v93();
        v43.Active = not v43.Active;
        for v391 = 1, v70 do
            v55[v391]:SetClickability(not l_Visible_2);
        end;
    end;
    if v44.Visible then
        if v67 then
            if v24[l_UserInputService_0:GetLastInputType()] then
                v349();
                v336.Visible = not l_UserInputService_0.VREnabled;
            end;
            enableGamepadInventoryControl();
        end;
    else
        if v67 then
            v336.Visible = false;
        end;
        disableGamepadInventoryControl();
    end;
    if v44.Visible then
        l_ContextActionService_0:BindAction("RBXRemoveSlot", l_v350_1, false, Enum.KeyCode.ButtonX);
    else
        l_ContextActionService_0:UnbindAction("RBXRemoveSlot");
    end;
    v0.IsOpen = v44.Visible;
    v0.StateChanged:Fire(v44.Visible);
end;
l_StarterGui_0:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
v0.OpenClose = l_UICorner_4;
while not l_LocalPlayer_0 do
    wait();
    l_LocalPlayer_0 = l_Players_0.LocalPlayer;
end;
l_LocalPlayer_0.CharacterAdded:Connect(v261);
if l_LocalPlayer_0.Character then
    v261(l_LocalPlayer_0.Character);
end;
l_UserInputService_0.InputBegan:Connect(v266);
l_UserInputService_0.TextBoxFocused:Connect(function() --[[ Line: 1871 ]]
    -- upvalues: v63 (ref)
    v63 = true;
end);
l_UserInputService_0.TextBoxFocusReleased:Connect(function() --[[ Line: 1872 ]]
    -- upvalues: v63 (ref)
    v63 = false;
end);
v58[l_Value_1] = function() --[[ Line: 1875 ]]
    -- upvalues: l_Humanoid_0 (ref)
    if l_Humanoid_0 then
        l_Humanoid_0:UnequipTools();
    end;
end;
l_UserInputService_0.Changed:Connect(v270);
v350 = l_UserInputService_0.KeyboardEnabled and not l_UserInputService_0.VREnabled;
for v392 = 1, v70 do
    v55[v392]:TurnNumber(v350);
end;
if l_UserInputService_0:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
    gamepadConnected();
end;
l_UserInputService_0.GamepadConnected:Connect(function(v393) --[[ Line: 1887 ]]
    if v393 == Enum.UserInputType.Gamepad1 then
        gamepadConnected();
    end;
end);
l_UserInputService_0.GamepadDisconnected:Connect(function(v394) --[[ Line: 1892 ]]
    if v394 == Enum.UserInputType.Gamepad1 then
        gamepadDisconnected();
    end;
end);
v0.SetBackpackEnabled = function(_, v396) --[[ Line: 1899 ]] --[[ Name: SetBackpackEnabled ]]
    -- upvalues: v17 (ref)
    v17 = v396;
end;
v0.IsOpened = function(_) --[[ Line: 1903 ]] --[[ Name: IsOpened ]]
    -- upvalues: v0 (copy)
    return v0.IsOpen;
end;
v0.GetBackpackEnabled = function(_) --[[ Line: 1907 ]] --[[ Name: GetBackpackEnabled ]]
    -- upvalues: v17 (ref)
    return v17;
end;
v0.GetStateChangedEvent = function(_) --[[ Line: 1911 ]] --[[ Name: GetStateChangedEvent ]]
    -- upvalues: l_Backpack_0 (ref)
    return l_Backpack_0.StateChanged;
end;
l_RunService_0.Heartbeat:Connect(function() --[[ Line: 1915 ]]
    -- upvalues: v322 (copy), v17 (ref)
    v322(v17);
end);
l_Api_0.Event:Connect(function(v400, v401) --[[ Line: 1918 ]]
    -- upvalues: v0 (copy)
    if v400 == "SetBackpackEnabled" then
        v0:SetBackpackEnabled(v401);
        return;
    else
        if v400 == "SetInventoryOpen" then
            if type(v401) == "boolean" and v401 == true then
                v0.IsOpen = true;
                return;
            elseif type(v401) == "boolean" then
                v0.IsOpen = false;
                return;
            end;
        elseif v400 == "ToggleBackpack" then
            v0.OpenClose();
        end;
        return;
    end;
end);
return v0;