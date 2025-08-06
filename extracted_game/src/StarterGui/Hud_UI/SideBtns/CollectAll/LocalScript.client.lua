script.Parent.Activated:Connect(function()
	game:GetService("MarketplaceService"):PromptProductPurchase(game.Players.LocalPlayer, require(game.ReplicatedStorage.PRODUCT_IDS).Products.CollectAll)
	end)