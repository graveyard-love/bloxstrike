local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 86340105244546 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagOut = v3
local v4 = {
    ["Identifiers"] = { 130255300548454 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagInRIGHT = v4
local v5 = {
    ["Identifiers"] = { 138715583826653 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagInLEFT = v5
local v6 = {
    ["Identifiers"] = { 112727028680595 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Bolt = v6
local v7 = {
    ["Identifiers"] = { 97602636034092 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Equip = v7
local v8 = {
    ["Identifiers"] = { 94337423663604 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Tap = v8
local v9 = {
    ["Identifiers"] = { 108508645677337 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Flip = v9
local v10 = {
    ["Identifiers"] = { 87073516979455, 139902396102453 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 35,
        ["Volume"] = 0.85
    }
}
v2.Shoot = v10
return v1(v2)