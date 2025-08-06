-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Item_Module);
local v2 = require(l_ReplicatedStorage_0.Data.GearData);
local v4 = {
    ["Open 1 - Exotic Seed Pack"] = {
        GiftId = 3269033223, 
        NormalId = 3267528421, 
        Display = "1 Exotic Seed Pack"
    }, 
    ["Open 3 - Exotic Seed Pack"] = {
        GiftId = 3269033336, 
        NormalId = 3267548052, 
        Display = "3 Exotic Seed Packs"
    }, 
    ["Open 10 - Exotic Seed Pack"] = {
        GiftId = 3269033529, 
        NormalId = 3267548161, 
        Display = "10 Exotic Seed Packs"
    }, 
    ["10 Premium Seed Sacks"] = {
        GiftId = 3273679009, 
        NormalId = 3273679012, 
        Display = "10 Premium Seed Sacks"
    }, 
    ["Sheckles 1"] = {
        GiftId = 3269363716, 
        NormalId = 3250137172, 
        Display = "100\194\162"
    }, 
    ["Sheckles 2"] = {
        GiftId = 3269364749, 
        NormalId = 3250137261, 
        Display = "250\194\162"
    }, 
    ["Sheckles 3"] = {
        GiftId = 3269364968, 
        NormalId = 3250137355, 
        Display = "1,000\194\162"
    }, 
    ["Sheckles 4"] = {
        GiftId = 3269365441, 
        NormalId = 3250139018, 
        Display = "5,000\194\162"
    }
};
for _, v6 in v1.Return_All_Seeds() do
    if v6[8] and v6[5] then
        v4[("Seed-%*"):format(v6[1])] = {
            GiftId = v6[8], 
            NormalId = v6[5], 
            Display = v6[1]
        };
    end;
end;
for v7, v8 in v2 do
    if v8.GiftPurchaseID and v8.PurchaseID then
        v4[("Gear-%*"):format(v7)] = {
            GiftId = v8.GiftPurchaseID, 
            NormalId = v8.PurchaseID, 
            Display = v8.GearName
        };
    end;
end;
return v4;