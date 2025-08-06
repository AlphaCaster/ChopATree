-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local reservedProperties = {
	"Set", 
	"Get", 
	"Private", 
	"ReadOnly", 
	"WriteOnly", 
	"Constructor", 
	"GlobalGetFunction", 
	"GlobalSetFunction"
};
local function deepCopy(originalTable) --[[ Line: 5 ]] --[[ Name: DeepCopy ]]
	-- upvalues: v1 (copy)
	local copiedTable = {};
	for key, value in originalTable do
		copiedTable[key] = type(value) == "table" and deepCopy(value) or value;
	end;
	return copiedTable;
end;
return function(configurationTable) --[[ Line: 13 ]] --[[ Name: class ]]
	-- upvalues: v1 (copy), v0 (copy)
	local metatable = {};
	metatable.__index = metatable;
	metatable.__customclass = true;
	local setFunctions = deepCopy(configurationTable.Set or {});
	local getFunctions = deepCopy(configurationTable.Get or {});
	local readOnlyProperties = deepCopy(configurationTable.ReadOnly or {});
	local writeOnlyProperties = deepCopy(configurationTable.WriteOnly or {});
	local privateFunctions = deepCopy(configurationTable.Private or {});
	local globalGetFunction = configurationTable.GlobalGetFunction;
	local globalSetFunction = configurationTable.GlobalSetFunction;
	local constructorFunction = configurationTable.Constructor;
	table.freeze(setFunctions);
	table.freeze(getFunctions);
	table.freeze(readOnlyProperties);
	table.freeze(writeOnlyProperties);
	table.freeze(privateFunctions);
	table.freeze(configurationTable);
	metatable.new = function(...) --[[ Line: 35 ]] --[[ Name: new ]]
		-- upvalues: v6 (ref), v1 (ref), v0 (ref), v12 (copy), v11 (copy), v9 (copy), l_GlobalGetFunction_0 (copy), v7 (copy), v10 (copy), v8 (copy), l_GlobalSetFunction_0 (copy), l_Constructor_0 (copy)
		local realData = {};
		local privateAccessCache = {};
		configurationTable = deepCopy(configurationTable);
		for propertyName, propertyValue in configurationTable do
			if not table.find(reservedProperties, propertyName) then
				realData[propertyName] = propertyValue;
			end;
		end;
		local instance = setmetatable({
			RealData = realData
		}, {
			__index = function(instanceToGet, propertyKey) --[[ Line: 50 ]] --[[ Name: __index ]]
				-- upvalues: v12 (ref), v17 (copy), v11 (ref), v9 (ref), l_GlobalGetFunction_0 (ref), v7 (ref), v16 (copy)
				local callerFunction = debug.info(2, "f");
				local privateFunction = privateFunctions[propertyKey];
				if not privateAccessCache[callerFunction] and privateFunction then
					return error((("Cannot access private function %* from %*"):format(callerFunction, (debug.info(2, "f")))));
				elseif writeOnlyProperties[propertyKey] then
					return error((("Cannot read from write only property %*"):format(propertyKey)));
				else
					local getFunction = getFunctions[propertyKey];
					if globalGetFunction then
						globalGetFunction(instanceToGet, propertyKey);
					end;
					return rawget(metatable, propertyKey) or getFunction and getFunction(instanceToGet) or rawget(realData, propertyKey);
				end;
			end, 
			__newindex = function(instanceToSet, propertyKeyToSet, value) --[[ Line: 73 ]] --[[ Name: __newindex ]]
				-- upvalues: v12 (ref), v17 (copy), v10 (ref), v8 (ref), v16 (copy), l_GlobalSetFunction_0 (ref)
				local functionName = debug.info(2, "f");
				local privateSetFunction = privateFunctions[propertyKeyToSet];
				if not privateAccessCache[functionName] and privateSetFunction then
					return error((("Cannot access private function %* from %*"):format(functionName, (debug.info(2, "f")))));
				elseif readOnlyProperties[propertyKeyToSet] then
					return error((("Cannot write to read only property %*"):format(propertyKeyToSet)));
				else
					local setFunction = setFunctions[propertyKeyToSet];
					if setFunction then
						setFunction(instanceToSet, propertyKeyToSet, value);
					else
						rawset(realData, propertyKeyToSet, value);
					end;
					if globalSetFunction then
						globalSetFunction(instanceToSet, propertyKeyToSet, value);
					end;
					return;
				end;
			end
		});
		for _, callbackFunction in metatable do
			if type(callbackFunction) == "function" then
				privateAccessCache[callbackFunction] = true;
			end;
		end;
		privateAccessCache[debug.info(1, "f")] = true;
		if constructorFunction then
			constructorFunction(instance, ...);
		end;
		return instance;
	end;
	return metatable;
end;