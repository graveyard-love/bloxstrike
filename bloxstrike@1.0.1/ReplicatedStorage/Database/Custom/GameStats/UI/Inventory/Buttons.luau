local v1 = game:GetService("ReplicatedStorage")
require(v1.Database.Custom.Types)
local v2 = require(v1.Packages.Sift)
local v3 = {
    ["LayoutOrder"] = 0,
    ["Search"] = {
        "Badge",
        "Zeus x27",
        "C4",
        "Graffiti",
        "Charm",
        "Charm Capsule",
        "Sticker",
        "Sticker Capsule",
        "Music Kit",
        "Weapon",
        "Glove",
        "Melee",
        "Case",
        "Package"
    }
}
local v10 = {
    ["GetEffectiveItemType"] = function(p4)
        local v5
        if p4.Type == "Case" and p4.Name then
            local v6 = string.find(p4.Skin, "Sticker") ~= nil
            local v7 = string.find(p4.Skin, "Charm") ~= nil
            v5 = v7 or v6
        else
            v5 = false
        end
        return v5 and (p4.Name and string.find(p4.Name, "Charm") and "Charm Capsule" or (p4.Name and string.find(p4.Name, "Sticker") and "Sticker Capsule" or (p4.Type == "Charm Capsule" and "Charm Capsule" or "Sticker Capsule"))) or (p4.Type or "")
    end,
    ["IsCapsule"] = function(p8)
        if p8.Type ~= "Case" or not p8.Name then
            return false
        end
        local v9 = string.find(p8.Skin, "Sticker") ~= nil
        return string.find(p8.Skin, "Charm") ~= nil or v9
    end,
    ["Everything"] = {
        ["Default"] = v3
    }
}
local v11 = {
    ["All Equipment"] = v3,
    ["Melee"] = {
        ["Search"] = { "Melee" },
        ["LayoutOrder"] = 1
    },
    ["Pistols"] = {
        ["Search"] = { "Weapon:Pistol" },
        ["LayoutOrder"] = 2
    },
    ["Mid-Tier"] = {
        ["Search"] = { "Weapon:Heavy", "Weapon:SMG" },
        ["LayoutOrder"] = 3
    },
    ["Rifles"] = {
        ["Search"] = { "Weapon:Rifle" },
        ["LayoutOrder"] = 4
    },
    ["Misc"] = {
        ["Search"] = { "Zeus x27", "C4" },
        ["LayoutOrder"] = 5
    },
    ["Gloves"] = {
        ["Search"] = { "Glove" },
        ["LayoutOrder"] = 6
    },
    ["Music Kits"] = {
        ["Search"] = { "Music Kit" },
        ["LayoutOrder"] = 7
    }
}
v10.Equipment = v11
local v12 = {
    ["All Graphic Art"] = {
        ["Search"] = {
            "Badge",
            "Graffiti",
            "Charm",
            "Sticker"
        },
        ["LayoutOrder"] = 0
    },
    ["Badges"] = {
        ["Search"] = { "Badge" },
        ["LayoutOrder"] = 1
    },
    ["Stickers"] = {
        ["Search"] = { "Sticker" },
        ["LayoutOrder"] = 2
    },
    ["Graffiti"] = {
        ["Search"] = { "Graffiti" },
        ["LayoutOrder"] = 3
    },
    ["Charms"] = {
        ["Search"] = { "Charm" },
        ["LayoutOrder"] = 4
    }
}
v10["Graphic Art"] = v12
local v13 = {
    ["All"] = {
        ["Search"] = {
            "Case",
            "Package",
            "Charm Capsule",
            "Sticker Capsule"
        },
        ["LayoutOrder"] = 0
    },
    ["Cases"] = {
        ["Search"] = { "Case" },
        ["LayoutOrder"] = 1
    },
    ["Packages"] = {
        ["Search"] = { "Package" },
        ["LayoutOrder"] = 2
    },
    ["Capsules"] = {
        ["Search"] = { "Charm Capsule", "Sticker Capsule" },
        ["LayoutOrder"] = 3
    }
}
v10.Display = v13
return v2.Dictionary.freezeDeep(v10)