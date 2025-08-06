-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Shake_0 = require(script:WaitForChild("Shake"));
local l_CurrentCamera_0 = workspace.CurrentCamera;
local l_Settings_0 = require(script:WaitForChild("Settings"));
local l_DD_0 = l_Settings_0.DD;
local l_Min_Distance_0 = l_Settings_0.Min_Distance;
local l_Check_Can_Shake_0 = function() return true end;
local v6 = {
    punch_shake = {
        FadeInTime = 0, 
        Frequency = 0.05, 
        Amplitude = 0.35, 
        SustainTime = 0.145, 
        FadeOutTime = 0.15, 
        RotationInfluence = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612, 0), 
        PositionInfluence = Vector3.new(0.4000000059604645, 0.4000000059604645, 0.4000000059604645, 0)
    }, 
    tiny_shake = {
        FadeInTime = 0, 
        Frequency = 0.07, 
        Amplitude = 0.25, 
        SustainTime = 0.05, 
        FadeOutTime = 0.2, 
        RotationInfluence = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612, 0), 
        PositionInfluence = Vector3.new(0.5, 0.5, 0.5, 0)
    }, 
    tiny_shake_less_aggresive = {
        FadeInTime = 0, 
        Frequency = 0.15, 
        Amplitude = 0.25, 
        SustainTime = 0.1, 
        FadeOutTime = 0.3, 
        RotationInfluence = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612, 0), 
        PositionInfluence = Vector3.new(0.5, 0.5, 0.5, 0)
    }, 
    medium_shake = {
        FadeInTime = 0, 
        Frequency = 0.055, 
        Amplitude = 0.98, 
        SustainTime = 0.14, 
        FadeOutTime = 0.5, 
        RotationInfluence = Vector3.new(0.25, 0.25, 0.25, 0), 
        PositionInfluence = Vector3.new(3.5, 3.5, 3.5, 0)
    }, 
    medium_shake_longer = {
        FadeInTime = 0, 
        Frequency = 0.1, 
        Amplitude = 0.4, 
        SustainTime = 0.9, 
        FadeOutTime = 0.75, 
        RotationInfluence = Vector3.new(0.25, 0.25, 0.25, 0), 
        PositionInfluence = Vector3.new(3.5, 3.5, 3.5, 0)
    }, 
    medium_tiny_shake = {
        FadeInTime = 0, 
        Frequency = 0.1, 
        Amplitude = 0.5, 
        SustainTime = 0.14, 
        FadeOutTime = 0.5, 
        RotationInfluence = Vector3.new(0.25, 0.25, 0.25, 0), 
        PositionInfluence = Vector3.new(3.5, 3.5, 3.5, 0)
    }, 
    medium_tiny_shake2 = {
        FadeInTime = 0, 
        Frequency = 0.15, 
        Amplitude = 0.4, 
        SustainTime = 0.14, 
        FadeOutTime = 0.5, 
        RotationInfluence = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448, 0), 
        PositionInfluence = Vector3.new(1, 1, 1, 0)
    }, 
    activate_shake_less_aggresive = {
        FadeInTime = 0, 
        Frequency = 0.22, 
        Amplitude = 0.1, 
        SustainTime = 0.2, 
        FadeOutTime = 0.4, 
        RotationInfluence = Vector3.new(0.25, 0.25, 0.25, 0), 
        PositionInfluence = Vector3.new(0.5, 0.5, 0.5, 0)
    }, 
    activate_shake = {
        FadeInTime = 0, 
        Frequency = 0.15, 
        Amplitude = 0.25, 
        SustainTime = 0.1, 
        FadeOutTime = 0.5, 
        RotationInfluence = Vector3.new(0.25, 0.25, 0.25, 0), 
        PositionInfluence = Vector3.new(1, 1, 1, 0)
    }
};
local l_typeof_0 = typeof;
return function(v8, v9) --[[ Line: 93 ]]
    -- upvalues: l_Check_Can_Shake_0 (copy), l_typeof_0 (copy), v6 (copy), l_Shake_0 (copy), l_CurrentCamera_0 (copy), l_Min_Distance_0 (copy), l_DD_0 (copy)
    if l_Check_Can_Shake_0() ~= true then
        return;
    else
        if v8 ~= nil and v9 == nil then
            v9 = v8;
            v8 = nil;
        end;
        if l_typeof_0(v9) ~= "table" and v6[v9] then
            v9 = v6[v9];
        end;
        if v9 == nil then
            return;
        elseif l_typeof_0(v9) ~= "table" then
            return;
        else
            local l_Value_0 = Enum.RenderPriority.Camera.Value;
            local v11 = l_Shake_0.new();
            if v9 then
                for v12, v13 in pairs(v9) do
                    v11[v12] = v13;
                end;
            end;
            v11:Start();
            v11:BindToRenderStep(l_Shake_0.NextRenderName(), l_Value_0, function(v14, v15, v16) --[[ Line: 129 ]]
                -- upvalues: v11 (copy), v8 (ref), l_CurrentCamera_0 (ref), l_Min_Distance_0 (ref), l_DD_0 (ref)
                local v17 = v11.center_pos or v8;
                if typeof(v8) == "BasePart" or typeof(v8) == "Part" then
                    v17 = v8.Position;
                end;
                if v17 ~= nil then
                    local v18 = math.clamp((l_CurrentCamera_0.CFrame.Position - v17).Magnitude, l_Min_Distance_0, 999999);
                    v14 = v11.InverseSquare(v14, v18) * l_DD_0;
                    v15 = v11.InverseSquare(v15, v18) * l_DD_0;
                end;
                local l_l_CurrentCamera_0_0 = l_CurrentCamera_0;
                l_l_CurrentCamera_0_0.CFrame = l_l_CurrentCamera_0_0.CFrame * (CFrame.new(v14) * CFrame.Angles(v15.X, v15.Y, v15.Z));
                if v16 == true then
                    v11:Stop();
                    v11:Destroy();
                end;
            end);
            return v11;
        end;
    end;
end;