local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 108155808807154 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagOut = v3
local v4 = {
    ["Identifiers"] = { 131828601333215 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagIn = v4
local v5 = {
    ["Identifiers"] = { 132328932882322 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BoltPull = v5
local v6 = {
    ["Identifiers"] = { 104664645700254 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BoltRelease = v6
local v7 = {
    ["Identifiers"] = { 117148840921052 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Equip = v7
local v8 = {
    ["Identifiers"] = { 114600251925767, 129239616000307 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 35,
        ["Volume"] = 0.85
    }
}
v2.Shoot = v8
return v1(v2)