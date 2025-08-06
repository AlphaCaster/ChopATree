-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local isStudio = game:GetService("RunService"):IsStudio();
return function() --[[ Line: 6 ]]
	-- upvalues: v0 (copy)
	local isStudioMode = true;
	if game.GameId ~= 7500518143 then
		isStudioMode = isStudio;
	end;
	return isStudioMode;
end;