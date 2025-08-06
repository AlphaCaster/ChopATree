-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

while script:IsDescendantOf(game) do
    task.wait(2);
    script.Parent.Scale = 0.9;
    task.wait(math.random(2, 3) * 0.1);
    script.Parent.Scale = 1;
end;