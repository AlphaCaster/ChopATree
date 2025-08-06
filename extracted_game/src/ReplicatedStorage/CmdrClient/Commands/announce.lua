-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "announce", 
    Aliases = {
        "m"
    }, 
    Description = "Makes a server-wide announcement.", 
    Group = "DefaultAdmin", 
    Args = {
        {
            Type = "string", 
            Name = "text", 
            Description = "The announcement text."
        }
    }
};