-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "var", 
    Aliases = {}, 
    Description = "Gets a stored variable.", 
    Group = "DefaultUtil", 
    AutoExec = {
        "alias \"init-edit|Edit your initialization script\" edit ${var init} \\\\\n && var= init ||", 
        "alias \"init-run|Re-runs the initialization script manually.\" run-lines ${var init}", 
        "init-run"
    }, 
    Args = {
        {
            Type = "storedKey", 
            Name = "Key", 
            Description = "The key to get, retrieved from your user data store. Keys prefixed with . are not saved. Keys prefixed with $ are game-wide. Keys prefixed with $. are game-wide and non-saved."
        }
    }, 
    ClientRun = function(v0, v1) --[[ Line: 19 ]] --[[ Name: ClientRun ]]
        v0:GetStore("vars_used")[v1] = true;
    end
};