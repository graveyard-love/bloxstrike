local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 97405183279985 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 130,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Equip = v3
local v4 = {
    ["Identifiers"] = { 139013144373428, 135414885439700, 133991983072870 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 130,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagIn = v4
local v5 = {
    ["Identifiers"] = { 132138679464484 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 40,
        ["Volume"] = 0.85
    }
}
v2.Shoot = v5
return v1(v2)