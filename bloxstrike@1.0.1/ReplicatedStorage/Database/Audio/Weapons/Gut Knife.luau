local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 91729110777679 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 50,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 0.9
    }
}
v2.Equip = v3
local v4 = {
    ["Identifiers"] = { 89185508106386 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 50,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.HitOne = v4
local v5 = {
    ["Identifiers"] = { 89185508106386 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 50,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.HitTwo = v5
local v6 = {
    ["Identifiers"] = { 89185508106386 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 50,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.HitThree = v6
local v7 = {
    ["Identifiers"] = { 125726459155685 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 50,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.BackStab = v7
local v8 = {
    ["Identifiers"] = { 84292728084061 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 50,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 0.9
    }
}
v2.Handling1 = v8
local v9 = {
    ["Identifiers"] = { 131742455196849 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 50,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 0.9
    }
}
v2.Handling2 = v9
return v1(v2)