-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_PlayerGui_0 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local l_SortBackpackEvent_0 = game:GetService("ReplicatedStorage").GameEvents:WaitForChild("SortBackpackEvent");
local l_Inventory_0 = l_PlayerGui_0:WaitForChild("BackpackGui"):WaitForChild("Backpack"):WaitForChild("Inventory");
local l_TextButton_0 = Instance.new("TextButton");
l_TextButton_0.Name = "SortButton";
l_TextButton_0.Text = "Sort";
l_TextButton_0.Size = UDim2.new(0, 80, 0, 30);
l_TextButton_0.Position = UDim2.new(1, 10, 0.5, -15);
l_TextButton_0.AnchorPoint = Vector2.new(0, 0.5);
l_TextButton_0.BackgroundColor3 = Color3.fromRGB(50, 50, 50);
l_TextButton_0.TextColor3 = Color3.fromRGB(255, 255, 255);
l_TextButton_0.Parent = l_Inventory_0;
l_Inventory_0:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 20 ]]
    -- upvalues: l_TextButton_0 (copy), l_Inventory_0 (copy)
    l_TextButton_0.Visible = l_Inventory_0.Visible;
end);
l_TextButton_0.Visible = l_Inventory_0.Visible;
l_TextButton_0.MouseButton1Click:Connect(function() --[[ Line: 25 ]]
    -- upvalues: l_SortBackpackEvent_0 (copy)
    l_SortBackpackEvent_0:FireServer();
end);