local Plant = script:FindFirstAncestorOfClass("Model")

script.Parent.Triggered:Connect(function(playerWhoTriggered: Player) 
	if not script.Parent.Enabled then
		playerWhoTriggered:Kick("gg detected by hyperion MODIFIED CLIENT!!! js quit bro")
		return
	end
	
	if Plant:GetAttribute("Owner") ~= playerWhoTriggered.Name then
		return
	end

	local clone = game.ReplicatedStorage.Fruit_Spawn:FindFirstChild(Plant.Name):Clone()

	local tool = Instance.new("Tool")
	tool.Name = Plant.Name .. " (" .. Plant:FindFirstChild("Weight").Value .. " kg)"
	tool.Parent = playerWhoTriggered.Backpack

	local itemStr = Instance.new("StringValue")
	itemStr.Name = "Item_String"
	itemStr.Value = Plant.Name
	itemStr.Parent = tool

	local weight = Instance.new("NumberValue")
	weight.Name = "Weight"
	weight.Value = Plant.Weight.Value
	weight.Parent = tool

	local variant = Instance.new("StringValue")
	variant.Name = "Variant"
	variant.Value = Plant.Variant.Value
	variant.Parent = tool

	tool:ScaleTo(Plant:GetScale())

	local largestPart = nil
	local largestVolume = 0

	for _, descendant in pairs(Plant:GetDescendants()) do
		if descendant:IsA("BasePart") then
			local volume = descendant.Size.X * descendant.Size.Y * descendant.Size.Z
			if volume > largestVolume then
				largestVolume = volume
				largestPart = descendant
			end
		end
	end

	largestPart.Name = "Handle"

	for _,v in pairs(Plant:GetDescendants()) do
		if v:IsA("BasePart") and v.Name ~= "PrimaryPart" then
			v.Transparency = v:GetAttribute("OG_Transparency") or 1

			if v ~= largestPart then
				local weld = Instance.new("WeldConstraint")
				weld.Part0 = largestPart
				weld.Part1 = v
				weld.Parent = largestPart
			end

			v.CanCollide = false
			v.Anchored = false

			v.Parent = tool
		elseif v:IsA("ProximityPrompt") or v:IsA("Script") then
			v:Destroy()
		end
	end

	tool.Grip = CFrame.Angles(0, 0, math.rad(180))
	Plant:Destroy()
end)