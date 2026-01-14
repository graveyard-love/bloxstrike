-- Decompiled with Bunni.lol Decompiler

local v1 = {
	["MaxInventorySpace"] = 4
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
	},
	{
		["MaxSlotSpace"] = 4,
		["Type"] = "Grenade"
	}
}
v1.InventorySlots = v2
return table.freeze(v1)