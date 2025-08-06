-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_SoundService_0 = game:GetService("SoundService");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v5 = require(l_ReplicatedStorage_0.Modules.WeightRandom);
local v6 = require(l_ReplicatedStorage_0.Data.SeedPackData);
local v7 = require(l_ReplicatedStorage_0.Item_Module);
local v8 = require(l_ReplicatedStorage_0.Data.SeedData);
local v9 = require(l_ReplicatedStorage_0.Modules.Remotes);
local v10 = require(l_ReplicatedStorage_0.Modules.FastTween);
local v11 = require(l_ReplicatedStorage_0.Modules.Shake);
local l_RollCrate_UI_0 = l_Players_0.LocalPlayer.PlayerGui:WaitForChild("RollCrate_UI");
local l_Frame_0 = l_RollCrate_UI_0.Frame;
local l_Rolled_0 = l_Frame_0.Rolled;
local l_Spinner_0 = l_Frame_0.Section.Spinner;
local v16 = table.create(150);
local v17 = false;
local v18 = {};
local v19 = false;
local v20 = false;
local function v23(v21, v22) --[[ Line: 42 ]] --[[ Name: tweenHolder ]]
    -- upvalues: l_Frame_0 (copy), v10 (copy)
    if v21 then
        if v22 then
            l_Frame_0.Position = UDim2.fromScale(0.5, 0.5);
            return;
        else
            l_Frame_0.Position = UDim2.fromScale(0.5, 1.5);
            v10(l_Frame_0, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, 0.5)
            });
            return;
        end;
    elseif v22 then
        l_Frame_0.Position = UDim2.fromScale(0.5, 1.5);
        return;
    else
        l_Frame_0.Position = UDim2.fromScale(0.5, 0.5);
        v10(l_Frame_0, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Position = UDim2.fromScale(0.5, 1.5)
        });
        return;
    end;
end;
local function v28(v24, v25) --[[ Line: 64 ]] --[[ Name: tweenRolled ]]
    -- upvalues: l_Rolled_0 (copy), v10 (copy)
    if v24 then
        if v25 then
            l_Rolled_0.ImageTransparency = 0;
            l_Rolled_0.Label.TextTransparency = 0;
            l_Rolled_0.Label.UIStroke.Transparency = 0;
            return;
        else
            local v26 = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
            l_Rolled_0.ImageTransparency = 1;
            l_Rolled_0.Label.TextTransparency = 1;
            l_Rolled_0.Label.UIStroke.Transparency = 1;
            v10(l_Rolled_0, v26, {
                ImageTransparency = 0
            });
            v10(l_Rolled_0.Label, v26, {
                TextTransparency = 0
            });
            v10(l_Rolled_0.Label.UIStroke, v26, {
                Transparency = 0
            });
            return;
        end;
    elseif v25 then
        l_Rolled_0.ImageTransparency = 1;
        l_Rolled_0.Label.TextTransparency = 1;
        l_Rolled_0.Label.UIStroke.Transparency = 1;
        return;
    else
        local v27 = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        l_Rolled_0.ImageTransparency = 0;
        l_Rolled_0.Label.TextTransparency = 0;
        l_Rolled_0.Label.UIStroke.Transparency = 0;
        v10(l_Rolled_0, v27, {
            ImageTransparency = 1
        });
        v10(l_Rolled_0.Label, v27, {
            TextTransparency = 1
        });
        v10(l_Rolled_0.Label.UIStroke, v27, {
            Transparency = 1
        });
        return;
    end;
end;
local function v81(v29) --[[ Line: 116 ]] --[[ Name: spinAction ]]
    -- upvalues: v20 (ref), l_RollCrate_UI_0 (copy), v23 (copy), l_Frame_0 (copy), v6 (copy), l_Rolled_0 (copy), v5 (copy), v16 (copy), v8 (copy), v7 (copy), l_SoundService_0 (copy), l_Spinner_0 (copy), l_TweenService_0 (copy), v10 (copy), v11 (copy), l_RunService_0 (copy), v28 (copy)
    local l_v20_0 = v20;
    local v31 = false;
    l_RollCrate_UI_0.Enabled = true;
    v23(true, l_v20_0);
    l_Frame_0.Visible = true;
    local v32 = 140;
    local v33 = Random.new();
    local v34 = v6.Packs[v29.seedPackType];
    local v35 = (not (v29.seedPackType ~= "RainbowSeedSackPremium") or v29.seedPackType == "RainbowSeedSackBasic") and "Rainbow" or "Normal";
    local l_Items_0 = v34.Items;
    local v37 = l_Items_0[v29.resultIndex];
    for _, v39 in l_Frame_0.Decorations:GetChildren() do
        v39.Visible = v39.Name == v35;
    end;
    for _, v41 in l_Rolled_0.Decorations:GetChildren() do
        v41.Visible = v41.Name == v35;
    end;
    if v37.Type == "Pack" and (v37.RewardId == "RainbowSeedSackPremium" or v37.RewardId == "RainbowSeedSackBasic") then
        v31 = true;
    end;
    local v42 = {};
    local v43 = nil;
    for v44 = 1, 150 do
        local v45 = nil;
        v45 = if v44 == v32 then v37 else v5.array(l_Items_0, v33);
        if not v45 then
            v32 = v32 - 1;
        else
            local v46 = v16[v44];
            local v47 = nil;
            local l_v35_0 = v35;
            if v45.Type == "Pack" and (v45.RewardId == "RainbowSeedSackPremium" or v45.RewardId == "RainbowSeedSackBasic") then
                l_v35_0 = "Custom_RainbowCrate";
            end;
            for _, v50 in v46:GetChildren() do
                local v51 = v50.Name == l_v35_0;
                v50.Visible = v51;
                if v51 then
                    v47 = v50;
                end;
            end;
            if v47 then
                if v44 == v32 then
                    v43 = v47;
                end;
                if (v45.Type == "Seed" or v45.Type == "RainbowSeed") and v8[v45.RewardId] then
                    local v52 = v8[v45.RewardId];
                    local v53 = v7.Return_Rarity_Data(v52.SeedRarity);
                    if v53 then
                        v47.Rarity.Text = v53[1];
                        v47.Rarity.TextColor3 = v53[2];
                    end;
                    v47.Vector.Visible = false;
                    v47.ViewportFrame.Visible = true;
                    local v54 = v52.Asset:Clone();
                    local l_BasePart_0 = v47.ViewportFrame.BasePart;
                    v54.Name = "BasePart";
                    v54.CFrame = l_BasePart_0.CFrame;
                    v54.Parent = v47.ViewportFrame;
                    if v45.Type == "RainbowSeed" then
                        v54:AddTag("RainbowPart");
                        table.insert(v42, function() --[[ Line: 207 ]]
                            -- upvalues: v54 (copy)
                            v54:RemoveTag("RainbowPart");
                        end);
                    end;
                    l_BasePart_0:Destroy();
                elseif v45.Type == "Pack" then
                    v47.Vector.Image = v45.Icon or "";
                    v47.Vector.Visible = true;
                    v47.ViewportFrame.Visible = false;
                else
                    warn((("Seed data not found for %*"):format(v45.RewardId)));
                end;
                v47.Label.Text = v6:GetTextDisplayForItem(v45);
            end;
        end;
    end;
    local l_NumberValue_0 = Instance.new("NumberValue");
    l_NumberValue_0.Value = 5;
    local v57 = nil;
    local v58 = nil;
    local function v61() --[[ Line: 230 ]] --[[ Name: updatePosition ]]
        -- upvalues: l_NumberValue_0 (copy), v57 (ref), v58 (ref), l_SoundService_0 (ref), v20 (ref), l_Spinner_0 (ref)
        local l_Value_0 = l_NumberValue_0.Value;
        local v60 = l_Value_0 // 1;
        if v60 ~= v57 then
            if v57 and (not v58 or os.clock() - v58 > 0.05) then
                l_SoundService_0:PlayLocalSound(if v20 then l_SoundService_0["Seed Pack"].RainbowTick else l_SoundService_0["Seed Pack"].NormalTick);
                v58 = os.clock();
            end;
            v57 = v60;
        end;
        l_Spinner_0.Position = UDim2.new(0.5, -l_Value_0 * l_Spinner_0.AbsoluteSize.Y, 0.5, 0);
    end;
    local v62 = l_Spinner_0:GetPropertyChangedSignal("AbsoluteSize"):Connect(v61);
    local v63 = l_NumberValue_0.Changed:Connect(v61);
    task.spawn(v61);
    local v64 = v32 - 0.5 + (math.random() - 0.5) * 0.5;
    local v65 = l_TweenService_0:Create(l_NumberValue_0, TweenInfo.new(5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Value = v64
    });
    v65:Play();
    local v66 = false;
    local v67 = coroutine.running();
    local function v68() --[[ Line: 260 ]] --[[ Name: resume ]]
        -- upvalues: v66 (ref), v67 (copy)
        if v66 then
            return;
        else
            v66 = true;
            if coroutine.status(v67) == "suspended" then
                task.spawn(v67);
            end;
            return;
        end;
    end;
    local v69 = l_Frame_0.Skip.Activated:Once(v68);
    local v70 = v65.Completed:Once(v68);
    if not v66 then
        coroutine.yield();
    end;
    v69:Disconnect();
    v70:Disconnect();
    v65:Cancel();
    v65:Destroy();
    v63:Disconnect();
    v62:Disconnect();
    task.defer(function() --[[ Line: 288 ]]
        -- upvalues: l_NumberValue_0 (copy), v64 (copy), v61 (copy)
        l_NumberValue_0.Value = v64;
        v61();
        l_NumberValue_0:Destroy();
    end);
    if v31 and v43 then
        l_SoundService_0["Seed Pack"].RainbowReward:Play();
        local v71 = v10(v43.Vector, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            ImageColor3 = Color3.new(1, 1, 1)
        });
        local v72 = v10(v43, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            ImageColor3 = Color3.new(1, 1, 1)
        });
        task.wait(0.3);
        local v73 = v11.new();
        v73.FadeInTime = 0.5;
        v73.FadeOutTime = 1.5;
        v73.Frequency = 0.08;
        v73.Amplitude = 15;
        v73.Sustain = true;
        v73.PositionInfluence = Vector3.new(1, 1, 0, 0);
        v73.RotationInfluence = Vector3.new(0, 0, 0, 0);
        local v74 = nil;
        do
            local l_v74_0 = v74;
            l_v74_0 = l_RunService_0.PostSimulation:Connect(function() --[[ Line: 319 ]]
                -- upvalues: v73 (copy), l_Frame_0 (ref), l_v74_0 (ref)
                local v76, _, v78 = v73:Update();
                l_Frame_0.Position = UDim2.fromScale(0.5, 0.5) + UDim2.fromOffset(v76.X, v76.Y);
                if v78 then
                    l_v74_0:Disconnect();
                end;
            end);
            task.wait(1.2);
            l_RollCrate_UI_0.Fade.BackgroundTransparency = 0;
            v10(l_RollCrate_UI_0.Fade, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.2), {
                BackgroundTransparency = 1
            });
            v71:Cancel();
            v72:Cancel();
            task.delay(0.3, function() --[[ Line: 338 ]]
                -- upvalues: v73 (copy)
                v73:StopSustain();
            end);
        end;
    else
        l_SoundService_0["Seed Pack"].Reward:Play();
        l_Rolled_0.Label.Text = ("x1 %*"):format((v6:GetTextDisplayForItem(v37)));
        v28(true);
        task.wait(2);
        v23(false);
        task.wait(0.5);
        v28(false);
    end;
    l_Frame_0.Visible = false;
    l_RollCrate_UI_0.Enabled = false;
    for _, v80 in v42 do
        if type(v80) == "function" then
            task.spawn(v80);
        end;
    end;
    if l_v20_0 then
        v20 = false;
    end;
    if v31 then
        v20 = true;
    end;
end;
v18.Spin = function(_, v83) --[[ Line: 375 ]] --[[ Name: Spin ]]
    -- upvalues: v17 (ref), v19 (ref), v81 (copy), v9 (copy)
    while not v17 do
        task.wait();
    end;
    while v19 do
        task.wait();
    end;
    v19 = true;
    xpcall(v81, warn, v83);
    v19 = false;
    v9.SeedPack.SpinFinished.send();
end;
v18.Start = function(v84) --[[ Line: 391 ]] --[[ Name: Start ]]
    -- upvalues: l_RollCrate_UI_0 (copy), v9 (copy), l_Spinner_0 (copy), v16 (copy), v17 (ref)
    l_RollCrate_UI_0.Frame.Visible = false;
    l_RollCrate_UI_0.Frame.Position = UDim2.fromScale(0.5, 1.5);
    l_RollCrate_UI_0.Frame.Rolled.ImageTransparency = 1;
    l_RollCrate_UI_0.Frame.Rolled.Label.TextTransparency = 1;
    l_RollCrate_UI_0.Frame.Rolled.Label.UIStroke.Transparency = 1;
    for _, v86 in l_RollCrate_UI_0.Frame.Rolled.Decorations:GetChildren() do
        v86.ImageTransparency = l_RollCrate_UI_0.Frame.Rolled.ImageTransparency;
        l_RollCrate_UI_0.Frame.Rolled:GetPropertyChangedSignal("ImageTransparency"):Connect(function() --[[ Line: 402 ]]
            -- upvalues: v86 (copy), l_RollCrate_UI_0 (ref)
            v86.ImageTransparency = l_RollCrate_UI_0.Frame.Rolled.ImageTransparency;
        end);
    end;
    v9.SeedPack.Result.listen(function(v87) --[[ Line: 407 ]]
        -- upvalues: v84 (copy)
        v84:Spin(v87);
    end);
    for v88 = 1, 150 do
        local v89 = l_Spinner_0.UIListLayout.Template:Clone();
        v89.Name = tostring(v88);
        v89.LayoutOrder = v88;
        v89.Parent = l_Spinner_0;
        v16[v88] = v89;
        if v88 % 10 == 0 then
            task.wait(0.1);
        end;
    end;
    v17 = true;
end;
task.spawn(v18.Start, v18);
return v18;