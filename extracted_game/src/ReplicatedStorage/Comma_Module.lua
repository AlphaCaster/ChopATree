-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Comma = function(v0) --[[ Line: 2 ]] --[[ Name: Comma ]]
        local l_v0_0 = v0;
        local _ = nil;
        repeat
            local v3, v4 = string.gsub(l_v0_0, "^(-?%d+)(%d%d%d)", "%1,%2");
            l_v0_0 = v3;
        until v4 == 0;
        return l_v0_0;
    end
};