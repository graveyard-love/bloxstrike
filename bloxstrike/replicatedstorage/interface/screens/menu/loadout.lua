-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_contentprovider = game:GetService("ContentProvider")
local v_u_userinput = game:GetService("UserInputService")
local v_u_gamepad = game:GetService("GamepadService")
local v_u_tween = game:GetService("TweenService")
local v_u_run = game:GetService("RunService")
local v_u_gui = game:GetService("GuiService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u_playergui = v_u_localplayer:WaitForChild("PlayerGui")
local v_u2 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u3 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u4 = require(v_u_replicatedstorage.Database.Components.Libraries.Skins)
local v_u5 = require(v_u_replicatedstorage.Database.Components.Libraries.Cases)
local v6 = require(v_u_replicatedstorage.Database.Components.Libraries.Collections)
local v_u7 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u8 = require(v_u_replicatedstorage.Interface.MenuState)
local v_u9 = require(v_u_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u10 = require(v_u_replicatedstorage.Database.Custom.GameStats.Rarities)
local v_u11 = require(v_u_replicatedstorage.Database.Custom.GameStats.UI.Inventory.WeaponDropShadows)
local v_u_characters = v_u_replicatedstorage.Assets.Characters
local v_new = CFrame.new(0, 0.025, 0.4)
local v_u12 = {
	["CT"] = {
		["Character"] = "IDF",
		["CameraOffset"] = CFrame.new(0, 0.2, -8) * CFrame.Angles(0, -3.141592653589793, 0),
		["CharacterOffset"] = v_new,
		["IdleAnimation"] = "rbxassetid://137360078752983"
	},
	["T"] = {
		["Character"] = "Anarchist",
		["CameraOffset"] = CFrame.new(0, 0.2, -8) * CFrame.Angles(0, -3.141592653589793, 0),
		["CharacterOffset"] = v_new,
		["IdleAnimation"] = "rbxassetid://99540873384647"
	}
}
local v_u13 = {
	["Melee"] = {
		["Default"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Melee.Default,
		["Butterfly Knife"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Melee["Butterfly Knife"],
		["M9 Bayonet"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Melee["M9 Bayonet"],
		["Flip Knife"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Melee["Flip Knife"],
		["Gut Knife"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Melee["Gut Knife"],
		["Karambit"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Melee.Karambit
	},
	["SMG"] = {
		["Default"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.SMG.Default,
		["MAC-10"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.SMG["MAC-10"],
		["P90"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.SMG.P90
	},
	["Sniper"] = {
		["Default"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Sniper.Default,
		["AWP"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Sniper.AWP
	},
	["LMG"] = {
		["Default"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.LMG.Default,
		["Negev"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.LMG.Negev
	},
	["Pistol"] = {
		["Default"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Pistol.Default,
		["Dual Berettas"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Pistol["Dual Berettas"]
	},
	["Heavy"] = {
		["Default"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Heavy.Default
	},
	["Rifle"] = {
		["Default"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Rifle.Default,
		["FAMAS"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Rifle.FAMAS,
		["Galil AR"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Rifle["Galil AR"],
		["M4A1-S"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Rifle["M4A1-S"],
		["AUG"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Rifle.AUG,
		["SG 553"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Rifle["SG 553"],
		["M4A4"] = v_u_replicatedstorage.Assets.UI.Loadout.Animations.Rifle.M4A4
	}
}
local v_u14 = {
	["AWP"] = "UpperTorso",
	["C4"] = "LeftHand"
}
local v_u15 = {
	["Right Arm"] = "RightGlove",
	["Left Arm"] = "LeftGlove"
}
local v_u16 = {
	["Right Arm"] = "RightHand",
	["Left Arm"] = "LeftHand"
}
local v_u17 = "Counter-Terrorists"
local v_u18 = nil
local v_u_newest = "Newest"
local v_u19 = false
local v_u20 = nil
local v_u21 = nil
local v_u22 = nil
local v_u23 = nil
local v_u24 = nil
local v_u25 = nil
local v_u26 = nil
local v_u27 = nil
local v_u28 = false
local v_u29 = nil
local v_u30 = false
local v_u31 = nil
local v_u32 = nil
local v_u33 = nil
local v_u34 = false
local v_u35 = false
local v_u36 = false
local v_u37 = false
local v_u38 = nil
local v_u39 = nil
local v_u40 = nil
local v_u41 = nil
local v_u42 = {}
local v_u43 = {
	["CT"] = nil,
	["T"] = nil
}
local v_u44 = {
	["CT"] = nil,
	["T"] = nil
}
local v_u45 = {
	["CT"] = {},
	["T"] = {}
}
local v_u46 = {}
local v_u47 = {
	["CT"] = nil,
	["T"] = nil
}
local v_u48 = {}
local v_u49 = 0
local v_u50 = false
local v_u51 = false
local v_u_fromscale = UDim2.fromScale(0.2, 0.2)
local v_u_new = Vector2.new(0, 0)
local v_u52 = {
	["Melee"] = 1,
	["Glove"] = 2,
	["Badge"] = 7,
	["Music Kit"] = 8,
	["Charm"] = 9,
	["Sticker"] = 10,
	["Graffiti"] = 11,
	["Case"] = 12,
	["Charm Capsule"] = 13,
	["Sticker Capsule"] = 14,
	["Zeus x27"] = 3,
	["C4"] = 15,
	["Grenade"] = 16
}
local v_u53 = {
	["Pistol"] = 3,
	["SMG"] = 4,
	["Heavy"] = 5,
	["Rifle"] = 6,
	["Equipment"] = 17,
	["Miscellaneous"] = 18
}
local v_u54 = {
	["Pistol"] = "Pistols",
	["SMG"] = "Mid Tier",
	["Heavy"] = "Mid Tier",
	["Rifle"] = "Rifles"
}
local v_u55 = {
	["Incendiary Grenade"] = true,
	["Decoy Grenade"] = true,
	["Smoke Grenade"] = true,
	["HE Grenade"] = true,
	["Flashbang"] = true,
	["Molotov"] = true
}
local v_u56 = {
	["Charm"] = true,
	["Charm Capsule"] = true,
	["Sticker"] = true,
	["Sticker Capsule"] = true,
	["Grenade"] = true,
	["Case"] = true
}
local v_u57 = {
	["Pistol"] = 1,
	["SMG"] = 2,
	["Heavy"] = 3,
	["Rifle"] = 4,
	["Equipment"] = 5,
	["Miscellaneous"] = 6
}
local v_u58 = {
	["Forbidden"] = 7,
	["Special"] = 6,
	["Red"] = 5,
	["Pink"] = 4,
	["Purple"] = 3,
	["Blue"] = 2,
	["Stock"] = 1
}
local v_u59 = {
	["Glove"] = "Equipped Gloves",
	["Melee"] = "Equipped Melee",
	["Zeus x27"] = "Equipped Zeus x27",
	["Badge"] = "Equipped Badge",
	["Music Kit"] = "Equipped Music Kit",
	["Graffiti"] = "Equipped Graffiti"
}
local v_u60 = {
	["Equipped Gloves"] = "Gloves",
	["Equipped Melee"] = "Melee",
	["Equipped Zeus x27"] = "Zeus",
	["Equipped Badge"] = "Badge",
	["Equipped Music Kit"] = "Music Kit",
	["Equipped Graffiti"] = "Graffiti"
}
local v_u61 = {
	["Terrorists"] = { "Glock-18" },
	["Counter-Terrorists"] = { "USP-S", "P2000" }
}
local v_u62 = nil
local function v_u63(arg1, arg2)
	for _, v1 in ipairs(arg1:GetChildren()) do
		if not table.find(arg2, v1.Name) then
			v1:Destroy()
		end
	end
end
local function v_u64()
	-- upvalues: (ref) v_u39, (ref) v_u62, (copy) v_u3
	if v_u39 then
		local v1 = v_u39
		local v_actionframe = v_u62.ActionFrame
		if v_actionframe then
			v_actionframe.Visible = false
		end
		v_u39 = nil
		v_u3.broadcastRouter("WeaponInspect", v1.Name, v1.Skin, v1.Float, v1.StatTrack, v1.NameTag, v1.Charm, v1.Stickers, v1.Type, v1.Pattern, v1._id, v1.Serial, v1.IsTradeable)
	end
end
local v_u65 = {
	["Pistols"] = 1,
	["Mid Tier"] = 2,
	["Rifles"] = 3
}
local v_u66 = {
	["Equipped Melee"] = 1,
	["Equipped Gloves"] = 2,
	["Equipped Badge"] = 3,
	["Equipped Music Kit"] = 4,
	["Equipped Graffiti"] = 5,
	["Equipped Zeus x27"] = 6
}
local function v_u67(arg1)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u65, (copy) v_u66
	local v_get = v_u2.Get(v_u_localplayer, "Loadout")
	if not v_get then
		return nil
	end
	local v1 = nil
	for _, v2 in ipairs({ "Counter-Terrorists", "Terrorists" }) do
		local v3 = v_get[v2]
		if v3 and v3.Loadout then
			for v4, v5 in pairs(v_u65) do
				if v5 and (v3.Loadout[v4] and v3.Loadout[v4].Options) then
					for v6, v7 in ipairs(v3.Loadout[v4].Options) do
						if v7 == arg1 then
							local v8 = v5 * 1000 + v6
							if not v1 or v8 < v1 then
								v1 = v8
							end
						end
					end
				end
			end
			if v3.Equipped then
				for v9, v10 in pairs(v3.Equipped) do
					if v10 == arg1 then
						local v11 = v_u66[v9] or 99
						if not v1 or v11 < v1 then
							v1 = v11
						end
					end
				end
			end
		end
	end
	return v1
end
local v_u68 = nil
v6.ObserveAvailableCollections(function(arg1)
	-- upvalues: (ref) v_u68
	v_u68 = arg1
end)
local v_u69 = {
	["Melee"] = 1,
	["Glove"] = 2,
	["Case"] = 3
}
local function v_u70(arg1)
	-- upvalues: (copy) v_u5, (ref) v_u68, (copy) v_u4
	if arg1.Type ~= "Case" then
		local v_getskininformation = v_u4.GetSkinInformation(arg1.Name, arg1.Skin)
		return v_getskininformation and v_getskininformation.collection or nil
	end
	local v_getcasebyname = v_u5.GetCaseByName(arg1.Skin)
	if not (v_getcasebyname and v_u68) then
		return nil
	end
	for _, v1 in ipairs(v_u68) do
		if v1.cases then
			for _, v2 in ipairs(v1.cases) do
				if v2 == v_getcasebyname.name then
					return v1.name
				end
			end
		end
	end
	return nil
end
local function v_u71(arg1)
	-- upvalues: (copy) v_u70, (copy) v_u69, (copy) v_u4, (copy) v_u58, (copy) v_u67, (copy) v_u52, (copy) v_u9, (copy) v_u53
	return arg1 == "Alphabetical" and function(arg1, arg2)
		local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
		if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
			local v2
			if arg1.Type == "Case" then
				v2 = arg1.Skin or ""
			else
				v2 = (arg1.Name or "") .. "|" .. (arg1.Skin or "")
			end
			local v3
			if arg2.Type == "Case" then
				v3 = arg2.Skin or ""
			else
				v3 = (arg2.Name or "") .. "|" .. (arg2.Skin or "")
			end
			if v2 == v3 then
				local v4 = arg1.MetaData and (arg1.MetaData.CreatedAt or 0) or 0
				local v5 = arg2.MetaData and (arg2.MetaData.CreatedAt or 0) or 0
				if v4 == v5 then
					return (arg1._id or "") < (arg2._id or "")
				else
					return v5 < v4
				end
			else
				return v2 < v3
			end
		else
			return v1
		end
	end or (arg1 == "Collection" and function(arg1, arg2)
		-- upvalues: (ref) v_u70, (ref) v_u69, (ref) v_u4, (ref) v_u58
		local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
		if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
			local v2 = v_u70(arg1) or ""
			local v3 = v_u70(arg2) or ""
			if v2 == v3 then
				local v4 = v_u69[arg1.Type] or 4
				local v5 = v_u69[arg2.Type] or 4
				if v4 == v5 then
					local v_getskininformation = v_u4.GetSkinInformation(arg1.Name, arg1.Skin)
					local v_getskininformation = v_u4.GetSkinInformation(arg2.Name, arg2.Skin)
					local v6 = v_getskininformation and v_u58[v_getskininformation.rarity] or 0
					local v7 = v_getskininformation and v_u58[v_getskininformation.rarity] or 0
					if v6 == v7 then
						local v8
						if arg1.Type == "Case" then
							v8 = arg1.Skin or ""
						else
							v8 = (arg1.Name or "") .. "|" .. (arg1.Skin or "")
						end
						local v9
						if arg2.Type == "Case" then
							v9 = arg2.Skin or ""
						else
							v9 = (arg2.Name or "") .. "|" .. (arg2.Skin or "")
						end
						if v8 == v9 then
							return (arg1.MetaData and arg1.MetaData.CreatedAt or 0) > (arg2.MetaData and arg2.MetaData.CreatedAt or 0)
						else
							return v8 < v9
						end
					else
						return v7 < v6
					end
				else
					return v4 < v5
				end
			else
				return v2 < v3
			end
		else
			return v1
		end
	end or (arg1 == "Equipped" and function(arg1, arg2)
		-- upvalues: (ref) v_u67
		local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
		if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
			local v2 = v_u67(arg1._id)
			local v3 = v_u67(arg2._id)
			if v2 ~= nil == (v3 ~= nil) then
				if v2 and v3 then
					if v2 == v3 then
						local v4
						if arg1.Type == "Case" then
							v4 = arg1.Skin or ""
						else
							v4 = (arg1.Name or "") .. "|" .. (arg1.Skin or "")
						end
						local v5
						if arg2.Type == "Case" then
							v5 = arg2.Skin or ""
						else
							v5 = (arg2.Name or "") .. "|" .. (arg2.Skin or "")
						end
						if v4 == v5 then
							return (arg1.MetaData and arg1.MetaData.CreatedAt or 0) > (arg2.MetaData and arg2.MetaData.CreatedAt or 0)
						else
							return v4 < v5
						end
					else
						return v2 < v3
					end
				else
					local v6
					if arg1.Type == "Case" then
						v6 = arg1.Skin or ""
					else
						v6 = (arg1.Name or "") .. "|" .. (arg1.Skin or "")
					end
					local v7
					if arg2.Type == "Case" then
						v7 = arg2.Skin or ""
					else
						v7 = (arg2.Name or "") .. "|" .. (arg2.Skin or "")
					end
					if v6 == v7 then
						return (arg1.MetaData and arg1.MetaData.CreatedAt or 0) > (arg2.MetaData and arg2.MetaData.CreatedAt or 0)
					else
						return v6 < v7
					end
				end
			else
				return v2 ~= nil
			end
		else
			return v1
		end
	end or (arg1 == "Newest" and function(arg1, arg2)
		local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
		if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
			local v2 = arg1.MetaData and (arg1.MetaData.CreatedAt or 0) or 0
			local v3 = arg2.MetaData and (arg2.MetaData.CreatedAt or 0) or 0
			if v2 == v3 then
				local v4
				if arg1.Type == "Case" then
					v4 = arg1.Skin or ""
				else
					v4 = (arg1.Name or "") .. "|" .. (arg1.Skin or "")
				end
				local v5
				if arg2.Type == "Case" then
					v5 = arg2.Skin or ""
				else
					v5 = (arg2.Name or "") .. "|" .. (arg2.Skin or "")
				end
				if v4 == v5 then
					return (arg1._id or "") < (arg2._id or "")
				else
					return v4 < v5
				end
			else
				return v3 < v2
			end
		else
			return v1
		end
	end or (arg1 == "Quality" and function(arg1, arg2)
		-- upvalues: (ref) v_u4, (ref) v_u58
		local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
		if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
			local v_getskininformation = v_u4.GetSkinInformation(arg1.Name, arg1.Skin)
			local v_getskininformation = v_u4.GetSkinInformation(arg2.Name, arg2.Skin)
			local v2 = v_getskininformation and v_u58[v_getskininformation.rarity] or 0
			local v3 = v_getskininformation and v_u58[v_getskininformation.rarity] or 0
			if v2 == v3 then
				local v4
				if arg1.Type == "Case" then
					v4 = arg1.Skin or ""
				else
					v4 = (arg1.Name or "") .. "|" .. (arg1.Skin or "")
				end
				local v5
				if arg2.Type == "Case" then
					v5 = arg2.Skin or ""
				else
					v5 = (arg2.Name or "") .. "|" .. (arg2.Skin or "")
				end
				if v4 == v5 then
					return (arg1.MetaData and arg1.MetaData.CreatedAt or 0) > (arg2.MetaData and arg2.MetaData.CreatedAt or 0)
				else
					return v4 < v5
				end
			else
				return v3 < v2
			end
		else
			return v1
		end
	end or (arg1 == "Type" and function(arg1, arg2)
		-- upvalues: (ref) v_u52, (ref) v_u9, (ref) v_u53
		local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
		if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
			local v2 = v_u52[arg1.Type]
			local v3
			if v2 or arg1.Type ~= "Weapon" then
				v3 = v2 or 99
			else
				local v4, v5 = pcall(v_u9, arg1.Name)
				v3 = v4 and (v5 and v5.Type) and (v_u53[v5.Type] or 99) or 99
			end
			local v6 = v_u52[arg2.Type]
			local v7
			if v6 or arg2.Type ~= "Weapon" then
				v7 = v6 or 99
			else
				local v8, v9 = pcall(v_u9, arg2.Name)
				v7 = v8 and (v9 and v9.Type) and (v_u53[v9.Type] or 99) or 99
			end
			if v3 == v7 then
				local v10
				if arg1.Type == "Case" then
					v10 = arg1.Skin or ""
				else
					v10 = (arg1.Name or "") .. "|" .. (arg1.Skin or "")
				end
				local v11
				if arg2.Type == "Case" then
					v11 = arg2.Skin or ""
				else
					v11 = (arg2.Name or "") .. "|" .. (arg2.Skin or "")
				end
				if v10 == v11 then
					return (arg1.MetaData and arg1.MetaData.CreatedAt or 0) > (arg2.MetaData and arg2.MetaData.CreatedAt or 0)
				else
					return v10 < v11
				end
			else
				return v3 < v7
			end
		else
			return v1
		end
	end or nil)))))
end
local function v_u72()
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u71, (ref) v_u_newest, (copy) v_u56, (copy) v_u55, (copy) v_u59, (copy) v_u9, (ref) v_u17, (ref) v_u18
	local v_get = v_u2.Get(v_u_localplayer, "Inventory")
	if not v_get then
		return {}
	end
	local v1 = v_u71(v_u_newest)
	local v2 = {}
	local v3 = {}
	for _, v4 in ipairs(v_get) do
		if v4 and (v4._id and (not v2[v4._id] and (not v_u56[v4.Type] and (v4.Type ~= "Case" and (not v_u55[v4.Name] and (v4.Name and type(v4.Name) == "string")))))) then
			if v_u59[v4.Type] ~= nil then
				local v5, v6 = pcall(v_u9, v4.Name)
				local v7 = not (v5 and (v6 and v6.Team))
				local v_name = v4.Name
				local v8 = v_u17
				local v9
				if v_name and (type(v_name) == "string" and v_name ~= "") then
					local v10, v11 = pcall(v_u9, v_name)
					if v10 and (v11 and v11.Team) then
						v9 = v11.Team == "Both" and true or v11.Team == v8
					else
						v9 = false
					end
				else
					v9 = false
				end
				if v7 or v9 then
					v2[v4._id] = true
					table.insert(v3, v4)
				end
			else
				local v_name = v4.Name
				local v12 = v_u17
				local v13
				if v_name and (type(v_name) == "string" and v_name ~= "") then
					local v14, v15 = pcall(v_u9, v_name)
					if v14 and (v15 and v15.Team) then
						v13 = v15.Team == "Both" and true or v15.Team == v12
					else
						v13 = false
					end
				else
					v13 = false
				end
				if v13 then
					v2[v4._id] = true
					table.insert(v3, v4)
				else
					local v16, v17 = pcall(v_u9, v4.Name)
					if not (v16 and (v17 and v17.Team)) then
						v2[v4._id] = true
						table.insert(v3, v4)
					end
				end
			end
		end
	end
	if v_u18 then
		v3 = {}
		for _, v18 in ipairs(v3) do
			if v18.Type ~= "Case" and (v18.Type ~= "Charm Capsule" and (v18.Type ~= "Sticker Capsule" and (v18.Name and type(v18.Name) == "string"))) then
				local v19, v20 = pcall(v_u9, v18.Name)
				if v19 and (v20 and v20.Type == v_u18) then
					table.insert(v3, v18)
				end
			end
		end
	end
	if v1 then
		table.sort(v3, v1)
	end
	return v3
end
local function v_u73()
	-- upvalues: (ref) v_u62, (ref) v_u49, (ref) v_u48, (copy) v_u1
	if not v_u62 then
		return
	end
	local v_container = v_u62.Tabs.Container.Container
	local v_min = math.min(v_u49 + 25, #v_u48)
	for v1 = v_u49 + 1, v_min do
		local v2 = v_u48[v1]
		if v2 and not v_container:FindFirstChild(v2._id) then
			v_u1.CreateItemTemplate(v2)
		end
	end
	v_u49 = v_min
	for _, v3 in ipairs(v_container:GetChildren()) do
		if v3:IsA("Frame") and (v3.Name ~= "UIGridLayout" and (v3.Name ~= "UIListLayout" and v3.Name ~= "UIPadding")) then
			for v4, v5 in ipairs(v_u48) do
				if v5._id == v3.Name then
					v3.LayoutOrder = v4
					break
				end
			end
		end
	end
end
local function v_u74()
	-- upvalues: (ref) v_u62, (ref) v_u49, (ref) v_u48, (copy) v_u73
	if v_u62 then
		local v_container = v_u62.Tabs.Container.Container
		local v1 = v_container.AbsoluteCanvasSize.Y - v_container.AbsoluteSize.Y
		if v1 > 0 and (v_u49 < #v_u48 and v1 - v_container.CanvasPosition.Y < 200) then
			v_u73()
		end
	else
		return
	end
end
local function v_u75()
	-- upvalues: (ref) v_u62
	if not (v_u62 and v_u62.Visible) then
		return 50
	end
	local v_container = v_u62.Tabs.Container.Container
	local v_uigridlayout = v_container:FindFirstChildOfClass("UIGridLayout")
	if not v_uigridlayout then
		return 50
	end
	local v_absolutesize = v_container.AbsoluteSize
	local v_y = v_absolutesize.Y
	local v_x = v_absolutesize.X
	local v_cellsize = v_uigridlayout.CellSize
	local v_cellpadding = v_uigridlayout.CellPadding
	local v1 = v_cellsize.Y.Scale * v_y + v_cellsize.Y.Offset
	local v2 = v_cellpadding.Y.Scale * v_y + v_cellpadding.Y.Offset
	local v3 = v_cellsize.X.Scale * v_x + v_cellsize.X.Offset
	local v4 = v_cellpadding.X.Scale * v_x + v_cellpadding.X.Offset
	local v_uipadding = v_container:FindFirstChildOfClass("UIPadding")
	local v5, v6, v7, v8
	if v_uipadding then
		v5 = v_uipadding.PaddingTop.Scale * v_y + v_uipadding.PaddingTop.Offset
		v6 = v_uipadding.PaddingBottom.Scale * v_y + v_uipadding.PaddingBottom.Offset
		v7 = v_uipadding.PaddingLeft.Scale * v_x + v_uipadding.PaddingLeft.Offset
		v8 = v_uipadding.PaddingRight.Scale * v_x + v_uipadding.PaddingRight.Offset
	else
		v5 = 0
		v6 = 0
		v7 = 0
		v8 = 0
	end
	local v9 = v_y - v5 - v6
	local v10 = v_x - v7 - v8
	local v11
	if v3 + v4 > 0 then
		local v_floor = math.floor((v10 + v4) / UNNAMED_1728998324072)
		v11 = math.max(1, v_floor)
	else
		v11 = 1
	end
	local v12
	if v1 + v2 > 0 then
		local v_floor = math.floor((v9 + v2) / UNNAMED_1729001242600)
		v12 = math.max(1, v_floor)
	else
		v12 = 1
	end
	return v12 * v11 + v11
end
local function v_u76()
	-- upvalues: (ref) v_u62, (ref) v_u49, (copy) v_u75, (ref) v_u48, (copy) v_u1, (ref) v_u50
	if not (v_u62 and v_u62.Visible) then
		return
	end
	local v_container = v_u62.Tabs.Container.Container
	v_u49 = 0
	local v1 = v_u75()
	local v_max = math.max(v1, 50)
	local v_min = math.min(v_max, #v_u48)
	for v2 = 1, v_min do
		local v3 = v_u48[v2]
		if v3 and not v_container:FindFirstChild(v3._id) then
			v_u1.CreateItemTemplate(v3)
		end
	end
	for _, v4 in ipairs(v_container:GetChildren()) do
		if v4:IsA("Frame") and (v4.Name ~= "UIGridLayout" and (v4.Name ~= "UIListLayout" and v4.Name ~= "UIPadding")) then
			for v5, v6 in ipairs(v_u48) do
				if v6._id == v4.Name then
					v4.LayoutOrder = v5
					break
				end
			end
		end
	end
	v_u49 = v_min
	v_u50 = false
end
local function v_u77()
	-- upvalues: (ref) v_u62, (ref) v_u48, (ref) v_u49, (ref) v_u50, (copy) v_u76
	if v_u62 then
		local v_container = v_u62.Tabs.Container.Container
		local v1 = {}
		for _, v2 in ipairs(v_u48) do
			if v2 and v2._id then
				v1[v2._id] = true
			end
		end
		for _, v3 in ipairs(v_container:GetChildren()) do
			if v3:IsA("Frame") and (v3.Name ~= "UIGridLayout" and (v3.Name ~= "UIPadding" and not v1[v3.Name])) then
				v3:Destroy()
			end
		end
		v_u49 = 0
		v_u50 = true
		if v_u62.Visible then
			v_u76()
		end
	end
end
local function v_u78(arg1, arg2)
	-- upvalues: (copy) v_u_tween
	v_u_tween:Create(arg1, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["BackgroundTransparency"] = arg2 and 0.85 or 1
	}):Play()
end
local function v_u79(arg1, arg2)
	-- upvalues: (copy) v_u_tween
	local v_new = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local v1 = arg2 and 0 or 1
	for _, v2 in ipairs(arg1:GetChildren()) do
		if v2:IsA("Frame") and (v2:FindFirstChild("Price") and v2:FindFirstChild("WeaponName")) then
			v_u_tween:Create(v2:FindFirstChild("Price"), v_new, {
				["TextTransparency"] = v1
			}):Play()
			v_u_tween:Create(v2:FindFirstChild("WeaponName"), v_new, {
				["TextTransparency"] = v1
			}):Play()
		end
	end
end
local function v_u80(arg1, arg2)
	for _, v1 in ipairs(arg1:GetChildren()) do
		if v1:IsA("TextButton") then
			local v_frame = v1:FindFirstChild("Frame")
			if v_frame then
				local v2 = v1.Name == arg2
				v_frame.BackgroundTransparency = v2 and 0 or 1
				if v2 then
					v_frame.BackgroundColor3 = Color3.fromRGB(53, 83, 99)
				end
			end
		end
	end
end
local function v_u81(arg1, arg2, arg3, arg4, arg5)
	-- upvalues: (copy) v_u_replicatedstorage, (copy) v_u78
	local v_sortingtemplate = v_u_replicatedstorage.Assets.UI.Loadout:FindFirstChild("SortingTemplate")
	if not v_sortingtemplate then
		return nil
	end
	local v_u_clone = v_sortingtemplate:Clone()
	v_u_clone.Name = arg2
	v_u_clone.LayoutOrder = arg4
	v_u_clone.Parent = arg1
	local v_frame = v_u_clone:FindFirstChild("Frame")
	if v_frame then
		local v_textbutton = v_frame:FindFirstChild("TextButton")
		if v_textbutton then
			v_textbutton.Text = arg3
		end
		v_frame.BackgroundTransparency = 1
		v_frame.Active = false
	end
	v_u_clone.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u78, (copy) v_u_clone
		v_u78(v_u_clone, true)
	end)
	v_u_clone.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u78, (copy) v_u_clone
		v_u78(v_u_clone, false)
	end)
	v_u_clone.MouseButton1Click:Connect(arg5)
	return v_u_clone
end
local function v_u82(arg1)
	for _, v1 in ipairs(arg1:GetChildren()) do
		if v1:IsA("TextButton") then
			v1:Destroy()
		end
	end
end
local function v_u83()
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u56, (copy) v_u55, (copy) v_u9, (copy) v_u57
	local v_get = v_u2.Get(v_u_localplayer, "Inventory")
	if not v_get then
		return {}
	end
	local v1 = {}
	for _, v2 in ipairs(v_get) do
		if not (v_u56[v2.Type] or v_u55[v2.Name]) then
			local v3, v4 = pcall(v_u9, v2.Name)
			if v3 and (v4 and v4.Type) then
				v1[v4.Type] = true
			end
		end
	end
	local v5 = {}
	for v6 in pairs(v1) do
		table.insert(v5, v6)
	end
	table.sort(v5, function(arg1, arg2)
		-- upvalues: (ref) v_u57
		return (v_u57[arg1] or 99) < (v_u57[arg2] or 99)
	end)
	return v5
end
local function v_u84(arg1)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u56, (copy) v_u55, (copy) v_u9
	local v_get = v_u2.Get(v_u_localplayer, "Inventory")
	if not v_get then
		return {}
	end
	local v1 = {}
	for _, v2 in ipairs(v_get) do
		if not (v_u56[v2.Type] or v_u55[v2.Name]) then
			local v3, v4 = pcall(v_u9, v2.Name)
			if v3 and (v4 and (not arg1 or v4.Type == arg1)) then
				v1[v2.Name] = true
			end
		end
	end
	local v5 = {}
	for v6 in pairs(v1) do
		table.insert(v5, v6)
	end
	table.sort(v5)
	return v5
end
local function v_u85(arg1)
	-- upvalues: (copy) v_u_playergui
	local v_getguiobjectsatposition = v_u_playergui:GetGuiObjectsAtPosition(arg1.X, arg1.Y)
	for _, v1 in ipairs(v_getguiobjectsatposition) do
		if v1.Name ~= "DragIcon" and (v1:IsA("ViewportFrame") and v1.Name == "Player") then
			local v_parent = v1.Parent
			if v_parent and (v_parent.Name == "CT" or v_parent.Name == "T") then
				return true
			end
		end
	end
	return false
end
local function v_u86(arg1)
	-- upvalues: (copy) v_u4, (copy) v_u_fromscale
	local v_getskininformation = v_u4.GetSkinInformation(arg1.Name, arg1.Skin)
	if not v_getskininformation then
		return nil
	end
	local v_imagelabel = Instance.new("ImageLabel")
	v_imagelabel.Name = "DragIcon"
	v_imagelabel.Size = v_u_fromscale
	v_imagelabel.AnchorPoint = Vector2.new(0.5, 0.5)
	v_imagelabel.BackgroundTransparency = 1
	v_imagelabel.Image = v_u4.GetWearImageForFloat(v_getskininformation, arg1.Float or 0.9999) or v_getskininformation.imageAssetId or ""
	v_imagelabel.ScaleType = Enum.ScaleType.Fit
	v_imagelabel.ZIndex = 100
	v_imagelabel.Active = false
	return v_imagelabel
end
local function v_u87(arg1, arg2)
	-- upvalues: (ref) v_u62, (ref) v_u17, (copy) v_u61
	local v_teams = v_u62.Teams
	local v1 = (v_u17 == "Counter-Terrorists" and v_teams.GunsCT or v_teams.GunsT):FindFirstChild(arg1)
	if v1 then
		local v2 = 0
		for _, v3 in ipairs(v1:GetChildren()) do
			if v3:IsA("Frame") and (v3.Name ~= "Frame" and v3:FindFirstChild("Button")) then
				v2 = v2 + 1
				local v4
				if arg1 == "Pistols" and (v2 == 1 and arg2) then
					local v5 = v_u61[v_u17]
					if v5 then
						v4 = table.find(v5, arg2) ~= nil
					else
						v4 = false
					end
				else
					v4 = true
				end
				local v_moveframe = v3:FindFirstChild("MoveFrame")
				if v_moveframe and v_moveframe:IsA("GuiObject") then
					v_moveframe.Visible = v4
				end
				if v4 then
					local v_weapon = v3:FindFirstChild("Weapon")
					if v_weapon then
						local v_icon = v_weapon:FindFirstChild("Icon")
						if v_icon then
							v_icon.Size = UDim2.fromScale(0.9, 0.85)
						end
					end
				end
			end
		end
	end
end
local function v_u88()
	-- upvalues: (ref) v_u62, (ref) v_u17
	local v1 = v_u62.Teams:FindFirstChild(v_u17 == "Counter-Terrorists" and "CT" or "T")
	local v2 = v1 and v1:FindFirstChild("Player")
	if v2 then
		local v_moveframe = v2:FindFirstChild("MoveFrame")
		if v_moveframe and v_moveframe:IsA("GuiObject") then
			v_moveframe.Visible = true
		end
	end
end
local function v_u89()
	-- upvalues: (ref) v_u62
	local v_teams = v_u62.Teams
	for _, v1 in ipairs({ v_teams.GunsCT, v_teams.GunsT }) do
		for _, v2 in ipairs({ "Mid Tier", "Pistols", "Rifles" }) do
			local v3 = v1:FindFirstChild(v2)
			if v3 then
				for _, v4 in ipairs(v3:GetChildren()) do
					if v4:IsA("Frame") and v4.Name ~= "Frame" then
						local v_moveframe = v4:FindFirstChild("MoveFrame")
						if v_moveframe and v_moveframe:IsA("GuiObject") then
							v_moveframe.Visible = false
						end
						local v_weapon = v4:FindFirstChild("Weapon")
						if v_weapon then
							local v_icon = v_weapon:FindFirstChild("Icon")
							if v_icon then
								v_icon.Size = UDim2.fromScale(1, 0.95)
							end
						end
					end
				end
			end
		end
	end
	for _, v5 in ipairs({ "CT", "T" }) do
		local v6 = v_teams:FindFirstChild(v5)
		if v6 then
			local v_player = v6:FindFirstChild("Player")
			if v_player then
				local v_moveframe = v_player:FindFirstChild("MoveFrame")
				if v_moveframe and v_moveframe:IsA("GuiObject") then
					v_moveframe.Visible = false
				end
			end
		end
	end
end
local function v_u90(arg1)
	local v_parent = arg1.Parent
	if not (v_parent and v_parent:IsA("Frame")) then
		return nil, nil
	end
	local v_parent = v_parent.Parent
	if not (v_parent and v_parent:IsA("Frame")) then
		return nil, nil
	end
	local v_name = v_parent.Name
	if v_name ~= "Mid Tier" and (v_name ~= "Pistols" and v_name ~= "Rifles") then
		return nil, nil
	end
	local v1 = 0
	for _, v2 in ipairs(v_parent:GetChildren()) do
		if v2:IsA("Frame") and (v2.Name ~= "Frame" and v2:FindFirstChild("Button")) then
			v1 = v1 + 1
			if v2 == v_parent then
				return v_name, v1
			end
		end
	end
	return nil, nil
end
local function v_u91(arg1)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u90
	local v_get = v_u2.Get(v_u_localplayer, "Inventory")
	if not v_get then
		return nil, nil, nil
	end
	local v_parent = arg1.Parent
	if v_parent and v_parent:IsA("Frame") then
		local v_name = v_parent.Name
		local v1, v2 = v_u90(arg1)
		if v1 and v2 then
			for _, v4 in ipairs(v_get) do
				if v4._id == v_name then
					::l11::
					return v4, v1, v2
				end
			end
			local v4 = nil
			goto l11
		end
	end
	return nil, nil, nil
end
local function v_u92(self)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (ref) v_u29, (ref) v_u30, (ref) v_u31, (ref) v_u32, (ref) v_u33, (ref) v_u35, (copy) v_u_gui, (copy) v_u_gamepad, (ref) v_u62, (copy) v_u9, (copy) v_u54, (copy) v_u87, (copy) v_u59, (copy) v_u88, (copy) v_u91
	local v_get = v_u2.Get(v_u_localplayer, "Inventory")
	local v2
	if v_get then
		local v_parent = self.Parent
		if not (v_parent and v_parent:IsA("Frame")) then
			v2 = nil
			goto l3
		end
		local v_name = v_parent.Name
		for _, v2 in ipairs(v_get) do
			if v2._id == v_name then
				goto l3
			end
		end
		v2 = nil
		goto l3
	else
		v2 = nil
		::l3::
		if v2 then
			v_u29 = v2
			v_u30 = false
			v_u31 = self
			v_u32 = nil
			v_u33 = nil
			if not v_u35 then
				v_u35 = true
				v_u_gui.AutoSelectGuiEnabled = false
				v_u_gui.SelectedObject = nil
				pcall(function()
					-- upvalues: (ref) v_u_gamepad, (copy) self, (ref) v_u62
					v_u_gamepad:EnableGamepadCursor(self or v_u62)
				end)
			end
			local v3, v4 = pcall(v_u9, v2.Name)
			local v5
			if v3 and (v4 and v4.Type) then
				v5 = v_u54[v4.Type]
			else
				v5 = nil
			end
			if v5 then
				v_u87(v5, v2.Name)
				return
			elseif v_u59[v2.Type] then
				v_u88()
			else
				local v6, v7 = pcall(v_u9, v2.Name)
				if v6 and (v7 and (v7.Class == "Melee" or v7.Class == "Glove")) then
					v_u88()
				end
			end
		else
			local v8, v9, v10 = v_u91(self)
			if v8 and (v9 and v10) then
				v_u29 = v8
				v_u30 = true
				v_u31 = self
				v_u32 = v9
				v_u33 = v10
				if not v_u35 then
					v_u35 = true
					v_u_gui.AutoSelectGuiEnabled = false
					v_u_gui.SelectedObject = nil
					pcall(function()
						-- upvalues: (ref) v_u_gamepad, (copy) self, (ref) v_u62
						v_u_gamepad:EnableGamepadCursor(self or v_u62)
					end)
				end
				v_u87(v9, v8.Name)
			end
		end
	end
end
local function v_u93(arg1)
	-- upvalues: (copy) v_u_playergui
	local v_getguiobjectsatposition = v_u_playergui:GetGuiObjectsAtPosition(arg1.X, arg1.Y)
	for _, v1 in ipairs(v_getguiobjectsatposition) do
		if v1.Name ~= "DragIcon" and (v1:IsA("ImageButton") and (v1.Name == "Button" and v1.Parent)) then
			local v_parent = v1.Parent
			if v_parent:IsA("Frame") and v_parent.Parent then
				local v_parent = v_parent.Parent
				if v_parent:IsA("Frame") then
					local v_name = v_parent.Name
					if v_name == "Mid Tier" or (v_name == "Pistols" or v_name == "Rifles") then
						local v2 = 0
						local v3 = 1
						for _, v4 in ipairs(v_parent:GetChildren()) do
							if v4:IsA("Frame") and (v4.Name ~= "Frame" and v4:FindFirstChild("Button")) then
								v2 = v2 + 1
								if v4 == v_parent then
									v3 = v2
									break
								end
							end
						end
						return v_name, v3, v1
					end
				end
			end
		end
	end
	return nil, nil, nil
end
local function v_u94(arg1, arg2)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (ref) v_u17
	local v_get = v_u2.Get(v_u_localplayer, "Loadout")
	if not v_get then
		return false, nil
	end
	local v1 = v_get[v_u17]
	if not (v1 and (v1.Loadout and v1.Loadout[arg2])) then
		return false, nil
	end
	for v2, v3 in ipairs(v1.Loadout[arg2].Options) do
		if v3 == arg1 then
			return true, v2
		end
	end
	return false, nil
end
local function v_u95()
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (ref) v_u17
	-- failed to decompile
end
local function v_u96(arg1, arg2, arg3)
	-- upvalues: (ref) v_u37, (copy) v_u7, (ref) v_u17
	if v_u37 then
		return false
	end
	v_u37 = true
	v_u7.Inventory.EquipLoadoutSkin.Send({
		["Type"] = arg1,
		["Slot"] = arg2 - 1,
		["Team"] = v_u17,
		["Identifier"] = arg3
	})
	task.delay(5, function()
		-- upvalues: (ref) v_u37
		v_u37 = false
	end)
	return true
end
local function v_u97(arg1, arg2, arg3)
	-- upvalues: (ref) v_u37, (copy) v_u7, (ref) v_u17
	if v_u37 then
		return false
	end
	v_u37 = true
	v_u7.Inventory.SwapLoadoutSkins.Send({
		["Type"] = arg1,
		["SlotOne"] = arg2 - 1,
		["SlotTwo"] = arg3 - 1,
		["Team"] = v_u17
	})
	task.delay(5, function()
		-- upvalues: (ref) v_u37
		v_u37 = false
	end)
	return true
end
local function v_u98(arg1, arg2)
	-- upvalues: (ref) v_u37, (copy) v_u7, (ref) v_u17
	if v_u37 then
		return false
	end
	v_u37 = true
	v_u7.Inventory.EquipSpecialItem.Send({
		["Path"] = arg1,
		["Team"] = v_u17,
		["Identifier"] = arg2
	})
	task.delay(5, function()
		-- upvalues: (ref) v_u37
		v_u37 = false
	end)
	return true
end
local function v_u99()
	-- upvalues: (ref) v_u29, (copy) v_u_userinput, (copy) v_u_gui, (copy) v_u93, (ref) v_u17, (copy) v_u9, (ref) v_u30, (ref) v_u31, (ref) v_u32, (ref) v_u33, (ref) v_u36, (ref) v_u35, (copy) v_u_gamepad, (copy) v_u89, (copy) v_u54, (copy) v_u94, (copy) v_u97, (copy) v_u95, (copy) v_u96, (copy) v_u59, (copy) v_u85, (copy) v_u98
	if v_u29 then
		local v_getmouselocation = v_u_userinput:GetMouseLocation()
		local v_getguiinset = v_u_gui:GetGuiInset()
		local v_new = Vector2.new(v_getmouselocation.X - v_getguiinset.X, v_getmouselocation.Y - v_getguiinset.Y)
		local v1, v2, _ = v_u93(v_new)
		if v1 and v2 then
			local v_name = v_u29.Name
			local v3 = v_u17
			local v4
			if v_name and (type(v_name) == "string" and v_name ~= "") then
				local v5, v6 = pcall(v_u9, v_name)
				if v5 and (v6 and v6.Team) then
					v4 = v6.Team == "Both" and true or v6.Team == v3
				else
					v4 = false
				end
			else
				v4 = false
			end
			if v4 then
				local v7, v8 = pcall(v_u9, v_u29.Name)
				local v9
				if v7 and (v8 and v8.Type) then
					v9 = v_u54[v8.Type]
				else
					v9 = nil
				end
				if v9 == v1 then
					local v10, v11 = v_u94(v_u29._id, v1)
					if v10 and v11 then
						if v11 ~= v2 then
							v_u97(v1, v11, v2)
						end
					else
						local v12, v13 = v_u95(v_u29.Name, v1)
						if v12 and v13 then
							v_u96(v1, v13, v_u29._id)
						else
							v_u96(v1, v2, v_u29._id)
						end
					end
					v_u29 = nil
					v_u30 = false
					v_u31 = nil
					v_u32 = nil
					v_u33 = nil
					v_u36 = false
					if v_u35 then
						v_u35 = false
						pcall(function()
							-- upvalues: (ref) v_u_gamepad
							v_u_gamepad:DisableGamepadCursor()
						end)
						v_u_gui.AutoSelectGuiEnabled = true
					end
					v_u89()
				else
					v_u29 = nil
					v_u30 = false
					v_u31 = nil
					v_u32 = nil
					v_u33 = nil
					v_u36 = false
					if v_u35 then
						v_u35 = false
						pcall(function()
							-- upvalues: (ref) v_u_gamepad
							v_u_gamepad:DisableGamepadCursor()
						end)
						v_u_gui.AutoSelectGuiEnabled = true
					end
					v_u89()
				end
			else
				v_u29 = nil
				v_u30 = false
				v_u31 = nil
				v_u32 = nil
				v_u33 = nil
				v_u36 = false
				if v_u35 then
					v_u35 = false
					pcall(function()
						-- upvalues: (ref) v_u_gamepad
						v_u_gamepad:DisableGamepadCursor()
					end)
					v_u_gui.AutoSelectGuiEnabled = true
				end
				v_u89()
				return
			end
		else
			local v_type = v_u29.Type
			if v_type then
				v_type = v_u59[v_u29.Type]
			end
			if not v_type then
				local v14, v15 = pcall(v_u9, v_u29.Name)
				v_type = v14 and (v15 and (v15.Class == "Melee" or v15.Class == "Glove")) and true or v_type
			end
			if v_type and v_u85(v_new) then
				local v16 = v_u59[v_u29.Type]
				if not v16 then
					local v17, v18 = pcall(v_u9, v_u29.Name)
					if v17 and v18 then
						v16 = v18.Class == "Melee" and "Equipped Melee" or (v18.Class == "Glove" and "Equipped Gloves" or v16)
					end
				end
				if v16 then
					v_u98(v16, v_u29._id)
				end
				v_u29 = nil
				v_u30 = false
				v_u31 = nil
				v_u32 = nil
				v_u33 = nil
				v_u36 = false
				if v_u35 then
					v_u35 = false
					pcall(function()
						-- upvalues: (ref) v_u_gamepad
						v_u_gamepad:DisableGamepadCursor()
					end)
					v_u_gui.AutoSelectGuiEnabled = true
				end
				v_u89()
			else
				v_u29 = nil
				v_u30 = false
				v_u31 = nil
				v_u32 = nil
				v_u33 = nil
				v_u36 = false
				if v_u35 then
					v_u35 = false
					pcall(function()
						-- upvalues: (ref) v_u_gamepad
						v_u_gamepad:DisableGamepadCursor()
					end)
					v_u_gui.AutoSelectGuiEnabled = true
				end
				v_u89()
			end
		end
	else
		return
	end
end
local function v_u100()
	-- upvalues: (ref) v_u62, (ref) v_u29, (ref) v_u30, (ref) v_u31, (ref) v_u32, (ref) v_u33, (ref) v_u36, (ref) v_u35, (copy) v_u_gamepad, (copy) v_u_gui, (copy) v_u89
	if v_u62 and v_u62.Visible then
		if v_u29 then
			v_u29 = nil
			v_u30 = false
			v_u31 = nil
			v_u32 = nil
			v_u33 = nil
			v_u36 = false
			if v_u35 then
				v_u35 = false
				pcall(function()
					-- upvalues: (ref) v_u_gamepad
					v_u_gamepad:DisableGamepadCursor()
				end)
				v_u_gui.AutoSelectGuiEnabled = true
			end
			v_u89()
		end
	end
end
function v_u1.HandleSpecialItemDrop()
	-- upvalues: (ref) v_u21, (ref) v_u23, (copy) v_u59, (ref) v_u22, (copy) v_u9, (copy) v_u98
	if v_u21 and v_u23 then
		local v1 = v_u59[v_u23]
		if not v1 and v_u22 then
			local v2, v3 = pcall(v_u9, v_u22)
			if v2 and v3 then
				v1 = v3.Class == "Melee" and "Equipped Melee" or (v3.Class == "Glove" and "Equipped Gloves" or v1)
			end
		end
		if v1 then
			v_u98(v1, v_u21)
		end
	else
		return
	end
end
function v_u1.HandleDrop(arg1, arg2)
	-- upvalues: (ref) v_u21, (ref) v_u22, (ref) v_u17, (copy) v_u9, (copy) v_u54, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u94, (copy) v_u97, (copy) v_u95, (copy) v_u96
	if v_u21 and v_u22 then
		local v1 = v_u22
		local v2 = v_u17
		local v3
		if v1 and (type(v1) == "string" and v1 ~= "") then
			local v4, v5 = pcall(v_u9, v1)
			if v4 and (v5 and v5.Team) then
				v3 = v5.Team == "Both" and true or v5.Team == v2
			else
				v3 = false
			end
		else
			v3 = false
		end
		if v3 then
			local v6, v7 = pcall(v_u9, v_u22)
			local v8
			if v6 and (v7 and v7.Type) then
				v8 = v_u54[v7.Type]
			else
				v8 = nil
			end
			if v8 == arg1 then
				local v_get = v_u2.Get(v_u_localplayer, "Loadout")
				if v_get then
					local v9 = v_get[v_u17]
					if v9 and (v9.Loadout and v9.Loadout[arg1]) then
						if arg2 < 1 or #v9.Loadout[arg1].Options < arg2 then
							return
						else
							local v10, v11 = v_u94(v_u21, arg1)
							if v10 and v11 then
								if v11 ~= arg2 then
									v_u97(arg1, v11, arg2)
								end
								return
							else
								local v12, v13 = v_u95(v_u22, arg1)
								if v12 and v13 then
									v_u96(arg1, v13, v_u21)
								else
									v_u96(arg1, arg2, v_u21)
								end
							end
						end
					else
						return
					end
				else
					return
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v_u101(arg1)
	-- upvalues: (ref) v_u27, (ref) v_u25, (ref) v_u26, (ref) v_u28, (ref) v_u19, (copy) v_u86, (ref) v_u20, (ref) v_u21, (ref) v_u22, (ref) v_u23, (copy) v_u9, (copy) v_u54, (copy) v_u87, (copy) v_u59, (copy) v_u88, (copy) v_u_playergui, (copy) v_u_userinput, (copy) v_u_new, (ref) v_u24, (copy) v_u_run
	if v_u27 then
		v_u27:Disconnect()
		v_u27 = nil
	end
	v_u25 = nil
	v_u26 = nil
	v_u28 = false
	if v_u19 then
		return
	else
		local v1 = v_u86(arg1)
		if v1 then
			v_u19 = true
			v_u20 = v1
			v_u21 = arg1._id
			v_u22 = arg1.Name
			v_u23 = arg1.Type
			local v2, v3 = pcall(v_u9, arg1.Name)
			local v4
			if v2 and (v3 and v3.Type) then
				v4 = v_u54[v3.Type]
			else
				v4 = nil
			end
			if v4 then
				v_u87(v4, arg1.Name)
			elseif v_u59[arg1.Type] then
				v_u88()
			else
				local v5, v6 = pcall(v_u9, arg1.Name)
				if v5 and (v6 and (v6.Class == "Melee" or v6.Class == "Glove")) then
					v_u88()
				end
			end
			local v_maingui = v_u_playergui:FindFirstChild("MainGui")
			if v_maingui then
				v1.Parent = v_maingui
			else
				v1.Parent = v_u_playergui
			end
			local v_getmouselocation = v_u_userinput:GetMouseLocation()
			v1.Position = UDim2.fromOffset(v_getmouselocation.X + v_u_new.X, v_getmouselocation.Y + v_u_new.Y)
			v_u24 = v_u_run.RenderStepped:Connect(function()
				-- upvalues: (ref) v_u20, (ref) v_u_userinput, (ref) v_u_new
				if v_u20 then
					local v_getmouselocation = v_u_userinput:GetMouseLocation()
					v_u20.Position = UDim2.fromOffset(v_getmouselocation.X + v_u_new.X, v_getmouselocation.Y + v_u_new.Y)
				end
			end)
		end
	end
end
function v_u1.OnItemMouseDown(arg1, arg2)
	-- upvalues: (ref) v_u29, (ref) v_u35, (ref) v_u19, (ref) v_u25, (ref) v_u26, (copy) v_u_userinput, (ref) v_u28, (ref) v_u27, (copy) v_u_run, (copy) v_u101
	if v_u29 or v_u35 then
		return
	elseif not (v_u19 or v_u25) then
		v_u25 = arg1
		v_u26 = v_u_userinput:GetMouseLocation()
		v_u28 = arg2 or false
		v_u27 = v_u_run.RenderStepped:Connect(function()
			-- upvalues: (ref) v_u25, (ref) v_u26, (ref) v_u_userinput, (ref) v_u27, (ref) v_u28, (ref) v_u101
			if v_u25 and (v_u26 and (v_u_userinput:GetMouseLocation() - v_u26).Magnitude >= 10) then
				local v1 = v_u25
				if v_u27 then
					v_u27:Disconnect()
					v_u27 = nil
				end
				v_u25 = nil
				v_u26 = nil
				v_u28 = false
				v_u101(v1)
			end
		end)
	end
end
function v_u1.OnItemClick(arg1)
	-- upvalues: (ref) v_u62, (copy) v_u9, (ref) v_u18, (copy) v_u1, (copy) v_u2, (copy) v_u_localplayer
	local v_name = arg1.Name
	local v_container = v_u62.Tabs.Container.Container
	local v1, v2 = pcall(v_u9, v_name)
	if v1 and (v2 and v2.Type) then
		v_u18 = v2.Type
		v_u62.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = v2.Type
		v_u1.PopulateWeaponDropdown()
	end
	v_u62.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = v_name
	local v_get = v_u2.Get(v_u_localplayer, "Inventory")
	for _, v3 in ipairs(v_container:GetChildren()) do
		if v3:IsA("Frame") then
			local v_name = v3.Name
			for _, v5 in ipairs(v_get) do
				if v5._id == v_name then
					goto l11
				end
			end
			local v5 = nil
			::l11::
			if v5 then
				v3.Visible = v5.Name == v_name
			end
		end
	end
	local v_reset = v_u62.Tabs.Container.WeaponSort:FindFirstChild("Reset")
	if v_reset then
		v_reset.Visible = v_u18 ~= nil and true or v_u62.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text ~= "All Weapons"
	end
end
function v_u1.EndDrag()
	-- upvalues: (ref) v_u25, (ref) v_u19, (ref) v_u28, (ref) v_u27, (ref) v_u26, (copy) v_u1, (copy) v_u_userinput, (copy) v_u_gui, (ref) v_u23, (copy) v_u59, (ref) v_u22, (copy) v_u9, (copy) v_u85, (copy) v_u93, (ref) v_u24, (ref) v_u20, (ref) v_u21, (copy) v_u89
	if v_u25 and not v_u19 then
		local v1 = v_u25
		local v2 = v_u28
		if v_u27 then
			v_u27:Disconnect()
			v_u27 = nil
		end
		v_u25 = nil
		v_u26 = nil
		v_u28 = false
		if v2 then
			v_u1.OnItemClick(v1)
		end
		return
	elseif v_u19 then
		local v_getmouselocation = v_u_userinput:GetMouseLocation()
		local v_getguiinset = v_u_gui:GetGuiInset()
		local v_new = Vector2.new(v_getmouselocation.X - v_getguiinset.X, v_getmouselocation.Y - v_getguiinset.Y)
		local v3 = v_u23
		if v3 then
			v3 = v_u59[v_u23]
		end
		if not v3 and v_u22 then
			local v4, v5 = pcall(v_u9, v_u22)
			v3 = v4 and (v5 and (v5.Class == "Melee" or v5.Class == "Glove")) and true or v3
		end
		if v3 and v_u85(v_new) then
			v_u1.HandleSpecialItemDrop()
		else
			local v6, v7 = v_u93(v_new)
			if v6 and v7 then
				v_u1.HandleDrop(v6, v7)
			end
		end
		if v_u27 then
			v_u27:Disconnect()
			v_u27 = nil
		end
		v_u25 = nil
		v_u26 = nil
		v_u28 = false
		if v_u24 then
			v_u24:Disconnect()
			v_u24 = nil
		end
		if v_u20 then
			v_u20:Destroy()
			v_u20 = nil
		end
		v_u19 = false
		v_u21 = nil
		v_u22 = nil
		v_u23 = nil
		v_u89()
	end
end
function v_u1.CreateItemTemplate(self)
	-- upvalues: (copy) v_u4, (copy) v_u_replicatedstorage, (copy) v_u10, (ref) v_u62, (copy) v_u11, (copy) v_u_tween, (copy) v_u1, (ref) v_u29, (copy) v_u92
	local v_getskininformation = v_u4.GetSkinInformation(self.Name, self.Skin)
	if v_getskininformation then
		local v_u_clone = v_u_replicatedstorage.Assets.UI.Inventory.ItemTemplate:Clone()
		v_u_clone.Main.RarityFrame.UIGradient.Color = v_u10[v_getskininformation.rarity].ColorSequence
		v_u_clone.Main.Glow.UIGradient.Color = v_u10[v_getskininformation.rarity].ColorSequence
		v_u_clone.Parent = v_u62.Tabs.Container.Container
		v_u_clone.Main.Icon.Image = v_u4.GetWearImageForFloat(v_getskininformation, self.Float or 0.9999) or (v_getskininformation.imageAssetId or "")
		local v1 = self.StatTrack and "KillTrak\226\132\162 " .. self.Name or self.Name
		if self.Type == "Melee" then
			v1 = "\226\152\133 " .. v1
		end
		v_u_clone.Information.Weapon.Text = v1
		v_u_clone.Information.Skin.Text = self.Skin
		v_u_clone.Name = self._id
		local v2 = v_u11[self.Name]
		local v_u3
		if v2 then
			v_u3 = v_u_clone.Main.Icon:Clone()
			v_u3.Name = "DropShadow"
			v_u3.Image = v2
			v_u3.ImageTransparency = 1
			v_u3.ZIndex = v_u_clone.Main.Icon.ZIndex - 1
			v_u3.Parent = v_u_clone.Main
		else
			v_u3 = nil
		end
		local v_u_icon = v_u_clone.Main.Icon
		local v_u_position = v_u_icon.Position
		local v_u_new = UDim2.new(0, 0, -0.05, 0)
		local v_u_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		v_u_clone.Button.MouseEnter:Connect(function()
			-- upvalues: (copy) v_u_position, (copy) v_u_new, (ref) v_u_tween, (copy) v_u_icon, (copy) v_u_new, (ref) v_u3
			v_u_tween:Create(v_u_icon, v_u_new, {
				["Position"] = UDim2.new(v_u_position.X.Scale + v_u_new.X.Scale, v_u_position.X.Offset + v_u_new.X.Offset, v_u_position.Y.Scale + v_u_new.Y.Scale, v_u_position.Y.Offset + v_u_new.Y.Offset)
			}):Play()
			if v_u3 then
				v_u_tween:Create(v_u3, v_u_new, {
					["ImageTransparency"] = 0.3
				}):Play()
			end
		end)
		v_u_clone.Button.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_tween, (copy) v_u_icon, (copy) v_u_new, (copy) v_u_position, (ref) v_u3
			v_u_tween:Create(v_u_icon, v_u_new, {
				["Position"] = v_u_position
			}):Play()
			if v_u3 then
				v_u_tween:Create(v_u3, v_u_new, {
					["ImageTransparency"] = 1
				}):Play()
			end
		end)
		v_u_clone.Button.MouseButton1Down:Connect(function()
			-- upvalues: (ref) v_u1, (copy) self
			v_u1.OnItemMouseDown(self)
		end)
		v_u_clone.Button.Selectable = true
		v_u_clone.Button.SelectionGained:Connect(function()
			-- upvalues: (copy) v_u_position, (copy) v_u_new, (ref) v_u_tween, (copy) v_u_icon, (copy) v_u_new, (ref) v_u3
			v_u_tween:Create(v_u_icon, v_u_new, {
				["Position"] = UDim2.new(v_u_position.X.Scale + v_u_new.X.Scale, v_u_position.X.Offset + v_u_new.X.Offset, v_u_position.Y.Scale + v_u_new.Y.Scale, v_u_position.Y.Offset + v_u_new.Y.Offset)
			}):Play()
			if v_u3 then
				v_u_tween:Create(v_u3, v_u_new, {
					["ImageTransparency"] = 0.3
				}):Play()
			end
		end)
		v_u_clone.Button.SelectionLost:Connect(function()
			-- upvalues: (ref) v_u_tween, (copy) v_u_icon, (copy) v_u_new, (copy) v_u_position, (ref) v_u3
			v_u_tween:Create(v_u_icon, v_u_new, {
				["Position"] = v_u_position
			}):Play()
			if v_u3 then
				v_u_tween:Create(v_u3, v_u_new, {
					["ImageTransparency"] = 1
				}):Play()
			end
		end)
		v_u_clone.Button.Activated:Connect(function(arg1)
			-- upvalues: (ref) v_u29, (ref) v_u92, (copy) v_u_clone
			if arg1 and (arg1.UserInputType == Enum.UserInputType.Gamepad1 and not v_u29) then
				v_u92(v_u_clone.Button)
			end
		end)
	end
end
function v_u1.CreateLoadoutTemplate(arg1, arg2, arg3)
	-- upvalues: (copy) v_u4, (copy) v_u9, (copy) v_u_replicatedstorage, (copy) v_u10, (copy) v_u11, (copy) v_u_tween, (ref) v_u38, (copy) v_u1, (ref) v_u29, (copy) v_u92
	local v_getskininformation = v_u4.GetSkinInformation(arg2.Name, arg2.Skin)
	local v1, v2 = pcall(v_u9, arg2.Name)
	local v3 = v1 and (v2 and v2.Cost) or 0
	if v_getskininformation then
		local v_u_clone = v_u_replicatedstorage.Assets.UI.Loadout:FindFirstChild(arg3 == "Counter-Terrorists" and "LoadoutTemplateCT" or "LoadoutTemplateT"):Clone()
		v_u_clone:WaitForChild("Weapon")
		v_u_clone.Weapon:WaitForChild("Icon")
		v_u_clone.Weapon.Rarity.UIGradient.Color = v_u10[v_getskininformation.rarity].ColorSequence
		v_u_clone.Weapon.Glow.ImageColor3 = v_u10[v_getskininformation.rarity].Color
		v_u_clone.Parent = arg1
		v_u_clone.Name = arg2._id
		v_u_clone.Price.Text = "$" .. tostring(v3)
		v_u_clone.WeaponName.Text = arg2.Name
		v_u_clone.Weapon.Icon.Image = v_u4.GetWearImageForFloat(v_getskininformation, arg2.Float or 0.9999) or (v_getskininformation.imageAssetId or "")
		local v4 = v_u11[arg2.Name]
		local v_u5
		if v4 then
			v_u5 = v_u_clone.Weapon.Icon:Clone()
			v_u5.Name = "DropShadow"
			v_u5.Image = v4
			v_u5.ImageTransparency = 1
			v_u5.ZIndex = v_u_clone.Weapon.Icon.ZIndex - 1
			v_u5.Parent = v_u_clone.Weapon
		else
			v_u5 = nil
		end
		local v_u_icon = v_u_clone.Weapon.Icon
		local v_u_position = v_u_icon.Position
		local v_u_new = UDim2.new(0, 0, -0.05, 0)
		local v_u_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		v_u_clone.Button.MouseEnter:Connect(function()
			-- upvalues: (copy) v_u_position, (copy) v_u_new, (ref) v_u_tween, (copy) v_u_icon, (copy) v_u_new, (ref) v_u5
			v_u_tween:Create(v_u_icon, v_u_new, {
				["Position"] = UDim2.new(v_u_position.X.Scale + v_u_new.X.Scale, v_u_position.X.Offset + v_u_new.X.Offset, v_u_position.Y.Scale + v_u_new.Y.Scale, v_u_position.Y.Offset + v_u_new.Y.Offset)
			}):Play()
			if v_u5 then
				v_u_tween:Create(v_u5, v_u_new, {
					["ImageTransparency"] = 0.3
				}):Play()
			end
		end)
		v_u_clone.Button.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_tween, (copy) v_u_icon, (copy) v_u_new, (copy) v_u_position, (ref) v_u5
			v_u_tween:Create(v_u_icon, v_u_new, {
				["Position"] = v_u_position
			}):Play()
			if v_u5 then
				v_u_tween:Create(v_u5, v_u_new, {
					["ImageTransparency"] = 1
				}):Play()
			end
		end)
		local v6 = v_u38 == arg1.Name
		v_u_clone.Price.TextTransparency = v6 and 0 or 1
		v_u_clone.WeaponName.TextTransparency = v6 and 0 or 1
		v_u_clone.Button.MouseButton1Down:Connect(function()
			-- upvalues: (ref) v_u1, (copy) arg2
			v_u1.OnItemMouseDown(arg2, true)
		end)
		v_u_clone.Button.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u1, (copy) arg2
			v_u1.OnLoadoutItemHover(arg2)
		end)
		v_u_clone.Button.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u1
			v_u1.OnLoadoutItemUnhover()
		end)
		v_u_clone.Button.Selectable = true
		v_u_clone.Button.SelectionGained:Connect(function()
			-- upvalues: (ref) v_u1, (copy) arg2, (copy) v_u_position, (copy) v_u_new, (ref) v_u_tween, (copy) v_u_icon, (copy) v_u_new, (ref) v_u5
			v_u1.OnLoadoutItemHover(arg2)
			v_u_tween:Create(v_u_icon, v_u_new, {
				["Position"] = UDim2.new(v_u_position.X.Scale + v_u_new.X.Scale, v_u_position.X.Offset + v_u_new.X.Offset, v_u_position.Y.Scale + v_u_new.Y.Scale, v_u_position.Y.Offset + v_u_new.Y.Offset)
			}):Play()
			if v_u5 then
				v_u_tween:Create(v_u5, v_u_new, {
					["ImageTransparency"] = 0.3
				}):Play()
			end
		end)
		v_u_clone.Button.SelectionLost:Connect(function()
			-- upvalues: (ref) v_u_tween, (copy) v_u_icon, (copy) v_u_new, (copy) v_u_position, (ref) v_u5
			v_u_tween:Create(v_u_icon, v_u_new, {
				["Position"] = v_u_position
			}):Play()
			if v_u5 then
				v_u_tween:Create(v_u5, v_u_new, {
					["ImageTransparency"] = 1
				}):Play()
			end
		end)
		v_u_clone.Button.Activated:Connect(function(arg1)
			-- upvalues: (ref) v_u29, (ref) v_u92, (copy) v_u_clone
			if arg1 and (arg1.UserInputType == Enum.UserInputType.Gamepad1 and not v_u29) then
				v_u92(v_u_clone.Button)
			end
		end)
	end
end
function v_u1.PopulateCategoryDropdown()
	-- upvalues: (ref) v_u62, (copy) v_u82, (copy) v_u81, (copy) v_u1, (copy) v_u80, (copy) v_u83
	local v_u_scrollingframe = v_u62.Tabs.Container.WeaponSort.Category.ScrollingFrame
	if v_u_scrollingframe then
		v_u82(v_u_scrollingframe)
		v_u81(v_u_scrollingframe, "All", "All Categories", 0, function()
			-- upvalues: (ref) v_u1, (ref) v_u80, (copy) v_u_scrollingframe
			v_u1.SortByCategory(nil)
			v_u80(v_u_scrollingframe, "All")
			v_u_scrollingframe.Visible = false
		end)
		local v1 = v_u83()
		for v2, v_u3 in ipairs(v1) do
			v_u81(v_u_scrollingframe, v_u3, v_u3, v2, function()
				-- upvalues: (ref) v_u1, (copy) v_u3, (ref) v_u80, (copy) v_u_scrollingframe
				v_u1.SortByCategory(v_u3)
				v_u80(v_u_scrollingframe, v_u3)
				v_u_scrollingframe.Visible = false
			end)
		end
		v_u80(v_u_scrollingframe, "All")
	end
end
function v_u1.PopulateWeaponDropdown()
	-- upvalues: (ref) v_u62, (copy) v_u82, (copy) v_u81, (copy) v_u1, (copy) v_u80, (copy) v_u84, (ref) v_u18
	local v_u_options = v_u62.Tabs.Container.WeaponSort.Weapon:FindFirstChild("Options")
	if v_u_options and (v_u_options:IsA("Frame") or v_u_options:IsA("ScrollingFrame")) then
		v_u82(v_u_options)
		v_u81(v_u_options, "All", "All Weapons", 0, function()
			-- upvalues: (ref) v_u1, (ref) v_u80, (copy) v_u_options, (copy) v_u_options
			v_u1.SortByWeapon(nil)
			v_u80(v_u_options, "All")
			v_u_options.Visible = false
		end)
		local v1 = v_u84(v_u18)
		for v2, v_u3 in ipairs(v1) do
			v_u81(v_u_options, v_u3, v_u3, v2, function()
				-- upvalues: (ref) v_u1, (copy) v_u3, (ref) v_u80, (copy) v_u_options, (copy) v_u_options
				v_u1.SortByWeapon(v_u3)
				v_u80(v_u_options, v_u3)
				v_u_options.Visible = false
			end)
		end
		v_u80(v_u_options, "All")
	end
end
function v_u1.SortByCategory(arg1)
	-- upvalues: (ref) v_u18, (ref) v_u62, (copy) v_u1, (copy) v_u9, (copy) v_u57, (ref) v_u51, (ref) v_u50, (ref) v_u48, (copy) v_u72, (copy) v_u77
	v_u18 = arg1
	local _ = v_u62.Tabs.Container.Container
	v_u62.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = arg1 or "All Categories"
	v_u1.PopulateWeaponDropdown()
	v_u62.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
	local v_reset = v_u62.Tabs.Container.WeaponSort:FindFirstChild("Reset")
	if v_reset then
		v_reset.Visible = v_u18 ~= nil and true or v_u62.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text ~= "All Weapons"
	end
	if v_u62 and v_u62.Visible then
		v_u48 = v_u72()
		v_u77()
	else
		v_u51 = true
		v_u50 = true
	end
end
function v_u1.SortByWeapon(arg1, arg2)
	-- upvalues: (ref) v_u62, (copy) v_u2, (copy) v_u_localplayer, (ref) v_u18, (copy) v_u1
	v_u62.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = arg1 or "All Weapons"
	for _, v1 in ipairs(v_u62.Tabs.Container.Container:GetChildren()) do
		if v1:IsA("Frame") then
			if arg1 then
				local v_get = v_u2.Get(v_u_localplayer, "Inventory")
				local v_name = v1.Name
				for _, v3 in ipairs(v_get) do
					if v3._id == v_name then
						goto l9
					end
				end
				local v3 = nil
				::l9::
				if v3 then
					v1.Visible = v3.Name == arg1 and (arg2 == nil and true or v3.Skin == arg2)
				end
			else
				v1.Visible = true
			end
		end
	end
	if v_u18 then
		v_u1.SortByCategory(v_u18)
	end
	local v_reset = v_u62.Tabs.Container.WeaponSort:FindFirstChild("Reset")
	if v_reset then
		v_reset.Visible = v_u18 ~= nil and true or v_u62.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text ~= "All Weapons"
	end
end
function v_u1.SortBySkinMetadata(arg1)
	-- upvalues: (ref) v_u_newest, (ref) v_u62, (ref) v_u51, (ref) v_u50, (ref) v_u48, (copy) v_u72, (copy) v_u77, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u4, (copy) v_u58, (copy) v_u9
	v_u_newest = arg1
	local _ = v_u62.Tabs.Container.Container
	v_u62.Tabs.Container.SkinSort.Sort.Frame.TextLabel.Text = arg1
	if arg1 == "Alphabetical" then
		if v_u62 and v_u62.Visible then
			v_u48 = v_u72()
			v_u77()
		else
			v_u51 = true
			v_u50 = true
		end
	elseif arg1 == "Collection" then
		if v_u62 and v_u62.Visible then
			v_u48 = v_u72()
			v_u77()
		else
			v_u51 = true
			v_u50 = true
		end
	elseif arg1 == "Equipped" then
		local v_get = v_u2.Get(v_u_localplayer, "Loadout")
		local v1 = {}
		if v_get then
			for _, v2 in pairs(v_get) do
				if v2.Loadout then
					for _, v3 in pairs(v2.Loadout) do
						if v3.Options then
							for _, v4 in ipairs(v3.Options) do
								v1[v4] = true
							end
						end
					end
				end
			end
		end
		if v_u62 and v_u62.Visible then
			v_u48 = v_u72()
			v_u77()
		else
			v_u51 = true
			v_u50 = true
		end
	elseif arg1 == "Newest" then
		if v_u62 and v_u62.Visible then
			v_u48 = v_u72()
			v_u77()
		else
			v_u51 = true
			v_u50 = true
		end
	elseif arg1 == "Quality" then
		if v_u62 and v_u62.Visible then
			v_u48 = v_u72()
			v_u77()
		else
			v_u51 = true
			v_u50 = true
		end
	else
		if arg1 == "Type" then
			if not (v_u62 and v_u62.Visible) then
				v_u51 = true
				v_u50 = true
				return
			end
			v_u48 = v_u72()
			v_u77()
		end
		return
	end
end
function v_u1.UpdateInventoryContainer()
	-- upvalues: (ref) v_u62, (ref) v_u51, (ref) v_u50, (ref) v_u29, (ref) v_u30, (ref) v_u31, (ref) v_u32, (ref) v_u33, (ref) v_u36, (ref) v_u35, (copy) v_u_gamepad, (copy) v_u_gui, (copy) v_u89, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u1, (ref) v_u_newest
	if v_u62 then
		if v_u62.Visible then
			v_u29 = nil
			v_u30 = false
			v_u31 = nil
			v_u32 = nil
			v_u33 = nil
			v_u36 = false
			if v_u35 then
				v_u35 = false
				pcall(function()
					-- upvalues: (ref) v_u_gamepad
					v_u_gamepad:DisableGamepadCursor()
				end)
				v_u_gui.AutoSelectGuiEnabled = true
			end
			v_u89()
			local v_get = v_u2.Get(v_u_localplayer, "Inventory")
			local v1 = {}
			for _, v2 in ipairs(v_get) do
				if v2 and v2._id then
					v1[v2._id] = true
				end
			end
			for _, v3 in ipairs(v_u62.Tabs.Container.Container:GetChildren()) do
				if v3:IsA("Frame") and (v3.Name ~= "UIGridLayout" and (v3.Name ~= "UIPadding" and not v1[v3.Name])) then
					v3:Destroy()
				end
			end
			v_u1.PopulateCategoryDropdown()
			v_u1.PopulateWeaponDropdown()
			v_u1.SortBySkinMetadata(v_u_newest)
		else
			v_u51 = true
			v_u50 = true
		end
	else
		return
	end
end
function v_u1.UpdateLoadoutContainer()
	-- upvalues: (ref) v_u29, (ref) v_u30, (ref) v_u31, (ref) v_u32, (ref) v_u33, (ref) v_u36, (ref) v_u35, (copy) v_u_gamepad, (copy) v_u_gui, (copy) v_u89, (copy) v_u2, (copy) v_u_localplayer, (ref) v_u62, (ref) v_u17, (copy) v_u63, (copy) v_u1
	-- failed to decompile
end
function v_u1.UpdateSidebarFrames(arg1, arg2)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (ref) v_u17, (ref) v_u62, (copy) v_u60, (copy) v_u4, (copy) v_u10
	local v_get = v_u2.Get(v_u_localplayer, "Inventory")
	local v1 = arg2 or v_u17
	local v2 = v_u62.Teams:FindFirstChild(v1 == "Counter-Terrorists" and "CT" or "T")
	if not v2 then
		return
	end
	local v_sidebar = v2:FindFirstChild("Sidebar")
	if not v_sidebar then
		return
	end
	local v3 = arg1[v1]
	if not (v3 and v3.Equipped) then
		return
	end
	for v4, v5 in pairs(v_u60) do
		local v6 = v3.Equipped[v4]
		local v7 = v_sidebar:FindFirstChild(v5)
		if v7 then
			local v_weapon = v7:FindFirstChild("Weapon")
			local v8
			if v_weapon then
				v8 = v_weapon:FindFirstChild("Icon")
			else
				v8 = v_weapon
			end
			local v9
			if v_weapon then
				v9 = v_weapon:FindFirstChild("Rarity")
			else
				v9 = v_weapon
			end
			local v10
			if v_weapon then
				v10 = v_weapon:FindFirstChild("Glow")
			else
				v10 = v_weapon
			end
			local v11 = nil
			local v12 = false
			local v14
			if v6 and v6 ~= "" then
				for _, v14 in ipairs(v_get) do
					if v14._id == v6 then
						goto l28
					end
				end
				v14 = nil
				::l28::
				if v14 then
					local v_getskininformation = v_u4.GetSkinInformation(v14.Name, v14.Skin)
					if v_getskininformation then
						v12 = true
						if v8 then
							v8.Image = v_u4.GetWearImageForFloat(v_getskininformation, v14.Float or 0.9999) or (v_getskininformation.imageAssetId or "")
							v8.Visible = true
						end
						if v9 then
							v9.Visible = true
							local v_uigradient = v9:FindFirstChild("UIGradient")
							if v_uigradient then
								v_uigradient.Color = v_u10[v_getskininformation.rarity].ColorSequence
							end
						end
						if v10 then
							v10.Visible = true
							v10.ImageColor3 = v_u10[v_getskininformation.rarity].Color
						end
					end
				else
					v14 = v11
				end
			else
				v14 = v11
			end
			if not v12 then
				if v8 then
					v8.Visible = false
				end
				if v9 then
					v9.Visible = false
				end
				if v10 then
					v10.Visible = false
				end
			end
			if v_weapon and (v5 == "Melee" or v5 == "Gloves") then
				if v14 then
					v_weapon:SetAttribute("EquippedItemId", v14._id)
				else
					v_weapon:SetAttribute("EquippedItemId", nil)
				end
				v_weapon:SetAttribute("SidebarName", v5)
				v_weapon:SetAttribute("TeamKey", v1 == "Counter-Terrorists" and "CT" or "T")
			end
		end
	end
end
local function v_u102()
	-- upvalues: (ref) v_u62, (copy) v_u12, (copy) v_u_characters, (copy) v_u42
	local v_teams = v_u62.Teams
	for _, v1 in ipairs({ "CT", "T" }) do
		local v2 = v_u12[v1]
		local v3 = v_teams:FindFirstChild(v1)
		if v3 then
			local v_player = v3:FindFirstChild("Player")
			if v_player then
				for _, v4 in ipairs(v_player:GetChildren()) do
					if v4:IsA("WorldModel") or v4:IsA("Camera") then
						v4:Destroy()
					end
				end
				local v5 = v_u_characters:FindFirstChild(v2.Character)
				if v5 then
					local v_worldmodel = Instance.new("WorldModel")
					v_worldmodel.Name = "CharacterWorldModel"
					v_worldmodel.Parent = v_player
					local v_clone = v5:Clone()
					v_clone.Name = "ViewportCharacter"
					v_clone.Parent = v_worldmodel
					v_u42[v1] = v_clone
					local v6 = v2.CharacterOffset or CFrame.new(0, 0, 0)
					if v_clone.PrimaryPart then
						v_clone:SetPrimaryPartCFrame(v6)
					else
						v_clone:PivotTo(v6)
					end
					local v_humanoid = v_clone:FindFirstChildOfClass("Humanoid")
					if v_humanoid and v2.IdleAnimation then
						local v_animator = v_humanoid:FindFirstChildOfClass("Animator")
						if not v_animator then
							v_animator = Instance.new("Animator")
							v_animator.Parent = v_humanoid
						end
						local v_animation = Instance.new("Animation")
						v_animation.AnimationId = v2.IdleAnimation
						local v_loadanimation = v_animator:LoadAnimation(v_animation)
						v_loadanimation.Looped = true
						v_loadanimation:Play()
					end
					local v_camera = Instance.new("Camera")
					v_camera.Name = "ViewportCamera"
					v_camera.CameraType = Enum.CameraType.Scriptable
					v_camera.FieldOfView = 50
					v_camera.CFrame = CFrame.new(0, 0, 0) * v2.CameraOffset
					v_camera.Parent = v_player
					v_player.CurrentCamera = v_camera
				end
			end
		end
	end
end
local function v_u103(arg1)
	-- upvalues: (copy) v_u42, (copy) v_u45, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u4, (copy) v_u16, (copy) v_u15
	local v1 = v_u42[arg1]
	if not v1 then
		return
	end
	local v2 = v_u45[arg1]
	if v2 then
		for _, v3 in ipairs(v2) do
			if v3 and v3.Parent then
				v3:Destroy()
			end
		end
		v_u45[arg1] = {}
	end
	local v4 = arg1 == "CT" and "Counter-Terrorists" or "Terrorists"
	local v_get = v_u2.Get(v_u_localplayer, "Loadout")
	if not (v_get and v_get[v4]) then
		return
	end
	local v_equipped = v_get[v4].Equipped
	if v_equipped then
		v_equipped = v_get[v4].Equipped["Equipped Gloves"]
	end
	if not v_equipped then
		return
	end
	local v_get = v_u2.Get(v_u_localplayer, "Inventory")
	local v5 = nil
	for _, v6 in ipairs(v_get) do
		if v6._id == v_equipped then
			v5 = v6
			break
		end
	end
	if v5 then
		local v_getgloves = v_u4.GetGloves(v5.Name, v5.Skin, v5.Float)
		if v_getgloves then
			local v7 = {}
			for _, v8 in ipairs(v_getgloves:GetChildren()) do
				if v8:IsA("BasePart") then
					local v9 = v_u16[v8.Name]
					if v9 then
						local v10 = v1:FindFirstChild(v9)
						if v10 then
							local v_clone = v8:Clone()
							v_clone.Name = v_u15[v8.Name] or v8.Name
							v_clone.CastShadow = false
							v_clone.CanCollide = false
							v_clone.CanTouch = false
							v_clone.Anchored = false
							v_clone.CanQuery = false
							v_clone.CFrame = v10.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
							v_clone.Size = Vector3.new(v10.Size.X * 1.1, v10.Size.Z, v10.Size.Y) * 1.1
							v_clone.Parent = v1
							local v_motor6d = Instance.new("Motor6D")
							v_motor6d.Name = "GloveAttachment"
							v_motor6d.Part0 = v10
							v_motor6d.Part1 = v_clone
							v_motor6d.C0 = CFrame.new(0, 0, -0.025)
							v_motor6d.C1 = v_clone.PivotOffset * CFrame.Angles(1.5707963267948966, 0, 0)
							v_motor6d.Parent = v_clone
							table.insert(v7, v_clone)
						end
					end
				end
			end
			v_u45[arg1] = v7
			v_getgloves:Destroy()
		end
	else
		return
	end
end
local function v_u104(arg1, arg2)
	-- upvalues: (copy) v_u42, (copy) v_u47, (copy) v_u44, (copy) v_u9, (copy) v_u13, (copy) v_u43, (copy) v_u4, (copy) v_u14
	local v1 = v_u42[arg1]
	if v1 then
		if arg2 and v_u47[arg1] == arg2._id then
			local v2 = v_u44[arg1]
			if not (v2 and v2.IsPlaying) then
				local v_humanoid = v1:FindFirstChildOfClass("Humanoid")
				local v3 = v_humanoid and v_humanoid:FindFirstChildOfClass("Animator")
				if v3 then
					local v4 = nil
					if arg2.Type == "Melee" then
						v4 = "Melee"
					else
						local v5, v6 = pcall(v_u9, arg2.Name)
						if v5 and v6 then
							local v_type = v6.Type
							local v_aimingoptions = v6.AimingOptions
							local v_muzzletype = v6.MuzzleType
							if v_type == nil then
								v4 = nil
							elseif v_aimingoptions == "SniperScope" then
								v4 = "Sniper"
							elseif v_type == "Heavy" then
								v4 = v_muzzletype == "MachineGun" and "LMG" or "Heavy"
							else
								v4 = ({
									["Pistol"] = "Pistol",
									["Rifle"] = "Rifle",
									["SMG"] = "SMG",
									["Equipment"] = nil,
									["Miscellaneous"] = nil
								})[v_type]
							end
						end
					end
					if v4 then
						local v_name = arg2.Name
						local v7
						if v4 and v_u13[v4] then
							local v8 = v_u13[v4]
							if v_name and v8[v_name] then
								v7 = v8[v_name]
							else
								v7 = v8.Default
							end
						else
							v7 = nil
						end
						if v7 then
							local v_loadanimation = v3:LoadAnimation(v7)
							v_loadanimation.Looped = true
							v_loadanimation.Priority = Enum.AnimationPriority.Action
							v_loadanimation:Play()
							v_u44[arg1] = v_loadanimation
						end
					end
				end
			end
			return
		else
			local v9 = v_u44[arg1]
			if v9 then
				v9:Stop()
				v_u44[arg1] = nil
			end
			local v10 = v_u43[arg1]
			if v10 then
				v10:Destroy()
				v_u43[arg1] = nil
			end
			v_u47[arg1] = nil
			for _, v11 in pairs({ "RightHand", "UpperTorso", "LeftHand" }) do
				local v12 = v1:FindFirstChild(v11)
				if v12 then
					local v_weaponattachment = v12:FindFirstChild("WeaponAttachment")
					if v_weaponattachment then
						v_weaponattachment:Destroy()
					end
					local v_weaponattachmenthandler = v12:FindFirstChild("WeaponAttachmentHandleR")
					if v_weaponattachmenthandler then
						v_weaponattachmenthandler:Destroy()
					end
					local v_weaponattachmenthandlel = v12:FindFirstChild("WeaponAttachmentHandleL")
					if v_weaponattachmenthandlel then
						v_weaponattachmenthandlel:Destroy()
					end
				end
			end
			if arg2 then
				local v_getcharactermodel = v_u4.GetCharacterModel(arg2.Name, arg2.Skin, arg2.Float, arg2.StatTrack, arg2.NameTag)
				if v_getcharactermodel then
					v_getcharactermodel.Name = arg2.Name
					local v13 = v1:FindFirstChild(v_u14[arg2.Name] or "RightHand")
					if v13 then
						if not v_getcharactermodel.PrimaryPart then
							local v_weapon = v_getcharactermodel:FindFirstChild("Weapon")
							if v_weapon then
								v_weapon = v_weapon:FindFirstChild("Insert")
							end
							if v_weapon then
								v_getcharactermodel.PrimaryPart = v_weapon
							else
								local v_insert = v_getcharactermodel:FindFirstChild("Insert", true)
								if v_insert then
									v_getcharactermodel.PrimaryPart = v_insert
								end
							end
						end
						if v_getcharactermodel.PrimaryPart then
							for _, v14 in ipairs(v_getcharactermodel:GetDescendants()) do
								if v14:IsA("BasePart") then
									v14.CanCollide = false
									v14.CanQuery = false
									v14.CanTouch = false
									v14.Anchored = false
									v14.Massless = true
								end
							end
							v_getcharactermodel.Parent = v1
							local v15, v16 = pcall(v_u9, arg2.Name)
							local v17
							if v15 and v16 then
								v17 = v16.ShootingOptions == "Dual"
							else
								v17 = false
							end
							local v_properties = v_getcharactermodel:FindFirstChild("Properties")
							if not v_properties then
								local v_weapon = v_getcharactermodel:FindFirstChild("Weapon")
								if v_weapon then
									v_properties = v_weapon:FindFirstChild("Properties")
								end
							end
							local v18 = v_properties or v_getcharactermodel:FindFirstChild("Properties", true)
							if v17 then
								local v_righthand = v1:FindFirstChild("RightHand")
								local v_lefthand = v1:FindFirstChild("LeftHand")
								if v_righthand and v_lefthand then
									local v_handler = v_getcharactermodel:FindFirstChild("HandleR", true)
									if v_handler then
										local v_motor6d = Instance.new("Motor6D")
										v_motor6d.Name = "WeaponAttachmentHandleR"
										v_motor6d.Part0 = v_righthand
										v_motor6d.Part1 = v_handler
										v_motor6d.Parent = v_righthand
										if v18 then
											local v_c0right = v18:FindFirstChild("C0RIGHT")
											if v_c0right then
												v_motor6d.C0 = v_c0right.Value
											end
											local v_c1right = v18:FindFirstChild("C1RIGHT")
											if v_c1right then
												v_motor6d.C1 = v_c1right.Value
											end
										end
									end
									local v_handlel = v_getcharactermodel:FindFirstChild("HandleL", true)
									if v_handlel then
										local v_motor6d = Instance.new("Motor6D")
										v_motor6d.Name = "WeaponAttachmentHandleL"
										v_motor6d.Part0 = v_lefthand
										v_motor6d.Part1 = v_handlel
										v_motor6d.Parent = v_lefthand
										if v18 then
											local v_c0left = v18:FindFirstChild("C0LEFT")
											if v_c0left then
												v_motor6d.C0 = v_c0left.Value
											end
											local v_c1left = v18:FindFirstChild("C1LEFT")
											if v_c1left then
												v_motor6d.C1 = v_c1left.Value
											end
										end
									end
								end
							else
								local v_motor6d = Instance.new("Motor6D")
								v_motor6d.Name = "WeaponAttachment"
								v_motor6d.Part0 = v13
								v_motor6d.Part1 = v_getcharactermodel.PrimaryPart
								v_motor6d.Parent = v13
								if v18 then
									local v_c0 = v18:FindFirstChild("C0")
									if v_c0 then
										v_motor6d.C0 = v_c0.Value
									end
									local v_c1 = v18:FindFirstChild("C1")
									if v_c1 then
										v_motor6d.C1 = v_c1.Value
									end
								end
							end
							v_u43[arg1] = v_getcharactermodel
							v_u47[arg1] = arg2._id
							local v_humanoid = v1:FindFirstChildOfClass("Humanoid")
							if v_humanoid then
								local v_animator = v_humanoid:FindFirstChildOfClass("Animator")
								if v_animator then
									local v19 = nil
									if arg2.Type == "Melee" then
										v19 = "Melee"
									elseif v16 then
										local v_type = v16.Type
										local v_aimingoptions = v16.AimingOptions
										local v_muzzletype = v16.MuzzleType
										if v_type == nil then
											v19 = nil
										elseif v_aimingoptions == "SniperScope" then
											v19 = "Sniper"
										elseif v_type == "Heavy" then
											v19 = v_muzzletype == "MachineGun" and "LMG" or "Heavy"
										else
											v19 = ({
												["Pistol"] = "Pistol",
												["Rifle"] = "Rifle",
												["SMG"] = "SMG",
												["Equipment"] = nil,
												["Miscellaneous"] = nil
											})[v_type]
										end
									else
										local v20, v21 = pcall(v_u9, arg2.Name)
										if v20 and v21 then
											local v_type = v21.Type
											local v_aimingoptions = v21.AimingOptions
											local v_muzzletype = v21.MuzzleType
											if v_type == nil then
												v19 = nil
											elseif v_aimingoptions == "SniperScope" then
												v19 = "Sniper"
											elseif v_type == "Heavy" then
												v19 = v_muzzletype == "MachineGun" and "LMG" or "Heavy"
											else
												v19 = ({
													["Pistol"] = "Pistol",
													["Rifle"] = "Rifle",
													["SMG"] = "SMG",
													["Equipment"] = nil,
													["Miscellaneous"] = nil
												})[v_type]
											end
										end
									end
									if v19 then
										local v_name = arg2.Name
										local v22
										if v19 and v_u13[v19] then
											local v23 = v_u13[v19]
											if v_name and v23[v_name] then
												v22 = v23[v_name]
											else
												v22 = v23.Default
											end
										else
											v22 = nil
										end
										if v22 then
											local v_loadanimation = v_animator:LoadAnimation(v22)
											v_loadanimation.Looped = true
											v_loadanimation.Priority = Enum.AnimationPriority.Action
											v_loadanimation:Play()
											v_u44[arg1] = v_loadanimation
										end
									end
								end
							else
								return
							end
						else
							v_getcharactermodel:Destroy()
							return
						end
					else
						v_getcharactermodel:Destroy()
						return
					end
				else
					return
				end
			else
				return
			end
		end
	else
		return
	end
end
local function v_u105(arg1)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u104
	local v1 = arg1 == "CT" and "Counter-Terrorists" or "Terrorists"
	local v_get = v_u2.Get(v_u_localplayer, "Loadout")
	local v_get = v_u2.Get(v_u_localplayer, "Inventory")
	if not (v_get and v_get) then
		return
	end
	local v2 = v_get[v1]
	if not (v2 and v2.Equipped) then
		return
	end
	local v_equipped melee = v2.Equipped["Equipped Melee"]
	if v_equipped melee and v_equipped melee ~= "" then
		for _, v4 in ipairs(v_get) do
			if v4._id == v_equipped melee then
				goto l16
			end
		end
		local v4 = nil
		::l16::
		if v4 then
			v_u104(arg1, v4)
			return
		end
	end
	v_u104(arg1, {
		["_id"] = "default_knife",
		["Type"] = "Melee",
		["Serial"] = 0,
		["Name"] = arg1 == "CT" and "CT Knife" or "T Knife",
		["Skin"] = "Stock",
		["Float"] = 0,
		["StatTrack"] = false,
		["IsTradeable"] = false,
		["NameTag"] = false,
		["Charm"] = false
	})
end
function v_u1.OnLoadoutItemHover(arg1)
	-- upvalues: (ref) v_u17, (copy) v_u104
	v_u104(v_u17 == "Counter-Terrorists" and "CT" or "T", arg1)
end
function v_u1.OnLoadoutItemUnhover() end
local function v_u106()
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (ref) v_u62, (copy) v_u46, (copy) v_u104, (copy) v_u105
	local v_u_get = v_u2.Get(v_u_localplayer, "Inventory")
	if v_u_get then
		local v_teams = v_u62.Teams
		for _, v_u1 in ipairs({ "CT", "T" }) do
			local v2 = v_teams:FindFirstChild(v_u1)
			if v2 then
				local v_sidebar = v2:FindFirstChild("Sidebar")
				if v_sidebar then
					for _, v_u3 in ipairs({ "Melee", "Gloves" }) do
						local v4 = v_sidebar:FindFirstChild(v_u3)
						if v4 then
							local v_weapon = v4:FindFirstChild("Weapon")
							if v_weapon then
								local v5 = v_u1 .. "_" .. v_u3
								local v6 = v_u46[v5]
								if v6 then
									if v6.MouseEnter then
										v6.MouseEnter:Disconnect()
									end
									if v6.MouseLeave then
										v6.MouseLeave:Disconnect()
									end
								end
								local v_u_equippeditemid = v_weapon:GetAttribute("EquippedItemId")
								local v_u_teamkey = v_weapon:GetAttribute("TeamKey")
								v_u46[v5] = {
									["MouseEnter"] = v_weapon.MouseEnter:Connect(function()
										-- upvalues: (copy) v_u_equippeditemid, (copy) v_u_get, (copy) v_u3, (ref) v_u104, (copy) v_u_teamkey, (copy) v_u1, (ref) v_u105
										if not v_u_equippeditemid or v_u_equippeditemid == "" then
											if v_u3 == "Melee" then
												v_u105(v_u_teamkey or v_u1)
											end
											goto l10
										end
										local v1 = v_u_equippeditemid
										for _, v3 in ipairs(v_u_get) do
											if v3._id == v1 then
												goto l7
											end
										end
										local v3 = nil
										::l7::
										if v3 and v_u3 == "Melee" then
											v_u104(v_u_teamkey or v_u1, v3)
											return
										end
										::l10::
									end),
									["MouseLeave"] = v_weapon.MouseLeave:Connect(function() end)
								}
							end
						end
					end
				end
			end
		end
	end
end
function v_u1.SelectTeam(arg1)
	-- upvalues: (ref) v_u62, (ref) v_u40, (ref) v_u41, (copy) v_u_tween, (ref) v_u17, (ref) v_u18, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u1
	local v_teams = v_u62.Teams
	v_teams.GunsCT.Visible = arg1 == "CT"
	v_teams.GunsT.Visible = arg1 == "T"
	if v_u40 == nil then
		v_u40 = v_u62.Teams.CT.BackgroundTransparency
	end
	if v_u41 == nil then
		v_u41 = v_u62.Teams.T.BackgroundTransparency
	end
	v_u62.Teams.CT.Visible = true
	v_u62.Teams.T.Visible = true
	local v_new = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local v_sidebar = v_u62.Teams.CT:FindFirstChild("Sidebar")
	local v_sidebar = v_u62.Teams.T:FindFirstChild("Sidebar")
	local v_equip = v_u62.Teams.CT:FindFirstChild("Equip")
	local v_equip = v_u62.Teams.T:FindFirstChild("Equip")
	local v1
	if v_equip then
		v1 = v_equip:FindFirstChild("Frame")
	else
		v1 = v_equip
	end
	local v2
	if v_equip then
		v2 = v_equip:FindFirstChild("Frame")
	else
		v2 = v_equip
	end
	local v3
	if v1 then
		v3 = v1:FindFirstChild("UIStroke")
	else
		v3 = v1
	end
	local v4
	if v2 then
		v4 = v2:FindFirstChild("UIStroke")
	else
		v4 = v2
	end
	if v_equip then
		v_equip = v_equip:FindFirstChild("skin")
	end
	if v_equip then
		v_equip = v_equip:FindFirstChild("skin")
	end
	local v_player = v_u62.Teams.CT:FindFirstChild("Player")
	local v_player = v_u62.Teams.T:FindFirstChild("Player")
	local v_fromrgb = Color3.fromRGB(104, 140, 175)
	local v_fromrgb = Color3.fromRGB(136, 115, 56)
	local v_fromrgb = Color3.fromRGB(0, 0, 0)
	if arg1 == "CT" then
		v_u_tween:Create(v_u62.Teams.CT, v_new, {
			["BackgroundTransparency"] = v_u40
		}):Play()
		v_u62.Teams.CT.Border.Visible = true
		v_u_tween:Create(v_u62.Teams.T, v_new, {
			["BackgroundTransparency"] = 1
		}):Play()
		v_u62.Teams.T.Frame.Visible = false
		if v_sidebar then
			v_u_tween:Create(v_sidebar, v_new, {
				["GroupTransparency"] = 0
			}):Play()
		end
		if v_sidebar then
			v_u_tween:Create(v_sidebar, v_new, {
				["GroupTransparency"] = 0.65
			}):Play()
		end
		if v_player then
			v_u_tween:Create(v_player, v_new, {
				["ImageTransparency"] = 0
			}):Play()
		end
		if v_player then
			v_u_tween:Create(v_player, v_new, {
				["ImageTransparency"] = 0.6
			}):Play()
		end
		if v1 then
			v_u_tween:Create(v1, v_new, {
				["BackgroundTransparency"] = 0
			}):Play()
		end
		if v3 then
			v_u_tween:Create(v3, v_new, {
				["Transparency"] = 0
			}):Play()
		end
		if v_equip then
			v_u_tween:Create(v_equip, v_new, {
				["TextColor3"] = v_fromrgb
			}):Play()
		end
		if v2 then
			v_u_tween:Create(v2, v_new, {
				["BackgroundTransparency"] = 1
			}):Play()
		end
		if v4 then
			v_u_tween:Create(v4, v_new, {
				["Transparency"] = 0.6
			}):Play()
		end
		if v_equip then
			v_u_tween:Create(v_equip, v_new, {
				["TextColor3"] = v_fromrgb
			}):Play()
		end
	else
		v_u_tween:Create(v_u62.Teams.T, v_new, {
			["BackgroundTransparency"] = v_u41
		}):Play()
		v_u62.Teams.T.Frame.Visible = true
		v_u_tween:Create(v_u62.Teams.CT, v_new, {
			["BackgroundTransparency"] = 1
		}):Play()
		v_u62.Teams.CT.Border.Visible = false
		if v_sidebar then
			v_u_tween:Create(v_sidebar, v_new, {
				["GroupTransparency"] = 0.65
			}):Play()
		end
		if v_sidebar then
			v_u_tween:Create(v_sidebar, v_new, {
				["GroupTransparency"] = 0
			}):Play()
		end
		if v_player then
			v_u_tween:Create(v_player, v_new, {
				["ImageTransparency"] = 0.6
			}):Play()
		end
		if v_player then
			v_u_tween:Create(v_player, v_new, {
				["ImageTransparency"] = 0
			}):Play()
		end
		if v2 then
			v_u_tween:Create(v2, v_new, {
				["BackgroundTransparency"] = 0
			}):Play()
		end
		if v4 then
			v_u_tween:Create(v4, v_new, {
				["Transparency"] = 0
			}):Play()
		end
		if v_equip then
			v_u_tween:Create(v_equip, v_new, {
				["TextColor3"] = v_fromrgb
			}):Play()
		end
		if v1 then
			v_u_tween:Create(v1, v_new, {
				["BackgroundTransparency"] = 1
			}):Play()
		end
		if v3 then
			v_u_tween:Create(v3, v_new, {
				["Transparency"] = 0.6
			}):Play()
		end
		if v_equip then
			v_u_tween:Create(v_equip, v_new, {
				["TextColor3"] = v_fromrgb
			}):Play()
		end
	end
	v_u17 = arg1 == "CT" and "Counter-Terrorists" or (arg1 == "T" and "Terrorists" or false)
	v_u18 = nil
	v_u62.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = "All Categories"
	v_u62.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
	local v_get = v_u2.Get(v_u_localplayer, "Loadout")
	v_u1.UpdateLoadoutContainer(v_get)
	v_u1.UpdateSidebarFrames(v_get)
	v_u1.UpdateInventoryContainer()
	v_u1.PopulateCategoryDropdown()
	v_u1.PopulateWeaponDropdown()
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u62, (ref) v_u27, (ref) v_u25, (ref) v_u26, (ref) v_u28, (ref) v_u24, (ref) v_u20, (ref) v_u19, (ref) v_u21, (ref) v_u22, (ref) v_u23, (copy) v_u89, (ref) v_u29, (ref) v_u30, (ref) v_u31, (ref) v_u32, (ref) v_u33, (ref) v_u36, (ref) v_u35, (copy) v_u_gamepad, (copy) v_u_gui, (ref) v_u51, (copy) v_u1, (ref) v_u_newest, (ref) v_u50, (copy) v_u76, (ref) v_u49, (ref) v_u48, (copy) v_u73, (copy) v_u74, (ref) v_u39, (copy) v_u8, (copy) v_u3, (copy) v_u64, (copy) v_u7, (copy) v_u_userinput, (copy) v_u11, (copy) v_u_contentprovider, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u102, (copy) v_u103, (copy) v_u105, (ref) v_u38, (copy) v_u79, (ref) v_u37, (copy) v_u106, (ref) v_u100, (ref) v_u99, (ref) v_u34, (copy) v_u78, (copy) v_u80, (copy) v_u82, (ref) v_u18
	v_u62 = arg2
	v_u62:GetPropertyChangedSignal("Visible"):Connect(function()
		-- upvalues: (ref) v_u62, (ref) v_u27, (ref) v_u25, (ref) v_u26, (ref) v_u28, (ref) v_u24, (ref) v_u20, (ref) v_u19, (ref) v_u21, (ref) v_u22, (ref) v_u23, (ref) v_u89, (ref) v_u29, (ref) v_u30, (ref) v_u31, (ref) v_u32, (ref) v_u33, (ref) v_u36, (ref) v_u35, (ref) v_u_gamepad, (ref) v_u_gui, (ref) v_u51, (ref) v_u1, (ref) v_u_newest, (ref) v_u50, (ref) v_u76
		if v_u62.Visible then
			if v_u51 then
				v_u51 = false
				v_u1.SortBySkinMetadata(v_u_newest)
			end
			if v_u50 then
				v_u76()
			end
		else
			if v_u27 then
				v_u27:Disconnect()
				v_u27 = nil
			end
			v_u25 = nil
			v_u26 = nil
			v_u28 = false
			if v_u24 then
				v_u24:Disconnect()
				v_u24 = nil
			end
			if v_u20 then
				v_u20:Destroy()
				v_u20 = nil
			end
			v_u19 = false
			v_u21 = nil
			v_u22 = nil
			v_u23 = nil
			v_u89()
			v_u29 = nil
			v_u30 = false
			v_u31 = nil
			v_u32 = nil
			v_u33 = nil
			v_u36 = false
			if v_u35 then
				v_u35 = false
				pcall(function()
					-- upvalues: (ref) v_u_gamepad
					v_u_gamepad:DisableGamepadCursor()
				end)
				v_u_gui.AutoSelectGuiEnabled = true
			end
			v_u89()
		end
	end)
	local v_container = v_u62.Tabs.Container.Container
	v_container:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
		-- upvalues: (ref) v_u62, (ref) v_u49, (ref) v_u48, (ref) v_u73
		if v_u62 then
			local v_container = v_u62.Tabs.Container.Container
			local v1 = v_container.AbsoluteCanvasSize.Y - v_container.AbsoluteSize.Y
			if v1 > 0 and (v_u49 < #v_u48 and v1 - v_container.CanvasPosition.Y < 200) then
				v_u73()
			end
		else
			return
		end
	end)
	v_container:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
		-- upvalues: (ref) v_u74
		task.defer(v_u74)
	end)
	local v_u_menu = arg1:FindFirstChild("Menu")
	if v_u_menu then
		v_u_menu:GetPropertyChangedSignal("Visible"):Connect(function()
			-- upvalues: (copy) v_u_menu, (ref) v_u27, (ref) v_u25, (ref) v_u26, (ref) v_u28, (ref) v_u24, (ref) v_u20, (ref) v_u19, (ref) v_u21, (ref) v_u22, (ref) v_u23, (ref) v_u89, (ref) v_u29, (ref) v_u30, (ref) v_u31, (ref) v_u32, (ref) v_u33, (ref) v_u36, (ref) v_u35, (ref) v_u_gamepad, (ref) v_u_gui, (ref) v_u62, (ref) v_u39, (ref) v_u8, (ref) v_u3
			if not v_u_menu.Visible then
				if v_u27 then
					v_u27:Disconnect()
					v_u27 = nil
				end
				v_u25 = nil
				v_u26 = nil
				v_u28 = false
				if v_u24 then
					v_u24:Disconnect()
					v_u24 = nil
				end
				if v_u20 then
					v_u20:Destroy()
					v_u20 = nil
				end
				v_u19 = false
				v_u21 = nil
				v_u22 = nil
				v_u23 = nil
				v_u89()
				v_u29 = nil
				v_u30 = false
				v_u31 = nil
				v_u32 = nil
				v_u33 = nil
				v_u36 = false
				if v_u35 then
					v_u35 = false
					pcall(function()
						-- upvalues: (ref) v_u_gamepad
						v_u_gamepad:DisableGamepadCursor()
					end)
					v_u_gui.AutoSelectGuiEnabled = true
				end
				v_u89()
				local v_actionframe = v_u62.ActionFrame
				if v_actionframe then
					v_actionframe.Visible = false
				end
				v_u39 = nil
				if v_u8.IsInspectActive() then
					v_u3.broadcastRouter("WeaponInspectClose")
				end
			end
		end)
	end
	local v_u_actionframe = v_u62.ActionFrame
	if v_u_actionframe then
		v_u_actionframe.Visible = false
		local v_inspect = v_u_actionframe:FindFirstChild("Inspect")
		if v_inspect then
			v_inspect.MouseButton1Click:Connect(v_u64)
		end
		local v_charm = v_u_actionframe:FindFirstChild("Charm")
		if v_charm then
			v_charm.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u39, (ref) v_u62, (ref) v_u7
				if v_u39 then
					local v1 = v_u39
					local v2
					if v1.Charm == nil or v1.Charm == false then
						v2 = false
					else
						v2 = (type(v1.Charm) == "string" or v1.Charm == true) and true or type(v1.Charm) == "table"
					end
					local v_actionframe = v_u62.ActionFrame
					if v_actionframe then
						v_actionframe.Visible = false
					end
					v_u39 = nil
					if v2 then
						v_u7.Inventory.RemoveWeaponCharm.Send({
							["WeaponId"] = v1._id
						})
					end
				end
			end)
		end
		v_u_userinput.InputBegan:Connect(function(arg1, arg2)
			-- upvalues: (copy) v_u_actionframe, (ref) v_u39, (ref) v_u_userinput, (ref) v_u62
			if not arg2 then
				if arg1.UserInputType == Enum.UserInputType.MouseButton1 or (arg1.UserInputType == Enum.UserInputType.MouseButton2 or arg1.UserInputType == Enum.UserInputType.Touch) then
					task.defer(function()
						-- upvalues: (ref) v_u_actionframe, (ref) v_u39, (ref) v_u_userinput, (ref) v_u62
						if v_u_actionframe.Visible and v_u39 then
							local v_getmouselocation = v_u_userinput:GetMouseLocation()
							local v_absoluteposition = v_u_actionframe.AbsolutePosition
							local v_absolutesize = v_u_actionframe.AbsoluteSize
							local v1
							if v_getmouselocation.X >= v_absoluteposition.X then
								v1 = v_getmouselocation.X <= v_absoluteposition.X + v_absolutesize.X
							else
								v1 = false
							end
							local v2
							if v_getmouselocation.Y >= v_absoluteposition.Y then
								v2 = v_getmouselocation.Y <= v_absoluteposition.Y + v_absolutesize.Y
							else
								v2 = false
							end
							if not (v1 and v2) then
								local v_actionframe = v_u62.ActionFrame
								if v_actionframe then
									v_actionframe.Visible = false
								end
								v_u39 = nil
							end
						end
					end)
				end
			end
		end)
	end
	task.spawn(function()
		-- upvalues: (ref) v_u11, (ref) v_u_contentprovider
		local v1 = {}
		for _, v2 in pairs(v_u11) do
			table.insert(v1, v2)
		end
		v_u_contentprovider:PreloadAsync(v1)
	end)
	v_u2.WaitForDataLoaded(v_u_localplayer)
	v_u102()
	v_u103("CT")
	v_u103("T")
	v_u105("CT")
	v_u105("T")
	local v_teams = v_u62.Teams
	for _, v1 in ipairs({ v_teams.GunsCT, v_teams.GunsT }) do
		for _, v_u2 in ipairs({ "Mid Tier", "Pistols", "Rifles" }) do
			local v_u3 = v1:FindFirstChild(v_u2)
			if v_u3 and v_u3:IsA("Frame") then
				v_u3.MouseEnter:Connect(function()
					-- upvalues: (ref) v_u38, (copy) v_u2, (ref) v_u79, (copy) v_u3
					v_u38 = v_u2
					v_u79(v_u3, true)
				end)
				v_u3.MouseLeave:Connect(function()
					-- upvalues: (ref) v_u38, (ref) v_u79, (copy) v_u3
					v_u38 = nil
					v_u79(v_u3, false)
				end)
			end
		end
	end
	v_u2.CreateListener(v_u_localplayer, "Loadout", function(arg1)
		-- upvalues: (ref) v_u37, (ref) v_u1, (ref) v_u103, (ref) v_u106
		v_u37 = false
		v_u1.UpdateLoadoutContainer(arg1)
		v_u1.UpdateSidebarFrames(arg1, "Counter-Terrorists")
		v_u1.UpdateSidebarFrames(arg1, "Terrorists")
		v_u103("CT")
		v_u103("T")
		v_u106()
	end)
	v_u7.Inventory.LoadoutResponse.Listen(function()
		-- upvalues: (ref) v_u37
		v_u37 = false
	end)
	v_u2.CreateListener(v_u_localplayer, "Inventory", function()
		-- upvalues: (ref) v_u1
		v_u1.UpdateInventoryContainer()
	end)
	v_u_userinput.InputEnded:Connect(function(arg1, _)
		-- upvalues: (ref) v_u19, (ref) v_u25, (ref) v_u1
		if (arg1.UserInputType == Enum.UserInputType.MouseButton1 or arg1.UserInputType == Enum.UserInputType.Touch) and (v_u19 or v_u25) then
			v_u1.EndDrag()
		end
	end)
	v_u_userinput.InputBegan:Connect(function(arg1, _)
		-- upvalues: (ref) v_u29, (ref) v_u35, (ref) v_u36, (ref) v_u100
		if arg1.UserInputType == Enum.UserInputType.Gamepad1 then
			if arg1.KeyCode == Enum.KeyCode.ButtonA then
				if v_u29 and v_u35 then
					v_u36 = true
					return
				end
			elseif arg1.KeyCode == Enum.KeyCode.ButtonB then
				v_u100()
			end
		end
	end)
	v_u_userinput.InputEnded:Connect(function(arg1, _)
		-- upvalues: (ref) v_u29, (ref) v_u35, (ref) v_u36, (ref) v_u99
		if arg1.UserInputType == Enum.UserInputType.Gamepad1 then
			if arg1.KeyCode == Enum.KeyCode.ButtonA and (v_u29 and (v_u35 and v_u36)) then
				v_u99()
			end
		end
	end)
	v_u_userinput.LastInputTypeChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u34, (ref) v_u29, (ref) v_u30, (ref) v_u31, (ref) v_u32, (ref) v_u33, (ref) v_u36, (ref) v_u35, (ref) v_u_gamepad, (ref) v_u_gui, (ref) v_u89, (ref) v_u27, (ref) v_u25, (ref) v_u26, (ref) v_u28, (ref) v_u24, (ref) v_u20, (ref) v_u19, (ref) v_u21, (ref) v_u22, (ref) v_u23
		local v1 = v_u34
		v_u34 = arg1 == Enum.UserInputType.Gamepad1
		if v1 and not v_u34 then
			v_u29 = nil
			v_u30 = false
			v_u31 = nil
			v_u32 = nil
			v_u33 = nil
			v_u36 = false
			if v_u35 then
				v_u35 = false
				pcall(function()
					-- upvalues: (ref) v_u_gamepad
					v_u_gamepad:DisableGamepadCursor()
				end)
				v_u_gui.AutoSelectGuiEnabled = true
			end
			v_u89()
		end
		if not v1 and v_u34 then
			if v_u27 then
				v_u27:Disconnect()
				v_u27 = nil
			end
			v_u25 = nil
			v_u26 = nil
			v_u28 = false
			if v_u24 then
				v_u24:Disconnect()
				v_u24 = nil
			end
			if v_u20 then
				v_u20:Destroy()
				v_u20 = nil
			end
			v_u19 = false
			v_u21 = nil
			v_u22 = nil
			v_u23 = nil
			v_u89()
		end
	end)
	v_u34 = v_u_userinput:GetLastInputType() == Enum.UserInputType.Gamepad1
	local v_sort = v_u62.Tabs.Container.SkinSort.Sort
	local v_u_options = v_sort.Options
	v_sort.MouseButton1Click:Connect(function()
		-- upvalues: (copy) v_u_options, (ref) v_u62
		local v_visible = v_u_options.Visible
		local v_category = v_u62.Tabs.Container.WeaponSort.Category
		local v_weapon = v_u62.Tabs.Container.WeaponSort.Weapon
		v_u62.Tabs.Container.SkinSort.Sort.Options.Visible = false
		if v_category.ScrollingFrame then
			v_category.ScrollingFrame.Visible = false
		end
		local v_options = v_weapon:FindFirstChild("Options")
		if v_options then
			v_options.Visible = false
		end
		v_u_options.Visible = not v_visible
	end)
	for _, v_u4 in ipairs(v_u_options:GetChildren()) do
		if v_u4:IsA("TextButton") then
			v_u4.MouseEnter:Connect(function()
				-- upvalues: (ref) v_u78, (copy) v_u4
				v_u78(v_u4, true)
			end)
			v_u4.MouseLeave:Connect(function()
				-- upvalues: (ref) v_u78, (copy) v_u4
				v_u78(v_u4, false)
			end)
			v_u4.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u1, (copy) v_u4, (ref) v_u80, (copy) v_u_options
				v_u1.SortBySkinMetadata(v_u4.Name)
				v_u80(v_u_options, v_u4.Name)
				v_u_options.Visible = false
			end)
		end
	end
	local v_u_category = v_u62.Tabs.Container.WeaponSort.Category
	local v_u_scrollingframe = v_u_category.ScrollingFrame
	if v_u_scrollingframe then
		v_u82(v_u_scrollingframe)
		v_u_category.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_scrollingframe, (ref) v_u62
			local v_visible = v_u_scrollingframe.Visible
			local v_category = v_u62.Tabs.Container.WeaponSort.Category
			local v_weapon = v_u62.Tabs.Container.WeaponSort.Weapon
			v_u62.Tabs.Container.SkinSort.Sort.Options.Visible = false
			if v_category.ScrollingFrame then
				v_category.ScrollingFrame.Visible = false
			end
			local v_options = v_weapon:FindFirstChild("Options")
			if v_options then
				v_options.Visible = false
			end
			v_u_scrollingframe.Visible = not v_visible
		end)
	end
	local v_u_weapon = v_u62.Tabs.Container.WeaponSort.Weapon
	local v_u_options = v_u_weapon:FindFirstChild("Options")
	if v_u_options and (v_u_options:IsA("Frame") or v_u_options:IsA("ScrollingFrame")) then
		v_u82(v_u_options)
		v_u_weapon.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_options, (ref) v_u62
			local v_visible = v_u_options.Visible
			local v_category = v_u62.Tabs.Container.WeaponSort.Category
			local v_weapon = v_u62.Tabs.Container.WeaponSort.Weapon
			v_u62.Tabs.Container.SkinSort.Sort.Options.Visible = false
			if v_category.ScrollingFrame then
				v_category.ScrollingFrame.Visible = false
			end
			local v_options = v_weapon:FindFirstChild("Options")
			if v_options then
				v_options.Visible = false
			end
			v_u_options.Visible = not v_visible
		end)
	end
	local v_u_reset = v_u62.Tabs.Container.WeaponSort:FindFirstChild("Reset")
	if v_u_reset then
		v_u_reset.Visible = false
		v_u_reset.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u18, (copy) v_u_category, (copy) v_u_weapon, (copy) v_u_reset, (ref) v_u1, (ref) v_u62, (ref) v_u_newest
			v_u18 = nil
			v_u_category.Frame.TextLabel.Text = "All Categories"
			v_u_weapon.Frame.TextLabel.Text = "All Weapons"
			v_u_reset.Visible = false
			v_u1.PopulateWeaponDropdown()
			for _, v1 in ipairs(v_u62.Tabs.Container.Container:GetChildren()) do
				if v1:IsA("Frame") then
					v1.Visible = true
				end
			end
			v_u1.SortBySkinMetadata(v_u_newest)
		end)
	end
end
function v_u1.ViewInLoadout(arg1)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u9, (ref) v_u18, (ref) v_u62, (copy) v_u1
	local v_get = v_u2.Get(v_u_localplayer, "Inventory")
	for _, v2 in ipairs(v_get) do
		if v2._id == arg1 then
			goto l4
		end
	end
	local v2 = nil
	::l4::
	if v2 then
		local v_name = v2.Name
		local v_skin = v2.Skin
		local v3, v4 = pcall(v_u9, v_name)
		if v3 and (v4 and v4.Type) then
			v_u18 = v4.Type
			v_u62.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = v4.Type
			v_u1.PopulateWeaponDropdown()
		end
		v_u62.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = v_name
		v_u1.SortByWeapon(v_name, v_skin)
		local v_reset = v_u62.Tabs.Container.WeaponSort:FindFirstChild("Reset")
		if v_reset then
			v_reset.Visible = v_u18 ~= nil and true or v_u62.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text ~= "All Weapons"
		end
		if not v_u62.Visible then
			v_u62.Visible = true
		end
	else
		return
	end
end
function v_u1.Start()
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u1, (copy) v_u106, (copy) v_u80, (ref) v_u62
	v_u2.WaitForDataLoaded(v_u_localplayer)
	v_u1.SelectTeam("CT")
	local v_get = v_u2.Get(v_u_localplayer, "Loadout")
	if v_get then
		v_u1.UpdateSidebarFrames(v_get, "Counter-Terrorists")
		v_u1.UpdateSidebarFrames(v_get, "Terrorists")
		v_u106()
	end
	v_u1.PopulateCategoryDropdown()
	v_u1.PopulateWeaponDropdown()
	v_u1.SortBySkinMetadata("Newest")
	v_u80(v_u62.Tabs.Container.SkinSort.Sort.Options, "Newest")
	v_u62.Teams.ButtonCT.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u1
		v_u1.SelectTeam("CT")
	end)
	v_u62.Teams.ButtonT.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u1
		v_u1.SelectTeam("T")
	end)
end
return v_u1