-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local _ = replicatedStorageService:WaitForChild("Modules");
local gameEventsDataStreamRemoteEvent = replicatedStorageService:WaitForChild("GameEvents"):WaitForChild("DataStream");
local class = require(script:WaitForChild("class"));
local signalModule = require(script:WaitForChild("Signal"));
local tableListenerModule = require(script:WaitForChild("TableListener"));
local deepCloneModule = require(script:WaitForChild("DeepClone"));
local dataMap = {};
local objectMap = {};
gameEventsDataStreamRemoteEvent.OnClientEvent:Connect(function(...) --[[ Line: 15 ]]
	-- upvalues: v7 (copy), l_TableListener_0 (copy), l_DeepClone_0 (copy), v8 (copy)
	local arguments = {...};

	local dataType = arguments[1];
	if dataType == "InitData" then
		local dataKey = arguments[2];
		local dataValue = arguments[3];
		if not dataKey or not dataValue then
			return;
		else
			dataMap[dataKey] = tableListenerModule.new(dataValue);
			return;
		end;
	else
		if dataType == "UpdateData" then
			local objectName = arguments[2];
			local dataObject = dataMap[objectName];
			if not dataObject then
				return;
			else
				for _, dataPair in arguments[3] do
					task.spawn(function() --[[ Line: 33 ]]
						-- upvalues: v14 (copy), v16 (copy), l_DeepClone_0 (ref), v8 (ref), v13 (copy)
						local dataObjectTable = dataObject:GetTable();
						local pathSegment = dataPair[1];
						local newValue = dataPair[2];
						local pathSegments = pathSegment:split("/");
						if #pathSegments < 1 then
							return;
						else
							table.remove(pathSegments, 1);
							local pathString = table.concat(pathSegments, "/", 1, #pathSegments);
							local parentPath = table.concat(pathSegments, "/", 1, #pathSegments == 1 and 1 or #pathSegments - 1);
							local currentTable = "";
							local errorMessage = nil;
							for index, key in pathSegments do
								key = tonumber(key) or key;
								if not errorMessage then
									errorMessage = key;
								else
									errorMessage = ("%*/%*"):format(errorMessage, key);
								end;
								local pathSignalName = ("%*/@"):format(errorMessage);
								local pathSignal = dataObject:FindPathSignal(pathSignalName);
								if pathSignal then
									pathSignal:Fire(key, newValue, pathString);
								end;
								if index == #pathSegments then
									local oldValue = dataObjectTable[key];
									if type(newValue) ~= "table" or type(dataObjectTable[key]) ~= "table" then
										dataObjectTable[key] = newValue;
									else
										dataObjectTable[key] = deepCloneModule:DeepCopy(newValue);
									end;
									local pathSignalSingle = dataObject:FindPathSignal((("%*"):format(parentPath)));
									if pathSignalSingle then
										pathSignalSingle:Fire(key, newValue, oldValue, parentPath);
									end;
									local pathSignalRecursive = dataObject:FindPathSignal((("%*/*"):format(parentPath)));
									if pathSignalRecursive then
										pathSignalRecursive:Fire(key, newValue, oldValue, pathString);
									end;
									local existingObject = objectMap[objectName];
									if existingObject then
										existingObject.GlobalChanged:Fire(key, newValue, oldValue, pathString);
										return;
									else
										break;
									end;
								else
									local cachedData = dataObjectTable[key] or {};
									dataObjectTable[key] = cachedData;
									dataObjectTable = cachedData;
									if key == #pathSegments - 1 then
										currentTable = dataObjectTable;
									end;
								end;
							end;
							return;
						end;
					end);
				end;
			end;
		end;
		return;
	end;
end);
local alreadyCalled = false
local dataClass = class({
	Constructor = function(self, instanceName) --[[ Line: 110 ]] --[[ Name: Constructor ]]
		-- upvalues: l_Signal_0 (copy), l_DataStream_0 (copy), v8 (copy)
		self.Name = instanceName;
		self.GlobalChanged = signalModule.new();
		if not alreadyCalled then
			alreadyCalled = true
			gameEventsDataStreamRemoteEvent:FireServer("InitData");
		else
			local s,r = pcall(function()
				error(debug.traceback())
			end)
			print(r)
		end
		objectMap[instanceName] = self;
	end, 
	Data = nil
});
dataClass.GetData = function(instance) --[[ Line: 121 ]] --[[ Name: GetData ]]
	-- upvalues: v7 (copy)
	return dataMap[instance.Name];
end;
dataClass.YieldUntilData = function(dataObject, timeout) --[[ Line: 126 ]] --[[ Name: YieldUntilData ]]
	timeout = timeout or 5;
	local startTime = os.clock();
	local data;
	while true do
		data = dataObject:GetData();
		if not data and timeout >= os.clock() - startTime then
			task.wait();
		else
			break;
		end;
	end;
	return data;
end;
dataClass.GetPathSignal = function(dataStream, path) --[[ Line: 139 ]] --[[ Name: GetPathSignal ]]
	local yieldedData = dataStream:YieldUntilData();
	if not yieldedData then
		return;
	else
		return (yieldedData:GetPathSignal(path));
	end;
end;
return dataClass;