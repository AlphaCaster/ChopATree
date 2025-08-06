-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_MarketplaceService_0 = game:GetService("MarketplaceService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_PolicyService_0 = game:GetService("PolicyService");
local _ = game:GetService("SoundService");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v8 = require(l_ReplicatedStorage_0.Data.SeedData);
local v9 = require(l_ReplicatedStorage_0.Modules.MarketController);
local v10 = require(l_ReplicatedStorage_0.Modules.GiftController);
local v11 = require(l_ReplicatedStorage_0.Modules.GuiController);
local v12 = require(l_ReplicatedStorage_0.Modules.DataService);
local v13 = require(l_ReplicatedStorage_0.Modules.NumberUtil);
local v14 = require(l_ReplicatedStorage_0.Modules.RetryPcall);
local v15 = require(l_ReplicatedStorage_0.Modules.FastTween);
local v16 = require(l_ReplicatedStorage_0.Modules.Remotes);
local v17 = require(l_ReplicatedStorage_0.Comma_Module);
local IDs = require(l_ReplicatedStorage_0.PRODUCT_IDS)
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Shop_UI_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("Shop_UI");
local onscreenui = l_LocalPlayer_0.PlayerGui:WaitForChild("OnScreenProds_UI")
local v77 = {
    _initSheckles = function(_) 
        -- upvalues: l_Shop_UI_0 (copy), v9 (copy), v10 (copy)
        for _, v75 in l_Shop_UI_0.Frame.ScrollingFrame.Sheckles.List:GetChildren() do
            if v75:IsA("GuiObject") then
                local v76 = tonumber(v75.Name);
                if v76 then
                    v75.Buttons.Buy.Activated:Connect(function() 
                        -- upvalues: v9 (ref), v76 (copy)
                        v9:PromptPurchase(v76, Enum.InfoType.Product);
                    end);

                    v9:SetPriceLabel(v75.Buttons.Buy, v76);
                end;
            end;
        end;
	end;
	
	_initUsp = function(_)
		local sp = l_Shop_UI_0.Frame.ScrollingFrame.UltimateSeedPack
		local v76 = IDs.Products.UltimateSeedPack
		sp.Buttons.Buy.Activated:Connect(function()
			v9:PromptPurchase(v76, Enum.InfoType.Product);
		end)
		v9:SetPriceLabel(sp.Buttons.Buy, v76);
	end,
	
	_initRsp = function(_)
		local sp = l_Shop_UI_0.Frame.ScrollingFrame.RandomSeedPack
		local v76 = IDs.Products.RandomSeedPack
		sp.Buttons.Buy.Activated:Connect(function()
			v9:PromptPurchase(v76, Enum.InfoType.Product);
		end)
		v9:SetPriceLabel(sp.Buttons.Buy, v76, true);
	end,
};
v77.Start = function(_) --[[ Line: 336 ]] --[[ Name: Start ]]
    -- upvalues: v11 (copy), l_Shop_UI_0 (copy), v77 (copy)
    v11:UsePopupAnims(l_Shop_UI_0);
    l_Shop_UI_0.Frame.Close.Activated:Connect(function() --[[ Line: 339 ]]
        -- upvalues: v11 (ref), l_Shop_UI_0 (ref)
		v11:Close(l_Shop_UI_0);
    end);
	task.spawn(v77._initSheckles, v77);
	task.spawn(v77._initUsp, v77);
	task.spawn(v77._initRsp, v77);
end;
task.spawn(v77.Start, v77);
return v77;