local v1 = table.freeze
local v2 = {
    ["MaxInventorySpace"] = 5
}
local v3 = {
    {
        ["MaxSlotSpace"] = 1,
        ["Type"] = "Primary"
    },
    {
        ["MaxSlotSpace"] = 1,
        ["Type"] = "Secondary"
    },
    {
        ["MaxSlotSpace"] = 1,
        ["Type"] = "Melee"
    },
    {
        ["MaxSlotSpace"] = 4,
        ["Type"] = "Grenade"
    },
    {
        ["MaxSlotSpace"] = 1,
        ["Type"] = "C4"
    }
}
v2.InventorySlots = v3
return v1(v2)