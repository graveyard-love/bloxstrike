local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 90864665314198 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagOut = v3
local v4 = {
    ["Identifiers"] = { 138596958953762 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.MagIn = v4
local v5 = {
    ["Identifiers"] = { 140633632539266 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Tap = v5
local v6 = {
    ["Identifiers"] = { 110646189453016 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BoltBack = v6
local v7 = {
    ["Identifiers"] = { 109761343260789 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BoltForward = v7
local v8 = {
    ["Identifiers"] = { 117783825149596 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Equip = v8
local v9 = {
    ["Identifiers"] = { 106501113547953, 113882419721020, 119088838146118 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 300,
        ["RollOffMinDistance"] = 35,
        ["Volume"] = 0.85
    }
}
v2.Shoot = v9
return v1(v2)