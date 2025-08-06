-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local userInputService = game:GetService("UserInputService");
local guiService = game:GetService("GuiService");
local currentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() --[[ Line: 6 ]]
	-- upvalues: l_CurrentCamera_0 (ref)
	currentCamera = workspace.CurrentCamera;
end);
return function(raycastParams, raycastDistance) --[[ Line: 10 ]] --[[ Name: GetMouseToWorld ]]
	-- upvalues: l_UserInputService_0 (copy), l_GuiService_0 (copy), l_CurrentCamera_0 (ref)
	local mouseLocation = userInputService:GetMouseLocation();
	local guiInset = guiService:GetGuiInset();
	local mouseRay = currentCamera:ScreenPointToRay(mouseLocation.X + guiInset.X, mouseLocation.Y - guiInset.Y);
	return workspace:Raycast(mouseRay.Origin, mouseRay.Direction * (raycastDistance or 1000), raycastParams);
end;