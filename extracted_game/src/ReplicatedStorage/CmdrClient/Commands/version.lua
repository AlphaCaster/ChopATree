-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "version", 
    Args = {}, 
    Description = "Shows the current version of Cmdr", 
    Group = "DefaultDebug", 
    Run = function() --[[ Line: 9 ]] --[[ Name: Run ]]
        return ("Cmdr Version %s"):format("v1.12.0");
    end
};