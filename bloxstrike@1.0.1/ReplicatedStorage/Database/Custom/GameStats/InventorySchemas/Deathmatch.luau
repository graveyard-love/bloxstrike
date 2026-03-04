local v1 = table.freeze
local v2 = {
    ["MaxInventorySpace"] = 3
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
    }
}
v2.InventorySlots = v3
return v1(v2)