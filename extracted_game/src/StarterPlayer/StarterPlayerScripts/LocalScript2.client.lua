-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = nil;
task.spawn(function() --[[ Line: 2 ]]
    -- upvalues: v0 (ref)
    while true do
        task.wait(1);
        xpcall(function() --[[ Line: 6 ]]
            return game:________SKIBIDI_TOILET();
        end, function() --[[ Line: 8 ]]
            -- upvalues: v0 (ref)
            local v1 = debug.info(2, "f");
            if not v0 then
                v0 = v1;
            end;
            if v1 ~= v0 then
                while true do

                end;
            end;
        end);
    end;
end);