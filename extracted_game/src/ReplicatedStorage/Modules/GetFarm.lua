-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local playersService = game:GetService("Players");
local farmOwnerMap = {};
local function getFarm(player) --[[ Line: 5 ]] --[[ Name: GetFarm ]]
	-- upvalues: v1 (copy)
	if not player then
		return;
	elseif farmOwnerMap[player] then
		return farmOwnerMap[player];
	else
		local farmInstance = nil;
		for _, farmChild in workspace.Farm:GetChildren() do
			local importantData = farmChild:FindFirstChild("Important");
			if importantData then
				local ownerData = importantData:FindFirstChild("Data");
				if ownerData and ownerData.Owner.Value == player.Name then
					farmInstance = farmChild;
					break;
				end;
			end;
		end;
		farmOwnerMap[player] = farmInstance;
		return farmInstance;
	end;
end;
playersService.PlayerRemoving:Connect(function(playerToRemove) --[[ Line: 25 ]]
	-- upvalues: v1 (copy)
	farmOwnerMap[playerToRemove] = nil;
end);
return getFarm;