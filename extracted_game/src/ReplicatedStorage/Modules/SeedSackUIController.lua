-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local playersService = game:GetService("Players");
local replicatedStorageService = game:GetService("ReplicatedStorage");
local _ = game:GetService("ServerScriptService");
local marketplaceService = game:GetService("MarketplaceService");
local policyService = game:GetService("PolicyService");
local runService = game:GetService("RunService");
local seedPackGiverEvent = replicatedStorageService:WaitForChild("GameEvents"):WaitForChild("SeedPackGiverEvent");
local seedGiverQuestProgressionData = require(replicatedStorageService.Data.SeedGiverQuestProgression);
local marketController = require(replicatedStorageService.Modules.MarketController);
local giftController = require(replicatedStorageService.Modules.GiftController);
local guiController = require(replicatedStorageService.Modules.GuiController);
local dataService = require(replicatedStorageService.Modules.DataService);
local seedPackData = require(replicatedStorageService.Data.SeedPackData);
local retryPcallModule = require(replicatedStorageService.Modules.RetryPcall);
local commaModule = require(replicatedStorageService.Comma_Module);
local seedData = require(replicatedStorageService.Data.SeedData);
local localPlayer = playersService.LocalPlayer;
local freeSeedSackUI = localPlayer.PlayerGui:WaitForChild("FreeSeedSack_UI");
local freeSeedSackFrame = freeSeedSackUI.Frame;
local sackTypeButtons = freeSeedSackFrame.Btns;
local isPremiumSackAvailable = false;
local freeSeedSackController = {};
freeSeedSackController.DisplayPremiumSackUI = function(_) --[[ Line: 32 ]] --[[ Name: DisplayPremiumSackUI ]]
	-- upvalues: v20 (ref), v21 (copy), v10 (copy), l_FreeSeedSack_UI_0 (copy), l_Frame_0 (copy)
	if not isPremiumSackAvailable then
		freeSeedSackController:DisplayBasicSackUI();
		return;
	else
		freeSeedSackController:UpdateProgression();
		guiController:Open(freeSeedSackUI);
		freeSeedSackFrame.BasicVer.Visible = false;
		freeSeedSackFrame.PremVer.Visible = true;
		return;
	end;
end;
freeSeedSackController.DisplayBasicSackUI = function(_) --[[ Line: 45 ]] --[[ Name: DisplayBasicSackUI ]]
	-- upvalues: v21 (copy), v10 (copy), l_FreeSeedSack_UI_0 (copy), l_Frame_0 (copy)
	freeSeedSackController:UpdateProgression();
	guiController:Open(freeSeedSackUI);
	freeSeedSackFrame.BasicVer.Visible = true;
	freeSeedSackFrame.PremVer.Visible = false;
end;
freeSeedSackController.UpdateProgression = function(_) --[[ Line: 52 ]] --[[ Name: UpdateProgression ]]
	-- upvalues: v11 (copy), l_LocalPlayer_0 (copy), l_Frame_0 (copy), v7 (copy)
	local playerData = dataService:GetData();
	if not playerData then
		warn((("No player data for %*!"):format(localPlayer)));
		return;
	else
		local seedPackGiverInfo = playerData.SeedPackGiverInfo;
		local seedPackProgressionBar = freeSeedSackFrame.BasicVer.Prog;
		local progressionFraction = (playerData.SeedPackGiverInfo.Progression - 1) / #seedGiverQuestProgressionData;
		freeSeedSackFrame.BasicVer.Prog.Fill.Size = UDim2.new(progressionFraction, 0, 1, 0);
		if playerData.SeedPackGiverInfo.Progression > #seedGiverQuestProgressionData then
			seedPackProgressionBar.Progress.Text = "Plant is fully fed! Claim your Premium Seed Sack!";
			freeSeedSackFrame.BasicVer.ClaimButton.Visible = true;
			return;
		else
			seedPackProgressionBar.Progress.Text = ("%*/%*"):format(seedPackGiverInfo.Progression - 1, #seedGiverQuestProgressionData);
			freeSeedSackFrame.BasicVer.ClaimButton.Visible = false;
			return;
		end;
	end;
end;
freeSeedSackController.Start = function(_) --[[ Line: 78 ]] --[[ Name: Start ]]
	-- upvalues: v10 (copy), l_FreeSeedSack_UI_0 (copy), l_Btns_0 (copy), v21 (copy), l_Frame_0 (copy), l_SeedPackGiverEvent_0 (copy), v12 (copy), v15 (copy), l_RunService_0 (copy), v8 (copy), v13 (copy), l_MarketplaceService_0 (copy), v14 (copy), v9 (copy), l_PolicyService_0 (copy), l_LocalPlayer_0 (copy), v20 (ref)
	local freeSeedSackUIState = guiController:GetStateForGui(freeSeedSackUI);
	guiController:UsePopupAnims(freeSeedSackUI);
	sackTypeButtons.Basic.Activated:Connect(function() --[[ Line: 82 ]]
		-- upvalues: v21 (ref)
		freeSeedSackController:DisplayBasicSackUI();
	end);
	sackTypeButtons.Premium.Activated:Connect(function() --[[ Line: 86 ]]
		-- upvalues: v21 (ref)
		freeSeedSackController:DisplayPremiumSackUI();
	end);
	freeSeedSackFrame.ExitButton.Activated:Connect(function() --[[ Line: 90 ]]
		-- upvalues: v10 (ref), l_FreeSeedSack_UI_0 (ref)
		guiController:Close(freeSeedSackUI);
	end);
	freeSeedSackFrame.BasicVer.ClaimButton.Claim.Activated:Connect(function() --[[ Line: 94 ]]
		-- upvalues: l_SeedPackGiverEvent_0 (ref), l_Frame_0 (ref)
		seedPackGiverEvent:FireServer("ClaimPremiumPack");
		freeSeedSackFrame.BasicVer.Prog.Progress.Text = "Well done! Premium Seed Sack Claimed!";
		freeSeedSackFrame.BasicVer.ClaimButton.Visible = false;
	end);
	local function renderRewards(packListLayout, packData) --[[ Line: 103 ]] --[[ Name: renderRewards ]]
		-- upvalues: v12 (ref), v15 (ref), l_v10_StateForGui_0 (copy), l_RunService_0 (ref)
		for itemIndex, itemData in packData.Items do
			local isRainbowTemplate = if packData == seedPackData.Packs.SeedSackBasic then itemIndex >= 7 else itemIndex >= 6;
			local canAffordPack = if packData == seedPackData.Packs.SeedSackBasic then itemIndex >= 5 else itemIndex >= 4;
			local rewardTemplate = (if isRainbowTemplate then packListLayout.UIListLayout.TemplateRainbow else if canAffordPack then packListLayout.UIListLayout.TemplateBigger else packListLayout.UIListLayout.TemplateSmaller):Clone();
			rewardTemplate.LayoutOrder = itemIndex;
			rewardTemplate.Odds.Text = itemData.RemoveChance and "" or itemData.HideChance and "???" or ("%*%%"):format(math.floor(itemData.Chance * 100) / 100);
			rewardTemplate.Title.Text = seedPackData:GetTextDisplayForItem(itemData);
			if itemData.Icon then
				rewardTemplate.ViewportFrame.Visible = false;
				rewardTemplate.Vector.Image = itemData.Icon;
				rewardTemplate.Vector.Visible = true;
			else
				local seedInfo = seedData[itemData.RewardId];
				if seedInfo and seedInfo.Asset then
					rewardTemplate.Vector.Visible = false;
					local seedAsset = seedInfo.Asset:Clone();
					local basePart = rewardTemplate.ViewportFrame.BasePart;
					seedAsset.CFrame = basePart.CFrame;
					seedAsset.Parent = rewardTemplate.ViewportFrame;
					basePart:Destroy();
				end;
			end;
			if isRainbowTemplate then
				local rainbowAnimationConnection = nil;
				do
					local rainbowAnimationConnectionRef = rainbowAnimationConnection;
					freeSeedSackUIState.Visible:Listen(function(isVisible) --[[ Line: 136 ]]
						-- upvalues: l_v41_0 (ref), l_RunService_0 (ref), v37 (copy)
						if isVisible then
							if not rainbowAnimationConnectionRef then
								rainbowAnimationConnectionRef = runService.PostSimulation:Connect(function() --[[ Line: 140 ]]
									-- upvalues: v37 (ref)
									rewardTemplate.Odds.TextColor3 = Color3.fromHSV(os.clock() % 5 / 5, 1, 1);
								end);
								return;
							end;
						elseif rainbowAnimationConnectionRef then
							rainbowAnimationConnectionRef:Disconnect();
							rainbowAnimationConnectionRef = nil;
						end;
					end);
				end;
			elseif canAffordPack then
				rewardTemplate.Odds.TextColor3 = Color3.fromRGB(255, 204, 1);
			end;
			rewardTemplate.Parent = packListLayout;
		end;
	end;
	renderRewards(freeSeedSackFrame.BasicVer.Items, seedPackData.Packs.SeedSackBasic);
	renderRewards(freeSeedSackFrame.PremVer.Items, seedPackData.Packs.SeedSackPremium);
	marketController:SetPriceLabel(freeSeedSackFrame.PremVer.Frame.Buy1.Cost, 3273679011);
	freeSeedSackFrame.PremVer.Frame.Buy1.Activated:Connect(function() --[[ Line: 164 ]]
		-- upvalues: v8 (ref)
		marketController:PromptPurchase(3273679011, Enum.InfoType.Product);
	end);
	marketController:SetPriceLabel(freeSeedSackFrame.PremVer.Frame.Buy3.Cost, 3273679014);
	freeSeedSackFrame.PremVer.Frame.Buy3.Activated:Connect(function() --[[ Line: 169 ]]
		-- upvalues: v8 (ref)
		marketController:PromptPurchase(3273679014, Enum.InfoType.Product);
	end);
	marketController:SetPriceLabel(freeSeedSackFrame.PremVer.Frame.Buy10.Cost, 3273679012);
	freeSeedSackFrame.PremVer.Frame.Buy10.Activated:Connect(function() --[[ Line: 174 ]]
		-- upvalues: v8 (ref)
		marketController:PromptPurchase(3273679012, Enum.InfoType.Product);
	end);
	task.spawn(function() --[[ Line: 178 ]]
		-- upvalues: l_Frame_0 (ref), v13 (ref), l_MarketplaceService_0 (ref), v14 (ref)
		freeSeedSackFrame.PremVer.Frame.Buy10.Tag.Visible = false;
		local productInfoSuccess, productInfo = retryPcallModule(30, 6, function() --[[ Line: 181 ]]
			-- upvalues: l_MarketplaceService_0 (ref)
			return marketplaceService:GetProductInfo(3273679011, Enum.InfoType.Product);
		end);
		if not productInfoSuccess then
			return;
		else
			freeSeedSackFrame.PremVer.Frame.Buy10.Tag.Text = commaModule.Comma(productInfo.PriceInRobux * 10);
			freeSeedSackFrame.PremVer.Frame.Buy10.Tag.Visible = true;
			return;
		end;
	end);
	freeSeedSackFrame.PremVer.Frame.Gift.Activated:Connect(function() --[[ Line: 193 ]]
		-- upvalues: v9 (ref)
		giftController:PromptGift("10 Premium Seed Sacks");
	end);
	freeSeedSackController:UpdateProgression();
	task.spawn(function() --[[ Line: 199 ]]
		-- upvalues: l_Btns_0 (ref), l_Frame_0 (ref), v13 (ref), l_PolicyService_0 (ref), l_LocalPlayer_0 (ref), v20 (ref)
		sackTypeButtons.Premium.Visible = false;
		local premiumVersionVisibilityConnection = freeSeedSackFrame.PremVer:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 202 ]]
			-- upvalues: l_Frame_0 (ref)
			if not freeSeedSackFrame.PremVer.Visible then
				return;
			else
				freeSeedSackFrame.PremVer.Visible = false;
				freeSeedSackFrame.BasicVer.Visible = true;
				return;
			end;
		end);
		local success, policyInfo = retryPcallModule(10, 5, function() --[[ Line: 211 ]]
			-- upvalues: l_PolicyService_0 (ref), l_LocalPlayer_0 (ref)
			return policyService:GetPolicyInfoForPlayerAsync(localPlayer);
		end);
		if not success then
			return;
		elseif policyInfo.ArePaidRandomItemsRestricted then
			return;
		else
			isPremiumSackAvailable = true;
			sackTypeButtons.Premium.Visible = true;
			premiumVersionVisibilityConnection:Disconnect();
			return;
		end;
	end);
end;
task.spawn(freeSeedSackController.Start, freeSeedSackController);
return freeSeedSackController;