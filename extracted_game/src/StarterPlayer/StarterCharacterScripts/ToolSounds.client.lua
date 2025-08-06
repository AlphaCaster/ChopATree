-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Character_0 = game.Players.LocalPlayer.Character;
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_SoundService_0 = game:GetService("SoundService");
local v3 = {};
local v4 = os.clock();
local v5 = l_Character_0:FindFirstChild("Animator", true):LoadAnimation(script.TwoHandedFruitAnimation);
local function v10(v6, v7) --[[ Line: 14 ]] --[[ Name: PlaySound ]]
    -- upvalues: v4 (ref)
    if os.clock() < v4 + 0.1 then
        return;
    else
        v4 = os.clock();
        local v8 = v6:Clone();
        local l_Part_0 = Instance.new("Part");
        l_Part_0.Parent = workspace;
        l_Part_0.CanCollide = false;
        l_Part_0.CanQuery = false;
        l_Part_0.Anchored = true;
        l_Part_0.Position = v7.Position;
        l_Part_0.Transparency = 1;
        v8.Parent = l_Part_0;
        v8:Play();
        game.Debris:AddItem(l_Part_0, v8.TimeLength);
        return;
    end;
end;
l_Character_0.ChildAdded:Connect(function(v11) --[[ Line: 36 ]]
    -- upvalues: v5 (copy), v10 (copy), v3 (copy)
    if not v11:IsA("Tool") then
        return;
    else
        local l_Handle_0 = v11:WaitForChild("Handle");
        if not l_Handle_0 then
            return;
        else
            local v13 = nil;
            v13 = v11.Equipped:Connect(function() --[[ Line: 41 ]]
                -- upvalues: l_Handle_0 (copy), v11 (copy), v5 (ref), v10 (ref)
                local v14 = l_Handle_0:FindFirstChild("Equip") or script.Equip;
                if v11:HasTag("TwoHandedFruit") then
                    v5:Play();
                end;
                v10(v14, l_Handle_0);
            end);
            local _ = nil;
            v3[v11] = {
                v13, 
                (v11.Unequipped:Connect(function() --[[ Line: 53 ]]
                    -- upvalues: l_Handle_0 (copy), v11 (copy), v5 (ref), v10 (ref)
                    local v16 = l_Handle_0:FindFirstChild("Unequip") or script.Unequip;
                    if v11:HasTag("TwoHandedFruit") then
                        v5:Stop();
                    end;
                    v10(v16, l_Handle_0);
                end))
            };
            return;
        end;
    end;
end);
l_Character_0.ChildRemoved:Connect(function(v17) --[[ Line: 71 ]]
    -- upvalues: v3 (copy), v5 (copy)
    if not v17:IsA("Tool") then
        return;
    else
        if v3[v17] then
            for _, v19 in v3[v17] do
                v19:Disconnect();
            end;
            if v17:HasTag("TwoHandedFruit") then
                v5:Stop();
            end;
        end;
        return;
    end;
end);
l_ReplicatedStorage_0.GameEvents.PlaySound.OnClientEvent:Connect(function(v20) --[[ Line: 85 ]]
    -- upvalues: l_SoundService_0 (copy)
    local l_l_SoundService_0_FirstChild_0 = l_SoundService_0:FindFirstChild(v20);
    if not l_l_SoundService_0_FirstChild_0 then
        return;
    else
        l_SoundService_0:PlayLocalSound(l_l_SoundService_0_FirstChild_0);
        return;
    end;
end);
local v22 = -1;
local v23 = 0;
local function v28(v24) --[[ Line: 97 ]] --[[ Name: PickUpSound ]]
    -- upvalues: l_SoundService_0 (copy), v22 (ref), v23 (ref)
    local l_l_SoundService_0_FirstChild_1 = l_SoundService_0:FindFirstChild(v24);
    if not l_l_SoundService_0_FirstChild_1 then
        return;
    else
        l_l_SoundService_0_FirstChild_1 = l_l_SoundService_0_FirstChild_1:Clone();
        v22 = v22 + 1;
        v22 = v22 % 16;
        local v26 = tick();
        v23 = v26;
        task.delay(1, function() --[[ Line: 109 ]]
            -- upvalues: v23 (ref), v26 (copy), v22 (ref)
            if v23 == v26 then
                v22 = 0;
            end;
        end);
        local l_PitchShiftSoundEffect_0 = Instance.new("PitchShiftSoundEffect");
        l_PitchShiftSoundEffect_0.Octave = math.clamp(v22 * 0.05, 0, 0.8) + 0.7;
        l_PitchShiftSoundEffect_0.Parent = l_l_SoundService_0_FirstChild_1;
        l_l_SoundService_0_FirstChild_1.Parent = workspace;
        l_l_SoundService_0_FirstChild_1:Play();
        game.Debris:AddItem(l_l_SoundService_0_FirstChild_1, 5);
        return;
    end;
end;
l_ReplicatedStorage_0.GameEvents.PickupEvent.Event:Connect(v28);
l_ReplicatedStorage_0.GameEvents.PickupSound.OnClientEvent:Connect(v28);