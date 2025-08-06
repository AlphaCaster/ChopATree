-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
local v2 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
l_LocalPlayer_0.CharacterAdded:Connect(function(v3) --[[ Line: 7 ]]
    -- upvalues: v2 (ref)
    v2 = v3;
end);
local v4 = require(l_ReplicatedStorage_0.Modules.PetServices.PetUtilities);
local v5 = require(l_ReplicatedStorage_0.Modules.PetServices.ActivePetsService);
local v6 = {};
local function v16() --[[ Line: 17 ]] --[[ Name: GetClosestPetModel ]]
    -- upvalues: v5 (copy), l_LocalPlayer_0 (copy), v2 (ref)
    local l_v5_ClientPetState_0 = v5:GetClientPetState(l_LocalPlayer_0.Name);
    local v8 = nil;
    local v9 = 1e999;
    local v10 = nil;
    for v11, v12 in l_v5_ClientPetState_0 do
        local l_Asset_0 = v12.Asset;
        if not l_Asset_0 then
            return;
        else
            local l_l_Asset_0_FirstChildWhichIsA_0 = l_Asset_0:FindFirstChildWhichIsA("Model", true);
            local l_Magnitude_0 = (l_l_Asset_0_FirstChildWhichIsA_0:GetPivot().Position - v2:GetPivot().Position).Magnitude;
            if v9 > l_Magnitude_0 then
                v8 = l_l_Asset_0_FirstChildWhichIsA_0;
                v9 = l_Magnitude_0;
                v10 = v11;
            end;
        end;
    end;
    return v10, v8;
end;
local v17 = nil;
local l_ProximityPrompt_0 = Instance.new("ProximityPrompt");
l_ProximityPrompt_0.Exclusivity = Enum.ProximityPromptExclusivity.AlwaysShow;
l_ProximityPrompt_0.KeyboardKeyCode = Enum.KeyCode.F;
l_ProximityPrompt_0.RequiresLineOfSight = false;
l_ProximityPrompt_0.HoldDuration = 0.5;
l_ProximityPrompt_0.MaxActivationDistance = 1e999;
l_ProximityPrompt_0.Triggered:Connect(function() --[[ Line: 47 ]]
    -- upvalues: v17 (ref), v5 (copy)
    if not v17 then
        return;
    else
        v5:Feed(v17);
        return;
    end;
end);
task.spawn(function() --[[ Line: 52 ]]
    -- upvalues: v2 (ref), l_ProximityPrompt_0 (copy), v16 (copy), v5 (copy), v17 (ref), v4 (copy)
    while true do
        task.wait(0.5);
        local l_Tool_0 = v2:FindFirstChildWhichIsA("Tool");
        if not l_Tool_0 then
            l_ProximityPrompt_0.Enabled = false;
        elseif not l_Tool_0:HasTag("FruitTool") then
            l_ProximityPrompt_0.Enabled = false;
        else
            local v20, v21 = v16();
            if not v21 then
                l_ProximityPrompt_0.Enabled = false;
            else
                local l_PetType_0 = v5:GetPetDataFromPetObject(v21.Parent).PetType;
                v17 = v20;
                local v23 = v4:GetFruitWorthPercentageForAnimal(l_PetType_0, l_Tool_0) * 100;
                local v24 = if math.round(v23) - v23 == 0 then v23 else ("%.2f"):format(v23);
                l_ProximityPrompt_0.ObjectText = v21.Name;
                l_ProximityPrompt_0.ActionText = ("Feed (%*%%) %*"):format(v24, l_Tool_0.Name);
                l_ProximityPrompt_0.Enabled = true;
                l_ProximityPrompt_0.Parent = v21.PrimaryPart or v21:FindFirstChildWhichIsA("BasePart", true);
            end;
        end;
    end;
end);
return v6;