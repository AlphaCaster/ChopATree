-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local gearShopGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("Gear_Shop");
local guiController = require(replicatedStorageService.Modules.GuiController);
local dataService = require(replicatedStorageService.Modules.DataService);
local commaModule = require(replicatedStorageService.Comma_Module);
local signalModule = require(replicatedStorageService.Modules.Signal);
local fastTweenModule = require(replicatedStorageService.Modules.FastTween);
local gearShopData = require(replicatedStorageService.Data.GearShopData);
local gearData = require(replicatedStorageService.Data.GearData);
local itemModule = require(replicatedStorageService.Item_Module);
local _ = require(replicatedStorageService.Modules.RetryPcall);
local marketController = require(replicatedStorageService.Modules.MarketController);
local giftController = require(replicatedStorageService.Modules.GiftController);
local gearScrollingFrame = gearShopGui:WaitForChild("Frame"):WaitForChild("ScrollingFrame");
local restockTimerTextLabel = gearShopGui:WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("Timer");
local itemFrameTemplate = gearScrollingFrame:WaitForChild("ItemFrame");
itemFrameTemplate.Parent = script;
local itemPaddingFrame = gearScrollingFrame:WaitForChild("ItemPadding");
itemPaddingFrame.Parent = gearScrollingFrame;
local gearItemFrames = {};
local gearShopController = {};
local selectedGearId = nil;
local gearUpdateSignal = signalModule.new();
local function _() --[[ Line: 39 ]] --[[ Name: GetRefreshTime ]]
	-- upvalues: v4 (copy), v8 (copy)
	local serverTimeNow = workspace:GetServerTimeNow();
	local gearShopDataCache = dataService:GetData();
	local forcedGearEndTime = gearShopDataCache.GearStock.ForcedGearEndTimestamp and gearShopDataCache.GearStock.ForcedGearEndTimestamp - serverTimeNow or -1;
	if forcedGearEndTime >= 0 then
		return forcedGearEndTime;
	else
		return gearShopData.RefreshTime - serverTimeNow % gearShopData.RefreshTime;
	end;
end;
local function setupTimer() --[[ Line: 52 ]] --[[ Name: SetupTimer ]]
	-- upvalues: v4 (copy), v8 (copy), l_Timer_0 (copy), l_ReplicatedStorage_0 (copy)
	while true do
		local serverTimeNowLoop = workspace:GetServerTimeNow();
		local gearShopDataCacheLoop = dataService:GetData();
		local forcedGearEndTime = gearShopDataCacheLoop.GearStock.ForcedGearEndTimestamp and gearShopDataCacheLoop.GearStock.ForcedGearEndTimestamp - serverTimeNowLoop or -1;
		local timeUntilRefresh = if forcedGearEndTime >= 0 then forcedGearEndTime else gearShopData.RefreshTime - serverTimeNowLoop % gearShopData.RefreshTime;
		restockTimerTextLabel.Text = timeUntilRefresh <= 0 and "Restocking" or "New gear in " .. string.format("%01d:%02d", timeUntilRefresh / 60, timeUntilRefresh % 60);
		if timeUntilRefresh <= 1 then
			require(replicatedStorageService.Modules.Notification):CreateNotification("<font color=\"#90EE90\"><b>Your Gear Shop stock has been reset!</b></font>");
		end;
		task.wait(1);
	end;
end;
local function _(color) --[[ Line: 69 ]] --[[ Name: Darken ]]
	local hue, saturation, value = color:ToHSV();
	return Color3.fromHSV(hue, saturation, value / 2);
end;
local function setupFrames() --[[ Line: 74 ]] --[[ Name: SetupFrames ]]
	-- upvalues: v30 (copy), v9 (copy), l_ItemFrame_0 (copy), v18 (copy), v10 (copy), v5 (copy), l_ScrollingFrame_0 (copy), l_ItemPadding_0 (copy), l_ReplicatedStorage_0 (copy), v12 (copy), v13 (copy), v20 (ref), v7 (copy), v21 (copy), v4 (copy)
	task.spawn(setupTimer);
	local itemFramesList = {};
	for gearId, gearInfo in gearData do
		if gearInfo.LayoutOrder ~= -1 then
			local itemFrame = itemFrameTemplate:Clone();
			gearItemFrames[gearId] = itemFrame;
			itemFrame.Name = gearId;
			itemFrame.LayoutOrder = gearInfo.LayoutOrder * 10;
			table.insert(itemFramesList, itemFrame);
			local mainFrame = itemFrame.Main_Frame;
			local rarityData = itemModule.Return_Rarity_Data(gearInfo.GearRarity);
			if rarityData then
				mainFrame.Rarity_Text.Text = rarityData[1];
				local rarityTextStroke = mainFrame.Rarity_Text.UIStroke;
				local hue, saturation, valueComponent = rarityData[2]:ToHSV();
				rarityTextStroke.Color = Color3.fromHSV(hue, saturation, valueComponent / 2);
				mainFrame.Rarity_BG.ImageColor3 = rarityData[2];
			end;
			mainFrame.Gear_Text.Text = gearInfo.GearName;
			mainFrame.Gear_Text_Shadow.Text = gearInfo.GearName;
			mainFrame.Description_Text.Text = gearInfo.GearDescription;
			mainFrame.Cost_Text.Text = commaModule.Comma(gearInfo.Price) .. "\194\162";
			mainFrame:WaitForChild("Gear_Image").Image = gearInfo.Asset;
			itemFrame.Parent = gearScrollingFrame;
			local itemPaddingFrame = itemPaddingFrame:Clone();
			itemPaddingFrame.LayoutOrder = gearInfo.LayoutOrder * 10 + 1;
			itemPaddingFrame.Name = gearId .. "_Padding";
			itemPaddingFrame.Parent = gearScrollingFrame;
			local gearFrame = itemFrame.Frame;
			gearFrame.Sheckles_Buy.In_Stock.Cost_Text.Text = commaModule.Comma(gearInfo.Price) .. "\194\162";
			gearFrame.Sheckles_Buy.Activated:Connect(function() --[[ Line: 117 ]]
				-- upvalues: l_ReplicatedStorage_0 (ref), v37 (copy)
				replicatedStorageService.GameEvents.BuyGearStock:FireServer(gearId);
			end);
			gearFrame.Robux_Buy.Activated:Connect(function() --[[ Line: 121 ]]
				-- upvalues: v12 (ref), v38 (copy)
				marketController:PromptPurchase(gearInfo.PurchaseID, Enum.InfoType.Product);
			end);
			gearFrame.Gift.Visible = gearInfo.GiftPurchaseID ~= nil;
			if gearInfo.GiftPurchaseID then
				gearFrame.Gift.Activated:Connect(function() --[[ Line: 127 ]]
					-- upvalues: v13 (ref), v38 (copy)
					giftController:PromptGiftFromGiftId(gearInfo.GiftPurchaseID);
				end);
			end;
			local function updateOptions() --[[ Line: 132 ]] --[[ Name: updateOptions ]]
				-- upvalues: v20 (ref), v37 (copy), l_Frame_0 (copy), v7 (ref), v46 (copy)
				if selectedGearId == gearId then
					gearFrame.Visible = true;
					fastTweenModule(gearFrame, TweenInfo.new(0.25), {
						Position = UDim2.fromScale(0.5, 1.3)
					});
					fastTweenModule(itemPaddingFrame, TweenInfo.new(0.25), {
						Size = UDim2.fromScale(0.13, 0.25)
					});
					return;
				else
					gearFrame.Visible = false;
					fastTweenModule(gearFrame, TweenInfo.new(0.25), {
						Position = UDim2.fromScale(0.5, 0.5)
					});
					fastTweenModule(itemPaddingFrame, TweenInfo.new(0.25), {
						Size = UDim2.fromScale(0.13, 0.02)
					});
					return;
				end;
			end;
			gearUpdateSignal:Connect(updateOptions);
			task.spawn(updateOptions);
			mainFrame.Activated:Connect(function() --[[ Line: 147 ]]
				-- upvalues: v7 (ref), l_ScrollingFrame_0 (ref), v39 (copy), v36 (copy), v20 (ref), v37 (copy), v21 (ref)
				fastTweenModule(gearScrollingFrame, TweenInfo.new(0.35), {
					CanvasPosition = Vector2.new(0, itemFrame.AbsoluteSize.Y * (table.find(itemFramesList, itemFrame) - 1))
				});
				selectedGearId = if selectedGearId == gearId then nil else gearId;
				gearUpdateSignal:Fire();
			end);
			task.spawn(function() --[[ Line: 156 ]]
				-- upvalues: v12 (ref), l_Frame_0 (copy), v38 (copy)
				marketController:SetPriceLabel(gearFrame.Robux_Buy.Price, gearInfo.PurchaseID, ":robux::value:");
			end);
			local function updateStock() --[[ Line: 160 ]] --[[ Name: updateStock ]]
				-- upvalues: v4 (ref), v37 (copy), l_Main_Frame_0 (copy), v38 (copy), l_Frame_0 (copy), v12 (ref), v5 (ref)
				local gearStockData = dataService:GetData();
				local gearStockEntry = gearStockData and gearStockData.GearStock.Stocks[gearId];
				local currentStock = gearStockEntry and gearStockEntry.Stock or 0;
				mainFrame.Stock_Text.Text = gearInfo.RobuxOnly and "" or ("X%* Stock"):format(currentStock);
				gearFrame.Sheckles_Buy.In_Stock.Visible = currentStock > 0;
				gearFrame.Sheckles_Buy.No_Stock.Visible = currentStock <= 0;
				gearFrame.Sheckles_Buy.HoverImage = currentStock > 0 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
				gearFrame.Sheckles_Buy.Image = currentStock > 0 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";
				gearFrame.Sheckles_Buy.Visible = not gearInfo.RobuxOnly;
				if gearInfo.RobuxOnly then
					mainFrame.Cost_Text.Text = "???";
					marketController:SetPriceLabel(mainFrame.Cost_Text, gearInfo.PurchaseID, ":robux::value:");
					return;
				else
					mainFrame.Cost_Text.Text = currentStock <= 0 and "NO STOCK" or commaModule.Comma(gearInfo.Price) .. "\194\162";
					mainFrame.Cost_Text.TextColor3 = if currentStock <= 0 then Color3.fromRGB(255, 0, 0) else Color3.fromRGB(0, 255, 0);
					return;
				end;
			end;
			task.spawn(updateStock);
			task.spawn(function() --[[ Line: 186 ]]
				-- upvalues: v4 (ref), v52 (copy)
				local gearStockPathSignal = dataService:GetPathSignal("GearStock/@");
				if gearStockPathSignal then
					gearStockPathSignal:Connect(updateStock);
				end;
			end);
		end;
	end;
	table.sort(itemFramesList, function(itemA, itemB) --[[ Line: 194 ]]
		if itemA.LayoutOrder == itemB.LayoutOrder then
			return itemA.Name < itemB.Name;
		else
			return itemA.LayoutOrder < itemB.LayoutOrder;
		end;
	end);
end;
gearShopController.Start = function(_) --[[ Line: 202 ]] --[[ Name: Start ]]
	-- upvalues: v3 (copy), l_Gear_Shop_0 (copy), v12 (copy), v56 (copy)
	guiController:UsePopupAnims(gearShopGui);
	gearShopGui.Frame.Frame.ExitButton.Activated:Connect(function() --[[ Line: 205 ]]
		-- upvalues: v3 (ref), l_Gear_Shop_0 (ref)
		guiController:Close(gearShopGui);
	end);
	gearShopGui.Frame.Frame.Restock.Activated:Connect(function() --[[ Line: 209 ]]
		-- upvalues: v12 (ref)
		--marketController:PromptPurchase(3265941675, Enum.InfoType.Product);
	end);
	setupFrames();
end;
task.spawn(gearShopController.Start, gearShopController);
return gearShopController;