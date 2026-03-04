game:GetService("ReplicatedStorage")
local v1 = {
    ["Primary"] = 1,
    ["Secondary"] = 2,
    ["Melee"] = 3,
    ["Grenade"] = 4,
    ["C4"] = 5
}
return table.freeze({
    ["Primary"] = v1.Primary,
    ["Secondary"] = v1.Secondary,
    ["Melee"] = v1.Melee,
    ["Grenade"] = v1.Grenade,
    ["C4"] = v1.C4,
    ["Priorities"] = {
        3,
        2,
        0,
        1,
        1
    }
})