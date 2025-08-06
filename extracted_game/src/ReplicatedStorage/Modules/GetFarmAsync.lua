-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("Players");
local replicatedStorageService = game:GetService("ReplicatedStorage");
local getFarmModule = require(replicatedStorageService.Modules.GetFarm);
return function(farmId) --[[ Line: 7 ]] --[[ Name: GetFarmAsync ]]
	-- upvalues: v2 (copy)
	local farmInstance = getFarmModule(farmId);
	if farmInstance then
		return farmInstance;
	else
		repeat
			task.wait();
			farmInstance = getFarmModule(farmId);
		until not farmId:IsDescendantOf(farmId) or farmInstance;
		return farmInstance;
	end;
end;