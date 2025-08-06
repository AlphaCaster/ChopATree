local RainEffectModule = {};
local unused = {};

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
local isRainEventActive = false;

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
		return currentPosition, false; -- Original returned l_position_0 which is currentPosition
	end;
end;

local rainSky = script.Sky;
local originalCartoonEffect = lighting.Cartoon;

local function startRainEvent()
	isRainEventActive = true;
	originalCartoonEffect.Parent = replicatedStorage;
	rainSky.Parent = lighting;

	tweenService:Create(lighting, TweenInfo.new(3), {
		Ambient = Color3.fromRGB(196, 240, 255),
		ExposureCompensation = 0.4,
		Brightness = 0.7
	}):Play();

	tweenService:Create(lighting.ColorCorrection, TweenInfo.new(3), {
		Brightness = 0.1,
		TintColor = Color3.fromRGB(215, 240, 255)
	}):Play();

	workspace.Terrain.Clouds.Enabled = true;
	tweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(3), {
		Cover = 0.905,
		Density = 0.083
	}):Play();

	task.spawn(function()
		while isRainEventActive do
			task.wait(0.05);
			if #activeParticles <= 50 then
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

		rainSky.Parent = script;
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

workspace:GetAttributeChangedSignal("RainEvent"):Connect(function()
	if workspace:GetAttribute("RainEvent") then
		startRainEvent();
		return;
	else
		isRainEventActive = false;
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
		local renderStepScaledTime = deltaTime * 3;
		local scaledDeltaTime = math.min(1, deltaTime * 5);

		for index = #activeParticles, 1, -1 do
			local particleData = activeParticles[index]
			local _elapsedTimeSinceSpawn = currentTime - particleData.spawnTime + scaledDeltaTime; -- Calculated but unused in original logic here
			local currentPosition = particleData.position;
			local movementVector = Vector3.new(0, -20 * scaledDeltaTime, 0);
			local raycastResult = workspace:Spherecast(currentPosition, 0.15, movementVector, particleRaycastParams);
			local newPosition;
			local collided;
			if raycastResult then
				newPosition = raycastResult.Position;
				collided = true;
			else
				particleData.position = currentPosition + movementVector;
				newPosition = particleData.position; -- Use the updated position
				collided = false; -- Explicitly set to false, original used nil check
			end;

			local screenPosition, isOnScreen = currentCamera:WorldToScreenPoint(newPosition);
			local wasVisible = particleData.visible;
			local normalizedDistance = (currentCamera.CFrame.Position - newPosition).Magnitude / 120;
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
					table.insert(targetCFrames, CFrame.new(newPosition, currentCamera.CFrame.Position) * CFrame.Angles(1.5707963267948966, 0, 0));
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
				if collided then
					particleData.particle:Destroy();
					rainSplashEffect.CFrame = CFrame.new(newPosition);
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

if workspace:GetAttribute("RainEvent") then
	task.defer(startRainEvent);
else
	isRainEventActive = false;
end;

return RainEffectModule;