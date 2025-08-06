local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_PetEquipSlots_UI_0 = l_LocalPlayer_0:WaitForChild("PlayerGui"):WaitForChild("PetEquipSlots_UI");
local l_Trading_0 = l_PetEquipSlots_UI_0:WaitForChild("Trading");
local l_GameEvents_0 = l_ReplicatedStorage_0:WaitForChild("GameEvents");
local v6 = require(l_ReplicatedStorage_0.Modules.PetServices.PetUtilities);
local v7 = require(l_ReplicatedStorage_0.Modules.DataService);
local l_PetList_0 = require(l_ReplicatedStorage_0.Data.PetRegistry).PetList;
local v9 = require(l_ReplicatedStorage_0.Modules.GuiController);
local l_TradeIn_0 = l_Trading_0.Main.Holder.TradeInButton.TradeIn;
local l_Details_0 = l_Trading_0:WaitForChild("Details");
local l_TradeInButton_0 = l_Trading_0.Main.Holder.TradeInButton;
local l_Confirm_0 = l_TradeInButton_0.Confirm;
local l_Cancel_0 = l_TradeInButton_0.Cancel;
local l_TradeIn_1 = l_TradeInButton_0.TradeIn;
local l_REQUIRED_AGE_0 = l_Trading_0.Main.Holder.TextHolder.REQUIRED_AGE;
local v17 = {};
local v18 = {
	Pet = "Pet", 
	Egg = "Egg", 
	EggInfo = "EggInfo"
};
v17.CurrentMode = v18.Pet;
local v19 = nil;
local v20 = {
	[0] = UDim2.new(1, 0, 0, 0), 
	[1] = UDim2.new(1, 0, 0.175, 0), 
	[2] = UDim2.new(1, 0, 0.375, 0), 
	[3] = UDim2.new(1, 0, 0.575, 0), 
	[4] = UDim2.new(1, 0, 0.775, 0), 
	[5] = UDim2.new(1, 0, 1, 0)
};
local function v24(v21) --[[ Line: 45 ]] --[[ Name: TweenDetails ]]
	-- upvalues: l_TweenService_0 (copy), l_Details_0 (copy)
	local v22 = {
		Position = v21 and UDim2.new(0.8, 0, 0.5, 0) or UDim2.new(0.6, 0, 0.5, 0)
	};
	local v23 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
	l_TweenService_0:Create(l_Details_0, v23, v22):Play();
end;
local function _(v25) --[[ Line: 53 ]] --[[ Name: SetTradeButtonEnabled ]]
	-- upvalues: l_TradeIn_0 (copy)
	l_TradeIn_0.BackgroundTransparency = v25 and 0 or 0.5;
	l_TradeIn_0.UIStroke.Transparency = v25 and 0 or 0.5;
	l_TradeIn_0.TextLabel.TextTransparency = v25 and 0 or 0.5;
end;
local function _(v27) --[[ Line: 59 ]] --[[ Name: SetTradeConfirmationVisible ]]
	-- upvalues: l_TradeIn_1 (copy), l_Confirm_0 (copy), l_Cancel_0 (copy)
	l_TradeIn_1.Visible = not v27;
	l_Confirm_0.Visible = v27;
	l_Cancel_0.Visible = v27;
end;
v17.SetMode = function(v29, v30) --[[ Line: 66 ]] --[[ Name: SetMode ]]
	-- upvalues: v19 (ref), v24 (copy), l_TradeIn_0 (copy), l_TradeIn_1 (copy), l_Confirm_0 (copy), l_Cancel_0 (copy), v18 (copy), l_Trading_0 (copy)
	v29.CurrentMode = v30;
	v19 = nil;
	v24(false);
	l_TradeIn_0.BackgroundTransparency = 0.5;
	l_TradeIn_0.UIStroke.Transparency = 0.5;
	l_TradeIn_0.TextLabel.TextTransparency = 0.5;
	l_TradeIn_1.Visible = true;
	l_Confirm_0.Visible = false;
	l_Cancel_0.Visible = false;
	local v31 = true;
	if v30 ~= v18.Pet then
		v31 = v30 == v18.Egg;
	end;
	l_Trading_0.Main.Holder.ScrollingFrame.Visible = v31;
	l_Trading_0.Main.Holder.TradeInButton.Visible = v31;
	l_Trading_0.Main.Holder.TextHolder.Visible = v31;
	l_Trading_0.Main.BAR.Visible = v31;
	l_Trading_0.Main.Holder.EggInfo.Visible = not v31;
	if v31 then
		v29:RefreshUI();
		return;
	else
		l_Trading_0.Main.Header.Title.Text = "Egg Rarity Info";
		l_Trading_0.Main.Header.BackgroundColor3 = Color3.fromRGB(35, 150, 238);
		l_Trading_0.Main.Header.Title.UIStroke.Color = Color3.fromRGB(17, 74, 117);
		return;
	end;
end;
local function v37(v32) --[[ Line: 90 ]] --[[ Name: UpdateDetails ]]
	-- upvalues: l_PetList_0 (copy), v6 (copy), l_Details_0 (copy)
	local v33 = l_PetList_0[v32.PetType];
	local l_PetData_0 = v32.PetData;
	local l_Level_0 = l_PetData_0.Level;
	local v36 = math.round(v6:CalculateWeight(l_PetData_0.BaseWeight, l_Level_0) * 100) / 100;
	l_Details_0.Holder.Header.PET_TEXT.Text = v32.PetType or "Unknown";
	l_Details_0.Holder.Display.Display.PET_NAME_CONFIG.Text = l_PetData_0.Name or "Unnamed";
	l_Details_0.Holder.Display.Display.PET_IMAGE.Image = v33.Icon or "";
	l_Details_0.Holder.Description.Display.PET_DESCRIPTION.Text = v33.Description or "No description available.";
	l_Details_0.Holder.Stats.Holder.Weight.PET_WEIGHT.Text = ("Weight: %* KG"):format(v36);
	l_Details_0.Holder.Stats.Holder.Age.PET_AGE.Text = ("Age: %*"):format(l_Level_0);
end;
v17.Show = function(v38) --[[ Line: 104 ]] --[[ Name: Show ]]
	-- upvalues: l_PetEquipSlots_UI_0 (copy)
	l_PetEquipSlots_UI_0.Enabled = true;
	v38:SetMode(v38.CurrentMode);
	v38:RefreshUI();
end;
v17.Hide = function(_) --[[ Line: 110 ]] --[[ Name: Hide ]]
	-- upvalues: l_PetEquipSlots_UI_0 (copy)
	l_PetEquipSlots_UI_0.Enabled = false;
end;
v17.RefreshUI = function(_) --[[ Line: 114 ]] --[[ Name: RefreshUI ]]
	-- upvalues: v19 (ref), v24 (copy), l_TradeIn_0 (copy), l_TradeIn_1 (copy), l_Confirm_0 (copy), l_Cancel_0 (copy), v7 (copy), v17 (copy), l_Trading_0 (copy), v20 (copy), v6 (copy), l_LocalPlayer_0 (copy), l_PetList_0 (copy), v37 (copy)
	v19 = nil;
	v24(false);
	l_TradeIn_0.BackgroundTransparency = 0.5;
	l_TradeIn_0.UIStroke.Transparency = 0.5;
	l_TradeIn_0.TextLabel.TextTransparency = 0.5;
	l_TradeIn_1.Visible = true;
	l_Confirm_0.Visible = false;
	l_Cancel_0.Visible = false;
	local l_v7_Data_0 = v7:GetData();
	local _ = l_v7_Data_0.PetsData.MutableStats;
	local v43 = v17.CurrentMode == "Pet";
	local v44 = if v43 then l_v7_Data_0.PetsData.PurchasedEquipSlots or 0 else l_v7_Data_0.PetsData.PurchasedEggSlots or 0;
	local v45 = ({
		20, 
		30, 
		45, 
		60, 
		75
	})[v44 + 1] or 999;
	if v17.CurrentMode == "Pet" then
		l_Trading_0.Main.Header.Title.Text = "Trade in Pets for Extra Pet Equip Slots!";
		l_Trading_0.Main.Header.BackgroundColor3 = Color3.fromRGB(255, 175, 21);
		l_Trading_0.Main.Header.Title.UIStroke.Color = Color3.fromRGB(134, 87, 11);
	elseif v17.CurrentMode == "Egg" then
		l_Trading_0.Main.Header.Title.Text = "Trade in Pets for Extra Egg Equip Slots!";
		l_Trading_0.Main.Header.BackgroundColor3 = Color3.fromRGB(83, 171, 52);
		l_Trading_0.Main.Header.Title.UIStroke.Color = Color3.fromRGB(57, 100, 47);
	end;
	if v44 >= 5 then
		l_Trading_0.Main.Holder.TextHolder.REQUIRED_AGE.Text = "You have reached the maximum amount of pet equip slots!";
		l_Trading_0.Main.Holder.ScrollingFrame.Visible = false;
		l_Trading_0.Main.Holder.TradeInButton.Visible = false;
	elseif v43 or v17.CurrentMode == "Egg" then
		l_Trading_0.Main.Holder.TextHolder.REQUIRED_AGE.Text = ("Required age for next pet equip slot unlock: <font color=\"#ffbe19\">%*</font>"):format(v45);
		l_Trading_0.Main.Holder.ScrollingFrame.Visible = true;
		l_Trading_0.Main.Holder.TradeInButton.Visible = true;
	end;
	l_Trading_0.Main.BAR.ACTUAL_BAR.Size = v20[math.clamp(v44, 0, 5)] or v20[0];
	local l_IncrementalListing_0 = l_Trading_0.Main.BAR.IncrementalListing;
	local v47 = {
		"One", 
		"Two", 
		"Three", 
		"Four", 
		"Five"
	};
	for v48 = 1, 5 do
		local l_l_IncrementalListing_0_FirstChild_0 = l_IncrementalListing_0:FindFirstChild(v47[v48]);
		if l_l_IncrementalListing_0_FirstChild_0 then
			local v50 = v48 <= v44;
			local l_UIGradient_0 = l_l_IncrementalListing_0_FirstChild_0:FindFirstChildWhichIsA("UIGradient");
			if l_UIGradient_0 then
				l_UIGradient_0.Enabled = v50;
			end;
		end;
	end;
	local l_Title_0 = l_IncrementalListing_0:FindFirstChild("Title");
	if l_Title_0 and l_Title_0:FindFirstChild("UIGradient") then
		l_Title_0.UIGradient.Enabled = v44 >= 5;
	end;
	local l_Content_0 = l_Trading_0.Main.Holder.ScrollingFrame.Content;
	local l_TEMPLATE_0 = l_Content_0:FindFirstChild("TEMPLATE");
	for _, v56 in l_Content_0:GetChildren() do
		if v56:IsA("ImageButton") and v56.Name ~= "TEMPLATE" then
			v56:Destroy();
		end;
	end;
	l_TEMPLATE_0.Visible = false;
	local l_v6_PetsSortedByAge_0 = v6:GetPetsSortedByAge(l_LocalPlayer_0, 0, true);
	if v44 >= 5 then
		l_TradeIn_0.BackgroundTransparency = 0.5;
		l_TradeIn_0.UIStroke.Transparency = 0.5;
		l_TradeIn_0.TextLabel.TextTransparency = 0.5;
		return;
	else
		for _, v59 in l_v6_PetsSortedByAge_0 do
			if v59.PetData.Level >= v45 then
				local v60 = l_PetList_0[v59.PetType];
				local v61 = l_TEMPLATE_0:Clone();
				v61.Visible = true;
				v61.Name = v59.UUID;
				v61.Display.PET_NAME.Text = v59.PetType or "Unknown";
				v61.Display.PET_AGE.Text = v59.PetData.Level or "1";
				v61.Display.DetailHolder.PET_IMAGE.Image = v60.Icon or "";
				local function v64(v62, v63) --[[ Line: 204 ]] --[[ Name: SetSelectedStyle ]]
					if v63 then
						v62.Display.BackgroundColor3 = Color3.fromRGB(30, 100, 14);
						v62.Display.UIStroke.Color = Color3.fromRGB(37, 238, 38);
						v62.Display.SELECTED_VIGNETTE.Visible = true;
						return;
					else
						v62.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18);
						v62.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0);
						v62.Display.SELECTED_VIGNETTE.Visible = false;
						return;
					end;
				end;
				v64(v61, false);
				v61.MouseButton1Click:Connect(function() --[[ Line: 218 ]]
					-- upvalues: v19 (ref), v59 (copy), l_Content_0 (copy), v64 (copy), l_TradeIn_0 (ref), v37 (ref), v24 (ref)
					if v19 == v59.UUID then
						v19 = nil;
					else
						v19 = v59.UUID;
					end;
					for _, v66 in l_Content_0:GetChildren() do
						if v66:IsA("ImageButton") and v66:FindFirstChild("Display") then
							local v67 = v66.Name == v19;
							v64(v66, v67);
						end;
					end;
					local v68 = v19 ~= nil;
					l_TradeIn_0.BackgroundTransparency = v68 and 0 or 0.5;
					l_TradeIn_0.UIStroke.Transparency = v68 and 0 or 0.5;
					l_TradeIn_0.TextLabel.TextTransparency = v68 and 0 or 0.5;
					if v19 then
						v37(v59);
						v24(true);
						return;
					else
						v24(false);
						return;
					end;
				end);
				v61.Parent = l_Content_0;
				l_TradeIn_0.BackgroundTransparency = 0.5;
				l_TradeIn_0.UIStroke.Transparency = 0.5;
				l_TradeIn_0.TextLabel.TextTransparency = 0.5;
			end;
		end;
		return;
	end;
end;
v17.OpenEggInfoExternally = function(v69) --[[ Line: 248 ]] --[[ Name: OpenEggInfoExternally ]]
	-- upvalues: v18 (copy)
	v69:SetMode(v18.EggInfo);
end;
local v70 = {};
local function _(v71, v72) --[[ Line: 253 ]] --[[ Name: IsDebounced ]]
	-- upvalues: v70 (copy)
	v72 = v72 or 0.5;
	if v70[v71] and tick() - v70[v71] < v72 then
		return true;
	else
		v70[v71] = tick();
		return false;
	end;
end;
v17.Start = function(_) --[[ Line: 262 ]] --[[ Name: Start ]]
	-- upvalues: v9 (copy), l_PetEquipSlots_UI_0 (copy), l_TradeIn_1 (copy), v70 (copy), v19 (ref), l_REQUIRED_AGE_0 (copy), l_Confirm_0 (copy), l_Cancel_0 (copy), l_GameEvents_0 (copy), v17 (copy), v24 (copy), l_TradeIn_0 (copy), l_Trading_0 (copy), l_Details_0 (copy), v18 (copy)
	v9:UsePopupAnims(l_PetEquipSlots_UI_0);
	l_TradeIn_1.SENSOR.MouseButton1Click:Connect(function() --[[ Line: 265 ]]
		-- upvalues: v70 (ref), v19 (ref), l_REQUIRED_AGE_0 (ref), l_TradeIn_1 (ref), l_Confirm_0 (ref), l_Cancel_0 (ref)
		local v75 = nil or 0.5;
		local v76;
		if v70.TradeInStart and tick() - v70.TradeInStart < v75 then
			v76 = true;
		else
			v70.TradeInStart = tick();
			v76 = false;
		end;
		if v76 then
			return;
		elseif not v19 then
			return;
		else
			l_REQUIRED_AGE_0.Text = "Are you sure you want to trade in this pet?";
			l_TradeIn_1.Visible = false;
			l_Confirm_0.Visible = true;
			l_Cancel_0.Visible = true;
			return;
		end;
	end);
	l_Confirm_0.SENSOR.MouseButton1Click:Connect(function() --[[ Line: 273 ]]
		-- upvalues: v70 (ref), v19 (ref), l_GameEvents_0 (ref), v17 (ref), v24 (ref), l_TradeIn_0 (ref), l_TradeIn_1 (ref), l_Confirm_0 (ref), l_Cancel_0 (ref)
		local v77 = nil or 0.5;
		local v78;
		if v70.TradeConfirm and tick() - v70.TradeConfirm < v77 then
			v78 = true;
		else
			v70.TradeConfirm = tick();
			v78 = false;
		end;
		if v78 then
			return;
		elseif not v19 then
			return;
		else
			l_GameEvents_0.UnlockSlotFromPet:FireServer(v19, v17.CurrentMode);
			task.wait(1);
			v17:RefreshUI();
			v19 = nil;
			v24(false);
			l_TradeIn_0.BackgroundTransparency = 0.5;
			l_TradeIn_0.UIStroke.Transparency = 0.5;
			l_TradeIn_0.TextLabel.TextTransparency = 0.5;
			l_TradeIn_1.Visible = true;
			l_Confirm_0.Visible = false;
			l_Cancel_0.Visible = false;
			return;
		end;
	end);
	l_Cancel_0.SENSOR.MouseButton1Click:Connect(function() --[[ Line: 287 ]]
		-- upvalues: v70 (ref), l_TradeIn_1 (ref), l_Confirm_0 (ref), l_Cancel_0 (ref), v17 (ref)
		local v79 = nil or 0.5;
		local v80;
		if v70.TradeCancel and tick() - v70.TradeCancel < v79 then
			v80 = true;
		else
			v70.TradeCancel = tick();
			v80 = false;
		end;
		if v80 then
			return;
		else
			l_TradeIn_1.Visible = true;
			l_Confirm_0.Visible = false;
			l_Cancel_0.Visible = false;
			v17:RefreshUI();
			return;
		end;
	end);
	l_Trading_0.Main.Header.Exit.SENSOR.MouseButton1Click:Connect(function() --[[ Line: 293 ]]
		-- upvalues: v70 (ref), v9 (ref), l_PetEquipSlots_UI_0 (ref)
		local v81 = nil or 0.5;
		local v82;
		if v70.ExitHeader and tick() - v70.ExitHeader < v81 then
			v82 = true;
		else
			v70.ExitHeader = tick();
			v82 = false;
		end;
		if v82 then
			return;
		else
			v9:Close(l_PetEquipSlots_UI_0);
			return;
		end;
	end);
	l_Details_0.Holder.Header.EXIT_BUTTON.SENSOR.MouseButton1Click:Connect(function() --[[ Line: 298 ]]
		-- upvalues: v70 (ref), v19 (ref), v24 (ref), l_TradeIn_0 (ref), v17 (ref), v18 (ref), l_Trading_0 (ref)
		local v83 = nil or 0.5;
		local v84;
		if v70.ExitDetails and tick() - v70.ExitDetails < v83 then
			v84 = true;
		else
			v70.ExitDetails = tick();
			v84 = false;
		end;
		if v84 then
			return;
		else
			v19 = nil;
			v24(false);
			l_TradeIn_0.BackgroundTransparency = 0.5;
			l_TradeIn_0.UIStroke.Transparency = 0.5;
			l_TradeIn_0.TextLabel.TextTransparency = 0.5;
			v17:SetMode(v18.Pet);
			for _, v86 in l_Trading_0.Main.Holder.ScrollingFrame.Content:GetChildren() do
				if v86:IsA("ImageButton") and v86:FindFirstChild("Display") then
					v86.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18);
					v86.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0);
					v86.Display.SELECTED_VIGNETTE.Visible = false;
				end;
			end;
			return;
		end;
	end);
	l_Trading_0.Main.SideBar.ButtonList.PetEquipSlots.SENSOR.MouseButton1Click:Connect(function() --[[ Line: 315 ]]
		-- upvalues: v70 (ref), v17 (ref), v18 (ref)
		local v87 = nil or 0.5;
		local v88;
		if v70.PetButton and tick() - v70.PetButton < v87 then
			v88 = true;
		else
			v70.PetButton = tick();
			v88 = false;
		end;
		if v88 then
			return;
		else
			v17:SetMode(v18.Pet);
			return;
		end;
	end);
	l_Trading_0.Main.SideBar.ButtonList.EggEquipSlots.SENSOR.MouseButton1Click:Connect(function() --[[ Line: 320 ]]
		-- upvalues: v70 (ref), v17 (ref), v18 (ref)
		local v89 = nil or 0.5;
		local v90;
		if v70.EggButton and tick() - v70.EggButton < v89 then
			v90 = true;
		else
			v70.EggButton = tick();
			v90 = false;
		end;
		if v90 then
			return;
		else
			v17:SetMode(v18.Egg);
			return;
		end;
	end);
	l_Trading_0.Main.SideBar.ButtonList.EggInfo.SENSOR.MouseButton1Click:Connect(function() --[[ Line: 325 ]]
		-- upvalues: v70 (ref), v17 (ref), v18 (ref)
		local v91 = nil or 0.5;
		local v92;
		if v70.EggInfoButton and tick() - v70.EggInfoButton < v91 then
			v92 = true;
		else
			v70.EggInfoButton = tick();
			v92 = false;
		end;
		if v92 then
			return;
		else
			v17:SetMode(v18.EggInfo);
			return;
		end;
	end);
end;
task.spawn(v17.Start, v17);
return v17;