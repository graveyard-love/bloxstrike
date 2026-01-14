-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v2 = {
	["Identifiers"] = { 86823413173348 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagOut = v2
local v3 = {
	["Identifiers"] = { 134314786214736 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagIn = v3
local v4 = {
	["Identifiers"] = { 134895294071357 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Bolt = v4
local v5 = {
	["Identifiers"] = { 87995834264461 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Equip = v5
local v6 = {
	["Identifiers"] = { 134263220450285, 91599692761385 },
	["Properties"] = {
		["RollOffMaxDistance"] = 300,
		["RollOffMinDistance"] = 40,
		["Volume"] = 0.85
	}
}
v1.Shoot = v6
return table.freeze(v1)