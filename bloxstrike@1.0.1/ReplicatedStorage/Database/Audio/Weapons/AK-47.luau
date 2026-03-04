local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 86823413173348 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagOut = v3
local v4 = {
    ["Identifiers"] = { 134314786214736 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagIn = v4
local v5 = {
    ["Identifiers"] = { 134895294071357 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Bolt = v5
local v6 = {
    ["Identifiers"] = { 87995834264461 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Equip = v6
local v7 = {
    ["Identifiers"] = { 134263220450285, 91599692761385 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 40,
        ["Volume"] = 0.85
    }
}
v2.Shoot = v7
return v1(v2)