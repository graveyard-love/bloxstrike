local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 131273847577128 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 60,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2["Open Garage"] = v3
local v4 = {
    ["Identifiers"] = { 139971250122237 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 60,
        ["RollOffMinDistance"] = 10,
        ["Volume"] = 1
    }
}
v2["Close Garage"] = v4
return v1(v2)