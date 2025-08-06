-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TextChatService_0 = game:GetService("TextChatService");
local _ = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local l_UserService_0 = game:GetService("UserService");
local v4 = {
    RankMap = {
        [255] = "<font color=\"rgb(255,80,80)\"><b>[OWNER]</b></font> %s", 
        [254] = "<font color=\"rgb(255,165,00)\"><b>[OWNER]</b></font> %s", 
        [200] = "<font color=\"rgb(255,165,00)\"><b>[DEV]</b></font> %s", 
        [7] = "<font color=\"rgb(255,165,00)\"><b>[QA-LEAD]</b></font> %s", 
        [3] = "<font color=\"rgb(255,165,00)\"><b>[TESTER]</b></font> %s"
    }, 
    AnnouncementFormat = "<font color=\"rgb(255,165,0)\"><b>%s:</b> %s</font>"
};
l_TextChatService_0.OnIncomingMessage = function(v5) --[[ Line: 21 ]]
    -- upvalues: l_Players_0 (copy), v4 (copy), l_UserService_0 (copy)
    local l_TextChatMessageProperties_0 = Instance.new("TextChatMessageProperties");
    local l_TextSource_0 = v5.TextSource;
    local _ = v5.Text;
    local v9 = v5.TextSource and v5.TextSource.UserId;
    local v10 = v9 and l_Players_0:GetPlayerByUserId(v9);
    if v10 then
        if v10 then
			local _ = v4.RankMap[v10:GetRankInGroup(35872422)];
        end;
        if l_TextSource_0 then
            local v12 = l_UserService_0:GetUserInfosByUserIdsAsync({
                v5.TextSource.UserId
            })[1];
            if not v12 then
                return;
            else
                local l_l_Players_0_PlayerByUserId_0 = l_Players_0:GetPlayerByUserId(v5.TextSource.UserId);
                if not l_l_Players_0_PlayerByUserId_0 then
                    return;
                else
					local v14 = v4.RankMap[l_l_Players_0_PlayerByUserId_0:GetRankInGroup(35872422)];
					local finalStr = ("%*%*"):format(v14 and v14:format(l_l_Players_0_PlayerByUserId_0.DisplayName) or l_l_Players_0_PlayerByUserId_0.DisplayName, v12.HasVerifiedBadge and "\238\128\128" or "");
					if l_l_Players_0_PlayerByUserId_0:GetAttribute("VIP") then
						finalStr = "<font color=\"rgb(255, 255, 0)\"><b>[VIP]</b></font> "..finalStr
					end
					v5.PrefixText = finalStr
                end;
            end;
        end;
    end;
    return l_TextChatMessageProperties_0;
end;