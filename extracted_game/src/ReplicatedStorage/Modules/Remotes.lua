-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local replicatedStorageService = game:GetService("ReplicatedStorage");
local byteNetModule = require(replicatedStorageService.Modules.ByteNet);
return {
	Crops = byteNetModule.defineNamespace("Crops", function() --[[ Line: 9 ]]
		-- upvalues: v1 (copy)
		return {
			Collect = byteNetModule.definePacket({
				value = byteNetModule.array(byteNetModule.inst)
			})
		};
	end), 
	DailyQuests = byteNetModule.defineNamespace("DailyQuests", function() --[[ Line: 17 ]]
		-- upvalues: v1 (copy)
		return {
			Claim = byteNetModule.definePacket({
				value = byteNetModule.nothing
			})
		};
	end), 
	SeedPack = byteNetModule.defineNamespace("SeedPack", function() --[[ Line: 25 ]]
		-- upvalues: v1 (copy)
		return {
			SpinFinished = byteNetModule.definePacket({
				value = byteNetModule.nothing
			}), 
			Open = byteNetModule.definePacket({
				value = byteNetModule.string
			}), 
			Result = byteNetModule.definePacket({
				value = byteNetModule.struct({
					seedPackType = byteNetModule.string, 
					resultIndex = byteNetModule.uint8
				})
			})
		};
	end), 
	InfinitePack = byteNetModule.defineNamespace("InfinitePack", function() --[[ Line: 44 ]]
		-- upvalues: v1 (copy)
		return {
			Claim = byteNetModule.definePacket({
				value = byteNetModule.nothing
			})
		};
	end), 
	Tutorial = byteNetModule.defineNamespace("Tutorial", function() --[[ Line: 52 ]]
		-- upvalues: v1 (copy)
		return {
			Start = byteNetModule.definePacket({
				value = byteNetModule.optional(byteNetModule.string)
			})
		};
	end), 
	Market = byteNetModule.defineNamespace("Market", function() --[[ Line: 60 ]]
		-- upvalues: v1 (copy)
		return {
			FakePurchase = byteNetModule.definePacket({
				value = byteNetModule.float64
			}), 
			PromptPurchase = byteNetModule.definePacket({
				value = byteNetModule.struct({
					type = byteNetModule.uint8, 
					id = byteNetModule.float64
				})
			})
		};
	end), 
	Gift = byteNetModule.defineNamespace("Gift", function() --[[ Line: 75 ]]
		-- upvalues: v1 (copy)
		return {
			SendGiftTo = byteNetModule.definePacket({
				value = byteNetModule.struct({
					productId = byteNetModule.float64, 
					targetUserId = byteNetModule.float64
				})
			}), 
			GiftPrompted = byteNetModule.definePacket({
				value = byteNetModule.nothing
			})
		};
	end)
};