-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v2 = {
	["Identifiers"] = { 74133013196079 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagOut = v2
local v3 = {
	["Identifiers"] = { 139495075935981 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagIn = v3
local v4 = {
	["Identifiers"] = { 94620371263514 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.BoltForward = v4
local v5 = {
	["Identifiers"] = { 92681439316247 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.BoltBack = v5
local v6 = {
	["Identifiers"] = { 86204186387726 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Equip = v6
local v7 = {
	["Identifiers"] = { 92602917455037, 132472213198196, 133083060670706 },
	["Properties"] = {
		["RollOffMaxDistance"] = 300,
		["RollOffMinDistance"] = 40,
		["Volume"] = 0.85
	}
}
v1.Shoot = v7
return table.freeze(v1)