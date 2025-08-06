-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v4 = require(l_ReplicatedStorage_0.Modules.Maid).new();
local v5 = false;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v7 = l_Players_0.LocalPlayer or l_Players_0.PlayerAdded:Wait();
local v8 = v7.Character or v7.CharacterAdded:Wait();
local l_v8_Pivot_0 = v8:GetPivot();
local v10 = table.clone(task);
local l_delay_0 = v10.delay;
v10.delay = function(v12, v13) --[[ Line: 26 ]] --[[ Name: delay ]]
    -- upvalues: l_delay_0 (copy)
    local v14 = true;
    l_delay_0(v12, function() --[[ Line: 29 ]]
        -- upvalues: v14 (ref), v13 (copy)
        if v14 then
            v13();
        end;
    end);
    return {
        Cancel = function() --[[ Line: 36 ]] --[[ Name: Cancel ]]
            -- upvalues: v14 (ref)
            v14 = false;
        end, 
        Activate = function() --[[ Line: 39 ]] --[[ Name: Activate ]]
            -- upvalues: v14 (ref), v13 (copy)
            v14 = false;
            v13();
        end
    };
end;
local _ = v10.wait;
local function _() --[[ Line: 47 ]] --[[ Name: StopVelocity ]]
    -- upvalues: v8 (ref)
    local v16 = v8 and v8:FindFirstChild("HumanoidRootPart");
    if not v16 then
        return;
    else
        v16.Velocity = Vector3.new(0, 0, 0, 0);
        return;
    end;
end;
v4:GiveTask(v7.CharacterAdded:Connect(function(v18) --[[ Line: 53 ]]
    -- upvalues: v8 (ref)
    v8 = v18;
end));
v4:GiveTask(l_RunService_0.Stepped:Connect(function() --[[ Line: 57 ]]
    -- upvalues: v5 (ref), v8 (ref), l_CurrentCamera_0 (copy), l_v8_Pivot_0 (ref)
    if v5 then
        local v19 = v8 and v8:FindFirstChild("HumanoidRootPart");
        if v19 then
            v19.Velocity = Vector3.new(0, 0, 0, 0);
        end;
        v19 = l_CurrentCamera_0.CFrame;
        l_v8_Pivot_0 = CFrame.new(l_v8_Pivot_0.Position, l_v8_Pivot_0.Position + v19.LookVector);
        v8:PivotTo(l_v8_Pivot_0);
    end;
end));
local v20 = nil;
local v24 = {
    [Enum.KeyCode.Space] = {
        FLY_UP = function() --[[ Line: 71 ]]
            -- upvalues: l_UserInputService_0 (copy), l_RunService_0 (copy), l_v8_Pivot_0 (ref)
            while l_UserInputService_0:IsKeyDown(Enum.KeyCode.Space) do
                l_RunService_0.Stepped:Wait();
                l_v8_Pivot_0 = l_v8_Pivot_0 * CFrame.new(0, 1, 0);
            end;
        end
    }, 
    [Enum.KeyCode.LeftControl] = {
        FLY_DOWN = function() --[[ Line: 81 ]]
            -- upvalues: l_UserInputService_0 (copy), l_RunService_0 (copy), l_v8_Pivot_0 (ref)
            while l_UserInputService_0:IsKeyDown(Enum.KeyCode.LeftControl) do
                l_RunService_0.Stepped:Wait();
                l_v8_Pivot_0 = l_v8_Pivot_0 * CFrame.new(0, -1, 0);
            end;
        end
    }, 
    [Enum.KeyCode.W] = {
        FLY_FORWARD = function() --[[ Line: 91 ]]
            -- upvalues: l_UserInputService_0 (copy), l_RunService_0 (copy), l_v8_Pivot_0 (ref)
            while l_UserInputService_0:IsKeyDown(Enum.KeyCode.W) do
                l_RunService_0.Stepped:Wait();
                l_v8_Pivot_0 = l_v8_Pivot_0 * CFrame.new(0, 0, -1);
            end;
        end
    }, 
    [Enum.KeyCode.S] = {
        FLY_BACK = function() --[[ Line: 101 ]]
            -- upvalues: l_UserInputService_0 (copy), l_RunService_0 (copy), l_v8_Pivot_0 (ref)
            while l_UserInputService_0:IsKeyDown(Enum.KeyCode.S) do
                l_RunService_0.Stepped:Wait();
                l_v8_Pivot_0 = l_v8_Pivot_0 * CFrame.new(0, 0, 1);
            end;
        end
    }, 
    [Enum.KeyCode.A] = {
        FLY_LEFT = function() --[[ Line: 111 ]]
            -- upvalues: l_UserInputService_0 (copy), l_RunService_0 (copy), l_v8_Pivot_0 (ref)
            while l_UserInputService_0:IsKeyDown(Enum.KeyCode.A) do
                l_RunService_0.Stepped:Wait();
                l_v8_Pivot_0 = l_v8_Pivot_0 * CFrame.new(-1, 0, 0);
            end;
        end
    }, 
    [Enum.KeyCode.D] = {
        FLY_RIGHT = function() --[[ Line: 121 ]]
            -- upvalues: l_UserInputService_0 (copy), l_RunService_0 (copy), l_v8_Pivot_0 (ref)
            while l_UserInputService_0:IsKeyDown(Enum.KeyCode.D) do
                l_RunService_0.Stepped:Wait();
                l_v8_Pivot_0 = l_v8_Pivot_0 * CFrame.new(1, 0, 0);
            end;
        end
    }, 
    [Enum.KeyCode.F] = {
        TOGGLE = function() --[[ Line: 136 ]]
            -- upvalues: v8 (ref), v5 (ref), l_v8_Pivot_0 (ref), v20 (ref), l_RunService_0 (copy), v10 (copy), v4 (copy)
            if not v8:FindFirstChild("Humanoid") then
                return;
            else
                local l_HumanoidRootPart_0 = v8:FindFirstChild("HumanoidRootPart");
                if not l_HumanoidRootPart_0 then
                    return;
                else
                    if not v5 then
                        l_v8_Pivot_0 = v8:GetPivot();
                    else
                        if v20 then
                            v20:Activate();
                        end;
                        local v22 = v8 and v8:FindFirstChild("HumanoidRootPart");
                        if v22 then
                            v22.Velocity = Vector3.new(0, 0, 0, 0);
                        end;
                        v8:PivotTo(CFrame.new(v8:GetPivot().Position));
                        v22 = l_RunService_0.Stepped:Connect(function() --[[ Line: 151 ]]
                            -- upvalues: l_HumanoidRootPart_0 (copy), v8 (ref)
                            local l_AssemblyAngularVelocity_0 = l_HumanoidRootPart_0.AssemblyAngularVelocity;
                            if l_AssemblyAngularVelocity_0.X > 20 or l_AssemblyAngularVelocity_0.Y > 20 or l_AssemblyAngularVelocity_0.Z > 20 then
                                v8:PivotTo(CFrame.new(v8:GetPivot().Position));
                            end;
                        end);
                        v20 = v10.delay(10, function() --[[ Line: 161 ]]
                            -- upvalues: v22 (copy)
                            v22:Disconnect();
                        end);
                        v4:GiveTask(v22);
                    end;
                    v5 = not v5;
                    return;
                end;
            end;
        end
    }
};
local v25 = {
    [Enum.KeyCode.Space] = {
        IGNORE_OFF = function() --[[ Line: 175 ]]

        end
    }
};
local v26 = false;
v4:GiveTask(l_UserInputService_0.InputBegan:Connect(function(v27, _) --[[ Line: 183 ]]
    -- upvalues: v26 (ref), v24 (copy), v10 (copy)
    if not v26 then
        return;
    elseif v27.UserInputType == Enum.UserInputType.Keyboard and v24[v27.KeyCode] then
        for _, v30 in v24[v27.KeyCode] do
            v10.spawn(v30);
        end;
        return;
    else
        if v24[v27.UserInputType] then
            for _, v32 in v24[v27.UserInputType] do
                v10.spawn(v32);
            end;
        end;
        return;
    end;
end));
v4:GiveTask(l_UserInputService_0.InputEnded:Connect(function(v33, _) --[[ Line: 196 ]]
    -- upvalues: v26 (ref), v25 (copy), v10 (copy)
    if not v26 then
        return;
    elseif v33.UserInputType == Enum.UserInputType.Keyboard and v25[v33.KeyCode] then
        for _, v36 in v25[v33.KeyCode] do
            v10.spawn(v36);
        end;
        return;
    else
        if v25[v33.UserInputType] then
            for _, v38 in v25[v33.UserInputType] do
                v10.spawn(v38);
            end;
        end;
        return;
    end;
end));
v10.spawn(function() --[[ Line: 209 ]]
    -- upvalues: v10 (copy), v7 (copy), v5 (ref), v26 (ref)
    while true do
        v10.wait();
        if not ((v7:GetAttribute("Gamemode") or ""):lower() == "creative") then
            v5 = false;
            v26 = false;
        else
            v26 = true;
        end;
    end;
end);