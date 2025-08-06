-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local _ = replicatedStorageService:WaitForChild("Modules");
local replicationModule = require(replicatedStorageService.Modules.ReplicationClass);
local _ = require(script:WaitForChild("class"));
local dataFolder = replicatedStorageService:WaitForChild("Data");
local _ = require(dataFolder:WaitForChild("DefaultData"));
local localPlayer = game:GetService("Players").LocalPlayer;
local dataReceiver = {
	Receiver = replicationModule.new((("%*_DataServiceProfile"):format(localPlayer.Name)))
};
dataReceiver.Receiver:YieldUntilData();
dataReceiver.GetPathSignal = function(arg1, path) --[[ Line: 33 ]] --[[ Name: GetPathSignal ]]
	local receiver = arg1.Receiver;
	if not receiver then
		return;
	else
		local _ = receiver:YieldUntilData(25);
		return receiver:GetPathSignal(path);
	end;
end;
dataReceiver.GetData = function(arg1) --[[ Line: 39 ]] --[[ Name: GetData ]]
	local receiver = arg1.Receiver;
	if not receiver then
		return {};
	else
		receiver:YieldUntilData();
		local data = receiver:YieldUntilData(10);
		if not data then
			return {};
		else
			return data.Table;
		end;
	end;
end;
return dataReceiver;