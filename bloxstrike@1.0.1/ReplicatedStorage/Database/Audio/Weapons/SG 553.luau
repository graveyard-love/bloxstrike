local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 132057836686640, 135422263254331, 79354269657820 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 40,
        ["Volume"] = 0.85
    }
}
v2.Shoot = v3
local v4 = {
    ["Identifiers"] = { 101885182016053 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagOut = v4
local v5 = {
    ["Identifiers"] = { 77541576241995 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagIn = v5
local v6 = {
    ["Identifiers"] = { 133544069176481 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BoltForward = v6
local v7 = {
    ["Identifiers"] = { 87652940540965 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BoltBack = v7
local v8 = {
    ["Identifiers"] = { 80769111288161 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Equip = v8
return v1(v2)