-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(game.ReplicatedStorage.Data.GearData);
local function v7(v1) --[[ Line: 2 ]] --[[ Name: NewCollectable ]]
    -- upvalues: v0 (copy)
    local l_v1_Attribute_0 = v1:GetAttribute("RewardType");
    if v1:GetAttribute("Owner") ~= nil and v1:GetAttribute("Owner") ~= game.Players.LocalPlayer.Name then
        return;
    else
        local v3 = game.ReplicatedStorage.RewardDropVisual:Clone();
        v3.Value.Value = v1;
        for _, v5 in v3.BillboardGui:GetChildren() do
            v5.Visible = false;
        end;
        if l_v1_Attribute_0 == "Coins" then
            v3.BillboardGui.Coins.Visible = true;
        elseif l_v1_Attribute_0 == "Seeds" then
            v3.BillboardGui.Seeds.SeedColour.ImageColor3 = game.ReplicatedStorage.Seed_Models:FindFirstChild(v1:GetAttribute("KeySeed")).Color;
            v3.BillboardGui.Seeds.Visible = true;
        elseif l_v1_Attribute_0 == "SeedPack" then
            task.spawn(function() --[[ Line: 22 ]]
                -- upvalues: v3 (copy)
                while v3.Value.Value and v3.Value.Value:IsDescendantOf(workspace) do
                    local v6 = tick() % 2 / 2;
                    v3.BillboardGui.Seeds.SeedColour.ImageColor3 = Color3.fromHSV(v6, 1, 1);
                    task.wait();
                end;
            end);
            v3.BillboardGui.Seeds.Visible = true;
        elseif l_v1_Attribute_0 == "Items" then
            if v0[v1:GetAttribute("GearName")] then
                v3.BillboardGui.Gear.Image = v0[v1:GetAttribute("GearName")].Asset;
            end;
            v3.BillboardGui.Gear.Visible = true;
        end;
        v3.CFrame = CFrame.new(v1.CFrame.p) * CFrame.new(0, 0.5, 0);
        v3.Parent = workspace;
        v3:AddTag("CollectionVisual");
        return;
    end;
end;
task.spawn(function() --[[ Line: 46 ]]
    while true do
        local _ = game:GetService("RunService").RenderStepped:Wait();
        local v9 = {};
        local v10 = {};
        for _, v12 in game.CollectionService:GetTagged("CollectionVisual") do
            if v12.Value.Value == nil or not v12.Value.Value:IsDescendantOf(workspace) then
                v12:Destroy();
            else
                local v13 = (math.sin(tick() * 3.141592653589793) + 1) / 2;
                table.insert(v10, CFrame.new(v12.Value.Value.CFrame.Position) * CFrame.new(0, v13 * 1 + 0.5, 0));
                table.insert(v9, v12);
            end;
        end;
        workspace:BulkMoveTo(v9, v10, Enum.BulkMoveMode.FireCFrameChanged);
    end;
end);
for _, v15 in game.CollectionService:GetTagged("Collectable") do
    v7(v15);
end;
game.CollectionService:GetInstanceAddedSignal("Collectable"):Connect(v7);
local function v22(v16) --[[ Line: 76 ]] --[[ Name: NewVisualDrop ]]
    -- upvalues: v0 (copy)
    local l_RewardType_0 = v16.RewardType;
    local v18 = game.ReplicatedStorage.RewardDropVisual:Clone();
    for _, v20 in v18.BillboardGui:GetChildren() do
        v20.Visible = false;
    end;
    if l_RewardType_0 == "Coins" then
        v18.BillboardGui.Coins.Visible = true;
        return v18;
    elseif l_RewardType_0 == "Seeds" then
        v18.BillboardGui.Seeds.SeedColour.ImageColor3 = game.ReplicatedStorage.Seed_Models:FindFirstChild(v16.KeySeed).Color;
        v18.BillboardGui.Seeds.Visible = true;
        return v18;
    elseif l_RewardType_0 == "SeedPack" then
        task.spawn(function() --[[ Line: 92 ]]
            -- upvalues: v18 (copy)
            while v18 and v18:IsDescendantOf(workspace) do
                local v21 = tick() % 2 / 2;
                v18.BillboardGui.Seeds.SeedColour.ImageColor3 = Color3.fromHSV(v21, 1, 1);
                task.wait();
            end;
        end);
        v18.BillboardGui.Seeds.Visible = true;
        return v18;
    else
        if l_RewardType_0 == "Items" then
            if v0[v16.GearName] then
                v18.BillboardGui.Gear.Image = v0[v16.GearName].Asset;
            end;
            v18.BillboardGui.Gear.Visible = true;
        end;
        return v18;
    end;
end;
local v23 = require(game.ReplicatedStorage.Code.Bezier);
game.ReplicatedStorage.GameEvents.FireDrop.OnClientEvent:Connect(function(v24, v25) --[[ Line: 114 ]]
    -- upvalues: v22 (copy), v23 (copy)
    local v26 = v22(v24);
    v26.CFrame = v25;
    v26.Parent = workspace;
    local v27 = 0;
    while v27 < 0.5 do
        v27 = v27 + game:GetService("RunService").Heartbeat:Wait();
        local l_Position_0 = game.Players.LocalPlayer.Character.PrimaryPart.Position;
        local v29 = (v25.p + l_Position_0) / 2 + Vector3.new(0, v25.p.Y + 7, 0);
        local v30 = v23.new(v25.Position, v29, l_Position_0):Get((game.TweenService:GetValue(v27 / 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)));
        v26.CFrame = CFrame.new(v30);
    end;
    v26:Destroy();
    local v31 = game.Workspace.Terrain.PopEffect:Clone();
    v31.Parent = workspace.Terrain;
    v31.CFrame = CFrame.new(game.Players.LocalPlayer.Character.PrimaryPart.Position);
    for _, v33 in v31:GetChildren() do
        v33:Emit(1);
    end;
    game.Debris:AddItem(v31, 2);
    game.SoundService:PlayLocalSound(game.SoundService.Rainbow);
end);