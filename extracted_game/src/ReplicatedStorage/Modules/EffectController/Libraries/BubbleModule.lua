-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
return {
    CreateBubble = function(v1, v2, v3, v4, v5, v6) --[[ Line: 9 ]] --[[ Name: CreateBubble ]]
        -- upvalues: l_TweenService_0 (copy)
        local v7 = script.BubbleMesh:Clone();
        v7.CFrame = v1;
        v7.Anchored = true;
        v7.CanCollide = false;
        v7.Massless = true;
        v7.Material = Enum.Material.Glass;
        v7.Size = v2;
        v7.Transparency = v3;
        v7.Parent = workspace:FindFirstChild("Effects") or workspace;
        local l_Highlight_0 = Instance.new("Highlight");
        l_Highlight_0.Enabled = false;
        l_Highlight_0.Parent = v7;
        game:GetService("Debris"):AddItem(v7, v5);
        local v9 = TweenInfo.new(v5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
        local v10 = {
            Transparency = v6, 
            Size = v4
        };
        l_TweenService_0:Create(v7, v9, v10):Play();
    end
};