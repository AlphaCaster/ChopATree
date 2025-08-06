-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local userInputService = game:GetService("UserInputService");
local deviceDetector = {
	DeviceChanged = require(replicatedStorageService.Modules.Signal).new(), 
	GetCurrentDevice = function(_) --[[ Line: 13 ]] --[[ Name: GetCurrentDevice ]]
		-- upvalues: l_UserInputService_0 (copy)
		local lastInputType = userInputService:GetLastInputType();
		if lastInputType == Enum.UserInputType.Touch then
			return "Touch";
		elseif lastInputType == Enum.UserInputType.Keyboard or string.find(lastInputType.Name, "Mouse", 1, true) then
			return "PC";
		elseif string.find(lastInputType.Name, "Gamepad", 1, true) then
			return "Gamepad";
		else
			return "PC";
		end;
	end
};
deviceDetector.Observe = function(_, deviceChangedCallback) --[[ Line: 26 ]] --[[ Name: Observe ]]
	-- upvalues: v4 (copy)
	local deviceChangedConnection = deviceDetector.DeviceChanged:Connect(function() --[[ Line: 27 ]]
		-- upvalues: v6 (copy), v4 (ref)
		task.spawn(deviceChangedCallback, deviceDetector:GetCurrentDevice());
	end);
	task.spawn(deviceChangedCallback, deviceDetector:GetCurrentDevice());
	return function() --[[ Line: 33 ]]
		-- upvalues: v7 (copy)
		deviceChangedConnection:Disconnect();
	end;
end;
deviceDetector.Start = function(_) --[[ Line: 38 ]] --[[ Name: Start ]]
	-- upvalues: v4 (copy), l_UserInputService_0 (copy)
	local currentDeviceType = nil;
	local function updateInput() --[[ Line: 40 ]] --[[ Name: updateInput ]]
		-- upvalues: v4 (ref), v9 (ref)
		local currentDevice = deviceDetector:GetCurrentDevice();
		if currentDevice == currentDeviceType then
			return;
		else
			currentDeviceType = currentDevice;
			deviceDetector.DeviceChanged:Fire(currentDevice);
			return;
		end;
	end;
	userInputService.LastInputTypeChanged:Connect(updateInput);
	local newDevice = deviceDetector:GetCurrentDevice();
	if newDevice ~= currentDeviceType then
		currentDeviceType = newDevice;
		deviceDetector.DeviceChanged:Fire(newDevice);
	end;
end;
task.spawn(deviceDetector.Start, deviceDetector);
return deviceDetector;