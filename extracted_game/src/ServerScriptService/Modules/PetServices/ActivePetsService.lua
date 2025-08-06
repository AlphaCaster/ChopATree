-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local _ = l_ReplicatedStorage_0:WaitForChild("Assets"):WaitForChild("Models"):WaitForChild("PetAssets");
local _ = require(l_ReplicatedStorage_0.Modules.ExponentialScaler);
local v5 = require(l_ReplicatedStorage_0.Modules.ReplicationClass);
local l_PetList_0 = require(l_ReplicatedStorage_0.Data.PetRegistry).PetList;
local l_ActivePetService_0 = l_ReplicatedStorage_0:WaitForChild("GameEvents"):WaitForChild("ActivePetService");
local v8 = v5.new("ActivePetsService_Replicator");
local _ = v8:YieldUntilData();
local v10 = require(l_ReplicatedStorage_0.Modules.GetFarm);
local function _() --[[ Line: 23 ]] --[[ Name: GetReplicatedData ]]
    -- upvalues: v8 (copy)
    return v8:YieldUntilData().Table;
end;
local v12 = {};
local v13 = {};
v12.PetObjectRegistry = v13;
local function _(v14, v15) --[[ Line: 31 ]] --[[ Name: WeldInPlace ]]
    local l_Weld_0 = Instance.new("Weld");
    l_Weld_0.Part0 = v14;
    l_Weld_0.Part1 = v15;
    l_Weld_0.Name = "Weld";
    l_Weld_0.Parent = v15;
    l_Weld_0.Name = ("%*_%*_WELD"):format(v14.Name, v15.Name);
    return l_Weld_0;
end;
local function _(v18) --[[ Line: 44 ]] --[[ Name: GetClientPetState ]]
    -- upvalues: v13 (copy)
    local v19 = v13[v18];
    if not v19 then
        v19 = {};
        v13[v18] = v19;
    end;
    return v19;
end;
local function v34(v21, v22) --[[ Line: 55 ]] --[[ Name: GetPet ]]
    -- upvalues: v13 (copy), l_Players_0 (copy), v10 (copy), v8 (copy), l_PetList_0 (copy)
    local v23 = v13[v21];
    if not v23 then
        v23 = {};
        v13[v21] = v23;
    end;
    local l_v23_0 = v23;
    v23 = l_v23_0[v22];
    local l_l_Players_0_FirstChild_0 = l_Players_0:FindFirstChild(v21);
    if not l_l_Players_0_FirstChild_0 then
        return;
    else
        local v26 = v10(l_l_Players_0_FirstChild_0);
        if not v23 then
            local l_Part_0 = Instance.new("Part");
            l_Part_0.Size = Vector3.new(3, 3, 3, 0);
            l_Part_0.Shape = Enum.PartType.Ball;
            l_Part_0.Transparency = 1;
            l_Part_0.Material = Enum.Material.Glass;
            l_Part_0.BrickColor = BrickColor.random();
            l_Part_0.Anchored = true;
            l_Part_0.CanQuery = false;
            l_Part_0:AddTag("PetTargetable");
            l_Part_0:SetAttribute("UUID", v22);
            l_Part_0:SetAttribute("OWNER", v21);
            l_Part_0.Name = "PetMover";
            l_Part_0.CanCollide = false;
            local v28 = l_PetList_0[v8:YieldUntilData().Table.PlayerPetData[v21].PetInventory.Data[v22].PetType];
            local v29 = v28 and v28.Model;
            local v30 = v29 and v29:Clone();
            if v30 then
                local l_PrimaryPart_0 = v30.PrimaryPart;
                local l_Weld_1 = Instance.new("Weld");
                l_Weld_1.Part0 = l_PrimaryPart_0;
                l_Weld_1.Part1 = l_Part_0;
                l_Weld_1.Name = "Weld";
                l_Weld_1.Parent = l_Part_0;
                l_Weld_1.Name = ("%*_%*_WELD"):format(l_PrimaryPart_0.Name, l_Part_0.Name);
                local l_l_Weld_1_0 = l_Weld_1;
                l_l_Weld_1_0.C1 = l_l_Weld_1_0.C1 * v28.WeldOffset;
                v30.Parent = l_Part_0;
            end;
            l_Part_0:PivotTo(v26:FindFirstChild("PetArea").CFrame);
            l_Part_0.Parent = workspace.CurrentCamera;
            l_v23_0[v22] = {
                Asset = l_Part_0
            };
        end;
        return v23;
    end;
end;
local function _(v35, v36) --[[ Line: 114 ]] --[[ Name: RemovePet ]]
    -- upvalues: v13 (copy)
    local v37 = v13[v35];
    if not v37 then
        v37 = {};
        v13[v35] = v37;
    end;
    local l_v37_0 = v37;
    v37 = l_v37_0[v36];
    if v37 then
        v37.Asset:Destroy();
    end;
    l_v37_0[v36] = nil;
end;
local function _(v40) --[[ Line: 125 ]] --[[ Name: RemoveClientPetState ]]
    -- upvalues: v13 (copy)
    local v41 = v13[v40];
    if not v41 then
        v41 = {};
        v13[v40] = v41;
    end;
    local l_v41_0 = v41;
    if l_v41_0 then
        for v43 in l_v41_0 do
            local v44 = v13[v40];
            if not v44 then
                v44 = {};
                v13[v40] = v44;
            end;
            local l_v44_0 = v44;
            v44 = l_v44_0[v43];
            if v44 then
                v44.Asset:Destroy();
            end;
            l_v44_0[v43] = nil;
        end;
    end;
    v13[v40] = nil;
end;
local function v62() --[[ Line: 137 ]] --[[ Name: UpdateRegistry ]]
    -- upvalues: v8 (copy), v13 (copy), v34 (copy)
    local l_ActivePetStates_0 = v8:YieldUntilData().Table.ActivePetStates;
    for v48, v49 in v13 do
        local v50 = l_ActivePetStates_0[v48];
        if not v50 then
            local v51 = v13[v48];
            if not v51 then
                v51 = {};
                v13[v48] = v51;
            end;
            local l_v51_0 = v51;
            if l_v51_0 then
                for v53 in l_v51_0 do
                    local v54 = v13[v48];
                    if not v54 then
                        v54 = {};
                        v13[v48] = v54;
                    end;
                    local l_v54_0 = v54;
                    v54 = l_v54_0[v53];
                    if v54 then
                        v54.Asset:Destroy();
                    end;
                    l_v54_0[v53] = nil;
                end;
            end;
            v13[v48] = nil;
        else
            for v56 in v49 do
                if not v50[v56] then
                    local v57 = v13[v48];
                    if not v57 then
                        v57 = {};
                        v13[v48] = v57;
                    end;
                    local l_v57_0 = v57;
                    v57 = l_v57_0[v56];
                    if v57 then
                        v57.Asset:Destroy();
                    end;
                    l_v57_0[v56] = nil;
                end;
            end;
        end;
    end;
    for v59, v60 in l_ActivePetStates_0 do
        for v61 in v60 do
            v34(v59, v61);
        end;
    end;
end;
local _ = workspace.Baseplate;
local function _(v64, v65) --[[ Line: 166 ]] --[[ Name: GetLookAt ]]
    return (CFrame.new(v64.Position, (Vector3.new(v65.X, v64.Position.Y, v65.Z))));
end;
local function v88(v67) --[[ Line: 172 ]] --[[ Name: UpdatePositioning ]]
    -- upvalues: v8 (copy), v13 (copy), l_PetList_0 (copy)
    local l_ActivePetStates_1 = v8:YieldUntilData().Table.ActivePetStates;
    local v69 = {};
    local v70 = {};
    local v71 = 0;
    for v72, v73 in v13 do
        local v74 = l_ActivePetStates_1[v72];
        if v74 then
            for v75, v76 in v73 do
                local v77 = v74[v75];
                if v77 then
                    local l_Asset_0 = v76.Asset;
                    local l_CurrentCFrame_0 = v77.CurrentCFrame;
                    local v80 = l_CurrentCFrame_0.Position - l_Asset_0.Position;
                    local l_Magnitude_0 = v80.Magnitude;
                    if l_Magnitude_0 >= 0.5 then
                        local v82 = math.min(l_Magnitude_0, 6 * v67);
                        local v83 = l_Asset_0.Position + v80.Unit * v82;
                        local l_Position_0 = l_CurrentCFrame_0.Position;
                        local v85 = CFrame.new(l_Asset_0.Position, (Vector3.new(l_Position_0.X, l_Asset_0.Position.Y, l_Position_0.Z)));
                        v71 = v71 + 1;
                        v69[v71] = l_Asset_0;
                        l_Position_0 = l_Asset_0:FindFirstChildWhichIsA("Model", true);
                        local v86 = v8:YieldUntilData().Table.PlayerPetData[v72].PetInventory.Data[v75];
                        local l_Size_0 = l_Position_0.PrimaryPart.Size;
                        l_Position_0:ScaleTo(1 + l_PetList_0[v86.PetType].ModelScalePerLevel * v86.PetData.Level);
                        v70[v71] = CFrame.new(v83.X, 0 + l_Size_0.Y / 2, v83.Z) * CFrame.Angles(v85:ToEulerAnglesXYZ());
                    end;
                end;
            end;
        end;
    end;
    workspace:BulkMoveTo(v69, v70, Enum.BulkMoveMode.FireCFrameChanged);
end;
task.spawn(function() --[[ Line: 229 ]]
    -- upvalues: l_RunService_0 (copy), v88 (copy)
    while true do
        local v89 = task.wait(0.01) + l_RunService_0.RenderStepped:Wait();
        v88(v89);
    end;
end);
v12.GetServerState = function(_, v91, v92) --[[ Line: 237 ]] --[[ Name: GetServerState ]]
    -- upvalues: v8 (copy)
    local v93 = v8:YieldUntilData().Table.ActivePetStates[v91];
    if not v93 then
        return;
    else
        return v93[v92];
    end;
end;
v12.GetPetData = function(_, v95, v96) --[[ Line: 247 ]] --[[ Name: GetPetData ]]
    -- upvalues: v8 (copy)
    local v97 = v8:YieldUntilData().Table.PlayerPetData[v95];
    if not v97 then
        return;
    else
        return v97.PetInventory.Data[v96];
    end;
end;
v12.GetPetDataFromPetObject = function(_, v99) --[[ Line: 259 ]] --[[ Name: GetPetDataFromPetObject ]]
    -- upvalues: v12 (copy)
    local l_v99_Attribute_0 = v99:GetAttribute("OWNER");
    local l_v99_Attribute_1 = v99:GetAttribute("UUID");
    return v12:GetPetData(l_v99_Attribute_0, l_v99_Attribute_1);
end;
v12.SetPetState = function(_, v103, v104, v105) --[[ Line: 265 ]] --[[ Name: SetPetState ]]
    -- upvalues: l_ActivePetService_0 (copy)
    l_ActivePetService_0:FireServer("SetPetState", v103, v104, v105);
end;
v12.GetClientPetState = function(_, v107) --[[ Line: 269 ]] --[[ Name: GetClientPetState ]]
    -- upvalues: v13 (copy)
    local v108 = v13[v107];
    if not v108 then
        v108 = {};
        v13[v107] = v108;
    end;
    return v108;
end;
v12.Feed = function(_, v110) --[[ Line: 273 ]] --[[ Name: Feed ]]
    -- upvalues: l_ActivePetService_0 (copy)
    l_ActivePetService_0:FireServer("Feed", v110);
end;
v8:GetPathSignal("ActivePetStates/@"):Connect(function(...) --[[ Line: 279 ]]
    -- upvalues: v62 (copy)
    v62();
end);
return v12;