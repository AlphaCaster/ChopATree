-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_Players_0 = game:GetService("Players");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local l_ConfirmSprinkler_0 = l_PlayerGui_0.ConfirmSprinkler;
local v7 = require(l_ReplicatedStorage_0.Modules.EffectController.Libraries.BoatTween);
local v8 = RaycastParams.new();
local v9 = {};
for _, v11 in workspace.Farm:GetChildren() do
	for _, v13 in v11.Important.Plant_Locations:GetChildren() do
		table.insert(v9, v13);
	end;
end;
v8.FilterDescendantsInstances = v9;
v8.FilterType = Enum.RaycastFilterType.Include;
local v14 = os.clock();
local l_Hit_0 = l_l_LocalPlayer_0_Mouse_0.Hit;
local l_Parent_0 = script.Parent;
local v17 = false;
local realName = l_Parent_0:GetAttribute("ItemName")
l_Parent_0.Equipped:Connect(function() --[[ Line: 31 ]]
	-- upvalues: v17 (ref), l_ConfirmSprinkler_0 (copy), l_Parent_0 (copy), v14 (ref), l_ReplicatedStorage_0 (copy), l_l_LocalPlayer_0_Mouse_0 (copy), v8 (copy), v7 (copy)
	v17 = true;
	l_ConfirmSprinkler_0:FindFirstChild("PlacingLabel", true).Text = ("Place %*?"):format(l_Parent_0:GetAttribute("ItemName"));
	v14 = os.clock();
	task.spawn(function() --[[ Line: 39 ]]
		-- upvalues: l_ReplicatedStorage_0 (ref), l_Parent_0 (ref), v17 (ref), l_l_LocalPlayer_0_Mouse_0 (ref), v8 (ref), v7 (ref)
		local v18 = script.SprinklerVisualization:Clone();
		v18.Parent = workspace.Visuals;
		v18.Range.Enabled = true;
		v18.OuterRange.Enabled = true;
		local v19 = l_ReplicatedStorage_0.ObjectModels[l_Parent_0:GetAttribute("ItemName")]:Clone();
		v19.Parent = workspace.Visuals;
		v19:PivotTo(CFrame.new(0, -55, 0));
		for _, v21 in v19:GetDescendants() do
			if v21:IsA("BasePart") then
				v21.Transparency = 0.5;
			end;
		end;
		local l_Size_0 = v18.Size;
		v18.Size = Vector3.new(0, 0, 0, 0);
		local v23 = nil;
		local v24 = nil;
		local v25 = false;
		while v17 do
			local l_Hit_1 = l_l_LocalPlayer_0_Mouse_0.Hit;
			local v27 = workspace:Raycast(l_Hit_1.Position + Vector3.new(0, 10, 0, 0), Vector3.new(-0, -20, -0, -0), v8);
			if v27 then
				local l_Image_0 = v18.OuterRange.Image;
				l_Image_0.Rotation = l_Image_0.Rotation + 0.2;
				if not v25 then
					if v24 then
						v24:Stop();
					end;
					v23 = v7:Create(v18, {
						Time = 0.3, 
						EasingStyle = "Smoother", 
						EasingDirection = "In", 
						StepType = "Heartbeat", 
						Goal = {
							Size = l_Size_0
						}
					});
					v23:Play();
					v25 = true;
				end;
				v19:PivotTo(CFrame.new(v27.Position) * CFrame.new(0, v18.Size.Y / 2, 0));
				v18:PivotTo(CFrame.new(v27.Position) * CFrame.new(0, v18.Size.Y / 2, 0));
			elseif v25 then
				if v23 then
					v23:Stop();
				end;
				v24 = v7:Create(v18, {
					Time = 0.3, 
					EasingStyle = "Smoother", 
					EasingDirection = "Out", 
					StepType = "Heartbeat", 
					Goal = {
						Size = Vector3.new(0, 0, 0, 0)
					}
				});
				v19:PivotTo(v19:GetPivot() * CFrame.new(0, -10, 0));
				v24:Play();
				v25 = false;
			end;
			task.wait();
		end;
		v19:Destroy();
		v18:Destroy();
	end);
end);
l_Parent_0.Unequipped:Connect(function() --[[ Line: 128 ]]
	-- upvalues: v17 (ref)
	v17 = false;
end);
local l_Sprinkler_RE_0 = l_ReplicatedStorage_0.GameEvents.Sprinkler_RE;
local v30 = nil;
local _ = function() --[[ Line: 136 ]] --[[ Name: IsMouseOverUI ]]
	-- upvalues: l_PlayerGui_0 (copy), l_l_LocalPlayer_0_Mouse_0 (copy)
	for _, v32 in l_PlayerGui_0:GetGuiObjectsAtPosition(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y) do
		if v32.BackgroundTransparency ~= 1 and v32.Visible then
			return true;
		end;
	end;
end;
local function v41(v34) --[[ Line: 147 ]] --[[ Name: CheckDistance ]]
	-- upvalues: l_PlayerGui_0 (copy), l_l_LocalPlayer_0_Mouse_0 (copy), v8 (copy), l_ReplicatedStorage_0 (copy), l_LocalPlayer_0 (copy)
	local v35 = false;
	local v36;
	for _, v38 in l_PlayerGui_0:GetGuiObjectsAtPosition(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y) do
		if v38.BackgroundTransparency ~= 1 and v38.Visible then
			v36 = true;
			v35 = true;
		end;
		if v35 then
			break;
		end;
	end;
	if not v35 then
		v36 = nil;
	end;
	v35 = false;
	if v36 then
		return;
	else
		v36 = workspace:Raycast(v34.Position + Vector3.new(0, 10, 0, 0), Vector3.new(-0, -20, -0, -0), v8);
		if not v36 or not v36.Instance or not v36.Position then
			require(l_ReplicatedStorage_0.Modules.Notification):CreateNotification("You can only place this in plots!");
			return false;
		else
			local l_Character_0 = l_LocalPlayer_0.Character;
			local v40 = l_Character_0 and l_Character_0:FindFirstChild("HumanoidRootPart");
			if not v40 then
				return false;
			elseif (v40.Position - v36.Position).Magnitude > 50 then
				require(l_ReplicatedStorage_0.Modules.Notification):CreateNotification("Too far away! Try getting closer.");
				return false;
			else
				return v36;
			end;
		end;
	end;
end;
local function _(v42) --[[ Line: 181 ]] --[[ Name: AttemptPlacement ]]
	-- upvalues: l_Parent_0 (copy), v17 (ref), v41 (copy), v30 (ref), l_Sprinkler_RE_0 (copy)
	if not l_Parent_0 then
		return;
	elseif not v17 then
		return;
	elseif not v41(v42) then
		return;
	else
		--v30:Disconnect();
		--v17 = false;
		l_Sprinkler_RE_0:FireServer(l_Parent_0, v42);
		return;
	end;
end;
local l_l_ConfirmSprinkler_0_FirstChild_0 = l_ConfirmSprinkler_0:FindFirstChild("Confirm", true);
local l_l_ConfirmSprinkler_0_FirstChild_1 = l_ConfirmSprinkler_0:FindFirstChild("Cancel", true);
l_l_ConfirmSprinkler_0_FirstChild_0.MouseButton1Click:Connect(function() --[[ Line: 197 ]]
	-- upvalues: l_ConfirmSprinkler_0 (copy), l_Hit_0 (ref), l_Parent_0 (copy), v17 (ref), v41 (copy), v30 (ref), l_Sprinkler_RE_0 (copy)
	l_ConfirmSprinkler_0.Enabled = false;
	local l_l_Hit_0_0 = l_Hit_0;
	if not l_Parent_0 then
		return;
	elseif not v17 then
		return;
	elseif not v41(l_l_Hit_0_0) then
		return;
	else
		----v30:Disconnect();
		--v17 = false;
		l_Sprinkler_RE_0:FireServer(l_Parent_0, l_l_Hit_0_0);
		return;
	end;
end);
l_l_ConfirmSprinkler_0_FirstChild_1.MouseButton1Click:Connect(function() --[[ Line: 203 ]]
	-- upvalues: v14 (ref), l_ConfirmSprinkler_0 (copy)
	v14 = os.clock();
	l_ConfirmSprinkler_0.Enabled = false;
end);
v30 = if l_UserInputService_0.TouchEnabled then l_UserInputService_0.TouchTapInWorld:Connect(function() --[[ Line: 210 ]]
	-- upvalues: v17 (ref), v14 (ref), v41 (copy), l_l_LocalPlayer_0_Mouse_0 (copy), l_Hit_0 (ref), l_ConfirmSprinkler_0 (copy)
	if not v17 or os.clock() < v14 + 0.1 or not v41(l_l_LocalPlayer_0_Mouse_0.Hit) then
		return;
		else
		v14 = os.clock();
		l_Hit_0 = l_l_LocalPlayer_0_Mouse_0.Hit;
		l_ConfirmSprinkler_0.Enabled = true;
		return;
	end;
end) else l_UserInputService_0.InputBegan:Connect(function(v47) --[[ Line: 219 ]]
		-- upvalues: l_l_LocalPlayer_0_Mouse_0 (copy), l_Parent_0 (copy), v17 (ref), v41 (copy), v30 (ref), l_Sprinkler_RE_0 (copy)
		if v47.UserInputType ~= Enum.UserInputType.MouseButton1 and v47.KeyCode ~= Enum.KeyCode.ButtonR2 then
			return;
		else
			local l_Hit_2 = l_l_LocalPlayer_0_Mouse_0.Hit;
			if not l_Parent_0 then
				return;
			elseif not v17 then
				return;
			elseif not v41(l_Hit_2) then
				return;
			else
				----v30:Disconnect();
				-- v17 = false;
				l_Sprinkler_RE_0:FireServer(l_Parent_0, l_Hit_2);
				return;
			end;
		end;
	end);