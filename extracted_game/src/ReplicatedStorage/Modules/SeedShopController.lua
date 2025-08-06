-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local seedShopGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("Seed_Shop");
local guiController = require(replicatedStorageService.Modules.GuiController);
local dataService = require(replicatedStorageService.Modules.DataService);
local commaModule = require(replicatedStorageService.Comma_Module);
local signalModule = require(replicatedStorageService.Modules.Signal);
local fastTweenModule = require(replicatedStorageService.Modules.FastTween);
local marketController = require(replicatedStorageService.Modules.MarketController);
local giftController = require(replicatedStorageService.Modules.GiftController);
local seedShopData = require(replicatedStorageService.Data.SeedShopData);
local itemModule = require(replicatedStorageService.Item_Module);
local _ = require(replicatedStorageService.Modules.DumpTable);
local selectedItemFrame = nil;
local stockUpdateSignal = signalModule.new();
local seedShopScrollingFrame = seedShopGui:WaitForChild("Frame"):WaitForChild("ScrollingFrame");
local restockTimerText = seedShopGui:WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("Timer");
local itemFrameTemplate = seedShopScrollingFrame:WaitForChild("ItemFrame");
itemFrameTemplate.Parent = script;
local itemPadding = seedShopScrollingFrame:WaitForChild("ItemPadding");
itemPadding.Parent = seedShopScrollingFrame;
local seedData = require(game.ReplicatedStorage.Data.SeedData);
local seedItemFrames = {};
local seedShopController = {};
local function _() --[[ Line: 41 ]] --[[ Name: GetRefreshTime ]]
	-- upvalues: v4 (copy), v10 (copy)
	local serverTimeNow = workspace:GetServerTimeNow();
	local seedStockData = dataService:GetData();
	local forcedEndTimeRemaining = seedStockData.SeedStock.ForcedSeedEndTimestamp and seedStockData.SeedStock.ForcedSeedEndTimestamp - serverTimeNow or -1;
	if forcedEndTimeRemaining >= 0 then
		return forcedEndTimeRemaining;
	else
		return seedShopData.RefreshTime - serverTimeNow % seedShopData.RefreshTime;
	end;
end;
local function setupTimer() --[[ Line: 53 ]] --[[ Name: SetupTimer ]]
	-- upvalues: v4 (copy), v10 (copy), l_Timer_0 (copy)
	while true do
		local serverTimeNow = workspace:GetServerTimeNow();
		local seedStockData = dataService:GetData();
		local forcedEndTimeRemainingServer = seedStockData.SeedStock.ForcedSeedEndTimestamp and seedStockData.SeedStock.ForcedSeedEndTimestamp - serverTimeNow or -1;
		local timeUntilRestock = if forcedEndTimeRemainingServer >= 0 then forcedEndTimeRemainingServer else seedShopData.RefreshTime - serverTimeNow % seedShopData.RefreshTime;
		restockTimerText.Text = timeUntilRestock <= 0 and "Restocking" or "New seeds in " .. string.format("%01d:%02d", timeUntilRestock / 60, timeUntilRestock % 60);
		if timeUntilRestock <= 1 then
			require(game.ReplicatedStorage.Modules.Notification):CreateNotification("<font color=\"#ADD8E6\"><b>Your Seed shop stock has been reset!</b></font>");
		end;
		task.wait(1);
	end;
end;
local function _(color3) --[[ Line: 70 ]] --[[ Name: Darken ]]
	local hue, saturation, value = color3:ToHSV();
	return Color3.fromHSV(hue, saturation, value / 2);
end;
local availableFruits = string.split(replicatedStorageService:WaitForChild("Collectibles").Value, "|")
local function setupFrames() --[[ Line: 75 ]] --[[ Name: SetupFrames ]]
	-- upvalues: v30 (copy), v19 (copy), l_ItemFrame_0 (copy), v20 (copy), v11 (copy), v5 (copy), l_ScrollingFrame_0 (copy), v7 (copy), l_ItemPadding_0 (copy), l_ReplicatedStorage_0 (copy), v8 (copy), v9 (copy), v13 (ref), v14 (copy), v4 (copy)
	task.spawn(setupTimer);
	local itemFramesList = {};
	for seedName, seedData in seedData do
		if seedData.DisplayInShop and table.find(availableFruits, seedName) then
			local itemFrame = itemFrameTemplate:Clone();
			seedItemFrames[seedName] = itemFrame;
			itemFrame.Name = seedName;
			itemFrame.LayoutOrder = seedData.LayoutOrder * 10;
			table.insert(itemFramesList, itemFrame);
			local mainFrame = itemFrame.Main_Frame;
			local rarityData = itemModule.Return_Rarity_Data(seedData.SeedRarity);
			if rarityData then
				mainFrame.Rarity_Text.Text = rarityData[1];
				local rarityTextUIStroke = mainFrame.Rarity_Text.UIStroke;
				local hue, saturation, valueHSV = rarityData[2]:ToHSV();
				rarityTextUIStroke.Color = Color3.fromHSV(hue, saturation, valueHSV / 2);
				mainFrame.Rarity_BG.ImageColor3 = rarityData[2];
			end;
			mainFrame.Seed_Text.Text = seedData.SeedName;
			mainFrame.Seed_Text_Shadow.Text = seedData.SeedName;
			mainFrame.Cost_Text.Text = commaModule.Comma(seedData.Price) .. "\194\162";
			local seedAsset = seedData.Asset:Clone();
			local basePart = itemFrame.Main_Frame.ViewportFrame.BasePart;
			seedAsset.CFrame = basePart.CFrame;
			seedAsset.Parent = itemFrame.Main_Frame.ViewportFrame;
			basePart:Destroy();
			itemFrame.Parent = seedShopScrollingFrame;
			seedAsset.Orientation = Vector3.new(0, 45, 0, 0);
			local unknownVariable = nil;
			do
				local assetRotationTween = unknownVariable;
				mainFrame.MouseEnter:Connect(function() --[[ Line: 116 ]]
					-- upvalues: l_v48_0 (ref), v7 (ref), v46 (copy), v39 (copy)
					assetRotationTween = fastTweenModule(seedAsset, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false, 0), {
						Orientation = seedAsset.Orientation + Vector3.new(0, 360, 0, 0)
					});
					fastTweenModule(itemFrame.Main_Frame.ViewportFrame.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
						Scale = 1.25
					});
				end);
				mainFrame.MouseLeave:Connect(function() --[[ Line: 134 ]]
					-- upvalues: l_v48_0 (ref), v46 (copy), v7 (ref), v39 (copy)
					if assetRotationTween then
						assetRotationTween:Cancel();
					end;
					seedAsset.Orientation = Vector3.new(0, 45, 0, 0);
					fastTweenModule(itemFrame.Main_Frame.ViewportFrame.UIScale, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
						Scale = 1
					});
				end);
				local itemPaddingFrame = itemPadding:Clone();
				itemPaddingFrame.LayoutOrder = seedData.LayoutOrder * 10 + 1;
				itemPaddingFrame.Name = ("%*_Padding"):format(seedName);
				itemPaddingFrame.Parent = seedShopScrollingFrame;
				local seedShopItemFrame = itemFrame.Frame;
				seedShopItemFrame.Sheckles_Buy.In_Stock.Cost_Text.Text = commaModule.Comma(seedData.Price) .. "\194\162";
				seedShopItemFrame.Sheckles_Buy.Activated:Connect(function() --[[ Line: 159 ]]
					-- upvalues: v37 (copy), l_ReplicatedStorage_0 (ref)
					if workspace:GetAttribute("InTutorial") and seedName ~= "Carrot" then
						return;
					else
						replicatedStorageService.GameEvents.BuySeedStock:FireServer(seedName);
						return;
					end;
				end);
				seedShopItemFrame.Robux_Buy.Activated:Connect(function() --[[ Line: 167 ]]
					-- upvalues: v8 (ref), v38 (copy)
					marketController:PromptPurchase(seedData.PurchaseID, Enum.InfoType.Product);
				end);
				seedShopItemFrame.Gift.Visible = seedData.GiftPurchaseID ~= nil;
				if seedData.GiftPurchaseID then
					seedShopItemFrame.Gift.Activated:Connect(function() --[[ Line: 173 ]]
						-- upvalues: v9 (ref), v38 (copy)
						giftController:PromptGiftFromGiftId(seedData.GiftPurchaseID);
					end);
				end;
				local function updateOptions() --[[ Line: 178 ]] --[[ Name: updateOptions ]]
					-- upvalues: v13 (ref), v37 (copy), l_Frame_0 (copy), v7 (ref), v50 (copy)
					if selectedItemFrame == seedName then
						seedShopItemFrame.Visible = true;
						fastTweenModule(seedShopItemFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Position = UDim2.fromScale(0.5, 1.3)
						});
						fastTweenModule(itemPaddingFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Size = UDim2.fromScale(0.13, 0.25)
						});
						return;
					else
						seedShopItemFrame.Visible = false;
						fastTweenModule(seedShopItemFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Position = UDim2.fromScale(0.5, 0.5)
						});
						fastTweenModule(itemPaddingFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Size = UDim2.fromScale(0.13, 0.02)
						});
						return;
					end;
				end;
				stockUpdateSignal:Connect(updateOptions);
				task.spawn(updateOptions);
				mainFrame.Activated:Connect(function() --[[ Line: 203 ]]
					-- upvalues: v7 (ref), l_ScrollingFrame_0 (ref), v39 (copy), v36 (copy), v13 (ref), v37 (copy), v14 (ref)
					fastTweenModule(seedShopScrollingFrame, TweenInfo.new(0.35), {
						CanvasPosition = Vector2.new(0, itemFrame.AbsoluteSize.Y * (table.find(itemFramesList, itemFrame) - 1))
					});
					selectedItemFrame = if selectedItemFrame == seedName then nil else seedName;
					stockUpdateSignal:Fire();
				end);
				task.spawn(function() --[[ Line: 216 ]]
					-- upvalues: v8 (ref), l_Frame_0 (copy), v38 (copy)
					marketController:SetPriceLabel(seedShopItemFrame.Robux_Buy.Price, seedData.PurchaseID, ":robux::value:");
				end);
				local function updateStock() --[[ Line: 221 ]] --[[ Name: updateStock ]]
					-- upvalues: v4 (ref), v37 (copy), l_Main_Frame_0 (copy), l_Frame_0 (copy), v5 (ref), v38 (copy)
					local seedStockData = dataService:GetData();
					local seedStockEntry = seedStockData and seedStockData.SeedStock.Stocks[seedName];
					local currentStock = seedStockEntry and seedStockEntry.Stock or 0;
					local stockText = ("X%* Stock"):format(currentStock);
					mainFrame.Stock_Text.Text = stockText;
					seedShopItemFrame.Sheckles_Buy.In_Stock.Visible = currentStock > 0;
					seedShopItemFrame.Sheckles_Buy.No_Stock.Visible = currentStock <= 0;
					seedShopItemFrame.Sheckles_Buy.HoverImage = currentStock > 0 and "rbxassetid://71551639169723" or "rbxassetid://138411009141674";
					seedShopItemFrame.Sheckles_Buy.Image = currentStock > 0 and "rbxassetid://96160773850314" or "rbxassetid://104713419928195";
					mainFrame.Cost_Text.Text = currentStock <= 0 and "NO STOCK" or commaModule.Comma(seedData.Price) .. "\194\162";
					mainFrame.Cost_Text.TextColor3 = if currentStock <= 0 then Color3.fromRGB(255, 0, 0) else Color3.fromRGB(0, 255, 0);
				end;
				task.spawn(updateStock);
				task.spawn(function() --[[ Line: 241 ]]
					-- upvalues: v4 (ref), v57 (copy)
					local seedStockAttributeSignal = dataService:GetPathSignal("SeedStock/@");
					if seedStockAttributeSignal then
						seedStockAttributeSignal:Connect(updateStock);
					end;
					local seedStockSignal = dataService:GetPathSignal("SeedStock");
					if seedStockSignal then
						seedStockSignal:Connect(updateStock);
					end;
				end);
			end;
		end;
	end;
	table.sort(itemFramesList, function(itemFrame1, itemFrame2) --[[ Line: 254 ]]
		local layoutOrder1 = itemFrame1.LayoutOrder;
		local layoutOrder2 = itemFrame2.LayoutOrder;
		if layoutOrder1 == layoutOrder2 then
			return itemFrame1.Name < itemFrame2.Name;
		else
			return layoutOrder1 < layoutOrder2;
		end;
	end);
end;
seedShopController.Start = function(_) --[[ Line: 264 ]] --[[ Name: Start ]]
	-- upvalues: v3 (copy), l_Seed_Shop_0 (copy), v8 (copy), v64 (copy)
	guiController:UsePopupAnims(seedShopGui);
	seedShopGui.Frame.Frame.ExitButton.Activated:Connect(function() --[[ Line: 267 ]]
		-- upvalues: v3 (ref), l_Seed_Shop_0 (ref)
		guiController:Close(seedShopGui);
	end);
	seedShopGui.Frame.Frame.Restock.Activated:Connect(function() --[[ Line: 271 ]]
		-- upvalues: v8 (ref)
		--marketController:PromptPurchase(3248683091, Enum.InfoType.Product);
	end);
	
	setupFrames();
end;
task.spawn(seedShopController.Start, seedShopController);
return seedShopController;