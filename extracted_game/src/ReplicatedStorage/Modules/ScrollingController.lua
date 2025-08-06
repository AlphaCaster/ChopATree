-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local _ = game:GetService("SoundService");
local _ = game:GetService("Players");
local observersModule = require(replicatedStorageService.Modules.Observers);
local automaticScrollBarThicknessHandler = {
	Start = function(_) --[[ Line: 10 ]] --[[ Name: Start ]]
		-- upvalues: v3 (copy)
		observersModule.observeTag("AutomaticScrollBarThickness", function(scrollingFrame) --[[ Line: 11 ]]
			if not scrollingFrame:IsA("ScrollingFrame") then
				return nil;
			else
				local scrollBarUpdateTask = nil;
				local function updateScrollBarThickness() --[[ Line: 17 ]] --[[ Name: update ]]
					-- upvalues: v6 (ref), v5 (copy)
					if scrollBarUpdateTask and coroutine.status(scrollBarUpdateTask) == "suspended" then
						pcall(task.cancel, scrollBarUpdateTask);
					end;
					scrollBarUpdateTask = task.delay(0.15, function() --[[ Line: 22 ]]
						-- upvalues: v5 (ref), v6 (ref)
						local scrollingFrameParent = scrollingFrame.Parent;
						if not scrollingFrameParent or not scrollingFrameParent:IsA("GuiObject") then
							return;
						else
							scrollingFrame.ScrollBarThickness = scrollingFrameParent.AbsoluteSize.X * 0.025;
							scrollBarUpdateTask = nil;
							return;
						end;
					end);
				end;
				local absoluteSizeChangedConnection = scrollingFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateScrollBarThickness);
				task.spawn(updateScrollBarThickness);
				return function() --[[ Line: 37 ]]
					-- upvalues: v9 (copy)
					absoluteSizeChangedConnection:Disconnect();
				end;
			end;
		end);
	end
};
task.spawn(automaticScrollBarThicknessHandler.Start, automaticScrollBarThicknessHandler);
return automaticScrollBarThicknessHandler;