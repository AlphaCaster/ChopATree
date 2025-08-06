-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local localPlayer = game:GetService("Players").LocalPlayer;
local _ = {};
local objectsToRemoveList = {
	workspace.NPCS:WaitForChild("Gear Stands", 5), 
	workspace.MapDecorations:WaitForChild("QuestSign", 5), 
	workspace.MapDecorations:WaitForChild("GearShopSign", 5), 
	workspace.NPCS:WaitForChild("Raphael", 5), 
	workspace.NPCS:WaitForChild("Eloise", 5), 
	workspace.NPCS:WaitForChild("Quest Stand", 5)
};
local function handleFTUE() --[[ Line: 16 ]] --[[ Name: HandleFTUE ]]
	-- upvalues: l_LocalPlayer_0 (copy), v2 (copy)
	if localPlayer:GetAttribute("FirstTimePlayer") then
		for _, objectToRemove in objectsToRemoveList do
			objectToRemove.Parent = nil;
		end;
	end;
end;
task.spawn(handleFTUE);
localPlayer:GetAttributeChangedSignal("FirstTimePlayer"):Connect(handleFTUE);
return {};