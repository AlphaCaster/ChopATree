-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
--local _ = require(l_ReplicatedStorage_0.Data.QuestData.Types);
local v2 = require(l_ReplicatedStorage_0.Data.QuestData.Quests);
local v3 = require(l_ReplicatedStorage_0.Data.QuestData.QuestRewards);
local v4 = {
    v2.Plant:Use({
        Target = 100, --100
        Arguments = {
            "Carrot"
        }
    }), 
    v2.Plant:Use({
        Target = 5, 
        Arguments = {
            "Watermelon"
        }
    }), 
    v2.Plant:Use({
        Target = 5, 
        Arguments = {
            "Pumpkin"
        }
    }), 
    v2.Harvest:Use({
        Target = 50, --50
        Arguments = {
            "Strawberry"
        }
    }), 
    v2.Harvest:Use({
        Target = 100, --100
        Arguments = {
            "Blueberry"
        }
    }), 
    v2.Harvest:Use({
        Target = 25, --25
        Arguments = {
            "Apple"
        }
    }), 
    v2.Harvest:Use({
        Target = 3, 
        Arguments = {
            "Dragon Fruit"
        }
    }), 
    v2.EarnSheckles:Use({
        Target = 25000
    })
};
local v5 = {
    v3["Sheckles"]:Use({
        Amount = 100_000
    }), 
	v3["Seed"]:Use({
		Seed = "Walking Shark",
        Amount = 5
    }), 
	v3["Seed"]:Use({
		Seed = "Candy Blossom",
		Amount = 1
	}),
	v3["Seed"]:Use({
		Seed = "Red Lollipop",
		Amount = 3
	}),
	v3["Seed"]:Use({
		Seed = "Lotus",
		Amount = 2
	}),
};
return {
    Type = "Daily", 
    Display = function(_) --[[ Line: 61 ]] --[[ Name: Display ]]
        return "Daily Quests";
    end, 
    Generate = function(_) --[[ Line: 65 ]] --[[ Name: Generate ]]
        -- upvalues: v4 (copy), v5 (copy)
        local v8 = Random.new();
        local v9 = table.create(3);
        local v10 = table.clone(v4);
        v8:Shuffle(v10);
        for v11 = 1, 3 do
            v9[v11] = table.remove(v10, 1) or v4[v8:NextInteger(1, #v4)];
        end;
        return {
            Quests = v9, 
            Rewards = {
                v5[v8:NextInteger(1, #v5)]
            }
        };
    end
};