local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 121286178796608 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagOut = v3
local v4 = {
    ["Identifiers"] = { 121859645646862 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagIn = v4
local v5 = {
    ["Identifiers"] = { 78816630619112 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BoltForward = v5
local v6 = {
    ["Identifiers"] = { 105025028355006 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BoltBack = v6
local v7 = {
    ["Identifiers"] = { 96212573279536 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Equip = v7
local v8 = {
    ["Identifiers"] = { 73809404254628 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Tap = v8
local v9 = {
    ["Identifiers"] = { 71405973595764, 106301976774991, 135428059753141 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 40,
        ["Volume"] = 0.85
    }
}
v2.Shoot = v9
return v1(v2)