-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(v0) --[[ Line: 1 ]] --[[ Name: Radialize ]]
    local v1 = 70;
    local v2 = 0.5;
    local v3 = {};
    for _, v5 in v0:GetChildren() do
        if v5:IsA("Frame") then
            table.insert(v3, v5);
        end;
    end;
    table.sort(v3, function(v6, v7) --[[ Line: 12 ]]
        return v6.AbsoluteSize.X * v6.AbsoluteSize.Y < v7.AbsoluteSize.X * v7.AbsoluteSize.Y;
    end);
    local v8 = #v3;
    local v9 = 6.283185307179586 / v8;
    v2 = v2 + (v8 == 3 and 0.1 or 0);
    v1 = v1 + v8 * 5;
    for v10, v11 in v3 do
        local v12 = -1.5707963267948966 + (v10 - 1) * v9;
        local v13 = math.cos(v12) * v1;
        local v14 = math.sin(v12) * v1;
        v11.AnchorPoint = Vector2.new(0.5, 0.5);
        v11.Position = UDim2.new(0.5, v13, v2, v14);
    end;
end;