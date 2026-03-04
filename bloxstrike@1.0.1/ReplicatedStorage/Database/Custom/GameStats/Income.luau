local v1 = table.freeze
local v2 = {}
local v3 = {
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
        ["Incendiary"] = 0,
        ["Incendiary Grenade"] = 0
    },
    ["WeaponBonusesCompetitive"] = {
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
        ["XM1014"] = 600,
        ["P90"] = 0,
        ["AWP"] = -200,
        ["CZ75-Auto"] = -200,
        ["Zeus x27"] = -300,
        ["HE Grenade"] = 0,
        ["Molotov"] = 0,
        ["Incendiary"] = 0,
        ["Incendiary Grenade"] = 0
    }
}
v2.Kill = v3
v2.Assist = {
    ["Competitive"] = 0,
    ["Casual"] = 50,
    ["Deathmatch"] = 0
}
v2.BombPlant = {
    ["Competitive"] = 300,
    ["Casual"] = 300,
    ["Deathmatch"] = 0
}
v2.BombDefuse = {
    ["Competitive"] = 300,
    ["Casual"] = 300,
    ["Deathmatch"] = 0
}
v2.BombPlantedButDefused = {
    ["Competitive"] = 600,
    ["Casual"] = 600,
    ["Deathmatch"] = 0
}
local v4 = {
    ["Competitive"] = {
        ["Elimination"] = 3250,
        ["BombObjective"] = 3500,
        ["BombExplode"] = 3500,
        ["BombDefuse"] = 3250,
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
v2.RoundWin = v4
local v5 = {
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
v2.RoundLoss = v5
v2.BombPlantLossBonus = {
    ["Competitive"] = 600,
    ["Casual"] = 0,
    ["Deathmatch"] = 0
}
v2.CTTeamKillBonus = {
    ["Competitive"] = 50,
    ["Casual"] = 50,
    ["Deathmatch"] = 0
}
v2.HostageShotPenalty = {
    ["Competitive"] = -300,
    ["Deathmatch"] = 0,
    ["Casual"] = -300
}
v2.HostageInteraction = {
    ["Competitive"] = 150,
    ["Casual"] = 0,
    ["Deathmatch"] = 0
}
v2.HostageTeamInteraction = {
    ["Competitive"] = 500,
    ["Casual"] = 0,
    ["Deathmatch"] = 0
}
v2.HostageRescueBonus = {
    ["Competitive"] = 1000,
    ["Casual"] = 0,
    ["Deathmatch"] = 0
}
v2.TeamKillPenalty = {
    ["Competitive"] = -300,
    ["Casual"] = 0,
    ["Deathmatch"] = 0
}
v2.MinimumRoundIncome = {
    ["Competitive"] = 1400,
    ["Casual"] = 1400,
    ["Deathmatch"] = 0
}
v2.SpecialRules = {
    ["TerroristTimeoutPenalty"] = true,
    ["CasualKillRewardHalved"] = true,
    ["MaxMoney"] = 16000
}
return v1(v2)