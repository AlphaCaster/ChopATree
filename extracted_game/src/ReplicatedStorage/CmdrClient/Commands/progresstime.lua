-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "progresstime", 
    Aliases = {
        "pt"
    }, 
    Description = "Progresses time in the server in seconds.", 
    Group = "GameCommands", 
    Args = {
        {
            Type = "player", 
            Name = "to", 
            Description = "The player(s) to progress held plants."
        }, 
        {
            Type = "integer", 
            Name = "Seconds", 
            Description = "Time time progressed.", 
            Optional = true
        }
    }
};