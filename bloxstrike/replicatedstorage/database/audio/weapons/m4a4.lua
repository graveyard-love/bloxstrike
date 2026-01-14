-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v2 = {
	["Identifiers"] = { 90698793665750, 91665393784211, 86582201819894 },
	["Properties"] = {
		["RollOffMaxDistance"] = 300,
		["RollOffMinDistance"] = 40,
		["Volume"] = 0.85
	}
}
v1.Shoot = v2
local v3 = {
	["Identifiers"] = { 80702375430296 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagOut = v3
local v4 = {
	["Identifiers"] = { 77653564064830 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.MagIn = v4
local v5 = {
	["Identifiers"] = { 80470576683196 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.BoltRelease = v5
local v6 = {
	["Identifiers"] = { 112825283651370 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.BoltPull = v6
local v7 = {
	["Identifiers"] = { 110271584686767 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Equip = v7
local v8 = {
	["Identifiers"] = { 110129262300933 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Tap = v8
return table.freeze(v1)