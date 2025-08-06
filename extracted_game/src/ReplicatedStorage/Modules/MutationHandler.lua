-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local collectionService = game:GetService("CollectionService");
local runService = game:GetService("RunService");
local playersService = game:GetService("Players");
local tableUtils = require(game.ReplicatedStorage.Modules.TableUtils);
local mutationHandler = {};
local transparencyConnections = {};
local _ = function() --[[ Line: 26 ]] --[[ Name: IsJexInStudio ]]
	-- upvalues: l_RunService_0 (copy), l_Players_0 (copy)
	if not runService:IsStudio() then
		return false;
	else
		for _, player in playersService:GetPlayers() do
			if player.Name == "JexSavron" then
				return true;
			end;
		end;
		return false;
	end;
end;
local function GetBoundingBox(model: Model)
	local cfSum = Vector3.zero
	local totalParts = 0

	-- Get all BaseParts
	local parts = {}
	for _, part in ipairs(model:GetDescendants()) do
		if part:IsA("BasePart") then
			table.insert(parts, part)
			cfSum += part.Position
			totalParts += 1
		end
	end

	if totalParts == 0 then
		return nil, nil -- no parts, invalid bounding box
	end

	local center = cfSum / totalParts
	local minBound = Vector3.new(math.huge, math.huge, math.huge)
	local maxBound = Vector3.new(-math.huge, -math.huge, -math.huge)

	for _, part in ipairs(parts) do
		local corners = {}

		-- Get 8 corners of the part in world space
		local size = part.Size * 0.5
		local cf = part.CFrame
		for x = -1, 1, 2 do
			for y = -1, 1, 2 do
				for z = -1, 1, 2 do
					local corner = cf.Position + (cf.RightVector * size.X * x) + (cf.UpVector * size.Y * y) + (cf.LookVector * size.Z * z)
					table.insert(corners, corner)

					minBound = Vector3.new(
						math.min(minBound.X, corner.X),
						math.min(minBound.Y, corner.Y),
						math.min(minBound.Z, corner.Z)
					)

					maxBound = Vector3.new(
						math.max(maxBound.X, corner.X),
						math.max(maxBound.Y, corner.Y),
						math.max(maxBound.Z, corner.Z)
					)
				end
			end
		end
	end

	local boundingCFrame = CFrame.new((minBound + maxBound) / 2)
	local boundingSize = maxBound - minBound

	return boundingCFrame, boundingSize
end

local function getFXPart(plant) --[[ Line: 39 ]] --[[ Name: GetFXPart ]]
	-- upvalues: l_RunService_0 (copy), l_Players_0 (copy)
	local isJexSavron = false;
	if not plant then
		warn("MutationHandler.GetFXPart | No plant given!");
		return nil;
	elseif not plant:IsDescendantOf(game) then
		return nil;
	else
		for _, fxPart in plant:GetDescendants() do
			if fxPart:IsA("BasePart") and fxPart:GetAttribute("FX_PART") then
				return fxPart;
			end;
		end;
		if plant:IsA("Tool") then
			local handlePart = plant:WaitForChild("Handle", 0.3);
			if handlePart then
				return handlePart;
			end;
		end;
		if plant.PrimaryPart then
			return plant.PrimaryPart;
		else
			local isStudioAndJexSavron;
			if not runService:IsStudio() then
				isStudioAndJexSavron = false;
			else
				for _, player in playersService:GetPlayers() do
					if player.Name == "JexSavron" then
						isStudioAndJexSavron = true;
						isJexSavron = true;
					end;
					if isJexSavron then
						break;
					end;
				end;
				if not isJexSavron then
					isStudioAndJexSavron = false;
				end;
			end;
			isJexSavron = false;
			if isStudioAndJexSavron then
				warn((("MutationHandler.GetFXPart | No valid FX part found for %* of type %*"):format(plant:GetFullName(), plant.ClassName)));
			end;
			return nil;
		end;
	end;
end;
local function handleCombos(characterModelAttributes) --[[ Line: 76 ]] --[[ Name: HandleCombos ]]
	if characterModelAttributes:GetAttribute("Frozen") or characterModelAttributes:GetAttribute("Wet") and characterModelAttributes:GetAttribute("Chilled") then
		characterModelAttributes:SetAttribute("Wet", false);
		characterModelAttributes:SetAttribute("Chilled", false);
		characterModelAttributes:SetAttribute("Frozen", true);
	end;
end;
local function updateFX(plantInstance) --[[ Line: 90 ]] --[[ Name: UpdateFX ]]
	-- upvalues: v4 (copy), v17 (copy)
	local removeFXFunctions = {};
	local addFXFunctions = {};
	for _, mutation in mutationHandler:GetMutations() do
		if not plantInstance:GetAttribute(mutation.Name) then
			removeFXFunctions[mutation] = mutation._RemoveFX;
		end;
		if plantInstance:GetAttribute(mutation.Name) then
			addFXFunctions[mutation] = mutation._AddFX;
		end;
	end;
	task.spawn(function() --[[ Line: 106 ]]
		-- upvalues: v17 (ref), v20 (copy), v21 (copy), v22 (copy)
		local result = getFXPart(plantInstance);
		for mutationName, removeFXFunction in removeFXFunctions do
			removeFXFunction(mutationName, plantInstance, result);
		end;
		for mutationNameToAdd, addFXFunction in addFXFunctions do
			addFXFunction(mutationNameToAdd, plantInstance, result);
		end;
	end);
end;
local mutations = {
	Shocked = {
		Name = "Shocked", 
		ValueMulti = 100, 
		_AddFX = function(_RemoveFX, effectPart, characterModel) --[[ Line: 123 ]] --[[ Name: _AddFX ]]
			_RemoveFX:_RemoveFX(effectPart);
			if characterModel then
				for _, fxInstance in game.ReplicatedStorage.Mutation_FX.Shocked:GetChildren() do
					local clonedFx = fxInstance:Clone();
					clonedFx.Parent = characterModel;
					clonedFx:AddTag("Cleanup_Shock");
				end;
			end;
			for _, childPart in effectPart:GetChildren() do
				if childPart:IsA("BasePart") or childPart:IsA("UnionOperation") then
					childPart.Material = Enum.Material.Neon;
				end;
			end;
		end, 
		_RemoveFX = function(_, model, characterModelShocked) --[[ Line: 143 ]] --[[ Name: _RemoveFX ]]
			if characterModelShocked then
				for _, shockPart in characterModelShocked:GetChildren() do
					if shockPart:HasTag("Cleanup_Shock") then
						shockPart:Destroy();
					end;
				end;
			end;
			for _, part in model:GetChildren() do
				if part:IsA("BasePart") or part:IsA("UnionOperation") then
					part.Material = Enum.Material.Plastic;
				end;
			end;
		end
	}, 
	Wet = {
		Name = "Wet", 
		ValueMulti = 2, 
		_AddFX = function(effectHandler, effectPart, characterModelWet) --[[ Line: 165 ]] --[[ Name: _AddFX ]]
			effectHandler:_RemoveFX(effectPart);
			if characterModelWet then
				for _, wetFxInstance in game.ReplicatedStorage.Mutation_FX.Wet:GetChildren() do
					local clonedWetFx = wetFxInstance:Clone();
					clonedWetFx.Parent = characterModelWet;
					clonedWetFx.Enabled = true;
					clonedWetFx:AddTag("Cleanup_Wet");
				end;
			end;
		end, 
		_RemoveFX = function(_, _, waterArea) --[[ Line: 179 ]] --[[ Name: _RemoveFX ]]
			if waterArea then
				for _, wetPart in waterArea:GetChildren() do
					if wetPart:HasTag("Cleanup_Wet") then
						wetPart:Destroy();
					end;
				end;
			end;
		end
	}, 
	Chilled = {
		Name = "Chilled", 
		ValueMulti = 2, 
		_AddFX = function(effectHandler, characterModelReflectance, characterModelChilled) --[[ Line: 194 ]] --[[ Name: _AddFX ]]
			effectHandler:_RemoveFX(characterModelReflectance);
			if characterModelChilled then
				for _, chilledFxInstance in game.ReplicatedStorage.Mutation_FX.Chilled:GetChildren() do
					local clonedChilledFx = chilledFxInstance:Clone();
					clonedChilledFx.Parent = characterModelChilled;
					clonedChilledFx.Enabled = true;
					clonedChilledFx:AddTag("Cleanup_Chilled");
				end;
			end;
			for _, part in characterModelReflectance:GetChildren() do
				if part:IsA("BasePart") or part:IsA("UnionOperation") then
					part.Reflectance = 0.1;
				end;
			end;
		end, 
		_RemoveFX = function(_, model, iceArea) --[[ Line: 214 ]] --[[ Name: _RemoveFX ]]
			if iceArea then
				for _, chilledPart in iceArea:GetChildren() do
					if chilledPart:HasTag("Cleanup_Chilled") then
						chilledPart:Destroy();
					end;
				end;
			end;
			for _, part in model:GetChildren() do
				if part:IsA("BasePart") or part:IsA("UnionOperation") then
					part.Reflectance = 0;
				end;
			end;
		end
	}, 
	Frozen = {
		Name = "Frozen", 
		ValueMulti = 10, 
		_AddFX = function(effectHandler, instance, characterModel) --[[ Line: 236 ]] --[[ Name: _AddFX ]]
			effectHandler:_RemoveFX(instance);
			local instanceBoundingBox, boundingBoxSize = instance:GetBoundingBox();
			boundingBoxSize = boundingBoxSize + Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612, 0);
			local frozenShellPart = Instance.new("Part");
			frozenShellPart.Name = "FrozenShell";
			frozenShellPart.Size = boundingBoxSize;
			frozenShellPart.CFrame = instanceBoundingBox;
			frozenShellPart.Anchored = false;
			frozenShellPart.CanCollide = false;
			frozenShellPart.CanQuery = false;
			frozenShellPart.Massless = true;
			frozenShellPart.Transparency = 0.5;
			frozenShellPart.Color = Color3.fromRGB(108, 184, 255);
			frozenShellPart.Material = Enum.Material.Ice;
			frozenShellPart:AddTag("Cleanup_Frozen");
			frozenShellPart:AddTag("Effect");
			for _, frozenEffect in game.ReplicatedStorage.Mutation_FX.Frozen:GetChildren() do
				local clonedFrozenFx = frozenEffect:Clone();
				clonedFrozenFx.Parent = characterModel;
				clonedFrozenFx.Enabled = true;
				clonedFrozenFx:AddTag("Cleanup_Frozen");
			end;
			local primaryOrHandlePart = instance.PrimaryPart or instance:FindFirstChild("Handle") or instance:FindFirstChildOfClass("BasePart");
			if primaryOrHandlePart then
				local weldConstraint = Instance.new("WeldConstraint");
				weldConstraint.Part0 = frozenShellPart;
				weldConstraint.Part1 = primaryOrHandlePart;
				weldConstraint.Parent = frozenShellPart;
				frozenShellPart.Parent = primaryOrHandlePart;
			else
				frozenShellPart:Destroy();
			end;
			for _, descendant in instance:GetDescendants() do
				if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
					descendant.Reflectance = 0.3;
				end;
			end;
		end, 
		_RemoveFX = function(_, characterModelReflectanceReset, debuffInstance) --[[ Line: 286 ]] --[[ Name: _RemoveFX ]]
			local function cleanupFrozenEffects(characterModelFrozen) --[[ Line: 288 ]] --[[ Name: cleanup ]]
				for _, descendant in characterModelFrozen:GetDescendants() do
					if descendant:HasTag("Cleanup_Frozen") then
						descendant:Destroy();
					end;
				end;
			end;
			if debuffInstance then
				cleanupFrozenEffects(debuffInstance);
			end;
			if characterModelReflectanceReset then
				cleanupFrozenEffects(characterModelReflectanceReset);
			end;
			for _, descendant in characterModelReflectanceReset:GetDescendants() do
				if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
					descendant.Reflectance = 0;
				end;
			end;
		end
	}, 
	Choc = {
		Name = "Choc", 
		ValueMulti = 2, 
		_AddFX = function(effectHandler, _RemoveFX, _) --[[ Line: 312 ]] --[[ Name: _AddFX ]]
			-- upvalues: v5 (copy)
			effectHandler:_RemoveFX(_RemoveFX);
			local function loopThroughObject(characterModelChoc) --[[ Line: 319 ]] --[[ Name: LoopThroughObject ]]
				-- upvalues: v5 (ref), v97 (copy)
				for _, child in characterModelChoc:GetChildren() do
					if child:IsA("BasePart") or child:IsA("UnionOperation") then
						local chocTextures = {};
						for _, chocTexture in game.ReplicatedStorage.Mutation_Textures.Choc:GetChildren() do
							local chocolateClone = chocTexture:Clone();
							chocolateClone.Parent = child;
							chocolateClone.Transparency = child.Transparency;
							table.insert(chocTextures, chocolateClone);
							chocolateClone:AddTag("Cleanup_Choc");
						end;
						transparencyConnections[child] = child.Changed:Connect(function() --[[ Line: 332 ]]
							-- upvalues: v100 (copy), v5 (ref), v101 (copy)
							if child.Transparency ~= 0 then
								return;
							else
								transparencyConnections[child]:Disconnect();
								for _, texture in chocTextures do
									texture.Transparency = 0;
								end;
								return;
							end;
						end);
					elseif child:IsA("Model") then
						loopThroughObject(child);
					end;
				end;
			end;
			loopThroughObject(_RemoveFX);
		end, 
		_RemoveFX = function(_, characterModel, _) --[[ Line: 350 ]] --[[ Name: _RemoveFX ]]
			-- upvalues: v5 (copy)
			for _, descendantChoc in characterModel:GetDescendants() do
				if descendantChoc:HasTag("Cleanup_Choc") then
					descendantChoc:Destroy();
				end;
				if transparencyConnections[descendantChoc] then
					transparencyConnections[descendantChoc]:Disconnect();
				end;
			end;
		end
	}
};
mutationHandler.GetMutations = function(_) --[[ Line: 366 ]] --[[ Name: GetMutations ]]
	-- upvalues: v3 (copy), v112 (copy)
	return tableUtils:DeepCopy(mutations);
end;
mutationHandler.AddMutation = function(_, plant, attribute) --[[ Line: 372 ]] --[[ Name: AddMutation ]]
	if not plant then
		warn("MutationHandler:AddMutation | No plant");
		return;
	else
		plant:SetAttribute(attribute.Name, true);
		return;
	end;
end;
mutationHandler.RemoveMutation = function(_, plantRemove, attribute) --[[ Line: 383 ]] --[[ Name: RemoveMutation ]]
	if not plantRemove then
		warn("MutationHandler:RemoveMutation | No plant");
		return;
	else
		plantRemove:SetAttribute(attribute.Name, false);
		return;
	end;
end;
mutationHandler.GetPlantMutations = function(_, attributeSourceInstance) --[[ Line: 394 ]] --[[ Name: GetPlantMutations ]]
	-- upvalues: v4 (copy)
	local mutationList = {};
	for _, mutation in mutationHandler:GetMutations() do
		if attributeSourceInstance:GetAttribute(mutation.Name) then
			table.insert(mutationList, mutation);
		end;
	end;
	return mutationList;
end;
mutationHandler.GetMutationsAsString = function(_, attributeSourceInstance, isUsingBracket) --[[ Line: 406 ]] --[[ Name: GetMutationsAsString ]]
	-- upvalues: v4 (copy)
	isUsingBracket = isUsingBracket or false;
	local mutationString = "";
	for _, mutation in mutationHandler:GetMutations() do
		if attributeSourceInstance:GetAttribute(mutation.Name) then
			if mutationString ~= "" then
				mutationString = mutationString .. ", ";
			end;
			mutationString = mutationString .. mutation.Name;
		end;
	end;
	if mutationString ~= "" and isUsingBracket then
		mutationString = "[" .. mutationString .. "]";
	end;
	return mutationString;
end;
mutationHandler.ExtractMutationsFromString = function(_, mutationStringInput) --[[ Line: 426 ]] --[[ Name: ExtractMutationsFromString ]]
	-- upvalues: v4 (copy)
	local mutationList = {};
	if not mutationStringInput or mutationStringInput == "" then
		return mutationList;
	else
		mutationStringInput = mutationStringInput:gsub("%[", ""):gsub("%]", ""):gsub("%s+", "");
		for mutationName in string.gmatch(mutationStringInput, "([^,]+)") do
			local mutationExists = false;
			for _, mutation in mutationHandler:GetMutations() do
				if mutation.Name == mutationName then
					table.insert(mutationList, mutation);
					mutationExists = true;
				end;
			end;
			if not mutationExists then
				warn((("MutationHandler:ExtractMutationsFromString | Mutation name: %* does not exist"):format(mutationName)));
			end;
		end;
		return mutationList;
	end;
end;
mutationHandler.TransferMutations = function(_, sourceInstance, targetInstance) --[[ Line: 457 ]] --[[ Name: TransferMutations ]]
	-- upvalues: v4 (copy)
	for _, mutation in mutationHandler:GetMutations() do
		if sourceInstance:GetAttribute(mutation.Name) then
			mutationHandler:AddMutation(targetInstance, mutation);
			mutationHandler:RemoveMutation(sourceInstance, mutation);
		end;
	end;
	targetInstance:SetAttribute("WeightMulti", sourceInstance:GetAttribute("WeightMulti") or 1);
end;
mutationHandler.CalcValueMulti = function(_, attributeSourceInstance) --[[ Line: 469 ]] --[[ Name: CalcValueMulti ]]
	-- upvalues: v4 (copy)
	local weightMultiplier = 1;
	for _, mutation in mutationHandler:GetMutations() do
		if attributeSourceInstance:GetAttribute(mutation.Name) then
			weightMultiplier = weightMultiplier + (mutation.ValueMulti - 1);
		end;
	end;
	return (math.max(1, weightMultiplier));
end;
mutationHandler.SetToolName = function(_, tool) --[[ Line: 486 ]] --[[ Name: SetToolName ]]
	-- upvalues: v4 (copy)
	if not tool:IsA("Tool") then
		return;
	else
		task.spawn(function() --[[ Line: 489 ]]
			-- upvalues: v149 (copy), v4 (ref)
			local variantObject = tool:WaitForChild("Variant", 0.3);
			if not variantObject then
				return;
			else
				local itemStringObject = tool:WaitForChild("Item_String", 0.3);
				if not itemStringObject then
					return;
				else
					local weightObject = tool:WaitForChild("Weight", 0.3);
					if not weightObject then
						return;
					else
						local mutationsAsString = mutationHandler:GetMutationsAsString(tool);
						local mutationValue = variantObject.Value;
						local formattedMutationsString = mutationsAsString;
						if mutationValue and mutationValue ~= "" and mutationValue ~= "Normal" then
							formattedMutationsString = if formattedMutationsString == "" then mutationValue else formattedMutationsString .. ", " .. mutationValue;
						end;
						tool.Name = (formattedMutationsString ~= "" and ("[%*] "):format(formattedMutationsString) or "") .. itemStringObject.Value .. " [" .. string.format("%.2f", weightObject.Value) .. "kg]";
						return;
					end;
				end;
			end;
		end);
		return;
	end;
end;
local mutationCache = {};
collectionService:GetInstanceAddedSignal("Mutatable"):Connect(function(mutatablePlant) --[[ Line: 520 ]] --[[ Name: MutatableAdded ]]
	-- upvalues: v30 (copy), v4 (copy), v156 (copy), v19 (copy)
	if not mutatablePlant then
		warn("MutationHandler.MutatableAdded | No plant");
		return;
	else
		updateFX(mutatablePlant);
		mutationHandler:SetToolName(mutatablePlant);
		for _, mutation in mutationHandler:GetMutations() do
			mutatablePlant:GetAttributeChangedSignal(mutation.Name):Connect(function() --[[ Line: 533 ]]
				-- upvalues: v156 (ref), v157 (copy), v19 (ref), v30 (ref), v4 (ref)
				if mutationCache[mutatablePlant] then
					return;
				else
					mutationCache[mutatablePlant] = true;
					task.defer(function() --[[ Line: 538 ]]
						-- upvalues: v19 (ref), v157 (ref), v30 (ref), v4 (ref), v156 (ref)
						handleCombos(mutatablePlant);
						updateFX(mutatablePlant);
						mutationHandler:SetToolName(mutatablePlant);
						mutationCache[mutatablePlant] = nil;
					end);
					return;
				end;
			end);
		end;
		return;
	end;
end);
collectionService:GetInstanceAddedSignal("PlantScaled"):Connect(function(mutatableInstance) --[[ Line: 550 ]]
	-- upvalues: l_CollectionService_0 (copy), v30 (copy), v4 (copy)
	if not collectionService:HasTag(mutatableInstance, "Mutatable") then
		return;
	elseif not mutatableInstance:IsA("Model") and not mutatableInstance:IsA("Tool") then
		return;
	else
		updateFX(mutatableInstance);
		mutationHandler:SetToolName(mutatableInstance);
		return;
	end;
end);
return mutationHandler;