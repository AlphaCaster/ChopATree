-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local farm = workspace:WaitForChild("Farm");
return function(part) --[[ Line: 3 ]] --[[ Name: GetFarmAncestor ]]
	-- upvalues: l_Farm_0 (copy)
	for _, farmChild in farm:GetChildren() do
		if farmChild:IsAncestorOf(part) then
			return farmChild;
		end;
	end;
	return nil;
end;