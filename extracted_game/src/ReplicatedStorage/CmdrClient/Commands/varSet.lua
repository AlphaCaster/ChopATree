-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "var=", 
    Aliases = {}, 
    Description = "Sets a stored value.", 
    Group = "DefaultUtil", 
    Args = {
        {
            Type = "storedKey", 
            Name = "Key", 
            Description = "The key to set, saved in your user data store. Keys prefixed with . are not saved. Keys prefixed with $ are game-wide. Keys prefixed with $. are game-wide and non-saved."
        }, 
        {
            Type = "string", 
            Name = "Value", 
            Description = "Value or values to set.", 
            Default = ""
        }
    }, 
    ClientRun = function(v0, v1) --[[ Line: 20 ]] --[[ Name: ClientRun ]]
        v0:GetStore("vars_used")[v1] = true;
    end
};