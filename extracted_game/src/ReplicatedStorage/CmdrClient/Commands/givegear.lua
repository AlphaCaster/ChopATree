-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "givegear", 
    Aliases = {
        "gg"
    }, 
    Description = "Gives gear to specified player(s) with a specified amount.", 
    Group = "GameCommands", 
    Args = {
        {
            Type = "players", 
            Name = "to", 
            Description = "The player(s) to give gear to."
        }, 
        {
            Type = "gearname", 
            Name = "gearname(s)", 
            Description = "The gear to give."
        }, 
        {
            Type = "integer", 
            Name = "quantity", 
            Description = "The amount given.", 
            Optional = true
        }
    }
};