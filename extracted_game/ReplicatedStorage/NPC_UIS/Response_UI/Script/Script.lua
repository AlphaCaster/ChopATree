-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(game.ReplicatedStorage.Top_Text);
task.wait(math.random(8, 12) * 0.2);
if script and script.Parent and script.Parent ~= nil then
    v0.TakeAwayResponses(script.Parent.Parent.Parent, game.Players.LocalPlayer);
end;