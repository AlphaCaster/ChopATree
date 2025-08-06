-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v35 = {
    RunWhitePetals = function(v0, v1, v2) --[[ Line: 8 ]] --[[ Name: RunWhitePetals ]]
        local l_Petals_0 = v0.Head.Head.Petals;
        for _, v5 in l_Petals_0:GetChildren() do
            if v5.Name == "FlowerPedalWhite" then
                v5:Destroy();
            end;
        end;
        local l_Pivot_0 = v0.Head.Head.Pivot;
        local l_FlowerPedalWhite_0 = script.FlowerPedalWhite;
        local v8 = math.random(-15, 30) * 0.01;
        for v9 = 0, v1 - 1, 2 do
            local v10 = 6.283185307179586 / v1 * v9;
            local v11 = l_Pivot_0.Position + l_Pivot_0.CFrame:VectorToWorldSpace(Vector3.new(math.cos(v10) * 0.5, 0, math.sin(v10) * 0.5) + Vector3.new(0, 0.25, 0, 0));
            local _ = (l_Pivot_0.Position - v11).Unit;
            local v13 = l_FlowerPedalWhite_0:Clone();
            v13.CFrame = CFrame.lookAt(v11, l_Pivot_0.Position, l_Pivot_0.CFrame.UpVector) * CFrame.new(0, -0.3, 0);
            v13.CFrame = v13.CFrame * CFrame.Angles(0, v2, 0);
            if v1 < 20 then
                v13.Size = v13.Size + Vector3.new(v1 * 0.005, 0, v8);
            end;
            v13.Parent = l_Petals_0;
        end;
    end, 
    RunRedPetals = function(v14, v15, v16) --[[ Line: 46 ]] --[[ Name: RunRedPetals ]]
        local l_Petals_1 = v14.Head.Head.Petals;
        for _, v19 in l_Petals_1:GetChildren() do
            if v19.Name == "FlowerPedalRed" then
                v19:Destroy();
            end;
        end;
        local l_Pivot_1 = v14.Head.Head.Pivot;
        local l_FlowerPedalRed_0 = script.FlowerPedalRed;
        local v22 = math.random(-15, 30) * 0.01;
        for v23 = 1, v15 - 1, 2 do
            local v24 = 6.283185307179586 / v15 * v23;
            local v25 = l_Pivot_1.Position + l_Pivot_1.CFrame:VectorToWorldSpace(Vector3.new(math.cos(v24) * 0.7, 0, math.sin(v24) * 0.7) + Vector3.new(0, 0.11999999731779099, 0, 0));
            local _ = (l_Pivot_1.Position - v25).Unit;
            local v27 = l_FlowerPedalRed_0:Clone();
            v27.CFrame = CFrame.lookAt(v25, l_Pivot_1.Position, l_Pivot_1.CFrame.UpVector) * CFrame.new(0, -0.15, 0);
            v27.CFrame = v27.CFrame * CFrame.Angles(0, v16, 0);
            if v15 < 20 then
                v27.Size = v27.Size - Vector3.new(v15 * 0.008, 0, v22);
            end;
            v27.Parent = l_Petals_1;
        end;
    end, 
    RunSize = function(v28) --[[ Line: 85 ]] --[[ Name: RunSize ]]
        v28:ScaleTo(math.random(90, 115) * 0.01);
        v28.Stem.Stem.Size = Vector3.new(0.15, v28.Stem.Stem.Size.Y, 0.15);
    end, 
    RunLeaves = function(v29) --[[ Line: 91 ]] --[[ Name: RunLeaves ]]
        local l_Stem_0 = v29.Stem.Stem;
        local l_Ground_0 = v29.Stem.Ground;
        for _, v33 in v29.Leaves:GetChildren() do
            local v34 = (l_Ground_0.Position.Y + l_Stem_0.Size.Y) * 0.6;
            v33.Position = Vector3.new(v33.Position.X, v34 + math.random(-20, 10) * 0.1, v33.Position.Z);
        end;
    end
};
v35.RunAll = function(v36) --[[ Line: 104 ]] --[[ Name: RunAll ]]
    -- upvalues: v35 (copy)
    local v37 = math.random(16, 24);
    v36:ScaleTo(1);
    if v37 % 2 ~= 0 then
        v37 = v37 + 1;
    end;
    local l_Pivot_2 = v36.Head.Head.Pivot;
    l_Pivot_2.CFrame = l_Pivot_2.CFrame * CFrame.Angles(0, math.rad((math.random(-180, 180))), 0);
    l_Pivot_2 = 3.141592653589793 / math.random(4, 10);
    if math.random(1, 2) == 1 then
        l_Pivot_2 = -l_Pivot_2;
    end;
    v35.RunWhitePetals(v36, v37, l_Pivot_2);
    v35.RunRedPetals(v36, v37, l_Pivot_2);
    v35.RunSize(v36);
    v35.RunLeaves(v36);
end;
return v35;