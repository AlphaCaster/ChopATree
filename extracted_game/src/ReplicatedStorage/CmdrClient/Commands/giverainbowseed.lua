-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "giverainbowseed", 
    Aliases = {
        "grs"
    }, 
    Description = "Gives a rainbow seed to specific player(s) with a specified amount.", 
    Group = "GameCommands", 
    Args = {
        {
            Type = "players", 
            Name = "to", 
            Description = "The player(s) to give seed to."
        }, 
        {
            Type = "seedname", 
            Name = "seedname(s)", 
            Description = "The Seeds to give."
        }, 
        {
            Type = "integer", 
            Name = "quantity", 
            Description = "The amount given.", 
            Optional = true
        }
    }
};