-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return function(v0, v1, v2) --[[ Line: 1 ]] --[[ Name: TwoPointRaycast ]]
    local l_Magnitude_0 = (v0 - v1).Magnitude;
    local v4 = CFrame.lookAt(v0, v1).LookVector * l_Magnitude_0;
    return (workspace:Raycast(v0, v4, v2));
end;