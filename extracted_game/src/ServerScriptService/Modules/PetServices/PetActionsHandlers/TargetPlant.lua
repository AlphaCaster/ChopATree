-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Modules.PetServices.ActivePetsService);
local v2 = require(l_ReplicatedStorage_0.Modules.GeneralTargettingService);
return function(v3) --[[ Line: 7 ]]
    -- upvalues: v2 (copy), v1 (copy)
    v2:CreateTargetingHandler({
        OnConfirm = function(v4) --[[ Line: 9 ]] --[[ Name: OnConfirm ]]
            -- upvalues: v1 (ref), v3 (copy)
            print("Confirmed", v4);
            v1:SetPetState(v3:GetAttribute("UUID"), "TargetPlant", {
                TargetedPlant = v4
            });
        end, 
        OnCancelled = function(...) --[[ Line: 16 ]] --[[ Name: OnCancelled ]]
            print("Cancelled");
        end, 
        TargetType = "Plant", 
        Targeter = v3
    });
end;