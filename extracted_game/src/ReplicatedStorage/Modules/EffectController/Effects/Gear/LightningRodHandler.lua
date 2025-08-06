-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local collectionService = game:GetService("CollectionService");
local _ = require(replicatedStorageService.Modules.EffectController.Types);
return {
	Create = function(lightningRodModule) --[[ Line: 11 ]] --[[ Name: Create ]]
		-- upvalues: l_ReplicatedStorage_0 (copy), l_CollectionService_0 (copy)
		local lightningRodId = lightningRodModule.Parameters.ID;
		local _ = lightningRodModule.Parameters.Redirects;
		lightningRodModule.Cache[lightningRodId] = {};
		local lightningRodType = lightningRodModule.Parameters.LightningRodType;
		local lightningRodCFrame = lightningRodModule.Parameters.LightningRodCFrame;
		local lightningRodModel = replicatedStorageService.ObjectModels:FindFirstChild(lightningRodType);
		if not lightningRodModel then
			return;
		else
			local lightningRodInstance = lightningRodModel:Clone();
			if not lightningRodModel then
				return;
			else
				collectionService:AddTag(lightningRodInstance, "LightningRod");
				lightningRodInstance:SetAttribute("ROD_ID", lightningRodId);
				for _, descendant in lightningRodInstance:GetDescendants() do
					if descendant:IsA("BasePart") then
						descendant.CanQuery = true;
						descendant.CanCollide = true;
					end;
				end;
				lightningRodModule.Cache[lightningRodId].Rod = lightningRodInstance;
				local _, boundingBoxSize = lightningRodInstance:GetBoundingBox();
				local lightningRodYOffset = boundingBoxSize.Y / 2 - 1;
				lightningRodInstance.PrimaryPart.CFrame = lightningRodCFrame * CFrame.new(0, lightningRodYOffset, 0);
				lightningRodInstance.Parent = workspace.Visuals;
				local placeEffect = lightningRodModule.Default:CreateEffect({
					Object = script.PlaceEffect, 
					Emit = true, 
					Position = lightningRodCFrame, 
					DebrisTime = 2
				});
				lightningRodModule.Default:PlaySound(script.PlaceSFX, placeEffect);
				lightningRodModule.Libraries.BoatTween:Create(lightningRodInstance.PrimaryPart, {
					Time = 0.8, 
					EasingStyle = "Smoother", 
					EasingDirection = "In", 
					StepType = "Heartbeat", 
					Goal = {
						CFrame = lightningRodCFrame * CFrame.new(0, lightningRodYOffset, 0)
					}
				}):Play();
				lightningRodModule.Cache[lightningRodId].Rod = lightningRodInstance;
				return;
			end;
		end;
	end, 
	Destroy = function(lightningRodRemovalModule) --[[ Line: 68 ]] --[[ Name: Destroy ]]
		-- upvalues: l_CollectionService_0 (copy)
		local lightningRodIdToRemove = lightningRodRemovalModule.Parameters.ID;
		local existingLightningRod = lightningRodRemovalModule.Cache[lightningRodIdToRemove] and lightningRodRemovalModule.Cache[lightningRodIdToRemove].Rod;
		if not existingLightningRod then
			return;
		else
			collectionService:RemoveTag(existingLightningRod, "LightningRod");
			lightningRodRemovalModule.Libraries.BoatTween:Create(existingLightningRod.PrimaryPart, {
				Time = 0.6, 
				EasingStyle = "ExitExpressive", 
				EasingDirection = "In", 
				StepType = "Heartbeat", 
				Goal = {
					CFrame = lightningRodRemovalModule.Parameters.LightningRodCFrame * CFrame.new(0, 3, 0)
				}
			}):Play();
			lightningRodRemovalModule.Default:PlaySound(script.DestroySFX, existingLightningRod.PrimaryPart);
			task.delay(1.5, function() --[[ Line: 86 ]]
				-- upvalues: v18 (copy)
				existingLightningRod:Destroy();
			end);
			return;
		end;
	end, 
	Cancel = function(lightningRodContainer) --[[ Line: 92 ]] --[[ Name: Cancel ]]
		lightningRodContainer.Container:Clean();
		lightningRodContainer.Cache = {};
	end
};