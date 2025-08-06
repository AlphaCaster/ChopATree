-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

task.wait(1);
local l_Current_Biome_0 = game.Players.LocalPlayer:WaitForChild("Current_Biome"); -- TODO: add this
local l_TweenService_0 = game:GetService("TweenService");
local v2 = {};
for _, v4 in pairs(game.SoundService.Music_Folder:GetChildren()) do
    table.insert(v2, {
        v4, 
        v4:GetChildren()[1]
    });
end;
for _, v6 in pairs(v2) do
    for _, v8 in pairs(v6[1]:GetChildren()) do
        v8.Volume = 0;
    end;
end;
local v9 = nil;
for _, v11 in pairs(v2) do
    task.spawn(function() --[[ Line: 15 ]]
        -- upvalues: v11 (copy)
        while true do
            local v12 = v11[1]:GetChildren()[math.random(1, #v11[1]:GetChildren())];
            v11[2] = v12;
            task.wait(v12.TimeLength);
        end;
    end);
end;
local v13 = nil;
Turn_Off = function(v14, v15) --[[ Line: 24 ]] --[[ Name: Turn_Off ]]
    -- upvalues: l_TweenService_0 (copy)
    local v16 = TweenInfo.new(v15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
    l_TweenService_0:Create(v14, v16, {
        Volume = 0
    }):Play();
end;
Turn_On = function(v17, v18) --[[ Line: 29 ]] --[[ Name: Turn_On ]]
    -- upvalues: l_TweenService_0 (copy)
    local v19 = TweenInfo.new(v18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
    l_TweenService_0:Create(v17, v19, {
        Volume = 0.2
    }):Play();
end;
UPD = function() --[[ Line: 34 ]] --[[ Name: UPD ]]
    -- upvalues: v2 (copy), v13 (ref), v9 (ref)
    task.spawn(function() --[[ Line: 35 ]]
        -- upvalues: v2 (ref), v13 (ref), v9 (ref)
        local v20 = false;
        while v20 == false do
            task.wait();
            for _, v22 in pairs(game.SoundService.Music_Folder:GetDescendants()) do
                if v22:IsA("Sound") and v22.Playing == true then
                    v20 = true;
                end;
            end;
            local v23 = nil;
            for _, v25 in pairs(v2) do
                if v25[1] == v13 then
                    v23 = v25[2];
                end;
            end;
            if v9 ~= v23 and v9 ~= nil then
                Turn_Off(v9, 1);
            end;
            v9 = v23;
            if v23 then
                v23.Playing = true;
                Turn_On(v23, 1);
            end;
        end;
    end);
end;
UPD();
ok = function() --[[ Line: 64 ]] --[[ Name: ok ]]
    -- upvalues: v2 (copy), l_Current_Biome_0 (copy), v13 (ref)
    if game.ReplicatedStorage.Night_Time.Value == false then
        for _, v27 in pairs(v2) do
            if v27[1].Name == l_Current_Biome_0.Value then
                v13 = v27[1];
            end;
        end;
        UPD();
    end;
end;
ok();
l_Current_Biome_0:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 75 ]]
    ok();
end);
game.ReplicatedStorage.Night_Time:GetPropertyChangedSignal("Value"):Connect(function() --[[ Line: 78 ]]
    -- upvalues: v2 (copy), v13 (ref), v9 (ref), l_Current_Biome_0 (copy)
    if game.ReplicatedStorage.Night_Time.Value == true then
        for _, v29 in pairs(v2) do
            if v29[1].Name ~= "Night_Time" then
                for _, v31 in pairs(v29[1]:GetChildren()) do
                    Turn_Off(v31, 7);
                end;
            end;
        end;
        for _, v33 in pairs(v2) do
            if v33[1].Name == "Night_Time" then
                v13 = v33[1];
            end;
        end;
        local v34 = nil;
        for _, v36 in pairs(v2) do
            if v36[1] == v13 then
                v34 = v36[2];
            end;
        end;
        if v9 ~= v34 and v9 ~= nil then
            Turn_Off(v9, 7);
        end;
        v9 = v34;
        if v34 then
            v34.Playing = true;
            Turn_On(v34, 7);
            return;
        end;
    else
        for _, v38 in pairs(v2) do
            if v38[1].Name == l_Current_Biome_0.Value then
                v13 = v38[1];
            end;
        end;
        local v39 = nil;
        for _, v41 in pairs(v2) do
            if v41[1] == v13 then
                v39 = v41[2];
            end;
        end;
        if v9 ~= v39 and v9 ~= nil then
            Turn_Off(v9, 7);
        end;
        v9 = v39;
        if v39 then
            v39.Playing = true;
            Turn_On(v39, 7);
        end;
    end;
end);