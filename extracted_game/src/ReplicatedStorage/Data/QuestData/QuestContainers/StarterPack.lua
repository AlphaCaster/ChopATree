-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
--local _ = require(l_ReplicatedStorage_0.Data.QuestData.Types);
local v2 = require(l_ReplicatedStorage_0.Data.QuestData.Quests);
local _ = require(l_ReplicatedStorage_0.Data.QuestData.QuestRewards);
return {
    Type = "StarterPack", 
    Display = function(_) --[[ Line: 13 ]] --[[ Name: Display ]]
        return "Stater Pack Plant Logic";
    end, 
    Generate = function(_) --[[ Line: 17 ]] --[[ Name: Generate ]]
        -- upvalues: v2 (copy)
        return {
            Quests = {
                v2.Plant:Use({
                    Target = 2, 
                    Arguments = {
                        "Tomato"
                    }
                })
            }, 
            Rewards = {}
        };
    end
};