-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local l_ConfirmToolPlacement_0 = l_PlayerGui_0.ConfirmToolPlacement;
local _ = require(l_ReplicatedStorage_0.Modules.EffectController.Libraries.BoatTween);
local l_LightningRodService_0 = l_ReplicatedStorage_0.GameEvents.LightningRodService;
local v9 = RaycastParams.new();
local v10 = {};
for _, v12 in workspace.Farm:GetChildren() do
    for _, v14 in v12.Important.Plant_Locations:GetChildren() do
        table.insert(v10, v14);
    end;
end;
v9.FilterDescendantsInstances = v10;
v9.FilterType = Enum.RaycastFilterType.Include;
local v15 = os.clock();
local l_Hit_0 = l_l_LocalPlayer_0_Mouse_0.Hit;
local l_Parent_0 = script.Parent;
local v18 = false;
local v19 = nil;
l_Parent_0.Equipped:Connect(function() --[[ Line: 33 ]]
    -- upvalues: v18 (ref), l_ConfirmToolPlacement_0 (copy), l_Parent_0 (copy), v15 (ref), l_ReplicatedStorage_0 (copy), v19 (ref), l_l_LocalPlayer_0_Mouse_0 (copy), v9 (copy)
    v18 = true;
    l_ConfirmToolPlacement_0:FindFirstChild("PlacingLabel", true).Text = ("Place %*?"):format(l_Parent_0:GetAttribute("ItemName"));
    v15 = os.clock();
    task.spawn(function() --[[ Line: 39 ]]
        -- upvalues: l_ReplicatedStorage_0 (ref), l_Parent_0 (ref), v19 (ref), v18 (ref), l_l_LocalPlayer_0_Mouse_0 (ref), v9 (ref)
		local v20 = l_ReplicatedStorage_0.ObjectModels[l_Parent_0:GetAttribute("ItemName")]:Clone();
        v20:RemoveTag("LightningRod");
        v20.Parent = workspace.Visuals;
        v20:PivotTo(CFrame.new(0, -55, 0));
        v19 = v20;
        for _, v22 in v20:GetDescendants() do
            if v22:IsA("BasePart") then
                v22.Transparency = 0.5;
                v22.CanQuery = false;
            end;
        end;
        while v18 do
            local l_Hit_1 = l_l_LocalPlayer_0_Mouse_0.Hit;
            local v24 = workspace:Raycast(l_Hit_1.Position + Vector3.new(0, 10, 0, 0), Vector3.new(-0, -20, -0, -0), v9);
            if v24 then
                local _, v26 = v20:GetBoundingBox();
                local v27 = v26.Y / 2 - 1;
                v20:PivotTo(CFrame.new(v24.Position) * CFrame.new(0, v27, 0));
            else
                v20:PivotTo(v20:GetPivot() * CFrame.new(0, -10, 0));
            end;
            task.wait();
        end;
        v20:Destroy();
    end);
end);
l_Parent_0.Unequipped:Connect(function() --[[ Line: 72 ]]
    -- upvalues: v18 (ref)
    v18 = false;
end);
local v28 = nil;
local _ = function() --[[ Line: 78 ]] --[[ Name: IsMouseOverUI ]]
    -- upvalues: l_PlayerGui_0 (copy), l_l_LocalPlayer_0_Mouse_0 (copy)
    for _, v30 in l_PlayerGui_0:GetGuiObjectsAtPosition(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y) do
        if v30.BackgroundTransparency ~= 1 and v30.Visible then
            return true;
        end;
    end;
end;
local function v41(v32) --[[ Line: 89 ]] --[[ Name: CheckDistance ]]
    -- upvalues: l_PlayerGui_0 (copy), l_l_LocalPlayer_0_Mouse_0 (copy), v9 (copy), l_ReplicatedStorage_0 (copy), l_LocalPlayer_0 (copy)
    local v33 = false;
    local v34;
    for _, v36 in l_PlayerGui_0:GetGuiObjectsAtPosition(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y) do
        if v36.BackgroundTransparency ~= 1 and v36.Visible then
            v34 = true;
            v33 = true;
        end;
        if v33 then
            break;
        end;
    end;
    if not v33 then
        v34 = nil;
    end;
    v33 = false;
    if v34 then
        return;
    else
        v34 = workspace:Raycast(v32.Position + Vector3.new(0, 10, 0, 0), Vector3.new(-0, -20, -0, -0), v9);
        if not v34 then
            require(l_ReplicatedStorage_0.Modules.Notification):CreateNotification("You can only place this in plots!");
            return false;
        else
            local l_Character_0 = l_LocalPlayer_0.Character;
            local v38 = l_Character_0 and l_Character_0:FindFirstChild("HumanoidRootPart");
            if not v38 then
                return false;
            elseif (v38.Position - v34.Position).Magnitude > 50 then
                require(l_ReplicatedStorage_0.Modules.Notification):CreateNotification("Too far away! Try getting closer.");
                return false;
            elseif v34.Instance.Parent.Parent.Data.Owner.Value == "" then
                require(l_ReplicatedStorage_0.Modules.Notification):CreateNotification("No one owns that plot! Cant place it here.");
                return false;
            else
                for _, v40 in game:GetService("CollectionService"):GetTagged("LightningRod") do
                    if v40:IsA("Model") and v40.PrimaryPart and (v40.PrimaryPart.Position - v34.Position).Magnitude < 30 then
                        require(l_ReplicatedStorage_0.Modules.Notification):CreateNotification("Too close to another rod!");
                        return false;
                    end;
                end;
                return v34;
            end;
        end;
    end;
end;
local function _(v42) --[[ Line: 130 ]] --[[ Name: AttemptPlacement ]]
    -- upvalues: l_Parent_0 (copy), v18 (ref), v41 (copy), v28 (ref), v19 (ref), l_LightningRodService_0 (copy)
    if not l_Parent_0 then
        return;
    elseif not v18 then
        return;
    elseif not v41(v42) then
        return;
    else
       -- v28:Disconnect();
       -- v18 = false;
        if v19 then
            v19:Destroy();
        end;
        l_LightningRodService_0:FireServer("Create", v42);
        return;
    end;
end;
local l_l_ConfirmToolPlacement_0_FirstChild_0 = l_ConfirmToolPlacement_0:FindFirstChild("Confirm", true);
local l_l_ConfirmToolPlacement_0_FirstChild_1 = l_ConfirmToolPlacement_0:FindFirstChild("Cancel", true);
l_l_ConfirmToolPlacement_0_FirstChild_0.MouseButton1Click:Connect(function() --[[ Line: 150 ]]
    -- upvalues: l_ConfirmToolPlacement_0 (copy), l_Hit_0 (ref), l_Parent_0 (copy), v18 (ref), v41 (copy), v28 (ref), v19 (ref), l_LightningRodService_0 (copy)
    l_ConfirmToolPlacement_0.Enabled = false;
    local l_l_Hit_0_0 = l_Hit_0;
    if not l_Parent_0 then
        return;
    elseif not v18 then
        return;
    elseif not v41(l_l_Hit_0_0) then
        return;
    else
        --v28:Disconnect();
        --v18 = false;
        if v19 then
            v19:Destroy();
        end;
        l_LightningRodService_0:FireServer("Create", l_l_Hit_0_0);
        return;
    end;
end);
l_l_ConfirmToolPlacement_0_FirstChild_1.MouseButton1Click:Connect(function() --[[ Line: 156 ]]
    -- upvalues: v15 (ref), l_ConfirmToolPlacement_0 (copy)
    v15 = os.clock();
    l_ConfirmToolPlacement_0.Enabled = false;
end);
v28 = if l_UserInputService_0.TouchEnabled then l_UserInputService_0.TouchTapInWorld:Connect(function() --[[ Line: 163 ]]
    -- upvalues: v18 (ref), v15 (ref), v41 (copy), l_l_LocalPlayer_0_Mouse_0 (copy), l_Hit_0 (ref), l_ConfirmToolPlacement_0 (copy)
    if not v18 or os.clock() < v15 + 0.1 or not v41(l_l_LocalPlayer_0_Mouse_0.Hit) then
        return;
    else
        v15 = os.clock();
        l_Hit_0 = l_l_LocalPlayer_0_Mouse_0.Hit;
        l_ConfirmToolPlacement_0.Enabled = true;
        return;
    end;
end) else l_UserInputService_0.InputBegan:Connect(function(v47) --[[ Line: 172 ]]
    -- upvalues: l_l_LocalPlayer_0_Mouse_0 (copy), l_Parent_0 (copy), v18 (ref), v41 (copy), v28 (ref), v19 (ref), l_LightningRodService_0 (copy)
    if v47.UserInputType ~= Enum.UserInputType.MouseButton1 and v47.KeyCode ~= Enum.KeyCode.ButtonR2 then
        return;
    else
        local l_Hit_2 = l_l_LocalPlayer_0_Mouse_0.Hit;
        if not l_Parent_0 then
            return;
        elseif not v18 then
            return;
        elseif not v41(l_Hit_2) then
            return;
        else
            --v28:Disconnect();
            --v18 = false;
            if v19 then
                v19:Destroy();
            end;
            l_LightningRodService_0:FireServer("Create", l_Hit_2);
            return;
        end;
    end;
end);