-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
for _, v2 in pairs(script.Parent:GetChildren()) do
    if v2:IsA("ImageButton") then
        table.insert(v0, v2);
    end;
end;
for _, v4 in pairs(v0) do
    local l_Click_0 = game.SoundService.Click;
    local l_Hover_0 = game.SoundService.Hover;
    v4.MouseButton1Down:Connect(function() --[[ Line: 10 ]]
        -- upvalues: l_Click_0 (copy)
        l_Click_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        l_Click_0.TimePosition = 0;
        l_Click_0.Playing = true;
    end);
    local l_UserInputService_0 = game:GetService("UserInputService");
    v4.MouseEnter:Connect(function() --[[ Line: 16 ]]
        -- upvalues: l_UserInputService_0 (copy), l_Hover_0 (copy)
        if l_UserInputService_0.TouchEnabled == false then
            l_Hover_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            l_Hover_0.TimePosition = 0;
            l_Hover_0.Playing = true;
        end;
    end);
    v4.MouseButton1Click:Connect(function() --[[ Line: 23 ]]
        -- upvalues: v0 (copy), v4 (copy)
        for _, v9 in pairs(v0) do
            if v9.LayoutOrder <= v4.LayoutOrder then
                v9.ImageColor3 = Color3.new(1, 1, 1);
                script.Parent.Parent.Parent.Parent.Parent.Rating_Val.Value = v4.LayoutOrder;
            else
                v9.ImageColor3 = Color3.new(0, 0, 0);
            end;
        end;
    end);
end;