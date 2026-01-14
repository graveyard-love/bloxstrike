-- Decompiled with Bunni.lol Decompiler

local v1 = {
	["MaxInventorySpace"] = 3
}
local v2 = {
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
v1.InventorySlots = v2
return table.freeze(v1)