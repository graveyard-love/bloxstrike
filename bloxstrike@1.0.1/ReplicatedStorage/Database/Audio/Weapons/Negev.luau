local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 92095930939964 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 130,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Equip = v3
local v4 = {
    ["Identifiers"] = { 135904642782336 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 130,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagIn = v4
local v5 = {
    ["Identifiers"] = { 84954630264073 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 130,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagOut = v5
local v6 = {
    ["Identifiers"] = { 71975244023101 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 130,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Bolt = v6
local v7 = {
    ["Identifiers"] = { 111461530809915 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 130,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.CoverUp = v7
local v8 = {
    ["Identifiers"] = { 119946831593400 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 130,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.CoverDown = v8
local v9 = {
    ["Identifiers"] = { 125249488686284 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 130,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Chain = v9
local v10 = {
    ["Identifiers"] = { 140651367917299, 130125173746857 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 40,
        ["Volume"] = 0.85
    }
}
v2.Shoot = v10
return v1(v2)