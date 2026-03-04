local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 75780723351141 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Start = v3
local v4 = {
    ["Identifiers"] = { 104383867975769 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Clip = v4
local v5 = {
    ["Identifiers"] = { 84832273185097 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Throw = v5
local v6 = {
    ["Identifiers"] = { 109352631194924 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Equip = v6
local v7 = {
    ["Identifiers"] = { 123106625343060, 133747367739475 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Flash = v7
local v8 = {
    ["Identifiers"] = { 125697513023074 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 0,
        ["RollOffMinDistance"] = 0,
        ["Volume"] = 2,
        ["Looped"] = false
    }
}
v2.Flashed = v8
return v1(v2)