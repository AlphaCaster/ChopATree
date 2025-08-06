-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local tweenService = game:GetService("TweenService");
return function(instance, tweenInfo, tweenProperties, shouldPlay) --[[ Line: 4 ]]
	-- upvalues: l_TweenService_0 (copy)
	shouldPlay = shouldPlay ~= false;
	local tween = tweenService:Create(instance, tweenInfo, tweenProperties);
	tween.Completed:Once(function() --[[ Line: 8 ]]
		-- upvalues: v5 (copy)
		tween:Destroy();
	end);
	if shouldPlay then
		tween:Play();
	end;
	return tween;
end;