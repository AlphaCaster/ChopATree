-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_TweenService_0 = game:GetService("TweenService");
v0.Start_Cutscene = function(v2) --[[ Line: 5 ]] --[[ Name: Start_Cutscene ]]
    local l_CurrentCamera_0 = game.Workspace.CurrentCamera;
    local v4 = nil;
    for _, v6 in pairs(game.Workspace.Farm:GetChildren()) do
        if v6.Important.Data.Owner == v2.Name then
            v4 = v6;
        end;
    end;
    if v4 then
        l_CurrentCamera_0.CameraSubject = v4.Cutscene_Model.Orbit_Camera;
        l_CurrentCamera_0.CameraType = Enum.CameraType.Fixed;
    end;
end;
v0.End_Cutscene = function(v7) --[[ Line: 19 ]] --[[ Name: End_Cutscene ]]
    local l_CurrentCamera_1 = game.Workspace.CurrentCamera;
    l_CurrentCamera_1.CameraSubject = v7.Character.Humanoid;
    l_CurrentCamera_1.CameraType = Enum.CameraType.Fixed;
end;
local v9 = require(game.ReplicatedStorage.Field_Of_View_Module);
v0.Flash = function(v10, v11) --[[ Line: 25 ]] --[[ Name: Flash ]]
    -- upvalues: l_TweenService_0 (copy), v9 (copy)
    local v12 = TweenInfo.new(v11, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0);
    local v13 = TweenInfo.new(v11 * 4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
    local l_Frame_0 = v10.PlayerGui.Rejoin_UI.Frame;
    l_TweenService_0:Create(l_Frame_0, v12, {
        BackgroundTransparency = 0
    }):Play();
    v9.Change_FOV(90, v12.Time);
    task.spawn(function() --[[ Line: 32 ]]
        -- upvalues: v12 (copy), v9 (ref), v13 (copy), l_TweenService_0 (ref), l_Frame_0 (copy)
        task.wait(v12.Time + 1.5);
        v9.Change_FOV(70, v13.Time / 2);
        l_TweenService_0:Create(l_Frame_0, v13, {
            BackgroundTransparency = 1
        }):Play();
    end);
end;
return v0;