-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v2 = {
	["Identifiers"] = { 108825331639427 },
	["Properties"] = {
		["RollOffMaxDistance"] = 25,
		["RollOffMinDistance"] = 5,
		["Looped"] = true,
		["Volume"] = 0.75
	}
}
v1["Hostage Idle"] = v2
local v3 = {
	["Identifiers"] = { 70903336993282 },
	["Properties"] = {
		["RollOffMaxDistance"] = 60,
		["RollOffMinDistance"] = 5,
		["Volume"] = 0.4
	}
}
v1["Generic Hostage Pickup"] = v3
local v4 = {
	["Identifiers"] = { 135752990887744 },
	["Properties"] = {
		["RollOffMaxDistance"] = 60,
		["RollOffMinDistance"] = 5,
		["Volume"] = 0.4
	}
}
v1["Hostage Kit Pickup"] = v4
local v5 = {
	["Identifiers"] = { 90668532289323 },
	["Properties"] = {
		["RollOffMaxDistance"] = 60,
		["RollOffMinDistance"] = 5,
		["Volume"] = 0.4
	}
}
v1["Hostage Pickup"] = v5
return table.freeze(v1)