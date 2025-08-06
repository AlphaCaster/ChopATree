local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local Farms = workspace.Farm
local Product = require(ReplicatedStorage.PRODUCT_IDS)
local GameEvents = require(script.Parent.Modules.GameEvents)

local Plants = require(ServerStorage.Plants)

local Steal = Product.Products.StealPlant

for i, v in Farms:GetChildren() do
	local Important = v.Important
	local Plants_Physical = Important.Plants_Physical
	
	Plants_Physical.DescendantAdded:Connect(function(prompt)
		if not prompt:IsA("ProximityPrompt") then
			return
		end
		
		prompt.Triggered:Connect(function(player)
			local Owner = Important.Data.Owner.Value
			if player.Name ~= Owner then
				if not player:FindFirstChild("Stealing") then
					local obj = Instance.new("ObjectValue")
					obj.Value = prompt:FindFirstAncestorOfClass("Model")
					obj.Name = "Stealing"
					obj.Parent = player
				else
					player.Stealing.Value = prompt:FindFirstAncestorOfClass("Model")
				end
				
				MarketplaceService:PromptProductPurchase(player, Steal, false, Enum.CurrencyType.Robux)
			end
		end)
	end)
end

script.Parent.StealPlant.Event:Connect(function(player)
	local objVal = player:FindFirstChild("Stealing")
	if objVal then
		local plant = objVal.Value
		local plotOwner = plant:FindFirstAncestor("Important").Data.Owner.Value
		local isFruit = plant:FindFirstAncestor("Fruits")
		
		if Players:FindFirstChild(plotOwner) then
			local searchIn = isFruit and Plants[Players[plotOwner]].Fruits or Plants[Players[plotOwner]].Plants

			for uuid, data in searchIn do
				if plant:IsDescendantOf(data.model) or data.model == plant then
					data.owner = player
					data:Collect(player)
				end
			end
			
			ReplicatedStorage.GameEvents.Notification:FireClient(player, `You stole {plotOwner}'s plant!`)
			ReplicatedStorage.GameEvents.Notification:FireClient(Players[plotOwner], "Someone has stolen one of your plants!")
		end
	end
end)