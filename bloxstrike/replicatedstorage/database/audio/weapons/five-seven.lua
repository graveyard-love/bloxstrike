-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v2 = {
	["Identifiers"] = { 101323105710451 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagOut = v2
local v3 = {
	["Identifiers"] = { 88773763978251 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagIn = v3
local v4 = {
	["Identifiers"] = { 80749495257788 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.BoltRelease = v4
local v5 = {
	["Identifiers"] = { 104985880882363 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.PullBack = v5
local v6 = {
	["Identifiers"] = { 110821133065020 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Equip = v6
local v7 = {
	["Identifiers"] = { 74492232694545 },
	["Properties"] = {
		["RollOffMaxDistance"] = 300,
		["RollOffMinDistance"] = 35,
		["Volume"] = 0.85
	}
}
v1.Shoot = v7
return table.freeze(v1)