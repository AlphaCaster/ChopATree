-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local playersService = game:GetService("Players");
return function(part) --[[ Line: 3 ]] --[[ Name: GetPlayerFromFarm ]]
	-- upvalues: l_Players_0 (copy)
	if not part then
		return;
	else
		local ownerValue = part:FindFirstChild("Owner", true);
		if not ownerValue then
			return;
		else
			return (playersService:FindFirstChild(ownerValue.Value));
		end;
	end;
end;