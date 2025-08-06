-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(maxRetries, retryDelay, functionToCall, ...) --[[ Line: 2 ]]
	local success = {
		false
	};
	for _ = 1, maxRetries do
		success = {
			pcall(functionToCall, ...)
		};
		if not success[1] then
			task.wait(retryDelay);
		else
			break;
		end;
	end;
	return table.unpack(success);
end;