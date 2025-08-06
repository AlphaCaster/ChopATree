-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = nil;
local l_Parent_0 = script.Parent.Parent;
local l_Parent_1 = l_Parent_0.Parent;
local l_TweenService_0 = game:GetService("TweenService");
local v4 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local l_Object_UI_0 = game.ReplicatedStorage.Object_UI;
local v6 = nil;
local l_PlayerGui_0 = game.Players.LocalPlayer.PlayerGui;
local l_Object_Name_0 = l_Parent_0.Parent.Object_Name;
local l_Cost_Val_0 = l_Parent_0.Parent.Cost_Val;
local v10 = require(game.ReplicatedStorage.Object_Data);
local v11 = require(game.ReplicatedStorage.Comma_Module);
script.Parent.PromptShown:Connect(function() --[[ Line: 14 ]]
    -- upvalues: v0 (ref), l_Parent_1 (copy), l_TweenService_0 (copy), v4 (copy), v6 (ref), l_Object_UI_0 (copy), l_Parent_0 (copy), v11 (copy), l_Cost_Val_0 (copy), l_Object_Name_0 (copy), v10 (copy), l_PlayerGui_0 (copy)
    v0 = Instance.new("Highlight");
    v0.OutlineColor = Color3.new(0, 0, 0);
    v0.DepthMode = Enum.HighlightDepthMode.Occluded;
    v0.FillTransparency = 1;
    v0.OutlineTransparency = 1;
    v0.Adornee = l_Parent_1;
    v0.Parent = l_Parent_1;
    l_TweenService_0:Create(v0, v4, {
        OutlineTransparency = 0.5
    }):Play();
    v6 = l_Object_UI_0:Clone();
    v6.CanvasGroup.Frame.Object_Text.Text = l_Parent_0.Parent.Object_Name.Value;
    v6.CanvasGroup.Frame.Cost_Text.Text = v11.Comma((tostring(l_Parent_0.Parent.Cost_Val.Value))) .. "$";
    v6.CanvasGroup.GroupTransparency = 1;
    v6.CanvasGroup.BackgroundTransparency = 1;
    l_TweenService_0:Create(v6.CanvasGroup, v4, {
        GroupTransparency = 0
    }):Play();
    v6.StudsOffset = Vector3.new(3, 0, 0, 0);
    l_TweenService_0:Create(v6, v4, {
        StudsOffset = Vector3.new(4.75, 0, 0, 0)
    }):Play();
    v6.Adornee = l_Parent_0;
    v6.Cost_Val.Value = l_Cost_Val_0.Value;
    v6.Object_Name.Value = l_Object_Name_0.Value;
    v6.On_Sale.Value = script.Parent.Parent.Parent.On_Sale.Value;
    v6.On_Sale.Sale_Percent.Value = script.Parent.Parent.Parent.On_Sale.Sale_Percent.Value;
    v6.Object_ID.Value = script.Parent.Parent.Parent.Object_ID.Value;
    local v12 = v10.Return_Data(l_Object_Name_0.Value);
    v6.CanvasGroup.ImageLabel.Image = v12[6];
    v6.CanvasGroup.Frame.Object_Text.TextColor3 = v12[7];
    local v13 = v12[4];
    v6.CanvasGroup.Frame.TextLabel.Text = v13;
    v6.CanvasGroup.Frame.TextLabel.TextColor3 = v10.Return_Rarity_Color(v13);
    v6.Parent = l_PlayerGui_0;
end);
script.Parent.PromptHidden:Connect(function() --[[ Line: 48 ]]
    -- upvalues: v0 (ref), l_TweenService_0 (copy), v4 (copy), v6 (ref)
    if v0 then
        l_TweenService_0:Create(v0, v4, {
            OutlineTransparency = 1
        }):Play();
        game.Debris:AddItem(v0, v4.Time);
    end;
    if v6 then
        l_TweenService_0:Create(v6, v4, {
            Size = UDim2.new(v6.Size.X.Scale * 1.1, 0, v6.Size.Y.Scale * 1.1, 0)
        }):Play();
        l_TweenService_0:Create(v6.CanvasGroup, v4, {
            GroupTransparency = 1
        }):Play();
        game.Debris:AddItem(v6, v4.Time);
    end;
end);