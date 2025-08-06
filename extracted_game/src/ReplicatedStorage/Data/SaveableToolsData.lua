-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    DefaultData = {
        Trowel = {
            Uses = 5
        }, 
        ["Watering Can"] = {
            Uses = 10
        }, 
        ["Lightning Rod"] = {}, 
        Sprinkler = {}
    }
};
v0.GetDefaultData = function(_, v2) --[[ Line: 35 ]] --[[ Name: GetDefaultData ]]
    -- upvalues: v0 (copy)
    local v3 = v0.DefaultData[v2];
    if v3 then
        return v3;
    else
        return nil;
    end;
end;
return v0;