-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "globalnotify", 
    Aliases = {
        "gn"
    }, 
    Description = "Sends a cross server global notification to all players in the game.", 
    Group = "GameCommands", 
    Args = {
        {
            Type = "string", 
            Name = "Message", 
            Description = "Message to send to player(s)."
        }
    }
};