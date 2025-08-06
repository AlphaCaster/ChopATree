local ProximityPromptService = game:GetService("ProximityPromptService")

local Highlight = script.Highlight

ProximityPromptService.PromptShown:Connect(function(prompt)
	Highlight.Adornee = nil
	
	if prompt.ActionText ~= "Collect" then 
		return 
	end
	
	local model = prompt:FindFirstAncestorOfClass("Model")
	if not model then
		return
	end
	
	if model:FindFirstAncestor("Fruits") and model:HasTag("Harvestable") then
		Highlight.Adornee = model
	end
end)

ProximityPromptService.PromptHidden:Connect(function()
	Highlight.Adornee = nil
end)