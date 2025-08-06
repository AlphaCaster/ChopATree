-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local function getLuckModifiers(player, fruit, context) --[[ Line: 9 ]] --[[ Name: GetLuckModifiers ]]
	local luckModifiers = {
		{
			Name = "Default", 
			Modifier = 1
		}
	};
	if context == "Plant" or context == "Grow" or context == "BottomDisplay" then
		local fruitVariantLuckModifier = if fruit then fruit:GetAttribute("FruitVariantLuck") else nil;
		if type(fruitVariantLuckModifier) == "number" and fruitVariantLuckModifier ~= 1 then
			table.insert(luckModifiers, {
				Name = "FruitVariantLuck", 
				Modifier = fruitVariantLuckModifier - 1
			});
		end;
	end;
	if context == "BottomDisplay" then
		local sessionTimeLuckModifier = player:GetAttribute("SessionTimeLuck");
		if sessionTimeLuckModifier and sessionTimeLuckModifier ~= 0 then
			table.insert(luckModifiers, {
				Name = "SessionTimeLuck", 
				Modifier = sessionTimeLuckModifier
			});
		end;
	end;
	return luckModifiers;
end;
return {
	GetModifiers = getLuckModifiers, 
	GetLuck = function(player, fruit, context, excludedModifiers) --[[ Line: 41 ]] --[[ Name: PlayerLuck ]]
		-- upvalues: v6 (copy)
		local totalLuckModifier = 0;
		for _, luckModifier in getLuckModifiers(player, fruit, context) do
			if not excludedModifiers or not table.find(excludedModifiers, luckModifier.Name) then
				totalLuckModifier = totalLuckModifier + luckModifier.Modifier;
			end;
		end;
		return totalLuckModifier;
	end, 
	Listen = function(instance, callback) --[[ Line: 53 ]] --[[ Name: Listen ]]
		local attributeConnections = {};
		table.insert(attributeConnections, instance:GetAttributeChangedSignal("SessionTimeLuck"):Connect(callback));
		local spawnedTask = task.spawn(callback);
		return function() --[[ Line: 60 ]]
			-- upvalues: v17 (copy), v16 (copy)
			if coroutine.status(spawnedTask) == "suspended" then
				pcall(task.cancel, spawnedTask);
			end;
			for _, connection in attributeConnections do
				if connection.Connected then
					connection:Disconnect();
				end;
			end;
			table.clear(attributeConnections);
		end;
	end
};