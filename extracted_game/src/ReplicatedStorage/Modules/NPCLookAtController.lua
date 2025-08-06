-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("CollectionService");
local replicatedStorage = game:GetService("ReplicatedStorage");
local runService = game:GetService("RunService");
local playersService = game:GetService("Players");
local observersModule = require(replicatedStorage.Modules.Observers);
local localPlayer = playersService.LocalPlayer;
local npcDataMap = {};
local npcLookAtHandler = {
	UpdateTranslation = function(_, translationValue) --[[ Line: 26 ]] --[[ Name: UpdateTranslation ]]
		-- upvalues: v6 (copy)
		local translationFactor = math.exp(translationValue * -15);
		for npcInstance, npcData in next, npcDataMap do
			local targetPartPivot = if npcData.TargetPart then npcData.TargetPart:GetPivot() else nil;
			if targetPartPivot and npcInstance:GetPivot():ToObjectSpace(targetPartPivot).Z < 0 then
				local headToTargetVector = npcData.Head.CFrame.Position - targetPartPivot.Position;
				local initialNeckC0 = npcData.Neck.C0;
				local neckCFrame = npcData.InitialNeckC0 * CFrame.Angles(math.atan(headToTargetVector.Y / vector.magnitude(headToTargetVector)) * 0.5, 0, vector.cross(vector.normalize(headToTargetVector), npcData.Torso.CFrame.LookVector).y * 0.8);
				npcData.Neck.C0 = neckCFrame:Lerp(initialNeckC0, translationFactor);
			else
				local currentNeckC0 = npcData.Neck.C0;
				local initialNeckC0Value = npcData.InitialNeckC0;
				npcData.Neck.C0 = initialNeckC0Value:Lerp(currentNeckC0, translationFactor);
			end;
		end;
	end, 
	Update = function(_) --[[ Line: 53 ]] --[[ Name: Update ]]
		-- upvalues: l_LocalPlayer_0 (copy), v6 (copy)
		local playerCharacter = localPlayer.Character;
		local playerHead = if playerCharacter then playerCharacter:FindFirstChild("Head") else nil;
		local playerHeadPivot = if playerHead then playerHead:GetPivot() else nil;
		for npcInstance2, npcData2 in next, npcDataMap do
			if npcData2.Neck then
				local isInRange = false;
				if playerHeadPivot and vector.magnitude(playerHeadPivot.Position - npcInstance2:GetPivot().Position) <= 30 then
					isInRange = true;
				end;
				if isInRange then
					npcData2.TargetPart = playerHead;
				else
					npcData2.TargetPart = nil;
				end;
			end;
		end;
	end, 
	AddNPC = function(_, npcInstance3) --[[ Line: 78 ]] --[[ Name: AddNPC ]]
		-- upvalues: v6 (copy)
		local torsoPart = npcInstance3:WaitForChild("Torso");
		if not torsoPart then
			warn((("Failed to find Torso for npc \"%*\""):format((npcInstance3:GetFullName()))));
			return;
		else
			local headPart = npcInstance3:WaitForChild("Head");
			if not headPart then
				warn((("Failed to find Head for npc \"%*\""):format((npcInstance3:GetFullName()))));
				return;
			else
				local neckJoint = torsoPart:WaitForChild("Neck");
				if not neckJoint then
					warn((("Failed to find Neck for npc \"%*\""):format((npcInstance3:GetFullName()))));
					return;
				else
					npcDataMap[npcInstance3] = {
						Torso = torsoPart, 
						Head = headPart, 
						Neck = neckJoint, 
						InitialNeckC0 = neckJoint.C0
					};
					return;
				end;
			end;
		end;
	end, 
	RemoveNPC = function(_, index) --[[ Line: 106 ]] --[[ Name: RemoveNPC ]]
		-- upvalues: v6 (copy)
		npcDataMap[index] = nil;
	end
};
npcLookAtHandler.Start = function(_) --[[ Line: 110 ]] --[[ Name: Start ]]
	-- upvalues: v4 (copy), v32 (copy), l_RunService_0 (copy)
	observersModule.observeTag("NPCLookAt", function(npcTagInstance) --[[ Line: 111 ]]
		-- upvalues: v32 (ref)
		npcLookAtHandler:AddNPC(npcTagInstance);
		return function() --[[ Line: 114 ]]
			-- upvalues: v32 (ref), v34 (copy)
			npcLookAtHandler:RemoveNPC(npcTagInstance);
		end;
	end, {
		workspace
	});
	local elapsedTime = 0;
	runService.PostSimulation:Connect(function(deltaTime) --[[ Line: 120 ]]
		-- upvalues: v32 (ref), v35 (ref)
		npcLookAtHandler:UpdateTranslation(deltaTime);
		elapsedTime = elapsedTime + deltaTime;
		if elapsedTime < 0.05 then
			return;
		else
			elapsedTime = 0;
			npcLookAtHandler:Update();
			return;
		end;
	end);
end;
task.spawn(npcLookAtHandler.Start, npcLookAtHandler);
return npcLookAtHandler;