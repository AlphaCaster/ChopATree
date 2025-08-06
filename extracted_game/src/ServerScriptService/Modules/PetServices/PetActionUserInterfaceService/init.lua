-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("Selection");
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
local l_CurrentCamera_0 = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 12 ]]
    -- upvalues: l_CurrentCamera_0 (ref)
    l_CurrentCamera_0 = workspace.CurrentCamera;
end);
local l_Modules_0 = l_ReplicatedStorage_0.Modules;
local v10 = require(l_Modules_0.WaitForDescendant);
local l_PetServices_0 = l_Modules_0:WaitForChild("PetServices");
local v12 = require(l_PetServices_0.ActivePetsService);
local l_PetList_0 = require(l_ReplicatedStorage_0.Data.PetRegistry).PetList;
local l_PlayerGui_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
local l_PetActionUI_0 = l_PlayerGui_0:WaitForChild("PetUI"):WaitForChild("PetActionUI");
local l_UIScale_0 = l_PetActionUI_0:WaitForChild("UIScale");
local v17 = v10(l_PetActionUI_0, "CLOSE_BUTTON");
local v18 = v10(l_PetActionUI_0, "OPTION_HOLDER");
local l_PetActionsHandlers_0 = l_ReplicatedStorage_0.Modules.PetServices:WaitForChild("PetActionsHandlers");
local l_PetActionTemplates_0 = script:WaitForChild("PetActionTemplates");
local l_ScriptModules_0 = script:WaitForChild("ScriptModules");
local l_SetupHoverAnimations_0 = require(l_ScriptModules_0:WaitForChild("SetupHoverAnimations"));
local l_SetupBrightnessAnimation_0 = require(l_ScriptModules_0:WaitForChild("SetupBrightnessAnimation"));
local l_Radialize_0 = require(l_ScriptModules_0:WaitForChild("Radialize"));
local v25 = {
    Active = false, 
    Target = nil
};
local v26 = nil;
local function v33() --[[ Line: 51 ]] --[[ Name: CheckIfHoveringButton ]]
    -- upvalues: l_CollectionService_0 (copy), l_UserInputService_0 (copy), l_GuiService_0 (copy), l_PlayerGui_0 (copy)
    local l_l_CollectionService_0_Tagged_0 = l_CollectionService_0:GetTagged("PetActionButton");
    local _ = {};
    local v29 = l_UserInputService_0:GetMouseLocation() - l_GuiService_0:GetGuiInset();
    local l_l_PlayerGui_0_GuiObjectsAtPosition_0 = l_PlayerGui_0:GetGuiObjectsAtPosition(v29.X, v29.Y);
    for _, v32 in l_l_CollectionService_0_Tagged_0 do
        if v32:IsDescendantOf(l_PlayerGui_0) and table.find(l_l_PlayerGui_0_GuiObjectsAtPosition_0, v32) then
            return true;
        end;
    end;
    return false;
end;
v25.SetTarget = function(_, v35) --[[ Line: 71 ]] --[[ Name: SetTarget ]]
    -- upvalues: v26 (ref), v25 (copy), v18 (copy), v12 (copy), l_PetList_0 (copy), l_PetActionTemplates_0 (copy), l_SetupHoverAnimations_0 (copy), l_SetupBrightnessAnimation_0 (copy), l_PetActionsHandlers_0 (copy), l_Radialize_0 (copy)
    v26 = nil;
    if v25.Target == v35 then
        return;
    else
        v25.Target = v35;
        for _, v37 in v18:GetChildren() do
            if v37:HasTag("PetActionButton") then
                v37:Destroy();
            end;
        end;
        local l_v12_PetDataFromPetObject_0 = v12:GetPetDataFromPetObject(v35);
        if not l_v12_PetDataFromPetObject_0 then
            return;
        else
            for _, v40 in l_PetList_0[l_v12_PetDataFromPetObject_0.PetType].Actions do
                local v41 = l_PetActionTemplates_0:FindFirstChild(v40):Clone();
                v41.Parent = v18;
                local l_Inner_0 = v41:FindFirstChild("Inner");
                local v43 = l_SetupHoverAnimations_0(l_Inner_0);
                l_SetupBrightnessAnimation_0(l_Inner_0);
                v43.MouseButton1Down:Connect(function() --[[ Line: 97 ]]
                    -- upvalues: l_PetActionsHandlers_0 (ref), v40 (copy), v25 (ref)
                    local l_l_PetActionsHandlers_0_FirstChild_0 = l_PetActionsHandlers_0:FindFirstChild(v40);
                    if not l_l_PetActionsHandlers_0_FirstChild_0 then
                        return warn("No handler for", v40);
                    else
                        require(l_l_PetActionsHandlers_0_FirstChild_0)(v25.Target);
                        v25:Toggle(false);
                        return;
                    end;
                end);
            end;
            l_Radialize_0(v18);
            return;
        end;
    end;
end;
v25.Toggle = function(_, v46) --[[ Line: 109 ]] --[[ Name: Toggle ]]
    -- upvalues: v25 (copy), l_TweenService_0 (copy), l_UIScale_0 (copy)
    v25.Active = v46;
    l_TweenService_0:Create(l_UIScale_0, TweenInfo.new(0.1), {
        Scale = v46 and 1 or 0
    }):Play();
    if not v46 then
        v25.Target = nil;
    end;
end;
local function _(v47) --[[ Line: 122 ]] --[[ Name: GetWorldToPosition ]]
    -- upvalues: l_CurrentCamera_0 (ref)
    if not v47 then
        return;
    else
        local v48 = l_CurrentCamera_0:WorldToScreenPoint(v47);
        return UDim2.fromOffset(v48.X, v48.Y);
    end;
end;
l_RunService_0.RenderStepped:Connect(function() --[[ Line: 129 ]]
    -- upvalues: v25 (copy), l_PetActionUI_0 (copy), l_CurrentCamera_0 (ref)
    if not v25.Active then
        return;
    elseif not v25.Target then
        v25:Toggle(false);
        return;
    else
        local l_l_PetActionUI_0_0 = l_PetActionUI_0;
        local v51 = v25.Target.Position + Vector3.new(0, 2.5, 0, 0);
        local v52;
        if not v51 then
            v52 = nil;
        else
            local v53 = l_CurrentCamera_0:WorldToScreenPoint(v51);
            v52 = UDim2.fromOffset(v53.X, v53.Y);
        end;
        l_l_PetActionUI_0_0.Position = v52;
        return;
    end;
end);
l_SetupHoverAnimations_0(v17).MouseButton1Down:Connect(function() --[[ Line: 137 ]]
    -- upvalues: v25 (copy)
    v25:Toggle(false);
end);
local function _() --[[ Line: 141 ]] --[[ Name: DisableIfNoHover ]]
    -- upvalues: v33 (copy), v25 (copy)
    if v33() then
        return;
    else
        v25:Toggle(false);
        return;
    end;
end;
local v55 = {
    [Enum.UserInputType.MouseButton1] = {
        Activate = function() --[[ Line: 148 ]]

        end
    }
};
local v56 = {
    [Enum.UserInputType.MouseButton1] = {
        Deactivate = function() --[[ Line: 156 ]]
            -- upvalues: v33 (copy), v25 (copy)
            if v33() then
                return;
            else
                v25:Toggle(false);
                return;
            end;
        end
    }
};
l_UserInputService_0.InputBegan:Connect(function(v57, v58) --[[ Line: 162 ]]
    -- upvalues: v55 (copy)
    if v58 then
        return;
    else
        local v59 = v55[v57.KeyCode] or v55[v57.UserInputType];
        if not v59 then
            return;
        else
            for _, v61 in v59 do
                task.spawn(v61);
            end;
            return;
        end;
    end;
end);
l_UserInputService_0.InputEnded:Connect(function(v62, v63) --[[ Line: 173 ]]
    -- upvalues: v56 (copy)
    if v63 then
        return;
    else
        local v64 = v56[v62.KeyCode] or v56[v62.UserInputType];
        if not v64 then
            return;
        else
            for _, v66 in v64 do
                task.spawn(v66);
            end;
            return;
        end;
    end;
end);
l_UserInputService_0.TouchTap:Connect(function() --[[ Line: 183 ]]
    -- upvalues: v33 (copy), v25 (copy)
    if v33() then
        return;
    else
        v25:Toggle(false);
        return;
    end;
end);
return v25;