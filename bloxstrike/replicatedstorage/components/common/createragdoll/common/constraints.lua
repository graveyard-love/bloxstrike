-- Decompiled with Bunni.lol Decompiler

local v1 = {
	["UpperTorso"] = {
		["TwistLimitsEnabled"] = true,
		["LimitsEnabled"] = true,
		["TwistLowerAngle"] = -10,
		["TwistUpperAngle"] = 10,
		["Restitution"] = 0.1,
		["UpperAngle"] = 20
	},
	["LowerTorso"] = {
		["TwistLimitsEnabled"] = true,
		["LimitsEnabled"] = true,
		["TwistLowerAngle"] = -10,
		["TwistUpperAngle"] = 10,
		["Restitution"] = 0.1,
		["UpperAngle"] = 20
	},
	["Default"] = {
		["TwistLimitsEnabled"] = true,
		["LimitsEnabled"] = true,
		["TwistLowerAngle"] = -25,
		["TwistUpperAngle"] = 25,
		["Restitution"] = 0.1,
		["UpperAngle"] = 45
	}
}
return table.freeze(v1)