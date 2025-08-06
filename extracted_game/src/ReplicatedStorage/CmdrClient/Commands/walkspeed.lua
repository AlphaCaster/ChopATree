-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "walkspeed", 
    Aliases = {
        "speed"
    }, 
    Description = "Teleports a player or set of players to one target.", 
    Group = "GameCommands", 
    Args = {
        {
            Type = "players", 
            Name = "Players", 
            Description = "The players to change the speed"
        }, 
        {
            Type = "number", 
            Name = "Speed", 
            Description = "The speed to set"
        }
    }
};