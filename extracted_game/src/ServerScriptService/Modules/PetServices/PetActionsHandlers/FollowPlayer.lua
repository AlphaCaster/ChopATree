-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Modules.PetServices.ActivePetsService);
return function(v2) --[[ Line: 5 ]]
    -- upvalues: v1 (copy)
    v1:SetPetState(v2:GetAttribute("UUID"), "FollowPlayer");
end;