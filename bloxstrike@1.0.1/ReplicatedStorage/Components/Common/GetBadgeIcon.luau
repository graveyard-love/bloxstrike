local v1 = game:GetService("ReplicatedStorage")
require(v1.Database.Custom.Types)
local v_u_2 = require(v1.Controllers.DataController)
local v_u_3 = require(v1.Database.Components.Libraries.Skins)
return function(p4, p5)
    local v6, v7 = v_u_2.Get(p4, "Loadout", "Inventory")
    if not (v6 and v7) then
        return ""
    end
    local v8 = v6[p5]
    if not (v8 and v8.Equipped) then
        return ""
    end
    local v9 = v8.Equipped["Equipped Badge"]
    if not v9 or v9 == "" then
        return ""
    end
    local v10 = nil
    for _, v11 in ipairs(v7) do
        if v11._id == v9 then
            v10 = v11
            break
        end
    end
    if not v10 then
        return ""
    end
    local v12 = v_u_3.GetSkinInformation(v10.Name, v10.Skin)
    return v12 and (v_u_3.GetWearImageForFloat(v12, v10.Float or 0.9999) or v12.imageAssetId or "") or ""
end