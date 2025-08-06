-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local collectionService = game:GetService("CollectionService");
return function(configuration) --[[ Line: 3 ]] --[[ Name: CreateTagHandler ]]
	-- upvalues: l_CollectionService_0 (copy)
	local taggedInstanceName = configuration.Tag;
	local onInstanceAddedCallback = configuration.OnInstanceAdded or function() --[[ Line: 5 ]]

	end;
	local onInstanceRemovedCallback = configuration.OnInstanceRemoved or function() --[[ Line: 6 ]]

	end;
	for _, taggedInstance in (collectionService:GetTagged(taggedInstanceName)) do
		onInstanceAddedCallback(taggedInstance);
	end;
	collectionService:GetInstanceAddedSignal(taggedInstanceName):Connect(onInstanceAddedCallback);
	collectionService:GetInstanceRemovedSignal(taggedInstanceName):Connect(onInstanceRemovedCallback);
end;