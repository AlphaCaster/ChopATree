-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_TweenService_0 = game:GetService("TweenService");
local l_Debris_0 = game:GetService("Debris");
local _ = game:GetService("UserInputService");
local _ = game:GetService("SoundService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local _ = l_LocalPlayer_0:WaitForChild("leaderstats");
local _ = require(l_ReplicatedStorage_0.Modules.DataService);
local l_Parent_0 = script.Parent;
local l_val_0 = l_Parent_0.val;
local v11 = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local l_Appear_Effect_0 = game.ReplicatedStorage:WaitForChild("Appear_Effect");
local l_Comma_Module_0 = require(game.ReplicatedStorage:WaitForChild("Comma_Module"));
local function _() --[[ Line: 26 ]] --[[ Name: updateValue ]]
    -- upvalues: l_TweenService_0 (copy), l_val_0 (copy), v11 (copy)
    l_TweenService_0:Create(l_val_0, v11, {
        Value = l_val_0:GetAttribute("ActualValue")
    }):Play();
end;
local function _(v15, v16) --[[ Line: 34 ]] --[[ Name: showEffect ]]
    -- upvalues: l_Comma_Module_0 (copy), l_Appear_Effect_0 (copy), l_Parent_0 (copy), l_TweenService_0 (copy), l_Debris_0 (copy)
    local v17 = math.random(7, 11) * 0.1;
    local v18 = TweenInfo.new(v17, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v19 = l_Comma_Module_0.Comma(v15);
    local v20 = l_Appear_Effect_0:Clone();
    v20.Parent = l_Parent_0.Parent;
    v20.Position = l_Parent_0.Position;
    v20.TextColor3 = v16 and Color3.new(1, 1, 0) or Color3.new(1, 0, 0);
    v20.Text = (v16 and "+" or "-") .. v19 .. "\194\162";
    local v21 = v16 and 0.1 or math.random(4, 7) * 0.01;
    local v22 = v20.Position - UDim2.new(0, 0, v21, 0);
    local v23 = l_TweenService_0:Create(v20, v18, {
        Position = v22
    });
    local v24 = l_TweenService_0:Create(v20, v18, {
        TextTransparency = 1, 
        TextStrokeTransparency = 1
    });
    v23:Play();
    v24:Play();
    l_Debris_0:AddItem(v20, v18.Time);
end;
l_val_0:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 60 ]]
    -- upvalues: l_Parent_0 (copy), l_Comma_Module_0 (copy), l_val_0 (copy)
    l_Parent_0.Text = "x" .. l_Comma_Module_0.Comma((tostring((math.round(l_val_0.Value)))));
end);
local v26 = l_TweenService_0:Create(l_Parent_0, TweenInfo.new(0.7), {
    TextTransparency = 1
});
local v27 = l_TweenService_0:Create(l_Parent_0.UIStroke, TweenInfo.new(0.7), {
    Transparency = 1
});
local l_Hotbar_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("BackpackGui"):WaitForChild("Backpack"):WaitForChild("Hotbar");
l_val_0:GetAttributeChangedSignal("ActualValue"):Connect(function() --[[ Line: 75 ]]
    -- upvalues: v26 (copy), v27 (copy), l_Parent_0 (copy), l_val_0 (copy), l_TweenService_0 (copy), v11 (copy), l_Hotbar_0 (copy)
    v26:Cancel();
    v27:Cancel();
    l_Parent_0.TextTransparency = 0;
    l_Parent_0.UIStroke.Transparency = 0;
    if os.time() - l_val_0:GetAttribute("LastUpdate") > 2 then
        l_val_0.Value = l_val_0:GetAttribute("ActualValue");
    else
        l_TweenService_0:Create(l_val_0, v11, {
            Value = l_val_0:GetAttribute("ActualValue")
        }):Play();
    end;
    local v29 = l_Hotbar_0.AbsolutePosition + Vector2.new(l_Hotbar_0.AbsoluteSize.X, l_Hotbar_0.AbsoluteSize.Y);
    l_Parent_0.Position = UDim2.fromOffset(v29.X, v29.Y - 10);
    local l_l_val_0_Attribute_0 = l_val_0:GetAttribute("ActualValue");
    task.delay(2.7, function() --[[ Line: 92 ]]
        -- upvalues: l_val_0 (ref), l_l_val_0_Attribute_0 (copy), v26 (ref), v27 (ref)
        if l_val_0.Value == l_l_val_0_Attribute_0 then
            v26:Play();
            v27:Play();
        end;
    end);
end);