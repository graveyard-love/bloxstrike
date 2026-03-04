local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 111620049857680 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 2,
        ["Volume"] = 1
    }
}
v2["Fall Damage"] = v3
local v4 = {
    ["Identifiers"] = { 108335842533038 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2["Character Killed"] = v4
local v5 = {
    ["Identifiers"] = {
        72006836457644,
        91514836987946,
        129637321332478,
        112907036777251
    },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2["Character Damaged"] = v5
return v1(v2)