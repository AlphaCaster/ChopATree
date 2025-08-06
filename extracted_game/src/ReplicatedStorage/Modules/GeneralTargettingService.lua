-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local userInputService = game:GetService("UserInputService");
local replicatedStorage = game:GetService("ReplicatedStorage");
local runService = game:GetService("RunService");
local getMouseToWorldFunction = require(replicatedStorage.Modules.GetMouseToWorld);
local arrowsObject = script:WaitForChild("Arrows");
local attachment1 = arrowsObject.Attachment1;
local attachment2 = arrowsObject.Attachment2;
local interactionState = {
	Handler = nil, 
	CurrentTarget = nil, 
	LastHover = nil
};
local interactionFunctions = {
	Plant = function(instance) --[[ Line: 28 ]]
		local modelAncestor = instance:FindFirstAncestorWhichIsA("Model");
		if not modelAncestor then
			return;
		else
			local growFolder = modelAncestor:FindFirstChild("Grow");
			if not growFolder then
				return;
			elseif not growFolder:FindFirstChild("Age") then
				return;
			elseif not growFolder:FindFirstChild("Grow_Rate") then
				return;
			elseif not growFolder:FindFirstChild("Item_Speed_Mult") then
				return;
			else
				return modelAncestor;
			end;
		end;
	end
};
local highlightInstance = Instance.new("Highlight");
highlightInstance.FillTransparency = 1;
local function resetStates() --[[ Line: 44 ]] --[[ Name: ResetStates ]]
	-- upvalues: v7 (copy), l_Highlight_0 (copy), l_Arrows_0 (copy)
	interactionState.LastHover = nil;
	interactionState.CurrentTarget = nil;
	interactionState.Handler = nil;
	highlightInstance.Parent = nil;
	arrowsObject.Parent = script;
end;
local isInteractionActive = false;
local function _() --[[ Line: 54 ]] --[[ Name: Confirm ]]
	-- upvalues: v14 (ref), v7 (copy), v13 (copy), l_Highlight_0 (copy), l_Arrows_0 (copy)
	if isInteractionActive then
		return;
	else
		local interactionHandler = interactionState.Handler;
		if not interactionHandler then
			return;
		else
			interactionHandler.OnUnhover(interactionState.LastHover);
			if not interactionState.CurrentTarget then
				interactionHandler.OnCancelled();
				return resetStates();
			else
				interactionHandler.OnConfirm(interactionState.CurrentTarget);
				interactionState.LastHover = nil;
				interactionState.CurrentTarget = nil;
				interactionState.Handler = nil;
				highlightInstance.Parent = nil;
				arrowsObject.Parent = script;
				return;
			end;
		end;
	end;
end;
interactionState.CreateTargetingHandler = function(_, handler) --[[ Line: 70 ]] --[[ Name: CreateTargetingHandler ]]
	-- upvalues: v14 (ref), v7 (copy), l_Highlight_0 (copy), l_Arrows_0 (copy)
	isInteractionActive = true;
	interactionState.LastHover = nil;
	interactionState.CurrentTarget = nil;
	interactionState.Handler = nil;
	highlightInstance.Parent = nil;
	arrowsObject.Parent = script;
	interactionState.Handler = handler;
	handler.OnHover = handler.OnHover or function() --[[ Line: 75 ]]

	end;
	handler.OnUnhover = handler.OnUnhover or function() --[[ Line: 76 ]]

	end;
	handler.OnCancelled = handler.OnCancelled or function() --[[ Line: 77 ]]

	end;
	handler.OnConfirm = handler.OnConfirm or function() --[[ Line: 78 ]]

	end;
	task.delay(0.5, function() --[[ Line: 80 ]]
		-- upvalues: v14 (ref)
		isInteractionActive = false;
	end);
end;
runService.RenderStepped:Connect(function() --[[ Line: 84 ]]
	-- upvalues: v7 (copy), v11 (copy), v3 (copy), l_Arrows_0 (copy), l_Highlight_0 (copy), l_Attachment1_0 (copy), l_Attachment2_0 (copy)
	local interactionHandler = interactionState.Handler;
	if not interactionHandler then
		return;
	else
		local targetFunction = interactionFunctions[interactionHandler.TargetType];
		if not targetFunction then
			return;
		else
			local raycastResult = getMouseToWorldFunction(RaycastParams.new(), 100);
			local raycastInstance = raycastResult and raycastResult.Instance;
			local targetInstance = raycastInstance and targetFunction(raycastInstance);
			interactionState.CurrentTarget = targetInstance;
			arrowsObject.Parent = raycastInstance and workspace or script;
			highlightInstance.Adornee = targetInstance;
			highlightInstance.Parent = targetInstance;
			if raycastResult then
				attachment1.WorldCFrame = interactionHandler.Targeter:GetPivot();
				attachment2.WorldCFrame = targetInstance and targetInstance:GetPivot() or CFrame.new(raycastResult.Position);
			end;
			local lastHoveredInstance = interactionState.LastHover;
			if lastHoveredInstance == targetInstance then
				return;
			else
				interactionHandler.OnUnhover(lastHoveredInstance);
				interactionHandler.OnHover(targetInstance);
				return;
			end;
		end;
	end;
end);
local inputBeganActions = {
	[Enum.UserInputType.MouseButton1] = {}
};
local inputEndedActions = {
	[Enum.UserInputType.MouseButton1] = {
		function(_) --[[ Line: 117 ]]
			-- upvalues: v14 (ref), v7 (copy), l_Highlight_0 (copy), l_Arrows_0 (copy)
			if isInteractionActive then
				return;
			else
				local interactionHandler = interactionState.Handler;
				if not interactionHandler then
					return;
				else
					interactionHandler.OnUnhover(interactionState.LastHover);
					if not interactionState.CurrentTarget then
						interactionHandler.OnCancelled();
						interactionState.LastHover = nil;
						interactionState.CurrentTarget = nil;
						interactionState.Handler = nil;
						highlightInstance.Parent = nil;
						arrowsObject.Parent = script;
						local _ = nil;
						return;
					else
						interactionHandler.OnConfirm(interactionState.CurrentTarget);
						interactionState.LastHover = nil;
						interactionState.CurrentTarget = nil;
						interactionState.Handler = nil;
						highlightInstance.Parent = nil;
						arrowsObject.Parent = script;
						return;
					end;
				end;
			end;
		end
	}
};
userInputService.InputBegan:Connect(function(inputObject, _) --[[ Line: 123 ]]
	-- upvalues: v25 (copy)
	local inputBeganAction = inputBeganActions[inputObject.KeyCode] or inputBeganActions[inputObject.UserInputType];
	if not inputBeganAction then
		return;
	else
		for _, actionFunction in inputBeganAction do
			task.spawn(function() --[[ Line: 127 ]]
				-- upvalues: v34 (copy), v30 (copy)
				actionFunction(inputObject);
			end);
		end;
		return;
	end;
end);
userInputService.InputEnded:Connect(function(inputObject, _) --[[ Line: 133 ]]
	-- upvalues: v29 (copy)
	local inputEndedAction = inputEndedActions[inputObject.KeyCode] or inputEndedActions[inputObject.UserInputType];
	if not inputEndedAction then
		return;
	else
		for _, actionFunction in inputEndedAction do
			task.spawn(function() --[[ Line: 137 ]]
				-- upvalues: v39 (copy), v35 (copy)
				actionFunction(inputObject);
			end);
		end;
		return;
	end;
end);
userInputService.TouchTap:Connect(function() --[[ Line: 143 ]]
	-- upvalues: v14 (ref), v7 (copy), l_Highlight_0 (copy), l_Arrows_0 (copy)
	if isInteractionActive then
		return;
	else
		local interactionHandler = interactionState.Handler;
		if not interactionHandler then
			return;
		else
			interactionHandler.OnUnhover(interactionState.LastHover);
			if not interactionState.CurrentTarget then
				interactionHandler.OnCancelled();
				interactionState.LastHover = nil;
				interactionState.CurrentTarget = nil;
				interactionState.Handler = nil;
				highlightInstance.Parent = nil;
				arrowsObject.Parent = script;
				local _ = nil;
				return;
			else
				interactionHandler.OnConfirm(interactionState.CurrentTarget);
				interactionState.LastHover = nil;
				interactionState.CurrentTarget = nil;
				interactionState.Handler = nil;
				highlightInstance.Parent = nil;
				arrowsObject.Parent = script;
				return;
			end;
		end;
	end;
end);
return interactionState;