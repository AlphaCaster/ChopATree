-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = game:GetService("ReplicatedStorage");
local v1 = {};
local l_TweenService_0 = game:GetService("TweenService");
local v3 = require(script.Parent.PartCache);
local v4 = RaycastParams.new();
v4.FilterType = Enum.RaycastFilterType.Include;
v4.FilterDescendantsInstances = {
    workspace
};
local v5 = nil;
if not workspace:FindFirstChild("Debris") then
    v5 = Instance.new("Folder");
    v5.Name = "Debris";
    v5.Parent = workspace;
else
    v5 = workspace.Debris;
end;
local v6 = v3.new(Instance.new("Part"), 1000, v5);
v1.Ground = function(v7, v8, v9, v10, v11, v12, v13) --[[ Line: 22 ]] --[[ Name: Ground ]]
    -- upvalues: v6 (copy), v5 (ref), l_TweenService_0 (copy)
    local v14 = Random.new();
    local v15 = 30;
    local v16 = 360 / v11;
    local l_RayParams_0 = basicUtility.RayParams;
    local v18 = nil;
    v18 = v10 and Vector3.new(1, 1, 1, 0) * v10 or Vector3.new(2, 2, 2, 0);
    v13 = v13 or 3;
    local function v24() --[[ Line: 32 ]] --[[ Name: OuterRocksLoop ]]
        -- upvalues: v11 (copy), v7 (copy), v15 (ref), v9 (copy), v8 (copy), l_RayParams_0 (copy), v16 (copy), v6 (ref), v14 (copy), v18 (ref), v5 (ref), v12 (copy), v13 (ref), l_TweenService_0 (ref)
        for _ = 1, v11 do
            local v20 = CFrame.new(v7) * CFrame.fromEulerAnglesXYZ(0, math.rad(v15), 0) * CFrame.new(v9 / 2 + v9 / 2.7, 10, 0);
            local v21 = workspace:Raycast(v20.Position, v8, l_RayParams_0);
            v15 = v15 + v16;
            if v21 then
                local l_v6_Part_0 = v6:GetPart();
                local l_v6_Part_1 = v6:GetPart();
                l_v6_Part_0.CFrame = CFrame.new(v21.Position - Vector3.new(0, 0.5, 0, 0), v7) * CFrame.fromEulerAnglesXYZ(v14:NextNumber(-0.25, 0.5), v14:NextNumber(-0.25, 0.25), v14:NextNumber(-0.25, 0.25));
                l_v6_Part_0.Size = Vector3.new(v18.X * 1.3, v18.Y / 1.4, v18.Z * 1.3) * v14:NextNumber(1, 1.5);
                l_v6_Part_1.Size = Vector3.new(l_v6_Part_0.Size.X * 1.01, l_v6_Part_0.Size.Y * 0.25, l_v6_Part_0.Size.Z * 1.01);
                l_v6_Part_1.CFrame = l_v6_Part_0.CFrame * CFrame.new(0, l_v6_Part_0.Size.Y / 2 - l_v6_Part_1.Size.Y / 2.1, 0);
                l_v6_Part_0.Parent = v5;
                l_v6_Part_1.Parent = v5;
                if v21.Instance.Material == Enum.Material.Concrete or v21.Instance.Material == Enum.Material.Air or v21.Instance.Material == Enum.Material.Wood or v21.Instance.Material == Enum.Material.Neon or v21.Instance.Material == Enum.Material.WoodPlanks then
                    l_v6_Part_0.Material = v21.Instance.Material;
                    l_v6_Part_1.Material = v21.Instance.Material;
                    l_v6_Part_0.MaterialVariant = v21.Instance.MaterialVariant;
                    l_v6_Part_1.MaterialVariant = v21.Instance.MaterialVariant;
                else
                    l_v6_Part_0.Material = Enum.Material.Concrete;
                    l_v6_Part_1.Material = v21.Instance.Material;
                    l_v6_Part_1.MaterialVariant = v21.Instance.MaterialVariant;
                end;
                l_v6_Part_0.BrickColor = BrickColor.new("Dark grey");
                l_v6_Part_0.Anchored = true;
                l_v6_Part_0.CanTouch = false;
                l_v6_Part_0.CanCollide = false;
                l_v6_Part_1.BrickColor = v21.Instance.BrickColor;
                l_v6_Part_1.Anchored = true;
                l_v6_Part_1.CanTouch = false;
                l_v6_Part_1.CanCollide = false;
                if v12 then
                    l_v6_Part_0.BrickColor = BrickColor.new("Pastel light blue");
                    l_v6_Part_1.BrickColor = BrickColor.new("Lily white");
                    l_v6_Part_0.Material = Enum.Material.Ice;
                    l_v6_Part_1.Material = Enum.Material.Sand;
                end;
                task.delay(v13, function() --[[ Line: 79 ]]
                    -- upvalues: l_TweenService_0 (ref), l_v6_Part_0 (copy), l_v6_Part_1 (copy), v6 (ref)
                    l_TweenService_0:Create(l_v6_Part_0, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Size = Vector3.new(0.009999999776482582, 0.009999999776482582, 0.009999999776482582, 0)
                    }):Play();
                    l_TweenService_0:Create(l_v6_Part_1, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Size = Vector3.new(0.009999999776482582, 0.009999999776482582, 0.009999999776482582, 0), 
                        CFrame = l_v6_Part_0.CFrame * CFrame.new(0, l_v6_Part_0.Size.Y / 2 - l_v6_Part_0.Size.Y / 2.1, 0)
                    }):Play();
                    task.delay(0.6, function() --[[ Line: 83 ]]
                        -- upvalues: v6 (ref), l_v6_Part_0 (ref), l_v6_Part_1 (ref)
                        v6:ReturnPart(l_v6_Part_0);
                        v6:ReturnPart(l_v6_Part_1);
                    end);
                end);
            end;
        end;
    end;
    (function() --[[ Line: 92 ]] --[[ Name: InnerRocksLoop ]]
        -- upvalues: v11 (copy), v7 (copy), v15 (ref), v9 (copy), v8 (copy), l_RayParams_0 (copy), v16 (copy), v6 (ref), v18 (ref), v14 (copy), v5 (ref), v12 (copy), v13 (ref), l_TweenService_0 (ref)
        for _ = 1, v11 do
            local v26 = CFrame.new(v7) * CFrame.fromEulerAnglesXYZ(0, math.rad(v15), 0) * CFrame.new(v9 / 2 + v9 / 10, 10, 0);
            local v27 = game.Workspace:Raycast(v26.Position, v8, l_RayParams_0);
            v15 = v15 + v16;
            if v27 then
                local l_v6_Part_2 = v6:GetPart();
                local l_v6_Part_3 = v6:GetPart();
                l_v6_Part_2.CFrame = CFrame.new(v27.Position - Vector3.new(0, v18.Y * 0.4, 0), v7) * CFrame.fromEulerAnglesXYZ(v14:NextNumber(-1, -0.3), v14:NextNumber(-0.15, 0.15), v14:NextNumber(-0.15, 0.15));
                l_v6_Part_2.Size = Vector3.new(v18.X * 1.3, v18.Y * 0.7, v18.Z * 1.3) * v14:NextNumber(1, 1.5);
                l_v6_Part_3.Size = Vector3.new(l_v6_Part_2.Size.X * 1.01, l_v6_Part_2.Size.Y * 0.25, l_v6_Part_2.Size.Z * 1.01);
                l_v6_Part_3.CFrame = l_v6_Part_2.CFrame * CFrame.new(0, l_v6_Part_2.Size.Y / 2 - l_v6_Part_3.Size.Y / 2.1, 0);
                l_v6_Part_2.Parent = v5;
                l_v6_Part_3.Parent = v5;
                if v27.Instance.Material == Enum.Material.Concrete or v27.Instance.Material == Enum.Material.Air or v27.Instance.Material == Enum.Material.Wood or v27.Instance.Material == Enum.Material.Neon or v27.Instance.Material == Enum.Material.WoodPlanks then
                    l_v6_Part_2.Material = v27.Instance.Material;
                    l_v6_Part_3.Material = v27.Instance.Material;
                    l_v6_Part_2.MaterialVariant = v27.Instance.MaterialVariant;
                    l_v6_Part_3.MaterialVariant = v27.Instance.MaterialVariant;
                else
                    l_v6_Part_2.Material = Enum.Material.Concrete;
                    l_v6_Part_3.Material = v27.Instance.Material;
                    l_v6_Part_3.MaterialVariant = v27.Instance.MaterialVariant;
                end;
                l_v6_Part_2.BrickColor = BrickColor.new("Dark grey");
                l_v6_Part_2.Anchored = true;
                l_v6_Part_2.CanTouch = false;
                l_v6_Part_2.CanCollide = false;
                l_v6_Part_3.BrickColor = v27.Instance.BrickColor;
                l_v6_Part_3.Anchored = true;
                l_v6_Part_3.CanTouch = false;
                l_v6_Part_3.CanCollide = false;
                if v12 then
                    l_v6_Part_2.BrickColor = BrickColor.new("Pastel light blue");
                    l_v6_Part_3.BrickColor = BrickColor.new("Lily white");
                    l_v6_Part_2.Material = Enum.Material.Ice;
                    l_v6_Part_3.Material = Enum.Material.Sand;
                end;
                task.delay(v13, function() --[[ Line: 139 ]]
                    -- upvalues: l_TweenService_0 (ref), l_v6_Part_2 (copy), l_v6_Part_3 (copy), v6 (ref)
                    l_TweenService_0:Create(l_v6_Part_2, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Size = Vector3.new(0.009999999776482582, 0.009999999776482582, 0.009999999776482582, 0)
                    }):Play();
                    l_TweenService_0:Create(l_v6_Part_3, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Size = Vector3.new(0.009999999776482582, 0.009999999776482582, 0.009999999776482582, 0), 
                        CFrame = l_v6_Part_2.CFrame * CFrame.new(0, l_v6_Part_2.Size.Y / 2 - l_v6_Part_2.Size.Y / 2.1, 0)
                    }):Play();
                    task.delay(0.6, function() --[[ Line: 143 ]]
                        -- upvalues: v6 (ref), l_v6_Part_2 (ref), l_v6_Part_3 (ref)
                        v6:ReturnPart(l_v6_Part_2);
                        v6:ReturnPart(l_v6_Part_3);
                    end);
                end);
            end;
        end;
    end)();
    v24();
end;
return v1;