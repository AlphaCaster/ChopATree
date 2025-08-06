-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_TweenService_0 = game:GetService("TweenService");
local l_Debris_0 = game:GetService("Debris");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_SoundService_0 = game:GetService("SoundService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = l_Players_0.LocalPlayer:WaitForChild("leaderstats");
local v7 = require(l_ReplicatedStorage_0.Modules.DataService);
local l_Parent_0 = script.Parent;
local l_val_0 = l_Parent_0.val;
local v10 = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local l_Appear_Effect_0 = game.ReplicatedStorage:WaitForChild("Appear_Effect");
local l_Comma_Module_0 = require(game.ReplicatedStorage:WaitForChild("Comma_Module"));
local function _() --[[ Line: 26 ]] --[[ Name: updateValue ]]
    -- upvalues: l_TweenService_0 (copy), l_val_0 (copy), v10 (copy), v7 (copy)
    l_TweenService_0:Create(l_val_0, v10, {
        Value = v7:GetData().Sheckles or 0
    }):Play();
end;
local function v25(v14, v15) --[[ Line: 34 ]] --[[ Name: showEffect ]]
    -- upvalues: l_Comma_Module_0 (copy), l_Appear_Effect_0 (copy), l_Parent_0 (copy), l_TweenService_0 (copy), l_Debris_0 (copy), l_SoundService_0 (copy)
    local v16 = math.random(7, 11) * 0.1;
    local v17 = TweenInfo.new(v16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v18 = l_Comma_Module_0.Comma(v14);
    local v19 = l_Appear_Effect_0:Clone();
    v19.Parent = l_Parent_0.Parent;
    v19.Position = l_Parent_0.Position;
    v19.TextColor3 = v15 and Color3.new(1, 1, 0) or Color3.new(1, 0, 0);
    v19.Text = (v15 and "+" or "-") .. v18 .. "\194\162";
    local v20 = v15 and 0.1 or math.random(4, 7) * 0.01;
    local v21 = v19.Position - UDim2.new(0, 0, v20, 0);
    local v22 = l_TweenService_0:Create(v19, v17, {
        Position = v21
    });
    local v23 = l_TweenService_0:Create(v19, v17, {
        TextTransparency = 1, 
        TextStrokeTransparency = 1
    });
    v22:Play();
    v23:Play();
    l_Debris_0:AddItem(v19, v17.Time);
    local l_l_SoundService_0_FirstChild_0 = l_SoundService_0:FindFirstChild("Cash Register");
    if l_l_SoundService_0_FirstChild_0 then
        l_l_SoundService_0_FirstChild_0.TimePosition = 0;
        l_l_SoundService_0_FirstChild_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        l_l_SoundService_0_FirstChild_0:Play();
    end;
end;
l_val_0:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 65 ]]
    -- upvalues: l_Parent_0 (copy), l_Comma_Module_0 (copy), l_val_0 (copy)
    l_Parent_0.Text = l_Comma_Module_0.Comma((tostring((math.round(l_val_0.Value))))) .. "\194\162";
end);
if l_UserInputService_0.GamepadEnabled then
    l_Parent_0.Visible = false;
    l_Parent_0.Parent.Enabled = false;
end;
l_TweenService_0:Create(l_val_0, v10, {
    Value = v7:GetData().Sheckles or 0
}):Play();
local v26 = v7:GetData().Sheckles or 0;
v7:GetPathSignal("Sheckles"):Connect(function() --[[ Line: 82 ]]
    -- upvalues: v7 (copy), v26 (ref), v25 (copy), l_TweenService_0 (copy), l_val_0 (copy), v10 (copy)
    local v27 = v7:GetData().Sheckles or 0;
    if v26 == v27 then
        return;
    else
        local v28 = math.abs(v27 - v26);
        if v28 == 0 then
            return;
        else
            v25(v28, v26 < v27);
            v26 = v27;
            l_TweenService_0:Create(l_val_0, v10, {
                Value = v7:GetData().Sheckles or 0
            }):Play();
            return;
        end;
    end;
end);