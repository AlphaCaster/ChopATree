-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

return {
    Scale = function(v0, v1) --[[ Line: 3 ]] --[[ Name: Scale ]]
        debug.profilebegin("PlantScale1");
        if v0:FindFirstChild("PlantModel") then
            v0:FindFirstChild("PlantModel"):ScaleTo(v1);
            return;
        else
            for _, v3 in pairs(v0:GetDescendants()) do
                if v3:IsA("BasePart") then
                    if v3:GetAttribute("OG_SIZE") == nil then
                        v3:SetAttribute("OG_SIZE", v3.Size);
                    end;
                    v3.Size = v3:GetAttribute("OG_SIZE") * v1;
                    if v3:IsA("MeshPart") then

                    end;
                    local l_SpecialMesh_0 = v3:FindFirstChildOfClass("SpecialMesh");
                    if l_SpecialMesh_0 then
                        if l_SpecialMesh_0:GetAttribute("OG_SCALE") == nil then
                            l_SpecialMesh_0:SetAttribute("OG_SCALE", l_SpecialMesh_0.Scale);
                        end;
                        l_SpecialMesh_0.Scale = l_SpecialMesh_0:GetAttribute("OG_SCALE") * v1;
                    end;
                elseif v3:IsA("Motor6D") then
                    if v3:GetAttribute("OG_C0") == nil and v3:GetAttribute("OG_C1") == nil then
                        v3:SetAttribute("OG_C0", v3.C0);
                        v3:SetAttribute("OG_C1", v3.C1);
                    end;
                    local l_v3_Attribute_0 = v3:GetAttribute("OG_C0");
                    local l_v3_Attribute_1 = v3:GetAttribute("OG_C1");
                    v3.C0 = CFrame.new(l_v3_Attribute_0.Position * v1) * (l_v3_Attribute_0 - l_v3_Attribute_0.Position);
                    v3.C1 = CFrame.new(l_v3_Attribute_1.Position * v1) * (l_v3_Attribute_1 - l_v3_Attribute_1.Position);
                end;
            end;
            debug.profileend("PlantScale1");
            return;
        end;
    end
};