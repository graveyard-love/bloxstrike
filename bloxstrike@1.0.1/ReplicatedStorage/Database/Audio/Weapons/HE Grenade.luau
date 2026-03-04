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
    ["Identifiers"] = { 80091364983993, 80515518637864, 105837596019474 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 160,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Explode = v7
return v1(v2)