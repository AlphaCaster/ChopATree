-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "fetch", 
    Aliases = {}, 
    Description = "Fetch a value from the Internet", 
    Group = "DefaultDebug", 
    Args = {
        {
            Type = "url", 
            Name = "URL", 
            Description = "The URL to fetch."
        }
    }
};