-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v2 = {
	["Identifiers"] = { 91110815083341 },
	["Properties"] = {
		["RollOffMaxDistance"] = 300,
		["RollOffMinDistance"] = 40,
		["Volume"] = 0.85
	}
}
v1.Shoot = v2
local v3 = {
	["Identifiers"] = { 117026125132321, 117727161272334, 102126884379985 },
	["Properties"] = {
		["RollOffMaxDistance"] = 130,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagIn = v3
local v4 = {
	["Identifiers"] = { 95255392770739 },
	["Properties"] = {
		["RollOffMaxDistance"] = 165,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Pump = v4
local v5 = {
	["Identifiers"] = { 107374991518842 },
	["Properties"] = {
		["RollOffMaxDistance"] = 165,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Equip = v5
return table.freeze(v1)