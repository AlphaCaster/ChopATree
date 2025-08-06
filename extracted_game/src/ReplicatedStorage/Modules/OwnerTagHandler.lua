-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local module = {};
local runService = game:GetService("RunService");
local playersService = game:GetService("Players");
local tweenService = game:GetService("TweenService");
local modulesFolder = game:GetService("ReplicatedStorage"):WaitForChild("Modules");
local getFarmModule = require(modulesFolder:WaitForChild("GetFarm"));
local localPlayer = playersService.LocalPlayer;
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait();
localPlayer.CharacterAdded:Connect(function(newCharacter) --[[ Line: 16 ]]
	-- upvalues: v7 (ref)
	character = newCharacter;
end);
local ownerTagInstance = getFarmModule(localPlayer):WaitForChild("Owner_Tag");
local ownerTagPosition = Vector3.new(ownerTagInstance.Position.X, 0, ownerTagInstance.Position.Z);
local isFarFromCharacterCached = false;
local ownerTag = script:WaitForChild("OwnerTag");
ownerTag:PivotTo(ownerTagInstance:GetPivot());
ownerTag.Parent = workspace;
task.delay(2, function() --[[ Line: 30 ]]
	-- upvalues: l_OwnerTag_0 (copy), l_Players_0 (copy), l_LocalPlayer_0 (copy)
	ownerTag:FindFirstChild("PROFILE_IMAGE", true).Image = playersService:GetUserThumbnailAsync(localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
end);
runService.RenderStepped:Connect(function() --[[ Line: 35 ]]
	-- upvalues: v7 (ref), v10 (copy), v11 (ref), l_TweenService_0 (copy), l_OwnerTag_0 (copy)
	local characterPosition = character:GetPivot().Position;
	local characterPositionXZ = Vector3.new(characterPosition.X, 0, characterPosition.Z);
	local isFarFromCharacter = (ownerTagPosition - characterPositionXZ).Magnitude >= 80;
	if isFarFromCharacterCached == isFarFromCharacter then
		return;
	else
		isFarFromCharacterCached = isFarFromCharacter;
		tweenService:Create(ownerTag.Part1.BillboardGui.Frame.CanvasGroup, TweenInfo.new(0.2), {
			GroupTransparency = isFarFromCharacter and 0 or 1
		}):Play();
		return;
	end;
end);
return module;