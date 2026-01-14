-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_replicatedstorage.Database.Custom.Types)
local v1 = require(v_replicatedstorage.Packages.Sift)
local v2 = {
	["LayoutOrder"] = 0,
	["Search"] = {
		"Badge",
		"Zeus x27",
		"C4",
		"Graffiti",
		"Charm",
		"Charm Capsule",
		"Sticker",
		"Sticker Capsule",
		"Music Kit",
		"Weapon",
		"Glove",
		"Melee",
		"Case"
	}
}
local v3 = {
	["Everything"] = {
		["Default"] = v2
	}
}
local v4 = {
	["All Equipment"] = v2,
	["Melee"] = {
		["Search"] = { "Melee" },
		["LayoutOrder"] = 1
	},
	["Pistols"] = {
		["Search"] = { "Weapon:Pistol" },
		["LayoutOrder"] = 2
	},
	["Mid-Tier"] = {
		["Search"] = { "Weapon:Heavy", "Weapon:SMG" },
		["LayoutOrder"] = 3
	},
	["Rifles"] = {
		["Search"] = { "Weapon:Rifle" },
		["LayoutOrder"] = 4
	},
	["Misc"] = {
		["Search"] = { "Zeus x27", "C4" },
		["LayoutOrder"] = 5
	},
	["Gloves"] = {
		["Search"] = { "Glove" },
		["LayoutOrder"] = 6
	},
	["Music Kits"] = {
		["Search"] = { "Music Kit" },
		["LayoutOrder"] = 7
	}
}
v3.Equipment = v4
local v5 = {
	["All Graphic Art"] = {
		["Search"] = {
			"Badge",
			"Graffiti",
			"Charm",
			"Sticker"
		},
		["LayoutOrder"] = 0
	},
	["Badges"] = {
		["Search"] = { "Badge" },
		["LayoutOrder"] = 1
	},
	["Stickers"] = {
		["Search"] = { "Sticker" },
		["LayoutOrder"] = 2
	},
	["Graffiti"] = {
		["Search"] = { "Graffiti" },
		["LayoutOrder"] = 3
	},
	["Charms"] = {
		["Search"] = { "Charm" },
		["LayoutOrder"] = 4
	}
}
v3["Graphic Art"] = v5
local v6 = {
	["All"] = {
		["Search"] = { "Case", "Charm Capsule", "Sticker Capsule" },
		["LayoutOrder"] = 0
	},
	["Cases"] = {
		["Search"] = { "Case" },
		["LayoutOrder"] = 1
	},
	["Capsules"] = {
		["Search"] = { "Charm Capsule", "Sticker Capsule" },
		["LayoutOrder"] = 2
	}
}
v3.Display = v6
return v1.Dictionary.freezeDeep(v3)