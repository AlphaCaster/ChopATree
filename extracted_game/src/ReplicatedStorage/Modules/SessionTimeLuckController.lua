-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v2 = require(l_ReplicatedStorage_0.Data.SessionTimeLuckData);
local v3 = require(l_ReplicatedStorage_0.Modules.GetFarm);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v19 = {
    GetCurrentLuck = function(_, player) --[[ Line: 12 ]] --[[ Name: GetCurrentLuck ]]
		-- upvalues: l_LocalPlayer_0 (copy), v2 (copy)
		local player = player or l_LocalPlayer_0
		if player:GetAttribute("SessionTimeLuckDisabled") then
            return 0;
        else
			local v6 = player:GetAttribute("SessionTimeLuckIndex") or 1;
            local v7 = v2.Timer[v6 or 1];
            if not v7 then
                return 0;
            else
                return v7.Luck;
            end;
        end;
    end, 
    Start = function(_) --[[ Line: 26 ]] --[[ Name: Start ]]
        -- upvalues: v3 (copy), l_LocalPlayer_0 (copy), l_ReplicatedStorage_0 (copy), v2 (copy)
        local v9 = nil;
        while not v9 do
            v9 = v3(l_LocalPlayer_0);
            if not v9 then
                task.wait(1);
            else
                break;
            end;
        end;
        local v10 = l_ReplicatedStorage_0.Assets.Models.Luckboard:Clone();
        local v11 = v9:WaitForChild("LuckboardSpawn", 999);
        if not v11 then
            v10:Destroy();
            return;
        else
            v10:PivotTo(v11:GetPivot());
            for v12, v13 in v2.Timer do
                local l_FirstChild_0 = v10.Main.SurfaceGui.Frame:FindFirstChild((tostring(v12)));
                if l_FirstChild_0 then
                    l_FirstChild_0.Seconds.Text = ("%* Minutes"):format(v13.Time // 60);
                    l_FirstChild_0.TextLabel.Text = ("+%*%% Luck"):format(v13.Luck * 100);
                end;
            end;
            local l_TextLabel_0 = v10.Main.SurfaceGui.Frame.ActiveBoost.TextLabel;
            local function v18() --[[ Line: 59 ]] --[[ Name: update ]]
                -- upvalues: l_LocalPlayer_0 (ref), v10 (copy), l_ReplicatedStorage_0 (ref), v2 (ref), l_TextLabel_0 (copy)
                if l_LocalPlayer_0:GetAttribute("SessionTimeLuckDisabled") then
                    v10.Parent = l_ReplicatedStorage_0;
                    return;
                else
                    v10.Parent = workspace.MapDecorations;
                    local v16 = l_LocalPlayer_0:GetAttribute("SessionTimeLuckIndex") or 1;
                    local v17 = v2.Timer[v16 or 1];
                    l_TextLabel_0.Text = if v17 then ("+%*%% Luck"):format(v17.Luck * 100) else "1x Luck";
                    return;
                end;
            end;
            l_LocalPlayer_0:GetAttributeChangedSignal("SessionTimeLuckIndex"):Connect(v18);
            l_LocalPlayer_0:GetAttributeChangedSignal("SessionTimeLuckDisabled"):Connect(v18);
            task.spawn(v18);
            return;
        end;
    end
};
task.spawn(v19.Start, v19);
return v19;