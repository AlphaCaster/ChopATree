-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(script.Parent.CameraShakeInstance);
local v14 = {
    Bump = function() --[[ Line: 26 ]] --[[ Name: Bump ]]
        -- upvalues: v0 (copy)
        local v1 = v0.new(2.5, 4, 0.1, 0.75);
        v1.PositionInfluence = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448, 0);
        v1.RotationInfluence = Vector3.new(1, 1, 1, 0);
        return v1;
    end, 
    Dash = function() --[[ Line: 35 ]] --[[ Name: Dash ]]
        -- upvalues: v0 (copy)
        local v2 = v0.new(1.5, 2, 0.1, 0.75);
        v2.PositionInfluence = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448, 0);
        v2.RotationInfluence = Vector3.new(1, 1, 1, 0);
        return v2;
    end, 
    Explosion = function() --[[ Line: 44 ]] --[[ Name: Explosion ]]
        -- upvalues: v0 (copy)
        local v3 = v0.new(1.75, 9, 0, 1.25);
        v3.PositionInfluence = Vector3.new(0.25, 0.25, 0.25, 0);
        v3.RotationInfluence = Vector3.new(4, 1, 1, 0);
        return v3;
    end, 
    BlowUp = function() --[[ Line: 53 ]] --[[ Name: BlowUp ]]
        -- upvalues: v0 (copy)
        local v4 = v0.new(5, 10, 0.05, 0.75);
        v4.PositionInfluence = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612, 0);
        v4.RotationInfluence = Vector3.new(1, 0.5, 0.8500000238418579, 0);
        return v4;
    end, 
    HeavilyHurt = function() --[[ Line: 63 ]] --[[ Name: HeavilyHurt ]]
        -- upvalues: v0 (copy)
        local v5 = v0.new(3, 8, 0.05, 0.85);
        v5.PositionInfluence = Vector3.new(0.18000000715255737, 0.15000000596046448, 0.15000000596046448, 0);
        v5.RotationInfluence = Vector3.new(0.8600000143051147, 0.5600000023841858, 0.6299999952316284, 0);
        return v5;
    end, 
    WindBreak = function() --[[ Line: 73 ]] --[[ Name: WindBreak ]]
        -- upvalues: v0 (copy)
        local v6 = v0.new(6, 5, 0.05, 0.5);
        v6.PositionInfluence = Vector3.new(0.07999999821186066, 0.07999999821186066, 0.07999999821186066, 0);
        v6.RotationInfluence = Vector3.new(0.44999998807907104, 0.30000001192092896, 0.3499999940395355, 0);
        return v6;
    end, 
    Shoot = function() --[[ Line: 83 ]] --[[ Name: Shoot ]]
        -- upvalues: v0 (copy)
        local v7 = v0.new(2, 6, 0.05, 0.65);
        v7.PositionInfluence = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.125, 0);
        v7.RotationInfluence = Vector3.new(0.6000000238418579, 0.6000000238418579, 0.6000000238418579, 0);
        return v7;
    end, 
    M1 = function() --[[ Line: 92 ]] --[[ Name: M1 ]]
        -- upvalues: v0 (copy)
        local v8 = v0.new(0.5, 6, 0.05, 0.65);
        v8.PositionInfluence = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.125, 0);
        v8.RotationInfluence = Vector3.new(0.6000000238418579, 0.6000000238418579, 0.6000000238418579, 0);
        return v8;
    end, 
    Earthquake = function() --[[ Line: 101 ]] --[[ Name: Earthquake ]]
        -- upvalues: v0 (copy)
        local v9 = v0.new(0.6, 3.5, 2, 10);
        v9.PositionInfluence = Vector3.new(0.25, 0.25, 0.25, 0);
        v9.RotationInfluence = Vector3.new(1, 1, 4, 0);
        return v9;
    end, 
    BadTrip = function() --[[ Line: 111 ]] --[[ Name: BadTrip ]]
        -- upvalues: v0 (copy)
        local v10 = v0.new(10, 0.15, 5, 10);
        v10.PositionInfluence = Vector3.new(0, 0, 0.15000000596046448, 0);
        v10.RotationInfluence = Vector3.new(2, 1, 4, 0);
        return v10;
    end, 
    HandheldCamera = function() --[[ Line: 121 ]] --[[ Name: HandheldCamera ]]
        -- upvalues: v0 (copy)
        local v11 = v0.new(1, 0.25, 5, 10);
        v11.PositionInfluence = Vector3.new(0, 0, 0, 0);
        v11.RotationInfluence = Vector3.new(1, 0.5, 0.5, 0);
        return v11;
    end, 
    Vibration = function() --[[ Line: 131 ]] --[[ Name: Vibration ]]
        -- upvalues: v0 (copy)
        local v12 = v0.new(2, 20, 0, 0.2);
        v12.PositionInfluence = Vector3.new(0.25, 0.15000000596046448, 0, 0);
        v12.RotationInfluence = Vector3.new(1.25, 0, 4, 0);
        return v12;
    end, 
    RoughDriving = function() --[[ Line: 141 ]] --[[ Name: RoughDriving ]]
        -- upvalues: v0 (copy)
        local v13 = v0.new(1, 2, 1, 1);
        v13.PositionInfluence = Vector3.new(0, 0, 0, 0);
        v13.RotationInfluence = Vector3.new(1, 1, 1, 0);
        return v13;
    end
};
return (setmetatable({}, {
    __index = function(_, v16) --[[ Line: 153 ]] --[[ Name: __index ]]
        -- upvalues: v14 (copy)
        local v17 = v14[v16];
        if type(v17) == "function" then
            return v17();
        else
            error("No preset found with index \"" .. v16 .. "\"");
            return;
        end;
    end
}));