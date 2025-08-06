-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local marketplaceService = game:GetService("MarketplaceService");
local replicatedStorageService = game:GetService("ReplicatedStorage");
local playersService = game:GetService("Players");
local localPlayer = playersService.LocalPlayer;
local giftPlayerListGui = localPlayer.PlayerGui:WaitForChild("GiftPlayerList");
local marketControllerModule = require(replicatedStorageService.Modules.MarketController);
local guiControllerModule = require(replicatedStorageService.Modules.GuiController);
local giftDataModule = require(replicatedStorageService.Data.GiftData);
local remotesModule = require(replicatedStorageService.Modules.Remotes);
local giftState = {
	CurrentProduct = nil
};
giftState.PromptGift = function(_, giftId) --[[ Line: 19 ]] --[[ Name: PromptGift ]]
	-- upvalues: v7 (copy), v9 (copy), v6 (copy), l_GiftPlayerList_0 (copy)
	local giftData = giftDataModule[giftId];
	if not giftData then
		warn((("Gift not found for \"%*\""):format(giftId)));
		return;
	else
		giftState.CurrentProduct = giftData.NormalId;
		guiControllerModule:Open(giftPlayerListGui);
		return;
	end;
end;
giftState.PromptGiftFromGiftId = function(_, giftIdToFind) --[[ Line: 30 ]] --[[ Name: PromptGiftFromGiftId ]]
	-- upvalues: v7 (copy), v9 (copy)
	local giftIndex = nil;
	for index, giftInfo in giftDataModule do
		if giftIdToFind == giftInfo.GiftId then
			giftIndex = index;
			break;
		end;
	end;
	if not giftIndex then
		warn((("Gift not found for \"%*\""):format(giftIdToFind)));
		return;
	else
		giftState:PromptGift(giftIndex);
		return;
	end;
end;
giftState.PromptGiftFromNormalId = function(_, normalIdToFind) --[[ Line: 47 ]] --[[ Name: PromptGiftFromNormalId ]]
	-- upvalues: v7 (copy), v9 (copy)
	local giftIndexByNormalId = nil;
	for indexByNormalId, giftInfoByNormalId in giftDataModule do
		if normalIdToFind == giftInfoByNormalId.NormalId then
			giftIndexByNormalId = indexByNormalId;
			break;
		end;
	end;
	if not giftIndexByNormalId then
		warn((("Gift not found for \"%*\""):format(normalIdToFind)));
		return;
	else
		giftState:PromptGift(giftIndexByNormalId);
		return;
	end;
end;
giftState.Start = function(_) --[[ Line: 64 ]] --[[ Name: Start ]]
	-- upvalues: v6 (copy), l_GiftPlayerList_0 (copy), v5 (copy), v9 (copy), l_MarketplaceService_0 (copy), l_LocalPlayer_0 (copy), v8 (copy), l_Players_0 (copy)
	guiControllerModule:UsePopupAnims(giftPlayerListGui);
	local isGiftSending = false;
	local isPurchasePrompted = nil;
	giftPlayerListGui.Frame.Close.Activated:Connect(function() --[[ Line: 70 ]]
		-- upvalues: v6 (ref), l_GiftPlayerList_0 (ref)
		guiControllerModule:Close(giftPlayerListGui);
	end);
	marketControllerModule.PromptProductPurchaseInitiated:Connect(function(_, productId) --[[ Line: 74 ]]
		-- upvalues: v9 (ref), v25 (ref), l_GiftPlayerList_0 (ref)
		if productId == giftState.CurrentProduct then
			isPurchasePrompted = true;
			giftPlayerListGui.Black.ZIndex = 1000;
		end;
	end);
	marketplaceService.PromptProductPurchaseFinished:Connect(function() --[[ Line: 82 ]]
		-- upvalues: v25 (ref), l_GiftPlayerList_0 (ref), v6 (ref)
		if not isPurchasePrompted then
			return;
		else
			isPurchasePrompted = false;
			giftPlayerListGui.Black.ZIndex = -1;
			guiControllerModule:Close(giftPlayerListGui);
			return;
		end;
	end);
	local function createPlayer(player) --[[ Line: 93 ]] --[[ Name: createPlayer ]]
		-- upvalues: l_LocalPlayer_0 (ref), l_GiftPlayerList_0 (ref), v9 (ref), v24 (ref), v25 (ref), v8 (ref)
		if player == localPlayer then
			return;
		else
			local playerEntryFrame = giftPlayerListGui.Frame.ScrollingFrame.UIListLayout.Template:Clone();
			playerEntryFrame.Name = tostring(player.UserId);
			playerEntryFrame.Button.Headshot.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=180&h=180"):format(player.UserId);
			playerEntryFrame.Button.Username.Text = ("@%*"):format(player.Name);
			playerEntryFrame.Parent = giftPlayerListGui.Frame.ScrollingFrame;
			playerEntryFrame.Button.Activated:Connect(function() --[[ Line: 104 ]]
				-- upvalues: v9 (ref), v24 (ref), v25 (ref), v8 (ref), v28 (copy)
				if not giftState.CurrentProduct then
					return;
				elseif isGiftSending or isPurchasePrompted then
					return;
				else
					isGiftSending = true;
					remotesModule.Gift.SendGiftTo.send({
						productId = giftState.CurrentProduct, 
						targetUserId = player.UserId
					});
					task.wait(3);
					isGiftSending = false;
					return;
				end;
			end);
			return;
		end;
	end;
	playersService.PlayerAdded:Connect(createPlayer);
	for _, playerInstance in playersService:GetPlayers() do
		task.spawn(createPlayer, playerInstance);
	end;
	giftPlayerListGui.Frame.ScrollingFrame.NoPlayers.Visible = #playersService:GetPlayers() <= 1;
	playersService.PlayerRemoving:Connect(function(playerRemoving) --[[ Line: 131 ]]
		-- upvalues: l_GiftPlayerList_0 (ref), l_Players_0 (ref)
		local existingPlayerEntry = giftPlayerListGui.Frame.ScrollingFrame:FindFirstChild((tostring(playerRemoving.UserId)));
		if existingPlayerEntry then
			existingPlayerEntry:Destroy();
		end;
		giftPlayerListGui.Frame.ScrollingFrame.NoPlayers.Visible = #playersService:GetPlayers() <= 1;
	end);
end;
task.spawn(giftState.Start, giftState);
return giftState;