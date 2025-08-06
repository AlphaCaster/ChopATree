-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local gamepadService = game:GetService("GamepadService");
local _ = game:GetService("SoundService");
local playersService = game:GetService("Players");
local signalModule = require(replicatedStorageService.Modules.Signal);
local _ = require(replicatedStorageService.Modules.FastTween);
local framePopupModule = require(replicatedStorageService.Frame_Popup_Module);
local _ = playersService.LocalPlayer.PlayerGui;
local guiStateMap = {};
local groupStateMap = {};
local function createStateValue(initialValue) --[[ Line: 27 ]] --[[ Name: createStateValue ]]
	-- upvalues: v4 (copy)
	local stateSignal = signalModule.new();
	local stateValue = {
		_value = initialValue, 
		_signal = stateSignal
	};
	stateValue.Get = function(_) --[[ Line: 34 ]] --[[ Name: Get ]]
		-- upvalues: v12 (copy)
		return stateValue._value;
	end;
	stateValue.Set = function(_, newValue) --[[ Line: 38 ]] --[[ Name: Set ]]
		-- upvalues: v12 (copy), v11 (copy)
		local previousValue = stateValue._value;
		stateValue._value = newValue;
		stateSignal:Fire(newValue, previousValue);
	end;
	stateValue.Listen = function(_, connectionCallback) --[[ Line: 44 ]] --[[ Name: Listen ]]
		-- upvalues: v11 (copy)
		return stateSignal:Connect(connectionCallback);
	end;
	stateValue.Observe = function(data, callbackFunction) --[[ Line: 48 ]] --[[ Name: Observe ]]
		-- upvalues: v12 (copy)
		local stateConnection = stateValue:Listen(callbackFunction);
		task.spawn(callbackFunction, data:Get(), nil);
		return function() --[[ Line: 51 ]]
			-- upvalues: v21 (copy)
			stateConnection:Disconnect();
		end;
	end;
	return stateValue;
end;
local guiStateManager = {
	GetStateForGui = function(_, index) --[[ Line: 70 ]] --[[ Name: GetStateForGui ]]
		-- upvalues: v8 (copy), v22 (copy)
		local guiState = guiStateMap[index];
		if not guiState then
			guiState = {
				Visible = createStateValue(false), 
				ChangeEnabled = createStateValue(true)
			};
			guiStateMap[index] = guiState;
		end;
		return guiState;
	end, 
	GetStateForGroup = function(_, index2) --[[ Line: 83 ]] --[[ Name: GetStateForGroup ]]
		-- upvalues: v9 (copy), v22 (copy)
		local groupState = groupStateMap[index2];
		if not groupState then
			groupState = {
				Gui = createStateValue(nil)
			};
			groupStateMap[index2] = groupState;
		end;
		return groupState;
	end, 
	GetGroupForGui = function(_, object) --[[ Line: 95 ]] --[[ Name: GetGroupForGui ]]
		return object:GetAttribute("Group") or "Menu";
	end
};
guiStateManager.Close = function(_, guiObject) --[[ Line: 99 ]] --[[ Name: Close ]]
	-- upvalues: v31 (copy), l_GamepadService_0 (copy)
	local guiGroup = guiStateManager:GetGroupForGui(guiObject);
	local groupState = guiStateManager:GetStateForGroup(guiGroup);
	if groupState.Gui:Get() ~= guiObject then
		return;
	else
		local guiState = guiStateManager:GetStateForGui(guiObject);
		guiState.Visible:Set(false);
		groupState.Gui:Set(nil);
		if guiState.ChangeEnabled:Get() then
			guiObject.Enabled = false;
			gamepadService:DisableGamepadCursor();
		end;
		return;
	end;
end;
guiStateManager.Open = function(_, guiObject) --[[ Line: 116 ]] --[[ Name: Open ]]
	-- upvalues: v31 (copy), l_GamepadService_0 (copy)
	local guiGroup = guiStateManager:GetGroupForGui(guiObject);
	local groupState = guiStateManager:GetStateForGroup(guiGroup);
	local currentGui = groupState.Gui:Get();
	if currentGui == guiObject then
		return;
	else
		if currentGui then
			guiStateManager:Close(currentGui);
		end;
		local guiState = guiStateManager:GetStateForGui(guiObject);
		guiState.Visible:Set(true);
		groupState.Gui:Set(guiObject);
		if guiState.ChangeEnabled:Get() then
			guiObject.Enabled = true;
			gamepadService:EnableGamepadCursor(guiObject:FindFirstChildWhichIsA("GuiObject", true));
		end;
		return;
	end;
end;
guiStateManager.Toggle = function(_, guiId) --[[ Line: 137 ]] --[[ Name: Toggle ]]
	-- upvalues: v31 (copy)
	local guiState = guiStateManager:GetStateForGui(guiId);
	if guiState.Visible:Get() then
		guiStateManager:Close(guiId);
	else
		guiStateManager:Open(guiId);
	end;
	return guiState.Visible;
end;
guiStateManager.UsePopupAnims = function(_, guiObject) --[[ Line: 147 ]] --[[ Name: UsePopupAnims ]]
	-- upvalues: v31 (copy), v6 (copy)
	if not (guiObject:FindFirstChild("Main") or guiObject:FindFirstChild("Frame")) then
		error((("No root frame found for %*"):format((guiObject:GetFullName()))));
		return;
	else
		guiObject.Enabled = false;
		local guiState = guiStateManager:GetStateForGui(guiObject);
		guiState.ChangeEnabled:Set(true);
		guiState.Visible:Observe(function(isVisible) --[[ Line: 158 ]]
			-- upvalues: v6 (ref), v47 (copy)
			if isVisible then
				framePopupModule.Show(guiObject);
				return;
			else
				framePopupModule.Hide(guiObject);
				return;
			end;
		end);
		return;
	end;
end;
return guiStateManager;