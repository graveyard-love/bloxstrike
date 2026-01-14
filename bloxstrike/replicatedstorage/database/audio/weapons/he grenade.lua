-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v2 = {
	["Identifiers"] = { 75780723351141 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Start = v2
local v3 = {
	["Identifiers"] = { 104383867975769 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Clip = v3
local v4 = {
	["Identifiers"] = { 84832273185097 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Throw = v4
local v5 = {
	["Identifiers"] = { 109352631194924 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Equip = v5
local v6 = {
	["Identifiers"] = { 80091364983993, 80515518637864, 105837596019474 },
	["Properties"] = {
		["RollOffMaxDistance"] = 160,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1.Explode = v6
return table.freeze(v1)