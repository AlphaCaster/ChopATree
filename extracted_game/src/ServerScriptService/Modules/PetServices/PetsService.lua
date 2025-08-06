-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_PetsService_0 = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PetsService");
v0.EquipPet = function(_, v3) --[[ Line: 8 ]] --[[ Name: EquipPet ]]
    -- upvalues: l_PetsService_0 (copy)
    l_PetsService_0:FireServer("EquipPet", v3);
end;
v0.UnequipPet = function(_, v5) --[[ Line: 12 ]] --[[ Name: UnequipPet ]]
    -- upvalues: l_PetsService_0 (copy)
    l_PetsService_0:FireServer("UnequipPet", v5);
end;
return v0;