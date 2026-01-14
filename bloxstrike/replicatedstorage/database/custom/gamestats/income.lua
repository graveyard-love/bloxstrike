-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v2 = {
	["Competitive"] = 300,
	["Casual"] = 150,
	["Deathmatch"] = 0,
	["WeaponBonuses"] = {
		["Knife"] = 1200,
		["MP9"] = 300,
		["MAC-10"] = 300,
		["MP5-SD"] = 300,
		["UMP-45"] = 300,
		["PP-Bizon"] = 300,
		["MP7"] = 300,
		["Nova"] = 600,
		["Sawed-Off"] = 600,
		["MAG-7"] = 600,
		["P90"] = 0,
		["XM1014"] = 0,
		["AWP"] = -200,
		["Zeus x27"] = -200,
		["HE Grenade"] = 0,
		["Molotov"] = 0,
		["Incendiary"] = 0
	}
}
v1.Kill = v2
v1.Assist = {
	["Competitive"] = 50,
	["Casual"] = 50,
	["Deathmatch"] = 0
}
v1.BombPlant = {
	["Competitive"] = 300,
	["Casual"] = 300,
	["Deathmatch"] = 0
}
v1.BombDefuse = {
	["Competitive"] = 300,
	["Casual"] = 300,
	["Deathmatch"] = 0
}
local v3 = {
	["Competitive"] = {
		["Elimination"] = 3250,
		["BombObjective"] = 3500,
		["HostageRescue"] = 3500,
		["TimeExpiration"] = 3250
	},
	["Casual"] = {
		["Elimination"] = 3250,
		["BombObjective"] = 3500,
		["HostageRescue"] = 3500,
		["TimeExpiration"] = 3250
	},
	["Deathmatch"] = {
		["Elimination"] = 0,
		["BombObjective"] = 0,
		["TimeExpiration"] = 0
	}
}
v1.RoundWin = v3
local v4 = {
	["Competitive"] = {
		[0] = 1400,
		[1] = 1900,
		[2] = 2400,
		[3] = 2900,
		[4] = 3400
	},
	["Casual"] = {
		[0] = 1400,
		[1] = 1900,
		[2] = 2400,
		[3] = 2900,
		[4] = 3400
	},
	["Deathmatch"] = {
		[0] = 0,
		[1] = 0,
		[2] = 0,
		[3] = 0,
		[4] = 0
	}
}
v1.RoundLoss = v4
v1.CTTeamKillBonus = {
	["Competitive"] = 50,
	["Casual"] = 50,
	["Deathmatch"] = 0
}
v1.HostageShotPenalty = {
	["Competitive"] = -500,
	["Deathmatch"] = 0,
	["Casual"] = -300
}
v1.MinimumRoundIncome = {
	["Competitive"] = 1400,
	["Casual"] = 1400,
	["Deathmatch"] = 0
}
v1.SpecialRules = {
	["TerroristTimeoutPenalty"] = true,
	["CasualKillRewardHalved"] = true,
	["MaxMoney"] = 16000
}
return table.freeze(v1)