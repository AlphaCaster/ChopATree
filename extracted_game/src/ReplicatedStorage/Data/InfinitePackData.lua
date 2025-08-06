-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Modules.WeightRandom);
local v2 = {
    Free = {
        {
            Name = "50\194\162", 
            Coins = 50, 
            Chance = 0.3333333333333333, 
            Icon = "rbxassetid://111559087552483", 
            Color = Color3.new(1, 1, 0)
        }, 
        {
            Name = "100\194\162", 
            Coins = 50, 
            Chance = 0.3333333333333333, 
            Icon = "rbxassetid://84541528477238", 
            Color = Color3.new(1, 1, 0)
        }, 
        {
            Name = "Watering Can X1", 
            Coins = 25, 
            Chance = 0.3333333333333333, 
            Icon = "rbxassetid://108707176647018", 
            Color = Color3.new(0.666667, 0.666667, 0.666667)
        }
    }, 
    Paid = {
        {
            Name = "Super Seed", 
            Chance = 5, 
            Icon = "rbxassetid://119802391042790", 
            Color = Color3.new(1, 0, 0)
        }, 
        {
            Name = "Apple Seed", 
            Chance = 20, 
            Icon = "rbxassetid://128318449902634", 
            Color = Color3.new(0, 1, 0)
        }, 
        {
            Name = "500\194\162", 
            Chance = 20, 
            Icon = "rbxassetid://94889540639216", 
            Color = Color3.new(1, 1, 0)
        }, 
        {
            Name = "1,000\194\162", 
            Chance = 20, 
            Icon = "rbxassetid://123750064988458", 
            Color = Color3.new(1, 1, 0)
        }, 
        {
            Name = "2,000\194\162", 
            Chance = 20, 
            Icon = "rbxassetid://71146286015050", 
            Color = Color3.new(1, 1, 0)
        }, 
        {
            Name = "Watering Can X1", 
            Chance = 25, 
            Icon = "rbxassetid://108707176647018", 
            Color = Color3.new(0.666667, 0.666667, 0.666667)
        }, 
        {
            Name = "Watering Can X3", 
            Chance = 10, 
            Icon = "rbxassetid://70390145378562", 
            Color = Color3.new(0.666667, 0.666667, 0.666667)
        }, 
        {
            Name = "Watering Can X5", 
            Chance = 5, 
            Icon = "rbxassetid://73981405252852", 
            Color = Color3.new(0.666667, 0.666667, 0.666667)
        }, 
        {
            Name = "Watering Can X10", 
            Chance = 3, 
            Icon = "rbxassetid://106733159472445", 
            Color = Color3.new(0.666667, 0.666667, 0.666667)
        }
    }
};
local v3 = {
    {
        3250226689, 
        15
    }, 
    {
        3250227730, 
        25
    }, 
    {
        3250228324, 
        40
    }, 
    {
        3250229031, 
        70
    }, 
    {
        3250229162, 
        1e999
    }
};
local _ = game.PlaceId == 140398800602847;
return {
    Rewards = v2, 
    GetRewards = function(v5, v6) --[[ Line: 119 ]] --[[ Name: GetRewards ]]
        -- upvalues: v1 (copy), v3 (copy), v2 (copy)
        local v7 = false;
        local v8 = table.create(v6);
        local v9 = Random.new(v5);
        for v10 = 1, v6 do
            local l_array_0 = v1.array;
            local v12;
            if v10 == 1 then
                v12 = 0;
            elseif v10 ~= 2 and math.max(v10 - 2, 0) % 5 ~= 0 then
                v12 = 0;
            else
                for _, v14 in v3 do
                    if v10 < v14[2] then
                        v12 = v14[1];
                        v7 = true;
                    end;
                    if v7 then
                        break;
                    end;
                end;
                if not v7 then
                    v12 = 0;
                end;
            end;
            v7 = false;
            v8[v10] = l_array_0(if v12 == 0 then v2.Free else v2.Paid, v9);
        end;
        return v8;
    end, 
    GetProductFor = function(v15) --[[ Line: 99 ]] --[[ Name: GetProductFor ]]
        -- upvalues: v3 (copy)
        if v15 == 1 then
            return 0;
        elseif v15 ~= 2 and math.max(v15 - 2, 0) % 5 ~= 0 then
            return 0;
        else
            for _, v17 in v3 do
                if v15 < v17[2] then
                    return v17[1];
                end;
            end;
            return 0;
        end;
    end
};