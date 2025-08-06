-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
local l_CurrentBoost_0 = script.Parent.CurrentBoost;
l_LocalPlayer_0:GetAttributeChangedSignal("FriendBoost"):Connect(function() --[[ Line: 6 ]] --[[ Name: Update ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_CurrentBoost_0 (copy)
    local v2 = l_LocalPlayer_0:GetAttribute("FriendBoost") or 0;
    l_CurrentBoost_0.Visible = v2 > 0;
    l_CurrentBoost_0.Text = ("Friend Boost: +%*%%"):format((math.floor(v2 * 100)));
end);
local v3 = l_LocalPlayer_0:GetAttribute("FriendBoost") or 0;
l_CurrentBoost_0.Visible = v3 > 0;
l_CurrentBoost_0.Text = ("Friend Boost: +%*%%"):format((math.floor(v3 * 100)));