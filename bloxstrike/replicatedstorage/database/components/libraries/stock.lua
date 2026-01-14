-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_u_replicatedstorage.Database.Custom.Types)
local v_u2 = {
	"USP-S",
	"Glock-18",
	"P250",
	"Desert Eagle",
	"Tec-9",
	"CZ75-Auto",
	"Five-SeveN",
	"Dual Berettas",
	"R8 Revolver",
	"MAC-10",
	"MP9",
	"MP7",
	"MP5-SD",
	"UMP-45",
	"P90",
	"PP-Bizon",
	"AK-47",
	"M4A1-S",
	"M4A4",
	"AUG",
	"SG 553",
	"FAMAS",
	"Galil AR",
	"AWP",
	"SSG 08",
	"SCAR-20",
	"G3SG1",
	"XM1014",
	"Nova",
	"MAG-7",
	"Sawed-Off",
	"Negev",
	"M249",
	"CT Knife",
	"T Knife",
	"CT Glove",
	"T Glove",
	"Molotov",
	"Incendiary Grenade",
	"HE Grenade",
	"Flashbang",
	"Smoke Grenade",
	"Decoy Grenade",
	"C4",
	"Zeus x27"
}
local function v_u3(arg1)
	-- upvalues: (copy) v_u_replicatedstorage
	if arg1 == "Zeus x27" then
		return "Zeus x27"
	end
	if arg1 == "C4" then
		return "C4"
	end
	local v1 = v_u_replicatedstorage.Database.Custom.Weapons:FindFirstChild(arg1)
	if not v1 then
		return "Weapon"
	end
	local v_class = require(v1).Class
	return v_class == "Weapon" and "Weapon" or (v_class == "Melee" and "Melee" or (v_class == "Glove" and "Glove" or (v_class == "Grenade" and "Grenade" or (v_class == "C4" and "C4" or "Weapon"))))
end
local function v_u4(arg1)
	-- upvalues: (copy) v_u3
	local v1 = {
		["_id"] = arg1 .. "_Stock",
		["Type"] = v_u3(arg1),
		["Serial"] = 0,
		["Name"] = arg1,
		["Skin"] = "Stock",
		["Float"] = 1,
		["StatTrack"] = false,
		["IsTradeable"] = false,
		["NameTag"] = false,
		["Charm"] = false,
		["Stickers"] = {},
		["MetaData"] = {
			["LastTradeAt"] = 0,
			["CreatedAt"] = 0,
			["TradeHistory"] = {},
			["OriginalOwner"] = 0,
			["Owner"] = 0,
			["Origin"] = "Stock"
		}
	}
	return v1
end
function v_u1.IsStockIdentifier(arg1)
	return string.sub(arg1, -6) == "_Stock"
end
function v_u1.GetWeaponNameFromStockId(arg1)
	-- upvalues: (copy) v_u1
	if v_u1.IsStockIdentifier(arg1) then
		return string.sub(arg1, 1, -7)
	else
		return nil
	end
end
function v_u1.GenerateStockInventoryItems()
	-- upvalues: (copy) v_u2, (copy) v_u4
	local v1 = {}
	for _, v2 in ipairs(v_u2) do
		local v3 = v_u4(v2)
		table.insert(v1, v3)
	end
	return v1
end
function v_u1.InjectStockItems(arg1)
	-- upvalues: (copy) v_u1
	local v_generatestockinventoryitems = v_u1.GenerateStockInventoryItems()
	local v1 = {}
	local v2 = {}
	for _, v3 in ipairs(arg1) do
		v1[v3._id] = true
		if v3.Skin == "Stock" then
			v2[v3.Name] = true
		end
	end
	for _, v4 in ipairs(v_generatestockinventoryitems) do
		if not (v1[v4._id] or v2[v4.Name]) then
			table.insert(arg1, v4)
		end
	end
	return arg1
end
return v_u1