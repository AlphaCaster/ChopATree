local FrostEffectModule = {};
local unused = {};

local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local debris = game:GetService("Debris")
local lighting = game:GetService("Lighting")
local players = game:GetService("Players")
local workspace = game:GetService("Workspace")

local snowParticleTemplate = replicatedStorage.SnowParticle;
local randomGenerator = Random.new();
local currentCamera = workspace.CurrentCamera;

local particleRaycastParams = RaycastParams.new();
particleRaycastParams.FilterDescendantsInstances = {
	workspace.Terrain,
	workspace
};
particleRaycastParams.FilterType = Enum.RaycastFilterType.Include;

local activeParticles = {};
local isFrostEventActive = false;

local function createParticle(spawnPosition)
	local particleData = {
		particle = snowParticleTemplate:Clone(),
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

local function updateParticlePosition(particleData, currentTime, scaledDeltaTime)
	local elapsedTimeSinceSpawn = currentTime - particleData.spawnTime + scaledDeltaTime;
	local currentPosition = particleData.position;
	local movementVector = Vector3.new(-7, 0, 0).Unit * 45 * scaledDeltaTime + Vector3.new(math.sin((math.rad(particleData.spawnTime * 90))), (math.sin((math.rad(particleData.spawnTime * 90))) + 1) / 2 * -5, (math.sin((math.rad(particleData.spawnTime * 90))))) * scaledDeltaTime + Vector3.new(scaledDeltaTime * 0.5 * math.sin(math.rad(os.clock() * 35) + particleData.spawnTime), 0, 0);
	local raycastResult = workspace:Spherecast(currentPosition, 0.15, movementVector * scaledDeltaTime, particleRaycastParams);
	if raycastResult then
		return raycastResult.Position, true;
	else
		particleData.position = currentPosition + movementVector * scaledDeltaTime;
		return particleData.position, false;
	end;
end;

local frostSky = script.Sky;
local originalCartoonEffect = lighting.Cartoon;
local bodyShaker = require(replicatedStorage.Code.BodyShaker);

local function startFrostEvent()
	isFrostEventActive = true;
	task.delay(1, function()
		local localPlayerCharacter = players.LocalPlayer.Character;
		if localPlayerCharacter and localPlayerCharacter:IsDescendantOf(workspace) then
			local coldSoundInstance = script.coldSound:Clone();
			coldSoundInstance.Parent = localPlayerCharacter.PrimaryPart;
			coldSoundInstance:Play();
			tweenService:Create(coldSoundInstance, TweenInfo.new(1), {
				Volume = 0.02
			}):Play();
			task.delay(25, function()
				tweenService:Create(coldSoundInstance, TweenInfo.new(1), {
					Volume = 0
				}):Play();
				debris:AddItem(coldSoundInstance, 1);
			end);
		end;
		bodyShaker.EnableShaking();
	end);

	originalCartoonEffect.Parent = replicatedStorage;
	frostSky.Parent = lighting;

	tweenService:Create(lighting.Atmosphere, TweenInfo.new(3), {
		Density = 0.493,
		Glare = 0.85,
		Haze = 2.11,
		Offset = 1,
		Color = Color3.fromRGB(215, 244, 255),
		Decay = Color3.fromRGB(190, 238, 255)
	}):Play();

	tweenService:Create(lighting, TweenInfo.new(3), {
		Ambient = Color3.fromRGB(131, 179, 255),
		ExposureCompensation = 0.4,
		Brightness = 1
	}):Play();

	tweenService:Create(lighting.ColorCorrection, TweenInfo.new(3), {
		Brightness = 0.1,
		Saturation = -0.2
	}):Play();

	workspace.Terrain.Clouds.Enabled = true;
	tweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(3), {
		Cover = 0.777,
		Density = 0.123,
		Color = Color3.fromRGB(206, 238, 255)
	}):Play();

	local windyFrostEffectContainer = replicatedStorage.WindyFrostEffect:Clone();
	windyFrostEffectContainer.Parent = workspace;

	task.spawn(function()
		while isFrostEventActive do
			runService.Heartbeat:Wait();
			if #activeParticles <= 200 then
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

		frostSky.Parent = script;
		originalCartoonEffect.Parent = lighting;

		for _, effectChild in windyFrostEffectContainer:GetChildren() do
			effectChild.Enabled = false;
		end;
		task.delay(6, function()
			windyFrostEffectContainer:Destroy();
		end);

		bodyShaker.DisableShaking();

		tweenService:Create(lighting.Atmosphere, TweenInfo.new(3), {
			Density = 0,
			Haze = 0,
			Glare = 0,
			Offset = 0
		}):Play();

		tweenService:Create(lighting.ColorCorrection, TweenInfo.new(3), {
			Brightness = 0,
			Saturation = 0,
			TintColor = Color3.fromRGB(255, 255, 255)
		}):Play();

		tweenService:Create(lighting, TweenInfo.new(3), {
			Ambient = Color3.fromRGB(138, 138, 138),
			ExposureCompensation = 0.2,
			Brightness = 2
		}):Play();

		tweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(3), {
			Cover = 0,
			Density = 0,
			Color = Color3.fromRGB(22, 40, 70)
		}):Play();

		task.delay(3, function()
			workspace.Terrain.Clouds.Enabled = false;
		end);
	end);
end;

workspace:GetAttributeChangedSignal("FrostEvent"):Connect(function()
	if workspace:GetAttribute("FrostEvent") then
		startFrostEvent();
		return;
	else
		isFrostEventActive = false;
		return;
	end;
end);

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
			local newPosition, collided = updateParticlePosition(particleData, currentTime, scaledDeltaTime);
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
					debris:AddItem(particleData.particle, 1);
					tweenService:Create(particleData.particle, TweenInfo.new(1), {
						Transparency = 1
					}):Play();
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

if workspace:GetAttribute("FrostEvent") then
	task.defer(startFrostEvent);
else
	isFrostEventActive = false;
end;

return FrostEffectModule;