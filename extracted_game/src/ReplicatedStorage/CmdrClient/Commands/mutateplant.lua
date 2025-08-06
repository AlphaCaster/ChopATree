-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "mutateplant", 
    Aliases = {
        "mp"
    }, 
    Description = "Changes specified player(s) currently held plant to a specified mutation.", 
    Group = "GameCommands", 
    Args = {
        {
            Type = "players", 
            Name = "to", 
            Description = "The player(s) to mutate held plants."
        }, 
        {
            Type = "mutation", 
            Name = "mutation", 
            Description = "The mutation type!"
        }
    }
};