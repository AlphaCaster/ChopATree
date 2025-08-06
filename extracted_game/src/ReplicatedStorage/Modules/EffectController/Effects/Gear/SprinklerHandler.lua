-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local collectionService = game:GetService("CollectionService");
local playersService = game:GetService("Players");
local getFarmModule = require(replicatedStorageService.Modules.GetFarm);
local _ = require(replicatedStorageService.Modules.EffectController.Types);
local sprinklerOffsetMap = {
	["Basic Sprinkler"] = CFrame.new(0, -0.85, 0), 
	["Advanced Sprinkler"] = CFrame.new(0, -0.65, 0), 
	["Godly Sprinkler"] = CFrame.new(0, -0.85, 0), 
	["Master Sprinkler"] = CFrame.new(0, -0.85, 0), 
	["Chocolate Sprinkler"] = CFrame.new(0, -0.85, 0)
};
local sprinklerYieldMap = {
	["Basic Sprinkler"] = 0.6, 
	["Advanced Sprinkler"] = 0.2, 
	["Godly Sprinkler"] = 0.1, 
	["Master Sprinkler"] = 0.05, 
	["Chocolate Sprinkler"] = 0.25
};
local sprinklerRotationMap = {
	["Basic Sprinkler"] = 30, 
	["Advanced Sprinkler"] = 20, 
	["Godly Sprinkler"] = 75, 
	["Master Sprinkler"] = 144, 
	["Chocolate Sprinkler"] = 25
};
return {
	Create = function(sprinklerData) --[[ Line: 47 ]] --[[ Name: Create ]]
		-- upvalues: l_ReplicatedStorage_0 (copy), l_CollectionService_0 (copy), l_Players_0 (copy), v3 (copy), v5 (copy), v7 (copy), v6 (copy)
		local sprinklerId = sprinklerData.Parameters.ID;
		sprinklerData.Cache[sprinklerId] = {};
		local sprinklerCFrame = sprinklerData.Parameters.SprinklerCFrame;
		local sprinklerType = sprinklerData.Parameters.SprinklerType;
		local sprinklerModel = replicatedStorageService.ObjectModels:FindFirstChild(sprinklerData.Parameters.SprinklerType):Clone();
		sprinklerModel:SetAttribute("SPRINKLER_ID", sprinklerId);
		collectionService:AddTag(sprinklerModel, "Sprinkler");
		local ownerPlayer = playersService:FindFirstChild(sprinklerData.Parameters.OWNER);
		if not ownerPlayer then
			return;
		else
			local farmData = getFarmModule(ownerPlayer);
			if not farmData then
				return;
			else
				local importantFolder = farmData:FindFirstChild("Important");
				if not importantFolder then
					return;
				else
					local physicalObjectsFolder = importantFolder:FindFirstChild("Objects_Physical");
					if not physicalObjectsFolder then
						return;
					else
						local objectUUID = sprinklerData.Parameters.OBJECT_UUID;
						for _, physicalObject in physicalObjectsFolder:GetChildren() do
							--print(physicalObject:GetAttribute("OBJECT_UUID"), objectUUID);
							if physicalObject:GetAttribute("OBJECT_UUID") == objectUUID then
								physicalObject:GetAttributeChangedSignal("Lifetime"):Connect(function() --[[ Line: 73 ]]
									-- upvalues: v12 (copy), v19 (copy)
									sprinklerModel:SetAttribute("EndTime", physicalObject:GetAttribute("Lifetime"));
								end);
								physicalObject.Destroying:Connect(function() --[[ Line: 77 ]]
									-- upvalues: v12 (copy)
									sprinklerModel:Destroy();
								end);
								break;
							end;
						end;
						local debugPart = Instance.new("Part");
						debugPart.Size = Vector3.new(2.5, 3, 2.5, 0);
						debugPart.CFrame = sprinklerCFrame;
						debugPart.Anchored = true;
						debugPart.Transparency = 1;
						debugPart.Parent = sprinklerModel;
						debugPart.CanCollide = false;
						(function(model) --[[ Line: 94 ]] --[[ Name: setCanQueryRecursive ]]
							for _, descendant in (model:GetDescendants()) do
								if descendant:IsA("BasePart") then
									descendant.CanQuery = true;
								end;
							end;
						end)(sprinklerModel);
						sprinklerModel:SetAttribute("EndTime", sprinklerData.Parameters.EndTime);
						sprinklerModel.PrimaryPart.CFrame = sprinklerCFrame * CFrame.new(0, 1, 0);
						sprinklerModel.Parent = workspace.Visuals;
						local placeEffect = sprinklerData.Default:CreateEffect({
							Object = script.PlaceEffect, 
							Emit = true, 
							Position = sprinklerCFrame * CFrame.Angles(0, 180, 180), 
							DebrisTime = 2
						});
						sprinklerData.Default:PlaySound(script.PlaceSFX, placeEffect);
						sprinklerData.Libraries.BoatTween:Create(sprinklerModel.PrimaryPart, {
							Time = 0.8, 
							EasingStyle = "Smoother", 
							EasingDirection = "In", 
							StepType = "Heartbeat", 
							Goal = {
								CFrame = sprinklerCFrame * sprinklerOffsetMap[sprinklerType]
							}
						}):Play();
						task.spawn(function() --[[ Line: 132 ]]
							-- upvalues: v8 (copy), l_ID_0 (copy), l_SprinklerType_0 (copy), v12 (copy), l_SprinklerCFrame_0 (copy), v7 (ref), v6 (ref)
							sprinklerData.Cache[sprinklerId].SprinklerEffect = sprinklerData.Default:CreateEffect({
								Object = script[("%* VFX"):format(sprinklerType)], 
								Parent = sprinklerModel, 
								Position = sprinklerCFrame
							});
							sprinklerData.Default:PlaySound(script.SprinklerLoop, sprinklerData.Cache[sprinklerId].SprinklerEffect);
							local sprinklerRoot = sprinklerModel:WaitForChild("Top"):WaitForChild("Root");
							while sprinklerModel do
								sprinklerRoot.CFrame = sprinklerRoot.CFrame * CFrame.Angles(0, math.rad(sprinklerRotationMap[sprinklerType]), 0);
								local sprinklerSpawnChance = sprinklerYieldMap[sprinklerType] * 100;
								task.wait(math.random(math.floor(sprinklerSpawnChance / 3), sprinklerSpawnChance) / 100);
							end;
						end);
						sprinklerData.Cache[sprinklerId].Sprinkler = sprinklerModel;
						return;
					end;
				end;
			end;
		end;
	end, 
	Destroy = function(sprinklerController) --[[ Line: 157 ]] --[[ Name: Destroy ]]
		local sprinklerId = sprinklerController.Parameters.ID;
		local sprinklerInstance = sprinklerController.Cache[sprinklerId].Sprinkler;
		local sprinklerEffect = sprinklerController.Cache[sprinklerId].SprinklerEffect;
		sprinklerController.Default:UpdateStatus(sprinklerEffect, false, {});
		sprinklerController.Libraries.BoatTween:Create(sprinklerInstance.PrimaryPart, {
			Time = 0.6, 
			EasingStyle = "ExitExpressive", 
			EasingDirection = "In", 
			StepType = "Heartbeat", 
			Goal = {
				CFrame = sprinklerController.Parameters.SprinklerCFrame * CFrame.new(0, 3, 0)
			}
		}):Play();
		task.delay(0.6, sprinklerInstance.Destroy, sprinklerInstance);
	end, 
	Cancel = function(unknownObject) --[[ Line: 179 ]] --[[ Name: Cancel ]]
		unknownObject.Container:Clean();
		unknownObject.Cache = {};
	end
};