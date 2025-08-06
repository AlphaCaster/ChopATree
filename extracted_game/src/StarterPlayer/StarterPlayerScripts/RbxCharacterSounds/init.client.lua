-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_SoundService_0 = game:GetService("SoundService");
local l_AtomicBinding_0 = require(script:WaitForChild("AtomicBinding"));
local function _(v4) --[[ Line: 12 ]] --[[ Name: loadFlag ]]
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 13 ]]
        -- upvalues: v4 (copy)
        return UserSettings():IsUserFeatureEnabled(v4);
    end);
    return l_status_0 and l_result_0;
end;
local l_pcall_0 = pcall;
local v9 = "UserSoundsUseRelativeVelocity2";
local l_v9_0 = v9 --[[ copy: 8 -> 29 ]];
local v11;
l_pcall_0, v11 = l_pcall_0(function() --[[ Line: 13 ]]
    -- upvalues: l_v9_0 (copy)
    return UserSettings():IsUserFeatureEnabled(l_v9_0);
end);
local v12 = l_pcall_0 and v11;
v11 = pcall;
local v13 = "UserFixFreeFallingSound";
local l_v13_0 = v13 --[[ copy: 9 -> 30 ]];
v11, v9 = v11(function() --[[ Line: 13 ]]
    -- upvalues: l_v13_0 (copy)
    return UserSettings():IsUserFeatureEnabled(l_v13_0);
end);
l_pcall_0 = v11 and v9;
v9 = pcall;
local v15 = "UserNewCharacterSoundsApi3";
local l_v15_0 = v15 --[[ copy: 10 -> 31 ]];
v9, v13 = v9(function() --[[ Line: 13 ]]
    -- upvalues: l_v15_0 (copy)
    return UserSettings():IsUserFeatureEnabled(l_v15_0);
end);
v11 = v9 and v13;
v9 = {
    Climbing = {
        SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3", 
        Looped = true
    }, 
    Died = {
        SoundId = "rbxasset://sounds/uuhhh.mp3"
    }, 
    FreeFalling = {
        SoundId = l_pcall_0 and "rbxasset://sounds/action_falling.ogg" or "rbxasset://sounds/action_falling.mp3", 
        Looped = true
    }, 
    GettingUp = {
        SoundId = "rbxasset://sounds/action_get_up.mp3"
    }, 
    Jumping = {
        SoundId = "rbxasset://sounds/action_jump.mp3"
    }, 
    Landing = {
        SoundId = "rbxasset://sounds/action_jump_land.mp3"
    }, 
    Running = {
        SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3", 
        Looped = true, 
        Pitch = 1.85
    }, 
    Splash = {
        SoundId = "rbxasset://sounds/impact_water.mp3"
    }, 
    Swimming = {
        SoundId = "rbxasset://sounds/action_swim.mp3", 
        Looped = true, 
        Pitch = 1.6
    }
};
v13 = {
    Climbing = {
        AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3", 
        Looping = true
    }, 
    Died = {
        AssetId = "rbxasset://sounds/uuhhh.mp3"
    }, 
    FreeFalling = {
        AssetId = l_pcall_0 and "rbxasset://sounds/action_falling.ogg" or "rbxasset://sounds/action_falling.mp3", 
        Looping = true
    }, 
    GettingUp = {
        AssetId = "rbxasset://sounds/action_get_up.mp3"
    }, 
    Jumping = {
        AssetId = "rbxasset://sounds/action_jump.mp3"
    }, 
    Landing = {
        AssetId = "rbxasset://sounds/action_jump_land.mp3"
    }, 
    Running = {
        AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3", 
        Looping = true, 
        PlaybackSpeed = 1.85
    }, 
    Splash = {
        AssetId = "rbxasset://sounds/impact_water.mp3"
    }, 
    Swimming = {
        AssetId = "rbxasset://sounds/action_swim.mp3", 
        Looping = true, 
        PlaybackSpeed = 1.6
    }
};
v15 = function(v17, v18, v19, v20, v21) --[[ Line: 100 ]] --[[ Name: map ]]
    return (v17 - v18) * (v21 - v20) / (v19 - v18) + v20;
end;
local function v25(v22, v23) --[[ Line: 104 ]] --[[ Name: getRelativeVelocity ]]
    if not v22 then
        return v23;
    else
        local v24 = v22.ActiveController and (v22.ActiveController:IsA("GroundController") and v22.GroundSensor or v22.ActiveController:IsA("ClimbController") and v22.ClimbSensor);
        if v24 and v24.SensedPart then
            return v23 - v24.SensedPart:GetVelocityAtPosition(v22.RootPart.Position);
        else
            return v23;
        end;
    end;
end;
local function _(v26, v27) --[[ Line: 121 ]] --[[ Name: playSound ]]
    -- upvalues: v11 (copy)
    if not v27 then
        v26.TimePosition = 0;
    end;
    if v11 and v26:IsA("AudioPlayer") then
        v26:Play();
        return;
    else
        v26.Playing = true;
        return;
    end;
end;
local function _(v29) --[[ Line: 132 ]] --[[ Name: stopSound ]]
    -- upvalues: v11 (copy)
    if v11 and v29:IsA("AudioPlayer") then
        v29:Stop();
        return;
    else
        v29.Playing = false;
        return;
    end;
end;
local function _(v31, v32) --[[ Line: 140 ]] --[[ Name: playSoundIf ]]
    -- upvalues: v11 (copy)
    if v11 and v31:IsA("AudioPlayer") then
        if v31.IsPlaying and not v32 then
            v31:Stop();
            return;
        elseif not v31.IsPlaying and v32 then
            v31:Play();
            return;
        end;
    else
        v31.Playing = v32;
    end;
end;
local function _(v34, v35) --[[ Line: 152 ]] --[[ Name: setSoundLooped ]]
    -- upvalues: v11 (copy)
    if v11 and v34:IsA("AudioPlayer") then
        v34.Looping = v35;
        return;
    else
        v34.Looped = v35;
        return;
    end;
end;
local function _(v37) --[[ Line: 160 ]] --[[ Name: shallowCopy ]]
    local v38 = {};
    for v39, v40 in pairs(v37) do
        v38[v39] = v40;
    end;
    return v38;
end;
local v113 = l_AtomicBinding_0.new({
    humanoid = "Humanoid", 
    rootPart = "HumanoidRootPart"
}, function(v42) --[[ Line: 168 ]] --[[ Name: initializeSoundSystem ]]
    -- upvalues: v12 (copy), v11 (copy), l_SoundService_0 (copy), l_Players_0 (copy), v13 (copy), v9 (copy), l_pcall_0 (copy), v25 (copy), l_RunService_0 (copy)
    local l_humanoid_0 = v42.humanoid;
    local l_rootPart_0 = v42.rootPart;
    local v45 = nil;
    local v46 = nil;
    if v12 then
        v46 = l_humanoid_0.Parent:FindFirstChild("ControllerManager");
    end;
    local v47 = {};
    if v11 and l_SoundService_0.CharacterSoundsUseNewApi == Enum.RolloutState.Enabled then
        local l_Character_0 = l_Players_0.LocalPlayer.Character;
        local v49 = {};
        local v50 = 5;
        while v50 < 150 do
            v49[v50] = 5 / v50;
            v50 = v50 * 1.25;
        end;
        v49[150] = 0;
        v45 = Instance.new("AudioEmitter", l_Character_0);
        v45.Name = "RbxCharacterSoundsEmitter";
        v45:SetDistanceAttenuation(v49);
        for v51, v52 in pairs(v13) do
            local l_AudioPlayer_0 = Instance.new("AudioPlayer");
            local l_Wire_0 = Instance.new("Wire");
            l_AudioPlayer_0.Name = v51;
            l_Wire_0.Name = v51 .. "Wire";
            l_AudioPlayer_0.Archivable = false;
            l_AudioPlayer_0.Volume = 0.65;
            for v55, v56 in pairs(v52) do
                l_AudioPlayer_0[v55] = v56;
            end;
            l_AudioPlayer_0.Parent = l_rootPart_0;
            l_Wire_0.Parent = l_AudioPlayer_0;
            l_Wire_0.SourceInstance = l_AudioPlayer_0;
            l_Wire_0.TargetInstance = v45;
            v47[v51] = l_AudioPlayer_0;
        end;
    else
        for v57, v58 in pairs(v9) do
            local l_Sound_0 = Instance.new("Sound");
            l_Sound_0.Name = v57;
            l_Sound_0.Archivable = false;
            l_Sound_0.RollOffMinDistance = 5;
            l_Sound_0.RollOffMaxDistance = 150;
            l_Sound_0.Volume = 0.65;
            for v60, v61 in pairs(v58) do
                l_Sound_0[v60] = v61;
            end;
            l_Sound_0.Parent = l_rootPart_0;
            v47[v57] = l_Sound_0;
        end;
    end;
    local v62 = {};
    local function v70(v63) --[[ Line: 233 ]] --[[ Name: stopPlayingLoopedSounds ]]
        -- upvalues: v62 (copy), v11 (ref)
        v63 = v63 or nil;
        local l_pairs_0 = pairs;
        local l_v62_0 = v62;
        local v66 = {};
        for v67, v68 in pairs(l_v62_0) do
            v66[v67] = v68;
        end;
        for v69 in l_pairs_0(v66) do
            if v69 ~= v63 then
                if v11 and v69:IsA("AudioPlayer") then
                    v69:Stop();
                else
                    v69.Playing = false;
                end;
                v62[v69] = nil;
            end;
        end;
    end;
    local v83 = {
        [Enum.HumanoidStateType.FallingDown] = function() --[[ Line: 245 ]]
            -- upvalues: v70 (copy)
            v70();
        end, 
        [Enum.HumanoidStateType.GettingUp] = function() --[[ Line: 249 ]]
            -- upvalues: v70 (copy), v47 (copy), v11 (ref)
            v70();
            local l_GettingUp_0 = v47.GettingUp;
            l_GettingUp_0.TimePosition = 0;
            if v11 and l_GettingUp_0:IsA("AudioPlayer") then
                l_GettingUp_0:Play();
                return;
            else
                l_GettingUp_0.Playing = true;
                return;
            end;
        end, 
        [Enum.HumanoidStateType.Jumping] = function() --[[ Line: 254 ]]
            -- upvalues: v70 (copy), v47 (copy), v11 (ref)
            v70();
            local l_Jumping_0 = v47.Jumping;
            l_Jumping_0.TimePosition = 0;
            if v11 and l_Jumping_0:IsA("AudioPlayer") then
                l_Jumping_0:Play();
                return;
            else
                l_Jumping_0.Playing = true;
                return;
            end;
        end, 
        [Enum.HumanoidStateType.Swimming] = function() --[[ Line: 259 ]]
            -- upvalues: l_rootPart_0 (copy), v47 (copy), v11 (ref), v70 (copy), v62 (copy)
            local v73 = math.abs(l_rootPart_0.AssemblyLinearVelocity.Y);
            if v73 > 0.1 then
                v47.Splash.Volume = math.clamp((v73 - 100) * 0.72 / 250 + 0.28, 0, 1);
                local l_Splash_0 = v47.Splash;
                l_Splash_0.TimePosition = 0;
                if v11 and l_Splash_0:IsA("AudioPlayer") then
                    l_Splash_0:Play();
                else
                    l_Splash_0.Playing = true;
                end;
            end;
            v70(v47.Swimming);
            local l_Swimming_0 = v47.Swimming;
            if v11 and l_Swimming_0:IsA("AudioPlayer") then
                l_Swimming_0:Play();
            else
                l_Swimming_0.Playing = true;
            end;
            v62[v47.Swimming] = true;
        end, 
        [Enum.HumanoidStateType.Freefall] = function() --[[ Line: 270 ]]
            -- upvalues: v47 (copy), v70 (copy), l_pcall_0 (ref), v11 (ref), v62 (copy)
            v47.FreeFalling.Volume = 0;
            v70(v47.FreeFalling);
            if l_pcall_0 then
                local l_FreeFalling_0 = v47.FreeFalling;
                if v11 and l_FreeFalling_0:IsA("AudioPlayer") then
                    l_FreeFalling_0.Looping = true;
                else
                    l_FreeFalling_0.Looped = true;
                end;
                if v47.FreeFalling:IsA("Sound") then
                    v47.FreeFalling.PlaybackRegionsEnabled = true;
                end;
                v47.FreeFalling.LoopRegion = NumberRange.new(2, 9);
                l_FreeFalling_0 = v47.FreeFalling;
                l_FreeFalling_0.TimePosition = 0;
                if v11 and l_FreeFalling_0:IsA("AudioPlayer") then
                    l_FreeFalling_0:Play();
                else
                    l_FreeFalling_0.Playing = true;
                end;
            end;
            v62[v47.FreeFalling] = true;
        end, 
        [Enum.HumanoidStateType.Landed] = function() --[[ Line: 284 ]]
            -- upvalues: v70 (copy), l_rootPart_0 (copy), v47 (copy), v11 (ref)
            v70();
            local v77 = math.abs(l_rootPart_0.AssemblyLinearVelocity.Y);
            if v77 > 75 then
                v47.Landing.Volume = math.clamp((v77 - 50) * 1 / 50 + 0, 0, 1);
                local l_Landing_0 = v47.Landing;
                l_Landing_0.TimePosition = 0;
                if v11 and l_Landing_0:IsA("AudioPlayer") then
                    l_Landing_0:Play();
                    return;
                else
                    l_Landing_0.Playing = true;
                end;
            end;
        end, 
        [Enum.HumanoidStateType.Running] = function() --[[ Line: 293 ]]
            -- upvalues: v70 (copy), v47 (copy), v11 (ref), v62 (copy)
            v70(v47.Running);
            local l_Running_0 = v47.Running;
            if v11 and l_Running_0:IsA("AudioPlayer") then
                l_Running_0:Play();
            else
                l_Running_0.Playing = true;
            end;
            v62[v47.Running] = true;
        end, 
        [Enum.HumanoidStateType.Climbing] = function() --[[ Line: 299 ]]
            -- upvalues: v47 (copy), l_rootPart_0 (copy), v12 (ref), v25 (ref), v46 (ref), v11 (ref), v70 (copy), v62 (copy)
            local l_Climbing_0 = v47.Climbing;
            local l_AssemblyLinearVelocity_0 = l_rootPart_0.AssemblyLinearVelocity;
            if math.abs((if v12 then v25(v46, l_AssemblyLinearVelocity_0) else l_AssemblyLinearVelocity_0).Y) > 0.1 then
                if v11 and l_Climbing_0:IsA("AudioPlayer") then
                    l_Climbing_0:Play();
                else
                    l_Climbing_0.Playing = true;
                end;
                v70(l_Climbing_0);
            else
                v70();
            end;
            v62[l_Climbing_0] = true;
        end, 
        [Enum.HumanoidStateType.Seated] = function() --[[ Line: 312 ]]
            -- upvalues: v70 (copy)
            v70();
        end, 
        [Enum.HumanoidStateType.Dead] = function() --[[ Line: 316 ]]
            -- upvalues: v70 (copy), v47 (copy), v11 (ref)
            v70();
            local l_Died_0 = v47.Died;
            l_Died_0.TimePosition = 0;
            if v11 and l_Died_0:IsA("AudioPlayer") then
                l_Died_0:Play();
                return;
            else
                l_Died_0.Playing = true;
                return;
            end;
        end
    };
    local v95 = {
        [v47.Climbing] = function(_, v85, v86) --[[ Line: 324 ]]
            -- upvalues: v12 (ref), v25 (ref), v46 (ref), v11 (ref)
            local v87 = (if v12 then v25(v46, v86) else v86).Magnitude > 0.1;
            if v11 and v85:IsA("AudioPlayer") then
                if v85.IsPlaying and not v87 then
                    v85:Stop();
                    return;
                elseif not v85.IsPlaying and v87 then
                    v85:Play();
                    return;
                end;
            else
                v85.Playing = v87;
            end;
        end, 
        [v47.FreeFalling] = function(v88, v89, v90) --[[ Line: 329 ]]
            if v90.Magnitude > 75 then
                v89.Volume = math.clamp(v89.Volume + v88 * 0.9, 0, 1);
                return;
            else
                v89.Volume = 0;
                return;
            end;
        end, 
        [v47.Running] = function(_, v92, v93) --[[ Line: 337 ]]
            -- upvalues: l_humanoid_0 (copy), v11 (ref)
            local v94 = false;
            if v93.Magnitude > 0.5 then
                v94 = l_humanoid_0.MoveDirection.Magnitude > 0.5;
            end;
            if v11 and v92:IsA("AudioPlayer") then
                if v92.IsPlaying and not v94 then
                    v92:Stop();
                    return;
                elseif not v92.IsPlaying and v94 then
                    v92:Play();
                    return;
                end;
            else
                v92.Playing = v94;
            end;
        end
    };
    local v96 = {
        [Enum.HumanoidStateType.RunningNoPhysics] = Enum.HumanoidStateType.Running
    };
    local v97 = v96[l_humanoid_0:GetState()] or l_humanoid_0:GetState();
    local function _(v98) --[[ Line: 349 ]] --[[ Name: transitionTo ]]
        -- upvalues: v83 (copy), v97 (ref)
        local v99 = v83[v98];
        if v99 then
            v99();
        end;
        v97 = v98;
    end;
    local l_v97_0 = v97;
    local v102 = v83[l_v97_0];
    if v102 then
        v102();
    end;
    v97 = l_v97_0;
    l_v97_0 = l_humanoid_0.StateChanged:Connect(function(_, v104) --[[ Line: 361 ]]
        -- upvalues: v96 (copy), v97 (ref), v83 (copy)
        v104 = v96[v104] or v104;
        if v104 ~= v97 then
            local l_v104_0 = v104;
            local v106 = v83[l_v104_0];
            if v106 then
                v106();
            end;
            v97 = l_v104_0;
        end;
    end);
    v102 = l_RunService_0.Stepped:Connect(function(_, v108) --[[ Line: 369 ]]
        -- upvalues: v62 (copy), v95 (copy), l_rootPart_0 (copy)
        for v109 in pairs(v62) do
            local v110 = v95[v109];
            if v110 then
                v110(v108, v109, l_rootPart_0.AssemblyLinearVelocity);
            end;
        end;
    end);
    return function() --[[ Line: 380 ]] --[[ Name: terminate ]]
        -- upvalues: l_v97_0 (copy), v102 (copy), v47 (copy)
        l_v97_0:Disconnect();
        v102:Disconnect();
        for _, v112 in pairs(v47) do
            v112:Destroy();
        end;
        table.clear(v47);
    end;
end);
local v114 = {};
local function v116(v115) --[[ Line: 403 ]] --[[ Name: characterAdded ]]
    -- upvalues: v113 (copy)
    v113:bindRoot(v115);
end;
local function v118(v117) --[[ Line: 407 ]] --[[ Name: characterRemoving ]]
    -- upvalues: v113 (copy)
    v113:unbindRoot(v117);
end;
local function v122(v119) --[[ Line: 411 ]] --[[ Name: playerAdded ]]
    -- upvalues: v114 (copy), v113 (copy), v116 (copy), v118 (copy)
    local v120 = v114[v119];
    if not v120 then
        v120 = {};
        v114[v119] = v120;
    end;
    if v119.Character then
        local l_Character_1 = v119.Character;
        v113:bindRoot(l_Character_1);
    end;
    table.insert(v120, v119.CharacterAdded:Connect(v116));
    table.insert(v120, v119.CharacterRemoving:Connect(v118));
end;
local function v128(v123) --[[ Line: 425 ]] --[[ Name: playerRemoving ]]
    -- upvalues: v114 (copy), v113 (copy)
    local v124 = v114[v123];
    if v124 then
        for _, v126 in ipairs(v124) do
            v126:Disconnect();
        end;
        v114[v123] = nil;
    end;
    if v123.Character then
        local l_Character_2 = v123.Character;
        v113:unbindRoot(l_Character_2);
    end;
end;
for _, v130 in ipairs(l_Players_0:GetPlayers()) do
    task.spawn(v122, v130);
end;
l_Players_0.PlayerAdded:Connect(v122);
l_Players_0.PlayerRemoving:Connect(v128);