-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_LocalizationService_0 = game:GetService("LocalizationService");
local l_Players_0 = game:GetService("Players");
local _ = game.Players.LocalPlayer.PlayerGui:WaitForChild("BackpackGui");
local v3 = nil;
local v4 = nil;
local v5 = nil;
local v6 = nil;
local l_BindableEvent_0 = Instance.new("BindableEvent");
local function v8() --[[ Line: 14 ]] --[[ Name: handlePlayerOrLocaleChanged ]]
    -- upvalues: v4 (ref), v5 (ref), l_BindableEvent_0 (copy)
    if v4 and v4.LocaleId ~= v5 then
        v5 = v4.LocaleId;
        l_BindableEvent_0:Fire(v5);
    end;
end;
local function _() --[[ Line: 21 ]] --[[ Name: reset ]]
    -- upvalues: v3 (ref), v4 (ref), v6 (ref)
    v3 = nil;
    v4 = nil;
    if v6 then
        v6:Disconnect();
        v6 = nil;
    end;
end;
local function _() --[[ Line: 31 ]] --[[ Name: getTranslator ]]
    -- upvalues: v3 (ref), v4 (ref), l_Players_0 (copy), l_LocalizationService_0 (copy), v5 (ref), l_BindableEvent_0 (copy), v6 (ref), v8 (copy)
    if not v3 then
        v4 = l_Players_0.LocalPlayer;
        if v4 then
            v3 = l_LocalizationService_0:GetTranslatorForPlayer(v4);
            if v4 and v4.LocaleId ~= v5 then
                v5 = v4.LocaleId;
                l_BindableEvent_0:Fire(v5);
            end;
            v6 = v4:GetPropertyChangedSignal("LocaleId"):Connect(v8);
        end;
    end;
    return v3;
end;
local v11 = {};
local function _(v12) --[[ Line: 46 ]] --[[ Name: unregisterGui ]]
    -- upvalues: v11 (copy)
    v11[v12].connection:Disconnect();
    v11[v12] = nil;
end;
local _ = function(v14, v15) --[[ Line: 51 ]] --[[ Name: makeAncestryChangedHandler ]]
    -- upvalues: v11 (copy)
    return function(_, _) --[[ Line: 52 ]]
        -- upvalues: v14 (copy), v15 (copy), v11 (ref)
        if not game:IsAncestorOf(v14) then
            if v15.hasBeenAdded then
                local l_v14_0 = v14;
                v11[l_v14_0].connection:Disconnect();
                v11[l_v14_0] = nil;
                return;
            end;
        else
            v15.hasBeenAdded = true;
        end;
    end;
end;
local function _(v20, v21, v22) --[[ Line: 63 ]] --[[ Name: updateRegistryInfo ]]
    v20.context = v21;
    v20.text = v22;
end;
local function v31(v24, v25, v26) --[[ Line: 68 ]] --[[ Name: makeRegistryInfo ]]
    -- upvalues: v11 (copy)
    local v27 = {
        hasBeenAdded = game:IsAncestorOf(v24), 
        context = v25, 
        text = v26
    };
    v27.connection = v24.AncestryChanged:Connect(function(_, _) --[[ Line: 52 ]]
        -- upvalues: v24 (copy), v27 (copy), v11 (ref)
        if not game:IsAncestorOf(v24) then
            if v27.hasBeenAdded then
                local l_v24_0 = v24;
                v11[l_v24_0].connection:Disconnect();
                v11[l_v24_0] = nil;
                return;
            end;
        else
            v27.hasBeenAdded = true;
        end;
    end);
    return v27;
end;
local function _(v32, v33, v34) --[[ Line: 76 ]] --[[ Name: registerGui ]]
    -- upvalues: v11 (copy), v31 (copy)
    if v11[v32] == nil then
        v11[v32] = v31(v32, v33, v34);
        return;
    else
        local v35 = v11[v32];
        v35.context = v33;
        v35.text = v34;
        return;
    end;
end;
local v40 = {
    LocaleChanged = l_BindableEvent_0.Event, 
    TranslateGameText = function(_, _, v39) --[[ Line: 102 ]] --[[ Name: TranslateGameText ]]
        return v39;
    end
};
local function _() --[[ Line: 115 ]] --[[ Name: retranslateAll ]]
    -- upvalues: v11 (copy), v40 (copy)
    for v41, v42 in pairs(v11) do
        v41.Text = v40:TranslateGameText(v42.context, v42.text);
    end;
end;
v40.TranslateAndRegister = function(_, _, _, v47) --[[ Line: 125 ]] --[[ Name: TranslateAndRegister ]]
    return v47;
end;
return v40;