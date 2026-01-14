-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v2 = {
	["Identifiers"] = { 119095463272895 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagOut = v2
local v3 = {
	["Identifiers"] = { 79136629459326 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagIn = v3
local v4 = {
	["Identifiers"] = { 100031250931212 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.BoltRelease = v4
local v5 = {
	["Identifiers"] = { 117990182757287 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.BoltPull = v5
local v6 = {
	["Identifiers"] = { 110821133065020 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Equip = v6
local v7 = {
	["Identifiers"] = { 126473467851681 },
	["Properties"] = {
		["RollOffMaxDistance"] = 300,
		["RollOffMinDistance"] = 35,
		["Volume"] = 0.85
	}
}
v1.Shoot = v7
return table.freeze(v1)