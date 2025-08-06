-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = {
    Color = "TextColor3", 
    StrokeColor = "TextStrokeColor3", 
    ImageColor = "ImageColor3"
};
v0.ColorShortcuts = {};
v0.ColorShortcuts.White = Color3.new(1, 1, 1);
v0.ColorShortcuts.Black = Color3.new(0, 0, 0);
v0.ColorShortcuts.Red = Color3.new(1, 0.4, 0.4);
v0.ColorShortcuts.Green = Color3.new(0.4, 1, 0.4);
v0.ColorShortcuts.Blue = Color3.new(0.4, 0.4, 1);
v0.ColorShortcuts.Cyan = Color3.new(0.4, 0.85, 1);
v0.ColorShortcuts.Orange = Color3.new(1, 0.5, 0.2);
v0.ColorShortcuts.Yellow = Color3.new(1, 0.9, 0.2);
v0.ImageShortcuts = {};
v0.ImageShortcuts.Eggplant = 639588687;
v0.ImageShortcuts.Thinking = 955646496;
v0.ImageShortcuts.Sad = 947900188;
v0.ImageShortcuts.Happy = 414889555;
v0.ImageShortcuts.Despicable = 711674643;
local v2 = {
    ContainerHorizontalAlignment = "Center", 
    ContainerVerticalAlignment = "Center", 
    TextYAlignment = "Center", 
    TextScaled = true, 
    TextScaleRelativeTo = "Frame", 
    TextScale = 0.6, 
    TextSize = 20, 
    Font = "SourceSans", 
    TextColor3 = "White", 
    TextStrokeColor3 = "Black", 
    TextTransparency = 0, 
    TextStrokeTransparency = 0, 
    BackgroundTransparency = 1, 
    BorderSizePixel = 0, 
    ImageColor3 = "White", 
    ImageTransparency = 0, 
    ImageRectOffset = "0,0", 
    ImageRectSize = "0,0", 
    AnimateStepTime = 0, 
    AnimateStepGrouping = "Letter", 
    AnimateStepFrequency = 4, 
    AnimateYield = 0, 
    AnimateStyle = "Appear", 
    AnimateStyleTime = 0.5, 
    AnimateStyleNumPeriods = 3, 
    AnimateStyleAmplitude = 0.5
};
local v28 = {
    Appear = function(v3) --[[ Line: 226 ]] --[[ Name: Appear ]]
        v3.Visible = true;
    end, 
    Fade = function(v4, v5, v6) --[[ Line: 230 ]] --[[ Name: Fade ]]
        v4.Visible = true;
        if v4:IsA("TextLabel") then
            v4.TextTransparency = 1 - v5 * (1 - v6.TextTransparency);
            return;
        else
            if v4:IsA("ImageLabel") then
                v4.ImageTransparency = 1 - v5 * (1 - v6.ImageTransparency);
            end;
            return;
        end;
    end, 
    Wiggle = function(v7, v8, v9) --[[ Line: 239 ]] --[[ Name: Wiggle ]]
        v7.Visible = true;
        local v10 = v9.InitialSize.Y.Offset * (1 - v8) * v9.AnimateStyleAmplitude;
        v7.Position = v9.InitialPosition + UDim2.new(0, 0, 0, math.sin(v8 * 3.141592653589793 * 2 * v9.AnimateStyleNumPeriods) * v10 / 2);
    end, 
    FallDown = function(v11, v12, v13) --[[ Line: 245 ]] --[[ Name: FallDown ]]
        v11.Visible = true;
        local v14 = v13.InitialSize.Y.Offset * (1 - v12) * v13.AnimateStyleAmplitude;
        v11.Position = v13.InitialPosition + UDim2.new(0, 0, 0, v14 * -1);
        v11.TextTransparency = 1 - v12;
    end, 
    Swing = function(v15, v16, v17) --[[ Line: 252 ]] --[[ Name: Swing ]]
        v15.Visible = true;
        local v18 = 90 * (1 - v16) * v17.AnimateStyleAmplitude;
        v15.Rotation = math.sin(v16 * 3.141592653589793 * 2 * v17.AnimateStyleNumPeriods) * v18;
    end, 
    Spin = function(v19, v20, v21) --[[ Line: 258 ]] --[[ Name: Spin ]]
        v19.Visible = true;
        v19.Position = v21.InitialPosition + UDim2.new(0, v21.InitialSize.X.Offset / 2, 0, v21.InitialSize.Y.Offset / 2);
        v19.AnchorPoint = Vector2.new(0.5, 0.5);
        v19.Rotation = v20 * v21.AnimateStyleNumPeriods * 360;
    end, 
    Rainbow = function(v22, v23, v24) --[[ Line: 265 ]] --[[ Name: Rainbow ]]
        v22.Visible = true;
        local v25 = Color3.fromHSV(v23 * v24.AnimateStyleNumPeriods % 1, 1, 1);
        if v22:IsA("TextLabel") then
            local v26 = getColorFromString(v24.TextColor3);
            v22.TextColor3 = Color3.new(v25.r + v23 * (v26.r - v25.r), v25.g + v23 * (v26.g - v25.g), v25.b + v23 * (v26.b - v25.b));
            return;
        else
            local v27 = getColorFromString(v24.ImageColor3);
            v22.ImageColor3 = Color3.new(v25.r + v23 * (v27.r - v25.r), v25.g + v23 * (v27.g - v25.g), v25.b + v23 * (v27.b - v25.b));
            return;
        end;
    end
};
local l_TextService_0 = game:GetService("TextService");
local l_RunService_0 = game:GetService("RunService");
local v31 = 0;
getLayerCollector = function(v32) --[[ Line: 284 ]] --[[ Name: getLayerCollector ]]
    if not v32 then
        return nil;
    elseif v32:IsA("LayerCollector") then
        return v32;
    elseif v32 and v32.Parent then
        return getLayerCollector(v32.Parent);
    else
        return nil;
    end;
end;
shallowCopy = function(v33) --[[ Line: 296 ]] --[[ Name: shallowCopy ]]
    local v34 = {};
    for v35, v36 in pairs(v33) do
        v34[v35] = v36;
    end;
    return v34;
end;
getColorFromString = function(v37) --[[ Line: 304 ]] --[[ Name: getColorFromString ]]
    -- upvalues: v0 (copy)
    if v0.ColorShortcuts[v37] then
        return v0.ColorShortcuts[v37];
    else
        local v38, v39, v40 = v37:match("(%d+),(%d+),(%d+)");
        return Color3.new(v38 / 255, v39 / 255, v40 / 255);
    end;
end;
getVector2FromString = function(v41) --[[ Line: 313 ]] --[[ Name: getVector2FromString ]]
    local v42, v43 = v41:match("(%d+),(%d+)");
    return Vector2.new(v42, v43);
end;
setHorizontalAlignment = function(v44, v45) --[[ Line: 318 ]] --[[ Name: setHorizontalAlignment ]]
    if v45 == "Left" then
        v44.AnchorPoint = Vector2.new(0, 0);
        v44.Position = UDim2.new(0, 0, 0, 0);
        return;
    elseif v45 == "Center" then
        v44.AnchorPoint = Vector2.new(0.5, 0);
        v44.Position = UDim2.new(0.5, 0, 0, 0);
        return;
    else
        if v45 == "Right" then
            v44.AnchorPoint = Vector2.new(1, 0);
            v44.Position = UDim2.new(1, 0, 0, 0);
        end;
        return;
    end;
end;
v0.New = function(_, v47, v48, v49, v50, v51) --[[ Line: 331 ]] --[[ Name: New ]]
    -- upvalues: v1 (copy), v2 (copy), l_TextService_0 (copy), v0 (copy), v31 (ref), l_RunService_0 (copy), v28 (copy)
    for _, v53 in pairs(v47:GetChildren()) do
        v53:Destroy();
    end;
    if v50 == nil then
        v50 = true;
    end;
    local v54 = {};
    local v55 = {};
    if v51 then
        v48 = v51.Text;
        v49 = v51.StartingProperties;
    end;
    local v56 = {};
    local v57 = {};
    local v58 = {};
    local v59 = 0;
    local v60 = false;
    local l_TextLabel_0 = Instance.new("TextLabel");
    local l_ImageLabel_0 = Instance.new("ImageLabel");
    local v63 = getLayerCollector(v47);
    l_TextLabel_0.AutoLocalize = false;
    local v64 = nil;
    local v65 = nil;
    local v66 = nil;
    local v67 = nil;
    local v68 = nil;
    local v69 = nil;
    v65 = function(v70, v71) --[[ Line: 359 ]] --[[ Name: applyMarkup ]]
        -- upvalues: v1 (ref), v55 (copy), v54 (ref), v64 (ref), v56 (copy), v2 (ref), v68 (ref)
        v70 = v1[v70] or v70;
        if v71 == "/" then
            if v55[v70] then
                v71 = v55[v70];
            else
                warn("Attempt to default <" .. v70 .. "> to value with no default");
            end;
        end;
        if tonumber(v71) then
            v71 = tonumber(v71);
        elseif v71 == "false" or v71 == "true" then
            v71 = v71 == "true";
        end;
        v54[v70] = v71;
        if not v64(v70, v71) then
            if v70 == "ContainerHorizontalAlignment" and v56[#v56] then
                setHorizontalAlignment(v56[#v56].Container, v71);
            elseif not v2[v70] then
                if v70 == "Img" then
                    v68(v71);
                else
                    return false;
                end;
            end;
        end;
        return true;
    end;
    v64 = function(v72, v73, v74) --[[ Line: 390 ]] --[[ Name: applyProperty ]]
        -- upvalues: l_TextLabel_0 (copy), l_ImageLabel_0 (copy)
        local v75 = nil;
        local v76 = false;
        local l_pairs_0 = pairs;
        local v78 = v74 and {
            v74
        } or {
            l_TextLabel_0, 
            l_ImageLabel_0
        };
        for _, v80 in l_pairs_0(v78) do
            if pcall(function() --[[ Line: 394 ]]
                -- upvalues: v75 (ref), v80 (copy), v72 (copy)
                v75 = typeof(v80[v72]);
            end) then
                if v75 == "Color3" then
                    v80[v72] = getColorFromString(v73);
                elseif v75 == "Vector2" then
                    v80[v72] = getVector2FromString(v73);
                else
                    v80[v72] = v73;
                end;
                v76 = true;
            end;
        end;
        return v76;
    end;
    for v81, v82 in pairs(v2) do
        v65(v81, v82);
        v55[v1[v81] or v81] = v54[v1[v81] or v81];
    end;
    local l_pairs_1 = pairs;
    local v84 = v49 or {};
    for v85, v86 in l_pairs_1(v84) do
        v65(v85, v86);
        v55[v1[v85] or v85] = v54[v1[v85] or v85];
    end;
    if v51 then
        v54 = v51.OverflowPickupProperties;
        for v87, v88 in pairs(v54) do
            v65(v87, v88);
        end;
    end;
    l_pairs_1 = function() --[[ Line: 427 ]] --[[ Name: getTextSize ]]
        -- upvalues: v54 (ref), v63 (copy), v47 (copy)
        if v54.TextScaled == true then
            local v89 = nil;
            if v54.TextScaleRelativeTo == "Screen" then
                v89 = v63.AbsoluteSize.Y;
            elseif v54.TextScaleRelativeTo == "Frame" then
                v89 = v47.AbsoluteSize.Y;
            end;
            return (math.min(v54.TextScale * v89, 100));
        else
            return v54.TextSize;
        end;
    end;
    v84 = 0;
    local function v96() --[[ Line: 443 ]] --[[ Name: newLine ]]
        -- upvalues: v56 (copy), v84 (ref), v50 (ref), v54 (ref), v63 (copy), v47 (copy), v60 (ref), v57 (copy), v59 (ref)
        local v90 = v56[#v56];
        if v90 then
            v84 = v84 + v90.Size.Y.Offset;
            if not v50 then
                local l_v84_0 = v84;
                local v92;
                if v54.TextScaled == true then
                    local v93 = nil;
                    if v54.TextScaleRelativeTo == "Screen" then
                        v93 = v63.AbsoluteSize.Y;
                    elseif v54.TextScaleRelativeTo == "Frame" then
                        v93 = v47.AbsoluteSize.Y;
                    end;
                    v92 = math.min(v54.TextScale * v93, 100);
                else
                    v92 = v54.TextSize;
                end;
                if l_v84_0 + v92 > v47.AbsoluteSize.Y then
                    v60 = true;
                    return;
                end;
            end;
        end;
        local l_Frame_0 = Instance.new("Frame");
        l_Frame_0.Name = string.format("Line%03d", #v56 + 1);
        l_Frame_0.Size = UDim2.new(0, 0, 0, 0);
        l_Frame_0.BackgroundTransparency = 1;
        local v95 = Instance.new("Frame", l_Frame_0);
        v95.Name = "Container";
        v95.Size = UDim2.new(0, 0, 0, 0);
        v95.BackgroundTransparency = 1;
        setHorizontalAlignment(v95, v54.ContainerHorizontalAlignment);
        l_Frame_0.Parent = v47;
        table.insert(v56, l_Frame_0);
        v57[#v56] = {};
        v59 = 0;
    end;
    v96();
    local function _(v97) --[[ Line: 469 ]] --[[ Name: addFrameProperties ]]
        -- upvalues: v58 (copy), v54 (ref)
        v58[v97] = shallowCopy(v54);
        v58[v97].InitialSize = v97.Size;
        v58[v97].InitialPosition = v97.Position;
        v58[v97].InitialAnchorPoint = v97.AnchorPoint;
    end;
    v66 = function(v99, v100, v101, v102) --[[ Line: 476 ]] --[[ Name: formatLabel ]]
        -- upvalues: v56 (copy), v54 (ref), v59 (ref), v47 (copy), v57 (copy), v96 (copy), v58 (copy)
        local v103 = v56[#v56];
        local v104 = tostring(v54.TextYAlignment);
        if v104 == "Top" then
            v99.Position = UDim2.new(0, v59, 0, 0);
            v99.AnchorPoint = Vector2.new(0, 0);
        elseif v104 == "Center" then
            v99.Position = UDim2.new(0, v59, 0.5, 0);
            v99.AnchorPoint = Vector2.new(0, 0.5);
        elseif v104 == "Bottom" then
            v99.Position = UDim2.new(0, v59, 1, 0);
            v99.AnchorPoint = Vector2.new(0, 1);
        end;
        v59 = v59 + v101;
        if v59 > v47.AbsoluteSize.X and v59 ~= v101 then
            v99:Destroy();
            local v105 = v57[#v56][#v57[#v56]];
            if v105:IsA("TextLabel") and v105.Text == " " then
                v103.Container.Size = UDim2.new(0, v59 - v101 - v105.Size.X.Offset, 1, 0);
                v105:Destroy();
                table.remove(v57[#v56]);
            end;
            v96();
            v102();
            return;
        else
            v99.Size = UDim2.new(0, v101, 0, v100);
            v103.Container.Size = UDim2.new(0, v59, 1, 0);
            v103.Size = UDim2.new(1, 0, 0, (math.max(v103.Size.Y.Offset, v100)));
            v99.Name = string.format("Group%03d", #v57[#v56] + 1);
            v99.Parent = v103.Container;
            table.insert(v57[#v56], v99);
            v58[v99] = shallowCopy(v54);
            v58[v99].InitialSize = v99.Size;
            v58[v99].InitialPosition = v99.Position;
            v58[v99].InitialAnchorPoint = v99.AnchorPoint;
            v54.AnimateYield = 0;
            return;
        end;
    end;
    v67 = function(v106) --[[ Line: 516 ]] --[[ Name: printText ]]
        -- upvalues: v96 (copy), v59 (ref), v54 (ref), v63 (copy), v47 (copy), l_TextService_0 (ref), l_TextLabel_0 (copy), v58 (copy), v66 (ref), v60 (ref), v67 (ref)
        if v106 == "\n" then
            v96();
            return;
        elseif v106 == " " and v59 == 0 then
            return;
        else
            local v107;
            if v54.TextScaled == true then
                local v108 = nil;
                if v54.TextScaleRelativeTo == "Screen" then
                    v108 = v63.AbsoluteSize.Y;
                elseif v54.TextScaleRelativeTo == "Frame" then
                    v108 = v47.AbsoluteSize.Y;
                end;
                v107 = math.min(v54.TextScale * v108, 100);
            else
                v107 = v54.TextSize;
            end;
            local l_X_0 = l_TextService_0:GetTextSize(v106, v107, l_TextLabel_0.Font, Vector2.new(v63.AbsoluteSize.X, v107)).X;
            local v110 = l_TextLabel_0:Clone();
            v110.TextScaled = false;
            v110.TextSize = v107;
            v110.Text = v106;
            v110.TextTransparency = 1;
            v110.TextStrokeTransparency = 1;
            v110.TextWrapped = false;
            local v111 = 0;
            local v112 = 1;
            for v113, v114 in utf8.graphemes(v106) do
                local v115 = string.sub(v106, v113, v114);
                local l_X_1 = l_TextService_0:GetTextSize(v115, v107, l_TextLabel_0.Font, Vector2.new(v63.AbsoluteSize.X, v107)).X;
                local v117 = l_TextLabel_0:Clone();
                v117.Text = v115;
                v117.TextScaled = false;
                v117.TextSize = v107;
                v117.Position = UDim2.new(0, v111, 0, 0);
                v117.Size = UDim2.new(0, l_X_1 + 1, 0, v107);
                v117.Name = string.format("Char%03d", v112);
                v117.Parent = v110;
                v117.Visible = false;
                v58[v117] = shallowCopy(v54);
                v58[v117].InitialSize = v117.Size;
                v58[v117].InitialPosition = v117.Position;
                v58[v117].InitialAnchorPoint = v117.AnchorPoint;
                v111 = v111 + l_X_1;
                v112 = v112 + 1;
            end;
            v66(v110, v107, l_X_0, function() --[[ Line: 555 ]]
                -- upvalues: v60 (ref), v67 (ref), v106 (copy)
                if not v60 then
                    v67(v106);
                end;
            end);
            return;
        end;
    end;
    v68 = function(v118) --[[ Line: 558 ]] --[[ Name: printImage ]]
        -- upvalues: v54 (ref), v63 (copy), v47 (copy), l_ImageLabel_0 (copy), v0 (ref), v66 (ref), v60 (ref), v68 (ref)
        local v119;
        if v54.TextScaled == true then
            local v120 = nil;
            if v54.TextScaleRelativeTo == "Screen" then
                v120 = v63.AbsoluteSize.Y;
            elseif v54.TextScaleRelativeTo == "Frame" then
                v120 = v47.AbsoluteSize.Y;
            end;
            v119 = math.min(v54.TextScale * v120, 100);
        else
            v119 = v54.TextSize;
        end;
        local v121 = l_ImageLabel_0:Clone();
        if v0.ImageShortcuts[v118] then
            v121.Image = typeof(v0.ImageShortcuts[v118]) == "number" and "rbxassetid://" .. v0.ImageShortcuts[v118] or v0.ImageShortcuts[v118];
        else
            v121.Image = "rbxassetid://" .. v118;
        end;
        v121.Size = UDim2.new(0, v119, 0, v119);
        v121.Visible = false;
        v66(v121, v119, v119, function() --[[ Line: 572 ]]
            -- upvalues: v60 (ref), v68 (ref), v118 (copy)
            if not v60 then
                v68(v118);
            end;
        end);
    end;
    v69 = function(v122) --[[ Line: 575 ]] --[[ Name: printSeries ]]
        -- upvalues: v65 (ref), v67 (ref)
        for _, v124 in pairs(v122) do
            local v125, v126 = string.match(v124, "<(.+)=(.+)>");
            if v125 and v126 then
                if not v65(v125, v126) then
                    warn("Could not apply markup: ", v124);
                end;
            else
                v67(v124);
            end;
        end;
    end;
    local v127 = 1;
    local v128 = #v48;
    local v129 = {};
    if v51 then
        v127 = v51.OverflowPickupIndex;
    end;
    while v127 and v127 <= v128 do
        local v130, v131 = string.find(v48, "<.->", v127);
        local v132, v133 = string.find(v48, "[ \t\n]", v127);
        local v134 = nil;
        local v135 = nil;
        local v136 = nil;
        if v130 and v131 and (not v132 or v130 < v132) then
            v134 = v130;
            v135 = v131;
        else
            v134 = v132 or v128 + 1;
            v135 = v133 or v128 + 1;
            v136 = true;
        end;
        local v137 = v127 < v134 and string.sub(v48, v127, v134 - 1) or nil;
        local v138 = v134 <= v128 and string.sub(v48, v134, v135) or nil;
        table.insert(v129, v137);
        if v136 then
            v69(v129);
            if not v60 then
                v69({
                    v138
                });
                if v60 then
                    v127 = v134;
                    break;
                else
                    v129 = {};
                end;
            else
                break;
            end;
        else
            table.insert(v129, v138);
        end;
        v127 = v135 + 1;
    end;
    if not v60 then
        v69(v129);
    end;
    local l_UIListLayout_0 = Instance.new("UIListLayout");
    l_UIListLayout_0.HorizontalAlignment = v54.ContainerHorizontalAlignment;
    l_UIListLayout_0.VerticalAlignment = v54.ContainerVerticalAlignment;
    l_UIListLayout_0.Parent = v47;
    local v140 = 0;
    local l_X_2 = v47.AbsoluteSize.X;
    local v142 = 0;
    for _, v144 in pairs(v56) do
        v140 = v140 + v144.Size.Y.Offset;
        local l_Container_0 = v144.Container;
        local v146 = nil;
        local v147 = nil;
        if l_Container_0.AnchorPoint.X == 0 then
            v146 = l_Container_0.Position.X.Offset;
            v147 = l_Container_0.Size.X.Offset;
        elseif l_Container_0.AnchorPoint.X == 0.5 then
            v146 = v144.AbsoluteSize.X / 2 - l_Container_0.Size.X.Offset / 2;
            v147 = v144.AbsoluteSize.X / 2 + l_Container_0.Size.X.Offset / 2;
        elseif l_Container_0.AnchorPoint.X == 1 then
            v146 = v144.AbsoluteSize.X - l_Container_0.Size.X.Offset;
            v147 = v144.AbsoluteSize.X;
        end;
        l_X_2 = math.min(l_X_2, v146);
        v142 = math.max(v142, v147);
    end;
    v31 = v31 + 1;
    local v148 = false;
    local v149 = false;
    local v150 = false;
    local v151 = "TextAnimation" .. v31;
    local v152 = {};
    local function v159() --[[ Line: 673 ]] --[[ Name: updateAnimations ]]
        -- upvalues: v149 (ref), v152 (ref), v148 (ref), l_RunService_0 (ref), v151 (copy), v28 (ref)
        if v149 and #v152 == 0 or v148 then
            v148 = true;
            l_RunService_0:UnbindFromRenderStep(v151);
            v152 = {};
            return;
        else
            local v153 = tick();
            for v154 = #v152, 1, -1 do
                local v155 = v152[v154];
                local l_Settings_0 = v155.Settings;
                local v157 = v28[l_Settings_0.AnimateStyle];
                if not v157 then
                    warn("No animation style found for: ", l_Settings_0.AnimateStyle, ", defaulting to Appear");
                    v157 = v28.Appear;
                end;
                local v158 = math.min((v153 - v155.Start) / l_Settings_0.AnimateStyleTime, 1);
                v157(v155.Char, v158, l_Settings_0);
                if v158 >= 1 then
                    table.remove(v152, v154);
                end;
            end;
            return;
        end;
    end;
    local function v163(v160) --[[ Line: 698 ]] --[[ Name: setFrameToDefault ]]
        -- upvalues: v58 (copy), v64 (ref)
        v160.Position = v58[v160].InitialPosition;
        v160.Size = v58[v160].InitialSize;
        v160.AnchorPoint = v58[v160].InitialAnchorPoint;
        for v161, v162 in pairs(v58[v160]) do
            v64(v161, v162, v160);
        end;
    end;
    local function v168(v164, v165) --[[ Line: 707 ]] --[[ Name: setGroupVisible ]]
        -- upvalues: v163 (copy)
        v164.Visible = v165;
        for _, v167 in pairs(v164:GetChildren()) do
            v167.Visible = v165;
            if v165 then
                v163(v167);
            end;
        end;
        if v165 and v164:IsA("ImageLabel") then
            v163(v164);
        end;
    end;
    local function v197(v169) --[[ Line: 720 ]] --[[ Name: animate ]]
        -- upvalues: v148 (ref), l_RunService_0 (ref), v151 (copy), v159 (copy), v57 (copy), v168 (copy), v152 (ref), v150 (ref), v58 (copy), v149 (ref)
        v148 = false;
        l_RunService_0:BindToRenderStep(v151, Enum.RenderPriority.Last.Value, v159);
        local v170 = nil;
        local v171 = nil;
        local v172 = nil;
        local v173 = nil;
        for _, v175 in pairs(v57) do
            for _, v177 in pairs(v175) do
                v168(v177, false);
            end;
        end;
        local function _(v178, v179) --[[ Line: 736 ]] --[[ Name: animateCharacter ]]
            -- upvalues: v152 (ref)
            table.insert(v152, {
                Char = v178, 
                Settings = v179, 
                Start = tick()
            });
        end;
        local function _() --[[ Line: 740 ]] --[[ Name: yield ]]
            -- upvalues: v150 (ref), v173 (ref), v172 (ref), v171 (ref)
            if not v150 and v173 % v172 == 0 and v171 >= 0 then
                local v181 = v171 > 0 and v171 or nil;
                wait(v181);
            end;
        end;
        for _, v184 in pairs(v57) do
            for _, v186 in pairs(v184) do
                local v187 = v58[v186];
                if v187.AnimateStepGrouping ~= v170 or v187.AnimateStepFrequency ~= v172 then
                    v173 = 0;
                end;
                v170 = v187.AnimateStepGrouping;
                v171 = v187.AnimateStepTime;
                v172 = v187.AnimateStepFrequency;
                if v187.AnimateYield > 0 then
                    wait(v187.AnimateYield);
                end;
                if v170 == "Word" or v170 == "All" then
                    if v186:IsA("TextLabel") then
                        v186.Visible = true;
                        for _, v189 in pairs(v186:GetChildren()) do
                            local v190 = v58[v189];
                            table.insert(v152, {
                                Char = v189, 
                                Settings = v190, 
                                Start = tick()
                            });
                        end;
                    else
                        table.insert(v152, {
                            Char = v186, 
                            Settings = v187, 
                            Start = tick()
                        });
                    end;
                    if v170 == "Word" then
                        v173 = v173 + 1;
                        if not v150 and v173 % v172 == 0 and v171 >= 0 then
                            local v191 = v171 > 0 and v171 or nil;
                            wait(v191);
                        end;
                    end;
                elseif v170 == "Letter" then
                    if v186:IsA("TextLabel") then
                        v186.Visible = true;
                        local _ = v186.Text;
                        local v193 = 1;
                        while true do
                            local l_v186_FirstChild_0 = v186:FindFirstChild(string.format("Char%03d", v193));
                            if l_v186_FirstChild_0 then
                                local v195 = v58[l_v186_FirstChild_0];
                                table.insert(v152, {
                                    Char = l_v186_FirstChild_0, 
                                    Settings = v195, 
                                    Start = tick()
                                });
                                v173 = v173 + 1;
                                if not v150 and v173 % v172 == 0 and v171 >= 0 then
                                    v195 = v171 > 0 and v171 or nil;
                                    wait(v195);
                                end;
                                if v148 then
                                    return;
                                else
                                    v193 = v193 + 1;
                                end;
                            else
                                break;
                            end;
                        end;
                    else
                        table.insert(v152, {
                            Char = v186, 
                            Settings = v187, 
                            Start = tick()
                        });
                        v173 = v173 + 1;
                        if not v150 and v173 % v172 == 0 and v171 >= 0 then
                            local v196 = v171 > 0 and v171 or nil;
                            wait(v196);
                        end;
                    end;
                else
                    warn("Invalid step grouping: ", v170);
                end;
                if v148 then
                    return;
                end;
            end;
        end;
        v149 = true;
        if v169 then
            while #v152 > 0 do
                l_RunService_0.RenderStepped:Wait();
            end;
        end;
    end;
    local v198 = {
        Overflown = v60, 
        OverflowPickupIndex = v127, 
        StartingProperties = v49, 
        OverflowPickupProperties = v54, 
        Text = v48
    };
    if v51 then
        v51.NextTextObject = v198;
    end;
    v198.ContentSize = Vector2.new(v142 - l_X_2, v140);
    v198.Animate = function(v199, v200) --[[ Line: 841 ]] --[[ Name: Animate ]]
        -- upvalues: v197 (copy)
        if v200 then
            v197();
        else
            coroutine.wrap(v197)();
        end;
        if v199.NextTextObject then
            v199.NextTextObject:Animate(v200);
        end;
    end;
    v198.Show = function(v201, v202) --[[ Line: 852 ]] --[[ Name: Show ]]
        -- upvalues: v150 (ref), v148 (ref), v57 (copy), v168 (copy)
        if v202 then
            v150 = true;
        else
            v148 = true;
            for _, v204 in pairs(v57) do
                for _, v206 in pairs(v204) do
                    v168(v206, true);
                end;
            end;
        end;
        if v201.NextTextObject then
            v201.NextTextObject:Show(v202);
        end;
    end;
    v198.Hide = function(v207) --[[ Line: 868 ]] --[[ Name: Hide ]]
        -- upvalues: v148 (ref), v57 (copy), v168 (copy)
        v148 = true;
        for _, v209 in pairs(v57) do
            for _, v211 in pairs(v209) do
                v168(v211, false);
            end;
        end;
        if v207.NextTextObject then
            v207.NextTextObject:Hide();
        end;
    end;
    return v198;
end;
v0.ContinueOverflow = function(_, v213, v214) --[[ Line: 884 ]] --[[ Name: ContinueOverflow ]]
    -- upvalues: v0 (copy)
    return v0:New(v213, nil, nil, false, v214);
end;
return v0;