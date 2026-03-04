local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 108825331639427 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 25,
        ["RollOffMinDistance"] = 5,
        ["Looped"] = true,
        ["Volume"] = 0.75
    }
}
v2["Hostage Idle"] = v3
local v4 = {
    ["Identifiers"] = { 70903336993282 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 60,
        ["RollOffMinDistance"] = 5,
        ["Volume"] = 0.4
    }
}
v2["Generic Hostage Pickup"] = v4
local v5 = {
    ["Identifiers"] = { 135752990887744 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 60,
        ["RollOffMinDistance"] = 5,
        ["Volume"] = 0.4
    }
}
v2["Hostage Kit Pickup"] = v5
local v6 = {
    ["Identifiers"] = { 90668532289323 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 60,
        ["RollOffMinDistance"] = 5,
        ["Volume"] = 0.4
    }
}
v2["Hostage Pickup"] = v6
return v1(v2)