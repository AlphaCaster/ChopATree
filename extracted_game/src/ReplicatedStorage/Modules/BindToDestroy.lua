-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

script.Bind.Event:Connect(function(v0, v1) --[[ Line: 2 ]]
    v0.Destroying:Once(v1);
end);
return function(v2, v3) --[[ Line: 6 ]]
    script.Bind:Fire(v2, v3);
end;