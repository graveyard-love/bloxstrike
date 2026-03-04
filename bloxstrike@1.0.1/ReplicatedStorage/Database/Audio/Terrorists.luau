local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 115140779482842, 88634080120233 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 25,
        ["Volume"] = 1.25
    }
}
v2["Planting bomb"] = v3
local v4 = {
    ["Identifiers"] = { 135058881646144, 86027329305419 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 25,
        ["Volume"] = 1
    }
}
v2["Throwing Smoke Grenade"] = v4
local v5 = {
    ["Identifiers"] = { 100233273666271, 98456275706455 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 25,
        ["Volume"] = 1
    }
}
v2["Throwing Flashbang"] = v5
local v6 = {
    ["Identifiers"] = { 111954056952523, 128099708243009 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 25,
        ["Volume"] = 1
    }
}
v2["Throwing HE Grenade"] = v6
local v7 = {
    ["Identifiers"] = { 95908032396502 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 25,
        ["Volume"] = 1
    }
}
v2["Throwing Incendiary Grenade"] = v7
local v8 = {
    ["Identifiers"] = { 84829160150572 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 25,
        ["Volume"] = 1
    }
}
v2["Throwing Molotov"] = v8
local v9 = {
    ["Identifiers"] = { 120361810997490, 71431959853004 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 25,
        ["Volume"] = 1
    }
}
v2["Throwing Decoy Grenade"] = v9
local v10 = {
    ["Identifiers"] = { 94141667493613, 75636280774479, 73096326509225 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 120,
        ["RollOffMinDistance"] = 25,
        ["Volume"] = 1.1
    }
}
v2.Death = v10
return v1(v2)