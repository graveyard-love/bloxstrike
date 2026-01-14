-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_u_text = game:GetService("TextService")
local v_u_run = game:GetService("RunService")
local v_u_players = game:GetService("Players")
local v_u_gui = game:GetService("GuiService")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_u_players.LocalPlayer
local v_u_getmouse = v_u_localplayer:GetMouse()
local v_u2 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u3 = require(v_u_replicatedstorage.Database.Components.Libraries.Skins)
local v_u4 = require(v_u_replicatedstorage.Database.Components.Libraries.Cases)
local v_u5 = require(v_u_replicatedstorage.Database.Components.Libraries.Collections)
local v6 = require(v_u_replicatedstorage.Components.Common.GetUserPlatform)
local v_u7 = require(v_u_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u8 = require(v_u_replicatedstorage.Database.Security.Remotes)
local v_u9 = require(v_u_replicatedstorage.Database.Security.Router)
local v_u10 = require(v_u_replicatedstorage.Database.Custom.GameStats.UI.Inventory.Buttons)
local v_u11 = require(v_u_replicatedstorage.Database.Custom.GameStats.UI.Inventory.Sort)
local v_u12 = require(v_u_replicatedstorage.Database.Custom.GameStats.Rarities)
local v_u13 = require(v_u_replicatedstorage.Database.Custom.GameStats.Grenades)
local v_u14 = require(script.Parent.UseItemFrame)
local v_u15 = require(script.Parent.Loadout)
local v_u16 = require(script.Parent.Store)
local v_u17 = require(v_u_replicatedstorage.Interface.MenuState)
local v_u_fromrgb = Color3.fromRGB(53, 83, 99)
local v_u_fromrgb = Color3.fromRGB(243, 243, 243)
local v_u_fromrgb = Color3.fromRGB(125, 206, 243)
local v_u18 = {
	["Sticker Capsule"] = 14,
	["Charm Capsule"] = 13,
	["Music Kit"] = 8,
	["Graffiti"] = 11,
	["Grenade"] = 16,
	["Sticker"] = 10,
	["Zeus x27"] = 3,
	["Charm"] = 9,
	["Melee"] = 1,
	["Glove"] = 2,
	["Badge"] = 7,
	["Case"] = 12,
	["C4"] = 15
}
local v_u19 = {
	["Melee"] = 1,
	["Glove"] = 2,
	["Case"] = 3
}
local v_u20 = {
	["Miscellaneous"] = 18,
	["Equipment"] = 17,
	["Pistol"] = 3,
	["Rifle"] = 6,
	["Heavy"] = 5,
	["SMG"] = 4
}
local v_u21 = {
	["Pistols"] = 1,
	["Mid Tier"] = 2,
	["Rifles"] = 3
}
local v_u22 = {
	["Equipped Melee"] = 1,
	["Equipped Gloves"] = 2,
	["Equipped Badge"] = 3,
	["Equipped Music Kit"] = 4,
	["Equipped Graffiti"] = 5,
	["Equipped Zeus x27"] = 6
}
local v_u23 = {}
local v_u24 = table.find(v6(), "PC") ~= nil
local v_u25 = nil
local v_u26 = nil
local v_u27 = nil
local v_u28 = 0
local v_u29 = false
local v_u30 = nil
local v_u31 = nil
local v_u32 = false
local v_u33 = false
local v_u34 = nil
local v_u35 = 0
local v_u36 = nil
local v_u37 = nil
local v_u38 = nil
local v_u39 = {}
local v_u40 = {
	["Charm Capsule"] = "Charm Pack"
}
local function v_u41(arg1, arg2)
	local v_getchildren = arg1:GetChildren()
	for _, v1 in ipairs(v_getchildren) do
		if v1.ClassName == arg2 then
			v1:Destroy()
		end
	end
end
local function v_u42()
	-- upvalues: (copy) v_u_getmouse, (ref) v_u37, (ref) v_u36
	local v_new = Vector2.new(v_u_getmouse.X, v_u_getmouse.Y)
	if v_u37.ItemNotification.Visible then
		return true
	end
	local v_options = v_u37.Tabs.Inventory.Sort.Button.Options
	if v_options.Visible then
		local v_absoluteposition = v_options.AbsolutePosition
		local v_absolutesize = v_options.AbsoluteSize
		if v_new.X >= v_absoluteposition.X and (v_new.X <= v_absoluteposition.X + v_absolutesize.X and (v_new.Y >= v_absoluteposition.Y and v_new.Y <= v_absoluteposition.Y + v_absolutesize.Y)) then
			return true
		end
	end
	if v_u36.Visible then
		local v_absoluteposition = v_u36.AbsolutePosition
		local v_absolutesize = v_u36.AbsoluteSize
		if v_new.X >= v_absoluteposition.X and (v_new.X <= v_absoluteposition.X + v_absolutesize.X and (v_new.Y >= v_absoluteposition.Y and v_new.Y <= v_absoluteposition.Y + v_absolutesize.Y)) then
			return true
		end
	end
	return false
end
local function v_u43(arg1)
	-- upvalues: (ref) v_u37, (copy) v_u_gui
	local v_absoluteposition = v_u37.AbsolutePosition
	local v_absolutesize = v_u37.Hover.AbsoluteSize
	local v_absolutesize = v_u37.AbsoluteSize
	local v_absolutesize = arg1.AbsoluteSize
	local v1 = arg1.AbsolutePosition.X - v_absoluteposition.X
	local v2 = v_absolutesize.X - (v1 + v_absolutesize.X) >= v_absolutesize.X + 8 and (v1 + v_absolutesize.X + 8 + v_absolutesize.X / 2) / v_absolutesize.X or (v1 - 8 - v_absolutesize.X / 2) / v_absolutesize.X
	local v_max = math.max((UNNAMED_1728998474712.Y - v_absoluteposition.Y + v_absolutesize.Y / 2) / v_absolutesize.Y, v_absolutesize.Y / 2 / v_absolutesize.Y)
	local v3 = 1 - v_absolutesize.Y / 2 / v_absolutesize.Y
	local v_min = math.min(v_max, v3)
	if v_u_gui:GetGuiInset().Y >= v_absoluteposition.Y + v_min * v_absolutesize.Y - v_absolutesize.Y / 2 then
		v_min = math.min(v_min + 30 / v_absolutesize.Y, v3)
	end
	return UDim2.fromScale(v2, v_min)
end
local function v_u44(arg1, arg2, arg3)
	-- upvalues: (copy) v_u3
	if arg3 then
		return arg2.imageAssetId or ""
	end
	if arg1.Type ~= "Charm" then
		return v_u3.GetWearImageForFloat(arg2, arg1.Float or 0.9999) or arg2.imageAssetId or ""
	end
	local v_pattern = arg1.Pattern
	if v_pattern and arg2.charmImages then
		for _, v1 in ipairs(arg2.charmImages) do
			if v1.pattern == v_pattern then
				return v1.assetId
			end
		end
	end
	return arg2.imageAssetId or ""
end
local function v_u45(arg1)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u21, (copy) v_u22
	local v1 = nil
	local v_get = v_u2.Get(v_u_localplayer, "Loadout")
	if not v_get then
		return nil
	end
	for _, v2 in ipairs({ "Counter-Terrorists", "Terrorists" }) do
		local v3 = v_get[v2]
		if v3 and v3.Loadout then
			for v4, v5 in pairs(v_u21) do
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
						local v11 = v_u22[v9] or 99
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
local function v_u46(arg1)
	-- upvalues: (copy) v_u4, (ref) v_u30, (copy) v_u3
	if arg1.Type ~= "Case" then
		local v_getskininformation = v_u3.GetSkinInformation(arg1.Name, arg1.Skin)
		return v_getskininformation and v_getskininformation.collection or nil
	end
	local v_getcasebyname = v_u4.GetCaseByName(arg1.Skin)
	if not (v_getcasebyname and v_u30) then
		return nil
	end
	for _, v1 in ipairs(v_u30) do
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
local function v_u47(arg1)
	-- upvalues: (copy) v_u46, (copy) v_u19, (copy) v_u3, (copy) v_u45, (copy) v_u18, (copy) v_u7, (copy) v_u20
	if arg1 == "Alphabetical" then
		return function(arg1, arg2)
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
		end
	end
	if arg1 == "Collection" then
		return function(arg1, arg2)
			-- upvalues: (ref) v_u46, (ref) v_u19, (ref) v_u3
			local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
			if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
				local v2 = v_u46(arg1) or ""
				local v3 = v_u46(arg2) or ""
				if v2 == v3 then
					local v4 = v_u19[arg1.Type] or 4
					local v5 = v_u19[arg2.Type] or 4
					if v4 == v5 then
						local v6 = {
							["Forbidden"] = 7,
							["Special"] = 6,
							["Red"] = 5,
							["Pink"] = 4,
							["Purple"] = 3,
							["Blue"] = 2,
							["Stock"] = 1
						}
						local v_getskininformation = v_u3.GetSkinInformation(arg1.Name, arg1.Skin)
						local v_getskininformation = v_u3.GetSkinInformation(arg2.Name, arg2.Skin)
						local v7 = v_getskininformation and (v6[v_getskininformation.rarity] or 0) or 0
						local v8 = v_getskininformation and v6[v_getskininformation.rarity] or 0
						if v7 == v8 then
							local v9
							if arg1.Type == "Case" then
								v9 = arg1.Skin or ""
							else
								v9 = (arg1.Name or "") .. "|" .. (arg1.Skin or "")
							end
							local v10
							if arg2.Type == "Case" then
								v10 = arg2.Skin or ""
							else
								v10 = (arg2.Name or "") .. "|" .. (arg2.Skin or "")
							end
							if v9 == v10 then
								return (arg1.MetaData and arg1.MetaData.CreatedAt or 0) > (arg2.MetaData and arg2.MetaData.CreatedAt or 0)
							else
								return v9 < v10
							end
						else
							return v8 < v7
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
		end
	end
	if arg1 == "Equipped" then
		return function(arg1, arg2)
			-- upvalues: (ref) v_u45
			local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
			if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
				local v2 = v_u45(arg1._id)
				local v3 = v_u45(arg2._id)
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
		end
	end
	if arg1 == "Newest" then
		return function(arg1, arg2)
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
		end
	end
	if arg1 ~= "Quality" then
		return arg1 == "Type" and function(arg1, arg2)
			-- upvalues: (ref) v_u18, (ref) v_u7, (ref) v_u20
			local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
			if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
				local v2 = v_u18[arg1.Type]
				local v3
				if v2 or arg1.Type ~= "Weapon" then
					v3 = v2 or 99
				else
					local v4, v5 = pcall(v_u7, arg1.Name)
					v3 = v4 and (v5 and v5.Type) and (v_u20[v5.Type] or 99) or 99
				end
				local v6 = v_u18[arg2.Type]
				local v7
				if v6 or arg2.Type ~= "Weapon" then
					v7 = v6 or 99
				else
					local v8, v9 = pcall(v_u7, arg2.Name)
					v7 = v8 and (v9 and v9.Type) and (v_u20[v9.Type] or 99) or 99
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
		end or nil
	end
	local v_u1 = {
		["Forbidden"] = 7,
		["Special"] = 6,
		["Red"] = 5,
		["Pink"] = 4,
		["Purple"] = 3,
		["Blue"] = 2,
		["Stock"] = 1
	}
	return function(arg1, arg2)
		-- upvalues: (ref) v_u3, (copy) v_u1
		local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
		if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
			local v_getskininformation = v_u3.GetSkinInformation(arg1.Name, arg1.Skin)
			local v_getskininformation = v_u3.GetSkinInformation(arg2.Name, arg2.Skin)
			local v2 = v_getskininformation and v_u1[v_getskininformation.rarity] or 0
			local v3 = v_getskininformation and v_u1[v_getskininformation.rarity] or 0
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
	end
end
local function v_u48()
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (ref) v_u31, (ref) v_u37, (copy) v_u47, (copy) v_u13
	local v_get = v_u2.Get(v_u_localplayer, "Inventory")
	if not v_get then
		return {}
	end
	local v1 = v_u47(v_u31 or (v_u37.Tabs.Inventory.Sort.Button.Frame.TextLabel.Text or "Newest"))
	local v2 = {}
	for _, v3 in ipairs(v_get) do
		local v4
		if v3 then
			v4 = v_u13[v3.Name]
		else
			v4 = v3
		end
		local v5
		if v3 then
			v5 = v3.Type == "Case"
		else
			v5 = v3
		end
		local v6 = v3 and (v3._id and v3.Name)
		if v6 then
			v6 = v5 or v3.Skin
		end
		if v6 and not v4 then
			table.insert(v2, v3)
		end
	end
	if v1 then
		table.sort(v2, v1)
	end
	return v2
end
local function v_u49(arg1, arg2)
	-- upvalues: (copy) v_u7
	if not arg2 or #arg2 == 0 then
		return true
	end
	for _, v1 in ipairs(arg2) do
		if arg1.Type and arg1.Type == v1 then
			return true
		end
		local v2
		if arg1.Name then
			local v3, v4 = pcall(v_u7, arg1.Name)
			v2 = v3 and v4 and v4 or nil
		else
			v2 = nil
		end
		if string.find(v1, ":") then
			local v_split = string.split(v1, ":")
			if v_split[1] == "Weapon" and (v2 and (v2.Class == "Weapon" and v2.Type == v_split[2])) then
				return true
			end
		elseif v2 and v2.Class == v1 then
			return true
		end
	end
	return false
end
local function v_u50(arg1)
	-- upvalues: (ref) v_u37, (copy) v_u10, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u49
	local v1 = nil
	local v2 = nil
	for _, v3 in ipairs(v_u37.Top.Filter:GetChildren()) do
		if v3:IsA("TextButton") and v3:GetAttribute("Selected") then
			v2 = v3.Name
			break
		end
	end
	for _, v4 in ipairs(v_u37.Top.Categories:GetChildren()) do
		if v4:IsA("TextButton") and v4:GetAttribute("Selected") then
			v1 = v4.Name
			break
		end
	end
	local v5 = nil
	if v2 and v1 then
		local v6 = v_u10[v1]
		if v6 and v6[v2] then
			v5 = v6[v2].Search
		end
	end
	local v7 = {}
	local v_get = v_u2.Get(v_u_localplayer, "Inventory")
	if v_get then
		for _, v8 in ipairs(v_get) do
			if v8.Charm then
				local v9 = type(v8.Charm) == "table" and v8.Charm._id
				if not v9 then
					if type(v8.Charm) == "string" then
						v9 = v8.Charm
					else
						v9 = false
					end
				end
				if v9 then
					v7[v9] = true
				end
			end
		end
	end
	local v10 = {}
	for _, v11 in ipairs(arg1) do
		local v12 = v_u49(v11, v5)
		if v12 and (v11.Type == "Charm" and v7[v11._id]) then
			v12 = false
		end
		if v12 then
			table.insert(v10, v11)
		end
	end
	return v10
end
local function v_u51()
	-- upvalues: (ref) v_u37, (ref) v_u35, (ref) v_u23, (copy) v_u1
	if v_u37 then
		local v_container = v_u37.Tabs.Inventory.Container
		local v_min = math.min(v_u35 + 25, #v_u23)
		for v1 = v_u35 + 1, v_min do
			local v2 = v_u23[v1]
			if v2 and not v_container:FindFirstChild(v2._id) then
				v_u1.CreateItemTemplate(v2)
			end
		end
		v_u35 = v_min
		for _, v3 in ipairs(v_container:GetChildren()) do
			if v3:IsA("Frame") and (v3.Name ~= "UIGridLayout" and (v3.Name ~= "UIListLayout" and v3.Name ~= "UIPadding")) then
				for v4, v5 in ipairs(v_u23) do
					if v5._id == v3.Name then
						v3.LayoutOrder = v4
						break
					end
				end
			end
		end
	end
end
local function v_u52()
	-- upvalues: (ref) v_u37, (ref) v_u35, (ref) v_u23, (copy) v_u51
	if v_u37 then
		local v1 = v_u37.Tabs.Inventory.Container.AbsoluteCanvasSize.Y - v_u37.Tabs.Inventory.Container.AbsoluteSize.Y
		if v1 > 0 and (v_u35 < #v_u23 and v1 - v_u37.Tabs.Inventory.Container.CanvasPosition.Y < 200) then
			v_u51()
			return
		end
	end
end
local function v_u53()
	-- upvalues: (ref) v_u37
	if not (v_u37 and v_u37.Visible) then
		return 50
	end
	local v_container = v_u37.Tabs.Inventory.Container
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
		local v_floor = math.floor((v10 + v4) / UNNAMED_1729003284392)
		v11 = math.max(1, v_floor)
	else
		v11 = 1
	end
	local v12
	if v1 + v2 > 0 then
		local v_floor = math.floor((v9 + v2) / UNNAMED_1729003286888)
		v12 = math.max(1, v_floor)
	else
		v12 = 1
	end
	return v12 * v11 + v11
end
local function v_u54()
	-- upvalues: (ref) v_u37, (ref) v_u35, (copy) v_u53, (ref) v_u23, (copy) v_u1, (ref) v_u32
	if not (v_u37 and v_u37.Visible) then
		return
	end
	local v_container = v_u37.Tabs.Inventory.Container
	v_u35 = 0
	local v1 = v_u53()
	local v_max = math.max(v1, 50)
	local v_min = math.min(v_max, #v_u23)
	for v2 = 1, v_min do
		local v3 = v_u23[v2]
		if v3 and not v_container:FindFirstChild(v3._id) then
			v_u1.CreateItemTemplate(v3)
		end
	end
	for _, v4 in ipairs(v_container:GetChildren()) do
		if v4:IsA("Frame") and (v4.Name ~= "UIGridLayout" and (v4.Name ~= "UIListLayout" and v4.Name ~= "UIPadding")) then
			for v5, v6 in ipairs(v_u23) do
				if v6._id == v4.Name then
					v4.LayoutOrder = v5
					break
				end
			end
		end
	end
	v_u35 = v_min
	v_u32 = false
end
local function v_u55()
	-- upvalues: (ref) v_u37, (ref) v_u23, (ref) v_u35, (ref) v_u32, (copy) v_u54
	if v_u37 then
		local v_container = v_u37.Tabs.Inventory.Container
		local v1 = {}
		for _, v2 in ipairs(v_u23) do
			if v2 and v2._id then
				v1[v2._id] = true
			end
		end
		for _, v3 in ipairs(v_container:GetChildren()) do
			if v3:IsA("Frame") and (v3.Name ~= "UIGridLayout" and (v3.Name ~= "UIListLayout" and (v3.Name ~= "UIPadding" and (v3.Name ~= "Title" and (v3.Name ~= "Label" and not v1[v3.Name]))))) then
				v3:Destroy()
			end
		end
		v_u35 = 0
		v_u32 = true
		if v_u37.Visible then
			v_u54()
		end
	end
end
local function v_u56(arg1, arg2, _, arg4, arg5, _)
	-- upvalues: (copy) v_u_tween, (copy) v_u9, (ref) v_u31, (ref) v_u37, (ref) v_u33, (ref) v_u32, (ref) v_u23, (copy) v_u48, (copy) v_u50, (copy) v_u55
	arg2.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) arg2
		v_u_tween:Create(arg2, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["BackgroundTransparency"] = 0.85
		}):Play()
	end)
	arg2.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) arg2
		v_u_tween:Create(arg2, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["BackgroundTransparency"] = 1
		}):Play()
	end)
	arg2.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u9, (ref) v_u31, (copy) arg4, (ref) v_u37, (ref) v_u33, (ref) v_u32, (ref) v_u23, (ref) v_u48, (ref) v_u50, (ref) v_u55, (copy) arg5, (copy) arg1, (copy) arg2
		v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
		v_u31 = arg4
		if v_u37 then
			if v_u37.Visible then
				v_u23 = v_u48()
				v_u23 = v_u50(v_u23)
				v_u55()
			else
				v_u33 = true
				v_u32 = true
			end
		end
		arg5.Text = arg4
		for _, v1 in ipairs(arg1:GetChildren()) do
			if v1:IsA("TextButton") then
				v1.Frame.BackgroundTransparency = v1 == arg2 and 0 or 1
			end
		end
		arg1.Visible = false
	end)
end
local function v_u57(self)
	-- upvalues: (copy) v_u_tween
	local v_u_hoverframe = self:FindFirstChild("HoverFrame")
	local v_u_size = self.Size
	self.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self, (copy) v_u_size, (copy) v_u_hoverframe
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.new(v2.X.Scale * 0.95, v2.X.Offset, v2.Y.Scale * 0.95, v2.Y.Offset)
		v_u_tween:Create(self, v_new, v1):Play()
		if v_u_hoverframe and not self:GetAttribute("Selected") then
			v_u_hoverframe.BackgroundTransparency = 1
			v_u_hoverframe.Visible = true
			v_u_tween:Create(v_u_hoverframe, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["BackgroundTransparency"] = 0.85
			}):Play()
		end
	end)
	self.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self, (copy) v_u_size, (copy) v_u_hoverframe
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.new(v2.X.Scale * 1, v2.X.Offset, v2.Y.Scale * 1, v2.Y.Offset)
		v_u_tween:Create(self, v_new, v1):Play()
		if v_u_hoverframe and not self:GetAttribute("Selected") then
			local v_create = v_u_tween:Create(v_u_hoverframe, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["BackgroundTransparency"] = 1
			})
			v_create:Play()
			v_create.Completed:Once(function()
				-- upvalues: (ref) v_u_hoverframe
				v_u_hoverframe.Visible = false
			end)
		end
	end)
	self.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self, (copy) v_u_size
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.new(v2.X.Scale * 0.9, v2.X.Offset, v2.Y.Scale * 0.9, v2.Y.Offset)
		v_u_tween:Create(self, v_new, v1):Play()
	end)
	self.MouseButton1Up:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self, (copy) v_u_size
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.new(v2.X.Scale * 0.95, v2.X.Offset, v2.Y.Scale * 0.95, v2.Y.Offset)
		v_u_tween:Create(self, v_new, v1):Play()
	end)
end
function v_u1.CreateItemTemplate(self)
	-- upvalues: (copy) v_u4, (copy) v_u3, (copy) v_u12, (copy) v_u44, (copy) v_u_replicatedstorage, (ref) v_u37, (copy) v_u40, (copy) v_u42, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u9, (ref) v_u25, (copy) v_u1, (ref) v_u36, (copy) v_u_getmouse, (ref) v_u27, (ref) v_u34, (copy) v_u24, (ref) v_u26
	if self and self._id then
		local v1 = self.Type == "Case"
		local v2 = v1 and v_u4.GetCaseByName(self.Skin) or v_u3.GetSkinInformation(self.Name, self.Skin)
		if v2 then
			local v3 = v_u12[v1 and v2.caseRarity or v2.rarity]
			local v4 = v_u44(self, v2, v1)
			local v_u_clone = v_u_replicatedstorage.Assets.UI.Inventory.ItemTemplate:Clone()
			v_u_clone.Main.RarityFrame.UIGradient.Color = v3.ColorSequence
			v_u_clone.Main.Glow.UIGradient.Color = v3.ColorSequence
			v_u_clone.Parent = v_u37.Tabs.Inventory.Container
			v_u_clone.Main.Icon.Image = v4
			v_u_clone.Name = self._id
			local v5 = v1 and v2.caseType and v_u40[v2.caseType] or v1 and v2.caseType or (self.StatTrack and "KillTrak\226\132\162 " .. self.Name or self.Name)
			local v6 = v1 and v2.skin or (self.Skin or "")
			if self.Type == "Melee" then
				v5 = "\226\152\133 " .. v5
			end
			v_u_clone.Information.Weapon.Text = v5
			v_u_clone.Information.Skin.Text = v6
			v_u_clone.Button.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u37, (ref) v_u42, (ref) v_u2, (ref) v_u_localplayer, (ref) self, (ref) v_u9, (ref) v_u25, (ref) v_u1, (ref) v_u36, (ref) v_u_getmouse, (ref) v_u27, (ref) v_u34
				if v_u37.ItemNotification.Visible or v_u42() then
					return
				end
				local v_get = v_u2.Get(v_u_localplayer, "Inventory")
				if v_get then
					for _, v1 in ipairs(v_get) do
						if v1._id == self._id then
							self = v1
							break
						end
					end
				end
				v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
				v_u25 = self
				if self.Type == "Case" or (self.Type == "Charm Capsule" and true or self.Type == "Sticker Capsule") then
					v_u1.SetupInformationFrame(self)
					v_u36.Visible = true
					local v_parent = v_u36.Parent
					local v2 = (v_u_getmouse.X - v_parent.AbsolutePosition.X) / v_parent.AbsoluteSize.X
					v_u36.Position = UDim2.fromScale(1 - v2 >= v_u36.Size.X.Scale + 0.01 and v2 + v_u36.Size.X.Scale / 2 + 0.01 or v2 - v_u36.Size.X.Scale / 2 - 0.01, (v_u_getmouse.Y - UNNAMED_1729003634072.Y) / UNNAMED_1729003635560.Y + v_u36.Size.Y.Scale / 2)
					v_u37.Hover.Visible = false
				else
					v_u36.Visible = not v_u36.Visible
					if v_u36.Visible then
						local v_parent = v_u36.Parent
						local v3 = (v_u_getmouse.X - v_parent.AbsolutePosition.X) / v_parent.AbsoluteSize.X
						v_u36.Position = UDim2.fromScale(1 - v3 >= v_u36.Size.X.Scale + 0.01 and v3 + v_u36.Size.X.Scale / 2 + 0.01 or v3 - v_u36.Size.X.Scale / 2 - 0.01, (v_u_getmouse.Y - UNNAMED_1728998092792.Y) / UNNAMED_1728998091400.Y + v_u36.Size.Y.Scale / 2)
						v_u37.Hover.Visible = false
					elseif v_u27 then
						v_u34 = tick()
					end
					v_u1.SetupInformationFrame(self)
				end
			end)
			if v_u24 then
				v_u_clone.MouseEnter:Connect(function()
					-- upvalues: (ref) v_u26, (ref) self, (ref) v_u27, (copy) v_u_clone, (ref) v_u34
					v_u26 = self
					v_u27 = v_u_clone
					v_u34 = tick()
				end)
				v_u_clone.MouseLeave:Connect(function()
					-- upvalues: (ref) v_u27, (ref) v_u26, (ref) v_u34
					v_u27 = nil
					v_u26 = nil
					v_u34 = nil
				end)
			end
		else
			print((("[Inventory] Skipping template creation for item: %* | %* (Type: %*) - No item information found"):format(self.Name, self.Skin, self.Type)))
		end
	else
		return
	end
end
function v_u1.UpdateInventoryFilter()
	-- upvalues: (ref) v_u37, (ref) v_u33, (ref) v_u32, (ref) v_u23, (copy) v_u48, (copy) v_u50, (copy) v_u55
	if v_u37 then
		if v_u37.Visible then
			v_u23 = v_u48()
			v_u23 = v_u50(v_u23)
			v_u55()
		else
			v_u33 = true
			v_u32 = true
		end
	else
		return
	end
end
function v_u1.UpdateInventory(arg1)
	-- upvalues: (ref) v_u37, (ref) v_u33, (ref) v_u32, (ref) v_u23, (copy) v_u48, (copy) v_u50, (copy) v_u55
	if v_u37 then
		if arg1 and type(arg1) == "table" then
			if v_u37.Visible then
				local v_container = v_u37.Tabs.Inventory.Container
				local v1 = {}
				for _, v2 in ipairs(arg1) do
					if v2 and v2._id then
						v1[v2._id] = true
					end
				end
				for _, v3 in ipairs(v_container:GetChildren()) do
					if v3:IsA("Frame") and (v3.Name ~= "UIGridLayout" and (v3.Name ~= "UIListLayout" and (v3.Name ~= "UIPadding" and (v3.Name ~= "Title" and (v3.Name ~= "Label" and not v1[v3.Name]))))) then
						v3:Destroy()
					end
				end
				if v_u37 then
					if v_u37.Visible then
						v_u23 = v_u48()
						v_u23 = v_u50(v_u23)
						v_u55()
					else
						v_u33 = true
						v_u32 = true
					end
				else
					return
				end
			else
				v_u33 = true
				v_u32 = true
				return
			end
		else
			print("UpdateInventory received invalid inventory data:", arg1)
			return
		end
	else
		return
	end
end
function v_u1.UpdateTemplates(arg1)
	-- upvalues: (ref) v_u37, (copy) v_u3, (copy) v_u12, (copy) v_u44
	if v_u37 and v_u37.Visible then
		local v_container = v_u37.Tabs.Inventory.Container
		if arg1 then
			for _, v1 in ipairs(arg1) do
				local v2 = v_container:FindFirstChild(v1._id)
				if v2 and v2:IsA("Frame") then
					local v_getskininformation = v_u3.GetSkinInformation(v1.Name, v1.Skin)
					if v_getskininformation then
						v2.Main.RarityFrame.UIGradient.Color = v_u12[v_getskininformation.rarity].ColorSequence
						v2.Main.Glow.UIGradient.Color = v_u12[v_getskininformation.rarity].ColorSequence
						v2.Main.Icon.Image = v_u44(v1, v_getskininformation, false)
					end
				end
			end
		end
	end
end
function v_u1.SetupInformationFrame(arg1)
	-- upvalues: (ref) v_u36
	v_u36.Inspect.Visible = (arg1.Type == "Weapon" or (arg1.Type == "Glove" or arg1.Type == "Melee")) and true or arg1.Type == "Charm"
	v_u36.Unlock.Visible = arg1.Type == "Case"
	v_u36.Loadout.Visible = false
	local v1 = arg1.Type == "Weapon" and true or arg1.Type == "Charm"
	if not v_u36.Charm then
		warn("[Inventory] InformationFrame.Charm element not found - item type:", arg1.Type)
	end
	if v_u36.Charm then
		v_u36.Charm.Visible = v1
		local v2 = v1 and v_u36.Charm:FindFirstChild("TextLabel")
		if v2 then
			if arg1.Type == "Charm" then
				v2.Text = "Attach to Weapon"
				return
			end
			local v3
			if arg1.Charm == nil or arg1.Charm == false then
				v3 = false
			else
				v3 = (type(arg1.Charm) == "string" or arg1.Charm == true) and true or type(arg1.Charm) == "table"
			end
			if v3 then
				v2.Text = "Detach Charm"
				return
			end
			v2.Text = "Attach Charm"
		end
	end
end
function v_u1.SelectOption(arg1, arg2)
	-- upvalues: (ref) v_u37, (copy) v_u_fromrgb, (copy) v_u_fromrgb, (copy) v_u_fromrgb, (copy) v_u1
	arg1.HoverFrame.BackgroundTransparency = 0
	arg1.HoverFrame.Visible = true
	for _, v1 in ipairs(v_u37.Top.Filter:GetChildren()) do
		if v1:IsA("TextButton") then
			v1.HoverFrame.Visible = v1.Name == arg2
			v1.HoverFrame.BackgroundColor3 = v_u_fromrgb
			v1.TextLabel.TextColor3 = v_u_fromrgb
			v1:SetAttribute("Selected", nil)
			if v1.HoverFrame.Visible then
				v1.HoverFrame.BackgroundColor3 = v_u_fromrgb
				v1.TextLabel.TextColor3 = v_u_fromrgb
				v1:SetAttribute("Selected", true)
			end
		end
	end
	v_u1.UpdateInventoryFilter()
end
function v_u1.NextInventoryItem(arg1)
	-- upvalues: (copy) v_u39, (ref) v_u28, (copy) v_u4, (copy) v_u3, (copy) v_u12, (copy) v_u44, (ref) v_u37
	local v1 = v_u39[arg1]
	v_u28 = arg1
	if v1 then
		local v2 = v1.Type == "Case"
		local v3 = v2 and v_u4.GetCaseByName(v1.Skin) or v_u3.GetSkinInformation(v1.Name, v1.Skin)
		local v4 = v_u12[v2 and v3.caseRarity or v3.rarity]
		local v5 = v_u44(v1, v3, v2)
		v_u37.ItemNotification.Holder.ViewLoadout.Visible = v1.Type ~= "Case"
		v_u37.ItemNotification.Holder.RarityFrame.UIGradient.Color = v4.ColorSequence
		v_u37.ItemNotification.Holder.Background.ImageColor3 = v4.Color
		v_u37.ItemNotification.Holder.IconShadow.Image = v5
		v_u37.ItemNotification.Holder.Light.ImageColor3 = v4.Color
		v_u37.ItemNotification.Holder.WeaponName.Text = v2 and v3.Skin or ("%* | %*"):format(v1.Name, v1.Skin)
		v_u37.ItemNotification.Holder.Icon.Image = v5
		v_u37.ItemNotification.Visible = true
		v_u37.ItemNotification.Holder.Title.TextColor3 = Color3.new(v4.Color.R * 0.56, v4.Color.G * 0.56, v4.Color.B * 0.56)
	end
end
function v_u1.SelectCategory(arg1)
	-- upvalues: (copy) v_u10, (copy) v_u41, (ref) v_u37, (copy) v_u_fromrgb, (copy) v_u_fromrgb, (copy) v_u_fromrgb, (copy) v_u_replicatedstorage, (copy) v_u_text, (copy) v_u1, (copy) v_u57, (copy) v_u9
	local v1 = v_u10[arg1]
	if v1 then
		v_u41(v_u37.Top.Filter, "TextButton")
		for _, v2 in ipairs(v_u37.Top.Categories:GetChildren()) do
			if v2:IsA("TextButton") and v2:GetAttribute("IsCategoryButton") then
				v2.HoverFrame.Visible = v2.Name == arg1
				v2.HoverFrame.BackgroundColor3 = v_u_fromrgb
				v2.TextLabel.TextColor3 = v_u_fromrgb
				v2:SetAttribute("Selected", nil)
				if v2.HoverFrame.Visible then
					v2.HoverFrame.BackgroundColor3 = v_u_fromrgb
					v2.TextLabel.TextColor3 = v_u_fromrgb
					v2:SetAttribute("Selected", true)
				end
			end
		end
		for v_u3, v4 in pairs(v1) do
			local v_u_clone = v_u_replicatedstorage.Assets.UI.Inventory.OptionTemplate:Clone()
			v_u_clone.HoverFrame.BackgroundColor3 = v_u_fromrgb
			v_u_clone.TextLabel.TextColor3 = v_u_fromrgb
			v_u_clone.LayoutOrder = v4.LayoutOrder
			v_u_clone.Parent = v_u37.Top.Filter
			v_u_clone.Visible = v_u3 ~= "Default"
			v_u_clone.TextLabel.Text = v_u3
			v_u_clone.HoverFrame.Visible = false
			v_u_clone.Name = v_u3
			v_u_clone.Size = UDim2.new(0, v_u_text:GetTextSize(v_u3, v_u_clone.TextLabel.TextSize, v_u_clone.TextLabel.Font, Vector2.new((1 / 0), (1 / 0))).X + 16, v_u_clone.Size.Y.Scale, v_u_clone.Size.Y.Offset)
			if v4.LayoutOrder == 0 then
				v_u1.SelectOption(v_u_clone, v_u3)
			end
			v_u57(v_u_clone)
			v_u_clone.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u1, (copy) v_u_clone, (copy) v_u3, (ref) v_u9
				v_u1.SelectOption(v_u_clone, v_u3)
				v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
			end)
		end
	else
		warn((("[Inventory] Category \"%*\" not found in InventoryButtons"):format(arg1)))
	end
end
function v_u1.SetupCategoryButton(self)
	-- upvalues: (copy) v_u57, (copy) v_u1, (copy) v_u9
	v_u57(self)
	self.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u1, (copy) self, (ref) v_u9
		v_u1.SelectCategory((tostring(self.Name)))
		v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
	end)
end
function v_u1.UpdateHoverFrame(_)
	-- upvalues: (ref) v_u34, (copy) v_u42, (ref) v_u37, (ref) v_u36, (ref) v_u27, (ref) v_u26, (copy) v_u43, (copy) v_u4, (copy) v_u3, (copy) v_u40, (copy) v_u46, (copy) v_u5, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u_replicatedstorage, (copy) v_u12, (copy) v_u7
	local v1 = v_u42()
	if v_u37.Visible and (not v1 and (not v_u36.Visible and (v_u27 and (v_u26 and tick() - (v_u34 or 0) > 0.75)))) then
		v_u37.Hover.Position = v_u43(v_u27)
		local v2 = v_u26
		local v3 = v2.Type == "Case"
		local v4 = v3 and v_u4.GetCaseByName(v2.Skin) or v_u3.GetSkinInformation(v2.Name, v2.Skin)
		if v4 then
			local v5 = v3 and v4.skin or v2.Skin
			v_u37.Hover.ItemName.Frame.ItemName.Text = ((v2.Type == "Melee" and "\226\152\133 " or "") .. (v3 and v4.caseType and v_u40[v4.caseType] or v3 and v4.caseType or (v2.StatTrack and "KillTrak\226\132\162 " .. v2.Name or v2.Name))) .. (v5 == "Vanilla" and "" or (" | " .. v5 or ""))
			local v6 = v_u46(v2)
			v_u37.Hover.ItemName.Frame.Collection.Text = v6 or ""
			local v_collectionicon = v_u37.Hover.ItemName.CollectionIcon
			if v6 then
				local v_getcollectionbyname = v_u5.GetCollectionByName(v6)
				if v_getcollectionbyname and v_getcollectionbyname.imageAssetId then
					v_collectionicon.Image = v_getcollectionbyname.imageAssetId
					v_collectionicon.Visible = true
				else
					v_collectionicon.Visible = false
				end
			else
				v_collectionicon.Visible = false
			end
			local v_collectionname = v_u37.Hover:FindFirstChild("CollectionName")
			if v_collectionname then
				if v6 then
					v_collectionname.Text = v6 .. ":"
					v_collectionname.Visible = true
				else
					v_collectionname.Visible = false
				end
			end
			if v6 and not v3 then
				local v_getcollectionbyname = v_u5.GetCollectionByName(v6)
				if v_getcollectionbyname and v_getcollectionbyname.items then
					local v_collection = v_u37.Hover.Collection
					local v_get = v_u2.Get(v_u_localplayer, "Inventory")
					for _, v7 in ipairs(v_collection:GetChildren()) do
						if v7:IsA("Frame") and v7.Name ~= "UIListLayout" then
							v7:Destroy()
						end
					end
					local v8 = {}
					if v_get then
						for _, v9 in ipairs(v_get) do
							if v9.Name and v9.Skin then
								v8[v9.Name .. "|" .. v9.Skin] = true
							end
						end
					end
					local v10 = {
						["Blue"] = 1,
						["Purple"] = 2,
						["Pink"] = 3,
						["Red"] = 4,
						["Special"] = 5,
						["Forbidden"] = 6,
						["Stock"] = 7
					}
					local v11 = {}
					for _, v12 in ipairs(v_getcollectionbyname.items) do
						if v12.itemName and v12.skinName then
							local v_getskininformation = v_u3.GetSkinInformation(v12.itemName, v12.skinName)
							if v_getskininformation then
								table.insert(v11, {
									["item"] = v12,
									["rarity"] = v_getskininformation.rarity,
									["rarityOrder"] = v10[v_getskininformation.rarity] or 99
								})
							end
						end
					end
					table.sort(v11, function(arg1, arg2)
						if arg1.rarityOrder == arg2.rarityOrder then
							return arg1.item.itemName < arg2.item.itemName
						else
							return arg1.rarityOrder < arg2.rarityOrder
						end
					end)
					local v_collectionnametemplate = v_u_replicatedstorage.Assets.UI.Inventory.CollectionNameTemplate
					for v13, v14 in ipairs(v11) do
						local v_item = v14.item
						local v_getskininformation = v_u3.GetSkinInformation(v_item.itemName, v_item.skinName)
						if v_getskininformation and v_collectionnametemplate then
							local v_clone = v_collectionnametemplate:Clone()
							v_clone.Parent = v_collection
							v_clone.LayoutOrder = v13
							v_clone.Visible = true
							local v15 = v_clone:FindFirstChild("CollectionName") or v_clone:FindFirstChild("gun")
							if v15 then
								v15.Text = "[" .. v_item.itemName .. "] | " .. v_item.skinName
								local v_rarity = v_getskininformation.rarity
								if v_rarity then
									v_rarity = v_u12[v_getskininformation.rarity]
								end
								if v_rarity then
									v15.TextColor3 = v_rarity.Color
								end
								v15.Visible = true
							end
							local v_imagelabel = v_clone:FindFirstChild("ImageLabel")
							if v_imagelabel then
								v_imagelabel.Visible = v8[v_item.itemName .. "|" .. v_item.skinName] == true
							end
						end
					end
					if v_collectionname then
						v_collectionname.Visible = true
					end
					v_collection.Visible = true
					local v_collectionspacer = v_u37.Hover:FindFirstChild("CollectionSpacer")
					if v_collectionspacer then
						v_collectionspacer.Visible = true
					end
				else
					local v_collection = v_u37.Hover.Collection
					if v_collection then
						for _, v16 in ipairs(v_collection:GetChildren()) do
							if v16:IsA("Frame") and v16.Name ~= "UIListLayout" then
								v16:Destroy()
							end
						end
						v_collection.Visible = false
					end
					local v_collectionname = v_u37.Hover:FindFirstChild("CollectionName")
					if v_collectionname then
						v_collectionname.Visible = false
					end
					local v_collectionspacer = v_u37.Hover:FindFirstChild("CollectionSpacer")
					if v_collectionspacer then
						v_collectionspacer.Visible = false
					end
				end
			else
				local v_collection = v_u37.Hover.Collection
				if v_collection then
					for _, v17 in ipairs(v_collection:GetChildren()) do
						if v17:IsA("Frame") and v17.Name ~= "UIListLayout" then
							v17:Destroy()
						end
					end
					v_collection.Visible = false
				end
				local v_collectionname = v_u37.Hover:FindFirstChild("CollectionName")
				if v_collectionname then
					v_collectionname.Visible = false
				end
				local v_collectionspacer = v_u37.Hover:FindFirstChild("CollectionSpacer")
				if v_collectionspacer then
					v_collectionspacer.Visible = false
				end
			end
			if v3 or v2.Type ~= "Weapon" and (v2.Type ~= "Melee" and v2.Type ~= "Glove") then
				if v3 then
					if v4.description then
						v_u37.Hover.Description.Text = v4.description
					else
						v_u37.Hover.Description.Text = ""
					end
				elseif v4.description then
					v_u37.Hover.Description.Text = v4.description
				else
					v_u37.Hover.Description.Text = ""
				end
			else
				local v_getskininformation = v_u3.GetSkinInformation(v2.Type == "Melee" and "T Knife" or (v2.Type == "Glove" and "T Glove" or v2.Name), "Stock")
				if v_getskininformation and v_getskininformation.description then
					v_u37.Hover.Description.Text = v_getskininformation.description
				else
					v_u37.Hover.Description.Text = ""
				end
			end
			if v3 or (v2.Type == "Charm Capsule" and true or v2.Type == "Sticker Capsule") then
				v_u37.Hover.Information.Visible = false
			else
				v_u37.Hover.Information.Visible = true
			end
			local v18 = v3 and v4.caseRarity or v4.rarity
			if v18 then
				local v19 = v_u12[v18]
				if v19 then
					v_u37.Hover.Information.Rarity.Label.Text = ({
						["Blue"] = "Blue",
						["Purple"] = "Purple",
						["Pink"] = "Pink",
						["Red"] = "Red",
						["Special"] = "\226\152\133 Special",
						["Forbidden"] = "\226\152\133 Special"
					})[v18] or v18
					v_u37.Hover.Information.Rarity.Label.TextColor3 = v19.Color
				else
					v_u37.Hover.Information.Rarity.Label.Text = ""
				end
			else
				v_u37.Hover.Information.Rarity.Label.Text = ""
			end
			local v_exterior = v_u37.Hover.Information.Exterior
			if v3 then
				v_exterior.Visible = false
			else
				local v_getwearnameforfloat = v_u3.GetWearNameForFloat(v4, v2.Float or v4.floatRange.max)
				if v_getwearnameforfloat then
					v_exterior.Label.Text = v_getwearnameforfloat
					v_exterior.Visible = true
				else
					v_exterior.Visible = false
				end
			end
			local v_team = v_u37.Hover.Information.Team.Team
			if (v2.Type == "Melee" or (v2.Type == "Glove" or v2.Type == "Badge")) and true or v2.Type == "Charm" then
				v_team.CT.Visible = true
				v_team.T.Visible = true
				v_team.Label.Visible = true
				v_team.Label.Text = "Both"
			elseif v2.Type == "Weapon" then
				local v20, v21 = pcall(v_u7, v2.Name)
				if v20 and (v21 and v21.Team) then
					local v_team = v21.Team
					if v_team == "Counter-Terrorists" then
						v_team.CT.Visible = true
						v_team.T.Visible = false
						v_team.Label.Visible = true
						v_team.Label.Text = "Counter-Terrorists"
					elseif v_team == "Terrorists" then
						v_team.CT.Visible = false
						v_team.T.Visible = true
						v_team.Label.Visible = true
						v_team.Label.Text = "Terrorists"
					else
						v_team.CT.Visible = true
						v_team.T.Visible = true
						v_team.Label.Visible = true
						v_team.Label.Text = "Both"
					end
				end
			end
		end
		v_u37.Hover.Visible = true
	else
		v_u37.Hover.Visible = false
	end
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u38, (ref) v_u37, (ref) v_u36, (copy) v_u5, (ref) v_u30, (copy) v_u9, (ref) v_u25, (copy) v_u8, (copy) v_u14, (copy) v_u17, (copy) v_u4, (copy) v_u16, (ref) v_u28, (copy) v_u1, (copy) v_u39, (copy) v_u15, (copy) v_u11, (copy) v_u56, (ref) v_u33, (ref) v_u32, (ref) v_u23, (copy) v_u48, (copy) v_u50, (copy) v_u55, (copy) v_u54, (copy) v_u52
	v_u38 = arg1
	v_u37 = arg2
	v_u36 = arg2.Information
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u30
		v_u30 = arg1
	end)
	v_u36.Inspect.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u9, (ref) v_u25, (ref) v_u36
		v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
		if v_u25 then
			v_u36.Visible = false
			v_u9.broadcastRouter("WeaponInspect", v_u25.Name, v_u25.Skin, v_u25.Float, v_u25.StatTrack, v_u25.NameTag, v_u25.Charm, v_u25.Stickers, v_u25.Type, v_u25.Pattern, v_u25._id, v_u25.Serial, v_u25.IsTradeable)
		end
	end)
	if v_u36.Charm then
		v_u36.Charm.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u9, (ref) v_u25, (ref) v_u36, (ref) v_u8, (ref) v_u37, (ref) v_u14
			v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
			if v_u25 then
				local v1
				if v_u25.Charm == nil or v_u25.Charm == false then
					v1 = false
				else
					v1 = (type(v_u25.Charm) == "string" or v_u25.Charm == true) and true or type(v_u25.Charm) == "table"
				end
				v_u36.Visible = false
				if v1 then
					v_u8.Inventory.RemoveWeaponCharm.Send({
						["WeaponId"] = v_u25._id
					})
					return
				end
				v_u37.Visible = false
				v_u14.TriggerAction("AttachCharm", v_u25)
			end
		end)
	end
	v_u14.OnItemSelected:Connect(function(arg1, arg2)
		-- upvalues: (ref) v_u14
		local v_get = v_u14.GetActions().Get(arg2.ActionType)
		if v_get then
			v_get.OnItemSelected(arg1, arg2)
		end
	end)
	v_u14.OnClosed:Connect(function(_)
		-- upvalues: (ref) v_u17, (ref) v_u37
		if v_u17.GetCurrentScreen() == "Inventory" then
			v_u37.Visible = true
		end
	end)
	v_u36.Unlock.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u9, (ref) v_u25, (ref) v_u4, (ref) v_u16, (ref) v_u36, (ref) v_u37
		v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
		if v_u25 then
			local v_getcasebyname = v_u4.GetCaseByName(v_u25.Skin)
			v_u16.OpenCaseContent(v_getcasebyname.caseId, "Open", v_u25._id)
			v_u36.Visible = false
			v_u37.Visible = false
		end
	end)
	v_u37.ItemNotification.Holder.Left.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u9, (ref) v_u28, (ref) v_u1
		v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
		if v_u28 > 0 then
			v_u1.NextInventoryItem(v_u28 - 1)
		end
	end)
	v_u37.ItemNotification.Holder.Right.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u9, (ref) v_u28, (ref) v_u39, (ref) v_u1
		v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
		if v_u28 <= #v_u39 then
			v_u1.NextInventoryItem(v_u28 + 1)
		end
	end)
	v_u37.ItemNotification.Holder.Continue.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u9, (ref) v_u37, (ref) v_u39
		v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
		v_u37.ItemNotification.Visible = false
		table.clear(v_u39)
	end)
	v_u37.ItemNotification.Holder.ViewLoadout.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u39, (ref) v_u28, (ref) v_u9, (ref) v_u37, (ref) v_u15
		local v1 = v_u39[v_u28]
		v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
		v_u37.ItemNotification.Visible = false
		if v1 and (v1 == "Melee" or (v1 == "Glove" or v1 == "Weapon")) and true or false then
			v_u37.Visible = false
			v_u15.ViewInLoadout(v1._id)
		end
	end)
	v_u37.Tabs.Inventory.Sort.Button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u37, (ref) v_u9
		v_u37.Tabs.Inventory.Sort.Button.Options.Visible = not v_u37.Tabs.Inventory.Sort.Button.Options.Visible
		v_u9.broadcastRouter("RunInterfaceSound", "UI Click")
	end)
	for v1, v2 in pairs(v_u11) do
		v_u56(v_u37.Tabs.Inventory.Sort.Button.Options, v_u37.Tabs.Inventory.Sort.Button.Options:FindFirstChild(v1), v2, v1, v_u37.Tabs.Inventory.Sort.Button.Frame.TextLabel, v_u37.Tabs.Inventory.Container)
	end
	for _, v3 in ipairs(v_u37.Top.Categories:GetChildren()) do
		if v3:IsA("TextButton") and v3:GetAttribute("IsCategoryButton") then
			v_u1.SetupCategoryButton(v3)
		end
	end
	v_u37:GetPropertyChangedSignal("Visible"):Connect(function()
		-- upvalues: (ref) v_u37, (ref) v_u33, (ref) v_u32, (ref) v_u23, (ref) v_u48, (ref) v_u50, (ref) v_u55, (ref) v_u54, (ref) v_u39, (ref) v_u28, (ref) v_u1
		if v_u37.Visible then
			if v_u33 then
				v_u33 = false
				if v_u37 then
					if v_u37.Visible then
						v_u23 = v_u48()
						v_u23 = v_u50(v_u23)
						v_u55()
					else
						v_u33 = true
						v_u32 = true
					end
				end
			end
			if v_u32 then
				v_u54()
			end
			local v1 = #v_u39
			if v1 > 0 and v_u28 < v1 then
				v_u1.NextInventoryItem(v_u28 + 1)
				return
			end
		end
	end)
	v_u37.Tabs.Inventory.Container:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
		-- upvalues: (ref) v_u52
		v_u52()
	end)
	v_u37.Tabs.Inventory.Container:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
		-- upvalues: (ref) v_u52
		task.defer(v_u52)
	end)
end
function v_u1.Start()
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u1, (copy) v_u_run, (ref) v_u38, (copy) v_u24, (ref) v_u37, (copy) v_u39, (ref) v_u28, (copy) v_u3, (copy) v_u8, (copy) v_u_players, (ref) v_u29, (ref) v_u31, (ref) v_u33, (ref) v_u32, (ref) v_u23, (copy) v_u48, (copy) v_u50, (copy) v_u55, (copy) v_u17
	v_u2.WaitForDataLoaded(v_u_localplayer)
	v_u1.SelectCategory("Everything")
	v_u_run.Heartbeat:Connect(function(arg1)
		-- upvalues: (ref) v_u38, (ref) v_u24, (ref) v_u1, (ref) v_u37, (ref) v_u39, (ref) v_u28
		local v_alert = v_u38.Menu.Top.Buttons.Inventory.Alert
		if v_u24 then
			v_u1.UpdateHoverFrame(arg1)
		else
			v_u37.Hover.Visible = false
		end
		local v1 = #v_u39
		v_alert.TextLabel.Text = v1
		v_alert.Visible = v1 > 0
		v_u37.ItemNotification.Holder.Light.Rotation = v_u37.ItemNotification.Holder.Light.Rotation + arg1 * 10
		v_u37.ItemNotification.Holder.Amount.TextLabel.Text = ("%* / %*"):format(v_u28, v1)
		v_u37.ItemNotification.Holder.Right.Visible = v_u28 < v1
		v_u37.ItemNotification.Holder.Left.Visible = v_u28 > 1
	end)
	v_u3.OnItemStockSchemasUpdated:Connect(function(_)
		-- upvalues: (ref) v_u2, (ref) v_u_localplayer, (ref) v_u1
		local v_get = v_u2.Get(v_u_localplayer, "Inventory")
		v_u1.UpdateTemplates(v_get)
	end)
	v_u8.Store.NewInventoryItem.Listen(function(arg1)
		-- upvalues: (ref) v_u_players, (ref) v_u_localplayer, (ref) v_u39
		local v1 = tonumber(arg1.Player)
		if v1 then
			local v_getplayerbyuserid = v_u_players:GetPlayerByUserId(v1)
			if v_getplayerbyuserid then
				for _, v2 in ipairs(arg1.Items) do
					if v_u_localplayer == v_getplayerbyuserid then
						table.insert(v_u39, v2)
					end
				end
			end
		else
			return
		end
	end)
	v_u2.CreateListener(v_u_localplayer, "Inventory", function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u29, (ref) v_u37, (ref) v_u31, (ref) v_u33, (ref) v_u32, (ref) v_u23, (ref) v_u48, (ref) v_u50, (ref) v_u55
		v_u1.UpdateInventory(arg1)
		if not v_u29 then
			v_u37.Tabs.Inventory.Sort.Button.Frame.TextLabel.Text = "Newest"
			v_u31 = "Newest"
			v_u29 = true
		end
		if v_u37 then
			if v_u37.Visible then
				v_u23 = v_u48()
				v_u23 = v_u50(v_u23)
				v_u55()
			else
				v_u33 = true
				v_u32 = true
			end
		else
			return
		end
	end)
	v_u17.OnInspectStateChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u39, (ref) v_u37, (ref) v_u28, (ref) v_u1
		if not arg1 then
			task.defer(function()
				-- upvalues: (ref) v_u39, (ref) v_u37, (ref) v_u28, (ref) v_u1
				local v1 = #v_u39
				if v_u37.Visible and (v1 > 0 and v_u28 < v1) then
					v_u1.NextInventoryItem(v_u28 + 1)
				end
			end)
		end
	end)
end
return v_u1