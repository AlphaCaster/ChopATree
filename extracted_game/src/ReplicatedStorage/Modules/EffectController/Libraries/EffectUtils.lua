-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ReplicatedStorage_1 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_Debris_0 = game:GetService("Debris");
local v4 = require(l_ReplicatedStorage_0.Modules.EffectController.Utility.Utility);
local function _(v5, v6, v7) --[[ Line: 8 ]] --[[ Name: lerp ]]
    return v5 + (v6 - v5) * v7;
end;
local v9 = {};
local v10 = {
    "rbxassetid://13080396681", 
    "rbxassetid://13080396467", 
    "rbxassetid://13080396272", 
    "rbxassetid://13080396046", 
    "rbxassetid://13080395739", 
    "rbxassetid://13080395411", 
    "rbxassetid://13080395112", 
    "rbxassetid://13080394784", 
    "rbxassetid://13080394488", 
    "rbxassetid://13080394240", 
    "rbxassetid://13080394013", 
    "rbxassetid://13080393801", 
    "rbxassetid://13080393553", 
    "rbxassetid://13080393316", 
    "rbxassetid://13080393039", 
    "rbxassetid://13080392801", 
    "rbxassetid://13080392599", 
    "rbxassetid://13080392299", 
    "rbxassetid://13080392045", 
    "rbxassetid://13080391819", 
    "rbxassetid://13080391566", 
    "rbxassetid://13080391273", 
    "rbxassetid://13080391030", 
    "rbxassetid://13080391030", 
    "rbxassetid://13080390759", 
    "rbxassetid://13080389960"
};
local v22 = {
    EmitParticles = function(v11, v12, v13, v14) --[[ Line: 44 ]] --[[ Name: EmitParticles ]]
        -- upvalues: l_TweenService_0 (copy)
        v12 = v12 or 2;
        v13 = v13 or 0.5;
        v14 = v14 or false;
        for _, v16 in next, v11:GetDescendants() do
            if v16:IsA("ParticleEmitter") then
                if v16:GetAttribute("EmitDelay") then
                    task.delay(v16:GetAttribute("EmitDelay"), function() --[[ Line: 52 ]]
                        -- upvalues: v16 (copy)
                        v16:Emit(v16:GetAttribute("EmitCount"));
                    end);
                else
                    v16:Emit(v16:GetAttribute("EmitCount"));
                end;
            elseif (v16:IsA("PointLight") or v16:IsA("SpotLight")) and v14 == false then
                l_TweenService_0:Create(v16, TweenInfo.new(v13, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, true, 0), {
                    Brightness = v12
                }):Play();
            end;
        end;
    end, 
    ParticleHandler = function(v17, v18, v19) --[[ Line: 68 ]] --[[ Name: ParticleHandler ]]
        -- upvalues: l_TweenService_0 (copy)
        for _, v21 in next, v17:GetDescendants() do
            if v21:IsA("ParticleEmitter") then
                v21.Enabled = v18;
            elseif v21:IsA("PointLight") or v21:IsA("SpotLight") then
                l_TweenService_0:Create(v21, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Brightness = v19
                }):Play();
            end;
        end;
    end
};
v22.OwnTrails = function(v23, v24, v25, v26, v27) --[[ Line: 80 ]] --[[ Name: OwnTrails ]]
    -- upvalues: v22 (copy), l_Debris_0 (copy)
    v25 = v25 or 15;
    v24 = v24 or 15;
    v27 = v27 or 3;
    coroutine.wrap(function() --[[ Line: 87 ]]
        -- upvalues: v23 (copy), v26 (copy), v24 (ref), v25 (ref), v22 (ref), l_Debris_0 (ref), v27 (ref)
        local l_Position_0 = v23.Position;
        local l_Position_1 = v26.Position;
        local v30 = (l_Position_0 + l_Position_1) / 2 + Vector3.new(math.random(-v24, v24), math.random(-v24, v24), math.random(-v24, v24));
        for v31 = 1, v25 do
            local v32 = v31 / v25;
            local v33 = l_Position_0 + (v30 - l_Position_0) * v32;
            v23.Position = v33 + (v30 + (l_Position_1 - v30) * v32 - v33) * v32;
            l_Position_1 = v26.Position;
            task.wait();
        end;
        v22.ParticleHandler(v23, false, 0);
        l_Debris_0:AddItem(v23, v27);
    end)();
end;
v22.CreateTrails = function(v34, v35, v36, v37, v38, v39, v40) --[[ Line: 108 ]] --[[ Name: CreateTrails ]]
    -- upvalues: l_Debris_0 (copy)
    v35 = v35 or 15;
    v34 = v34 or 15;
    v39 = v39 or false;
    v40 = v40 or 2;
    v37 = v37 or {
        [1] = Color3.fromRGB(255, 255, 255)
    };
    local v41 = v37[math.random(1, #v37)];
    local v42 = nil;
    if v39 and math.random(1, v40) == v40 then
        v42 = script.Trails.Trail2:Clone();
        v42.Attachment1.Trail.WidthScale = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0), 
            NumberSequenceKeypoint.new(0.3, v34 * 0.01), 
            NumberSequenceKeypoint.new(1, 0)
        });
    else
        v42 = script.Trails.Trail:Clone();
    end;
    v42.Attachment1.Trail.LightEmission = 0.5;
    v42.CFrame = v36.CFrame * CFrame.new(math.random(-v34, v34), math.random(-v34, v34), math.random(-v34, v34));
    v42.Attachment1.Trail.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, v41), 
        ColorSequenceKeypoint.new(1, v41)
    });
    v42.Parent = v38;
    coroutine.wrap(function() --[[ Line: 138 ]]
        -- upvalues: v42 (ref), v36 (copy), v34 (ref), v35 (ref), l_Debris_0 (ref)
        local l_Position_2 = v42.Position;
        local l_Position_3 = v36.Position;
        local v45 = (l_Position_2 + l_Position_3) / 2 + Vector3.new(math.random(-v34, v34), math.random(-v34, v34), math.random(-v34, v34));
        for v46 = 1, v35 do
            local v47 = v46 / v35;
            local v48 = l_Position_2 + (v45 - l_Position_2) * v47;
            v42.Position = v48 + (v45 + (l_Position_3 - v45) * v47 - v48) * v47;
            l_Position_3 = v36.Position;
            task.wait();
        end;
        l_Debris_0:AddItem(v42, v42.Attachment1.Trail.Lifetime);
    end)();
end;
v22.CreatePartTrails = function(v49, v50, v51) --[[ Line: 158 ]] --[[ Name: CreatePartTrails ]]
    -- upvalues: l_ReplicatedStorage_1 (copy), l_Debris_0 (copy), l_TweenService_0 (copy)
    v50 = v50 or 15;
    v49 = v49 or 15;
    local v52 = v51.Position + Vector3.new(math.random(-v49, v49), math.random(-v49, v49), math.random(-v49, v49));
    local l_Position_4 = v51.Position;
    local v54 = (v52 + l_Position_4) / 2 + Vector3.new(math.random(-v49, v49), math.random(-v49, v49), math.random(-v49, v49));
    coroutine.wrap(function() --[[ Line: 166 ]]
        -- upvalues: v50 (ref), v52 (copy), v54 (copy), l_Position_4 (ref), l_ReplicatedStorage_1 (ref), l_Debris_0 (ref), l_TweenService_0 (ref), v51 (copy)
        for v55 = 1, v50 do
            local v56 = v55 / v50;
            local v57 = (v55 + 1) / v50;
            local l_v52_0 = v52;
            local v59 = l_v52_0 + (v54 - l_v52_0) * v56;
            local l_v54_0 = v54;
            l_v52_0 = l_v54_0 + (l_Position_4 - l_v54_0) * v56;
            local l_v52_1 = v52;
            l_v54_0 = l_v52_1 + (v54 - l_v52_1) * v57;
            local l_v54_1 = v54;
            l_v52_1 = l_v54_1 + (l_Position_4 - l_v54_1) * v57;
            l_v54_1 = v59 + (l_v52_0 - v59) * v56;
            local v63 = l_v54_0 + (l_v52_1 - l_v54_0) * v57;
            local l_Magnitude_0 = (v63 - l_v54_1).Magnitude;
            local v65 = l_ReplicatedStorage_1.GoIn:Clone();
            l_Debris_0:AddItem(v65, 0.025);
            v65.Position = l_v54_1;
            v65.CFrame = CFrame.lookAt(v65.Position, v63);
            v65.Parent = workspace.FX;
            l_TweenService_0:Create(v65, TweenInfo.new(0.025), {
                Size = Vector3.new(0.2, 0.2, l_Magnitude_0)
            }):Play();
            l_Position_4 = v51.Position;
            task.wait();
        end;
    end)();
end;
v22.Flipbook = function(v66, v67, v68) --[[ Line: 195 ]] --[[ Name: Flipbook ]]
    local l_Decal_0 = v66:FindFirstChildOfClass("Decal");
    if l_Decal_0 and v68 then
        l_Decal_0.Transparency = 1;
        coroutine.wrap(function() --[[ Line: 199 ]]
            -- upvalues: v68 (copy), l_Decal_0 (copy), v67 (copy)
            for v70 = 1, #v68 do
                local l_l_Decal_0_0 = l_Decal_0;
                l_l_Decal_0_0.Transparency = l_l_Decal_0_0.Transparency - #v68 * 0.025;
                l_Decal_0.Texture = v68[v70];
                task.wait(1 / v67);
            end;
            l_Decal_0.Texture = "";
        end)();
    end;
end;
v22.GroundSmoke = function(v72) --[[ Line: 211 ]] --[[ Name: GroundSmoke ]]
    -- upvalues: l_TweenService_0 (copy), v22 (copy), v10 (copy)
    local v73 = Random.new():NextNumber(125, 500);
    local v74 = script.SmokeMesh:Clone();
    v74.Decal.ZIndex = math.random(1, 10000000);
    v74.Decal.Color3 = Color3.fromRGB(1 * v73, 1 * v73, 1 * v73);
    v74.CFrame = v72.CFrame * CFrame.new(0, -1, 0) * CFrame.Angles(0, math.rad((math.random(-360, 360))), 0);
    v74.Parent = workspace.World.Alive;
    l_TweenService_0:Create(v74.Mesh, TweenInfo.new(0.75), {
        Scale = Vector3.new(2, 0, 2, 0) * Random.new():NextNumber(0.5, 1.25)
    }):Play();
    l_TweenService_0:Create(v74, TweenInfo.new(0.75), {
        CFrame = v74.CFrame * CFrame.Angles(0, -2.0943951023931953, 0) * CFrame.new(0, -2.5, 0)
    }):Play();
    l_TweenService_0:Create(v74.Decal, TweenInfo.new(0.125), {
        Transparency = 0
    }):Play();
    task.delay(0.1, function() --[[ Line: 223 ]]
        -- upvalues: l_TweenService_0 (ref), v74 (copy)
        l_TweenService_0:Create(v74.Decal, TweenInfo.new(0.625), {
            Transparency = 1
        }):Play();
    end);
    v22.Flipbook(v74, 48, v10);
end;
v22.ImpactFrame = function(v75, v76) --[[ Line: 230 ]] --[[ Name: ImpactFrame ]]
    -- upvalues: l_Debris_0 (copy)
    v76 = v76 or 0.06;
    for _, v78 in next, game.Lighting:GetChildren() do
        if v78:IsA("ColorCorrectionEffect") then
            v78.Enabled = false;
        end;
    end;
    for v79 = 1, #v75 do
        local l_Highlight_0 = Instance.new("Highlight");
        l_Highlight_0.FillTransparency = 0;
        l_Highlight_0.OutlineTransparency = 1;
        l_Highlight_0.FillColor = Color3.new(1, 1, 1);
        l_Highlight_0.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        l_Highlight_0.Parent = v75[v79];
        task.delay(v76 * 0.5, function() --[[ Line: 246 ]]
            -- upvalues: l_Highlight_0 (copy)
            l_Highlight_0.FillColor = Color3.new(0, 0, 0);
        end);
        l_Debris_0:AddItem(l_Highlight_0, v76);
    end;
    local l_ColorCorrectionEffect_0 = Instance.new("ColorCorrectionEffect");
    l_ColorCorrectionEffect_0.TintColor = Color3.new(0, 0, 0);
    l_ColorCorrectionEffect_0.Brightness = 3;
    task.delay(v76 * 0.5, function() --[[ Line: 255 ]]
        -- upvalues: l_ColorCorrectionEffect_0 (copy), v76 (ref)
        l_ColorCorrectionEffect_0.TintColor = Color3.new(1, 1, 1);
        task.wait(v76 * 0.5);
        for _, v83 in next, game.Lighting:GetChildren() do
            if v83:IsA("ColorCorrectionEffect") then
                v83.Enabled = true;
            end;
        end;
    end);
    l_ColorCorrectionEffect_0.Parent = game.Lighting;
    l_Debris_0:AddItem(l_ColorCorrectionEffect_0, v76);
end;
v22.BlackWhite = function(v84) --[[ Line: 270 ]] --[[ Name: BlackWhite ]]
    -- upvalues: l_Debris_0 (copy)
    v84 = v84 or 0.08;
    local l_ColorCorrectionEffect_1 = Instance.new("ColorCorrectionEffect");
    l_Debris_0:AddItem(l_ColorCorrectionEffect_1, 1);
    l_ColorCorrectionEffect_1.Contrast = 5;
    l_ColorCorrectionEffect_1.Saturation = -1;
    l_ColorCorrectionEffect_1.Enabled = false;
    l_ColorCorrectionEffect_1.Parent = game.Lighting;
    local l_ColorCorrectionEffect_2 = Instance.new("ColorCorrectionEffect");
    l_Debris_0:AddItem(l_ColorCorrectionEffect_2, 1);
    l_ColorCorrectionEffect_2.Contrast = -3;
    l_ColorCorrectionEffect_2.Saturation = -1;
    l_ColorCorrectionEffect_2.Enabled = false;
    l_ColorCorrectionEffect_2.Parent = game.Lighting;
    l_ColorCorrectionEffect_1.Enabled = true;
    task.delay(v84, function() --[[ Line: 288 ]]
        -- upvalues: l_ColorCorrectionEffect_1 (copy), l_ColorCorrectionEffect_2 (copy), v84 (ref)
        l_ColorCorrectionEffect_1.Enabled = false;
        l_ColorCorrectionEffect_2.Enabled = true;
        task.wait(v84);
        l_ColorCorrectionEffect_2.Enabled = false;
    end);
end;
v22.BloomBlur = function() --[[ Line: 296 ]] --[[ Name: BloomBlur ]]
    -- upvalues: l_Debris_0 (copy), l_TweenService_0 (copy)
    local l_new_0 = TweenInfo.new;
    local l_BlurEffect_0 = Instance.new("BlurEffect");
    local l_BloomEffect_0 = Instance.new("BloomEffect");
    l_BlurEffect_0.Parent = game.Lighting;
    l_BloomEffect_0.Parent = game.Lighting;
    l_Debris_0:AddItem(l_BlurEffect_0, 0.5);
    l_Debris_0:AddItem(l_BloomEffect_0, 0.5);
    l_BlurEffect_0.Name = "Blur";
    l_BloomEffect_0.Name = "Bloom";
    l_TweenService_0:Create(l_BlurEffect_0, l_new_0(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = math.random(8, 12)
    }):Play();
    l_TweenService_0:Create(l_BloomEffect_0, l_new_0(0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Intensity = 3, 
        Size = 35, 
        Threshold = 1
    }):Play();
    task.delay(0.1, function() --[[ Line: 312 ]]
        -- upvalues: l_TweenService_0 (ref), l_BlurEffect_0 (copy), l_new_0 (copy), l_BloomEffect_0 (copy)
        l_TweenService_0:Create(l_BlurEffect_0, l_new_0(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        l_TweenService_0:Create(l_BloomEffect_0, l_new_0(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Intensity = 1, 
            Size = 24, 
            Threshold = 2
        }):Play();
    end);
end;
v22.JustBlur = function(v90) --[[ Line: 319 ]] --[[ Name: JustBlur ]]
    -- upvalues: l_Debris_0 (copy), l_TweenService_0 (copy)
    local l_new_1 = TweenInfo.new;
    local l_BlurEffect_1 = Instance.new("BlurEffect");
    l_BlurEffect_1.Parent = game.Lighting;
    l_Debris_0:AddItem(l_BlurEffect_1, v90);
    l_BlurEffect_1.Name = "Blur";
    l_TweenService_0:Create(l_BlurEffect_1, l_new_1(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = math.random(8, 12)
    }):Play();
    task.delay(v90 - 0.5, function() --[[ Line: 331 ]]
        -- upvalues: l_TweenService_0 (ref), l_BlurEffect_1 (copy), l_new_1 (copy)
        l_TweenService_0:Create(l_BlurEffect_1, l_new_1(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
    end);
end;
v22.JustBloom = function(v93) --[[ Line: 336 ]] --[[ Name: JustBloom ]]
    -- upvalues: l_Debris_0 (copy), l_TweenService_0 (copy)
    v93 = v93 or 1;
    local l_new_2 = TweenInfo.new;
    local l_BloomEffect_1 = Instance.new("BloomEffect");
    l_BloomEffect_1.Parent = game.Lighting;
    l_Debris_0:AddItem(l_BloomEffect_1, v93);
    l_BloomEffect_1.Name = "Bloom";
    l_TweenService_0:Create(l_BloomEffect_1, l_new_2(0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Intensity = 3, 
        Size = 35, 
        Threshold = 1
    }):Play();
    task.delay(v93 - 0.5, function() --[[ Line: 345 ]]
        -- upvalues: l_TweenService_0 (ref), l_BloomEffect_1 (copy), l_new_2 (copy)
        l_TweenService_0:Create(l_BloomEffect_1, l_new_2(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Intensity = 1, 
            Size = 24, 
            Threshold = 2
        }):Play();
    end);
end;
v22.AddColorDepth = function(v96, v97) --[[ Line: 350 ]] --[[ Name: AddColorDepth ]]
    -- upvalues: l_Debris_0 (copy), l_TweenService_0 (copy)
    v96 = v96 or 1;
    v97 = v97 or 0.35;
    local l_ColorCorrectionEffect_3 = Instance.new("ColorCorrectionEffect");
    l_Debris_0:AddItem(l_ColorCorrectionEffect_3, v96 + v97);
    l_ColorCorrectionEffect_3.Saturation = 0.2;
    l_ColorCorrectionEffect_3.Contrast = 0.1;
    l_ColorCorrectionEffect_3.Parent = game.Lighting;
    task.delay(v97, function() --[[ Line: 360 ]]
        -- upvalues: l_TweenService_0 (ref), l_ColorCorrectionEffect_3 (copy), v96 (ref), v97 (ref)
        l_TweenService_0:Create(l_ColorCorrectionEffect_3, TweenInfo.new(0.3), {
            Saturation = 0.2, 
            Contrast = 0.1
        }):Play();
        task.wait(v96 - v97);
        l_TweenService_0:Create(l_ColorCorrectionEffect_3, TweenInfo.new(0.3), {
            Saturation = 0, 
            Contrast = 0
        }):Play();
    end);
end;
v22.GroundRocks = function(v99, v100, v101, v102, v103, v104, v105) --[[ Line: 367 ]] --[[ Name: GroundRocks ]]
    -- upvalues: v4 (copy), l_TweenService_0 (copy)
    v100 = v100 or -10;
    for _ = 1, v101 do
        local v107 = CFrame.new(v99);
        local v108 = workspace:Raycast(v107.Position, Vector3.new(0, v100, 0), v4.RayParams);
        if v108 and v108.Instance and v108.Position then
            local l_Part_0 = Instance.new("Part");
            l_Part_0.Parent = workspace.World.ClientEffects;
            l_Part_0.Name = "Rock";
            l_Part_0.Anchored = false;
            l_Part_0.CanCollide = true;
            l_Part_0.CollisionGroup = "Humanoid";
            local v110 = math.random(10, v102 * 100) / 100;
            l_Part_0.Size = Vector3.new(v110, v110 / 1.5, v110 / 1.5);
            l_Part_0.CFrame = CFrame.new(v108.Position) * CFrame.Angles(math.rad((math.random(-360, 360))), math.rad((math.random(-360, 360))), (math.rad((math.random(-360, 360)))));
            l_Part_0.Material = v108.Material;
            l_Part_0.MaterialVariant = v108.Instance.MaterialVariant;
            l_Part_0.Color = v108.Instance.Color;
            local v111 = Random.new():NextInteger(-2, 2);
            local v112 = Random.new():NextInteger(-2, 2);
            local l_Unit_0 = (v108.Position + Vector3.new(0, 5, 0, 0) - (v108.Position + Vector3.new(v111, 1, v112))).Unit;
            local l_BodyVelocity_0 = Instance.new("BodyVelocity");
            l_BodyVelocity_0.Name = "Fly";
            l_BodyVelocity_0.Parent = l_Part_0;
            l_BodyVelocity_0.P = 2000;
            l_BodyVelocity_0.MaxForce = Vector3.new(25000, 25000, 25000, 0);
            l_BodyVelocity_0.Velocity = l_Unit_0 * v103;
            task.delay(0.2, function() --[[ Line: 401 ]]
                -- upvalues: l_BodyVelocity_0 (copy), v104 (copy), l_TweenService_0 (ref), l_Part_0 (copy), v105 (copy)
                l_BodyVelocity_0:Destroy();
                task.wait(v104);
                l_TweenService_0:Create(l_Part_0, TweenInfo.new(v105, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Size = Vector3.new()
                }):Play();
                task.wait(1);
                l_Part_0:Destroy();
            end);
        end;
    end;
end;
v22.JuanGroundRock = function(v115, v116) --[[ Line: 412 ]] --[[ Name: JuanGroundRock ]]
    -- upvalues: v4 (copy), l_Debris_0 (copy), l_TweenService_0 (copy)
    local v117 = math.random(0, 30);
    local l_Position_5 = v115.Position;
    local l_RayParams_0 = v4.RayParams;
    local v120 = workspace:Raycast(v115.Position, Vector3.new(0, -25, 0, 0), l_RayParams_0);
    if v120 then
        local v121 = script.Rocks.Rock:Clone();
        local v122 = Vector3.new(v121.Size.X * Random.new():NextNumber(1, 2.25), v121.Size.Y * Random.new():NextNumber(1, 2.25), v121.Size.Z * Random.new():NextNumber(1, 1.9));
        l_Debris_0:AddItem(v121, 3);
        v121.CFrame = v115.CFrame * CFrame.new(-v116 * Random.new():NextNumber(1, 1.5), -v120.Distance, 0);
        v121.Size = Vector3.new(0, 0, 0, 0);
        v121.Parent = workspace.World.ClientEffects;
        v121.CFrame = CFrame.lookAt(v121.Position, l_Position_5) * CFrame.Angles(math.rad(v117), math.rad((math.random(-10, 10))), (math.rad((math.random(-10, 10)))));
        v121.BrickColor = BrickColor.new("Dark grey");
        v121.Material = Enum.Material.Concrete;
        v121.MaterialVariant = v120.Instance.MaterialVariant;
        l_TweenService_0:Create(v121, TweenInfo.new(0.3), {
            Size = v122
        }):Play();
        local v123 = 90 - v117;
        task.delay(1.7, function() --[[ Line: 433 ]]
            -- upvalues: l_TweenService_0 (ref), v121 (copy), v116 (copy), v123 (copy)
            l_TweenService_0:Create(v121, TweenInfo.new(1), {
                CFrame = v121.CFrame * CFrame.new(-(v116 * 2), -11.5, 0) * CFrame.Angles(math.rad(v123), 0, 0)
            }):Play();
        end);
    end;
end;
v22.throwRock = function(v124, v125, v126, v127) --[[ Line: 440 ]] --[[ Name: throwRock ]]
    -- upvalues: l_Debris_0 (copy), l_TweenService_0 (copy)
    v127 = v127 or 180;
    v125 = v125 or 2;
    v126 = v126 or 75;
    local v128 = script.Rocks["Rock" .. math.random(1, 3)]:Clone();
    v128.Size = v128.Size * Random.new():NextNumber(1.01, v125);
    v128.CanCollide = false;
    v128.CFrame = v124 * CFrame.new(math.random(-5, 5), math.random(0, 5), math.random(-5, 5)) * CFrame.Angles(math.rad((math.random(-v127, v127))), 0, (math.rad((math.random(-v127, v127)))));
    v128.Parent = workspace.World.ClientEffects;
    local l_BodyVelocity_1 = Instance.new("BodyVelocity");
    l_BodyVelocity_1.MaxForce = Vector3.new(100000000, 100000000, 100000000, 0);
    l_BodyVelocity_1.P = 1000;
    l_BodyVelocity_1.Velocity = v128.CFrame.UpVector * math.random(15, v126);
    l_BodyVelocity_1.Parent = v128;
    l_Debris_0:AddItem(l_BodyVelocity_1, 0.2);
    task.delay(0.1, function() --[[ Line: 457 ]]
        -- upvalues: v128 (copy)
        v128.CanCollide = true;
    end);
    task.delay(2, function() --[[ Line: 460 ]]
        -- upvalues: v128 (copy), l_TweenService_0 (ref), l_Debris_0 (ref)
        v128.Start.Trail.Enabled = false;
        l_TweenService_0:Create(v128, TweenInfo.new(0.5), {
            Size = Vector3.new(0, 0, 0, 0)
        }):Play();
        l_Debris_0:AddItem(v128, 0.5);
    end);
end;
v22.LeftRightRock = function(v130, v131, v132, v133) --[[ Line: 467 ]] --[[ Name: LeftRightRock ]]
    -- upvalues: v4 (copy), l_Debris_0 (copy), l_TweenService_0 (copy)
    v131 = -v131 or -25;
    local l_RayParams_1 = v4.RayParams;
    local v135 = workspace:Raycast(v130.Position, Vector3.new(0, v131, 0), l_RayParams_1);
    if v135 then
        local l_Part_1 = Instance.new("Part");
        l_Debris_0:AddItem(l_Part_1, 3);
        l_Part_1.Anchored = true;
        l_Part_1.CanCollide = true;
        l_Part_1.CFrame = CFrame.new(v135.Position, v135.Position + v135.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0);
        l_Part_1.Position = l_Part_1.Position + v130.CFrame.RightVector * v132;
        l_Part_1.Orientation = Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
        l_Part_1.Material = v135.Instance.Material;
        l_Part_1.MaterialVariant = v135.Instance.MaterialVariant;
        l_Part_1.Color = v135.Instance.Color;
        l_Part_1.Parent = workspace.World.ClientEffects;
        local v137 = l_Part_1:Clone();
        l_Debris_0:AddItem(v137, 3);
        v137.CFrame = CFrame.new(v135.Position, v135.Position + v135.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0);
        v137.Position = v137.Position + v130.CFrame.RightVector * -v132;
        v137.Orientation = Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
        v137.Parent = workspace.World.ClientEffects;
        l_TweenService_0:Create(l_Part_1, TweenInfo.new(0.2), {
            Size = Vector3.new(1, 1, 1, 0) * v133
        }):Play();
        l_TweenService_0:Create(v137, TweenInfo.new(0.2), {
            Size = Vector3.new(1, 1, 1, 0) * v133
        }):Play();
        task.delay(2.5, function() --[[ Line: 496 ]]
            -- upvalues: l_TweenService_0 (ref), l_Part_1 (copy), v137 (copy)
            l_TweenService_0:Create(l_Part_1, TweenInfo.new(0.5), {
                Size = Vector3.new(0, 0, 0, 0)
            }):Play();
            l_TweenService_0:Create(v137, TweenInfo.new(0.5), {
                Size = Vector3.new(0, 0, 0, 0)
            }):Play();
        end);
    end;
end;
v22.Crater = function(v138, v139, v140, v141, v142, v143, v144) --[[ Line: 503 ]] --[[ Name: Crater ]]
    -- upvalues: v4 (copy), l_Debris_0 (copy), l_TweenService_0 (copy)
    v142 = v142 or 1;
    v143 = v143 or 360;
    v144 = v144 or 0;
    v141 = v141 or 5;
    v139 = v139 or 12;
    v140 = v140 or -25;
    local l_RayParams_2 = v4.RayParams;
    local v146 = workspace:Raycast(v138.Position, Vector3.new(0, v140, 0), l_RayParams_2);
    local v147 = 0;
    if v146 then
        local l_Position_6 = (v138.CFrame * CFrame.new(0, -v146.Distance, -1)).Position;
        local v149 = script.Part:Clone();
        l_Debris_0:AddItem(v149, 1);
        v149.Anchored = true;
        v149.CanCollide = true;
        v149.CFrame = CFrame.new(v146.Position, v146.Position + v146.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0);
        v149.CFrame = CFrame.lookAt(v149.Position, l_Position_6) * CFrame.Angles(0, math.rad(v144), 0);
        v149.Parent = workspace.World.ClientEffects;
        for _ = 1, v139 do
            v149.CFrame = CFrame.lookAt(v149.Position, l_Position_6) * CFrame.Angles(0, math.rad(v144), 0) * CFrame.Angles(0, math.rad(v147), 0);
            local l_Part_2 = Instance.new("Part");
            l_Debris_0:AddItem(l_Part_2, 3);
            l_Part_2.Anchored = true;
            l_Part_2.CanCollide = true;
            l_Part_2.CFrame = v149.CFrame * CFrame.new(0, 0, -v141);
            l_Part_2.Orientation = Vector3.new(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
            l_Part_2.Material = v146.Instance.Material;
            l_Part_2.MaterialVariant = v146.Instance.MaterialVariant;
            l_Part_2.Color = v146.Instance.Color;
            l_Part_2.Parent = workspace.World.ClientEffects;
            v147 = v147 + v143 / v139;
            l_TweenService_0:Create(l_Part_2, TweenInfo.new(0.2), {
                Size = Vector3.new(1, 1, 1, 0) * v142
            }):Play();
            task.delay(2.5, function() --[[ Line: 544 ]]
                -- upvalues: l_TweenService_0 (ref), l_Part_2 (copy)
                l_TweenService_0:Create(l_Part_2, TweenInfo.new(0.5), {
                    Size = Vector3.new(0, 0, 0, 0)
                }):Play();
            end);
        end;
    end;
end;
v22.DecreaseBeamSize = function(v152, v153) --[[ Line: 552 ]] --[[ Name: DecreaseBeamSize ]]
    -- upvalues: l_TweenService_0 (copy)
    for _, v155 in next, v152:GetDescendants() do
        if v155:IsA("Beam") then
            l_TweenService_0:Create(v155, TweenInfo.new(v153), {
                Width0 = 0, 
                Width1 = 0
            }):Play();
        end;
    end;
end;
v22.CreateWeld = function(v156, v157) --[[ Line: 569 ]] --[[ Name: CreateWeld ]]
    local l_Weld_0 = Instance.new("Weld");
    l_Weld_0.Part0 = v156;
    l_Weld_0.Part1 = v157;
    l_Weld_0.Parent = v156;
    return l_Weld_0;
end;
v22.RememberParticleSize = function(v159) --[[ Line: 577 ]] --[[ Name: RememberParticleSize ]]
    -- upvalues: v9 (copy)
    for _, v161 in next, v159:GetDescendants() do
        if v161:IsA("ParticleEmitter") then
            v9[v161.Name] = v161.Size.Keypoints[2].Value;
        end;
    end;
end;
v22.UnRememberParticleSize = function(v162) --[[ Line: 585 ]] --[[ Name: UnRememberParticleSize ]]
    -- upvalues: v9 (copy)
    for _, v164 in next, v162:GetDescendants() do
        if v164:IsA("ParticleEmitter") then
            v9[v164.Name] = nil;
        end;
    end;
end;
v22.ScaleParticles = function(v165, v166) --[[ Line: 593 ]] --[[ Name: ScaleParticles ]]
    -- upvalues: v9 (copy)
    for _, v168 in next, v165:GetDescendants() do
        if v168:IsA("ParticleEmitter") then
            if v9[v168.Name] then
                local v169 = v9[v168.Name] + v166;
                v168.Size = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0), 
                    NumberSequenceKeypoint.new(1, v169)
                });
            else
                warn(v168.Name, "Has No Saved Scale Value");
            end;
        end;
    end;
end;
return v22;