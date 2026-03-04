local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 90698793665750, 91665393784211, 86582201819894 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 40,
        ["Volume"] = 0.85
    }
}
v2.Shoot = v3
local v4 = {
    ["Identifiers"] = { 80702375430296 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagOut = v4
local v5 = {
    ["Identifiers"] = { 77653564064830 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagIn = v5
local v6 = {
    ["Identifiers"] = { 80470576683196 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BoltRelease = v6
local v7 = {
    ["Identifiers"] = { 112825283651370 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BoltPull = v7
local v8 = {
    ["Identifiers"] = { 110271584686767 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Equip = v8
local v9 = {
    ["Identifiers"] = { 110129262300933 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Tap = v9
return v1(v2)