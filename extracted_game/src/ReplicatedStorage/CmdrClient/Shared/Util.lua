-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TextService_0 = game:GetService("TextService");
local v7 = {
    MakeDictionary = function(v1) --[[ Line: 6 ]] --[[ Name: MakeDictionary ]]
        local v2 = {};
        for v3 = 1, #v1 do
            v2[v1[v3]] = true;
        end;
        return v2;
    end, 
    DictionaryKeys = function(v4) --[[ Line: 17 ]] --[[ Name: DictionaryKeys ]]
        local v5 = {};
        for v6 in pairs(v4) do
            table.insert(v5, v6);
        end;
        return v5;
    end
};
local function _(v8) --[[ Line: 28 ]] --[[ Name: transformInstanceSet ]]
    local v9 = {};
    for v10 = 1, #v8 do
        v9[v10] = v8[v10].Name;
    end;
    return v9, v8;
end;
v7.MakeFuzzyFinder = function(v12) --[[ Line: 42 ]] --[[ Name: MakeFuzzyFinder ]]
    local v13 = nil;
    local v14 = {};
    if typeof(v12) == "Enum" then
        v12 = v12:GetEnumItems();
    end;
    if typeof(v12) == "Instance" then
        local l_v12_Children_0 = v12:GetChildren();
        local v16 = {};
        for v17 = 1, #l_v12_Children_0 do
            v16[v17] = l_v12_Children_0[v17].Name;
        end;
        local l_v16_0 = v16;
        local l_l_v12_Children_0_0 = l_v12_Children_0;
        v13 = l_v16_0;
        v14 = l_l_v12_Children_0_0;
    elseif typeof(v12) == "table" then
        if typeof(v12[1]) == "Instance" or typeof(v12[1]) == "EnumItem" or typeof(v12[1]) == "table" and typeof(v12[1].Name) == "string" then
            local l_v12_0 = v12;
            local v21 = {};
            for v22 = 1, #l_v12_0 do
                v21[v22] = l_v12_0[v22].Name;
            end;
            local l_v21_0 = v21;
            local l_l_v12_0_0 = l_v12_0;
            v13 = l_v21_0;
            v14 = l_l_v12_0_0;
        elseif type(v12[1]) == "string" then
            v13 = v12;
        elseif v12[1] ~= nil then
            error("MakeFuzzyFinder only accepts tables of instances or strings.");
        else
            v13 = {};
        end;
    else
        error("MakeFuzzyFinder only accepts a table, Enum, or Instance.");
    end;
    return function(v25, v26) --[[ Line: 70 ]]
        -- upvalues: v13 (ref), v14 (ref)
        local v27 = {};
        for v28, v29 in pairs(v13) do
            local v30 = v14 and v14[v28] or v29;
            if v29:lower() == v25:lower() then
                if v26 then
                    return v30;
                else
                    table.insert(v27, 1, v30);
                end;
            elseif v29:lower():find(v25:lower(), 1, true) then
                v27[#v27 + 1] = v30;
            end;
        end;
        if v26 then
            return v27[1];
        else
            return v27;
        end;
    end;
end;
v7.GetNames = function(v31) --[[ Line: 98 ]] --[[ Name: GetNames ]]
    local v32 = {};
    for v33 = 1, #v31 do
        v32[v33] = v31[v33].Name or tostring(v31[v33]);
    end;
    return v32;
end;
v7.SplitStringSimple = function(v34, v35) --[[ Line: 109 ]] --[[ Name: SplitStringSimple ]]
    if v35 == nil then
        v35 = "%s";
    end;
    local v36 = {};
    local v37 = 1;
    for v38 in string.gmatch(v34, "([^" .. v35 .. "]+)") do
        v36[v37] = v38;
        v37 = v37 + 1;
    end;
    return v36;
end;
local function v40(v39) --[[ Line: 122 ]] --[[ Name: charCode ]]
    return utf8.char((tonumber(v39, 16)));
end;
v7.ParseEscapeSequences = function(v41) --[[ Line: 127 ]] --[[ Name: ParseEscapeSequences ]]
    -- upvalues: v40 (copy)
    return v41:gsub("\\(.)", {
        t = "\t", 
        n = "\n"
    }):gsub("\\u(%x%x%x%x)", v40):gsub("\\x(%x%x)", v40);
end;
v7.EncodeEscapedOperator = function(v42, v43) --[[ Line: 136 ]] --[[ Name: EncodeEscapedOperator ]]
    local v44 = v43:sub(1, 1);
    local v45 = v43:gsub(".", "%%%1");
    return v42:gsub("(" .. ("%" .. v44) .. "+)(" .. v45 .. ")", function(v46, v47) --[[ Line: 141 ]]
        return (v46:sub(1, #v46 - 1) .. v47):gsub(".", function(v48) --[[ Line: 142 ]]
            return "\\u" .. string.format("%04x", string.byte(v48), 16);
        end);
    end);
end;
local v49 = {
    "&&", 
    "||", 
    ";"
};
v7.EncodeEscapedOperators = function(v50) --[[ Line: 149 ]] --[[ Name: EncodeEscapedOperators ]]
    -- upvalues: v49 (copy), v7 (copy)
    for _, v52 in ipairs(v49) do
        v50 = v7.EncodeEscapedOperator(v50, v52);
    end;
    return v50;
end;
local function _(v53) --[[ Line: 157 ]] --[[ Name: encodeControlChars ]]
    return (v53:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___"));
end;
local function _(v55) --[[ Line: 167 ]] --[[ Name: decodeControlChars ]]
    return (v55:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n"));
end;
v7.SplitString = function(v57, v58) --[[ Line: 177 ]] --[[ Name: SplitString ]]
    -- upvalues: v7 (copy)
    v57 = v57:gsub("\\\\", "___!CMDR_ESCAPE!___"):gsub("\\\"", "___!CMDR_QUOTE!___"):gsub("\\'", "___!CMDR_SQUOTE!___"):gsub("\\\n", "___!CMDR_NL!___");
    v58 = v58 or 1e999;
    local v59 = {};
    local v60 = nil;
    local v61 = nil;
    for v62 in v57:gmatch("[^ ]+") do
        v62 = v7.ParseEscapeSequences(v62);
        local v63 = v62:match("^(['\"])");
        local v64 = v62:match("(['\"])$");
        local v65 = v62:match("(\\*)['\"]$");
        if v63 and not v61 and not v64 then
            v60 = v62;
            v61 = v63;
        elseif v60 and v64 == v61 and #v65 % 2 == 0 then
            v62 = v60 .. " " .. v62;
            v60 = nil;
            v61 = nil;
        elseif v60 then
            v60 = v60 .. " " .. v62;
        end;
        if not v60 then
            v59[#v59 + (v58 < #v59 and 0 or 1)] = v62:gsub("^(['\"])", ""):gsub("(['\"])$", ""):gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n");
        end;
    end;
    if v60 then
        v59[#v59 + (v58 < #v59 and 0 or 1)] = v60:gsub("___!CMDR_ESCAPE!___", "\\"):gsub("___!CMDR_QUOTE!___", "\""):gsub("___!CMDR_NL!___", "\n");
    end;
    return v59;
end;
v7.MashExcessArguments = function(v66, v67) --[[ Line: 209 ]] --[[ Name: MashExcessArguments ]]
    local v68 = {};
    for v69 = 1, #v66 do
        if v67 < v69 then
            v68[v67] = ("%s %s"):format(v68[v67] or "", v66[v69]);
        else
            v68[v69] = v66[v69];
        end;
    end;
    return v68;
end;
v7.TrimString = function(v70) --[[ Line: 222 ]] --[[ Name: TrimString ]]
    local _, v72 = string.find(v70, "^%s*");
    if v72 == #v70 then
        return "";
    else
        return (string.match(v70, ".*%S", v72 + 1));
    end;
end;
v7.GetTextSize = function(v73, v74, v75) --[[ Line: 229 ]] --[[ Name: GetTextSize ]]
    -- upvalues: l_TextService_0 (copy)
    return l_TextService_0:GetTextSize(v73, v74.TextSize, v74.Font, v75 or Vector2.new(v74.AbsoluteSize.X, 0));
end;
v7.MakeEnumType = function(v76, v77) --[[ Line: 234 ]] --[[ Name: MakeEnumType ]]
    -- upvalues: v7 (copy)
    local v78 = v7.MakeFuzzyFinder(v77);
    return {
        Validate = function(v79) --[[ Line: 237 ]] --[[ Name: Validate ]]
            -- upvalues: v78 (copy), v76 (copy)
            return v78(v79, true) ~= nil, ("Value %q is not a valid %s."):format(v79, v76);
        end, 
        Autocomplete = function(v80) --[[ Line: 240 ]] --[[ Name: Autocomplete ]]
            -- upvalues: v78 (copy), v7 (ref)
            local v81 = v78(v80);
            return type(v81[1]) ~= "string" and v7.GetNames(v81) or v81;
        end, 
        Parse = function(v82) --[[ Line: 244 ]] --[[ Name: Parse ]]
            -- upvalues: v78 (copy)
            return v78(v82, true);
        end
    };
end;
v7.ParsePrefixedUnionType = function(v83, v84) --[[ Line: 251 ]] --[[ Name: ParsePrefixedUnionType ]]
    -- upvalues: v7 (copy)
    local v85 = v7.SplitStringSimple(v83);
    local v86 = {};
    for v87 = 1, #v85, 2 do
        v86[#v86 + 1] = {
            prefix = v85[v87 - 1] or "", 
            type = v85[v87]
        };
    end;
    table.sort(v86, function(v88, v89) --[[ Line: 265 ]]
        return #v88.prefix > #v89.prefix;
    end);
    for v90 = 1, #v86 do
        local v91 = v86[v90];
        if v84:sub(1, #v91.prefix) == v91.prefix then
            return v91.type, v84:sub(#v91.prefix + 1), v91.prefix;
        end;
    end;
end;
v7.MakeListableType = function(v92, v93) --[[ Line: 280 ]] --[[ Name: MakeListableType ]]
    local v94 = {
        Listable = true, 
        Transform = v92.Transform, 
        Validate = v92.Validate, 
        ValidateOnce = v92.ValidateOnce, 
        Autocomplete = v92.Autocomplete, 
        Default = v92.Default, 
        ArgumentOperatorAliases = v92.ArgumentOperatorAliases, 
        Parse = function(...) --[[ Line: 289 ]] --[[ Name: Parse ]]
            -- upvalues: v92 (copy)
            return {
                v92.Parse(...)
            };
        end
    };
    if v93 then
        for v95, v96 in pairs(v93) do
            v94[v95] = v96;
        end;
    end;
    return v94;
end;
local function _(v97) --[[ Line: 303 ]] --[[ Name: encodeCommandEscape ]]
    return (v97:gsub("\\%$", "___!CMDR_DOLLAR!___"));
end;
local function _(v99) --[[ Line: 307 ]] --[[ Name: decodeCommandEscape ]]
    return (v99:gsub("___!CMDR_DOLLAR!___", "$"));
end;
v7.RunCommandString = function(v101, v102) --[[ Line: 311 ]] --[[ Name: RunCommandString ]]
    -- upvalues: v7 (copy)
    v102 = v7.ParseEscapeSequences(v102);
    local v103 = v7.EncodeEscapedOperators(v102):split("&&");
    local v104 = "";
    for v105, v106 in ipairs(v103) do
        local v107 = v104:gsub("%$", "\\x24"):gsub("%%", "%%%%");
        v106 = v106:gsub("||", v104:find("%s") and ("%q"):format(v107) or v107);
        v104 = tostring(v101:EvaluateAndRun((v7.RunEmbeddedCommands(v101, v106))));
        if v105 == #v103 then
            return v104;
        end;
    end;
end;
v7.RunEmbeddedCommands = function(v108, v109) --[[ Line: 338 ]] --[[ Name: RunEmbeddedCommands ]]
    -- upvalues: v7 (copy)
    v109 = v109:gsub("\\%$", "___!CMDR_DOLLAR!___");
    local v110 = {};
    for v111 in v109:gmatch("$(%b{})") do
        local v112 = true;
        local v113 = v111:sub(2, #v111 - 1);
        if v113:match("^{.+}$") then
            v112 = false;
            v113 = v113:sub(2, #v113 - 1);
        end;
        v110[v111] = v7.RunCommandString(v108, v113);
        if v112 and (v110[v111]:find("%s") or v110[v111] == "") then
            v110[v111] = string.format("%q", v110[v111]);
        end;
    end;
    return (v109:gsub("$(%b{})", v110):gsub("___!CMDR_DOLLAR!___", "$"));
end;
v7.SubstituteArgs = function(v114, v115) --[[ Line: 366 ]] --[[ Name: SubstituteArgs ]]
    v114 = v114:gsub("\\%$", "___!CMDR_DOLLAR!___");
    if type(v115) == "table" then
        for v116 = 1, #v115 do
            local v117 = tostring(v116);
            v115[v117] = v115[v116];
            if v115[v117]:find("%s") then
                v115[v117] = string.format("%q", v115[v117]);
            end;
        end;
    end;
    return (v114:gsub("($%d+)%b{}", "%1"):gsub("$(%w+)", v115):gsub("___!CMDR_DOLLAR!___", "$"));
end;
v7.MakeAliasCommand = function(v118, v119) --[[ Line: 383 ]] --[[ Name: MakeAliasCommand ]]
    -- upvalues: v7 (copy)
    local v120, v121 = unpack(v118:split("|"));
    local v122 = {};
    v119 = v7.EncodeEscapedOperators(v119);
    local v123 = {};
    for v124 in v119:gmatch("$(%d+)") do
        if v123[v124] == nil then
            v123[v124] = true;
            local v125 = v119:match((("$%*(%%b{})"):format(v124)));
            local v126 = nil;
            local v127 = nil;
            local v128 = nil;
            local v129 = nil;
            if v125 then
                local v130, v131, v132 = unpack(v125:sub(2, #v125 - 1):split("|"));
                v127 = v130;
                v128 = v131;
                v129 = v132;
            end;
            v126 = v127 and not not v127:match("%?$");
            v127 = if v127 then v127:match("^%w+") else "string";
            v128 = v128 or ("Argument %*"):format(v124);
            v129 = v129 or "";
            table.insert(v122, {
                Type = v127, 
                Name = v128, 
                Description = v129, 
                Optional = v126
            });
        end;
    end;
    return {
        Name = v120, 
        Aliases = {}, 
        Description = ("<Alias> %*"):format(v121 or v119), 
        Group = "UserAlias", 
        Args = v122, 
        Run = function(v133) --[[ Line: 422 ]] --[[ Name: Run ]]
            -- upvalues: v7 (ref), v119 (ref)
            return v7.RunCommandString(v133.Dispatcher, v7.SubstituteArgs(v119, v133.RawArguments));
        end
    };
end;
v7.MakeSequenceType = function(v134) --[[ Line: 429 ]] --[[ Name: MakeSequenceType ]]
    -- upvalues: v7 (copy)
    v134 = v134 or {};
    local v135 = true;
    if v134.Parse == nil then
        v135 = v134.Constructor ~= nil;
    end;
    assert(v135, "MakeSequenceType: Must provide one of: Constructor, Parse");
    v134.TransformEach = v134.TransformEach or function(...) --[[ Line: 434 ]]
        return ...;
    end;
    v134.ValidateEach = v134.ValidateEach or function() --[[ Line: 438 ]]
        return true;
    end;
    return {
        Prefixes = v134.Prefixes, 
        Transform = function(v136) --[[ Line: 445 ]] --[[ Name: Transform ]]
            -- upvalues: v7 (ref), v134 (ref)
            return v7.Map(v7.SplitPrioritizedDelimeter(v136, {
                ",", 
                "%s"
            }), function(v137) --[[ Line: 446 ]]
                -- upvalues: v134 (ref)
                return v134.TransformEach(v137);
            end);
        end, 
        Validate = function(v138) --[[ Line: 451 ]] --[[ Name: Validate ]]
            -- upvalues: v134 (ref)
            if v134.Length and #v138 > v134.Length then
                return false, ("Maximum of %d values allowed in sequence"):format(v134.Length);
            else
                local v139 = 1;
                local v140 = v134.Length or #v138;
                for v141 = v139, v140 do
                    local v142, v143 = v134.ValidateEach(v138[v141], v141);
                    if not v142 then
                        return false, v143;
                    end;
                end;
                return true;
            end;
        end, 
        Parse = v134.Parse or function(v144) --[[ Line: 467 ]]
            -- upvalues: v134 (ref)
            return v134.Constructor(unpack(v144));
        end
    };
end;
v7.SplitPrioritizedDelimeter = function(v145, v146) --[[ Line: 475 ]] --[[ Name: SplitPrioritizedDelimeter ]]
    -- upvalues: v7 (copy)
    for v147, v148 in ipairs(v146) do
        if v145:find(v148) or v147 == #v146 then
            return v7.SplitStringSimple(v145, v148);
        end;
    end;
end;
v7.Map = function(v149, v150) --[[ Line: 484 ]] --[[ Name: Map ]]
    local v151 = {};
    for v152, v153 in ipairs(v149) do
        v151[v152] = v150(v153, v152);
    end;
    return v151;
end;
v7.Each = function(v154, ...) --[[ Line: 495 ]] --[[ Name: Each ]]
    local v155 = {};
    for v156, v157 in ipairs({
        ...
    }) do
        v155[v156] = v154(v157);
    end;
    return unpack(v155);
end;
v7.EmulateTabstops = function(v158, v159) --[[ Line: 504 ]] --[[ Name: EmulateTabstops ]]
    local v160 = 0;
    local v161 = #v158;
    local v162 = table.create(v161);
    for v163 = 1, v161 do
        local v164 = string.sub(v158, v163, v163);
        if v164 == "\t" then
            local v165 = v159 - v160 % v159;
            table.insert(v162, string.rep(" ", v165));
            v160 = v160 + v165;
        else
            table.insert(v162, v164);
            if v164 == "\n" then
                v160 = 0;
            elseif v164 ~= "\r" then
                v160 = v160 + 1;
            end;
        end;
    end;
    return table.concat(v162);
end;
v7.Mutex = function() --[[ Line: 526 ]] --[[ Name: Mutex ]]
    local v166 = {};
    local v167 = false;
    return function() --[[ Line: 530 ]]
        -- upvalues: v167 (ref), v166 (copy)
        if v167 then
            table.insert(v166, coroutine.running());
            coroutine.yield();
        else
            v167 = true;
        end;
        return function() --[[ Line: 538 ]]
            -- upvalues: v166 (ref), v167 (ref)
            if #v166 > 0 then
                coroutine.resume(table.remove(v166, 1));
                return;
            else
                v167 = false;
                return;
            end;
        end;
    end;
end;
return v7;