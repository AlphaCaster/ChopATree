-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local _ = game:GetService("RunService");
local l_TravellingMerchant_Shop_0 = game.Players.LocalPlayer.PlayerGui:WaitForChild("TravellingMerchant_Shop");
local _ = require(l_ReplicatedStorage_0.Modules.GuiController);
local _ = require(l_ReplicatedStorage_0.Modules.DataService);
local _ = require(l_ReplicatedStorage_0.Comma_Module);
local v7 = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Modules.FastTween);
local _ = require(l_ReplicatedStorage_0.Data.TravellingShopConfigData);
local _ = require(l_ReplicatedStorage_0.Item_Module);
local _ = require(l_ReplicatedStorage_0.Modules.DumpTable);
local _ = require(l_ReplicatedStorage_0.Modules.MarketController);
local _ = require(l_ReplicatedStorage_0.Modules.GiftController);
local _ = v7.new();
local l_ScrollingFrame_0 = l_TravellingMerchant_Shop_0:WaitForChild("Frame"):WaitForChild("ScrollingFrame");
local _ = l_TravellingMerchant_Shop_0:WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("Timer");
l_ScrollingFrame_0:WaitForChild("ItemFrame").Parent = script;
l_ScrollingFrame_0:WaitForChild("ItemPadding").Parent = l_ScrollingFrame_0;
local _ = require(game.ReplicatedStorage.Data.TravellingShopData);
local _ = {};
return {};