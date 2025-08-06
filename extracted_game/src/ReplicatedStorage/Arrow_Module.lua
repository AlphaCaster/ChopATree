-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    GenerateArrow = function(v0, v1, v2) --[[ Line: 3 ]] --[[ Name: GenerateArrow ]]
        local v3 = game.ReplicatedStorage.Arrow:Clone();
        v3.Random_Seed.Value = v2;
        v3.Target_Player.Value = v0.Name;
        v3.Anchored = true;
        v3.Position = v1;
        v3.CanCollide = false;
        v3.Parent = game.Workspace.Tutorial_Arrows;
        local l_Attachment_0 = Instance.new("Attachment");
        l_Attachment_0.Name = v2;
        l_Attachment_0.Parent = v0.Character.HumanoidRootPart;
        l_Attachment_0.Name = tostring(v2) .. "_Arrow";
        l_Attachment_0.CFrame = CFrame.new(0, 0, 0);
        v3.Beam.Attachment1 = l_Attachment_0;
        v3.Beam.Attachment0 = v3.Attachment;
        v3.Attachment.WorldCFrame = CFrame.new(v1);
        return v3;
    end, 
    Remove_Arrow = function(v5) --[[ Line: 22 ]] --[[ Name: Remove_Arrow ]]
        if v5 and v5.Parent then
            local l_FirstChild_0 = game.Players:FindFirstChild(v5.Target_Player.Value);
            if l_FirstChild_0 then
                local l_FirstChild_1 = l_FirstChild_0.Character.HumanoidRootPart:FindFirstChild((tostring(v5.Random_Seed.Value .. "_Arrow")));
                if l_FirstChild_1 then
                    l_FirstChild_1:Destroy();
                end;
                v5:Destroy();
            end;
        end;
    end
};