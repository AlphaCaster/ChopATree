if (true) then -- disabled
	return function()
		
	end
end

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ServerScriptService_0 = game:GetService("ServerScriptService");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Item_Module);
local v5 = require(l_ReplicatedStorage_0.Modules.PetServices.PetUtilities);
local v6 = require(l_ReplicatedStorage_0.Data.PetRegistry);
local v7 = require(l_ReplicatedStorage_0.Modules.NumberUtil);
local v8 = l_RunService_0:IsServer() and require(l_ServerScriptService_0.Modules.PetsServices.PetsService);
local v9 = l_RunService_0:IsClient() and require(l_ReplicatedStorage_0.Modules.DataService);
return function(v10) --[[ Line: 14 ]] --[[ Name: CalculatePetValue ]]
	-- upvalues: l_Players_0 (copy), l_RunService_0 (copy), v8 (copy), v9 (copy), v6 (copy), v7 (copy), v5 (copy)
	if not v10 then
		warn("CalculatePetValue | No Pet Tool given!");
		return 0;
	else
		local l_v10_FirstAncestorWhichIsA_0 = v10:FindFirstAncestorWhichIsA("Model");
		local l_l_Players_0_PlayerFromCharacter_0 = l_Players_0:GetPlayerFromCharacter(l_v10_FirstAncestorWhichIsA_0);
		if not l_l_Players_0_PlayerFromCharacter_0 then
			warn("CalculatePetValue | No Player Ancestor found!");
			return 0;
		else
			local l_v10_Attribute_0 = v10:GetAttribute("ItemType");
			if not l_v10_Attribute_0 or l_v10_Attribute_0 ~= "Pet" then
				warn("CalculatePetValue | ItemType attribute not \"Pet\"!");
			end;
			local l_v10_Attribute_1 = v10:GetAttribute("PET_UUID");
			if not l_v10_Attribute_1 then
				warn("CalculatePetValue | No UUID!");
				return 0;
			else
				local v15 = if l_RunService_0:IsServer() then v8:GetPlayerPetData(l_l_Players_0_PlayerFromCharacter_0, l_v10_Attribute_1) else v9:GetData().PetsData.PetInventory.Data[l_v10_Attribute_1];
				if not v15 then
					warn("CalculatePetValue | No pet data found!");
					return 0;
				else
					local l_HatchedFrom_0 = v15.PetData.HatchedFrom;
					print(l_HatchedFrom_0);
					if not l_HatchedFrom_0 or l_HatchedFrom_0 == "" then
						warn("CalculatePetValue | No HatchedFrom value!");
						return 0;
					else
						local v17 = v6.PetEggs[l_HatchedFrom_0];
						if not v17 then
							warn("CalculatePetValue | No egg data found!");
							return 0;
						else
							local v18 = v17.RarityData.Items[v15.PetType];
							if not v18 then
								warn("CalculatePetValue | No pet data in egg!");
								return 0;
							else
								local l_WeightRange_0 = v18.GeneratedPetData.WeightRange;
								if not l_WeightRange_0 then
									warn("CalculatePetValue | No WeightRange found!");
									return 0;
								else
									local v20 = math.lerp(0.8, 1.2, (v7.ReverseLerp(l_WeightRange_0[1], l_WeightRange_0[2], v15.PetData.BaseWeight))) * math.lerp(0.15, 6, (v5:GetLevelProgress(v15.PetData.Level)));
									return (math.floor(v6.PetList[v15.PetType].SellPrice * v20));
								end;
							end;
						end;
					end;
				end;
			end;
		end;
	end;
end;