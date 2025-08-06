-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local playersService = game:GetService("Players");
local userInputService = game:GetService("UserInputService");
local collectionService = game:GetService("CollectionService");
local replicatedStorageService = game:GetService("ReplicatedStorage");
local tweenService = game:GetService("TweenService");
local runService = game:GetService("RunService");
local proximityPromptService = game:GetService("ProximityPromptService");
local trowelRemoteEvent = replicatedStorageService:WaitForChild("GameEvents"):WaitForChild("TrowelRemote");
local getFarmModule = require(replicatedStorageService.Modules.GetFarm);
local notificationModule = require(replicatedStorageService.Modules.Notification);
local effectControllerModule = require(replicatedStorageService.Modules.EffectController.Libraries.Default);
local localPlayer = playersService.LocalPlayer;
local currentCamera = workspace.CurrentCamera;
local trowelClientGui = localPlayer.PlayerGui:WaitForChild("Trowel_Client");
local cancelButton = trowelClientGui.Frame:WaitForChild("Cancel");
local selectedPlant = nil;
local equippedTrowelTool = nil;
local plantOriginalCFrame = nil;
local plantHighlight = script.Highlight;
local placedPlantsList = {};
local destroyingConnection = nil;
local isDebouncing = false;
local function _() --[[ Line: 42 ]] --[[ Name: GetTrowel ]]
	-- upvalues: l_LocalPlayer_0 (copy)
	local tool = localPlayer.Character:FindFirstChildOfClass("Tool");
	return (tool and tool.Name:match("Trowel")) and tool or nil;
end;
local function verifyPlant(plantModel) --[[ Line: 49 ]] --[[ Name: VerifyPlant ]]
	-- upvalues: v8 (copy), l_LocalPlayer_0 (copy)
	local farmData = getFarmModule(localPlayer);
	if not farmData then
		return false;
	elseif not plantModel:IsDescendantOf(farmData) then
		return false;
	elseif not plantModel:FindFirstChild("Grow") or not plantModel:FindFirstChild("Fruits") or not plantModel:FindFirstChild("Fruit_Spawn") or plantModel.Parent.Name == "Fruits" or not plantModel:FindFirstChild("ADD_DATA") then
		return false;
	else
		return true;
	end;
end;
local function pickupRaycast(mousePosition1) --[[ Line: 58 ]] --[[ Name: PickupRaycast ]]
	-- upvalues: l_CurrentCamera_0 (copy), l_CollectionService_0 (copy)
	local cameraRay = currentCamera:ViewportPointToRay(mousePosition1.X, mousePosition1.Y);
	local shovelRaycastParams = RaycastParams.new();
	shovelRaycastParams.FilterType = Enum.RaycastFilterType.Exclude;
	shovelRaycastParams.FilterDescendantsInstances = {
		collectionService:GetTagged("ShovelIgnore")
	};
	local shovelRaycastResult = workspace:Raycast(cameraRay.Origin, cameraRay.Direction * 500, shovelRaycastParams);
	if shovelRaycastResult and shovelRaycastResult.Instance then
		return shovelRaycastResult;
	else
		return;
	end;
end;
local function placementRaycast(mousePosition2) --[[ Line: 72 ]] --[[ Name: PlacementRaycast ]]
	-- upvalues: l_CurrentCamera_0 (copy), v8 (copy), l_LocalPlayer_0 (copy)
	local placementCameraRay = currentCamera:ViewportPointToRay(mousePosition2.X, mousePosition2.Y);
	local locationRaycastParams = RaycastParams.new();
	locationRaycastParams.FilterType = Enum.RaycastFilterType.Include;
	locationRaycastParams.FilterDescendantsInstances = {
		getFarmModule(localPlayer).Important.Plant_Locations:GetChildren()
	};
	local locationRaycastResult = workspace:Raycast(placementCameraRay.Origin, placementCameraRay.Direction * 500, locationRaycastParams);
	if locationRaycastResult and locationRaycastResult.Instance then
		return locationRaycastResult;
	else
		return;
	end;
end;
local function cancelPlacement() --[[ Line: 86 ]] --[[ Name: Cancel ]]
	-- upvalues: v15 (ref), v21 (ref), l_LocalPlayer_0 (copy), l_TrowelRemote_0 (copy), v16 (ref), v9 (copy), v19 (copy), l_Highlight_0 (copy)
	if not selectedPlant or isDebouncing then
		return;
	else
		local canceledPlant = selectedPlant;
		selectedPlant = nil;
		if localPlayer.Character:FindFirstChildOfClass("Humanoid") then
			localPlayer.Character:FindFirstChildOfClass("Humanoid"):UnequipTools();
		end;
		trowelRemoteEvent:InvokeServer("Cancel", equippedTrowelTool, canceledPlant);
		notificationModule:CreateNotification((("Canceled moving %*!"):format(canceledPlant.Name)));
		local originalPartProperties = placedPlantsList or {};
		for _, part in originalPartProperties do
			part.CanCollide = true;
			part.CanQuery = true;
		end;
		plantHighlight.Adornee = nil;
		return;
	end;
end;
runService.RenderStepped:Connect(function() --[[ Line: 110 ]]
	-- upvalues: v16 (ref), l_LocalPlayer_0 (copy), l_Trowel_Client_0 (copy), v15 (ref), l_ProximityPromptService_0 (copy), v20 (ref), v41 (copy), l_UserInputService_0 (copy), v36 (copy), v17 (ref), v31 (copy), v26 (copy), l_Highlight_0 (copy), l_TweenService_0 (copy)
	local tool = localPlayer.Character:FindFirstChildOfClass("Tool");
	equippedTrowelTool = (tool and tool.Name:match("Trowel")) and tool or nil;
	trowelClientGui.Enabled = selectedPlant ~= nil;
	if proximityPromptService.Enabled ~= (equippedTrowelTool == nil) then
		proximityPromptService.Enabled = equippedTrowelTool == nil;
	end;
	if equippedTrowelTool then
		if not destroyingConnection then
			destroyingConnection = equippedTrowelTool.Destroying:Once(function() --[[ Line: 120 ]]
				-- upvalues: v20 (ref), v41 (ref)
				destroyingConnection:Disconnect();
				destroyingConnection = nil;
				cancelPlacement();
			end);
		end;
		local mouseLocation = userInputService:GetMouseLocation();
		if selectedPlant then
			tool = placementRaycast(mouseLocation);
			if tool and tool.Position then
				selectedPlant:PivotTo(CFrame.new(tool.Position) * CFrame.new(0, 3, 0) * plantOriginalCFrame.Rotation);
				return;
			else
				selectedPlant:PivotTo(plantOriginalCFrame);
				return;
			end;
		else
			tool = pickupRaycast(mouseLocation);
			if not tool then
				return;
			else
				local plantParent = tool.Instance.Parent;
				if not verifyPlant(plantParent) then
					plantHighlight.Adornee = nil;
					return;
				else
					if plantHighlight.Adornee ~= plantParent then
						plantHighlight.FillTransparency = 1;
						tweenService:Create(plantHighlight, TweenInfo.new(0.25), {
							FillTransparency = 0.65
						}):Play();
					end;
					plantHighlight.Adornee = plantParent;
					return;
				end;
			end;
		end;
	else
		if selectedPlant then
			cancelPlacement();
		end;
		plantHighlight.Adornee = nil;
		return;
	end;
end);
cancelButton.Activated:Connect(cancelPlacement);
local function processInput(mousePosition, isDebounced) --[[ Line: 167 ]] --[[ Name: ProcessInput ]]
	-- upvalues: l_LocalPlayer_0 (copy), v21 (ref), v9 (copy), l_UserInputService_0 (copy), v15 (ref), v36 (copy), v8 (copy), l_Highlight_0 (copy), v17 (ref), l_RunService_0 (copy), l_TweenService_0 (copy), l_TrowelRemote_0 (copy), v16 (ref), v10 (copy), l_CurrentCamera_0 (copy), v19 (copy), v31 (copy), v26 (copy)
	if localPlayer.Character then
		local placementTool = localPlayer.Character:FindFirstChildOfClass("Tool");
		if placementTool and placementTool.Name:match("Trowel") and not isDebounced then
			if isDebouncing then
				notificationModule:CreateNotification("On debounce!");
				return;
			else
				local inputPosition = mousePosition or userInputService:GetMouseLocation();
				if selectedPlant then
					placementTool = placementRaycast(inputPosition);
					if not placementTool or not placementTool.Instance.Name:find"Can_Plant" then
						notificationModule:CreateNotification("Can't place here!");
						return;
					else
						local plantRaycastParams = RaycastParams.new();
						plantRaycastParams.FilterType = Enum.RaycastFilterType.Include;
						plantRaycastParams.FilterDescendantsInstances = {
							getFarmModule(localPlayer).Important.Plants_Physical:GetChildren()
						};
						if workspace:Raycast(placementTool.Position + Vector3.new(0, 20, 0, 0), Vector3.new(0, -25, 0, 0), plantRaycastParams) then
							return;
						else
							plantHighlight.Adornee = nil;
							isDebouncing = true;
							task.spawn(function() --[[ Line: 204 ]]
								-- upvalues: l_Tool_2 (copy), v17 (ref), v15 (ref), l_RunService_0 (ref), l_TweenService_0 (ref), l_TrowelRemote_0 (ref), v16 (ref), v9 (ref), v10 (ref), l_CurrentCamera_0 (ref), v21 (ref)
								local plantPlacementCFrame = CFrame.new(placementTool.Position) * CFrame.new(0, 3, 0) * plantOriginalCFrame.Rotation;
								local plantRotationCFrame = CFrame.new(placementTool.Position.X, plantOriginalCFrame.Y, placementTool.Position.Z) * plantOriginalCFrame.Rotation;
								local plantInstance = selectedPlant;
								plantInstance:PivotTo(plantPlacementCFrame);
								local elapsedTime = 0;
								while elapsedTime < 0.15 do
									elapsedTime = elapsedTime + runService.Heartbeat:Wait();
									plantInstance:PivotTo(plantPlacementCFrame:Lerp(plantRotationCFrame, (tweenService:GetValue(elapsedTime / 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In))));
								end;
								trowelRemoteEvent:InvokeServer("Place", equippedTrowelTool, plantInstance, plantRotationCFrame);
								notificationModule:CreateNotification((("Successfully moved %*!"):format(plantInstance.Name)));
								local placeEffect = effectControllerModule:CreateEffect({
									Object = script.Place, 
									Emit = true, 
									Position = placementTool.Position, 
									DebrisTime = 1
								});
								effectControllerModule:SetScale(placeEffect, 3, {});
								effectControllerModule:PlaySound(script.PlantTrowel, currentCamera);
								task.wait(1);
								isDebouncing = false;
							end);
							local originalPartProperties2 = placedPlantsList or {};
							for _, part2 in originalPartProperties2 do
								part2.CanCollide = true;
								part2.CanQuery = true;
							end;
							selectedPlant = nil;
							return;
						end;
					end;
				else
					placementTool = pickupRaycast(inputPosition);
					if not placementTool then
						return;
					else
						local selectedInstanceParent = placementTool.Instance.Parent;
						if not verifyPlant(selectedInstanceParent) then
							notificationModule:CreateNotification("Can't move this!");
							return;
						else
							isDebouncing = true;
							trowelRemoteEvent:InvokeServer("Pickup", equippedTrowelTool, selectedInstanceParent);
							isDebouncing = false;
							notificationModule:CreateNotification((("Picked up %*!"):format(selectedInstanceParent.Name)));
							plantOriginalCFrame = selectedInstanceParent:GetPivot();
							for _, descendant in selectedInstanceParent:GetDescendants() do
								if not descendant:IsA("BasePart") or not descendant.CanCollide then
									if descendant:IsA("BasePart") then
										descendant.CanQuery = false;
									end;
								else
									descendant.CanCollide = false;
									descendant.CanQuery = false;
									table.insert(placedPlantsList, descendant);
								end;
							end;
							selectedPlant = selectedInstanceParent;
							return;
						end;
					end;
				end;
			end;
		end;
	end;
end;
if userInputService.TouchEnabled then
	userInputService.TouchTapInWorld:Connect(processInput);
else
	localPlayer:GetMouse().Button1Down:Connect(processInput);
end;