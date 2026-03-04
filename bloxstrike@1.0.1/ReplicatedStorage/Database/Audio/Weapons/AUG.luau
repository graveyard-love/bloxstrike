local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 72439780741814 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagOut = v3
local v4 = {
    ["Identifiers"] = { 78701536735584 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagIn = v4
local v5 = {
    ["Identifiers"] = { 128089600728518 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Tap = v5
local v6 = {
    ["Identifiers"] = { 113901310057779 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BoltPull = v6
local v7 = {
    ["Identifiers"] = { 117203272976855 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BoltRelease = v7
local v8 = {
    ["Identifiers"] = { 87995834264461 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Equip = v8
local v9 = {
    ["Identifiers"] = { 73411570759250, 126363484791235, 136946247994543 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 40,
        ["Volume"] = 0.85
    }
}
v2.Shoot = v9
return v1(v2)