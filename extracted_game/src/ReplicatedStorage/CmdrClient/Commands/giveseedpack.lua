-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "giveseedpack", 
    Aliases = {
        "gsp"
    }, 
    Description = "Gives seed pack(s) to specified player(s) with a specified amount.", 
    Group = "GameCommands", 
    Args = {
        {
            Type = "players", 
            Name = "to", 
            Description = "The player(s) to give seed pack to."
        }, 
        {
            Type = "integer", 
            Name = "quantity", 
            Description = "The amount given.", 
            Optional = true
        }
    }
};