-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_clock_0 = os.clock;
DiscretePulse = function(v1, v2, v3, v4, v5, v6, v7) --[[ Line: 9 ]] --[[ Name: DiscretePulse ]]
    return (math.clamp(v3 / (2 * v4) - math.abs((v1 - v5 * v2 + 0.5 * v3) / v4), v6, v7));
end;
NoiseBetween = function(v8, v9, v10, v11, v12) --[[ Line: 13 ]] --[[ Name: NoiseBetween ]]
    return v11 + (v12 - v11) * (math.noise(v8, v9, v10) + 0.5);
end;
CubicBezier = function(v13, v14, v15, v16, v17) --[[ Line: 17 ]] --[[ Name: CubicBezier ]]
    return v13 * (1 - v17) ^ 3 + v14 * 3 * v17 * (1 - v17) ^ 2 + v15 * 3 * (1 - v17) * v17 ^ 2 + v16 * v17 ^ 3;
end;
local l_Part_0 = Instance.new("Part");
local v19 = 0;
local v20 = 0;
l_Part_0.TopSurface = v19;
l_Part_0.BottomSurface = v20;
v19 = true;
v20 = false;
l_Part_0.Anchored = v19;
l_Part_0.CanCollide = v20;
l_Part_0.Shape = "Cylinder";
l_Part_0.Name = "BoltPart";
l_Part_0.Material = Enum.Material.Neon;
l_Part_0.Color = Color3.new(1, 1, 1);
l_Part_0.Transparency = 1;
v19 = CFrame.lookAt(Vector3.new(), (Vector3.new(1, 0, 0, 0))):Inverse();
v20 = {};
local v21 = {};
v21.__index = v21;
v21.new = function(v22, v23, v24) --[[ Line: 45 ]] --[[ Name: new ]]
    -- upvalues: v21 (copy), l_Part_0 (copy), v19 (copy), l_clock_0 (copy), v20 (copy)
    local v25 = setmetatable({}, v21);
    v25.Enabled = true;
    v25.Attachment0 = v22;
    v25.Attachment1 = v23;
    local v26 = 0;
    local v27 = 0;
    v25.CurveSize0 = v26;
    v25.CurveSize1 = v27;
    v26 = 0;
    v27 = 2.4;
    v25.MinRadius = v26;
    v25.MaxRadius = v27;
    v25.Frequency = 1;
    v25.AnimationSpeed = 7;
    v25.Thickness = 1;
    v26 = 0.2;
    v27 = 1;
    v25.MinThicknessMultiplier = v26;
    v25.MaxThicknessMultiplier = v27;
    v26 = 0;
    v27 = 1;
    v25.MinTransparency = v26;
    v25.MaxTransparency = v27;
    v25.PulseSpeed = 2;
    v25.PulseLength = 1000000;
    v25.FadeLength = 0.2;
    v25.ContractFrom = 0.5;
    v25.Color = Color3.new(1, 1, 1);
    v25.ColorOffsetSpeed = 3;
    v25.Parts = {};
    v26 = v22;
    v27 = v23;
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    local l_WorldPosition_0 = v26.WorldPosition;
    local v30 = v26.WorldPosition + v26.WorldAxis * v25.CurveSize0;
    local v31 = v27.WorldPosition - v27.WorldAxis * v25.CurveSize1;
    local l_WorldPosition_1 = v27.WorldPosition;
    local l_l_WorldPosition_0_0 = l_WorldPosition_0;
    local l_l_WorldPosition_0_1 = l_WorldPosition_0;
    local v35 = v24 or 30;
    for v36 = 1, v35 do
        local v37 = v36 / v35;
        local v38 = CubicBezier(l_WorldPosition_0, v30, v31, l_WorldPosition_1, v37);
        local v39 = v36 ~= v35 and CFrame.lookAt(l_l_WorldPosition_0_1, v38).Position or v38;
        local v40 = l_Part_0:Clone();
        v40.Size = Vector3.new((v39 - l_l_WorldPosition_0_0).Magnitude, 0, 0);
        v40.CFrame = CFrame.lookAt(0.5 * (l_l_WorldPosition_0_0 + v39), v39) * v19;
        v40.Parent = l_CurrentCamera_0;
        local v41 = true;
        local v42 = false;
        v40.Locked = v41;
        v40.CastShadow = v42;
        v25.Parts[v36] = v40;
        l_l_WorldPosition_0_0 = v39;
        l_l_WorldPosition_0_1 = v38;
    end;
    v25.PartsHidden = false;
    v25.DisabledTransparency = 1;
    v25.StartT = l_clock_0();
    v25.RanNum = math.random() * 100;
    v25.RefIndex = #v20 + 1;
    v20[v25.RefIndex] = v25;
    return v25;
end;
v21.Destroy = function(v43) --[[ Line: 110 ]] --[[ Name: Destroy ]]
    -- upvalues: v20 (copy)
    v20[v43.RefIndex] = nil;
    for v44 = 1, #v43.Parts do
        v43.Parts[v44]:Destroy();
        if v44 % 100 == 0 then
            task.wait();
        end;
    end;
    v43 = nil;
end;
game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 126 ]]
    -- upvalues: v20 (copy), l_clock_0 (copy), v19 (copy)
    for _, v46 in pairs(v20) do
        if v46.Enabled == true then
            v46.PartsHidden = false;
            local v47 = 1 - v46.MaxTransparency;
            local v48 = 1 - v46.MinTransparency;
            local l_MinRadius_0 = v46.MinRadius;
            local l_MaxRadius_0 = v46.MaxRadius;
            local l_Thickness_0 = v46.Thickness;
            local l_Parts_0 = v46.Parts;
            local v53 = #l_Parts_0;
            local l_RanNum_0 = v46.RanNum;
            local l_StartT_0 = v46.StartT;
            local l_AnimationSpeed_0 = v46.AnimationSpeed;
            local l_Frequency_0 = v46.Frequency;
            local l_MinThicknessMultiplier_0 = v46.MinThicknessMultiplier;
            local l_MaxThicknessMultiplier_0 = v46.MaxThicknessMultiplier;
            local l_Attachment0_0 = v46.Attachment0;
            local l_Attachment1_0 = v46.Attachment1;
            local l_CurveSize0_0 = v46.CurveSize0;
            local l_CurveSize1_0 = v46.CurveSize1;
            local l_WorldPosition_2 = l_Attachment0_0.WorldPosition;
            local v65 = l_Attachment0_0.WorldPosition + l_Attachment0_0.WorldAxis * l_CurveSize0_0;
            local v66 = l_Attachment1_0.WorldPosition - l_Attachment1_0.WorldAxis * l_CurveSize1_0;
            local l_WorldPosition_3 = l_Attachment1_0.WorldPosition;
            local v68 = l_clock_0() - l_StartT_0;
            local l_PulseLength_0 = v46.PulseLength;
            local l_PulseSpeed_0 = v46.PulseSpeed;
            local l_FadeLength_0 = v46.FadeLength;
            local l_Color_0 = v46.Color;
            local l_ColorOffsetSpeed_0 = v46.ColorOffsetSpeed;
            local v74 = 1 - v46.ContractFrom;
            local l_l_WorldPosition_2_0 = l_WorldPosition_2;
            local l_l_WorldPosition_2_1 = l_WorldPosition_2;
            if v68 < (l_PulseLength_0 + 1) / l_PulseSpeed_0 then
                for v77 = 1, v53 do
                    local v78 = l_Parts_0[v77];
                    local v79 = v77 / v53;
                    local v80 = DiscretePulse(v79, l_PulseSpeed_0, l_PulseLength_0, l_FadeLength_0, v68, v47, v48);
                    local v81 = CubicBezier(l_WorldPosition_2, v65, v66, l_WorldPosition_3, v79);
                    local v82 = -v68;
                    local v83 = l_AnimationSpeed_0 * v82 + l_Frequency_0 * 10 * v79 - 0.2 + l_RanNum_0 * 4;
                    local v84 = 5 * (l_AnimationSpeed_0 * 0.01 * v82 / 10 + l_Frequency_0 * v79) + l_RanNum_0 * 4;
                    local v85 = NoiseBetween(5 * v83, 1.5, 1 * v84, 0, 0.6283185307179586) + NoiseBetween(0.5 * v83, 1.5, 0.1 * v84, 0, 5.654866776461628);
                    local v86 = NoiseBetween(3.4, v84, v83, l_MinRadius_0, l_MaxRadius_0) * math.exp(-5000 * (v79 - 0.5) ^ 10);
                    local v87 = NoiseBetween(2.3, v84, v83, l_MinThicknessMultiplier_0, l_MaxThicknessMultiplier_0);
                    local v88 = v77 ~= v53 and (CFrame.new(l_l_WorldPosition_2_1, v81) * CFrame.Angles(0, 0, v85) * CFrame.Angles(math.acos((math.clamp(NoiseBetween(v84, v83, 2.7, 6.123233995736766E-17, 1), -1, 1))), 0, 0) * CFrame.new(0, 0, -v86)).Position or v81;
                    if v74 < v80 then
                        v78.Size = Vector3.new((v88 - l_l_WorldPosition_2_0).Magnitude, l_Thickness_0 * v87 * v80, l_Thickness_0 * v87 * v80);
                        v78.CFrame = CFrame.lookAt(0.5 * (l_l_WorldPosition_2_0 + v88), v88) * v19;
                        v78.Transparency = 1 - v80;
                    elseif v74 - 1 / (v53 * l_FadeLength_0) < v80 then
                        local v89 = (1 - (v80 - (v74 - 1 / (v53 * l_FadeLength_0))) * v53 * l_FadeLength_0) * (v79 < v68 * l_PulseSpeed_0 - 0.5 * l_PulseLength_0 and 1 or -1);
                        v78.Size = Vector3.new((1 - math.abs(v89)) * (v88 - l_l_WorldPosition_2_0).Magnitude, l_Thickness_0 * v87 * v80, l_Thickness_0 * v87 * v80);
                        v78.CFrame = CFrame.lookAt(l_l_WorldPosition_2_0 + (v88 - l_l_WorldPosition_2_0) * (math.max(0, v89) + (1 - math.abs(v89)) * 0.5), v88) * v19;
                        v78.Transparency = 1 - v80;
                    else
                        v78.Transparency = 1;
                    end;
                    if typeof(l_Color_0) == "Color3" then
                        v78.Color = l_Color_0;
                    else
                        v79 = (l_RanNum_0 + v79 - v68 * l_ColorOffsetSpeed_0) % 1;
                        local l_Keypoints_0 = l_Color_0.Keypoints;
                        for _ = 1, #l_Keypoints_0 - 1 do
                            if l_Keypoints_0[v77].Time < v79 and v79 < l_Keypoints_0[v77 + 1].Time then
                                v78.Color = l_Keypoints_0[v77].Value:lerp(l_Keypoints_0[v77 + 1].Value, (v79 - l_Keypoints_0[v77].Time) / (l_Keypoints_0[v77 + 1].Time - l_Keypoints_0[v77].Time));
                                break;
                            end;
                        end;
                    end;
                    l_l_WorldPosition_2_0 = v88;
                    l_l_WorldPosition_2_1 = v81;
                end;
            else
                v46:Destroy();
            end;
        elseif v46.PartsHidden == false then
            v46.PartsHidden = true;
            local l_DisabledTransparency_0 = v46.DisabledTransparency;
            for v93 = 1, #v46.Parts do
                v46.Parts[v93].Transparency = l_DisabledTransparency_0;
            end;
        end;
    end;
end);
return v21;