-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v2 = {
    StipFlavourText = function(_, v1) --[[ Line: 4 ]] --[[ Name: StipFlavourText ]]
        if not v1 or v1 == "" then
            warn("StringUtils:StipFlavourText | No item name passed!");
            return "";
        else
            return (v1:gsub("%b[]", ""):gsub("^%s*(.-)%s*$", "%1"));
        end;
    end
};
v2.FormatGearName = function(_, v4) --[[ Line: 16 ]] --[[ Name: FormatGearName ]]
    -- upvalues: v2 (copy)
    if not v4 or v4 == "" then
        warn("StringUtils:FormatGearName | No gear name passed!");
        return "";
    else
        return (v2:StipFlavourText(v4):gsub("%s+", ""):gsub("(%u)", " %1"):gsub("^%s+", ""));
    end;
end;
return v2;