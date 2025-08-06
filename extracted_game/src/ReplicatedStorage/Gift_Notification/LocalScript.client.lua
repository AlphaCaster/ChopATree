-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Holder_0 = script.Parent.Holder;
local l_TweenService_0 = game:GetService("TweenService");
local v2 = TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local _ = l_Holder_0.Position;
l_Holder_0.Position = UDim2.new(1.25, 0, 0.5, 0);
local v4 = l_TweenService_0:Create(l_Holder_0, v2, {
    Position = UDim2.new(0.5, 0, 0.5, 0)
});
v4:Play();
game.Debris:AddItem(v4, v2.Time);
local v5 = {
    script.Parent
};
for _, v7 in pairs(script.Parent:GetDescendants()) do
    if v7:IsA("Frame") or v7:IsA("TextLabel") or v7:IsA("UIStroke") or v7:IsA("ImageLabel") or v7:IsA("TextButton") then
        table.insert(v5, v7);
    end;
end;
local v8 = {};
for _, v10 in pairs(v5) do
    if v10:IsA("TextLabel") then
        local l_TextTransparency_0 = v10.TextTransparency;
        local l_TextStrokeTransparency_0 = v10.TextStrokeTransparency;
        v10.TextTransparency = 1;
        v10.TextStrokeTransparency = 1;
        local v13 = l_TweenService_0:Create(v10, v2, {
            TextTransparency = l_TextTransparency_0, 
            TextStrokeTransparency = l_TextStrokeTransparency_0
        });
        v13:Play();
        game.Debris:AddItem(v13, v2.Time);
        table.insert(v8, (l_TweenService_0:Create(v10, v2, {
            TextTransparency = 1, 
            TextStrokeTransparency = 1
        })));
    elseif v10:IsA("Frame") then
        local l_BackgroundTransparency_0 = v10.BackgroundTransparency;
        v10.BackgroundTransparency = 1;
        local v15 = l_TweenService_0:Create(v10, v2, {
            BackgroundTransparency = l_BackgroundTransparency_0
        });
        v15:Play();
        game.Debris:AddItem(v15, v2.Time);
        table.insert(v8, (l_TweenService_0:Create(v10, v2, {
            BackgroundTransparency = 1
        })));
    elseif v10:IsA("UIStroke") then
        local l_Transparency_0 = v10.Transparency;
        v10.Transparency = 1;
        local v17 = l_TweenService_0:Create(v10, v2, {
            Transparency = l_Transparency_0
        });
        v17:Play();
        game.Debris:AddItem(v17, v2.Time);
        table.insert(v8, (l_TweenService_0:Create(v10, v2, {
            Transparency = 1
        })));
    elseif v10:IsA("ImageLabel") then
        local l_ImageTransparency_0 = v10.ImageTransparency;
        local l_BackgroundTransparency_1 = v10.BackgroundTransparency;
        v10.ImageTransparency = 1;
        v10.BackgroundTransparency = 1;
        local v20 = l_TweenService_0:Create(v10, v2, {
            ImageTransparency = l_ImageTransparency_0, 
            BackgroundTransparency = l_BackgroundTransparency_1
        });
        v20:Play();
        game.Debris:AddItem(v20, v2.Time);
        table.insert(v8, (l_TweenService_0:Create(v10, v2, {
            ImageTransparency = 1, 
            BackgroundTransparency = 1
        })));
    elseif v10:IsA("TextButton") then
        local l_TextTransparency_1 = v10.TextTransparency;
        local l_BackgroundTransparency_2 = v10.BackgroundTransparency;
        v10.TextTransparency = 1;
        v10.BackgroundTransparency = 1;
        local v23 = l_TweenService_0:Create(v10, v2, {
            TextTransparency = l_TextTransparency_1, 
            BackgroundTransparency = l_BackgroundTransparency_2
        });
        v23:Play();
        game.Debris:AddItem(v23, v2.Time);
        table.insert(v8, (l_TweenService_0:Create(v10, v2, {
            TextTransparency = 1, 
            BackgroundTransparency = 1
        })));
    end;
end;
task.spawn(function() --[[ Line: 67 ]]
    -- upvalues: v8 (copy), v2 (copy)
    task.wait(30);
    if script.Parent then
        for _, v25 in pairs(v8) do
            v25:Play();
        end;
        game.Debris:AddItem(script.Parent, v2.Time);
    end;
end);