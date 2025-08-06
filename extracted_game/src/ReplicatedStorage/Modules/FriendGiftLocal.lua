-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local gameEvents = game:GetService("ReplicatedStorage").GameEvents;
local starterGuiService = game:GetService("StarterGui");
local friendGiftEvent = gameEvents.FriendGiftEvent;
local friendRequestHandlers = {};
repeat
	task.wait();
until game:IsLoaded();
local localPlayer = game.Players.LocalPlayer;
local friendNotificationGui = localPlayer.PlayerGui:WaitForChild("Friend_Notification", 3);
local bodyLabel = friendNotificationGui.Frame.Frame.Background.Holder.BodyLabel;
local acceptButton = friendNotificationGui.Frame.Frame.Background.Holder.Frame.Accept;
local declineButton = friendNotificationGui.Frame.Frame.Background.Holder.Frame.Decline;
local pendingFriendRequests = {};
local currentFriendRequest = nil;
local function _() --[[ Line: 25 ]] --[[ Name: UpdateFromQueue ]]
	-- upvalues: v10 (ref), v9 (copy), l_BodyLabel_0 (copy), v5 (copy)
	print("EVENT FIRED 5");
	if currentFriendRequest then
		return;
	else
		local firstPendingFriendRequest = pendingFriendRequests[1];
		currentFriendRequest = firstPendingFriendRequest;
		print("EVENT FIRED 6");
		bodyLabel.Text = ("Friend request from\n%*"):format(firstPendingFriendRequest.Name);
		print("EVENT FIRED 7");
		friendNotificationGui.Show_VAL.Value = true;
		return;
	end;
end;
friendRequestHandlers.DismissCurrent = function(_) --[[ Line: 38 ]] --[[ Name: DismissCurrent ]]
	-- upvalues: v9 (copy), v10 (ref), l_BodyLabel_0 (copy), v5 (copy)
	print("EVENT FIRED 1");
	local friendRequestIndex = table.find(pendingFriendRequests, currentFriendRequest);
	if friendRequestIndex then
		table.remove(pendingFriendRequests, friendRequestIndex);
	end;
	currentFriendRequest = nil;
	if #pendingFriendRequests > 0 then
		print("Trying to show next");
		print("EVENT FIRED 5");
		if currentFriendRequest then
			return;
		else
			local nextPendingFriendRequest = pendingFriendRequests[1];
			currentFriendRequest = nextPendingFriendRequest;
			print("EVENT FIRED 6");
			bodyLabel.Text = ("Friend request from\n%*"):format(nextPendingFriendRequest.Name);
			print("EVENT FIRED 7");
			friendNotificationGui.Show_VAL.Value = true;
			return;
		end;
	else
		print("Hiding");
		friendNotificationGui.Show_VAL.Value = false;
		return;
	end;
end;
friendRequestHandlers.AcceptCurrent = function(_) --[[ Line: 57 ]] --[[ Name: AcceptCurrent ]]
	-- upvalues: v10 (ref), v3 (copy), l_StarterGui_0 (copy)
	print("EVENT FIRED 2");
	local currentFriendRequestCopy = currentFriendRequest;
	friendRequestHandlers:DismissCurrent();
	if not currentFriendRequestCopy then
		return;
	else
		starterGuiService:SetCore("PromptSendFriendRequest", currentFriendRequestCopy);
		return;
	end;
end;
friendGiftEvent.OnClientEvent:Connect(function(friendRequester) --[[ Line: 68 ]]
	-- upvalues: l_LocalPlayer_0 (copy), v9 (copy), v10 (ref), l_BodyLabel_0 (copy), v5 (copy)
	print("EVENT FIRED 3");
	if friendRequester:IsFriendsWith(localPlayer.UserId) then
		return;
	else
		if not table.find(pendingFriendRequests, friendRequester) then
			table.insert(pendingFriendRequests, friendRequester);
		end;
		print("EVENT FIRED 5");
		if currentFriendRequest then
			return;
		else
			local friendRequesterInstance = pendingFriendRequests[1];
			currentFriendRequest = friendRequesterInstance;
			print("EVENT FIRED 6");
			bodyLabel.Text = ("Friend request from\n%*"):format(friendRequesterInstance.Name);
			print("EVENT FIRED 7");
			friendNotificationGui.Show_VAL.Value = true;
			return;
		end;
	end;
end);
acceptButton.MouseButton1Click:Connect(function() --[[ Line: 81 ]]
	-- upvalues: v3 (copy)
	friendRequestHandlers:AcceptCurrent();
end);
declineButton.MouseButton1Click:Connect(function() --[[ Line: 85 ]]
	-- upvalues: v3 (copy)
	friendRequestHandlers:DismissCurrent();
end);
return friendRequestHandlers;