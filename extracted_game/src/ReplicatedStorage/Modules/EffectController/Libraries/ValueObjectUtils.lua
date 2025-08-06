-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local v1 = {
    ["nil"] = "StringValue", 
    boolean = "BoolValue", 
    BrickColor = "BrickColorValue", 
    CFrame = "CFrameValue", 
    Color3 = "Color3Value", 
    number = "NumberValue", 
    Instance = "ObjectValue", 
    Ray = "RayValue", 
    string = "StringValue", 
    Vector3 = "Vector3Value"
};
v0.GetClassFromType = function(v2) --[[ Line: 19 ]] --[[ Name: GetClassFromType ]]
    -- upvalues: v1 (copy)
    return v1[v2];
end;
v0.ConvertTypeToClass = function(v3) --[[ Line: 23 ]] --[[ Name: ConvertTypeToClass ]]
    -- upvalues: v1 (copy)
    return Instance.new(v1[v3]);
end;
return v0;