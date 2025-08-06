-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Name = "run", 
    Aliases = {
        ">"
    }, 
    AutoExec = {
        "alias \"discard|Run a command and discard the output.\" replace ${run $1} .* \\\"\\\""
    }, 
    Description = "Runs a given command string (replacing embedded commands).", 
    Group = "DefaultUtil", 
    Args = {
        {
            Type = "string", 
            Name = "Command", 
            Description = "The command string to run"
        }
    }, 
    Run = function(v0, v1) --[[ Line: 17 ]] --[[ Name: Run ]]
        return v0.Cmdr.Util.RunCommandString(v0.Dispatcher, v1);
    end
};