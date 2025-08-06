-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "sendmessage", 
    Aliases = {
        "sm"
    }, 
    Description = "Send a specific message to specified player(s) in chat.", 
    Group = "GameCommands", 
    Args = {
        {
            Type = "players", 
            Name = "to", 
            Description = "The player(s) to send message."
        }, 
        {
            Type = "string", 
            Name = "Message", 
            Description = "Message to send to player(s)."
        }
    }
};