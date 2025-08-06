-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local goldReference = replicatedStorageService:WaitForChild("Gold_Reference");
local goldSoundEffect = replicatedStorageService.Assets.SFX:WaitForChild("Gold_SFX");
local rainbowReference = replicatedStorageService:WaitForChild("Rainbow_Reference");
local rainbowSoundEffect = replicatedStorageService.Assets.SFX:WaitForChild("Rainbow_SFX");
local variantVisualModule = {};
local _ = Color3.fromRGB(255, 225, 0);
local function insertEffects(targetPart, effectsFolder) --[[ Line: 17 ]] --[[ Name: InsertEffects ]]
	local particleEmitters = {};
	for _, child in (effectsFolder:GetChildren()) do
		child:Clone().Parent = targetPart;
		if child:IsA("Texture") then
			child.Transparency = 1;
		end;
		if child:IsA("ParticleEmitter") then
			table.insert(particleEmitters, child);
		end;
	end;
	return particleEmitters;
end;
local function gold(objectInstance) --[[ Line: 36 ]] --[[ Name: Gold ]]
	-- upvalues: l_Gold_Reference_0 (copy), v12 (copy), l_Gold_SFX_0 (copy)
	local function loopThroughObject(objectWithChildren) --[[ Line: 37 ]] --[[ Name: LoopThroughObject ]]
		-- upvalues: v14 (copy), l_Gold_Reference_0 (ref), v12 (ref)
		for _, childPart in objectWithChildren:GetChildren() do
			if childPart:IsA("Model") then
				loopThroughObject(childPart);
			end;
			if childPart:IsA("BasePart") or childPart:IsA("UnionOperation") then
				if childPart:IsA("UnionOperation") then
					childPart.UsePartColor = true;
				end;
				childPart.Color = goldReference.Color;
				childPart.Material = goldReference.Material;
				childPart.MaterialVariant = goldReference.MaterialVariant;
				if childPart.Transparency ~= 1 then
					insertEffects(childPart, goldReference);
				else
					local goldEffect = nil;
					do
						local transparencyChangedConnection = goldEffect;
						transparencyChangedConnection = childPart.Changed:Connect(function() --[[ Line: 59 ]]
							-- upvalues: v17 (copy), l_v18_0 (ref), v12 (ref), l_Gold_Reference_0 (ref)
							if childPart.Transparency ~= 0 then
								return;
							else
								transparencyChangedConnection:Disconnect();
								insertEffects(childPart, goldReference);
								return;
							end;
						end);
					end;
				end;
			end;
		end;
	end;
	loopThroughObject(objectInstance);
	local goldSound = goldSoundEffect:Clone();
	local attachmentPoint = objectInstance:FindFirstChild("Handle") or objectInstance:FindFirstChild("1") or objectInstance:FindFirstChild("Base");
	if not attachmentPoint then
		warn((("VariantVisuals:Gold | %* doesn't have a parent for SFX!"):format(objectInstance.Name)));
	end;
	goldSound.Parent = attachmentPoint or objectInstance;
	goldSound.Looped = true;
	goldSound.Playing = true;
	goldSound.Volume = 0.01;
	goldSound.PlaybackSpeed = 1 + math.random(-5, 5) / 100;
end;
local function rainbow(objectInstanceRainbow) --[[ Line: 87 ]] --[[ Name: Rainbow ]]
	-- upvalues: v12 (copy), l_Rainbow_Reference_0 (copy), l_Rainbow_SFX_0 (copy)
	local function loopThroughObjectRainbow(objectToRainbowify) --[[ Line: 88 ]] --[[ Name: LoopThroughObject ]]
		-- upvalues: v24 (copy), v12 (ref), l_Rainbow_Reference_0 (ref)
		for _, childPartRainbow in objectToRainbowify:GetChildren() do
			if childPartRainbow:IsA("Model") then
				loopThroughObjectRainbow(childPartRainbow);
			end;
			if not childPartRainbow:FindFirstChild("Rainbow Script") and childPartRainbow:IsA("BasePart") then
				if childPartRainbow:IsA("UnionOperation") then
					childPartRainbow.UsePartColor = true;
				end;
				childPartRainbow.Reflectance = 0.25;
				if childPartRainbow.Transparency ~= 1 then
					insertEffects(childPartRainbow, rainbowReference);
				else
					local rainbowEffect = nil;
					do
						local transparencyChangedConnectionRainbow = rainbowEffect;
						transparencyChangedConnectionRainbow = childPartRainbow.Changed:Connect(function() --[[ Line: 109 ]]
							-- upvalues: v27 (copy), l_v28_0 (ref), v12 (ref), l_Rainbow_Reference_0 (ref)
							if childPartRainbow.Transparency ~= 0 then
								return;
							else
								transparencyChangedConnectionRainbow:Disconnect();
								insertEffects(childPartRainbow, rainbowReference);
								return;
							end;
						end);
					end;
				end;
			end;
		end;
	end;
	loopThroughObjectRainbow(objectInstanceRainbow);
	local rainbowSound = rainbowSoundEffect:Clone();
	local handlePart = objectInstanceRainbow:FindFirstChild("Handle") or objectInstanceRainbow:FindFirstChild("1");
	if not handlePart then
		warn((("VariantVisuals:Rainbow | %* doesn't have a parent for SFX!"):format(objectInstanceRainbow.Name)));
	end;
	rainbowSound.Parent = handlePart or objectInstanceRainbow;
	rainbowSound.Looped = true;
	rainbowSound.Playing = true;
	rainbowSound.Volume = 0.01;
	rainbowSound.PlaybackSpeed = 1 + math.random(-5, 5) / 100;
end;
local function epicRainbow(objectInstanceEpicRainbow) --[[ Line: 136 ]] --[[ Name: EpicRainbow ]]
	-- upvalues: v12 (copy), l_Rainbow_Reference_0 (copy), l_Rainbow_SFX_0 (copy)
	local hue = 0;
	local basePartsList = {};
	for _, child in (objectInstanceEpicRainbow:GetChildren()) do
		if child:IsA("Model") then
			for _, childPart in child:GetChildren() do
				if childPart:IsA("BasePart") then
					table.insert(basePartsList, childPart);
				end;
			end;
		end;
		if child:IsA("BasePart") then
			table.insert(basePartsList, child);
		end;
	end;
	while #basePartsList >= 1 do
		task.wait();
		local highestPart = nil;
		local highestYPosition = -1e999;
		for _, part in basePartsList do
			if highestYPosition < part.Position.Y then
				highestYPosition = part.Position.Y;
				highestPart = part;
			end;
		end;
		do
			local highestYPart = highestPart;
			if highestYPart then
				local partIndex = table.find(basePartsList, highestYPart);
				if partIndex then
					hue = highestYPart.Position.Y * 0.025 % 1;
					local _ = highestYPart.Color:ToHSV();
					highestYPart.Reflectance = 0.2;
					highestYPart.Color = Color3.fromHSV(hue % 1, 1, 1);
					if highestYPart.Transparency ~= 1 then
						for _, particleEmitter in (insertEffects(highestYPart, rainbowReference)) do
							particleEmitter.Rate = particleEmitter.Rate * 2;
						end;
					else
						local epicRainbowEffect = nil;
						do
							local transparencyChangedConnectionEpicRainbow = epicRainbowEffect;
							transparencyChangedConnectionEpicRainbow = highestYPart.Changed:Connect(function() --[[ Line: 180 ]]
								-- upvalues: l_v40_0 (ref), l_v49_0 (ref), v12 (ref), l_Rainbow_Reference_0 (ref)
								if highestYPart.Transparency ~= 0 then
									return;
								else
									transparencyChangedConnectionEpicRainbow:Disconnect();
									for _, particleEmitter in (insertEffects(highestYPart, rainbowReference)) do
										particleEmitter.Rate = particleEmitter.Rate * 2;
									end;
									return;
								end;
							end);
						end;
					end;
					table.remove(basePartsList, partIndex);
				end;
			else
				basePartsList = {};
			end;
		end;
	end;
	local rainbowSoundEpic = rainbowSoundEffect:Clone();
	local handlePartGold = objectInstanceEpicRainbow:FindFirstChild("Handle") or objectInstanceEpicRainbow:FindFirstChild("1");
	if not handlePartGold then
		warn((("VariantVisuals:Gold | %* doesn't have a parent for SFX!"):format(objectInstanceEpicRainbow.Name)));
	end;
	rainbowSoundEpic.Parent = handlePartGold or objectInstanceEpicRainbow;
	rainbowSoundEpic.Looped = true;
	rainbowSoundEpic.Playing = true;
	rainbowSoundEpic.Volume = 0.01;
	rainbowSoundEpic.PlaybackSpeed = 1 + math.random(-5, 5) / 100;
end;
local variantVisualFunctions = {
	Gold = function(goldPart, _) --[[ Line: 217 ]]
		-- upvalues: v22 (copy)
		return gold(goldPart);
	end, 
	Rainbow = function(rainbowPart, epicRainbowData) --[[ Line: 220 ]]
		-- upvalues: v55 (copy), v32 (copy)
		return epicRainbowData and epicRainbowData.DoEpicRainbow and epicRainbow(rainbowPart) or rainbow(rainbowPart);
	end
};
variantVisualModule.SetVisuals = function(_, plantInstance, variantData) --[[ Line: 228 ]] --[[ Name: SetVisuals ]]
	-- upvalues: v60 (copy)
	if not plantInstance then
		warn("VariantVisuals:SetVisuals | plant is nil!");
		return;
	else
		task.spawn(function()
			math.randomseed(plantInstance:WaitForChild("Item_Seed").Value);
			local variantObject = plantInstance:FindFirstChild("Variant");
			local variantName = variantObject and variantObject.Value or "";
			local variantVisualFunction = variantVisualFunctions[variantName];
			if variantVisualFunction and not plantInstance:GetAttribute("SetVariant") and variantName ~= "" and variantName ~= "Normal" then
				plantInstance:SetAttribute("SetVariant", true);
				repeat
					task.wait(0.5);
				until plantInstance:HasTag("PlantGenerated");
				variantVisualFunction(plantInstance, variantData);
			end;
		end)
		return;
	end;
end;
variantVisualModule.functions = variantVisualFunctions
return variantVisualModule;