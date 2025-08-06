-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_UserInputService_0 = game:GetService("UserInputService");
local _ = game:GetService("GuiService");
local _ = game:GetService("CollectionService");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v6 = require(l_ReplicatedStorage_0.Modules.PetServices.PetInformationUserInterfaceService);
local v7 = require(l_ReplicatedStorage_0.Modules.PetServices.PetActionUserInterfaceService);
local l_CurrentCamera_0 = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 12 ]]
    -- upvalues: l_CurrentCamera_0 (ref)
    l_CurrentCamera_0 = workspace.CurrentCamera;
end);
local v9 = require(l_ReplicatedStorage_0.Modules.GetMouseToWorld);
local l_Highlight_0 = Instance.new("Highlight");
l_Highlight_0.FillTransparency = 1;
local v11 = nil;
local v12 = nil;
local function v13() --[[ Line: 25 ]] --[[ Name: TargettingInputBegan ]]
    -- upvalues: v12 (ref), l_TweenService_0 (copy), l_Highlight_0 (copy)
    if not v12 then
        return;
    else
        l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(0.2), {
            OutlineTransparency = 0.8
        }):Play();
        return;
    end;
end;
local function v14() --[[ Line: 33 ]] --[[ Name: TargettingInputEnded ]]
    -- upvalues: v12 (ref), l_TweenService_0 (copy), l_Highlight_0 (copy), v7 (copy)
    if not v12 then
        return;
    else
        l_TweenService_0:Create(l_Highlight_0, TweenInfo.new(0.2), {
            OutlineTransparency = 0
        }):Play();
        if v7.Target == v12 then
            v7:Toggle(false);
            return;
        else
            if v7.Target ~= nil then
                v7:Toggle(false);
            end;
            task.delay(0.1, function() --[[ Line: 48 ]]
                -- upvalues: v7 (ref), v12 (ref)
                v7:SetTarget(v12);
                v7:Toggle(true);
            end);
            return;
        end;
    end;
end;
local v16 = {
    [Enum.UserInputType.Touch] = {
        function(_) --[[ Line: 56 ]]
            -- upvalues: v13 (copy)
            v13();
        end
    }, 
    [Enum.UserInputType.MouseButton1] = {
        function() --[[ Line: 61 ]]
            -- upvalues: v13 (copy)
            v13();
        end
    }
};
local v18 = {
    [Enum.UserInputType.Touch] = {
        function(_) --[[ Line: 69 ]]
            -- upvalues: v14 (copy)
            v14();
        end
    }, 
    [Enum.UserInputType.MouseButton1] = {
        function() --[[ Line: 74 ]]
            -- upvalues: v14 (copy)
            v14();
        end
    }
};
l_UserInputService_0.InputBegan:Connect(function(v19, _) --[[ Line: 80 ]]
    -- upvalues: v16 (copy)
    local v21 = v16[v19.KeyCode] or v16[v19.UserInputType];
    if not v21 then
        return;
    else
        for _, v23 in v21 do
            task.spawn(function() --[[ Line: 84 ]]
                -- upvalues: v23 (copy), v19 (copy)
                v23(v19);
            end);
        end;
        return;
    end;
end);
l_UserInputService_0.InputEnded:Connect(function(v24, _) --[[ Line: 91 ]]
    -- upvalues: v18 (copy)
    local v26 = v18[v24.KeyCode] or v18[v24.UserInputType];
    if not v26 then
        return;
    else
        for _, v28 in v26 do
            task.spawn(function() --[[ Line: 95 ]]
                -- upvalues: v28 (copy), v24 (copy)
                v28(v24);
            end);
        end;
        return;
    end;
end);
l_UserInputService_0.TouchTap:Connect(function() --[[ Line: 101 ]]
    -- upvalues: v13 (copy)
    v13();
end);
l_UserInputService_0.TouchEnded:Connect(function() --[[ Line: 105 ]]
    -- upvalues: v14 (copy)
    v14();
end);
l_RunService_0.RenderStepped:Connect(function() --[[ Line: 110 ]]
    -- upvalues: l_UserInputService_0 (copy), v11 (ref), v9 (copy), v7 (copy), v6 (copy), v12 (ref), l_Highlight_0 (copy)
    local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
    if l_l_UserInputService_0_MouseLocation_0 == v11 then
        return;
    else
        v11 = l_l_UserInputService_0_MouseLocation_0;
        local v30 = RaycastParams.new();
        v30.FilterDescendantsInstances = {};
        local v31 = v9(v30, 1000);
        local v32 = v31 and v31.Instance;
        local v33 = v32 and v32:FindFirstAncestor("PetMover");
        if not v7.Active then
            v6:SetTarget(v33);
            v6:Toggle(v33 and true or false);
        elseif v7.Target == v7.Target then
            v6:Toggle(false);
        end;
        v12 = v33;
        l_Highlight_0.Adornee = v33 and v33:FindFirstChildWhichIsA("Model", true);
        l_Highlight_0.Parent = v33 and v33:FindFirstChildWhichIsA("Model", true);
        return;
    end;
end);
return {};