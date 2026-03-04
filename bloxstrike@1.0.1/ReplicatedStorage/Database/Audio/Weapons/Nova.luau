local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 91110815083341 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 40,
        ["Volume"] = 0.85
    }
}
v2.Shoot = v3
local v4 = {
    ["Identifiers"] = { 117026125132321, 117727161272334, 102126884379985 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 130,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagIn = v4
local v5 = {
    ["Identifiers"] = { 95255392770739 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 165,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Pump = v5
local v6 = {
    ["Identifiers"] = { 107374991518842 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 165,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Equip = v6
return v1(v2)