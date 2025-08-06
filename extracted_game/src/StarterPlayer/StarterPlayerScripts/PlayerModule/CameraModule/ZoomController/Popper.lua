-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_CommonUtils_0 = script.Parent.Parent.Parent:WaitForChild("CommonUtils");
local l_FlagUtil_0 = require(l_CommonUtils_0:WaitForChild("FlagUtil"));
local l_CameraWrapper_0 = require(l_CommonUtils_0:WaitForChild("CameraWrapper"));
local v4 = l_FlagUtil_0.getUserFlag("UserRaycastUpdateAPI");
local v5 = l_FlagUtil_0.getUserFlag("UserCurrentCameraUpdate2");
local v6 = if v5 then l_CameraWrapper_0.new() else nil;
local v7 = if v5 then nil else game.Workspace.CurrentCamera;
if v5 then
    v6:Enable();
end;
local l_min_0 = math.min;
local l_tan_0 = math.tan;
local l_rad_0 = math.rad;
local l_new_0 = Ray.new;
local v12 = RaycastParams.new();
v12.IgnoreWater = true;
v12.FilterType = Enum.RaycastFilterType.Exclude;
local v13 = RaycastParams.new();
v13.IgnoreWater = true;
v13.FilterType = Enum.RaycastFilterType.Include;
local function _(v14) --[[ Line: 38 ]] --[[ Name: getTotalTransparency ]]
    return 1 - (1 - v14.Transparency) * (1 - v14.LocalTransparencyModifier);
end;
local function _(v16, v17) --[[ Line: 42 ]] --[[ Name: eraseFromEnd ]]
    for v18 = #v16, v17 + 1, -1 do
        v16[v18] = nil;
    end;
end;
local v20 = nil;
local v21 = nil;
local v22 = nil;
if v5 then
    local function v27() --[[ Line: 52 ]] --[[ Name: updateProjection ]]
        -- upvalues: v6 (copy), l_rad_0 (copy), v22 (ref), l_tan_0 (copy), v21 (ref)
        local v23 = v6:getCamera();
        local v24 = l_rad_0(v23.FieldOfView);
        local l_ViewportSize_0 = v23.ViewportSize;
        local v26 = l_ViewportSize_0.X / l_ViewportSize_0.Y;
        v22 = l_tan_0(v24 / 2) * 2;
        v21 = v26 * v22;
    end;
    v6:Connect("FieldOfView", v27);
    v6:Connect("ViewportSize", v27);
    local v28 = v6:getCamera();
    local v29 = l_rad_0(v28.FieldOfView);
    local l_ViewportSize_1 = v28.ViewportSize;
    local v31 = l_ViewportSize_1.X / l_ViewportSize_1.Y;
    v22 = l_tan_0(v29 / 2) * 2;
    v21 = v31 * v22;
    v20 = v6:getCamera().NearPlaneZ;
    v6:Connect("NearPlaneZ", function() --[[ Line: 68 ]]
        -- upvalues: v20 (ref), v6 (copy)
        v20 = v6:getCamera().NearPlaneZ;
    end);
else
    local function v35() --[[ Line: 74 ]] --[[ Name: updateProjection ]]
        -- upvalues: v7 (ref), l_rad_0 (copy), v22 (ref), l_tan_0 (copy), v21 (ref)
        local v32 = l_rad_0(v7.FieldOfView);
        local l_ViewportSize_2 = v7.ViewportSize;
        local v34 = l_ViewportSize_2.X / l_ViewportSize_2.Y;
        v22 = l_tan_0(v32 / 2) * 2;
        v21 = v34 * v22;
    end;
    v7:GetPropertyChangedSignal("FieldOfView"):Connect(v35);
    v7:GetPropertyChangedSignal("ViewportSize"):Connect(v35);
    local v36 = l_rad_0(v7.FieldOfView);
    local l_ViewportSize_3 = v7.ViewportSize;
    local v38 = l_ViewportSize_3.X / l_ViewportSize_3.Y;
    v22 = l_tan_0(v36 / 2) * 2;
    v21 = v38 * v22;
    v20 = v7.NearPlaneZ;
    v7:GetPropertyChangedSignal("NearPlaneZ"):Connect(function() --[[ Line: 88 ]]
        -- upvalues: v20 (ref), v7 (ref)
        v20 = v7.NearPlaneZ;
    end);
end;
local v39 = {};
local v40 = {};
local l_v40_0 = v40 --[[ copy: 20 -> 30 ]];
local function v45() --[[ Line: 97 ]] --[[ Name: refreshIgnoreList ]]
    -- upvalues: v39 (ref), l_v40_0 (copy)
    local v42 = 1;
    v39 = {};
    for _, v44 in pairs(l_v40_0) do
        v39[v42] = v44;
        v42 = v42 + 1;
    end;
end;
local function v59(v46) --[[ Line: 106 ]] --[[ Name: playerAdded ]]
    -- upvalues: l_v40_0 (copy), v39 (ref)
    local function v51(v47) --[[ Line: 107 ]] --[[ Name: characterAdded ]]
        -- upvalues: l_v40_0 (ref), v46 (copy), v39 (ref)
        l_v40_0[v46] = v47;
        local v48 = 1;
        v39 = {};
        for _, v50 in pairs(l_v40_0) do
            v39[v48] = v50;
            v48 = v48 + 1;
        end;
    end;
    local function v55() --[[ Line: 111 ]] --[[ Name: characterRemoving ]]
        -- upvalues: l_v40_0 (ref), v46 (copy), v39 (ref)
        l_v40_0[v46] = nil;
        local v52 = 1;
        v39 = {};
        for _, v54 in pairs(l_v40_0) do
            v39[v52] = v54;
            v52 = v52 + 1;
        end;
    end;
    v46.CharacterAdded:Connect(v51);
    v46.CharacterRemoving:Connect(v55);
    if v46.Character then
        l_v40_0[v46] = v46.Character;
        local v56 = 1;
        v39 = {};
        for _, v58 in pairs(l_v40_0) do
            v39[v56] = v58;
            v56 = v56 + 1;
        end;
    end;
end;
local function v64(v60) --[[ Line: 123 ]] --[[ Name: playerRemoving ]]
    -- upvalues: l_v40_0 (copy), v39 (ref)
    l_v40_0[v60] = nil;
    local v61 = 1;
    v39 = {};
    for _, v63 in pairs(l_v40_0) do
        v39[v61] = v63;
        v61 = v61 + 1;
    end;
end;
l_Players_0.PlayerAdded:Connect(v59);
l_Players_0.PlayerRemoving:Connect(v64);
for _, v66 in ipairs(l_Players_0:GetPlayers()) do
    v59(v66);
end;
local v67 = 1;
v39 = {};
for _, v69 in pairs(v40) do
    v39[v67] = v69;
    v67 = v67 + 1;
end;
v40 = nil;
v45 = nil;
if v5 then
    v6:Connect("CameraSubject", function() --[[ Line: 158 ]]
        -- upvalues: v6 (copy), v45 (ref)
        local l_CameraSubject_0 = v6:getCamera().CameraSubject;
        if l_CameraSubject_0 and l_CameraSubject_0:IsA("Humanoid") then
            v45 = l_CameraSubject_0.RootPart;
            return;
        elseif l_CameraSubject_0 and l_CameraSubject_0:IsA("BasePart") then
            v45 = l_CameraSubject_0;
            return;
        else
            v45 = nil;
            return;
        end;
    end);
else
    v7:GetPropertyChangedSignal("CameraSubject"):Connect(function() --[[ Line: 169 ]]
        -- upvalues: v7 (ref), v45 (ref)
        local l_CameraSubject_1 = v7.CameraSubject;
        if l_CameraSubject_1:IsA("Humanoid") then
            v45 = l_CameraSubject_1.RootPart;
            return;
        elseif l_CameraSubject_1:IsA("BasePart") then
            v45 = l_CameraSubject_1;
            return;
        else
            v45 = nil;
            return;
        end;
    end);
end;
v59 = function(v72) --[[ Line: 181 ]] --[[ Name: canOcclude ]]
    -- upvalues: v40 (ref)
    local v73 = false;
    if 1 - (1 - v72.Transparency) * (1 - v72.LocalTransparencyModifier) < 0.25 then
        v73 = v72.CanCollide and v40 ~= (v72:GetRootPart() or v72) and not v72:IsA("TrussPart");
    end;
    return v73;
end;
v64 = {
    Vector2.new(0.4, 0), 
    Vector2.new(-0.4, 0), 
    Vector2.new(0, -0.4), 
    Vector2.new(0, 0.4), 
    Vector2.new(0, 0.2)
};
v67 = function(v74, v75) --[[ Line: 209 ]] --[[ Name: getCollisionPoint ]]
    -- upvalues: v4 (copy), v12 (copy), v39 (ref), l_new_0 (copy)
    if v4 then
        v12.FilterDescendantsInstances = v39;
        repeat
            local v76 = workspace:Raycast(v74, v75, v12);
            if v76 then
                if v76.Instance.CanCollide then
                    return v76.Position, true;
                else
                    v12:AddToFilter(v76.Instance);
                end;
            end;
        until not v76;
    else
        local v77 = #v39;
        while true do
            local l_workspace_PartOnRayWithIgnoreList_0, v79 = workspace:FindPartOnRayWithIgnoreList(l_new_0(v74, v75), v39, false, true);
            if l_workspace_PartOnRayWithIgnoreList_0 then
                if l_workspace_PartOnRayWithIgnoreList_0.CanCollide then
                    local l_v39_0 = v39;
                    for v81 = #l_v39_0, v77 + 1, -1 do
                        l_v39_0[v81] = nil;
                    end;
                    return v79, true;
                else
                    v39[#v39 + 1] = l_workspace_PartOnRayWithIgnoreList_0;
                end;
            end;
            if not l_workspace_PartOnRayWithIgnoreList_0 then
                l_workspace_PartOnRayWithIgnoreList_0 = v39;
                for v82 = #l_workspace_PartOnRayWithIgnoreList_0, v77 + 1, -1 do
                    l_workspace_PartOnRayWithIgnoreList_0[v82] = nil;
                end;
                break;
            end;
        end;
    end;
    return v74 + v75, false;
end;
local function v107(v83, v84, v85, v86) --[[ Line: 247 ]] --[[ Name: queryPoint ]]
    -- upvalues: v39 (ref), v20 (ref), v4 (copy), v12 (copy), v40 (ref), v13 (copy), l_new_0 (copy)
    debug.profilebegin("queryPoint");
    local v87 = #v39;
    v85 = v85 + v20;
    local v88 = v83 + v84 * v85;
    local v89 = 1e999;
    local v90 = 1e999;
    local l_v83_0 = v83;
    local v92 = 0;
    if v4 then
        v12.FilterDescendantsInstances = v39;
        while true do
            local v93 = workspace:Raycast(l_v83_0, v88 - l_v83_0, v12);
            if v93 then
                v92 = v92 + 1;
                local l_Instance_0 = v93.Instance;
                local l_Position_0 = v93.Position;
                local l_Magnitude_0 = (l_Position_0 - v83).Magnitude;
                if v92 >= 64 then
                    v90 = l_Magnitude_0;
                else
                    local v97 = false;
                    if 1 - (1 - l_Instance_0.Transparency) * (1 - l_Instance_0.LocalTransparencyModifier) < 0.25 then
                        v97 = l_Instance_0.CanCollide and v40 ~= (l_Instance_0:GetRootPart() or l_Instance_0) and not l_Instance_0:IsA("TrussPart");
                    end;
                    if v97 then
                        v13.FilterDescendantsInstances = {
                            l_Instance_0
                        };
                        if workspace:Raycast(v88, l_Position_0 - v88, v13) then
                            if if v86 then workspace:Raycast(v86, v88 - v86, v13) or workspace:Raycast(v88, v86 - v88, v13) else false then
                                v90 = l_Magnitude_0;
                            elseif v85 < v89 then
                                v89 = l_Magnitude_0;
                            end;
                        else
                            v90 = l_Magnitude_0;
                        end;
                    end;
                end;
                v12:AddToFilter(l_Instance_0);
                l_v83_0 = l_Position_0 - v84 * 0.001;
                if v90 < 1e999 or not l_Instance_0 then
                    break;
                end;
            else
                break;
            end;
        end;
    else
        repeat
            local l_workspace_PartOnRayWithIgnoreList_1, v99 = workspace:FindPartOnRayWithIgnoreList(l_new_0(l_v83_0, v88 - l_v83_0), v39, false, true);
            v92 = v92 + 1;
            if l_workspace_PartOnRayWithIgnoreList_1 then
                local v100 = v92 >= 64;
                local v101 = false;
                if 1 - (1 - l_workspace_PartOnRayWithIgnoreList_1.Transparency) * (1 - l_workspace_PartOnRayWithIgnoreList_1.LocalTransparencyModifier) < 0.25 then
                    v101 = l_workspace_PartOnRayWithIgnoreList_1.CanCollide and v40 ~= (l_workspace_PartOnRayWithIgnoreList_1:GetRootPart() or l_workspace_PartOnRayWithIgnoreList_1) and not l_workspace_PartOnRayWithIgnoreList_1:IsA("TrussPart");
                end;
                if v101 or v100 then
                    v101 = {
                        l_workspace_PartOnRayWithIgnoreList_1
                    };
                    local l_workspace_PartOnRayWithWhitelist_0 = workspace:FindPartOnRayWithWhitelist(l_new_0(v88, v99 - v88), v101, true);
                    local l_Magnitude_1 = (v99 - v83).Magnitude;
                    if l_workspace_PartOnRayWithWhitelist_0 and not v100 then
                        local v104 = false;
                        if v86 then
                            v104 = workspace:FindPartOnRayWithWhitelist(l_new_0(v86, v88 - v86), v101, true) or workspace:FindPartOnRayWithWhitelist(l_new_0(v88, v86 - v88), v101, true);
                        end;
                        if v104 then
                            v90 = l_Magnitude_1;
                        elseif v85 < v89 then
                            v89 = l_Magnitude_1;
                        end;
                    else
                        v90 = l_Magnitude_1;
                    end;
                end;
                v39[#v39 + 1] = l_workspace_PartOnRayWithIgnoreList_1;
                l_v83_0 = v99 - v84 * 0.001;
            end;
        until v90 < 1e999 or not l_workspace_PartOnRayWithIgnoreList_1;
        local l_v39_1 = v39;
        for v106 = #l_v39_1, v87 + 1, -1 do
            l_v39_1[v106] = nil;
        end;
    end;
    debug.profileend();
    return v89 - v20, v90 - v20;
end;
local function v125(v108, v109) --[[ Line: 350 ]] --[[ Name: queryViewport ]]
    -- upvalues: v7 (ref), v5 (copy), v6 (copy), v21 (ref), v22 (ref), v20 (ref), v107 (copy)
    debug.profilebegin("queryViewport");
    local l_p_0 = v108.p;
    local l_rightVector_0 = v108.rightVector;
    local l_upVector_0 = v108.upVector;
    local v113 = -v108.lookVector;
    v7 = if v5 then v6:getCamera() else v7;
    local l_ViewportSize_4 = v7.ViewportSize;
    local v115 = 1e999;
    local v116 = 1e999;
    for v117 = 0, 1 do
        local v118 = l_rightVector_0 * ((v117 - 0.5) * v21);
        for v119 = 0, 1 do
            local v120 = l_upVector_0 * ((v119 - 0.5) * v22);
            local v121 = l_p_0 + v20 * (v118 + v120);
            local l_Origin_0 = v7:ViewportPointToRay(l_ViewportSize_4.x * v117, l_ViewportSize_4.y * v119).Origin;
            local v123, v124 = v107(v121, v113, v109, l_Origin_0);
            if v124 < v115 then
                v115 = v124;
            end;
            if v123 < v116 then
                v116 = v123;
            end;
        end;
    end;
    debug.profileend();
    return v116, v115;
end;
local function v140(v126, v127, v128) --[[ Line: 393 ]] --[[ Name: testPromotion ]]
    -- upvalues: v67 (copy), l_min_0 (copy), v107 (copy), v64 (copy)
    debug.profilebegin("testPromotion");
    local l_p_1 = v126.p;
    local l_rightVector_1 = v126.rightVector;
    local l_upVector_1 = v126.upVector;
    local v132 = -v126.lookVector;
    debug.profilebegin("extrapolate");
    local l_Magnitude_2 = (v67(l_p_1, v128.posVelocity * 1.25) - l_p_1).Magnitude;
    local l_magnitude_0 = v128.posVelocity.magnitude;
    for v135 = 0, l_min_0(1.25, v128.rotVelocity.magnitude + l_Magnitude_2 / l_magnitude_0), 0.0625 do
        local v136 = v128.extrapolate(v135);
        if v127 <= v107(v136.p, -v136.lookVector, v127) then
            return false;
        end;
    end;
    debug.profileend();
    debug.profilebegin("testOffsets");
    for _, v138 in ipairs(v64) do
        local v139 = v67(l_p_1, l_rightVector_1 * v138.x + l_upVector_1 * v138.y);
        if v107(v139, (l_p_1 + v132 * v127 - v139).Unit, v127) == 1e999 then
            return false;
        end;
    end;
    debug.profileend();
    debug.profileend();
    return true;
end;
return function(v141, v142, v143) --[[ Line: 442 ]] --[[ Name: Popper ]]
    -- upvalues: v40 (ref), v45 (ref), v125 (copy), v140 (copy)
    debug.profilebegin("popper");
    v40 = v45 and v45:GetRootPart() or v45;
    local l_v142_0 = v142;
    local v145, v146 = v125(v141, v142);
    if v146 < l_v142_0 then
        l_v142_0 = v146;
    end;
    if v145 < l_v142_0 and v140(v141, v142, v143) then
        l_v142_0 = v145;
    end;
    v40 = nil;
    debug.profileend();
    return l_v142_0;
end;