local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 88305429005809 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 85,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Bounce = v3
local v4 = {
    ["Identifiers"] = { 88305429005809 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 85,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2["Bounce HE"] = v4
local v5 = {
    ["Identifiers"] = { 88305429005809 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 85,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2["Bounce Smoke"] = v5
local v6 = {
    ["Identifiers"] = { 72447402740398 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 85,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2["Bounce Flashbang"] = v6
local v7 = {
    ["Identifiers"] = { 72447402740398 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 85,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2["Bounce Decoy"] = v7
local v8 = {
    ["Identifiers"] = { 72640314222093 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 85,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2["Bounce Incendiary"] = v8
local v9 = {
    ["Identifiers"] = { 95491866742309 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 85,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2["Bounce Molotov"] = v9
local v10 = {
    ["Identifiers"] = { 116675737467831 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 115,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1,
        ["Looped"] = true
    }
}
v2.Flames = v10
return v1(v2)