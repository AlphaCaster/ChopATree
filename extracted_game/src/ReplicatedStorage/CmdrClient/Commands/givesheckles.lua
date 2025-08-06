-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "givesheckles", 
    Aliases = {
        "g$"
    }, 
    Description = "Gives sheckles to specified player(s) with a specified amount.", 
    Group = "GameCommands", 
    Args = {
        {
            Type = "players", 
            Name = "to", 
            Description = "The player(s) to give sheckles to."
        }, 
        {
            Type = "integer", 
            Name = "quantity", 
            Description = "The amount given.", 
            Optional = true
        }
    }
};