-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local localPlayer = game:GetService("Players").LocalPlayer;
local tutorialHandlers = {};
local abTestController = require(replicatedStorageService.Modules.ABTestController);
local remotesModule = require(replicatedStorageService.Modules.Remotes);
tutorialHandlers.Start = function(_) --[[ Line: 12 ]] --[[ Name: Start ]]
	-- upvalues: v4 (copy), v3 (copy), l_LocalPlayer_0 (copy)
	local tutorialVariantFunction = nil;
	remotesModule.Tutorial.Start.listen(function(tutorialVariantOverride, _) --[[ Line: 14 ]]
		-- upvalues: v6 (ref), v3 (ref), l_LocalPlayer_0 (ref)
		if type(tutorialVariantFunction) == "function" then
			tutorialVariantFunction();
		end;
		local loadAttempts = 10;
		while not abTestController:IsLoaded() and loadAttempts > 0 do
			loadAttempts = loadAttempts - task.wait(1);
		end;
		local tutorialVariant = tutorialVariantOverride or localPlayer:GetAttribute("AB_TutorialVariant") or "Variant1";
		local tutorialVariantScript = script.Variants:FindFirstChild(tutorialVariant) or script.Variants:FindFirstChild("Variant1");
		if not tutorialVariantScript then
			warn("No tutorial variant found to start");
			return;
		else
			tutorialVariantFunction = require(tutorialVariantScript)();
			return;
		end;
	end);
end;
task.spawn(tutorialHandlers.Start, tutorialHandlers);
return tutorialHandlers;