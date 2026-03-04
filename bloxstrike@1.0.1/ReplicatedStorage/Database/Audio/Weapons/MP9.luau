local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 107038116283936 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Equip = v3
local v4 = {
    ["Identifiers"] = { 130867599524535 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagIn = v4
local v5 = {
    ["Identifiers"] = { 96079663916420 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagOut = v5
local v6 = {
    ["Identifiers"] = { 123114131932389 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BoltForward = v6
local v7 = {
    ["Identifiers"] = { 120128678986818 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BoltBack = v7
local v8 = {
    ["Identifiers"] = { 131667209323660, 123735056260386, 87360275259132 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 35,
        ["Volume"] = 0.85
    }
}
v2.Shoot = v8
return v1(v2)