-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_SoundService_0 = game:GetService("SoundService");
local l_Players_0 = game:GetService("Players");
local v3 = require(l_ReplicatedStorage_0.Modules.Icon);
local _ = l_Players_0.LocalPlayer;
task.spawn(function() --[[ Line: 10 ]]
    -- upvalues: v3 (copy), l_SoundService_0 (copy)
    local v5 = v3.new();
    v5:setImage("rbxassetid://104187035779058", "deselected");
    v5:setImage("rbxassetid://77129566920961", "selected");
    v5:setName("Music Icon");
    v5:setImageScale(0.8);
    v5:setOrder(-5);
    v5:setCaption("Toggles music");
    v5.deselectWhenOtherIconSelected = false;
    v5.selected:Connect(function() --[[ Line: 20 ]]
        -- upvalues: l_SoundService_0 (ref)
        for _, v7 in l_SoundService_0.Music_Folder:GetDescendants() do
            if v7:IsA("Sound") then
                v7.PlaybackSpeed = 1;
            end;
        end;
        l_SoundService_0.Music.Volume = 1;
    end);
    v5.deselected:Connect(function() --[[ Line: 30 ]]
        -- upvalues: l_SoundService_0 (ref)
        for _, v9 in l_SoundService_0.Music_Folder:GetDescendants() do
            if v9:IsA("Sound") then
                v9.PlaybackSpeed = 0;
            end;
        end;
        l_SoundService_0.Music.Volume = 0;
    end);
    v5:select();
end);
return {};