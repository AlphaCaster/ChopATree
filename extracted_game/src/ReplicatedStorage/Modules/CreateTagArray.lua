-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local createTagHandler = require(replicatedStorageService.Modules.CreateTagHandler);
return function(tagName) --[[ Line: 5 ]] --[[ Name: CreateTagArray ]]
	-- upvalues: v1 (copy)
	local taggedInstancesList = {};
	createTagHandler({
		Tag = tagName, 
		OnInstanceAdded = function(instanceAdded) --[[ Line: 9 ]] --[[ Name: OnInstanceAdded ]]
			-- upvalues: v3 (copy)
			if table.find(taggedInstancesList, instanceAdded) then
				return;
			else
				table.insert(taggedInstancesList, instanceAdded);
				return;
			end;
		end, 
		OnInstanceRemoved = function(instanceToRemove) --[[ Line: 13 ]] --[[ Name: OnInstanceRemoved ]]
			-- upvalues: v3 (copy)
			local instanceIndex = table.find(taggedInstancesList, instanceToRemove);
			if not instanceIndex then
				return;
			else
				table.remove(taggedInstancesList, instanceIndex);
				return;
			end;
		end
	});
	return taggedInstancesList;
end;