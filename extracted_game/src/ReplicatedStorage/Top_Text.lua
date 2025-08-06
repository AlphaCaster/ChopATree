-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_Talk_UI_0 = game.ReplicatedStorage.NPC_UIS.Talk_UI;
local l_Response_UI_0 = game.ReplicatedStorage.NPC_UIS.Response_UI;
local l_Option_UI_0 = game.ReplicatedStorage.NPC_UIS.Option_UI;
local _ = game:GetService("TweenService");
local v5 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local l_Response_Text_0 = game.SoundService.Response_Text;
local _ = {
    "http://www.roblox.com/asset/?id=135588148188132", 
    "http://www.roblox.com/asset/?id=102212481360594", 
    "http://www.roblox.com/asset/?id=138037320970182", 
    "http://www.roblox.com/asset/?id=125722657143179", 
    "http://www.roblox.com/asset/?id=79508546100707", 
    "http://www.roblox.com/asset/?id=133878046497302"
};
local function _(v8) --[[ Line: 19 ]] --[[ Name: stripRichTextTags ]]
    return v8:gsub("<.->", "");
end;
task.wait(1);
effect = function(v10, v11, v12) --[[ Line: 27 ]] --[[ Name: effect ]]
    -- upvalues: l_Response_Text_0 (copy)
    local v13 = v10.Text:gsub("<.->", "");
    local v14 = string.len(v13);
    local v15 = string.len(v13);
    v10.MaxVisibleGraphemes = 0;
    local v16 = v12 and game.SoundService.NPC_SFX:FindFirstChild(v12) or game.SoundService.NPC_Text;
    if v11 == true then
        while v14 >= 1 do
            task.wait();
            if v16.TimePosition > 0.07 or v16.Playing == false then
                v16.TimePosition = 0;
                v16.Playing = true;
                v16.PlaybackSpeed = 1 + math.random(-5, 5) / 100;
            end;
            v14 = v14 - 1;
            v10.MaxVisibleGraphemes = v10.MaxVisibleGraphemes + 1;
        end;
    else
        while v14 >= 1 do
            task.wait();
            if math.floor(v14 / 3) * 3 == v14 or v14 == v15 then
                local v17 = l_Response_Text_0:Clone();
                v17.Parent = game.SoundService;
                v17.Name = "SFX";
                v17.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                v17.Playing = true;
                game.Debris:AddItem(v17, v17.TimeLength * v17.PlaybackSpeed);
            end;
            v14 = v14 - 1;
            v10.MaxVisibleGraphemes = v10.MaxVisibleGraphemes + 1;
        end;
    end;
end;
v0.NpcText = function(v18, v19, v20) --[[ Line: 61 ]] --[[ Name: NpcText ]]
    -- upvalues: l_Talk_UI_0 (copy)
    local l_FirstChild_0 = v18.Head:FindFirstChild(l_Talk_UI_0.Name);
    if l_FirstChild_0 == nil then
        local v22 = l_Talk_UI_0:Clone();
        v22.Parent = v18.Head;
        v22.TextLabel.Text = v19;
        effect(v22.TextLabel, true, v18.Name);
        if v20 == true then
            for _, v24 in pairs(v22:GetDescendants()) do
                if v24:IsA("LocalScript") or v24:IsA("Script") then
                    v24.Enabled = true;
                end;
            end;
        end;
        return v22;
    else
        if v20 == true then
            for _, v26 in pairs(l_FirstChild_0:GetDescendants()) do
                if v26:IsA("LocalScript") or v26:IsA("Script") then
                    v26:Destroy();
                end;
            end;
        end;
        l_FirstChild_0.TextLabel.Text = v19;
        effect(l_FirstChild_0.TextLabel, true, v18.Name);
        if v20 == true then
            for _, v28 in pairs(l_Talk_UI_0:GetDescendants()) do
                if v28:IsA("LocalScript") or v28:IsA("Script") then
                    for _, v30 in pairs(l_FirstChild_0:GetDescendants()) do
                        if v30.Name == v28.Parent.Name then
                            local v31 = v28:Clone();
                            v31.Parent = v30;
                            v31.Enabled = true;
                        end;
                    end;
                end;
            end;
        end;
        return l_FirstChild_0;
    end;
end;
local l_TweenService_1 = game:GetService("TweenService");
v0.ShowChoices = function(v33, v34) --[[ Line: 105 ]] --[[ Name: ShowChoices ]]
    -- upvalues: l_Option_UI_0 (copy), l_TweenService_1 (copy)
    local v35 = {};
    local v36 = 0;
    for _, v38 in pairs(v34) do
        v36 = v36 + 1;
        local v39 = l_Option_UI_0:Clone();
        v39.Parent = v33.PlayerGui.Billboard_UI;
        v39.Frame.Frame.Text_Element.Text = "[\"" .. v38 .. "\"]";
        v39.Frame.Frame.TextLabel.Text = "#" .. tostring(v36);
        local l_UIPadding_0 = v39.Frame.Frame.Text_Element.UIPadding;
        local v41 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
        l_UIPadding_0.PaddingLeft = UDim.new(string.len(v38) * 0.001 + 0.04, 0);
        local v42 = l_TweenService_1:Create(l_UIPadding_0, v41, {
            PaddingLeft = UDim.new(0, 0)
        });
        v42:Play();
        game.Debris:AddItem(v42, v41.Time);
        table.insert(v35, v39);
        v39.Frame.Frame.Text_Element:SetAttribute("Text", v38);
        task.wait(0.075);
    end;
    if v35[1] then
        game:GetService("GamepadService"):EnableGamepadCursor(v35[1]);
    end;
    return v35;
end;
v0.TakeAwayResponses = function(v43, v44) --[[ Line: 133 ]] --[[ Name: TakeAwayResponses ]]
    -- upvalues: l_TweenService_1 (copy), v5 (copy)
    local _ = {};
    for _, v47 in pairs(v44.PlayerGui.Billboard_UI:GetChildren()) do
        if v47.Name ~= "UIListLayout" then
            v47:Destroy();
        end;
    end;
    for _, v49 in pairs(v43.Head:GetChildren()) do
        if v49:IsA("BillboardGui") and (v49.Name == "Response_UI" or v49.Name == "Talk_UI") then
            for _, v51 in pairs(v49:GetChildren()) do
                if v51:IsA("TextLabel") then
                    l_TweenService_1:Create(v51, v5, {
                        TextTransparency = 1
                    }):Play();
                elseif v51:IsA("ImageLabel") then
                    l_TweenService_1:Create(v51, v5, {
                        ImageTransparency = 1
                    }):Play();
                end;
            end;
            game.Debris:AddItem(v49, v5.Time);
        end;
    end;
end;
v0.RemovePlayerSideFrame = function(v52) --[[ Line: 165 ]] --[[ Name: RemovePlayerSideFrame ]]
    for _, v54 in pairs(v52.PlayerGui.Billboard_UI:GetChildren()) do
        if v54.Name ~= "UIListLayout" then
            v54:Destroy();
        end;
    end;
    game:GetService("GamepadService"):DisableGamepadCursor();
end;
v0.ShowResponse = function(v55, v56, v57) --[[ Line: 177 ]] --[[ Name: ShowResponse ]]
    -- upvalues: l_Talk_UI_0 (copy)
    local l_FirstChild_1 = v55.Head:FindFirstChild(l_Talk_UI_0.Name);
    if l_FirstChild_1 == nil then
        local v59 = l_Talk_UI_0:Clone();
        v59.Parent = v55.Head;
        v59.TextLabel.Text = v56;
        effect(v59.TextLabel, true);
        if v57 == true then
            for _, v61 in pairs(v59:GetDescendants()) do
                if v61:IsA("LocalScript") or v61:IsA("Script") then
                    v61.Enabled = true;
                end;
            end;
        end;
        return v59;
    else
        if v57 == true then
            for _, v63 in pairs(l_FirstChild_1:GetDescendants()) do
                if v63:IsA("LocalScript") or v63:IsA("Script") then
                    v63:Destroy();
                end;
            end;
        end;
        l_FirstChild_1.TextLabel.Text = v56;
        effect(l_FirstChild_1.TextLabel, true);
        if v57 == true then
            for _, v65 in pairs(l_Talk_UI_0:GetDescendants()) do
                if v65:IsA("LocalScript") or v65:IsA("Script") then
                    for _, v67 in pairs(l_FirstChild_1:GetDescendants()) do
                        if v67.Name == v65.Parent.Name then
                            v65.Enabled = false;
                            local v68 = v65:Clone();
                            v68.Parent = v67;
                            v68.Enabled = true;
                        end;
                    end;
                end;
            end;
        end;
        return l_FirstChild_1;
    end;
end;
v0.PlayerResponse = function(v69, v70, v71) --[[ Line: 220 ]] --[[ Name: PlayerResponse ]]
    -- upvalues: l_Talk_UI_0 (copy), l_Response_UI_0 (copy)
    if v70 ~= nil then
        local l_FirstChild_2 = v69.Head:FindFirstChild(l_Talk_UI_0.Name);
        if l_FirstChild_2 == nil then
            local v73 = l_Response_UI_0:Clone();
            v73.Parent = v69.Head;
            v73.TextLabel.Text = v70;
            effect(v73.TextLabel, false);
            if v71 == true then
                for _, v75 in pairs(v73:GetDescendants()) do
                    if v75:IsA("LocalScript") or v75:IsA("Script") then
                        v75.Enabled = true;
                    end;
                end;
            end;
            return v73;
        else
            if v71 == true then
                for _, v77 in pairs(l_FirstChild_2:GetDescendants()) do
                    if v77:IsA("LocalScript") or v77:IsA("Script") then
                        v77:Destroy();
                    end;
                end;
            end;
            l_FirstChild_2.TextLabel.Text = v70;
            effect(l_FirstChild_2.TextLabel, false);
            if v71 == true then
                for _, v79 in pairs(l_Response_UI_0:GetDescendants()) do
                    if v79:IsA("LocalScript") or v79:IsA("Script") then
                        for _, v81 in pairs(l_FirstChild_2:GetDescendants()) do
                            if v81.Name == v79.Parent.Name then
                                v79.Enabled = false;
                                local v82 = v79:Clone();
                                v82.Parent = v81;
                                v82.Enabled = true;
                            end;
                        end;
                    end;
                end;
            end;
            return l_FirstChild_2;
        end;
    else
        return;
    end;
end;
return v0;