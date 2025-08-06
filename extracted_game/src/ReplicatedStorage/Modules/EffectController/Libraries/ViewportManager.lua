-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_RunService_0 = game:GetService("RunService");
local l_HttpService_0 = game:GetService("HttpService");
local l_TweenService_0 = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local l_clock_0 = os.clock;
local v5 = {
    "Accessory", 
    "Shirt", 
    "Pants", 
    "BodyColors", 
    "Humanoid"
};
local v6 = {
    InvalidInstance = "Incorrect type of instance given (%s). Can only track BaseParts, Models or Characters", 
    RootNotFound = "WorldModel 'Root' not found under viewportframe: %s", 
    NotDescendantOfWorkspace = "Object: %s is not a descendant of workspace."
};
local v7 = {};
v7.__index = v7;
v7.new = function(v8) --[[ Line: 70 ]] --[[ Name: new ]]
    -- upvalues: v6 (copy), v7 (copy)
    if not v8 or not v8.Object then
        error(v6.InvalidInstance:format(v8 and v8.Object or "nil"));
        return;
    else
        local v9 = setmetatable(v8, v7);
        v9.RenderPriority = v9.RenderPriority or Enum.RenderPriority.Camera.Value + 1;
        v9.RenderedProperties = v9.RenderedProperties or {
            "CFrame"
        };
        if typeof(v9.RenderPriority) == "EnumItem" then
            v9.RenderPriority = v9.RenderPriority.Value;
        end;
        v9.Object.Destroying:Once(function() --[[ Line: 84 ]]
            -- upvalues: v9 (copy)
            v9:Destroy();
        end);
        return v9;
    end;
end;
v7.Update = function(v10, v11, v12) --[[ Line: 96 ]] --[[ Name: Update ]]
    -- upvalues: v6 (copy)
    if not v10._renderframe or not v10._renderframe:FindFirstChild("Root") then
        error(v6.RootNotFound:format((tostring(v10._renderframe))));
        return;
    else
        for v13 = 1, #v10.RenderedProperties do
            local v14 = v10.RenderedProperties[v13];
            if pcall(function() --[[ Line: 106 ]]
                -- upvalues: v12 (copy), v14 (copy)
                return v12[v14] ~= nil;
            end) then
                v11[v14] = v12[v14];
            end;
        end;
        return;
    end;
end;
v7.Start = function(v15, v16) --[[ Line: 121 ]] --[[ Name: Start ]]
    -- upvalues: v6 (copy), l_Players_0 (copy), l_HttpService_0 (copy), v5 (copy)
    if v15._active then
        return;
    elseif not v15.Object:IsDescendantOf(workspace) then
        error(v6.NotDescendantOfWorkspace:format((tostring(v15.Object))));
        return;
    else
        local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
        local l_Parent_0 = v15.Parent;
        v15._active = true;
        v15._connection_id = l_HttpService_0:GenerateGUID(false);
        if not v15.Parent then
            l_Parent_0 = l_LocalPlayer_0.PlayerGui:FindFirstChild("ViewportManagerScreenGUI") or Instance.new("ScreenGui");
            l_Parent_0.Name = "ViewportManagerScreenGUI";
            l_Parent_0.IgnoreGuiInset = true;
            l_Parent_0.Parent = l_LocalPlayer_0.PlayerGui;
            l_Parent_0.Destroying:Once(function() --[[ Line: 144 ]]
                -- upvalues: v15 (copy)
                v15:Destroy();
            end);
        end;
        v15._renderframe = Instance.new("ViewportFrame");
        v15._renderframe.Size = UDim2.fromScale(1, 1);
        v15._renderframe.BackgroundTransparency = 1;
        v15._renderframe.LightDirection = Vector3.new(1, -1, -1, 0);
        v15._renderframe.Ambient = Color3.fromRGB(138, 138, 138);
        v15._renderframe.LightColor = Color3.new(1, 1, 1);
        v15._renderframe.CurrentCamera = workspace.CurrentCamera;
        v15._renderframe.Name = ("VFM%*"):format(v15._connection_id);
        v15._renderframe.Parent = l_Parent_0;
        v15._renderframe.ZIndex = v15.ZIndex or v15._renderframe.ZIndex;
        if not v15._renderframe:FindFirstChildOfClass("WorldModel") then
            local l_WorldModel_0 = Instance.new("WorldModel");
            l_WorldModel_0.Parent = v15._renderframe;
            l_WorldModel_0.Name = "Root";
        else
            v15._renderframe:FindFirstChildOfClass("WorldModel").Name = "Root";
        end;
        v15._connections = {};
        v15._viewportobject = Instance.new("Model");
        v15._viewportobject.Parent = v15._renderframe.Root;
        v15._viewportobject.Name = "";
        if v15.Object:IsA("Model") then
            local l_Humanoid_0 = v15.Object:FindFirstChild("Humanoid");
            local l_Children_0 = v15.Object:GetChildren();
            local v22 = nil;
            v22 = function(v23, v24) --[[ Line: 184 ]]
                -- upvalues: v15 (copy), v22 (ref), v16 (copy)
                for _, v26 in v23 do
                    if v15.GetModelDescendants and v26:IsA("Model") then
                        local l_Model_0 = Instance.new("Model");
                        local l_Name_0 = v26.Name;
                        local l__viewportobject_0 = v15._viewportobject;
                        l_Model_0.Name = l_Name_0;
                        l_Model_0.Parent = l__viewportobject_0;
                        v22(v26:GetChildren(), l_Model_0);
                    end;
                    if v26:IsA("BasePart") then
                        local v30 = v26:Clone();
                        v30.CFrame = v26.CFrame;
                        v30.Anchored = true;
                        v30.Parent = v24 or v15._viewportobject;
                        v15:AddConnection(v30, v26, v16);
                    end;
                end;
            end;
            v22(l_Children_0);
            if l_Humanoid_0 then
                l_Humanoid_0.Died:Once(function() --[[ Line: 206 ]]
                    -- upvalues: v15 (copy)
                    v15:Destroy();
                end);
                for _, v32 in l_Children_0 do
                    if table.find(v5, v32.ClassName) then
                        local v33 = v32:Clone();
                        v33.Parent = v15._viewportobject;
                        if v32:IsA("Accessory") and v32:FindFirstChild("Handle") then
                            local l_Handle_0 = v32.Handle;
                            v15:AddConnection(v33.Handle, l_Handle_0, v16);
                        end;
                    end;
                end;
            end;
            return;
        else
            if v15.Object:IsA("BasePart") then
                local v35 = v15.Object:Clone();
                v35.CFrame = v15.Object.CFrame;
                v35.Anchored = true;
                v35.Parent = v15._viewportobject;
                v15:AddConnection(v35, v15.Object, v16);
            end;
            return;
        end;
    end;
end;
v7.AddConnection = function(v36, v37, v38, v39) --[[ Line: 242 ]] --[[ Name: AddConnection ]]
    -- upvalues: l_clock_0 (copy), l_HttpService_0 (copy), l_RunService_0 (copy)
    if v39 then
        v36:Update(v37, v38);
        return;
    else
        local v40 = l_clock_0();
        local v41 = ("%*%*"):format(l_HttpService_0:GenerateGUID(false):sub(1, 7), v36._connection_id);
        l_RunService_0:BindToRenderStep(v41, v36.RenderPriority, function(_) --[[ Line: 251 ]]
            -- upvalues: v37 (copy), v38 (copy), v36 (copy), v41 (copy), l_RunService_0 (ref), l_clock_0 (ref), v40 (ref)
            if not v37 or not v38 then
                local v43 = table.find(v36._connections, v41);
                if v43 then
                    l_RunService_0:UnbindFromRenderStep(v41);
                    table.remove(v36._connections, v43);
                end;
                return;
            elseif v36.Framerate and l_clock_0() - v40 < 1 / v36.Framerate then
                return;
            else
                v40 = l_clock_0();
                v36:Update(v37, v38);
                return;
            end;
        end);
        table.insert(v36._connections, v41);
        return;
    end;
end;
v7.PlayOnce = function(v44, v45) --[[ Line: 275 ]] --[[ Name: PlayOnce ]]
    if not v45 then
        return;
    else
        v44:Start(true);
        task.spawn(v44.PlayFade, v44, v45);
        return;
    end;
end;
v7.PlayFade = function(v46, v47) --[[ Line: 287 ]] --[[ Name: PlayFade ]]
    -- upvalues: l_TweenService_0 (copy)
    if not v47 or not v46._renderframe then
        return;
    else
        if v47.StopTracking then
            v46:Stop();
        end;
        local v48 = v47.Time or 0.5;
        local v49 = v47.Ease or "Linear";
        local l__renderframe_0 = v46._renderframe;
        if v47.StopTracking then
            v46._renderframe = nil;
        end;
        local v51 = Enum.EasingStyle[v49];
        local v52 = TweenInfo.new(v48, v51);
        local v53 = l_TweenService_0:Create(l__renderframe_0, v52, {
            ImageTransparency = 1
        });
        v53:Play();
        v53.Completed:Wait();
        v53:Destroy();
        l__renderframe_0:Destroy();
        return;
    end;
end;
v7.Destroy = function(v54, v55) --[[ Line: 316 ]] --[[ Name: Destroy ]]
    if not v54._active then
        return;
    else
        v54:PlayFade(v55);
        v54:Stop();
        if v54._renderframe then
            v54._renderframe:Destroy();
        end;
        for v56 in v54 do
            v54[v56] = nil;
        end;
        v54 = nil;
        return;
    end;
end;
v7.Stop = function(v57) --[[ Line: 337 ]] --[[ Name: Stop ]]
    -- upvalues: l_RunService_0 (copy)
    v57._active = false;
    if v57._connections then
        for _, v59 in v57._connections do
            l_RunService_0:UnbindFromRenderStep(v59);
        end;
        v57._connections = nil;
    end;
end;
if l_RunService_0:IsServer() then
    return {};
else
    return v7;
end;