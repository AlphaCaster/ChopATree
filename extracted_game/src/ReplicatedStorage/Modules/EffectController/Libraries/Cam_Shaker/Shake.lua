-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local v2 = require(l_ReplicatedStorage_0.Modules.Trove);
local v3 = Random.new();
local v4 = 0;
local v5 = {};
v5.new = function() --[[ Line: 179 ]] --[[ Name: new ]]
    -- upvalues: v5 (copy), l_RunService_0 (copy), v3 (copy), v2 (copy)
    local v6 = setmetatable({}, {
        __index = v5
    });
    v6.Amplitude = 1;
    v6.Frequency = 1;
    v6.FadeInTime = 1;
    v6.FadeOutTime = 1;
    v6.SustainTime = 0;
    v6.Sustain = false;
    v6.PositionInfluence = Vector3.new(1, 1, 1, 0);
    v6.RotationInfluence = Vector3.new(1, 1, 1, 0);
    v6.TimeFunction = if l_RunService_0:IsRunning() then time else os.clock;
    v6._timeOffset = v3:NextNumber(-1000000000, 1000000000);
    v6._startTime = 0;
    v6._trove = v2.new();
    v6._trove:Add(function() --[[ Line: 198 ]]
        -- upvalues: v6 (copy)
        if v6 and getmetatable(v6) ~= nil then
            getmetatable(v6).__mode = "kv";
        end;
    end);
    v6._running = false;
    return v6;
end;
v5.InverseSquare = function(v7, v8) --[[ Line: 240 ]] --[[ Name: InverseSquare ]]
    if v8 < 1 then
        v8 = 1;
    end;
    return v7 * (1 / (v8 * v8));
end;
v5.NextRenderName = function() --[[ Line: 256 ]] --[[ Name: NextRenderName ]]
    -- upvalues: v4 (ref)
    v4 = v4 + 1;
    return ("__shake_%.4i__"):format(v4);
end;
v5.Start = function(v9) --[[ Line: 269 ]] --[[ Name: Start ]]
    v9._startTime = v9.TimeFunction();
    v9._running = true;
    v9._trove:Add(function() --[[ Line: 272 ]]
        -- upvalues: v9 (copy)
        v9._running = false;
    end);
end;
v5.Stop = function(v10) --[[ Line: 284 ]] --[[ Name: Stop ]]
    if v10._trove then
        v10._trove:Clean();
    end;
end;
v5.IsShaking = function(v11) --[[ Line: 294 ]] --[[ Name: IsShaking ]]
    return v11._running;
end;
v5.StopSustain = function(v12) --[[ Line: 303 ]] --[[ Name: StopSustain ]]
    local v13 = v12.TimeFunction();
    v12.Sustain = false;
    v12.SustainTime = v13 - v12._startTime - v12.FadeInTime;
end;
v5.Update = function(v14, v15) --[[ Line: 331 ]] --[[ Name: Update ]]
    local v16 = false;
    local v17 = v14.TimeFunction();
    local v18 = v17 - v14._startTime;
    local v19 = (v17 + v14._timeOffset) / v14.Frequency % 1000000;
    local v20 = 1;
    local v21 = 1;
    if v18 < v14.FadeInTime then
        v20 = v18 / v14.FadeInTime;
    end;
    if not v14.Sustain and v14.FadeInTime + v14.SustainTime < v18 then
        if v14.FadeOutTime == 0 then
            v16 = true;
        else
            v21 = 1 - (v18 - v14.FadeInTime - v14.SustainTime) / v14.FadeOutTime;
            if not v14.Sustain and v14.FadeInTime + v14.SustainTime + v14.FadeOutTime <= v18 then
                v16 = true;
            end;
        end;
    end;
    local v22 = v15 * 80 * 1.25;
    local v23 = Vector3.new(math.noise(v19, 0) / 2, math.noise(0, v19) / 2, math.noise(v19, v19) / 2) * (v14.Amplitude * v22) * math.min(v20, v21);
    if v16 then
        v14:Stop();
    end;
    return v14.PositionInfluence * v23, v14.RotationInfluence * v23, v16;
end;
v5.OnSignal = function(v24, v25, v26) --[[ Line: 389 ]] --[[ Name: OnSignal ]]
    return v24._trove:Connect(v25, function() --[[ Line: 390 ]]
        -- upvalues: v26 (copy), v24 (copy)
        v26(v24:Update());
    end);
end;
v5.BindToRenderStep = function(v27, v28, v29, v30) --[[ Line: 415 ]] --[[ Name: BindToRenderStep ]]
    v27._trove:BindToRenderStep(v28, v29, function(v31) --[[ Line: 416 ]]
        -- upvalues: v30 (copy), v27 (copy)
        v30(v27:Update(v31));
    end);
end;
v5.Clone = function(v32) --[[ Line: 450 ]] --[[ Name: Clone ]]
    -- upvalues: v5 (copy)
    local v33 = v5.new();
    for _, v35 in {
        "Amplitude", 
        "Frequency", 
        "FadeInTime", 
        "FadeOutTime", 
        "SustainTime", 
        "Sustain", 
        "PositionInfluence", 
        "RotationInfluence", 
        "TimeFunction"
    } do
        v33[v35] = v32[v35];
    end;
    return v33;
end;
v5.Destroy = function(v36) --[[ Line: 472 ]] --[[ Name: Destroy ]]
    v36:Stop();
end;
return v5;