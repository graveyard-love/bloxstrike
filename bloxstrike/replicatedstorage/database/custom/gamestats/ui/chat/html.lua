-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_replicatedstorage.Database.Custom.Types)
local v1 = {}
v1.Badges = table.freeze({
	["Verified"] = utf8.char(57344)
})
v1.Roles = table.freeze({
	[255] = "<font color=\"rgb(84, 210, 101)\">[OWNER] </font>",
	[254] = "<font color=\"rgb(84, 210, 101)\">[OWNER] </font>",
	[253] = "<font color=\"rgb(17, 247, 255)\">[DEV] </font>",
	[252] = "<font color=\"rgb(17, 247, 255)\">[DEV] </font>",
	[251] = "<font color=\"rgb(0, 0, 255)\">[MOD] </font>",
	[6] = "<font color=\"rgb(0, 0, 255)\">[MOD] </font>",
	[5] = "<font color=\"rgb(0, 0, 255)\">[MOD] </font>",
	[4] = "<font color=\"rgb(255, 17, 0)\">[CC] </font>",
	[3] = "<font color=\"rgb(128, 0, 128)\">[CONTRIBUTOR] </font>",
	[2] = "<font color=\"rgb(255, 255, 0)\">[TESTER] </font>",
	[1] = "<font color=\"rgb(255, 255, 0)\">[MEMBER] </font>"
})
v1.Money = table.freeze({
	["Kill"] = "<font color=\"rgb(85,255,85)\">+$%d</font> <font color=\"rgb(255,255,255)\">for %s kill%s</font>",
	["Assist"] = "<font color=\"rgb(85,255,85)\">+$%d</font> <font color=\"rgb(255,255,255)\">for assist</font>",
	["BombPlant"] = "<font color=\"rgb(85,255,85)\">+$%d</font> <font color=\"rgb(255,255,255)\">for planting the bomb</font>",
	["BombDefuse"] = "<font color=\"rgb(85,255,85)\">+$%d</font> <font color=\"rgb(255,255,255)\">for defusing the bomb</font>",
	["RoundWin"] = "<font color=\"rgb(85,255,85)\">+$%d</font> <font color=\"rgb(255,255,255)\">for winning the round</font>",
	["RoundLoss"] = "<font color=\"rgb(85,255,85)\">+$%d</font> <font color=\"rgb(255,255,255)\">round loss bonus</font>",
	["CTTeamKillBonus"] = "<font color=\"rgb(85,255,85)\">+$%d</font> <font color=\"rgb(255,255,255)\">team bonus</font>",
	["HostageShotPenalty"] = "<font color=\"rgb(255,85,85)\">-$%d</font> <font color=\"rgb(255,255,255)\">penalty for shooting a hostage</font>"
})
v1.TeamJoinMessages = table.freeze({
	["Terrorists"] = "<font color=\"rgb(223,171,57)\">%s is joining the Terrorists</font>",
	["Counter-Terrorists"] = "<font color=\"rgb(95,153,217)\">%s is joining the Counter-Terrorists</font>",
	["Spectators"] = "<font color=\"rgb(255,255,255)\">%s is joining the Spectators</font>"
})
v1.TeamColors = table.freeze({
	["Counter-Terrorists"] = "<font color=\"rgb(163,198,255)\">%s</font> ",
	["Terrorists"] = "<font color=\"rgb(255,223,148)\">%s</font> ",
	["Spectators"] = "<font color=\"rgb(255,255,255)\">%s</font> "
})
v1.Prefixes = table.freeze({
	["All"] = "<font color=\"rgb(255,255,255)\">[ALL]</font> ",
	["Team"] = "<font color=\"rgb(255,255,255)\">[TEAM]</font> "
})
v1.Points = table.freeze({
	["Deathmatch"] = "<font color=\"rgb(163,255,72)\">%d</font> <font color=\"rgb(255,255,255)\">points for neutralizing an enemy with the %s</font>"
})
v1.Suffixes = table.freeze({
	["Dead"] = "<font color=\"rgb(255,64,64)\">*DEAD*</font>"
})
v1.PlayerLeave = "<font color=\"rgb(198,203,208)\">%s disconnected</font>"
return table.freeze(v1)