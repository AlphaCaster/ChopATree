-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = require(script.Parent.ValueObjectUtils);
local l_HttpService_0 = game:GetService("HttpService");
local v3 = Random.new();
local function v11(v4, v5) --[[ Line: 36 ]] --[[ Name: Copy ]]
    if not v5 then
        return (table.clone(v4));
    else
        local function v6(v7) --[[ Line: 40 ]] --[[ Name: DeepCopy ]]
            -- upvalues: v6 (copy)
            local v8 = table.clone(v7);
            for v9, v10 in v8 do
                if type(v10) == "table" then
                    v8[v9] = v6(v10);
                end;
            end;
            return v8;
        end;
        return (v6(v4));
    end;
end;
local function v12(v13, v14) --[[ Line: 76 ]] --[[ Name: Sync ]]
    -- upvalues: v12 (copy)
    assert(type(v13) == "table", "First argument must be a table");
    assert(type(v14) == "table", "Second argument must be a table");
    local v15 = table.clone(v13);
    for v16, v17 in pairs(v15) do
        local v18 = v14[v16];
        if v18 == nil then
            v15[v16] = nil;
        elseif type(v17) ~= type(v18) then
            if type(v18) == "table" then
                local function v19(v20) --[[ Line: 40 ]] --[[ Name: DeepCopy ]]
                    -- upvalues: v19 (copy)
                    local v21 = table.clone(v20);
                    for v22, v23 in v21 do
                        if type(v23) == "table" then
                            v21[v22] = v19(v23);
                        end;
                    end;
                    return v21;
                end;
                v15[v16] = v19(v18);
            else
                v15[v16] = v18;
            end;
        elseif type(v17) == "table" then
            v15[v16] = v12(v17, v18);
        end;
    end;
    for v24, v25 in pairs(v14) do
        if v15[v24] == nil then
            if type(v25) == "table" then
                local function v26(v27) --[[ Line: 40 ]] --[[ Name: DeepCopy ]]
                    -- upvalues: v26 (copy)
                    local v28 = table.clone(v27);
                    for v29, v30 in v28 do
                        if type(v30) == "table" then
                            v28[v29] = v26(v30);
                        end;
                    end;
                    return v28;
                end;
                v15[v24] = v26(v25);
            else
                v15[v24] = v25;
            end;
        end;
    end;
    return v15;
end;
local function v31(v32, v33) --[[ Line: 145 ]] --[[ Name: Reconcile ]]
    -- upvalues: v31 (copy)
    assert(type(v32) == "table", "First argument must be a table");
    assert(type(v33) == "table", "Second argument must be a table");
    local v34 = table.clone(v32);
    for v35, v36 in v33 do
        local v37 = v32[v35];
        if v37 == nil then
            if type(v36) == "table" then
                local function v38(v39) --[[ Line: 40 ]] --[[ Name: DeepCopy ]]
                    -- upvalues: v38 (copy)
                    local v40 = table.clone(v39);
                    for v41, v42 in v40 do
                        if type(v42) == "table" then
                            v40[v41] = v38(v42);
                        end;
                    end;
                    return v40;
                end;
                v34[v35] = v38(v36);
            else
                v34[v35] = v36;
            end;
        elseif type(v37) == "table" then
            if type(v36) == "table" then
                v34[v35] = v31(v37, v36);
            else
                local function v43(v44) --[[ Line: 40 ]] --[[ Name: DeepCopy ]]
                    -- upvalues: v43 (copy)
                    local v45 = table.clone(v44);
                    for v46, v47 in v45 do
                        if type(v47) == "table" then
                            v45[v46] = v43(v47);
                        end;
                    end;
                    return v45;
                end;
                v34[v35] = v43(v37);
            end;
        end;
    end;
    return v34;
end;
local function v51(v48, v49) --[[ Line: 194 ]] --[[ Name: SwapRemove ]]
    local v50 = #v48;
    v48[v49] = v48[v50];
    v48[v50] = nil;
end;
local function v56(v52, v53) --[[ Line: 216 ]] --[[ Name: SwapRemoveFirstValue ]]
    local v54 = table.find(v52, v53);
    if v54 then
        local v55 = #v52;
        v52[v54] = v52[v55];
        v52[v55] = nil;
    end;
    return v54;
end;
local function v62(v57, v58) --[[ Line: 241 ]] --[[ Name: Map ]]
    assert(type(v57) == "table", "First argument must be a table");
    assert(type(v58) == "function", "Second argument must be a function");
    local v59 = table.create(#v57);
    for v60, v61 in v57 do
        v59[v60] = v58(v61, v60, v57);
    end;
    return v59;
end;
local function v71(v63, v64) --[[ Line: 268 ]] --[[ Name: Filter ]]
    assert(type(v63) == "table", "First argument must be a table");
    assert(type(v64) == "function", "Second argument must be a function");
    local v65 = table.create(#v63);
    if #v63 > 0 then
        local v66 = 0;
        for v67, v68 in v63 do
            if v64(v68, v67, v63) then
                v66 = v66 + 1;
                v65[v66] = v68;
            end;
        end;
        return v65;
    else
        for v69, v70 in v63 do
            if v64(v70, v69, v63) then
                v65[v69] = v70;
            end;
        end;
        return v65;
    end;
end;
local function v81(v72, v73, v74) --[[ Line: 308 ]] --[[ Name: Reduce ]]
    assert(type(v72) == "table", "First argument must be a table");
    assert(type(v73) == "function", "Second argument must be a function");
    local l_v74_0 = v74;
    if #v72 > 0 then
        local v76 = 1;
        if v74 == nil then
            l_v74_0 = v72[1];
            v76 = 2;
        end;
        for v77 = v76, #v72 do
            l_v74_0 = v73(l_v74_0, v72[v77], v77, v72);
        end;
        return l_v74_0;
    else
        local v78 = nil;
        if v74 == nil then
            l_v74_0 = next(v72);
            v78 = l_v74_0;
        end;
        for v79, v80 in next, v72, v78 do
            l_v74_0 = v73(l_v74_0, v80, v79, v72);
        end;
        return l_v74_0;
    end;
end;
local function v88(v82, ...) --[[ Line: 349 ]] --[[ Name: Assign ]]
    local v83 = table.clone(v82);
    for _, v85 in {
        ...
    } do
        for v86, v87 in v85 do
            v83[v86] = v87;
        end;
    end;
    return v83;
end;
local function v94(v89, v90) --[[ Line: 375 ]] --[[ Name: Extend ]]
    local v91 = table.clone(v89);
    for _, v93 in v90 do
        table.insert(v91, v93);
    end;
    return v91;
end;
local function v99(v95) --[[ Line: 397 ]] --[[ Name: Reverse ]]
    local v96 = #v95;
    local v97 = table.create(v96);
    for v98 = 1, v96 do
        v97[v98] = v95[v96 - v98 + 1];
    end;
    return v97;
end;
local function v108(v100, v101) --[[ Line: 421 ]] --[[ Name: Shuffle ]]
    -- upvalues: v3 (copy)
    assert(type(v100) == "table", "First argument must be a table");
    local v102 = table.clone(v100);
    local v103 = if typeof(v101) == "Random" then v101 else v3;
    for v104 = #v100, 2, -1 do
        local v105 = v103:NextInteger(1, v104);
        local v106 = v102[v105];
        local v107 = v102[v104];
        v102[v104] = v106;
        v102[v105] = v107;
    end;
    return v102;
end;
local function v120(v109, v110, v111) --[[ Line: 448 ]] --[[ Name: Sample ]]
    -- upvalues: v3 (copy)
    assert(type(v109) == "table", "First argument must be a table");
    assert(type(v110) == "number", "Second argument must be a number");
    local v112 = table.clone(v109);
    local v113 = table.create(v110);
    local v114 = if typeof(v111) == "Random" then v111 else v3;
    local v115 = #v109;
    v110 = math.clamp(v110, 1, v115);
    for v116 = 1, v110 do
        local v117 = v114:NextInteger(v116, v115);
        local v118 = v112[v117];
        local v119 = v112[v116];
        v112[v116] = v118;
        v112[v117] = v119;
    end;
    table.move(v112, 1, v110, 1, v113);
    return v113;
end;
local function v130(v121, v122) --[[ Line: 482 ]] --[[ Name: Flat ]]
    local v123 = if type(v122) == "number" then v122 else 1;
    local v124 = table.create(#v121);
    local function v125(v126, v127) --[[ Line: 485 ]] --[[ Name: Scan ]]
        -- upvalues: v123 (copy), v125 (copy), v124 (copy)
        for _, v129 in v126 do
            if type(v129) == "table" and v127 < v123 then
                v125(v129, v127 + 1);
            else
                table.insert(v124, v129);
            end;
        end;
    end;
    v125(v121, 0);
    return v124;
end;
local function v141(v131, v132) --[[ Line: 516 ]] --[[ Name: FlatMap ]]
    -- upvalues: v62 (copy)
    local v133 = v62(v131, v132);
    local v134 = table.create(#v133);
    local v135 = 1;
    local function v136(v137, v138) --[[ Line: 485 ]] --[[ Name: Scan ]]
        -- upvalues: v135 (copy), v136 (copy), v134 (copy)
        for _, v140 in v137 do
            if type(v140) == "table" and v138 < v135 then
                v136(v140, v138 + 1);
            else
                table.insert(v134, v140);
            end;
        end;
    end;
    v136(v133, 0);
    return v134;
end;
local function v145(v142) --[[ Line: 539 ]] --[[ Name: Keys ]]
    local v143 = table.create(#v142);
    for v144 in v142 do
        table.insert(v143, v144);
    end;
    return v143;
end;
local function v150(v146) --[[ Line: 566 ]] --[[ Name: Values ]]
    local v147 = table.create(#v146);
    for _, v149 in v146 do
        table.insert(v147, v149);
    end;
    return v147;
end;
local function v155(v151, v152) --[[ Line: 600 ]] --[[ Name: Find ]]
    for v153, v154 in v151 do
        if v152(v154, v153, v151) then
            return v154, v153;
        end;
    end;
    return nil, nil;
end;
local function v160(v156, v157) --[[ Line: 625 ]] --[[ Name: Every ]]
    for v158, v159 in v156 do
        if not v157(v159, v158, v156) then
            return false;
        end;
    end;
    return true;
end;
local function v165(v161, v162) --[[ Line: 650 ]] --[[ Name: Some ]]
    for v163, v164 in v161 do
        if v162(v164, v163, v161) then
            return true;
        end;
    end;
    return false;
end;
local function v169(v166, v167) --[[ Line: 674 ]] --[[ Name: Truncate ]]
    local v168 = #v166;
    v167 = math.clamp(v167, 1, v168);
    if v167 == v168 then
        return (table.clone(v166));
    else
        return (table.move(v166, 1, v167, 1, table.create(v167)));
    end;
end;
local function v185(...) --[[ Line: 703 ]] --[[ Name: Zip ]]
    assert(select("#", ...) > 0, "Must supply at least 1 table");
    local function v176(v170, v171) --[[ Line: 705 ]] --[[ Name: ZipIteratorArray ]]
        v171 = v171 + 1;
        local v172 = {};
        for v173, v174 in v170 do
            local v175 = v174[v171];
            if v175 ~= nil then
                v172[v173] = v175;
            else
                return nil, nil;
            end;
        end;
        return v171, v172;
    end;
    local function v183(v177, v178) --[[ Line: 718 ]] --[[ Name: ZipIteratorMap ]]
        local v179 = {};
        for v180, v181 in v177 do
            local v182 = next(v181, v178);
            if v182 ~= nil then
                v179[v180] = v182;
            else
                return nil, nil;
            end;
        end;
        return v178, v179;
    end;
    local v184 = {
        ...
    };
    if #v184[1] > 0 then
        return v176, v184, 0;
    else
        return v183, v184, nil;
    end;
end;
local function v191(v186) --[[ Line: 754 ]] --[[ Name: Lock ]]
    local function v187(v188) --[[ Line: 755 ]] --[[ Name: Freeze ]]
        -- upvalues: v187 (copy)
        for v189, v190 in pairs(v188) do
            if type(v190) == "table" then
                v188[v189] = v187(v190);
            end;
        end;
        return table.freeze(v188);
    end;
    return v187(v186);
end;
local function v193(v192) --[[ Line: 782 ]] --[[ Name: IsEmpty ]]
    return next(v192) == nil;
end;
local function v195(v194) --[[ Line: 793 ]] --[[ Name: EncodeJSON ]]
    -- upvalues: l_HttpService_0 (copy)
    return l_HttpService_0:JSONEncode(v194);
end;
local function v197(v196) --[[ Line: 804 ]] --[[ Name: DecodeJSON ]]
    -- upvalues: l_HttpService_0 (copy)
    return l_HttpService_0:JSONDecode(v196);
end;
local function v205(v198) --[[ Line: 808 ]] --[[ Name: ToFolder ]]
    -- upvalues: v0 (copy), v1 (copy)
    local l_Folder_0 = Instance.new("Folder");
    for v200, v201 in pairs(v198) do
        local v202 = typeof(v201);
        if v202 == "table" then
            local v203 = v0.ToFolder(v201);
            v203.Name = tostring(v200);
            v203.Parent = l_Folder_0;
        else
            local v204 = v1.ConvertTypeToClass(v202);
            v204.Value = v201;
            v204.Name = tostring(v200);
            v204.Parent = l_Folder_0;
        end;
    end;
    return l_Folder_0;
end;
local function v211(v206) --[[ Line: 828 ]] --[[ Name: ToTable ]]
    -- upvalues: v0 (copy)
    local v207 = {};
    for _, v209 in v206:GetChildren() do
        if v209:IsA("Folder") then
            local v210 = v0.ToTable(v209);
            v207[v209.Name] = v210;
        end;
    end;
    return v207;
end;
local function v217(v212) --[[ Line: 841 ]] --[[ Name: ToRawTable ]]
    -- upvalues: v0 (copy)
    local v213 = {};
    for _, v215 in ipairs(v212:GetChildren()) do
        if v215:IsA("Folder") then
            local v216 = v0.ToTable(v215);
            v213[v215.Name] = v216;
        end;
    end;
    return v213;
end;
v0.Copy = v11;
v0.Sync = v12;
v0.Reconcile = v31;
v0.SwapRemove = v51;
v0.SwapRemoveFirstValue = v56;
v0.Map = v62;
v0.Filter = v71;
v0.Reduce = v81;
v0.Assign = v88;
v0.Extend = v94;
v0.Reverse = v99;
v0.Shuffle = v108;
v0.Sample = v120;
v0.Flat = v130;
v0.FlatMap = v141;
v0.Keys = v145;
v0.Values = v150;
v0.Find = v155;
v0.Every = v160;
v0.Some = v165;
v0.Truncate = v169;
v0.Zip = v185;
v0.Lock = v191;
v0.IsEmpty = v193;
v0.EncodeJSON = v195;
v0.DecodeJSON = v197;
v0.ToFolder = v205;
v0.ToTable = v211;
v0.ToRawTable = v217;
return v0;