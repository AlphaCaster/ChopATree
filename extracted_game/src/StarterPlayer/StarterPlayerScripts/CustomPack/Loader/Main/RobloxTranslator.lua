-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_LocalizationService_0 = game:GetService("LocalizationService");
local l_PlayerGui_0 = game.Players.LocalPlayer.PlayerGui;
local _ = l_PlayerGui_0:WaitForChild("BackpackGui");
local l_Players_0 = game:GetService("Players");
local v4 = nil;
if l_Players_0.LocalPlayer == nil then
    l_Players_0:GetPropertyChangedSignal("LocalPlayer"):Wait();
end;
local v5 = nil;
local function _() --[[ Line: 18 ]] --[[ Name: getTranslator ]]
    -- upvalues: v5 (ref), l_PlayerGui_0 (copy), l_LocalizationService_0 (copy)
    if v5 == nil then
        v5 = l_PlayerGui_0.CoreScriptLocalization:GetTranslator(l_LocalizationService_0.RobloxLocaleId);
    end;
    return v5;
end;
local v7 = {};
local function _(v8) --[[ Line: 28 ]] --[[ Name: getTranslatorForLocale ]]
    -- upvalues: v7 (copy), l_PlayerGui_0 (copy)
    local v9 = v7[v8];
    if v9 then
        return v9;
    else
        v9 = l_PlayerGui_0.CoreScriptLocalization:GetTranslator(v8);
        v7[v8] = v9;
        return v9;
    end;
end;
local function _(v11, v12, v13) --[[ Line: 40 ]] --[[ Name: formatByKeyWithFallback ]]
    -- upvalues: v4 (ref)
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 41 ]]
        -- upvalues: v13 (copy), v11 (copy), v12 (copy)
        return v13:FormatByKey(v11, v12);
    end);
    if l_status_0 then
        return l_result_0;
    else
        return v4:FormatByKey(v11, v12);
    end;
end;
return {
    FormatByKey = function(_, v18, v19) --[[ Line: 54 ]] --[[ Name: FormatByKey ]]
        -- upvalues: v5 (ref), l_PlayerGui_0 (copy), l_LocalizationService_0 (copy)
        if v5 == nil then
            v5 = l_PlayerGui_0.CoreScriptLocalization:GetTranslator(l_LocalizationService_0.RobloxLocaleId);
        end;
        return v5:FormatByKey(v18, v19);
    end, 
    FormatByKeyForLocale = function(_, v21, v22, v23) --[[ Line: 62 ]] --[[ Name: FormatByKeyForLocale ]]
        -- upvalues: v7 (copy), l_PlayerGui_0 (copy)
        local v24 = v7[v22];
        local v25;
        if v24 then
            v25 = v24;
        else
            v24 = l_PlayerGui_0.CoreScriptLocalization:GetTranslator(v22);
            v7[v22] = v24;
            v25 = v24;
        end;
        return v25:FormatByKey(v21, v23);
    end
};