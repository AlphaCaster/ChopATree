-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Lighting_0 = game:GetService("Lighting");
local _ = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local v4 = require(script.Parent.Parent.Utility.Utility);
local v5 = require(script.Parent.Parent.Utility.Tables);
local v6 = require(script.Parent.BoatTween);
local v7 = {};
v7.CreateEffect = function(_, v9) --[[ Line: 34 ]] --[[ Name: CreateEffect ]]
    -- upvalues: v7 (copy), v4 (copy)
    local v10 = v9.Object:Clone();
    v10.Parent = v9.Parent or workspace.Visuals;
    if v9.Position then
        v10:PivotTo(typeof(v9.Position) == "Vector3" and CFrame.new(v9.Position) or v9.Position);
    end;
    if v9.Emit then
        task.delay(v9.EmitDelay, v7.Emit, v7, v10, 1);
    end;
    if v9.Attach and v10 and v9.Parent and (v9.Parent:IsA("Part") or v9.Parent:IsA("BasePart")) then
        if v10:IsA("Model") then
            v7:Attach(v10.PrimaryPart, v9.Parent);
        else
            v7:Attach(v10, v9.Parent);
        end;
    end;
    if v9.DebrisTime then
        v4:AddItem(v10, v9.DebrisTime);
    end;
    if v9.RaycastColored then
        local v11 = workspace:Raycast(v9.RaycastColored.Origin, v9.RaycastColored.Direction, v4.RayParams);
        if not v11 then
            return;
        else
            for _, v13 in v10:GetDescendants() do
                if v13:IsA("ParticleEmitter") and v13:GetAttribute("Raycast") then
                    v13.Color = ColorSequence.new(v11.Instance.Color, v11.Instance.Color);
                end;
            end;
        end;
    end;
    return v10;
end;
v7.Emit = function(_, v15, v16, v17) --[[ Line: 76 ]] --[[ Name: Emit ]]
    -- upvalues: l_TweenService_0 (copy), l_RunService_0 (copy)
    for _, v19 in v15:GetDescendants() do
        if not v17 or not v17[v19.Name] then
            if v19:IsA("ParticleEmitter") then
                local v20 = v19:GetAttribute("EmitDuration") or 0;
                if v20 < 0.05 then
                    task.delay(v19:GetAttribute("EmitDelay"), function() --[[ Line: 86 ]]
                        -- upvalues: v19 (copy)
                        v19:Emit((v19:GetAttribute("EmitCount")));
                    end);
                else
                    local v21 = os.clock() + v20;
                    task.spawn(function() --[[ Line: 92 ]]
                        -- upvalues: v19 (copy), v21 (copy)
                        repeat
                            v19:Emit((v19:GetAttribute("EmitCount")));
                            task.wait(0.1);
                        until v21 - os.clock() <= 0;
                    end);
                end;
            elseif v19:IsA("PointLight") or v19:IsA("SpotLight") or v19:IsA("SurfaceLight") then
                l_TweenService_0:Create(v19, TweenInfo.new(v16 or 1), {
                    Brightness = 0
                }):Play();
            elseif v19:IsA("Decal") then
                l_TweenService_0:Create(v19, TweenInfo.new(v16 or 1), {
                    Transparency = 1
                }):Play();
            elseif v19:IsA("Beam") then
                local function v23(v22) --[[ Line: 104 ]] --[[ Name: UpdateTransparency ]]
                    -- upvalues: v19 (copy)
                    v19.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, v22), 
                        NumberSequenceKeypoint.new(1, v22)
                    });
                end;
                task.spawn(function() --[[ Line: 111 ]]
                    -- upvalues: v19 (copy), v16 (copy), l_TweenService_0 (ref), v23 (copy), l_RunService_0 (ref)
                    local v24 = os.clock();
                    local l_Value_0 = v19.Transparency.Keypoints[2].Value;
                    repeat
                        local v26 = math.clamp((os.clock() - v24) / v16, l_Value_0, 1);
                        local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v26, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
                        v23(l_l_TweenService_0_Value_0);
                        l_RunService_0.Heartbeat:Wait();
                    until os.clock() - v24 > v16;
                    v23(1);
                end);
            end;
        end;
    end;
end;
v7.Attach = function(_, v29, v30, v31) --[[ Line: 130 ]] --[[ Name: Attach ]]
    -- upvalues: v4 (copy)
    local l_WeldConstraint_0 = Instance.new("WeldConstraint");
    v29.Massless = true;
    v29.CanCollide = false;
    l_WeldConstraint_0.Part0 = v30;
    l_WeldConstraint_0.Part1 = v29;
    l_WeldConstraint_0.Parent = v29;
    if v31 then
        v4:AddItem(l_WeldConstraint_0, v31);
    end;
end;
v7.PlaySound = function(_, v34, v35) --[[ Line: 146 ]] --[[ Name: PlaySound ]]
    -- upvalues: v4 (copy)
    local v36 = v34:Clone();
    v36.Parent = v35;
	v36:Play();
	if not v36.Looped then
	v4:AddItem(v36, v34.TimeLength > 0.1 and v34.TimeLength or 1);
	end
    return v36;
end;
v7.SetScale = function(_, v38, v39, v40) --[[ Line: 156 ]] --[[ Name: SetScale ]]
    for _, v42 in v38:GetDescendants() do
        if v42:IsA("ParticleEmitter") then
            if not table.find(v40, v42) and not table.find(v40, v42.Name) then
                local v43 = {};
                for _, v45 in ipairs(v42.Size.Keypoints) do
                    table.insert(v43, NumberSequenceKeypoint.new(v45.Time, v45.Value * v39, v45.Envelope * v39));
                end;
                local v46 = NumberSequence.new(v43);
                local v47 = NumberRange.new(v42.Speed.Min * v39, v42.Speed.Max * v39);
                local v48 = v42.Acceleration * v39;
                v42.Size = v46;
                v42.Speed = v47;
                v42.Acceleration = v48;
            end;
        elseif v42:IsA("Attachment") then
            v42.Position = v42.Position * v39;
        elseif v42:IsA("Beam") then
            v42.CurveSize0 = v42.CurveSize0 * v39;
            v42.CurveSize1 = v42.CurveSize1 * v39;
            v42.Width0 = v42.Width0 * v39;
            v42.Width1 = v42.Width1 * v39;
        end;
    end;
    v38:SetAttribute("Scale", v39);
end;
v7.ScaleTo = function(_, v50, v51, v52, v53) --[[ Line: 189 ]] --[[ Name: ScaleTo ]]
    -- upvalues: l_TweenService_0 (copy), v7 (copy), l_RunService_0 (copy)
    v53 = v53 or {} or v53;
    if not v53 then
        return;
    else
        task.spawn(function() --[[ Line: 196 ]]
            -- upvalues: v50 (copy), v52 (copy), l_TweenService_0 (ref), v51 (copy), v7 (ref), v53 (ref), l_RunService_0 (ref)
            local v54 = os.clock();
            local v55 = v50:GetAttribute("Scale") or 1;
            repeat
                local v56 = math.clamp((os.clock() - v54) / v52, 0, 1);
                local l_l_TweenService_0_Value_1 = l_TweenService_0:GetValue(v56, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
                local v58 = v55 + (v51 - v55) * l_l_TweenService_0_Value_1;
                v7:SetScale(v50, v58, v53);
                l_RunService_0.Heartbeat:Wait();
            until os.clock() - v54 > v52 or not v50;
            if not v50 then
                return;
            else
                v7:SetScale(v50, v51, v53);
                return;
            end;
        end);
        return;
    end;
end;
v7.AdjustSpeed = function(_) --[[ Line: 218 ]] --[[ Name: AdjustSpeed ]]

end;
v7.Recolor = function(_) --[[ Line: 222 ]] --[[ Name: Recolor ]]

end;
if l_RunService_0:IsClient() then
    local v61 = require(script.Parent.CameraShaker);
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    local v64 = v61.new(Enum.RenderPriority.Camera.Value, function(v63) --[[ Line: 230 ]]
        -- upvalues: l_CurrentCamera_0 (copy)
        l_CurrentCamera_0.CFrame = l_CurrentCamera_0.CFrame * v63;
    end);
    v64:Start();
    v7.ShakeCamera = function(_, v66) --[[ Line: 236 ]] --[[ Name: ShakeCamera ]]
        -- upvalues: v64 (copy), v61 (copy)
        v64:Shake(v61.Presets[v66]);
    end;
    v7.ShakeSustain = function(_, v68) --[[ Line: 240 ]] --[[ Name: ShakeSustain ]]
        -- upvalues: v64 (copy), v61 (copy)
        return v64:ShakeSustain(v61.Presets[v68]);
    end;
    v7.ShakeOnce = function(_, v70) --[[ Line: 244 ]] --[[ Name: ShakeOnce ]]
        -- upvalues: v5 (copy), v64 (copy)
        local v71 = {
            Magnitude = 6, 
            Roughness = 4, 
            FadeInTime = 0.05, 
            FadeOutTime = 0.75, 
            PositionInfluence = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448, 0), 
            RotationInfluence = Vector3.new(1, 1, 1, 0)
        };
        local v72 = v5.Reconcile(v70, v71);
        v64:ShakeOnce(v72.Magnitude, v72.Roughness, v72.FadeInTime, v72.FadeOutTime, v72.PosInfluence, v72.RotInfluence);
    end;
end;
v7.CreateLighting = function(_, v74, v75, v76) --[[ Line: 261 ]] --[[ Name: CreateLighting ]]
    -- upvalues: l_Lighting_0 (copy), v4 (copy)
    local v77 = Instance.new(v74);
    v77.Parent = l_Lighting_0;
    for v78, v79 in v75 do
        if v77[v78] then
            v77[v78] = v79;
        end;
    end;
    if v76 then
        v4:AddItem(v77, v76);
    end;
    return v77;
end;
v7.UpdateStatus = function(_, v81, v82, v83) --[[ Line: 278 ]] --[[ Name: UpdateStatus ]]
    -- upvalues: v6 (copy), l_TweenService_0 (copy)
    local v84 = typeof(v81) ~= "table" and v81:GetDescendants() or v81;
    for _, v86 in v84 do
        if not v83 or not v83[v86.Name] then
            task.spawn(function() --[[ Line: 286 ]]
                -- upvalues: v86 (copy), v82 (copy), v6 (ref), l_TweenService_0 (ref)
                if v86:IsA("ParticleEmitter") then
                    v86.Enabled = v82;
                    return;
                elseif v86:IsA("Beam") or v86:IsA("Trail") then
                    if v82 then
                        v86.Enabled = true;
                        return;
                    else
                        local v87 = v6:Create(v86, {
                            Time = 1, 
                            EasingStyle = "EntranceExpressive", 
                            EasingDirection = "Out", 
                            StepType = "RenderStepped", 
                            Goal = v86:IsA("Beam") and {
                                Transparency = NumberSequence.new(1, 1), 
                                TextureSpeed = 0
                            } or {
                                Transparency = NumberSequence.new(1, 1)
                            }
                        });
                        v87:Play();
                        v87.Completed:Connect(function() --[[ Line: 310 ]]
                            -- upvalues: v87 (copy)
                            v87:Destroy();
                        end);
                        return;
                    end;
                else
                    if v86:IsA("PointLight") or v86:IsA("SpotLight") then
                        if v82 then
                            v86.Enabled = false;
                            return;
                        else
                            l_TweenService_0:Create(v86, TweenInfo.new(1), {
                                Brightness = 0
                            }):Play();
                        end;
                    end;
                    return;
                end;
            end);
        end;
    end;
end;
return v7;