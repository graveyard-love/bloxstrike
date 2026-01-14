-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v2 = {
	["Identifiers"] = { 90864665314198 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagOut = v2
local v3 = {
	["Identifiers"] = { 138596958953762 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagIn = v3
local v4 = {
	["Identifiers"] = { 140633632539266 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Tap = v4
local v5 = {
	["Identifiers"] = { 110646189453016 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.BoltBack = v5
local v6 = {
	["Identifiers"] = { 109761343260789 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.BoltForward = v6
local v7 = {
	["Identifiers"] = { 117783825149596 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Equip = v7
local v8 = {
	["Identifiers"] = { 106501113547953, 113882419721020, 119088838146118 },
	["Properties"] = {
		["RollOffMaxDistance"] = 300,
		["RollOffMinDistance"] = 35,
		["Volume"] = 0.85
	}
}
v1.Shoot = v8
return table.freeze(v1)