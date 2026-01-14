-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v2 = {
	["Identifiers"] = { 132057836686640, 135422263254331, 79354269657820 },
	["Properties"] = {
		["RollOffMaxDistance"] = 300,
		["RollOffMinDistance"] = 40,
		["Volume"] = 0.85
	}
}
v1.Shoot = v2
local v3 = {
	["Identifiers"] = { 101885182016053 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagOut = v3
local v4 = {
	["Identifiers"] = { 77541576241995 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagIn = v4
local v5 = {
	["Identifiers"] = { 133544069176481 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.BoltForward = v5
local v6 = {
	["Identifiers"] = { 87652940540965 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.BoltBack = v6
local v7 = {
	["Identifiers"] = { 80769111288161 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Equip = v7
return table.freeze(v1)