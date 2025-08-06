-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_RunService_0 = game:GetService("RunService");
local v1 = require(script.TweenFunctions);
local v2 = require(script.Lerps);
local v3 = {};
local v4 = {
    Heartbeat = true, 
    Stepped = true, 
    RenderStepped = true
};
if not l_RunService_0:IsClient() then
    v4.RenderStepped = nil;
end;
local v5 = {
    FabricAccelerate = {
        In = v1.InFabricAccelerate, 
        Out = v1.OutFabricAccelerate, 
        InOut = v1.InOutFabricAccelerate, 
        OutIn = v1.OutInFabricAccelerate
    }, 
    UWPAccelerate = {
        In = v1.InUWPAccelerate, 
        Out = v1.OutUWPAccelerate, 
        InOut = v1.InOutUWPAccelerate, 
        OutIn = v1.OutInUWPAccelerate
    }, 
    Circ = {
        In = v1.InCirc, 
        Out = v1.OutCirc, 
        InOut = v1.InOutCirc, 
        OutIn = v1.OutInCirc
    }, 
    RevBack = {
        In = v1.InRevBack, 
        Out = v1.OutRevBack, 
        InOut = v1.InOutRevBack, 
        OutIn = v1.OutInRevBack
    }, 
    Spring = {
        In = v1.InSpring, 
        Out = v1.OutSpring, 
        InOut = v1.InOutSpring, 
        OutIn = v1.OutInSpring
    }, 
    Standard = {
        In = v1.InStandard, 
        Out = v1.OutStandard, 
        InOut = v1.InOutStandard, 
        OutIn = v1.OutInStandard
    }, 
    StandardExpressive = {
        In = v1.InStandardExpressive, 
        Out = v1.OutStandardExpressive, 
        InOut = v1.InOutStandardExpressive, 
        OutIn = v1.OutInStandardExpressive
    }, 
    Linear = {
        In = v1.InLinear, 
        Out = v1.OutLinear, 
        InOut = v1.InOutLinear, 
        OutIn = v1.OutInLinear
    }, 
    ExitProductive = {
        In = v1.InExitProductive, 
        Out = v1.OutExitProductive, 
        InOut = v1.InOutExitProductive, 
        OutIn = v1.OutInExitProductive
    }, 
    Deceleration = {
        In = v1.InDeceleration, 
        Out = v1.OutDeceleration, 
        InOut = v1.InOutDeceleration, 
        OutIn = v1.OutInDeceleration
    }, 
    Smoother = {
        In = v1.InSmoother, 
        Out = v1.OutSmoother, 
        InOut = v1.InOutSmoother, 
        OutIn = v1.OutInSmoother
    }, 
    FabricStandard = {
        In = v1.InFabricStandard, 
        Out = v1.OutFabricStandard, 
        InOut = v1.InOutFabricStandard, 
        OutIn = v1.OutInFabricStandard
    }, 
    RidiculousWiggle = {
        In = v1.InRidiculousWiggle, 
        Out = v1.OutRidiculousWiggle, 
        InOut = v1.InOutRidiculousWiggle, 
        OutIn = v1.OutInRidiculousWiggle
    }, 
    MozillaCurve = {
        In = v1.InMozillaCurve, 
        Out = v1.OutMozillaCurve, 
        InOut = v1.InOutMozillaCurve, 
        OutIn = v1.OutInMozillaCurve
    }, 
    Expo = {
        In = v1.InExpo, 
        Out = v1.OutExpo, 
        InOut = v1.InOutExpo, 
        OutIn = v1.OutInExpo
    }, 
    Sine = {
        In = v1.InSine, 
        Out = v1.OutSine, 
        InOut = v1.InOutSine, 
        OutIn = v1.OutInSine
    }, 
    Cubic = {
        In = v1.InCubic, 
        Out = v1.OutCubic, 
        InOut = v1.InOutCubic, 
        OutIn = v1.OutInCubic
    }, 
    EntranceExpressive = {
        In = v1.InEntranceExpressive, 
        Out = v1.OutEntranceExpressive, 
        InOut = v1.InOutEntranceExpressive, 
        OutIn = v1.OutInEntranceExpressive
    }, 
    Elastic = {
        In = v1.InElastic, 
        Out = v1.OutElastic, 
        InOut = v1.InOutElastic, 
        OutIn = v1.OutInElastic
    }, 
    Quint = {
        In = v1.InQuint, 
        Out = v1.OutQuint, 
        InOut = v1.InOutQuint, 
        OutIn = v1.OutInQuint
    }, 
    EntranceProductive = {
        In = v1.InEntranceProductive, 
        Out = v1.OutEntranceProductive, 
        InOut = v1.InOutEntranceProductive, 
        OutIn = v1.OutInEntranceProductive
    }, 
    Bounce = {
        In = v1.InBounce, 
        Out = v1.OutBounce, 
        InOut = v1.InOutBounce, 
        OutIn = v1.OutInBounce
    }, 
    Smooth = {
        In = v1.InSmooth, 
        Out = v1.OutSmooth, 
        InOut = v1.InOutSmooth, 
        OutIn = v1.OutInSmooth
    }, 
    Back = {
        In = v1.InBack, 
        Out = v1.OutBack, 
        InOut = v1.InOutBack, 
        OutIn = v1.OutInBack
    }, 
    Quart = {
        In = v1.InQuart, 
        Out = v1.OutQuart, 
        InOut = v1.InOutQuart, 
        OutIn = v1.OutInQuart
    }, 
    StandardProductive = {
        In = v1.InStandardProductive, 
        Out = v1.OutStandardProductive, 
        InOut = v1.InOutStandardProductive, 
        OutIn = v1.OutInStandardProductive
    }, 
    Quad = {
        In = v1.InQuad, 
        Out = v1.OutQuad, 
        InOut = v1.InOutQuad, 
        OutIn = v1.OutInQuad
    }, 
    FabricDecelerate = {
        In = v1.InFabricDecelerate, 
        Out = v1.OutFabricDecelerate, 
        InOut = v1.InOutFabricDecelerate, 
        OutIn = v1.OutInFabricDecelerate
    }, 
    Acceleration = {
        In = v1.InAcceleration, 
        Out = v1.OutAcceleration, 
        InOut = v1.InOutAcceleration, 
        OutIn = v1.OutInAcceleration
    }, 
    SoftSpring = {
        In = v1.InSoftSpring, 
        Out = v1.OutSoftSpring, 
        InOut = v1.InOutSoftSpring, 
        OutIn = v1.OutInSoftSpring
    }, 
    ExitExpressive = {
        In = v1.InExitExpressive, 
        Out = v1.OutExitExpressive, 
        InOut = v1.InOutExitExpressive, 
        OutIn = v1.OutInExitExpressive
    }, 
    Sharp = {
        In = v1.InSharp, 
        Out = v1.OutSharp, 
        InOut = v1.InOutSharp, 
        OutIn = v1.OutInSharp
    }
};
v3.Create = function(_, v7, v8) --[[ Line: 315 ]] --[[ Name: Create ]]
    -- upvalues: v4 (copy), l_RunService_0 (copy), v5 (copy), v2 (copy)
    if not v7 or typeof(v7) ~= "Instance" then
        return warn("Invalid object to tween:", v7);
    else
        v8 = type(v8) == "table" and v8 or {};
        local v9 = v4[v8.StepType] and l_RunService_0[v8.StepType] or l_RunService_0.Stepped;
        local v10 = v5[v8.EasingStyle or "Quad"][v8.EasingDirection or "In"];
        local v11 = math.max(type(v8.Time) == "number" and v8.Time or 1, 0.001);
        local v12 = type(v8.Goal) == "table" and v8.Goal or {};
        local v13 = false;
        if type(v8.DelayTime) == "number" then
            v13 = false;
            if v8.DelayTime > 0.027 then
                v13 = v8.DelayTime;
            end;
        end;
        local v14 = (type(v8.RepeatCount) == "number" and math.max(v8.RepeatCount, -1) or 0) + 1;
        local v15 = {};
        for v16, v17 in pairs(v12) do
            v15[v16] = v2[typeof(v17)](v7[v16], v17);
        end;
        local l_BindableEvent_0 = Instance.new("BindableEvent");
        local l_BindableEvent_1 = Instance.new("BindableEvent");
        local l_BindableEvent_2 = Instance.new("BindableEvent");
        local v21 = nil;
        local v22 = os.clock();
        local v23 = 0;
        local v24 = {
            Instance = v7, 
            PlaybackState = Enum.PlaybackState.Begin, 
            Completed = l_BindableEvent_0.Event, 
            Resumed = l_BindableEvent_2.Event, 
            Stopped = l_BindableEvent_1.Event
        };
        v24.Destroy = function() --[[ Line: 353 ]] --[[ Name: Destroy ]]
            -- upvalues: v21 (ref), l_BindableEvent_0 (copy), l_BindableEvent_1 (copy), l_BindableEvent_2 (copy), v24 (ref)
            if v21 then
                v21:Disconnect();
                v21 = nil;
            end;
            l_BindableEvent_0:Destroy();
            l_BindableEvent_1:Destroy();
            l_BindableEvent_2:Destroy();
            v24 = {};
        end;
        local v25 = false;
        local v26 = 0;
        local function v27(v28, v29) --[[ Line: 369 ]] --[[ Name: Play ]]
            -- upvalues: v21 (ref), v14 (copy), v24 (ref), l_BindableEvent_0 (copy), v25 (ref), v26 (ref), v13 (copy), v22 (ref), v23 (ref), v9 (copy), v11 (copy), v15 (copy), v7 (copy), v27 (copy), v8 (ref), v10 (copy)
            if v21 then
                v21:Disconnect();
                v21 = nil;
            end;
            v28 = v28 or 1;
            if v14 ~= 0 and v14 < v28 then
                v24.PlaybackState = Enum.PlaybackState.Completed;
                l_BindableEvent_0:Fire();
                v25 = false;
                v26 = 1;
                return;
            else
                v26 = v28;
                if v29 then
                    v25 = true;
                end;
                if v13 then
                    v24.PlaybackState = Enum.PlaybackState.Delayed;
                    task.wait(v13);
                end;
                v22 = os.clock() - v23;
                v21 = v9:Connect(function() --[[ Line: 399 ]]
                    -- upvalues: v23 (ref), v22 (ref), v11 (ref), v29 (copy), v15 (ref), v7 (ref), v21 (ref), v27 (ref), v28 (ref), v8 (ref), v10 (ref)
                    v23 = os.clock() - v22;
                    if v11 <= v23 then
                        if v29 then
                            for v30, v31 in pairs(v15) do
                                v7[v30] = v31(0);
                            end;
                        else
                            for v32, v33 in pairs(v15) do
                                v7[v32] = v33(1);
                            end;
                        end;
                        v21:Disconnect();
                        v21 = nil;
                        if v29 then
                            v23 = 0;
                            v27(v28 + 1, false);
                            return;
                        elseif v8.Reverses then
                            v23 = 0;
                            v27(v28, true);
                            return;
                        else
                            v23 = 0;
                            v27(v28 + 1, false);
                            return;
                        end;
                    else
                        local v34 = v29 and 1 - v23 / v11 or v23 / v11;
                        local v35 = math.clamp(v10(v34), 0, 1);
                        for v36, v37 in pairs(v15) do
                            v7[v36] = v37(v35);
                        end;
                        return;
                    end;
                end);
                v24.PlaybackState = Enum.PlaybackState.Playing;
                return;
            end;
        end;
        v24.Play = function() --[[ Line: 439 ]] --[[ Name: Play ]]
            -- upvalues: v23 (ref), v27 (copy)
            v23 = 0;
            v27(1, false);
        end;
        v24.Stop = function() --[[ Line: 444 ]] --[[ Name: Stop ]]
            -- upvalues: v21 (ref), v24 (ref), l_BindableEvent_1 (copy)
            if v21 then
                v21:Disconnect();
                v21 = nil;
                v24.PlaybackState = Enum.PlaybackState.Cancelled;
                l_BindableEvent_1:Fire();
            end;
        end;
        v24.Resume = function() --[[ Line: 453 ]] --[[ Name: Resume ]]
            -- upvalues: v27 (copy), v26 (ref), v25 (ref), l_BindableEvent_2 (copy)
            v27(v26, v25);
            l_BindableEvent_2:Fire();
        end;
        return v24;
    end;
end;
return v3;