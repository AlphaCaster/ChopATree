-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "notify", 
    Aliases = {
        "not"
    }, 
    Description = "Notify player(s) with a specific message.", 
    Group = "GameCommands", 
    Args = {
        {
            Type = "players", 
            Name = "to", 
            Description = "The player(s) to clear inventory."
        }, 
        {
            Type = "string", 
            Name = "Message", 
            Description = "Message to send to player(s)."
        }
    }
};