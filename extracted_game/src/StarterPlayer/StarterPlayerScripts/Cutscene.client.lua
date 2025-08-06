-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Cutscene_Module_0 = require(game.ReplicatedStorage:WaitForChild("Cutscene_Module"));
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local _ = game:GetService("TweenService");
local l_Debris_0 = game:GetService("Debris");
local _ = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local v5 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local _ = require(game.ReplicatedStorage:WaitForChild("RichText"));
local l_TweenService_1 = game:GetService("TweenService");
local _ = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local l_Sam_0 = game.SoundService.NPC_SFX.Sam;
local _ = game.SoundService.Response_Text;
Create_Text = function(v11) --[[ Line: 13 ]] --[[ Name: Create_Text ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_TweenService_1 (copy), v5 (copy), l_Debris_0 (copy), l_Sam_0 (copy)
    local l_Rejoin_UI_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("Rejoin_UI");
    for _, v14 in pairs(l_Rejoin_UI_0:GetDescendants()) do
        if v14:IsA("TextLabel") then
            l_TweenService_1:Create(v14, v5, {
                TextStrokeTransparency = 1, 
                TextTransparency = 1
            }):Play();
            l_Debris_0:AddItem(v14.Parent, v5.Time);
        end;
    end;
    local v15 = script.Frame:Clone();
    v15.TextLabel.Text = v11;
    l_TweenService_1:Create(v15.TextLabel, v5, {
        TextTransparency = 0, 
        TextStrokeTransparency = 0
    }):Play();
    v15.Parent = l_Rejoin_UI_0;
    local v16 = string.len(v11);
    while v16 >= 1 do
        task.wait();
        if l_Sam_0.TimePosition > 0.075 or l_Sam_0.Playing == false then
            l_Sam_0.TimePosition = 0;
            l_Sam_0.Playing = true;
            l_Sam_0.PlaybackSpeed = 1 + math.random(-5, 5) / 100;
        end;
        v16 = v16 - 1;
        local l_TextLabel_0 = v15.TextLabel;
        l_TextLabel_0.MaxVisibleGraphemes = l_TextLabel_0.MaxVisibleGraphemes + 1;
    end;
end;
End = function() --[[ Line: 42 ]] --[[ Name: End ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_TweenService_1 (copy), v5 (copy), l_Debris_0 (copy)
    local l_Rejoin_UI_1 = l_LocalPlayer_0.PlayerGui:WaitForChild("Rejoin_UI");
    for _, v20 in pairs(l_Rejoin_UI_1:GetDescendants()) do
        if v20:IsA("TextLabel") then
            l_TweenService_1:Create(v20, v5, {
                TextStrokeTransparency = 1, 
                TextTransparency = 1
            }):Play();
            l_Debris_0:AddItem(v20.Parent, v5.Time);
        end;
    end;
end;
game.ReplicatedStorage.GameEvents:WaitForChild("Start_Cutscene").OnClientEvent:Connect(function(v21) --[[ Line: 53 ]]
    -- upvalues: l_Cutscene_Module_0 (copy), l_LocalPlayer_0 (copy), l_TweenService_1 (copy), v5 (copy), l_Debris_0 (copy)
    Create_Text("Your garden grew while you were gone!");
    task.wait(3);
    End();
    task.wait(1);
    Create_Text("When you left it looked like this...");
    task.wait(0.5);
    task.wait(v21 - 0.5);
    l_Cutscene_Module_0.Flash(l_LocalPlayer_0, 0.75);
    task.wait(1.125);
    Create_Text("This is your garden now!");
    task.spawn(function() --[[ Line: 66 ]]
        -- upvalues: l_LocalPlayer_0 (ref), l_TweenService_1 (ref), v5 (ref), l_Debris_0 (ref)
        task.wait(2);
        local l_Rejoin_UI_2 = l_LocalPlayer_0.PlayerGui:WaitForChild("Rejoin_UI");
        for _, v24 in pairs(l_Rejoin_UI_2:GetDescendants()) do
            if v24:IsA("TextLabel") then
                l_TweenService_1:Create(v24, v5, {
                    TextStrokeTransparency = 1, 
                    TextTransparency = 1
                }):Play();
                l_Debris_0:AddItem(v24.Parent, v5.Time);
            end;
        end;
    end);
end);