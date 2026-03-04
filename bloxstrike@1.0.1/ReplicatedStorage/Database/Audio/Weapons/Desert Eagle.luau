local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 99647482504735 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagOut = v3
local v4 = {
    ["Identifiers"] = { 70470472513875 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagIn = v4
local v5 = {
    ["Identifiers"] = { 103402336192166 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BoltForward = v5
local v6 = {
    ["Identifiers"] = { 137518751564193 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BoltBack = v6
local v7 = {
    ["Identifiers"] = { 86503300838704 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Equip = v7
local v8 = {
    ["Identifiers"] = { 91532813641152, 122404937915296, 127227371619829 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 35,
        ["Volume"] = 0.85
    }
}
v2.Shoot = v8
return v1(v2)