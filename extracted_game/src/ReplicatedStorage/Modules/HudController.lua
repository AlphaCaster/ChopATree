-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local _ = game:GetService("SoundService");
local playersService = game:GetService("Players");
local guiControllerModule = require(replicatedStorageService.Modules.GuiController);
local playerGui = playersService.LocalPlayer.PlayerGui;
local hudUI = playerGui:WaitForChild("Hud_UI");
local shopButtonController = {
	Start = function(_) --[[ Line: 14 ]] --[[ Name: Start ]]
		-- upvalues: l_Hud_UI_0 (copy), v3 (copy), l_PlayerGui_0 (copy)
		hudUI.SideBtns.Shop.Activated:Connect(function() --[[ Line: 15 ]]
			-- upvalues: v3 (ref), l_PlayerGui_0 (ref)
			guiControllerModule:Toggle(playerGui.Shop_UI);
		end);
	end
};
task.spawn(shopButtonController.Start, shopButtonController);
return shopButtonController;