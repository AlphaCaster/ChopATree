-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v20 = {
    ConvertSecondsToTime = function(_, v1) --[[ Line: 3 ]] --[[ Name: ConvertSecondsToTime ]]
        local v2 = math.floor(v1 / 60);
        local v3 = v1 % 60;
        local v4 = math.floor(v2 / 60);
        local v5 = v2 % 60;
        local v6 = math.floor(v4 / 24);
        local v7 = v4 % 24;
        local v8 = math.floor(v6 / 365);
        local v9 = v6 % 365;
        local v10 = math.floor(v9 / 30);
        local v11 = v9 % 30;
        local v12 = math.floor(v8 / 10);
        local v13 = v8 % 10;
        local v14 = math.floor(v12 / 10);
        local v15 = v12 % 10;
        local v16 = math.floor(v14 / 10);
        local v17 = v14 % 10;
        local v18 = math.floor(v16 / 10);
        local v19 = v16 % 10;
        return {
            {
                Type = v18 == 1 and "Eon" or "Eons", 
                Value = if v18 == 0 then nil else v18, 
                Occupies = 1
            }, 
            {
                Type = v19 == 1 and "Millenium" or "Millenia", 
                Value = if v19 == 0 then nil else v19, 
                Occupies = 1
            }, 
            {
                Type = v17 == 1 and "Century" or "Centuries", 
                Value = if v17 == 0 then nil else v17, 
                Occupies = 1
            }, 
            {
                Type = v15 == 1 and "Decade" or "Decades", 
                Value = if v15 == 0 then nil else v15, 
                Occupies = 1
            }, 
            {
                Type = v13 == 1 and "Year" or "Years", 
                Value = if v13 == 0 then nil else v13, 
                Occupies = 1
            }, 
            {
                Type = v10 == 1 and "Month" or "Months", 
                Value = if v10 == 0 then nil else v10, 
                Occupies = 2
            }, 
            {
                Type = v11 == 1 and "Day" or "Days", 
                Value = if v11 == 0 then nil else v11, 
                Occupies = 2
            }, 
            {
                Type = v7 == 1 and "Hour" or "Hours", 
                Value = if v7 == 0 then nil else v7, 
                Occupies = 1
            }, 
            {
                Type = v5 == 1 and "Minute" or "Minutes", 
                Value = if v5 == 0 then nil else v5, 
                Occupies = 2
            }, 
            {
                Type = v3 == 1 and "Second" or "Seconds", 
                Value = if v3 == 0 then nil else v3, 
                Occupies = 2, 
                OverwriteOccupy = true
            }
        };
    end
};
v20.GenerateTextFromTime = function(_, v22) --[[ Line: 78 ]] --[[ Name: GenerateTextFromTime ]]
    -- upvalues: v20 (copy)
    v22 = v20:ConvertSecondsToTime(v22);
    local v23 = "";
    local v24 = 0;
    for v25, v26 in v22 do
        local l_Type_0 = v26.Type;
        local l_Value_0 = v26.Value;
        if l_Value_0 then
            v24 = v24 + 1;
            local v29 = v25 == #v22 - 1;
            v23 = v25 == #v22 and ("%* and %* %*"):format(v23, l_Value_0, l_Type_0) or v29 and ("%*%* %*"):format(v23, l_Value_0, l_Type_0) or ("%*%* %*, "):format(v23, l_Value_0, l_Type_0);
        end;
    end;
    return v24 == 1 and v23:sub(1, #v23 - 2) or ("%*"):format(v23);
end;
v20.GenerateColonFormatFromTime = function(_, v31) --[[ Line: 100 ]] --[[ Name: GenerateColonFormatFromTime ]]
    -- upvalues: v20 (copy)
    v31 = v20:ConvertSecondsToTime(v31);
    local v32 = "";
    local v33 = {
        "Second", 
        "Seconds", 
        "Minute", 
        "Minutes"
    };
    for v34, v35 in v31 do
        local l_Value_1 = v35.Value;
        local l_Occupies_0 = v35.Occupies;
        local l_Type_1 = v35.Type;
        local v39 = v31[v34 - 1];
        local v40 = v35.OverwriteOccupy or v39 and v39.Value;
        if table.find(v33, l_Type_1) then
            l_Value_1 = l_Value_1 or 0;
        end;
        if l_Value_1 then
            local v41 = v40 and ("%%0%*d"):format(l_Occupies_0) or "%d";
            local v42 = string.format(v41, l_Value_1);
            v32 = #v31 == v34 and ("%*%*"):format(v32, v42) or ("%*%*:"):format(v32, v42);
        end;
    end;
    return v32;
end;
return v20;