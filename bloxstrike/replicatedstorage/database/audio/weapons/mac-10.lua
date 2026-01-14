-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v2 = {
	["Identifiers"] = { 107038116283936 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Equip = v2
local v3 = {
	["Identifiers"] = { 116206639199606 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagIn = v3
local v4 = {
	["Identifiers"] = { 72337636873595 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagOut = v4
local v5 = {
	["Identifiers"] = { 72495952058630 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.BoltForward = v5
local v6 = {
	["Identifiers"] = { 99325700413723 },
	["Properties"] = {
		["RollOffMaxDistance"] = 120,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.BoltBack = v6
local v7 = {
	["Identifiers"] = { 74914094001052, 135447417872693, 91667415904618 },
	["Properties"] = {
		["RollOffMaxDistance"] = 300,
		["RollOffMinDistance"] = 35,
		["Volume"] = 0.85
	}
}
v1.Shoot = v7
return table.freeze(v1)