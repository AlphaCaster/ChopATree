-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local textChatService = game:GetService("TextChatService");
local displayChatMessageEvent = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("DisplayChatMessage");
local function displayChatMessage(message) --[[ Line: 8 ]] --[[ Name: DisplayChatMessage ]]
	-- upvalues: l_TextChatService_0 (copy)
	textChatService.TextChannels.RBXGeneral:DisplaySystemMessage(message);
end;
displayChatMessageEvent.OnClientEvent:Connect(function(message) --[[ Line: 12 ]]
	-- upvalues: l_TextChatService_0 (copy)
	textChatService.TextChannels.RBXGeneral:DisplaySystemMessage(message);
end);
return displayChatMessage;