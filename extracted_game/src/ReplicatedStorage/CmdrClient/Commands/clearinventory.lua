-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "clearinventory", 
    Aliases = {
        "ci"
    }, 
    Description = "Clears the specified player(s) inventory.", 
    Group = "GameCommands", 
    Args = {
        {
            Type = "players", 
            Name = "to", 
            Description = "The player(s) to clear inventory."
        }
    }
};