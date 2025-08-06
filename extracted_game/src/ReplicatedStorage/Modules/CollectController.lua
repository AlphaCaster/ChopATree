-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local proximityPromptService = game:GetService("ProximityPromptService");
local collectionService = game:GetService("CollectionService");
local replicatedStorage = game:GetService("ReplicatedStorage");
local userInputService = game:GetService("UserInputService");
local runService = game:GetService("RunService");
local _ = game:GetService("GuiService");
local playersService = game:GetService("Players");
local trove = require(replicatedStorage.Modules.Trove);
--local remotesModule = require(replicatedStorage.Modules.Remotes);
local blink = require(replicatedStorage.Blink.Blink.Client)
local _ = require(replicatedStorage.Modules.Notification);
local getFarmModule = require(replicatedStorage.Modules.GetFarm);
local isStudio = runService:IsStudio() and false;
local localPlayer = playersService.LocalPlayer;
local playerGui = localPlayer.PlayerGui;
local holdToCollectGui = playerGui:WaitForChild("HoldToCollect");
local backpack = localPlayer.Backpack;
local promptConnectionsMap = {};
local collectedPromptsMap = {};
local cleaner = trove.new();
local collectionHandler = {
	_lastCollected = 0, 
	_holding = false, 
	_initPrompt = function(holdToCollectController, proximityPrompt) --[[ Line: 54 ]] --[[ Name: _initPrompt ]]
		-- upvalues: v7 (copy), v16 (copy), v17 (copy)
		if not proximityPrompt:IsDescendantOf(workspace) then
			return;
		elseif not proximityPrompt:IsA("ProximityPrompt") then
			return;
		else
			local promptConnection = trove.new();
			promptConnection:Add(function() --[[ Line: 65 ]]
				-- upvalues: v16 (ref), v20 (copy), v17 (ref), v19 (copy)
				return function() --[[ Line: 66 ]]
					-- upvalues: v16 (ref), v20 (ref), v17 (ref), v19 (ref)
					promptConnectionsMap[proximityPrompt] = nil;
					collectedPromptsMap[proximityPrompt] = nil;
					holdToCollectController:_updateButtonState();
				end;
			end);
			promptConnection:Connect(proximityPrompt.PromptShown, function() --[[ Line: 74 ]]
				-- upvalues: v17 (ref), v20 (copy), v19 (copy)
				collectedPromptsMap[proximityPrompt] = true;
				holdToCollectController:_updateButtonState();
			end);
			promptConnection:Connect(proximityPrompt.PromptHidden, function() --[[ Line: 84 ]]
				-- upvalues: v17 (ref), v20 (copy), v19 (copy)
				collectedPromptsMap[proximityPrompt] = nil;
				holdToCollectController:_updateButtonState();
			end);
			promptConnection:AttachToInstance(proximityPrompt);
			promptConnectionsMap[proximityPrompt] = promptConnection;
			return;
		end;
	end, 
	_updateButtonState = function(_) --[[ Line: 93 ]] --[[ Name: _updateButtonState ]]
		-- upvalues: v17 (copy), l_HoldToCollect_0 (copy)
		local anyPromptsVisible = next(collectedPromptsMap) ~= nil;
		holdToCollectGui.Collect.Visible = anyPromptsVisible;
	end, 
	Collect = function(collectionData) --[[ Line: 100 ]] --[[ Name: Collect ]]
		-- upvalues: v18 (copy), v17 (copy), v8 (copy)
		local currentTime = os.clock();
		cleaner:Clean();
		local _ = currentTime - collectionData._lastCollected;
		collectionData._lastCollected = currentTime;
		local collectedCropInstances = {};
		for collectible, _ in collectedPromptsMap do
			collectible:SetAttribute("Collected", true);
			task.delay(1, function() --[[ Line: 125 ]]
				-- upvalues: v28 (copy)
				collectible:SetAttribute("Collected", nil);
			end);
			local grandparent = collectible:FindFirstAncestorOfClass("Model");
			if grandparent then
				table.insert(collectedCropInstances, grandparent);
			end;
		end;
		if #collectedCropInstances > 0 then
			collectionData._lastCollected = currentTime;
			blink.Collect.Fire(collectedCropInstances);
		end;
	end
};
local queueModule = require(game.ReplicatedStorage.Code.Queue);
local pickupParticle = workspace.Terrain:WaitForChild("PickupParticle");
collectionHandler.Start = function(self) --[[ Line: 147 ]] --[[ Name: Start ]]
	-- upvalues: l_UserInputService_0 (copy), v11 (copy), l_HoldToCollect_0 (copy), l_CollectionService_0 (copy), l_ProximityPromptService_0 (copy), l_PlayerGui_0 (copy), l_LocalPlayer_0 (copy), v10 (copy), v32 (copy), v17 (copy), l_Backpack_0 (copy), l_PickupParticle_0 (copy)
	local function updateHoldToCollect() --[[ Line: 149 ]] --[[ Name: updateHoldToCollect ]]
		-- upvalues: l_UserInputService_0 (ref), v11 (ref), l_HoldToCollect_0 (ref)
		holdToCollectGui.Enabled = userInputService.TouchEnabled and userInputService:GetLastInputType() == Enum.UserInputType.Touch or isStudio;
	end;
	userInputService.LastInputTypeChanged:Connect(updateHoldToCollect);
	holdToCollectGui.Enabled = userInputService.TouchEnabled and userInputService:GetLastInputType() == Enum.UserInputType.Touch or isStudio;
	task.delay(3, function() --[[ Line: 161 ]]
		-- upvalues: l_UserInputService_0 (ref), v11 (ref), l_HoldToCollect_0 (ref)
		holdToCollectGui.Enabled = userInputService.TouchEnabled and userInputService:GetLastInputType() == Enum.UserInputType.Touch or isStudio;
	end);
	collectionService:GetInstanceAddedSignal("CollectPrompt"):Connect(function(collectPromptInstance) --[[ Line: 165 ]]
		-- upvalues: v34 (copy)
		self:_initPrompt(collectPromptInstance);
	end);
	for _, collectPromptInstance in collectionService:GetTagged("CollectPrompt") do
		task.spawn(function() --[[ Line: 170 ]]
			-- upvalues: v34 (copy), v38 (copy)
			self:_initPrompt(collectPromptInstance);
		end);
	end;
	local lastInput = nil;
	local pickupCount = 0;
	local currentPrompt = nil;
	proximityPromptService.PromptShown:Connect(function(newValue) --[[ Line: 186 ]]
		-- upvalues: v41 (ref)
		currentPrompt = newValue;
	end);
	proximityPromptService.PromptHidden:Connect(function(oldValue) --[[ Line: 191 ]]
		-- upvalues: v41 (ref)
		if currentPrompt == oldValue then
			currentPrompt = nil;
		end;
	end);
	local function runHoldLoop(_) --[[ Line: 198 ]] --[[ Name: RunHoldLoop ]]
		-- upvalues: v34 (copy), v40 (ref), l_PlayerGui_0 (ref), l_LocalPlayer_0 (ref), v10 (ref), v32 (ref), v41 (ref), l_ProximityPromptService_0 (ref), v17 (ref), l_Backpack_0 (ref), l_PickupParticle_0 (ref)
		if self._holding then
			return;
		else
			self._holding = true;
			pickupCount = 0;
			playerGui.PickupTally.TextLabel.val:SetAttribute("LastUpdate", os.time() - 5);
			playerGui.PickupTally.TextLabel.val:SetAttribute("ActualValue", 0);
			localPlayer.PlayerScripts.CollectionQOL.Enabled = false;
			local farmInstance = getFarmModule(localPlayer);
			local promptQueue = queueModule.new();
			if currentPrompt then
				promptQueue:enqueue(currentPrompt);
			end;
			proximityPromptService.PromptShown:Connect(function(item) --[[ Line: 225 ]]
				-- upvalues: v46 (copy)
				if not table.find(promptQueue._queue, item) then
					promptQueue:enqueue(item);
				end;
			end);
			while self._holding do
				if promptQueue:isEmpty() then
					task.wait(0.125);
				else
					local queuedPrompt = promptQueue:dequeue();
					local _ = os.time();
					if queuedPrompt then
						if queuedPrompt:IsDescendantOf(farmInstance) and queuedPrompt:GetAttribute("Collected") ~= true and queuedPrompt:IsDescendantOf(farmInstance) and queuedPrompt:IsDescendantOf(workspace) and queuedPrompt.Enabled then
							queuedPrompt.Enabled = false;
							task.delay(1, function() --[[ Line: 267 ]]
								-- upvalues: v48 (copy)
								if queuedPrompt and queuedPrompt:IsDescendantOf(workspace) then
									queuedPrompt.Enabled = true;
								end;
							end);
							collectedPromptsMap[queuedPrompt] = true;
							self:_updateButtonState();
							self:Collect();
							local cropInstance = queuedPrompt.Parent and queuedPrompt.Parent.Parent;
							if cropInstance:FindFirstChild("Variant") then
								if #backpack:GetChildren() < 200 then
									local pickupSoundName = if cropInstance.Variant.Value ~= "Normal" then cropInstance.Variant.Value else game.SoundService.Collect.Name;
									game.ReplicatedStorage.GameEvents.PickupEvent:Fire(pickupSoundName);
									pickupParticle.WorldPosition = queuedPrompt.Parent.Position;
									pickupParticle.ParticleEmitter:Emit(Random.new():NextInteger(1, 3));
									pickupParticle.Gradient:Emit(1);
								end;
							else
								continue;
							end;
						else
							continue;
						end;
					end;
					task.wait(0.125);
				end;
			end;
			localPlayer.PlayerScripts.CollectionQOL.Enabled = true;
			return;
		end;
	end;
	proximityPromptService.PromptTriggered:Connect(function(collectPrompt) --[[ Line: 387 ]]
		-- upvalues: l_UserInputService_0 (ref), v52 (copy)
		if not collectPrompt:HasTag("CollectPrompt") then
			return;
		elseif not userInputService:IsKeyDown(Enum.KeyCode.E) and not userInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonX) then
			return;
		else
			local inputProcessed = false;
			local inputEndedConnection = nil;
			local currentTime = os.clock();
			collectPrompt:SetAttribute("Collected", true);
			task.delay(1, function()
				collectPrompt:SetAttribute("Collected", nil);
			end);
			local grandparent = collectPrompt:FindFirstAncestorOfClass("Model");
			if grandparent then
				self._lastCollected = currentTime;
				blink.Collect.Fire({grandparent});
				local pickupSoundName = if grandparent.Variant.Value ~= "Normal" then grandparent.Variant.Value else game.SoundService.Collect.Name;
				game.ReplicatedStorage.GameEvents.PickupEvent:Fire(pickupSoundName);

				pickupParticle.WorldPosition = collectPrompt.Parent.Position;
				pickupParticle.ParticleEmitter:Emit(Random.new():NextInteger(1, 3));
				pickupParticle.Gradient:Emit(1);
			end;
			inputEndedConnection = userInputService.InputEnded:Connect(function(inputObject) --[[ Line: 398 ]]
				-- upvalues: v55 (ref), v54 (ref)
				if inputObject.KeyCode == Enum.KeyCode.E or inputObject.KeyCode == Enum.KeyCode.ButtonX then
					inputEndedConnection:Disconnect();
					inputProcessed = true;
				end;
			end);
			task.wait(1);
			if not inputProcessed then
				inputEndedConnection:Disconnect();
				runHoldLoop(false);
			end;
			return;
		end;
	end);
	userInputService.InputBegan:Connect(function(inputObject, inputProcessed) --[[ Line: 416 ]]
		-- upvalues: v39 (ref), l_UserInputService_0 (ref), v52 (copy)
		if not inputProcessed and (inputObject.KeyCode == Enum.KeyCode.E or inputObject.KeyCode == Enum.KeyCode.ButtonX) then
			lastInput = inputObject;
			local inputEnded = false;
			local inputEndedConnection = nil;
			do
				local inputEndedFlag, inputEndedConnection2 = inputEnded, inputEndedConnection;
				inputEndedConnection2 = userInputService.InputEnded:Connect(function(inputObject) --[[ Line: 423 ]]
					-- upvalues: l_v60_0 (ref), l_v59_0 (ref)
					if inputObject.KeyCode == Enum.KeyCode.E or inputObject.KeyCode == Enum.KeyCode.ButtonX then
						inputEndedConnection2:Disconnect();
						inputEndedFlag = true;
					end;
				end);
				task.wait(1);
				if not inputEndedFlag and (game:GetService("UserInputService"):IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonX) or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.E)) then
					inputEndedConnection2:Disconnect();
					runHoldLoop(false);
				end;
			end;
		end;
	end);
	self:_updateButtonState();
	holdToCollectGui.Collect.MouseButton1Down:Connect(function(_) --[[ Line: 445 ]]
		-- upvalues: v52 (copy)
		runHoldLoop(true);
	end);
	userInputService.InputEnded:Connect(function(inputObject, _) --[[ Line: 449 ]]
		-- upvalues: v34 (copy)
		if inputObject.KeyCode == Enum.KeyCode.E or inputObject.KeyCode == Enum.KeyCode.ButtonX then
			self._holding = false;
		end;
		if inputObject.UserInputType == Enum.UserInputType.Touch or inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
			self._holding = false;
		end;
	end);
	userInputService.WindowFocusReleased:Connect(function() --[[ Line: 460 ]]
		-- upvalues: v34 (copy)
		self._holding = false;
	end);
	local function updatePickupTallyVisibility() --[[ Line: 464 ]] --[[ Name: updatePickupTallyVisibility ]]
		-- upvalues: l_PlayerGui_0 (ref), l_LocalPlayer_0 (ref)
		playerGui.PickupTally.Enabled = localPlayer:GetAttribute("AB_ShowPickupTally") == true;
	end;
	localPlayer:GetAttributeChangedSignal("AB_ShowPickupTally"):Connect(updatePickupTallyVisibility);
	playerGui.PickupTally.Enabled = localPlayer:GetAttribute("AB_ShowPickupTally") == true;
end;
task.spawn(function() --[[ Line: 472 ]]
	-- upvalues: v31 (copy)
	while true do
		task.wait(2);
		collectionHandler:_updateButtonState();
	end;
end);
task.spawn(collectionHandler.Start, collectionHandler);
return collectionHandler;