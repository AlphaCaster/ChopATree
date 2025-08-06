local PlayersService = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local ProximityPromptService = game:GetService("ProximityPromptService");

local TrowelRemoteEvent = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("TrowelRemote");

local FarmUtils = require(ReplicatedStorage.Modules.GetFarm);
local NotificationManager = require(ReplicatedStorage.Modules.Notification);
local DefaultEffectLibrary = require(ReplicatedStorage.Modules.EffectController.Libraries.Default);

local LocalPlayer = PlayersService.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local TrowelClientGui = LocalPlayer.PlayerGui:WaitForChild("Trowel_Client");
local CancelButton = TrowelClientGui.Frame:WaitForChild("Cancel");

local currentMovingObject = nil;
local equippedTrowelTool = nil;
local originalPivotOfMovingObject = nil;
local HighlightInstance = script.Highlight;
local collisionToggledParts = {};
local trowelDestroyingConnection = nil;

local function getEquippedTrowel_Unused() --[[ Line: 41 ]] --[[ Name: GetTrowel ]]
	-- upvalues: LocalPlayer (copy)
	local characterTool = LocalPlayer.Character:FindFirstChildOfClass("Tool");
	return (characterTool and characterTool.Name:match("Trowel")) and characterTool or nil;
end;

local function isValidPlantForTrowel(plantInstance) --[[ Line: 48 ]] --[[ Name: VerifyPlant ]]
	-- upvalues: FarmUtils (copy), LocalPlayer (copy)
	local playerFarm = FarmUtils(LocalPlayer);
	if not playerFarm then
		return false;
	elseif not plantInstance:IsDescendantOf(playerFarm) then
		return false;
	elseif not plantInstance:FindFirstChild("Grow") or not plantInstance:FindFirstChild("Fruits") or not plantInstance:FindFirstChild("Fruit_Spawn") or plantInstance.Parent.Name == "Fruits" or not plantInstance:FindFirstChild("ADD_DATA") then
		return false;
	else
		return true;
	end;
end;

local function performPickupRaycast(mousePosition) --[[ Line: 57 ]] --[[ Name: PickupRaycast ]]
	-- upvalues: CurrentCamera (copy), CollectionService (copy)
	local cameraRay = CurrentCamera:ViewportPointToRay(mousePosition.X, mousePosition.Y);
	local raycastParams = RaycastParams.new();
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude;
	raycastParams.FilterDescendantsInstances = {
		CollectionService:GetTagged("ShovelIgnore")
	};
	local raycastResult = workspace:Raycast(cameraRay.Origin, cameraRay.Direction * 500, raycastParams);
	if raycastResult and raycastResult.Instance then
		return raycastResult;
	else
		return;
	end;
end;

local function performPlacementRaycast(mousePosition) --[[ Line: 71 ]] --[[ Name: PlacementRaycast ]]
	-- upvalues: CurrentCamera (copy), FarmUtils (copy), LocalPlayer (copy)
	local cameraRay = CurrentCamera:ViewportPointToRay(mousePosition.X, mousePosition.Y);
	local raycastParams = RaycastParams.new();
	raycastParams.FilterType = Enum.RaycastFilterType.Include;
	raycastParams.FilterDescendantsInstances = {
		FarmUtils(LocalPlayer).Important.Plant_Locations:GetChildren()
	};
	local raycastResult = workspace:Raycast(cameraRay.Origin, cameraRay.Direction * 500, raycastParams);
	if raycastResult and raycastResult.Instance then
		return raycastResult;
	else
		return;
	end;
end;

local function cancelTrowelAction() --[[ Line: 85 ]] --[[ Name: Cancel ]]
	-- upvalues: currentMovingObject (ref), LocalPlayer (copy), TrowelRemoteEvent (copy), equippedTrowelTool (ref), NotificationManager (copy), collisionToggledParts (copy), originalPivotOfMovingObject (ref), HighlightInstance (copy)
	if not currentMovingObject then
		return;
	else
		local objectToCancelMovement = currentMovingObject;
		currentMovingObject = nil;
		if LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
			LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):UnequipTools();
		end;
		TrowelRemoteEvent:InvokeServer("Cancel", equippedTrowelTool, objectToCancelMovement);
		NotificationManager:CreateNotification((("Canceled moving %*!"):format(objectToCancelMovement.Name)));
		local partsToRestoreCollision = collisionToggledParts or {};
		for _, part in partsToRestoreCollision do
			part.CanCollide = true;
			part.CanQuery = true;
		end;
		objectToCancelMovement:PivotTo(originalPivotOfMovingObject);
		HighlightInstance.Adornee = nil;
		return;
	end;
end;

RunService.RenderStepped:Connect(function() --[[ Line: 112 ]]
	-- upvalues: equippedTrowelTool (ref), LocalPlayer (copy), TrowelClientGui (copy), currentMovingObject (ref), ProximityPromptService (copy), trowelDestroyingConnection (ref), cancelTrowelAction (copy), UserInputService (copy), performPlacementRaycast (copy), originalPivotOfMovingObject (ref), performPickupRaycast (copy), isValidPlantForTrowel (copy), HighlightInstance (copy), TweenService (copy)
	local currentlyEquippedTool = LocalPlayer.Character:FindFirstChildOfClass("Tool");
	equippedTrowelTool = (currentlyEquippedTool and currentlyEquippedTool.Name:match("Trowel")) and currentlyEquippedTool or nil;
	TrowelClientGui.Enabled = currentMovingObject ~= nil;

	if ProximityPromptService.Enabled ~= (equippedTrowelTool == nil) then
		ProximityPromptService.Enabled = equippedTrowelTool == nil;
	end;

	if equippedTrowelTool then
		if not trowelDestroyingConnection then
			trowelDestroyingConnection = equippedTrowelTool.Destroying:Once(function() --[[ Line: 122 ]]
				-- upvalues: trowelDestroyingConnection (ref), cancelTrowelAction (ref)
				trowelDestroyingConnection:Disconnect();
				trowelDestroyingConnection = nil;
				cancelTrowelAction();
			end);
		end;

		local currentMouseLocation = UserInputService:GetMouseLocation();

		if currentMovingObject then
			local placementRaycastHit = performPlacementRaycast(currentMouseLocation);
			if placementRaycastHit and placementRaycastHit.Position then
				currentMovingObject:PivotTo(CFrame.new(placementRaycastHit.Position) * CFrame.new(0, 3, 0) * originalPivotOfMovingObject.Rotation);
				return;
			else
				currentMovingObject:PivotTo(CFrame.new(0, -100, 0));
				return;
			end;
		else
			local pickupRaycastHit = performPickupRaycast(currentMouseLocation);
			if not pickupRaycastHit then
				return;
			else
				local hitInstanceParent = pickupRaycastHit.Instance.Parent;
				if not isValidPlantForTrowel(hitInstanceParent) then
					HighlightInstance.Adornee = nil;
					return;
				else
					if HighlightInstance.Adornee ~= hitInstanceParent then
						HighlightInstance.FillTransparency = 1;
						TweenService:Create(HighlightInstance, TweenInfo.new(0.25), {
							FillTransparency = 0.65
						}):Play();
					end;
					HighlightInstance.Adornee = hitInstanceParent;
					return;
				end;
			end;
		end;
	else
		if currentMovingObject then
			cancelTrowelAction();
		end;
		HighlightInstance.Adornee = nil;
		return;
	end;
end);

CancelButton.Activated:Connect(cancelTrowelAction);

local function handleTrowelInput(inputPosition, isGameProcessedEvent) --[[ Line: 169 ]] --[[ Name: ProcessInput ]]
	-- upvalues: LocalPlayer (copy), UserInputService (copy), currentMovingObject (ref), performPlacementRaycast (copy), NotificationManager (copy), FarmUtils (copy), HighlightInstance (copy), originalPivotOfMovingObject (ref), RunService (copy), TweenService (copy), TrowelRemoteEvent (copy), equippedTrowelTool (ref), DefaultEffectLibrary (copy), CurrentCamera (copy), collisionToggledParts (copy), performPickupRaycast (copy), isValidPlantForTrowel (copy)
	if LocalPlayer.Character then
		local activeTrowelTool = LocalPlayer.Character:FindFirstChildOfClass("Tool");
		if activeTrowelTool and activeTrowelTool.Name:match("Trowel") and not isGameProcessedEvent then
			local targetPosition = inputPosition or UserInputService:GetMouseLocation();

			if currentMovingObject then
				local placementRaycastHit = performPlacementRaycast(targetPosition);
				if not placementRaycastHit or not placementRaycastHit.Instance.Name:find("Can_Plant") then
					NotificationManager:CreateNotification("Can't place here!");
					return;
				else
					local plantCheckRaycastParams = RaycastParams.new();
					plantCheckRaycastParams.FilterType = Enum.RaycastFilterType.Include;
					plantCheckRaycastParams.FilterDescendantsInstances = {
						FarmUtils(LocalPlayer).Important.Plants_Physical:GetChildren()
					};
					if workspace:Raycast(placementRaycastHit.Position + Vector3.new(0, 20, 0, 0), Vector3.new(0, -25, 0, 0), plantCheckRaycastParams) then
						return;
					else
						HighlightInstance.Adornee = nil;
						task.spawn(function() --[[ Line: 197 ]]
							-- upvalues: placementRaycastHit (copy), originalPivotOfMovingObject (ref), currentMovingObject (ref), RunService (ref), TweenService (ref), TrowelRemoteEvent (ref), equippedTrowelTool (ref), NotificationManager (ref), DefaultEffectLibrary (ref), CurrentCamera (ref)
							local targetPivotCFrame = CFrame.new(placementRaycastHit.Position) * CFrame.new(0, 3, 0) * originalPivotOfMovingObject.Rotation;
							local finalPlacementCFrame = CFrame.new(placementRaycastHit.Position.X, originalPivotOfMovingObject.Y, placementRaycastHit.Position.Z) * originalPivotOfMovingObject.Rotation;
							local objectBeingPlaced = currentMovingObject;

							objectBeingPlaced:PivotTo(targetPivotCFrame);

							local elapsedTime = 0;
							while elapsedTime < 0.15 do
								elapsedTime = elapsedTime + RunService.Heartbeat:Wait();
								objectBeingPlaced:PivotTo(targetPivotCFrame:Lerp(finalPlacementCFrame, (TweenService:GetValue(elapsedTime / 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In))));
							end;

							TrowelRemoteEvent:InvokeServer("Place", equippedTrowelTool, objectBeingPlaced, finalPlacementCFrame);
							NotificationManager:CreateNotification((("Successfully moved %*!"):format(objectBeingPlaced.Name)));

							local placementEffect = DefaultEffectLibrary:CreateEffect({
								Object = script.Place,
								Emit = true,
								Position = placementRaycastHit.Position,
								DebrisTime = 1
							});
							DefaultEffectLibrary:SetScale(placementEffect, 3, {});
							DefaultEffectLibrary:PlaySound(script.PlantTrowel, CurrentCamera);
						end);

						local partsToRestoreCollision = collisionToggledParts or {};
						for _, part in partsToRestoreCollision do
							part.CanCollide = true;
							part.CanQuery = true;
						end;
						currentMovingObject = nil;
						return;
					end;
				end;
			else
				local pickupRaycastHit = performPickupRaycast(targetPosition);
				if not pickupRaycastHit then
					return;
				else
					local pickedUpObjectParent = pickupRaycastHit.Instance.Parent;
					if not isValidPlantForTrowel(pickedUpObjectParent) then
						NotificationManager:CreateNotification("Can't move this!");
						return;
					else
						TrowelRemoteEvent:InvokeServer("Pickup", equippedTrowelTool, pickedUpObjectParent);
						NotificationManager:CreateNotification((("Picked up %*!"):format(pickedUpObjectParent.Name)));
						originalPivotOfMovingObject = pickedUpObjectParent:GetPivot();

						for _, descendantPart in pickedUpObjectParent:GetDescendants() do
							if not descendantPart:IsA("BasePart") or not descendantPart.CanCollide then
								if descendantPart:IsA("BasePart") then
									descendantPart.CanQuery = false;
								end
							else
								descendantPart.CanCollide = false;
								descendantPart.CanQuery = false;
								table.insert(collisionToggledParts, descendantPart);
							end
						end;
						currentMovingObject = pickedUpObjectParent;
						return;
					end;
				end;
			end;
		end;
	end;
end;

if UserInputService.TouchEnabled then
	UserInputService.TouchTapInWorld:Connect(handleTrowelInput);
else
	LocalPlayer:GetMouse().Button1Down:Connect(handleTrowelInput);
end;