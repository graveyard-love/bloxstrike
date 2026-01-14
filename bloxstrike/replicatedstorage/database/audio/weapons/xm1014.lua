-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v2 = {
	["Identifiers"] = { 97405183279985 },
	["Properties"] = {
		["RollOffMaxDistance"] = 130,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Equip = v2
local v3 = {
	["Identifiers"] = { 139013144373428, 135414885439700, 133991983072870 },
	["Properties"] = {
		["RollOffMaxDistance"] = 130,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagIn = v3
local v4 = {
	["Identifiers"] = { 132138679464484 },
	["Properties"] = {
		["RollOffMaxDistance"] = 300,
		["RollOffMinDistance"] = 40,
		["Volume"] = 0.85
	}
}
v1.Shoot = v4
return table.freeze(v1)