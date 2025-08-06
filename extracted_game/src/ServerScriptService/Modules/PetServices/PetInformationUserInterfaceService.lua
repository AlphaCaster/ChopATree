-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("Selection");
local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local _ = game:GetService("CollectionService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("UserInputService");
local _ = game:GetService("GuiService");
local l_CurrentCamera_0 = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 12 ]]
    -- upvalues: l_CurrentCamera_0 (ref)
    l_CurrentCamera_0 = workspace.CurrentCamera;
end);
local v9 = require(l_ReplicatedStorage_0.Modules.PetServices.ActivePetsService);
local v10 = require(l_ReplicatedStorage_0.Modules.WaitForDescendant);
local v11 = require(l_ReplicatedStorage_0.Data.PetRegistry);
local v12 = require(l_ReplicatedStorage_0.Modules.PetServices.PetUtilities);
local l_PetList_0 = v11.PetList;
local l_MAX_LEVEL_0 = v11.PetConfig.XP_CONFIG.MAX_LEVEL;
local _ = l_ReplicatedStorage_0.Modules.PetServices:WaitForChild("PetActionsHandlers");
local l_PetInformationUI_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PetUI"):WaitForChild("PetInformationUI");
local v17 = v10(l_PetInformationUI_0, "CanvasGroup");
local v18 = v10(l_PetInformationUI_0, "PET_TEXT");
local v19 = v10(l_PetInformationUI_0, "LEVEL_TEXT");
local v20 = v10(l_PetInformationUI_0, "HUNGER_BAR");
local v21 = v10(l_PetInformationUI_0, "LEVEL_PROGRESS_BAR");
local v22 = v10(l_PetInformationUI_0, "LEVEL_ICON");
local v23 = v10(l_PetInformationUI_0, "LEVEL_MAXED_TEXT");
local v24 = {
    Active = false, 
    Target = nil
};
v24.SetTarget = function(_, v26) --[[ Line: 49 ]] --[[ Name: SetTarget ]]
    -- upvalues: v24 (copy), v9 (copy), v18 (copy), v19 (copy)
    v24.Target = v26;
    if not v26 then
        return;
    else
        local l_v9_PetDataFromPetObject_0 = v9:GetPetDataFromPetObject(v26);
        if not l_v9_PetDataFromPetObject_0 then
            return;
        else
            local l_PetType_0 = l_v9_PetDataFromPetObject_0.PetType;
            local l_PetData_0 = l_v9_PetDataFromPetObject_0.PetData;
            v18.Text = l_PetType_0;
            v19.Text = ("Level %*"):format(l_PetData_0.Level);
            v24:Update();
            return;
        end;
    end;
end;
v24.Update = function(_) --[[ Line: 62 ]] --[[ Name: Update ]]
    -- upvalues: v24 (copy), v9 (copy), l_PetList_0 (copy), l_TweenService_0 (copy), v20 (copy), v12 (copy), l_MAX_LEVEL_0 (copy), v21 (copy), v23 (copy), v22 (copy)
    local l_Target_0 = v24.Target;
    if not l_Target_0 then
        return;
    else
        local l_v9_PetDataFromPetObject_1 = v9:GetPetDataFromPetObject(l_Target_0);
        if not l_v9_PetDataFromPetObject_1 then
            return;
        else
            local l_PetType_1 = l_v9_PetDataFromPetObject_1.PetType;
            local l_PetData_1 = l_v9_PetDataFromPetObject_1.PetData;
            local l_DefaultHunger_0 = l_PetList_0[l_PetType_1].DefaultHunger;
            local v36 = l_PetData_1.Hunger / l_DefaultHunger_0;
            l_TweenService_0:Create(v20, TweenInfo.new(0.2), {
                Size = UDim2.fromScale(v36, 1)
            }):Play();
            local l_Level_0 = l_PetData_1.Level;
            local l_v12_CurrentLevelXPCost_0 = v12:GetCurrentLevelXPCost(l_Level_0);
            local v39 = l_MAX_LEVEL_0 <= l_Level_0;
            local v40 = l_PetData_1.LevelProgress or 0;
            local v41 = v39 and 1 or v40 / l_v12_CurrentLevelXPCost_0;
            l_TweenService_0:Create(v21, TweenInfo.new(0.2), {
                Size = UDim2.fromScale(v41, 1)
            }):Play();
            v23.Visible = v39;
            v22.Visible = not v39;
            return;
        end;
    end;
end;
v24.Toggle = function(_, v43) --[[ Line: 96 ]] --[[ Name: Toggle ]]
    -- upvalues: v24 (copy), l_TweenService_0 (copy), v17 (copy)
    v24.Active = v43;
    l_TweenService_0:Create(v17, TweenInfo.new(0.15), {
        GroupTransparency = v43 and 0 or 1
    }):Play();
    local l_UIStroke_0 = v17:FindFirstChild("UIStroke");
    l_TweenService_0:Create(l_UIStroke_0, TweenInfo.new(0.15), {
        Transparency = v43 and 0 or 1
    }):Play();
    if not v43 then
        v24.Target = nil;
    end;
end;
local function _(v45) --[[ Line: 116 ]] --[[ Name: GetWorldToPosition ]]
    -- upvalues: l_CurrentCamera_0 (ref)
    if not v45 then
        return;
    else
        local v46 = l_CurrentCamera_0:WorldToScreenPoint(v45);
        return UDim2.fromOffset(v46.X, v46.Y);
    end;
end;
l_RunService_0.RenderStepped:Connect(function() --[[ Line: 123 ]]
    -- upvalues: v24 (copy), l_PetInformationUI_0 (copy), l_CurrentCamera_0 (ref)
    if not v24.Active then
        return;
    elseif not v24.Target then
        v24:Toggle(false);
        return;
    else
        local l_l_PetInformationUI_0_0 = l_PetInformationUI_0;
        local v49 = v24.Target.Position + Vector3.new(0, 5, 0, 0);
        local v50;
        if not v49 then
            v50 = nil;
        else
            local v51 = l_CurrentCamera_0:WorldToScreenPoint(v49);
            v50 = UDim2.fromOffset(v51.X, v51.Y);
        end;
        l_l_PetInformationUI_0_0.Position = v50;
        return;
    end;
end);
task.spawn(function() --[[ Line: 129 ]]
    -- upvalues: v24 (copy)
    while true do
        task.wait(1);
        v24:Update();
    end;
end);
return v24;