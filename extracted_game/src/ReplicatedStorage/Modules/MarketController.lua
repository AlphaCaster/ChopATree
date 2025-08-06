-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local marketplaceService = game:GetService("MarketplaceService");
local replicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("SoundService");
local playersService = game:GetService("Players");
local notificationModule = require(replicatedStorage.Modules.Notification);
local retryPcallModule = require(replicatedStorage.Modules.RetryPcall);
local observersModule = require(replicatedStorage.Modules.Observers);
local commaModule = require(replicatedStorage.Comma_Module);
local remotesModule = require(replicatedStorage.Modules.Remotes);
local signalModule = require(replicatedStorage.Modules.Signal);
local _ = require(replicatedStorage.Modules.IsDev);
local localPlayer = playersService.LocalPlayer;
local _ = localPlayer.PlayerGui;
local purchaseHandler = {
	PromptProductPurchaseInitiated = signalModule.new()
};
local priceLabelMap = {};
local function updatePriceLabel(priceLabel) --[[ Line: 26 ]] --[[ Name: update ]]
	-- upvalues: v5 (copy), l_MarketplaceService_0 (copy), v7 (copy)
	local productId = priceLabel:GetAttribute("ProductId") or priceLabel:GetAttribute("GamepassId");
	if productId == nil then
		return;
	else
		priceLabel.Text = "???";
		local success, productInfo = retryPcallModule(30, 6, function() --[[ Line: 36 ]]
			-- upvalues: l_MarketplaceService_0 (ref), l_v15_Attribute_0 (copy)
			local type
			if priceLabel:GetAttribute("ProductId") then 
				type = Enum.InfoType.Product
			elseif priceLabel:GetAttribute("GamepassId") then		
				type = Enum.InfoType.GamePass
			end 
			return marketplaceService:GetProductInfo(productId, type);
		end);
		if not success then
			priceLabel.Text = "Failed to load";
			return;
		else
			local formattedText = priceLabel:GetAttribute("Format") or ":robux::value:";
			formattedText = string.gsub(formattedText, ":robux:", "\238\128\130");
			formattedText = string.gsub(formattedText, ":value:", commaModule.Comma(productInfo.PriceInRobux));
			priceLabel.Text = string.gsub(formattedText, ":rawvalue:", productInfo.PriceInRobux);
			return;
		end;
	end;
end;
purchaseHandler.PromptPurchase = function(_, productIdToPurchase, purchaseType) --[[ Line: 51 ]] --[[ Name: PromptPurchase ]]
	-- upvalues: v4 (copy), v8 (copy), v13 (copy), l_LocalPlayer_0 (copy), l_MarketplaceService_0 (copy)
	if purchaseType == Enum.InfoType.Product then
		if workspace:GetAttribute("AllowFakePurchases") then
			notificationModule:CreateNotification((("Invoking fake purchase for \"%*\""):format(productIdToPurchase)));
			task.wait(0.5);
			remotesModule.Market.FakePurchase.send(productIdToPurchase);
			task.wait(1);
			return;
		else
			purchaseHandler.PromptProductPurchaseInitiated:Fire(localPlayer, productIdToPurchase);
			marketplaceService:PromptProductPurchase(localPlayer, productIdToPurchase);
			return;
		end;
	elseif purchaseType == Enum.InfoType.GamePass then
		marketplaceService:PromptGamePassPurchase(localPlayer, productIdToPurchase);
		return;
	elseif purchaseType == Enum.InfoType.Asset then
		marketplaceService:PromptPurchase(localPlayer, productIdToPurchase);
		return;
	else
		if purchaseType == Enum.InfoType.Bundle then
			marketplaceService:PromptBundlePurchase(localPlayer, productIdToPurchase);
		end;
		return;
	end;
end;
purchaseHandler.SetPriceLabel = function(_, priceLabelInstance, productId, isGamepass) --[[ Line: 71 ]] --[[ Name: SetPriceLabel ]]
	-- upvalues: v20 (copy)
	priceLabelInstance:AddTag("PriceLabel");
	priceLabelInstance:SetAttribute("Format", ":robux::value:");
	priceLabelInstance:SetAttribute(isGamepass and "GamepassId" or "ProductId", productId);
	task.spawn(updatePriceLabel, priceLabelInstance);
end;
purchaseHandler.Start = function(_) --[[ Line: 78 ]] --[[ Name: Start ]]
	-- upvalues: v8 (copy), v13 (copy), v6 (copy), v14 (copy), v20 (copy)
	remotesModule.Market.PromptPurchase.listen(function(purchaseRequest) --[[ Line: 79 ]]
		-- upvalues: v13 (ref)
		local infoType = nil;
		if purchaseRequest.type == 1 then
			infoType = Enum.InfoType.Product;
		elseif purchaseRequest.type == 2 then
			infoType = Enum.InfoType.GamePass;
		elseif purchaseRequest.type == 3 then
			infoType = Enum.InfoType.Asset;
		elseif purchaseRequest.type == 4 then
			infoType = Enum.InfoType.Bundle;
		end;
		if not infoType then
			return;
		else
			purchaseHandler:PromptPurchase(purchaseRequest.id, infoType);
			return;
		end;
	end);
	observersModule.observeTag("PriceLabel", function(observedObject) --[[ Line: 98 ]]
		-- upvalues: v6 (ref), v14 (ref), v20 (ref)
		if not observedObject:IsA("TextButton") and not observedObject:IsA("TextLabel") then
			return nil;
		else
			return observersModule.observeAttribute(observedObject, "ProductId", function(productId) --[[ Line: 103 ]]
				-- upvalues: v14 (ref), v31 (copy), v20 (ref)
				priceLabelMap[observedObject] = productId;
				local updateTask = task.spawn(updatePriceLabel, observedObject);
				return function() --[[ Line: 107 ]]
					-- upvalues: v33 (copy), v14 (ref), v31 (ref)
					if coroutine.status(updateTask) == "suspended" then
						pcall(task.cancel, updateTask);
					end;
					priceLabelMap[observedObject] = nil;
				end;
			end);
		end;
	end);
end;
task.spawn(purchaseHandler.Start, purchaseHandler);
return purchaseHandler;