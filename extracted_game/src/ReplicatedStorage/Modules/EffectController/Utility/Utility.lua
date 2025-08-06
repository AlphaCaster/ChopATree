-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = {
    workspace
};
v0.RayParams = v1;
v0.AddItem = function(_, v3, v4) --[[ Line: 9 ]] --[[ Name: AddItem ]]
    task.delay(v4, function() --[[ Line: 10 ]]
        -- upvalues: v3 (copy)
        if v3.Parent ~= nil then
            v3:Destroy();
        end;
    end);
end;
v0.PlaySound = function(_, v6, v7) --[[ Line: 17 ]] --[[ Name: PlaySound ]]
    -- upvalues: v0 (copy)
    local v8 = v6:Clone();
    v8.Parent = v7;
    v8:Play();
    v0:AddItem(v8, v8.TimeLength);
    return v8;
end;
v0.WeldInPlace = function(_, v10, v11) --[[ Line: 27 ]] --[[ Name: WeldInPlace ]]
    if v10 == v11 then
        return;
    else
        local v12 = CFrame.new(v10.Position);
        local l_ManualWeld_0 = Instance.new("ManualWeld");
        l_ManualWeld_0.Part0 = v10;
        l_ManualWeld_0.Part1 = v11;
        l_ManualWeld_0.C0 = v10.CFrame:inverse() * v12;
        l_ManualWeld_0.C1 = v11.CFrame:inverse() * v12;
        l_ManualWeld_0.Parent = v10;
        l_ManualWeld_0.Name = "Weld";
        return l_ManualWeld_0;
    end;
end;
v0.CreateLockPart = function(_, v15, v16, v17, v18) --[[ Line: 40 ]] --[[ Name: CreateLockPart ]]
    v15:PivotTo(v16);
    local v19 = v18 and workspace.World.ClientEffects:FindFirstChild(v18);
    if not v19 then
        local v20 = script.LOCK:Clone();
        v20.Name = v18 or "LOCK";
        v20.Parent = workspace.World.Visuals;
        v20.Transparency = 1;
        v19 = v20;
    end;
    v19:PivotTo(v16);
    if v17 then
        task.delay(v17, v19.Destroy, v19);
    end;
    v19.Weld.part1 = v15;
    return v19;
end;
v0.Round = function(_, v22, v23, v24) --[[ Line: 67 ]] --[[ Name: Round ]]
    local v25 = v24 ^ v23;
    return math.floor(v22 * v25 + 0.5) / v25;
end;
v0.HasProperty = function(_, v27, v28) --[[ Line: 72 ]] --[[ Name: HasProperty ]]
    local l_status_0, _ = pcall(function() --[[ Line: 73 ]]
        -- upvalues: v27 (copy), v28 (copy)
        local _ = v27[v28];
    end);
    return l_status_0;
end;
return v0;