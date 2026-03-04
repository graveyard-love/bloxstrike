local v1 = game:GetService("ReplicatedStorage")
require(v1.Database.Custom.Types)
local v_u_2 = require(v1.Controllers.DataController)
local v_u_3 = require(v1.Database.Components.Libraries.Skins)
local v_u_4 = table.freeze({
    ["Medal.tv"] = "Medal"
})
return function(p5, p6)
    local v7, v8 = v_u_2.Get(p5, "Loadout", "Inventory")
    if not (v7 and v8) then
        return ""
    end
    local v9 = v7[p6]
    if not (v9 and v9.Equipped) then
        return ""
    end
    local v10 = v9.Equipped["Equipped Badge"]
    if not v10 or v10 == "" then
        return ""
    end
    local v11 = nil
    for _, v12 in ipairs(v8) do
        if v12._id == v10 then
            v11 = v12
            break
        end
    end
    return not v11 and "" or (not v_u_3.GetSkinInformation(v11.Name, v11.Skin) and "" or (v_u_4[v11.Skin] or v11.Skin))
end