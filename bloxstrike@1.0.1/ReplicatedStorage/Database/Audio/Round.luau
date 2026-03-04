local v1 = table.freeze
local v2 = {}
local v3 = {
    ["Identifiers"] = { 102242832333292 },
    ["Properties"] = {
        ["Volume"] = 1.5
    }
}
v2["Round Start Countdown"] = v3
local v4 = {
    ["Identifiers"] = { 138806965930837 },
    ["Properties"] = {
        ["Volume"] = 0.333,
        ["Looped"] = false
    }
}
v2["Buy Phase"] = v4
local v5 = {
    ["Identifiers"] = { 119219669735264 },
    ["Properties"] = {
        ["Volume"] = 1
    }
}
v2.Draw = v5
local v6 = {
    ["Identifiers"] = { 125321230056670 },
    ["Properties"] = {
        ["Volume"] = 1
    }
}
v2["Counter-Terrorists Win"] = v6
local v7 = {
    ["Identifiers"] = { 88851292403698 },
    ["Properties"] = {
        ["Volume"] = 1
    }
}
v2["Terrorists Win"] = v7
local v8 = {
    ["Identifiers"] = { 93457830354254 },
    ["Properties"] = {
        ["RollOffMaxDistance"] = 0,
        ["RollOffMinDistance"] = 0,
        ["Volume"] = 0.333,
        ["Looped"] = false
    }
}
v2.MVP = v8
return v1(v2)