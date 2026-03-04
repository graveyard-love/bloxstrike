local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Controllers.DataController)
local v_u_3 = require(v1.Components.Common.GetWeaponProperties)
local v_u_4 = require(v1.Database.Components.Libraries.Skins)
local v_u_5 = require(v1.Database.Components.Libraries.Cases)
local v_u_6 = require(v1.Database.Custom.GameStats.UI.Inventory.Buttons)
local v_u_7 = {
    ["Forbidden"] = 7,
    ["Special"] = 6,
    ["Red"] = 5,
    ["Pink"] = 4,
    ["Purple"] = 3,
    ["Blue"] = 2,
    ["Stock"] = 1
}
local v_u_8 = {
    ["Sticker Capsule"] = 14,
    ["Charm Capsule"] = 13,
    ["Music Kit"] = 8,
    ["Graffiti"] = 11,
    ["Grenade"] = 16,
    ["Sticker"] = 10,
    ["Zeus x27"] = 3,
    ["Charm"] = 9,
    ["Melee"] = 1,
    ["Glove"] = 2,
    ["Badge"] = 7,
    ["Case"] = 12,
    ["C4"] = 15
}
local v_u_9 = {
    ["Melee"] = 1,
    ["Glove"] = 2,
    ["Case"] = 3,
    ["Charm Capsule"] = 4,
    ["Sticker Capsule"] = 4
}
local v_u_10 = {
    ["Miscellaneous"] = 18,
    ["Equipment"] = 17,
    ["Pistol"] = 3,
    ["Rifle"] = 6,
    ["Heavy"] = 5,
    ["SMG"] = 4
}
local v_u_11 = {
    ["Pistols"] = 1,
    ["Mid Tier"] = 2,
    ["Rifles"] = 3
}
local v_u_12 = {
    ["Equipped Melee"] = 1,
    ["Equipped Gloves"] = 2,
    ["Equipped Badge"] = 3,
    ["Equipped Music Kit"] = 4,
    ["Equipped Graffiti"] = 5,
    ["Equipped Zeus x27"] = 6
}
local function v_u_19(p13, p14)
    if v_u_6.IsCapsule(p13) then
        return "Capsules"
    end
    if p13.Type ~= "Case" then
        if not (p13.Name and p13.Skin) then
            return nil
        end
        local v15 = v_u_4.GetSkinInformation(p13.Name, p13.Skin)
        return v15 and v15.collection or nil
    end
    if not p13.Skin then
        return nil
    end
    local v16 = v_u_5.GetCaseByName(p13.Skin)
    if not v16 then
        return nil
    end
    if p14 then
        p14 = p14()
    end
    if not p14 then
        return nil
    end
    for _, v17 in ipairs(p14) do
        if v17.cases then
            for _, v18 in ipairs(v17.cases) do
                if v18 == v16.name then
                    return v17.name
                end
            end
        end
    end
    return nil
end
local function v_u_34(p20, p21)
    local v22 = nil
    local v23 = v_u_2.Get(p21, "Loadout")
    if not v23 then
        return nil
    end
    for _, v24 in ipairs({ "Counter-Terrorists", "Terrorists" }) do
        local v25 = v23[v24]
        if v25 and v25.Loadout then
            for v26, v27 in pairs(v_u_11) do
                if v27 and (v25.Loadout[v26] and v25.Loadout[v26].Options) then
                    for v28, v29 in ipairs(v25.Loadout[v26].Options) do
                        if v29 == p20 then
                            local v30 = v27 * 1000 + v28
                            if not v22 or v30 < v22 then
                                v22 = v30
                            end
                        end
                    end
                end
            end
            if v25.Equipped then
                for v31, v32 in pairs(v25.Equipped) do
                    if v32 == p20 then
                        local v33 = v_u_12[v31] or 99
                        if not v22 or v33 < v22 then
                            v22 = v33
                        end
                    end
                end
            end
        end
    end
    return v22
end
return {
    ["GetSortComparisonFunction"] = function(p35, p_u_36, p_u_37)
        return p35 == "Alphabetical" and function(p38, p39)
            local v40 = (p38.Skin == "Stock" or p38.MetaData and p38.MetaData.Origin == "Stock") and true or false
            local v41 = (p39.Skin == "Stock" or p39.MetaData and p39.MetaData.Origin == "Stock") and true or false
            if v40 == v41 then
                local v42
                if p38.Type == "Case" then
                    v42 = p38.Skin or ""
                else
                    v42 = (p38.Name or "") .. "|" .. (p38.Skin or "")
                end
                local v43
                if p39.Type == "Case" then
                    v43 = p39.Skin or ""
                else
                    v43 = (p39.Name or "") .. "|" .. (p39.Skin or "")
                end
                if v42 == v43 then
                    local v44 = p38.MetaData and (p38.MetaData.CreatedAt or 0) or 0
                    local v45 = p39.MetaData and (p39.MetaData.CreatedAt or 0) or 0
                    if v44 == v45 then
                        return (p38._id or "") < (p39._id or "")
                    else
                        return v45 < v44
                    end
                else
                    return v42 < v43
                end
            else
                return v41
            end
        end or (p35 == "Collection" and function(p46, p47)
            local v48 = (p46.Skin == "Stock" or p46.MetaData and p46.MetaData.Origin == "Stock") and true or false
            local v49 = (p47.Skin == "Stock" or p47.MetaData and p47.MetaData.Origin == "Stock") and true or false
            if v48 == v49 then
                local v50 = v_u_19(p46, p_u_37) or ""
                local v51 = v_u_19(p47, p_u_37) or ""
                if v50 == v51 then
                    local v52 = v_u_6.GetEffectiveItemType(p46)
                    local v53 = v_u_6.GetEffectiveItemType(p47)
                    local v54 = v_u_9[v52] or 4
                    local v55 = v_u_9[v53] or 4
                    if v54 == v55 then
                        local v56
                        if p46.Name and p46.Skin then
                            v56 = v_u_4.GetSkinInformation(p46.Name, p46.Skin) or nil
                        else
                            v56 = nil
                        end
                        local v57
                        if p47.Name and p47.Skin then
                            v57 = v_u_4.GetSkinInformation(p47.Name, p47.Skin) or nil
                        else
                            v57 = nil
                        end
                        local v58 = v56 and v_u_7[v56.rarity] or 0
                        local v59 = v57 and v_u_7[v57.rarity] or 0
                        if v58 == v59 then
                            local v60
                            if p46.Type == "Case" then
                                v60 = p46.Skin or ""
                            else
                                v60 = (p46.Name or "") .. "|" .. (p46.Skin or "")
                            end
                            local v61
                            if p47.Type == "Case" then
                                v61 = p47.Skin or ""
                            else
                                v61 = (p47.Name or "") .. "|" .. (p47.Skin or "")
                            end
                            if v60 == v61 then
                                return (p46.MetaData and p46.MetaData.CreatedAt or 0) > (p47.MetaData and p47.MetaData.CreatedAt or 0)
                            else
                                return v60 < v61
                            end
                        else
                            return v59 < v58
                        end
                    else
                        return v54 < v55
                    end
                else
                    return v50 < v51
                end
            else
                return v49
            end
        end or (p35 == "Equipped" and function(p62, p63)
            local v64 = (p62.Skin == "Stock" or p62.MetaData and p62.MetaData.Origin == "Stock") and true or false
            local v65 = (p63.Skin == "Stock" or p63.MetaData and p63.MetaData.Origin == "Stock") and true or false
            if v64 == v65 then
                local v66
                if p62._id then
                    v66 = v_u_34(p62._id, p_u_36) or nil
                else
                    v66 = nil
                end
                local v67
                if p63._id then
                    v67 = v_u_34(p63._id, p_u_36) or nil
                else
                    v67 = nil
                end
                if v66 ~= nil == (v67 ~= nil) then
                    if v66 and v67 then
                        if v66 == v67 then
                            local v68
                            if p62.Type == "Case" then
                                v68 = p62.Skin or ""
                            else
                                v68 = (p62.Name or "") .. "|" .. (p62.Skin or "")
                            end
                            local v69
                            if p63.Type == "Case" then
                                v69 = p63.Skin or ""
                            else
                                v69 = (p63.Name or "") .. "|" .. (p63.Skin or "")
                            end
                            if v68 == v69 then
                                return (p62.MetaData and p62.MetaData.CreatedAt or 0) > (p63.MetaData and p63.MetaData.CreatedAt or 0)
                            else
                                return v68 < v69
                            end
                        else
                            return v66 < v67
                        end
                    else
                        local v70
                        if p62.Type == "Case" then
                            v70 = p62.Skin or ""
                        else
                            v70 = (p62.Name or "") .. "|" .. (p62.Skin or "")
                        end
                        local v71
                        if p63.Type == "Case" then
                            v71 = p63.Skin or ""
                        else
                            v71 = (p63.Name or "") .. "|" .. (p63.Skin or "")
                        end
                        if v70 == v71 then
                            return (p62.MetaData and p62.MetaData.CreatedAt or 0) > (p63.MetaData and p63.MetaData.CreatedAt or 0)
                        else
                            return v70 < v71
                        end
                    end
                else
                    return v66 ~= nil
                end
            else
                return v65
            end
        end or (p35 == "Newest" and function(p72, p73)
            local v74 = (p72.Skin == "Stock" or p72.MetaData and p72.MetaData.Origin == "Stock") and true or false
            local v75 = (p73.Skin == "Stock" or p73.MetaData and p73.MetaData.Origin == "Stock") and true or false
            if v74 == v75 then
                local v76 = p72.MetaData and (p72.MetaData.CreatedAt or 0) or 0
                local v77 = p73.MetaData and (p73.MetaData.CreatedAt or 0) or 0
                if v76 == v77 then
                    local v78
                    if p72.Type == "Case" then
                        v78 = p72.Skin or ""
                    else
                        v78 = (p72.Name or "") .. "|" .. (p72.Skin or "")
                    end
                    local v79
                    if p73.Type == "Case" then
                        v79 = p73.Skin or ""
                    else
                        v79 = (p73.Name or "") .. "|" .. (p73.Skin or "")
                    end
                    if v78 == v79 then
                        return (p72._id or "") < (p73._id or "")
                    else
                        return v78 < v79
                    end
                else
                    return v77 < v76
                end
            else
                return v75
            end
        end or (p35 == "Quality" and function(p80, p81)
            local v82 = (p80.Skin == "Stock" or p80.MetaData and p80.MetaData.Origin == "Stock") and true or false
            local v83 = (p81.Skin == "Stock" or p81.MetaData and p81.MetaData.Origin == "Stock") and true or false
            if v82 == v83 then
                local v84
                if p80.Name and p80.Skin then
                    v84 = v_u_4.GetSkinInformation(p80.Name, p80.Skin) or nil
                else
                    v84 = nil
                end
                local v85
                if p81.Name and p81.Skin then
                    v85 = v_u_4.GetSkinInformation(p81.Name, p81.Skin) or nil
                else
                    v85 = nil
                end
                local v86 = v84 and v_u_7[v84.rarity] or 0
                local v87 = v85 and v_u_7[v85.rarity] or 0
                if v86 == v87 then
                    local v88
                    if p80.Type == "Case" then
                        v88 = p80.Skin or ""
                    else
                        v88 = (p80.Name or "") .. "|" .. (p80.Skin or "")
                    end
                    local v89
                    if p81.Type == "Case" then
                        v89 = p81.Skin or ""
                    else
                        v89 = (p81.Name or "") .. "|" .. (p81.Skin or "")
                    end
                    if v88 == v89 then
                        return (p80.MetaData and p80.MetaData.CreatedAt or 0) > (p81.MetaData and p81.MetaData.CreatedAt or 0)
                    else
                        return v88 < v89
                    end
                else
                    return v87 < v86
                end
            else
                return v83
            end
        end or (p35 == "Type" and function(p90, p91)
            local v92 = (p90.Skin == "Stock" or p90.MetaData and p90.MetaData.Origin == "Stock") and true or false
            local v93 = (p91.Skin == "Stock" or p91.MetaData and p91.MetaData.Origin == "Stock") and true or false
            if v92 == v93 then
                local v94 = v_u_6.GetEffectiveItemType(p90)
                local v95 = v_u_6.GetEffectiveItemType(p91)
                local v96 = v_u_8[v94]
                local v97
                if v96 or v94 ~= "Weapon" then
                    v97 = v96 or 99
                elseif p90.Name then
                    local v98, v99 = pcall(v_u_3, p90.Name)
                    v97 = v98 and (v99 and v99.Type) and (v_u_10[v99.Type] or 99) or 99
                else
                    v97 = 99
                end
                local v100 = v_u_8[v95]
                local v101
                if v100 or v95 ~= "Weapon" then
                    v101 = v100 or 99
                elseif p91.Name then
                    local v102, v103 = pcall(v_u_3, p91.Name)
                    v101 = v102 and (v103 and v103.Type) and (v_u_10[v103.Type] or 99) or 99
                else
                    v101 = 99
                end
                if v97 == v101 then
                    local v104
                    if p90.Type == "Case" then
                        v104 = p90.Skin or ""
                    else
                        v104 = (p90.Name or "") .. "|" .. (p90.Skin or "")
                    end
                    local v105
                    if p91.Type == "Case" then
                        v105 = p91.Skin or ""
                    else
                        v105 = (p91.Name or "") .. "|" .. (p91.Skin or "")
                    end
                    if v104 == v105 then
                        return (p90.MetaData and p90.MetaData.CreatedAt or 0) > (p91.MetaData and p91.MetaData.CreatedAt or 0)
                    else
                        return v104 < v105
                    end
                else
                    return v97 < v101
                end
            else
                return v93
            end
        end or nil)))))
    end
}