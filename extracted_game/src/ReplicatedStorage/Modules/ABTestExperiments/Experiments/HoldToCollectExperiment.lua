-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
--local _ = require(l_ReplicatedStorage_0.Modules.ABTestExperiments.ABTestTypes);
return {
    RemoteConfig = "HoldToCollect", 
    Disabled = false, 
    DefaultState = false, 
    States = {
        [true] = {
            Client = function(v4, _) --[[ Line: 17 ]] --[[ Name: Client ]]
                -- upvalues: l_UserInputService_0 (copy), l_GuiService_0 (copy)
                if l_UserInputService_0.TouchEnabled and not l_UserInputService_0.KeyboardEnabled and not l_GuiService_0:IsTenFootInterface() then
                    v4:SetAttribute("AB_HoldToCollect", true);
                end;
            end
        }
    }
};