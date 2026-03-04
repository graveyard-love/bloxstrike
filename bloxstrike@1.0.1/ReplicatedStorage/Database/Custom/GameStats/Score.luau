local v1 = {
    ["Knife"] = {
        "CT Knife",
        "T Knife",
        "Butterfly Knife",
        "Flip Knife",
        "Gut Knife",
        "Karambit",
        "M9 Bayonet",
        "Bayonet",
        "Bowie Knife",
        "Falchion Knife",
        "Huntsman Knife",
        "Navaja Knife",
        "Paracord Knife",
        "Shadow Daggers",
        "Skeleton Knife",
        "Stiletto Knife",
        "Survival Knife",
        "Talon Knife",
        "Ursus Knife",
        "Classic Knife",
        "Nomad Knife",
        "Kukri Knife"
    },
    ["Pistols"] = {
        "USP-S",
        "P2000",
        "Glock-18",
        "P250",
        "Five-SeveN",
        "Tec-9",
        "CZ75-Auto",
        "Dual Berettas",
        "Desert Eagle",
        "R8 Revolver"
    },
    ["Shotguns"] = { "Nova", "MAG-7", "Sawed-Off" },
    ["SMGs"] = {
        "MAC-10",
        "MP9",
        "MP5-SD",
        "UMP-45",
        "PP-Bizon"
    },
    ["ElevenPoint"] = { "XM1014", "MP7", "P90" },
    ["AssaultRifles"] = {
        "AK-47",
        "M4A1-S",
        "M4A4",
        "AUG",
        "SG 553",
        "FAMAS",
        "Galil AR",
        "SSG 08"
    },
    ["SniperRifles"] = { "AWP", "SCAR-20", "G3SG1" },
    ["MachineGuns"] = { "Negev", "M249" }
}
local v2 = {}
for _, v3 in ipairs(v1.Knife) do
    v2[v3] = 20
end
for _, v4 in ipairs(v1.Pistols) do
    v2[v4] = 12
end
for _, v5 in ipairs(v1.Shotguns) do
    v2[v5] = 12
end
for _, v6 in ipairs(v1.SMGs) do
    v2[v6] = 12
end
for _, v7 in ipairs(v1.ElevenPoint) do
    v2[v7] = 11
end
for _, v8 in ipairs(v1.AssaultRifles) do
    v2[v8] = 11
end
for _, v9 in ipairs(v1.SniperRifles) do
    v2[v9] = 10
end
for _, v10 in ipairs(v1.MachineGuns) do
    v2[v10] = 10
end
v2["Zeus x27"] = 12
local v11 = {
    ["Kill"] = {
        ["Default"] = 2,
        ["NearObjective"] = 3
    },
    ["DeathmatchKill"] = v2,
    ["DeathmatchKillDefault"] = 11,
    ["Assist"] = {
        ["Default"] = 1,
        ["Deathmatch"] = 6
    },
    ["BombPlant"] = 2,
    ["BombExplodePlanter"] = 1,
    ["BombExplodeAlive"] = 1,
    ["BombDefuseWithEnemies"] = 4,
    ["BombDefuseNoEnemies"] = 2,
    ["BombDefuseAlive"] = 1,
    ["HostagePickup"] = 1,
    ["HostageRescueFirst"] = 4,
    ["HostageRescueSubsequent"] = 1,
    ["HostageRescueAlive"] = 1,
    ["TeamKill"] = -2,
    ["Suicide"] = -2,
    ["CasualParticipation"] = 1,
    ["ObjectiveProximityDistance"] = 15
}
return table.freeze(v11)