-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
	autoColon = function(elapsedSeconds) --[[ Line: 3 ]] --[[ Name: autoColon ]]
		if elapsedSeconds >= 86400 then
			return string.format("%02i:%02i:%02i:%02i", elapsedSeconds / 86400, elapsedSeconds / 3600 % 24, elapsedSeconds / 60 % 60, elapsedSeconds % 60);
		elseif elapsedSeconds >= 3600 then
			return string.format("%02i:%02i:%02i", elapsedSeconds / 3600, elapsedSeconds / 60 % 60, elapsedSeconds % 60);
		else
			return string.format("%02i:%02i", elapsedSeconds / 60, elapsedSeconds % 60);
		end;
	end, 
	toHMS = function(elapsedSeconds) --[[ Line: 13 ]] --[[ Name: toHMS ]]
		return string.format("%02i:%02i:%02i", elapsedSeconds / 3600, elapsedSeconds / 60 % 60, elapsedSeconds % 60);
	end, 
	compactFormat = function(totalSeconds) --[[ Line: 17 ]] --[[ Name: compactFormat ]]
		if totalSeconds >= 86400 then
			local remainingSecondsInDay = totalSeconds % 86400 // 3600;
			return (("%*d%*"):format(totalSeconds // 86400, if v3 > 0 then (" %*h"):format(v3) else ""));
		elseif totalSeconds >= 3600 then
			local remainingSecondsInHour = totalSeconds % 3600 // 60;
			return (("%*h%*"):format(totalSeconds // 3600, if v4 > 0 then (" %*m"):format(v4) else ""));
		elseif totalSeconds >= 60 then
			local remainingSecondsInMinute = totalSeconds % 60;
			return (("%*m%*"):format(totalSeconds // 60, if v5 > 0 then (" %*s"):format(v5) else ""));
		else
			return (("%*s"):format(totalSeconds));
		end;
	end
};