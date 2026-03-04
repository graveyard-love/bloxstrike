local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 139780121668422 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 2
    }
}
v2["Low Ammo Fire"] = v3
local v4 = {
    ["Identifiers"] = { 84239484255879 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2["Switch Fire Mode"] = v4
local v5 = {
    ["Identifiers"] = { 124772612909241 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2["Scope In"] = v5
local v6 = {
    ["Identifiers"] = { 80232125926926 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2["Scope Out"] = v6
local v7 = {
    ["Identifiers"] = { 127466955748548 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 45,
        ["RollOffMinDistance"] = 15,
        ["Volume"] = 1
    }
}
v2["Toggle Scope"] = v7
local v8 = {
    ["Identifiers"] = { 114504997850933 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2["No Ammo"] = v8
local v9 = {
    ["Identifiers"] = { 124960703101864 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2.Ping = v9
local v10 = {
    ["Identifiers"] = { 83225717442648 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 90,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 0.5
    }
}
v2["Danger Ping"] = v10
return v1(v2)