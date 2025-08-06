-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_LocalPlayer_0 = game.Players.LocalPlayer;
local v1 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
local l_HumanoidRootPart_0 = v1:WaitForChild("HumanoidRootPart");
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local v5 = nil;
local v6 = nil;
local v7 = game.Workspace:FindFirstChild("Player_Orientation_References") or Instance.new("Folder", game.Workspace);
v7.Name = "Player_Orientation_References";
local v8 = game.ReplicatedStorage.REF:Clone();
v8.Parent = v7;
v8.Anchored = true;
v8.CanCollide = false;
v8.Name = l_LocalPlayer_0.Name;
v8.Transparency = 1;
local v9 = Instance.new("Attachment", v8);
local v10 = Instance.new("Attachment", l_HumanoidRootPart_0);
local v11 = Instance.new("AlignOrientation", v8);
v11.Attachment0 = v10;
v11.Attachment1 = v9;
v11.MaxAngularVelocity = 3000000000;
v11.MaxTorque = 3000000000;
v11.Enabled = false;
if not l_UserInputService_0.TouchEnabled then
    l_RunService_0.RenderStepped:Connect(function() --[[ Line: 31 ]]
        -- upvalues: v5 (ref), l_UserInputService_0 (copy), l_HumanoidRootPart_0 (copy), v11 (copy), v8 (copy)
        if v5 == true then
            local l_CurrentCamera_0 = workspace.CurrentCamera;
            local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
            local v14 = l_CurrentCamera_0:ViewportPointToRay(l_l_UserInputService_0_MouseLocation_0.X, l_l_UserInputService_0_MouseLocation_0.Y);
            local l_Origin_0 = v14.Origin;
            local l_Direction_0 = v14.Direction;
            local v17 = l_Origin_0 + l_Direction_0 * ((l_HumanoidRootPart_0.Position.Y - l_Origin_0.Y) / l_Direction_0.Y);
            local l_Position_0 = l_HumanoidRootPart_0.Position;
            local l_Unit_0 = (v17 - l_Position_0).Unit;
            v11.Enabled = true;
            v8.Position = l_Position_0;
            v8.CFrame = CFrame.new(l_Position_0, l_Position_0 + l_Unit_0);
        end;
    end);
    v1.ChildAdded:Connect(function(v20) --[[ Line: 54 ]]
        if not v20:IsA("Tool") or string.find(v20.Name, "Watering") then

        end;
    end);
    v1.ChildRemoved:Connect(function(_) --[[ Line: 60 ]]
        -- upvalues: v1 (copy), v5 (ref), v11 (copy)
        if v1:FindFirstChildWhichIsA("Tool") == nil then
            v5 = false;
            v11.Enabled = false;
        end;
    end);
    l_UserInputService_0.InputBegan:Connect(function(v22) --[[ Line: 67 ]]
        -- upvalues: v6 (ref)
        if v22.UserInputType == Enum.UserInputType.MouseButton1 then
            v6 = true;
        end;
    end);
    l_UserInputService_0.InputEnded:Connect(function(v23) --[[ Line: 73 ]]
        -- upvalues: v6 (ref), v11 (copy)
        if v23.UserInputType == Enum.UserInputType.MouseButton1 then
            v6 = false;
            v11.Enabled = false;
        end;
    end);
end;