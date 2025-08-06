-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "kill", 
    Aliases = {
        "slay"
    }, 
    Description = "Kills a player or set of players.", 
    Group = "DefaultAdmin", 
    Args = {
        {
            Type = "players", 
            Name = "victims", 
            Description = "The players to kill."
        }
    }
};