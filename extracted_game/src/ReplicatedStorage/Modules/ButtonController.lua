-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_SoundService_0 = game:GetService("SoundService");
local l_Players_0 = game:GetService("Players");
local v3 = require(l_ReplicatedStorage_0.Modules.Trove);
local v4 = require(l_ReplicatedStorage_0.Modules.Observers);
local v5 = require(l_ReplicatedStorage_0.Modules.DeviceController);
local l_Hover_0 = l_SoundService_0.Hover;
local l_Click_0 = l_SoundService_0.Click;
local v13 = {
    Start = function(_) --[[ Line: 15 ]] --[[ Name: Start ]]
        -- upvalues: v4 (copy), v3 (copy), v5 (copy), l_Hover_0 (copy), l_Click_0 (copy), l_Players_0 (copy)
        v4.observeTag("Button", function(v9) --[[ Line: 16 ]]
            -- upvalues: v3 (ref), v5 (ref), l_Hover_0 (ref), l_Click_0 (ref)
            if not v9:IsA("GuiButton") then
                return nil;
            else
                local v10 = v3.new();
                local v11 = v10:Extend();
                v10:Add(v5:Observe(function(v12) --[[ Line: 24 ]]
                    -- upvalues: v11 (copy), v9 (copy), l_Hover_0 (ref)
                    v11:Clean();
                    if v12 == "PC" then
                        v11:Add(v9.MouseEnter:Connect(function() --[[ Line: 28 ]]
                            -- upvalues: l_Hover_0 (ref)
                            l_Hover_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                            l_Hover_0.TimePosition = 0;
                            l_Hover_0.Playing = true;
                        end));
                    end;
                end));
                v10:Add(v9.Activated:Connect(function() --[[ Line: 36 ]]
                    -- upvalues: l_Click_0 (ref)
                    l_Click_0.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                    l_Click_0.TimePosition = 0;
                    l_Click_0.Playing = true;
                end));
                return v10:WrapClean();
            end;
        end, {
            workspace, 
            l_Players_0.LocalPlayer.PlayerGui
        });
    end
};
task.spawn(v13.Start, v13);
return v13;