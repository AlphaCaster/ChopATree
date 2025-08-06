local ThunderstormEffectModule = {};

local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local debris = game:GetService("Debris")
local lighting = game:GetService("Lighting")
local workspace = game:GetService("Workspace")

local rainParticleTemplate = replicatedStorage.RainParticle;
local randomGenerator = Random.new();
local currentCamera = workspace.CurrentCamera;

local particleRaycastParams = RaycastParams.new();
particleRaycastParams.FilterDescendantsInstances = {
	workspace.Terrain,
	workspace
};
particleRaycastParams.FilterType = Enum.RaycastFilterType.Include;

local activeParticles = {};
local isThunderstormActive = false;

local function createParticle(spawnPosition)
	local particleData = {
		particle = rainParticleTemplate:Clone(),
		position = spawnPosition,
		spawnTime = os.clock(),
		visible = false,
		lastUpdateTime = 0
	};
	tweenService:Create(particleData.particle, TweenInfo.new(0.7), {
		Transparency = 0.2
	}):Play();
	table.insert(activeParticles, particleData);
end;

local _updateParticlePlace_Unused = function(particleData, currentTime, scaledDeltaTime)
	local _elapsedTimeSinceSpawn = currentTime - particleData.spawnTime + scaledDeltaTime;
	local currentPosition = particleData.position;
	local movementVector = Vector3.new(0, -20 * scaledDeltaTime, 0);
	local raycastResult = workspace:Spherecast(currentPosition, 0.15, movementVector, particleRaycastParams);
	if raycastResult then
		return raycastResult.Position, true;
	else
		particleData.position = currentPosition + movementVector;
		return currentPosition; -- Original returned l_position_0 which is currentPosition
	end;
end;

local thunderstormSky = script.Sky;
local originalCartoonEffect = lighting.Cartoon;

local function startThunderstormEvent()
	isThunderstormActive = true;
	originalCartoonEffect.Parent = replicatedStorage;
	thunderstormSky.Parent = lighting;

	tweenService:Create(lighting, TweenInfo.new(3), {
		Ambient = Color3.fromRGB(170, 237, 255),
		ExposureCompensation = 0.45,
		Brightness = 0.5
	}):Play();

	tweenService:Create(lighting.ColorCorrection, TweenInfo.new(3), {
		Brightness = 0.1,
		TintColor = Color3.fromRGB(221, 248, 255)
	}):Play();

	workspace.Terrain.Clouds.Enabled = true;
	tweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(3), {
		Cover = 0.925,
		Density = 0.183
	}):Play();

	task.spawn(function()
		while isThunderstormActive do
			task.wait(0);
			if #activeParticles <= 77 then
				for _ = 1, 3 do
					local spawnDistance = randomGenerator:NextNumber(10, 180);
					local frustumHeight = 2 * spawnDistance * math.tan(math.rad(currentCamera.FieldOfView / 2));
					local frustumWidth = frustumHeight * (currentCamera.ViewportSize.X / currentCamera.ViewportSize.Y);
					local randomX = randomGenerator:NextNumber(-frustumWidth / 2, frustumWidth / 2);
					local randomY = randomGenerator:NextNumber(-frustumHeight / 2, frustumHeight / 2 + 20);
					local randomZ = -spawnDistance;
					local spawnCFrame = currentCamera.CFrame * CFrame.new(randomX, randomY, randomZ);
					if not workspace:Raycast(spawnCFrame.Position, Vector3.new(0, 150, 0)) then
						createParticle(spawnCFrame.Position);
					end;
				end;
			end;
		end;

		thunderstormSky.Parent = script;
		originalCartoonEffect.Parent = lighting;

		tweenService:Create(lighting.ColorCorrection, TweenInfo.new(3), {
			Brightness = 0,
			TintColor = Color3.fromRGB(255, 255, 255)
		}):Play();

		tweenService:Create(lighting, TweenInfo.new(3), {
			Ambient = Color3.fromRGB(138, 138, 138),
			ExposureCompensation = 0.2,
			Brightness = 2
		}):Play();

		tweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(3), {
			Cover = 0,
			Density = 0
		}):Play();

		task.delay(3, function()
			workspace.Terrain.Clouds.Enabled = false;
		end);
	end);
end;

workspace:GetAttributeChangedSignal("Thunderstorm"):Connect(function()
	if workspace:GetAttribute("Thunderstorm") then
		startThunderstormEvent();
		return;
	else
		isThunderstormActive = false;
		return;
	end;
end);

local rainSplashEffect = replicatedStorage.RainSplash:Clone();
rainSplashEffect.Parent = workspace.WeatherVisuals;

task.spawn(function()
	while true do
		local deltaTime = runService.RenderStepped:Wait();
		local currentTime = os.clock();
		local particlesToMove = {};
		local targetCFrames = {};
		local renderStepScaledTime = deltaTime * 1.5;
		local scaledDeltaTime = math.min(1, deltaTime * 5);

		for index = #activeParticles, 1, -1 do
			local particleData = activeParticles[index]
			local _elapsedTimeSinceSpawn_Unused = currentTime - particleData.spawnTime + scaledDeltaTime;
			local currentPosition = particleData.position;
			local movementVector = Vector3.new(0, -20 * scaledDeltaTime, 0);
			local raycastResult = workspace:Spherecast(currentPosition, 0.15, movementVector, particleRaycastParams);
			local positionToCheck;
			local collided;
			if raycastResult then
				positionToCheck = raycastResult.Position;
				collided = true;
			else
				particleData.position = currentPosition + movementVector;
				positionToCheck = currentPosition; -- Original logic used position *before* update here
				collided = false; -- Original logic checked for nil implicitly
			end;

			local screenPosition, isOnScreen = currentCamera:WorldToScreenPoint(positionToCheck);
			local wasVisible = particleData.visible;
			local normalizedDistance = (currentCamera.CFrame.Position - positionToCheck).Magnitude / 120;
			local distanceFactor = normalizedDistance * normalizedDistance;
			local randomUpdateFactor = 1 / math.random(60, 120);
			local updateThreshold = renderStepScaledTime * distanceFactor + 0.016666666666666666;

			if normalizedDistance > 1.5 then
				particleData.particle:Destroy();
				table.remove(activeParticles, index);
			elseif currentTime - particleData.lastUpdateTime + randomUpdateFactor > updateThreshold then
				particleData.lastUpdateTime = currentTime;
				if isOnScreen and screenPosition.Z < 200 then
					particleData.visible = true;
					table.insert(particlesToMove, particleData.particle);
					table.insert(targetCFrames, CFrame.new(positionToCheck, currentCamera.CFrame.Position) * CFrame.Angles(1.5707963267948966, 0, 0));
				else
					particleData.visible = false;
				end;
				if particleData.visible ~= wasVisible then
					if particleData.visible then
						particleData.particle.Parent = workspace.WeatherVisuals;
					else
						particleData.particle.Parent = nil;
					end;
				end;
				if collided then -- Matches original logic checking if v41 was not nil
					particleData.particle:Destroy();
					rainSplashEffect.CFrame = CFrame.new(positionToCheck);
					rainSplashEffect.Attachment.ParticleEmitter:Emit(randomGenerator:NextInteger(1, 2));
					table.remove(activeParticles, index);
				elseif os.clock() - particleData.spawnTime > 7 then
					debris:AddItem(particleData.particle, 0.3);
					tweenService:Create(particleData.particle, TweenInfo.new(0.3), {
						Transparency = 1
					}):Play();
					table.remove(activeParticles, index);
				end;
			end;
		end;
		debug.profilebegin("Weather_" .. script.Name);
		workspace:BulkMoveTo(particlesToMove, targetCFrames, Enum.BulkMoveMode.FireCFrameChanged);
		debug.profileend();
	end;
end);

if workspace:GetAttribute("Thunderstorm") then
	task.defer(startThunderstormEvent);
else
	isThunderstormActive = false;
end;

local cameraShakerModule = require(replicatedStorage.Code.CameraShaker);
local lightningBoltModule = require(replicatedStorage.Code.LightningBolt);
local cameraShakerInstance = cameraShakerModule.new(Enum.RenderPriority.Camera.Value, function(shakeCFrame)
	currentCamera.CFrame = currentCamera.CFrame * shakeCFrame;
end);

local function createLightningEffect(startAttachment, endAttachment)
	local lightningBoltInstance = lightningBoltModule.new(startAttachment, endAttachment, 30);
	lightningBoltInstance.Thickness = 1.5;
	lightningBoltInstance.Color = Color3.fromRGB(139, 205, 255);
	lightningBoltInstance.Frequency = 15;
	lightningBoltInstance.MinThicknessMultiplier = 0.1;
	lightningBoltInstance.MaxThicknessMultiplier = 1;
	task.wait(0.65);
	cameraShakerInstance:Shake(cameraShakerInstance.Presets.Explosion);
	local lightningHitEffect = replicatedStorage.LightningHit:Clone();
	lightningHitEffect.CFrame = CFrame.new(endAttachment.WorldPosition);
	local groundRaycastResult = workspace:Raycast(lightningHitEffect.CFrame.p, Vector3.new(0, -50, 0));
	if groundRaycastResult and groundRaycastResult.Position then
		lightningHitEffect.CFrame = CFrame.new(groundRaycastResult.Position);
	end;
	lightningHitEffect.Parent = workspace.WeatherVisuals;
	lighting.ColorCorrection.Brightness = 0.3;
	task.delay(0.1, function()
		lighting.ColorCorrection.Brightness = 0.1;
	end);
	for _, descendant in pairs(lightningHitEffect:GetDescendants()) do
		if descendant:IsA("ParticleEmitter") then
			descendant:Emit(descendant:GetAttribute("EmitCount"));
		elseif descendant:IsA("Sound") then
			descendant:Play();
		elseif descendant:IsA("PointLight") then
			tweenService:Create(descendant, TweenInfo.new(3), {
				Range = 0
			}):Play();
		end;
	end;
	lightningBoltInstance:DestroyDissipate(0.7);
	debris:AddItem(lightningHitEffect, 3);
end;

replicatedStorage.GameEvents.LightningBolt.OnClientEvent:Connect(function(targetPosition)
	local endAttachment = Instance.new("Attachment");
	local startAttachment = Instance.new("Attachment");
	startAttachment.Parent = workspace.Terrain;
	endAttachment.Parent = workspace.Terrain;
	startAttachment.WorldPosition = targetPosition + Vector3.new(0, 200, 0);
	endAttachment.WorldPosition = targetPosition;
	createLightningEffect(startAttachment, endAttachment);
	task.delay(5, function()
		startAttachment:Destroy();
		endAttachment:Destroy();
	end);
end);

return ThunderstormEffectModule;