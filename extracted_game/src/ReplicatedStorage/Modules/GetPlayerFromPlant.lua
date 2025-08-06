-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local playersService = game:GetService("Players");
return function(instance) --[[ Line: 4 ]] --[[ Name: GetPlayerFromPlant ]]
	-- upvalues: l_Players_0 (copy)
	local importantAncestor = instance:FindFirstAncestor("Important");
	local dataFolder = if importantAncestor then importantAncestor:FindFirstChild("Data") else nil;
	local ownerValue = if dataFolder then dataFolder:FindFirstChild("Owner") else nil;
	if ownerValue and ownerValue.Value then
		return (playersService:FindFirstChild(ownerValue.Value));
	else
		return nil;
	end;
end;