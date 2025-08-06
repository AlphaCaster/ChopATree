-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
local _ = require(l_ReplicatedStorage_0.Modules.CollectController);
require(l_ReplicatedStorage_0.Modules.EffectController):Init(l_LocalPlayer_0);
l_ReplicatedStorage_0.GameEvents.PlayerInit:FireServer()