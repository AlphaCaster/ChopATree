-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local v1 = {
    EffectInstance = nil, 
    EmitDivider = 1, 
    CurrentScale = 1, 
    OriginalScale = {}
};
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local l_TableUtil_0 = require(script.Parent:WaitForChild("TableUtil"));
local function v11(v5, v6) --[[ Line: 26 ]] --[[ Name: evalColorSequence ]]
    if v6 == 0 then
        return v5.Keypoints[1].Value;
    elseif v6 == 1 then
        return v5.Keypoints[#v5.Keypoints].Value;
    else
        for v7 = 1, #v5.Keypoints - 1 do
            local v8 = v5.Keypoints[v7];
            local v9 = v5.Keypoints[v7 + 1];
            if v8.Time <= v6 and v6 < v9.Time then
                local v10 = (v6 - v8.Time) / (v9.Time - v8.Time);
                return Color3.new((v9.Value.R - v8.Value.R) * v10 + v8.Value.R, (v9.Value.G - v8.Value.G) * v10 + v8.Value.G, (v9.Value.B - v8.Value.B) * v10 + v8.Value.B);
            end;
        end;
        return;
    end;
end;
v0.new = function(v12) --[[ Line: 54 ]] --[[ Name: new ]]
    -- upvalues: l_TableUtil_0 (copy), v1 (copy), v0 (copy)
    v12 = l_TableUtil_0.Reconcile(v12, v1);
    return (setmetatable({
        EffectInstance = v12.EffectInstance:Clone() or Instance.new("Part"), 
        EmitDivider = v12.EmitDivider or 1, 
        CurrentScale = v12.CurrentScale or 1, 
        OriginalScale = v12.OriginalScale or {}
    }, v0));
end;
v0.SetCFrame = function(v13, v14) --[[ Line: 66 ]] --[[ Name: SetCFrame ]]
    if not v13.EffectInstance then
        return false;
    else
        if v13.EffectInstance:IsA("BasePart") or v13.EffectInstance:IsA("Part") or v13.EffectInstance:IsA("MeshPart") then
            v13.EffectInstance.CFrame = v14;
        elseif v13.EffectInstance:IsA("Model") and v13.EffectInstance.PrimaryPart then
            v13.EffectInstance:SetPrimaryPartCFrame(v14);
        end;
        return true;
    end;
end;
v0.AttachTo = function(v15, v16) --[[ Line: 78 ]] --[[ Name: AttachTo ]]
    local l_WeldConstraint_0 = Instance.new("WeldConstraint");
    v15.EffectInstance.Massless = true;
    v15.EffectInstance.CanCollide = false;
    l_WeldConstraint_0.Part0 = v16;
    l_WeldConstraint_0.Part1 = v15.EffectInstance;
    l_WeldConstraint_0.Parent = v15.EffectInstance;
    return l_WeldConstraint_0;
end;
v0.Play = function(v18, v19) --[[ Line: 92 ]] --[[ Name: Play ]]
    if not v18.EffectInstance then
        return false;
    else
        local l_Descendants_0 = v18.EffectInstance:GetDescendants();
        table.insert(l_Descendants_0, v18.EffectInstance);
        v19 = v19 or {};
        for _, v22 in ipairs(l_Descendants_0) do
            if v22:IsA("ParticleEmitter") then
                local v23 = v22:GetAttribute("EmitCount") or 1;
                local v24 = v22:GetAttribute("EmitRepeat") or 1;
                local v25 = v22:GetAttribute("EmitDelay") or 0;
                if v25 > 0 then
                    task.delay(v25, function() --[[ Line: 107 ]]
                        -- upvalues: v24 (copy), v19 (ref), v22 (copy), v23 (copy), v18 (copy), v25 (copy)
                        for _ = 1, v24 do
                            if not table.find(v19, v22) and not table.find(v19, v22.Name) then
                                v22:Emit((math.ceil(v23 / (v18.EmitDivider or 1))));
                            end;
                            task.wait(v25);
                        end;
                    end);
                else
                    for _ = 1, v24 do
                        if not table.find(v19, v22) and not table.find(v19, v22.Name) then
                            v22:Emit((math.ceil(v23 / v18.EmitDivider)));
                        end;
                    end;
                end;
            end;
        end;
        return true;
    end;
end;
v0.Emit = function(v28, v29, v30) --[[ Line: 128 ]] --[[ Name: Emit ]]
    if not v28.EffectInstance then
        return false;
    else
        v29 = v29 or 1;
        v30 = v30 or {};
        for _, v32 in ipairs(v28.EffectInstance:GetDescendants()) do
            if v32:IsA("ParticleEmitter") and not table.find(v30, v32) and not table.find(v30, v32.Name) then
                v32:Emit((math.ceil(v29 / v28.EmitDivider)));
            end;
        end;
        return true;
    end;
end;
v0.EmitForSeconds = function(v33, v34, v35) --[[ Line: 145 ]] --[[ Name: EmitForSeconds ]]
    if not v33.EffectInstance then
        return false;
    else
        local v36 = {};
        v34 = v34 or 1;
        v35 = v35 or {};
        for _, v38 in ipairs(v33.EffectInstance:GetDescendants()) do
            if v38:IsA("ParticleEmitter") then
                local v39 = v38:GetAttribute("EmitDelay") or 0;
                if not table.find(v35, v38) and not table.find(v35, v38.Name) then
                    if v39 > 0 then
                        task.delay(v39, function() --[[ Line: 158 ]]
                            -- upvalues: v38 (copy)
                            v38.Enabled = true;
                        end);
                    else
                        v38.Enabled = true;
                    end;
                    table.insert(v36, v38);
                end;
            end;
        end;
        task.delay(v34, function() --[[ Line: 169 ]]
            -- upvalues: v36 (copy)
            for _, v41 in ipairs(v36) do
                if v41 then
                    v41.Enabled = false;
                end;
            end;
        end);
        return true;
    end;
end;
v0.Toggle = function(v42, v43, v44) --[[ Line: 179 ]] --[[ Name: Toggle ]]
    -- upvalues: l_TweenService_0 (copy)
    if not v42.EffectInstance then
        return false;
    else
        v44 = v44 or {};
        for _, v46 in ipairs(v42.EffectInstance:GetDescendants()) do
            if v46:IsA("ParticleEmitter") then
                if not table.find(v44, v46) and not table.find(v44, v46.Name) then
                    v46.Enabled = if v43 ~= nil then v43 else not v46.Enabled;
                end;
            elseif v46:IsA("Beam") then
                v46.Enabled = false;
            elseif v46:IsA("PointLight") or v46:IsA("SpotLight") then
                l_TweenService_0:Create(v46, TweenInfo.new(1), {
                    Brightness = 0
                }):Play();
            end;
        end;
        return true;
    end;
end;
v0.SetOriginalScale = function(v47, v48) --[[ Line: 200 ]] --[[ Name: SetOriginalScale ]]
    v47.OriginalScale[v48] = {};
    v47.OriginalScale[v48].Size = v48.Size;
    v47.OriginalScale[v48].Speed = v48.Speed;
    v47.OriginalScale[v48].Acceleration = v48.Acceleration;
end;
v0.SetScale = function(v49, v50, v51, v52) --[[ Line: 207 ]] --[[ Name: SetScale ]]
    if not v49.EffectInstance or not v49.OriginalScale then
        return false;
    else
        v51 = v51 or {};
        v49.CurrentScale = v50;
        for _, v54 in ipairs(v49.EffectInstance:GetDescendants()) do
            if v54:IsA("ParticleEmitter") then
                if not table.find(v51, v54) and not table.find(v51, v54.Name) then
                    if not v49.OriginalScale[v54] or v52 then
                        v49:SetOriginalScale(v54);
                    end;
                    local v55 = {};
                    for _, v57 in ipairs(v49.OriginalScale[v54].Size.Keypoints) do
                        table.insert(v55, NumberSequenceKeypoint.new(v57.Time, v57.Value * v50, v57.Envelope * v50));
                    end;
                    local v58 = NumberSequence.new(v55);
                    local v59 = NumberRange.new(v49.OriginalScale[v54].Speed.Min * v50, v49.OriginalScale[v54].Speed.Max * v50);
                    local v60 = v49.OriginalScale[v54].Acceleration * v50;
                    v54.Size = v58;
                    v54.Speed = v59;
                    v54.Acceleration = v60;
                end;
            elseif v54:IsA("Attachment") then
                v54.Position = v54.Position * v50;
            elseif v54:IsA("Beam") then
                v54.CurveSize0 = v54.CurveSize0 * v50;
                v54.CurveSize1 = v54.CurveSize1 * v50;
                v54.Width0 = v54.Width0 * v50;
                v54.Width1 = v54.Width1 * v50;
            end;
        end;
        return true;
    end;
end;
v0.SetColor = function(v61, v62, v63) --[[ Line: 250 ]] --[[ Name: SetColor ]]
    if not v61.EffectInstance then
        return false;
    else
        v63 = v63 or {};
        for _, v65 in ipairs(v61.EffectInstance:GetDescendants()) do
            if v65:IsA("ParticleEmitter") and not table.find(v63, v65) and not table.find(v63, v65.Name) then
                v65.Color = v62;
            end;
        end;
        return true;
    end;
end;
v0.SetSize = function(v66, v67, v68) --[[ Line: 266 ]] --[[ Name: SetSize ]]
    if not v66.EffectInstance then
        return false;
    else
        v68 = v68 or {};
        for _, v70 in ipairs(v66.EffectInstance:GetDescendants()) do
            if v70:IsA("ParticleEmitter") and not table.find(v68, v70) and not table.find(v68, v70.Name) then
                v70.Size = v67;
            end;
        end;
        return true;
    end;
end;
v0.SetDelayTimeScale = function(v71, v72, v73) --[[ Line: 282 ]] --[[ Name: SetDelayTimeScale ]]
    if not v71.EffectInstance then
        return false;
    else
        v73 = v73 or {};
        for _, v75 in ipairs(v71.EffectInstance:GetDescendants()) do
            if v75:IsA("ParticleEmitter") and not table.find(v73, v75) and not table.find(v73, v75.Name) and v75:GetAttribute("EmitDelay") then
                v75:SetAttribute("EmitDelay", v75:GetAttribute("EmitDelay") * (1 / v72));
            end;
        end;
        return true;
    end;
end;
v0.TweenScale = function(v76, v77, v78, v79) --[[ Line: 299 ]] --[[ Name: TweenScale ]]
    -- upvalues: l_TweenService_0 (copy), l_RunService_0 (copy)
    v79 = v79 or {};
    task.spawn(function() --[[ Line: 302 ]]
        -- upvalues: v76 (copy), v78 (copy), v77 (copy), l_TweenService_0 (ref), v79 (ref), l_RunService_0 (ref)
        local v80 = os.clock();
        local l_CurrentScale_0 = v76.CurrentScale;
        v76.CurrentScale = v78;
        repeat
            local v82 = math.clamp((os.clock() - v80) / v77.Time, 0, 1);
            local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v82, v77.EasingStyle, v77.EasingDirection);
            local v84 = l_CurrentScale_0 + (v78 - l_CurrentScale_0) * l_l_TweenService_0_Value_0;
            v76:SetScale(v84, v79);
            l_RunService_0.Heartbeat:Wait();
        until os.clock() - v80 > v77.Time or not v76.EffectInstance;
        if not v76.EffectInstance then
            return;
        else
            v76:SetScale(v78, v79);
            return;
        end;
    end);
end;
v0.TweenColor = function(v85, v86, v87, v88) --[[ Line: 325 ]] --[[ Name: TweenColor ]]
    -- upvalues: v11 (copy), l_TweenService_0 (copy), l_RunService_0 (copy)
    v88 = v88 or {};
    local v89 = {};
    local v90 = {};
    for _, v92 in ipairs(v85.EffectInstance:GetDescendants()) do
        if v92:IsA("ParticleEmitter") and not table.find(v88, v92) and not table.find(v88, v92.Name) then
            table.insert(v90, v92);
        end;
    end;
    local function v104(v93) --[[ Line: 338 ]] --[[ Name: TickColor ]]
        -- upvalues: v90 (copy), v89 (copy), v87 (copy), v11 (ref)
        for _, v95 in ipairs(v90) do
            if v95 then
                if not v89[v95] then
                    v89[v95] = v95.Color;
                end;
                local v96 = {};
                for _, v98 in ipairs(v87.Keypoints) do
                    local v99 = v11(v89[v95], v98.Time);
                    local l_Value_0 = v98.Value;
                    local v101 = v99.R + (l_Value_0.R - v99.R) * v93;
                    local v102 = v99.G + (l_Value_0.G - v99.G) * v93;
                    local v103 = v99.B + (l_Value_0.B - v99.B) * v93;
                    table.insert(v96, ColorSequenceKeypoint.new(v98.Time, Color3.new(v101, v102, v103)));
                end;
                v95.Color = ColorSequence.new(v96);
            end;
        end;
    end;
    task.spawn(function() --[[ Line: 359 ]]
        -- upvalues: v86 (copy), l_TweenService_0 (ref), v104 (copy), l_RunService_0 (ref)
        local v105 = os.clock();
        repeat
            local v106 = math.clamp((os.clock() - v105) / v86.Time, 0, 1);
            local l_l_TweenService_0_Value_1 = l_TweenService_0:GetValue(v106, v86.EasingStyle, v86.EasingDirection);
            v104(l_l_TweenService_0_Value_1);
            l_RunService_0.Heartbeat:Wait();
        until os.clock() - v105 > v86.Time;
        v104(1);
    end);
end;
v0.IncrementDelay = function(v108, v109, v110) --[[ Line: 376 ]] --[[ Name: IncrementDelay ]]
    v110 = v110 or {};
    for _, v112 in ipairs(v108.EffectInstance:GetDescendants()) do
        if v112:IsA("ParticleEmitter") and not table.find(v110, v112) and not table.find(v110, v112.Name) and v112:GetAttribute("EmitDelay") then
            v112:SetAttribute("EmitDelay", v112:GetAttribute("EmitDelay") + v109);
        end;
    end;
end;
v0.UnLock = function(v113, v114) --[[ Line: 389 ]] --[[ Name: UnLock ]]
    v114 = v114 or {};
    for _, v116 in ipairs(v113.EffectInstance:GetDescendants()) do
        if v116:IsA("ParticleEmitter") and not table.find(v114, v116) and not table.find(v114, v116.Name) then
            v116.LockedToPart = false;
        end;
    end;
end;
v0.Destroy = function(v117) --[[ Line: 401 ]] --[[ Name: Destroy ]]
    if v117.EffectInstance then
        v117.EffectInstance:Destroy();
    end;
    table.clear(v117);
    setmetatable(v117, nil);
end;
return v0;