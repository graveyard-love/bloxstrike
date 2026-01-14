-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v2 = {
	["Identifiers"] = { 111620049857680 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 2,
		["Volume"] = 1
	}
}
v1["Fall Damage"] = v2
local v3 = {
	["Identifiers"] = { 108335842533038 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1["Character Killed"] = v3
local v4 = {
	["Identifiers"] = {
		72006836457644,
		91514836987946,
		129637321332478,
		112907036777251
	},
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1["Character Damaged"] = v4
local v5 = {
	["Identifiers"] = { 137503385834927 },
	["Properties"] = {
		["RollOffMaxDistance"] = 115,
		["RollOffMinDistance"] = 5,
		["Volume"] = 1
	}
}
v1["Deathmatch Character Spawned"] = v5
local v6 = {
	["Identifiers"] = { 117094641731981 },
	["Properties"] = {
		["RollOffMaxDistance"] = 90,
		["RollOffMinDistance"] = 10,
		["Volume"] = 1
	}
}
v1["Deathmatch Character Died"] = v6
return table.freeze(v1)