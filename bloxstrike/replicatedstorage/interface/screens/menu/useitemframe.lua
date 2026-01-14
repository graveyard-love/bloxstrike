-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_u_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_tween = game:GetService("TweenService")
local v_players = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_localplayer = v_players.LocalPlayer
local v_u_playergui = v_u_localplayer:WaitForChild("PlayerGui")
local v_u2 = require(v_u_replicatedstorage.Controllers.DataController)
local v_u3 = require(v_u_replicatedstorage.Database.Components.Libraries.Skins)
local v_u4 = require(v_u_replicatedstorage.Database.Components.Libraries.Cases)
local v_u5 = require(v_u_replicatedstorage.Database.Components.Libraries.Collections)
local v_u6 = require(v_u_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u7 = require(v_u_replicatedstorage.Database.Security.Router)
local v8 = require(v_u_replicatedstorage.Packages.Signal)
local v_u9 = require(v_u_replicatedstorage.Interface.MenuState)
local v_u10 = require(v_u_replicatedstorage.Database.Custom.GameStats.UI.Inventory.Sort)
local v_u11 = require(v_u_replicatedstorage.Database.Custom.GameStats.Rarities)
local v_u12 = require(v_u_replicatedstorage.Database.Custom.GameStats.Grenades)
local v_u13 = require(script.Actions)
local v_u14 = {
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
local v_u15 = {
	["Melee"] = 1,
	["Glove"] = 2,
	["Case"] = 3
}
local v_u16 = {
	["Miscellaneous"] = 18,
	["Equipment"] = 17,
	["Pistol"] = 3,
	["Rifle"] = 6,
	["Heavy"] = 5,
	["SMG"] = 4
}
local v_u17 = {
	["Pistols"] = 1,
	["Mid Tier"] = 2,
	["Rifles"] = 3
}
local v_u18 = {
	["Equipped Melee"] = 1,
	["Equipped Gloves"] = 2,
	["Equipped Badge"] = 3,
	["Equipped Music Kit"] = 4,
	["Equipped Graffiti"] = 5,
	["Equipped Zeus x27"] = 6
}
local v_u19 = nil
local v_u20 = nil
local v_u21 = nil
local v_u22 = false
local v_u23 = nil
local v_u24 = nil
local v_u25 = nil
local v_u26 = {}
local v_u27 = 0
local v_u28 = nil
local v_u29 = nil
local v_u30 = nil
local v_u31 = nil
local v_u32 = nil
local v_u33 = nil
v_u1.OnItemSelected = v8.new()
v_u1.OnClosed = v8.new()
local function v_u34(arg1, arg2)
	-- upvalues: (copy) v_u5, (ref) v_u24
	local v_getchildren = arg1:GetChildren()
	for _, v1 in ipairs(v_getchildren) do
		if v1.ClassName == arg2 then
			v1:Destroy()
		end
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u24
		v_u24 = arg1
	end)
end
local function v_u35(arg1)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u17, (copy) v_u18, (copy) v_u5, (ref) v_u24
	local v1 = nil
	local v_get = v_u2.Get(v_u_localplayer, "Loadout")
	if not v_get then
		return nil
	end
	for _, v2 in ipairs({ "Counter-Terrorists", "Terrorists" }) do
		local v3 = v_get[v2]
		if v3 and v3.Loadout then
			for v4, v5 in pairs(v_u17) do
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
						local v11 = v_u18[v9] or 99
						if not v1 or v11 < v1 then
							v1 = v11
						end
					end
				end
			end
		end
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u24
		v_u24 = arg1
	end)
	return v1
end
local function v_u36(arg1)
	-- upvalues: (copy) v_u4, (ref) v_u24, (copy) v_u3
	if arg1.Type ~= "Case" then
		local v_getskininformation = v_u3.GetSkinInformation(arg1.Name, arg1.Skin)
		return v_getskininformation and v_getskininformation.collection or nil
	end
	local v_getcasebyname = v_u4.GetCaseByName(arg1.Skin)
	if not (v_getcasebyname and v_u24) then
		return nil
	end
	for _, v1 in ipairs(v_u24) do
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
local function v_u37(arg1)
	-- upvalues: (copy) v_u36, (copy) v_u15, (copy) v_u3, (copy) v_u35, (copy) v_u14, (copy) v_u6, (copy) v_u16, (copy) v_u5, (ref) v_u24
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
			-- upvalues: (ref) v_u36, (ref) v_u15, (ref) v_u3
			local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
			if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
				local v2 = v_u36(arg1) or ""
				local v3 = v_u36(arg2) or ""
				if v2 == v3 then
					local v4 = v_u15[arg1.Type] or 4
					local v5 = v_u15[arg2.Type] or 4
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
			-- upvalues: (ref) v_u35
			local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
			if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
				local v2 = v_u35(arg1._id)
				local v3 = v_u35(arg2._id)
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
	if arg1 == "Quality" then
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
	if arg1 == "Type" then
		return function(arg1, arg2)
			-- upvalues: (ref) v_u14, (ref) v_u6, (ref) v_u16
			local v1 = (arg2.Skin == "Stock" or arg2.MetaData and arg2.MetaData.Origin == "Stock") and true or false
			if ((arg1.Skin == "Stock" or arg1.MetaData and arg1.MetaData.Origin == "Stock") and true or false) == v1 then
				local v2 = v_u14[arg1.Type]
				local v3
				if v2 or arg1.Type ~= "Weapon" then
					v3 = v2 or 99
				else
					local v4, v5 = pcall(v_u6, arg1.Name)
					v3 = v4 and (v5 and v5.Type) and (v_u16[v5.Type] or 99) or 99
				end
				local v6 = v_u14[arg2.Type]
				local v7
				if v6 or arg2.Type ~= "Weapon" then
					v7 = v6 or 99
				else
					local v8, v9 = pcall(v_u6, arg2.Name)
					v7 = v8 and (v9 and v9.Type) and (v_u16[v9.Type] or 99) or 99
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
		end
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u24
		v_u24 = arg1
	end)
	return nil
end
local function v_u38(arg1, arg2, _, arg4, arg5, _)
	-- upvalues: (copy) v_u_tween, (copy) v_u7, (ref) v_u25, (copy) v_u1
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
		-- upvalues: (ref) v_u7, (ref) v_u25, (copy) arg4, (ref) v_u1, (copy) arg5, (copy) arg1, (copy) arg2
		v_u7.broadcastRouter("RunInterfaceSound", "UI Click")
		v_u25 = arg4
		v_u1.PopulateItems()
		arg5.Text = arg4
		for _, v1 in ipairs(arg1:GetChildren()) do
			if v1:IsA("TextButton") then
				v1.Frame.BackgroundTransparency = v1 == arg2 and 0 or 1
			end
		end
		arg1.Visible = false
	end)
end
local function v_u39(self)
	-- upvalues: (copy) v_u_tween
	local v_u_size = self.Size
	local v_button = self.Button
	self.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self, (copy) v_u_size
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.new(v2.X.Scale * 0.95, v2.X.Offset, v2.Y.Scale * 0.95, v2.Y.Offset)
		v_u_tween:Create(self, v_new, v1):Play()
	end)
	self.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self, (copy) v_u_size
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.new(v2.X.Scale * 1, v2.X.Offset, v2.Y.Scale * 1, v2.Y.Offset)
		v_u_tween:Create(self, v_new, v1):Play()
	end)
	v_button.MouseButton1Down:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self, (copy) v_u_size
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.new(v2.X.Scale * 0.9, v2.X.Offset, v2.Y.Scale * 0.9, v2.Y.Offset)
		v_u_tween:Create(self, v_new, v1):Play()
	end)
	v_button.MouseButton1Up:Connect(function()
		-- upvalues: (ref) v_u_tween, (copy) self, (copy) v_u_size
		local v_new = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local v1 = {}
		local v2 = v_u_size
		v1.Size = UDim2.new(v2.X.Scale * 0.95, v2.X.Offset, v2.Y.Scale * 0.95, v2.Y.Offset)
		v_u_tween:Create(self, v_new, v1):Play()
	end)
end
local function v_u40()
	-- upvalues: (ref) v_u29
	if not (v_u29 and v_u29.Visible) then
		return 50
	end
	local v_uigridlayout = v_u29:FindFirstChildOfClass("UIGridLayout")
	if not v_uigridlayout then
		return 50
	end
	local v_absolutesize = v_u29.AbsoluteSize
	local v_y = v_absolutesize.Y
	local v_x = v_absolutesize.X
	local v_cellsize = v_uigridlayout.CellSize
	local v_cellpadding = v_uigridlayout.CellPadding
	local v1 = v_cellsize.Y.Scale * v_y + v_cellsize.Y.Offset
	local v2 = v_cellpadding.Y.Scale * v_y + v_cellpadding.Y.Offset
	local v3 = v_cellsize.X.Scale * v_x + v_cellsize.X.Offset
	local v4 = v_cellpadding.X.Scale * v_x + v_cellpadding.X.Offset
	local v_uipadding = v_u29:FindFirstChildOfClass("UIPadding")
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
		local v_floor = math.floor((v10 + v4) / UNNAMED_1729005790632)
		v11 = math.max(1, v_floor)
	else
		v11 = 1
	end
	local v12
	if v1 + v2 > 0 then
		local v_floor = math.floor((v9 + v2) / UNNAMED_1729005793032)
		v12 = math.max(1, v_floor)
	else
		v12 = 1
	end
	return v12 * v11 + v11
end
local function v_u41()
	-- upvalues: (ref) v_u29, (ref) v_u19, (copy) v_u1, (copy) v_u5, (ref) v_u24, (ref) v_u27, (ref) v_u26
	if v_u29 then
		local function v1(arg1)
			-- upvalues: (ref) v_u19, (ref) v_u1
			if v_u19 then
				v_u1.OnItemSelected:Fire(arg1, v_u19)
				v_u1.Hide()
			end
		end
		v_u5.ObserveAvailableCollections(function(arg1)
			-- upvalues: (ref) v_u24
			v_u24 = arg1
		end)
		local v_min = math.min(v_u27 + 25, #v_u26)
		for v2 = v_u27 + 1, v_min do
			local v3 = v_u26[v2]
			if v3 and not v_u29:FindFirstChild(v3._id) then
				v_u1.CreateItemTemplate(v3, v1)
			end
		end
		v_u5.ObserveAvailableCollections(function(arg1)
			-- upvalues: (ref) v_u24
			v_u24 = arg1
		end)
		v_u27 = v_min
	end
end
local function v_u42()
	-- upvalues: (ref) v_u29, (ref) v_u27, (ref) v_u26, (copy) v_u41, (copy) v_u5, (ref) v_u24
	if v_u29 then
		local v1 = v_u29.AbsoluteCanvasSize.Y - v_u29.AbsoluteSize.Y
		if v1 > 0 and (v_u27 < #v_u26 and v1 - v_u29.CanvasPosition.Y < 200) then
			v_u41()
		end
		v_u5.ObserveAvailableCollections(function(arg1)
			-- upvalues: (ref) v_u24
			v_u24 = arg1
		end)
	end
end
local function v_u43()
	-- upvalues: (ref) v_u22, (ref) v_u32, (copy) v_u_playergui, (ref) v_u28, (ref) v_u29, (ref) v_u33, (copy) v_u5, (ref) v_u24, (ref) v_u25, (copy) v_u7, (copy) v_u10, (copy) v_u38, (ref) v_u30, (ref) v_u31, (copy) v_u1, (ref) v_u19, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u9, (copy) v_u42
	if v_u22 then
		return true
	end
	print("Initializing")
	v_u32 = v_u_playergui:FindFirstChild("MainGui")
	if not v_u32 then
		warn("[UseItemFrame] MainGui not found")
		return false
	end
	local v_menu = v_u32:FindFirstChild("Menu")
	if not v_menu then
		warn("[UseItemFrame] Menu frame not found")
		return false
	end
	v_u28 = v_menu:FindFirstChild("UseItemFrame")
	if not v_u28 then
		warn("[UseItemFrame] UseItemFrame not found in Menu")
		return false
	end
	local v_tabs = v_u28:FindFirstChild("Tabs")
	local v1 = v_tabs and v_tabs:FindFirstChild("Inventory")
	if v1 then
		v_u29 = v1:FindFirstChild("Container")
		v_u33 = v1:FindFirstChild("Sort")
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u24
		v_u24 = arg1
	end)
	local v_u2 = v_u33 and v_u33:FindFirstChild("Button")
	if v_u2 then
		local v_textlabel = v_u2:FindFirstChild("Frame"):FindFirstChild("TextLabel")
		if v_textlabel then
			v_textlabel.Text = "Newest"
			v_u25 = "Newest"
		end
		v_u2.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u2, (ref) v_u7
			local v_options = v_u2:FindFirstChild("Options")
			if v_options then
				v_options.Visible = not v_options.Visible
				v_u7.broadcastRouter("RunInterfaceSound", "UI Click")
			end
		end)
		local v_options = v_u2:FindFirstChild("Options")
		local v_textlabel = v_u2:FindFirstChild("Frame"):FindFirstChild("TextLabel")
		if v_options and v_textlabel then
			for v3, v4 in pairs(v_u10) do
				local v5 = v_options:FindFirstChild(v3)
				if v5 then
					v_u38(v_options, v5, v4, v3, v_textlabel, v_u29)
				end
			end
		end
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u24
		v_u24 = arg1
	end)
	local v_top = v_u28:FindFirstChild("Top")
	if v_top then
		v_u30 = v_top:FindFirstChild("TextLabel")
		v_u31 = v_top:FindFirstChild("Close")
		if v_u31 then
			v_u31.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u7, (ref) v_u1, (ref) v_u19
				v_u7.broadcastRouter("RunInterfaceSound", "UI Click")
				v_u1.OnClosed:Fire(v_u19)
				v_u1.Hide()
			end)
		end
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u24
		v_u24 = arg1
	end)
	v_u2.CreateListener(v_u_localplayer, "Inventory", function(_)
		-- upvalues: (ref) v_u1
		if v_u1.IsVisible() then
			v_u1.PopulateItems()
		end
	end)
	v_u9.OnScreenChanged:Connect(function(_, _)
		-- upvalues: (ref) v_u1, (ref) v_u19
		if v_u1.IsVisible() then
			v_u1.OnClosed:Fire(v_u19)
			v_u1.Hide()
		end
	end)
	v_u9.OnInspectStateChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u19
		if arg1 and v_u1.IsVisible() then
			v_u1.OnClosed:Fire(v_u19)
			v_u1.Hide()
		end
	end)
	v_u9.OnCaseSceneStateChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u19
		if arg1 and v_u1.IsVisible() then
			v_u1.OnClosed:Fire(v_u19)
			v_u1.Hide()
		end
	end)
	if v_u29 then
		v_u29:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
			-- upvalues: (ref) v_u42
			v_u42()
		end)
	end
	v_u22 = true
	return true
end
function v_u1.CreateItemTemplate(arg1, arg2)
	-- upvalues: (ref) v_u29, (copy) v_u4, (copy) v_u3, (copy) v_u11, (copy) v_u_replicatedstorage, (copy) v_u7, (ref) v_u21, (ref) v_u23, (copy) v_u39
	if not (arg1 and arg1._id) then
		return
	end
	if not v_u29 then
		return
	end
	local v1 = arg1.Type == "Case"
	local v2 = v1 and v_u4.GetCaseByName(arg1.Skin) or v_u3.GetSkinInformation(arg1.Name, arg1.Skin)
	if not v2 then
		return
	end
	local v3 = v_u11[v1 and v2.caseRarity or v2.rarity]
	local v4 = nil
	if v1 then
		v4 = v2.imageAssetId or ""
	elseif arg1.Type == "Charm" then
		local v_pattern = arg1.Pattern
		if v_pattern and v2.charmImages then
			for _, v5 in ipairs(v2.charmImages) do
				if v5.pattern == v_pattern then
					v4 = v5.assetId
					break
				end
			end
		end
		if not v4 then
			v4 = v2.imageAssetId or ""
		end
	else
		v4 = v_u3.GetWearImageForFloat(v2, arg1.Float or 0.9999) or (v2.imageAssetId or "")
	end
	local v_u_clone = v_u_replicatedstorage.Assets.UI.Inventory.ItemTemplate:Clone()
	v_u_clone.Main.RarityFrame.UIGradient.Color = v3.ColorSequence
	v_u_clone.Main.Glow.UIGradient.Color = v3.ColorSequence
	v_u_clone.Parent = v_u29
	v_u_clone.Main.Icon.Image = v4
	v_u_clone.Name = arg1._id
	v_u_clone.Information.Weapon.Text = arg1.StatTrack and "KillTrak\226\132\162 " .. arg1.Name or arg1.Name
	v_u_clone.Information.Skin.Text = v1 and v2.skin or arg1.Skin
	if arg1.Type == "Charm" then
		v_u_clone.Button.MouseButton2Click:Connect(function()
			-- upvalues: (ref) v_u7, (copy) arg1
			v_u7.broadcastRouter("RunInterfaceSound", "UI Click")
			v_u7.broadcastRouter("WeaponInspect", arg1.Name, arg1.Skin, arg1.Float, arg1.StatTrack, arg1.NameTag, arg1.Charm, arg1.Stickers, arg1.Type, arg1.Pattern, arg1._id, arg1.Serial, arg1.IsTradeable)
		end)
	end
	v_u_clone.Button.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u7, (copy) arg2, (copy) arg1
		v_u7.broadcastRouter("RunInterfaceSound", "UI Click")
		arg2(arg1)
	end)
	v_u_clone.MouseEnter:Connect(function()
		-- upvalues: (ref) v_u21, (copy) v_u_clone, (ref) v_u23
		v_u21 = v_u_clone
		v_u23 = tick()
	end)
	v_u_clone.MouseLeave:Connect(function()
		-- upvalues: (ref) v_u21, (ref) v_u23
		v_u21 = nil
		v_u23 = nil
	end)
	v_u39(v_u_clone)
end
function v_u1.PopulateItems()
	-- upvalues: (ref) v_u29, (copy) v_u34, (ref) v_u27, (ref) v_u26, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u12, (ref) v_u20, (ref) v_u19, (copy) v_u5, (ref) v_u24, (ref) v_u25, (ref) v_u33, (copy) v_u37, (copy) v_u1, (copy) v_u40
	if v_u29 then
		v_u34(v_u29, "Frame")
		v_u27 = 0
		v_u26 = {}
		local v_get = v_u2.Get(v_u_localplayer, "Inventory")
		if v_get and type(v_get) == "table" then
			for _, v1 in ipairs(v_get) do
				local v2
				if v1 then
					v2 = v_u12[v1.Name]
				else
					v2 = v1
				end
				local v3
				if v1 then
					v3 = v1.Type == "Case"
				else
					v3 = v1
				end
				local v4 = v1 and (v1._id and v1.Name)
				if v4 then
					v4 = v3 or v1.Skin
				end
				if v4 and not (v2 or v3) and (not (v_u20 and v_u19) or v_u20(v1, v_u19)) then
					table.insert(v_u26, v1)
				end
			end
			v_u5.ObserveAvailableCollections(function(arg1)
				-- upvalues: (ref) v_u24
				v_u24 = arg1
			end)
			local v5 = v_u37(v_u25 or v_u33 and v_u33.Button.Frame.TextLabel.Text or "Newest")
			if v5 then
				table.sort(v_u26, v5)
			end
			local function v6(arg1)
				-- upvalues: (ref) v_u19, (ref) v_u1
				if v_u19 then
					v_u1.OnItemSelected:Fire(arg1, v_u19)
					v_u1.Hide()
				end
			end
			v_u5.ObserveAvailableCollections(function(arg1)
				-- upvalues: (ref) v_u24
				v_u24 = arg1
			end)
			local v7 = v_u40()
			local v_max = math.max(v7, 50)
			local v_min = math.min(v_max, #v_u26)
			for v8 = 1, v_min do
				local v9 = v_u26[v8]
				if v9 then
					v_u1.CreateItemTemplate(v9, v6)
				end
			end
			v_u5.ObserveAvailableCollections(function(arg1)
				-- upvalues: (ref) v_u24
				v_u24 = arg1
			end)
			v_u27 = v_min
		end
	else
		return
	end
end
function v_u1.Show(arg1, arg2)
	-- upvalues: (copy) v_u43, (ref) v_u28, (ref) v_u19, (ref) v_u20, (ref) v_u30, (copy) v_u5, (ref) v_u24, (copy) v_u1
	if v_u43() then
		if v_u28 then
			v_u19 = arg1
			v_u20 = arg2
			if v_u30 then
				if arg1.SourceItem then
					local v_sourceitem = arg1.SourceItem
					local v_name = v_sourceitem.Name
					if v_sourceitem.StatTrack then
						v_name = "KillTrak\226\132\162 " .. v_name
					end
					if v_sourceitem.Skin then
						v_name = v_name .. " | " .. v_sourceitem.Skin
					end
					v_u30.Text = ("Select an item to use with %*"):format(v_name)
				elseif arg1.Title then
					v_u30.Text = arg1.Title
				else
					v_u30.Text = "Select an item"
				end
			end
			v_u5.ObserveAvailableCollections(function(arg1)
				-- upvalues: (ref) v_u24
				v_u24 = arg1
			end)
			v_u1.PopulateItems()
			v_u28.Visible = true
		end
	else
		warn("[UseItemFrame] Failed to initialize")
		return
	end
end
function v_u1.Hide()
	-- upvalues: (ref) v_u28, (ref) v_u19, (ref) v_u20
	if v_u28 then
		v_u28.Visible = false
	end
	v_u19 = nil
	v_u20 = nil
end
function v_u1.IsVisible()
	-- upvalues: (ref) v_u28
	return v_u28 and v_u28.Visible or false
end
function v_u1.GetCurrentContext()
	-- upvalues: (ref) v_u19
	return v_u19
end
v_u1.Filters = {}
function v_u1.Filters.WeaponsWithoutCharm(arg1, _)
	if arg1.Type ~= "Weapon" then
		return false
	end
	local v1
	if arg1.Charm == nil or arg1.Charm == false then
		v1 = false
	else
		v1 = (type(arg1.Charm) == "string" or arg1.Charm == true) and true or type(arg1.Charm) == "table"
	end
	return not v1
end
local function v44(arg1, _)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer, (copy) v_u5, (ref) v_u24
	if arg1.Type ~= "Charm" then
		return false
	end
	local v_get = v_u2.Get(v_u_localplayer, "Inventory")
	if v_get then
		for _, v1 in ipairs(v_get) do
			if v1.Charm then
				local v2 = type(v1.Charm) == "table" and v1.Charm._id
				if not v2 then
					if type(v1.Charm) == "string" then
						v2 = v1.Charm
					else
						v2 = false
					end
				end
				if v2 == arg1._id then
					return false
				end
			end
		end
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u24
		v_u24 = arg1
	end)
	return true
end
v_u1.Filters.AllCharms = v44
function v_u1.Filters.AllWeapons(arg1, _)
	return arg1.Type == "Weapon"
end
function v_u1.Filters.AllMelees(arg1, _)
	return arg1.Type == "Melee"
end
function v_u1.Filters.AllGloves(arg1, _)
	return arg1.Type == "Glove"
end
function v_u1.Initialize(arg1, arg2)
	-- upvalues: (ref) v_u32, (ref) v_u28, (ref) v_u29, (ref) v_u33, (copy) v_u5, (ref) v_u24, (ref) v_u25, (copy) v_u7, (copy) v_u10, (copy) v_u38, (ref) v_u30, (ref) v_u31, (copy) v_u1, (ref) v_u19, (copy) v_u42, (ref) v_u22
	v_u32 = arg1
	v_u28 = arg2
	local v_tabs = arg2:FindFirstChild("Tabs")
	local v1 = v_tabs and v_tabs:FindFirstChild("Inventory")
	if v1 then
		v_u29 = v1:FindFirstChild("Container")
		v_u33 = v1:FindFirstChild("Sort")
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u24
		v_u24 = arg1
	end)
	if v_u33 then
		local v_u_button = v_u33:FindFirstChild("Button")
		if v_u_button then
			local v_textlabel = v_u_button:FindFirstChild("Frame"):FindFirstChild("TextLabel")
			if v_textlabel then
				v_textlabel.Text = "Newest"
				v_u25 = "Newest"
			end
			v_u_button.MouseButton1Click:Connect(function()
				-- upvalues: (copy) v_u_button, (ref) v_u7
				local v_options = v_u_button:FindFirstChild("Options")
				if v_options then
					v_options.Visible = not v_options.Visible
					v_u7.broadcastRouter("RunInterfaceSound", "UI Click")
				end
			end)
			local v_options = v_u_button:FindFirstChild("Options")
			local v_textlabel = v_u_button:FindFirstChild("Frame"):FindFirstChild("TextLabel")
			if v_options and v_textlabel then
				for v2, v3 in pairs(v_u10) do
					local v4 = v_options:FindFirstChild(v2)
					if v4 then
						v_u38(v_options, v4, v3, v2, v_textlabel, v_u29)
					end
				end
			end
		end
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u24
		v_u24 = arg1
	end)
	local v_top = arg2:FindFirstChild("Top")
	if v_top then
		v_u30 = v_top:FindFirstChild("TextLabel")
		v_u31 = v_top:FindFirstChild("Close")
		if v_u31 then
			v_u31.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u7, (ref) v_u1, (ref) v_u19
				v_u7.broadcastRouter("RunInterfaceSound", "UI Click")
				v_u1.OnClosed:Fire(v_u19)
				v_u1.Hide()
			end)
		end
	end
	v_u5.ObserveAvailableCollections(function(arg1)
		-- upvalues: (ref) v_u24
		v_u24 = arg1
	end)
	if v_u29 then
		v_u29:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
			-- upvalues: (ref) v_u42
			v_u42()
		end)
	end
	arg2.Visible = false
	v_u22 = true
end
function v_u1.Start()
	-- upvalues: (copy) v_u13, (copy) v_u2, (copy) v_u_localplayer, (copy) v_u1, (copy) v_u9, (ref) v_u19
	v_u13.InitializeAll()
	v_u2.CreateListener(v_u_localplayer, "Inventory", function(_)
		-- upvalues: (ref) v_u1
		if v_u1.IsVisible() then
			v_u1.PopulateItems()
		end
	end)
	v_u9.OnScreenChanged:Connect(function(_, _)
		-- upvalues: (ref) v_u1, (ref) v_u19
		if v_u1.IsVisible() then
			v_u1.OnClosed:Fire(v_u19)
			v_u1.Hide()
		end
	end)
	v_u9.OnInspectStateChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u19
		if arg1 and v_u1.IsVisible() then
			v_u1.OnClosed:Fire(v_u19)
			v_u1.Hide()
		end
	end)
	v_u9.OnCaseSceneStateChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u1, (ref) v_u19
		if arg1 and v_u1.IsVisible() then
			v_u1.OnClosed:Fire(v_u19)
			v_u1.Hide()
		end
	end)
end
function v_u1.TriggerAction(arg1, arg2)
	-- upvalues: (copy) v_u13, (copy) v_u1
	local v_get = v_u13.Get(arg1)
	if v_get then
		local v_getcontext = v_get.GetContext(arg2)
		local v_getfilter = v_get.GetFilter(arg2)
		v_u1.Show(v_getcontext, v_getfilter)
	else
		warn((("[UseItemFrame] Unknown action type: %*"):format(arg1)))
	end
end
function v_u1.GetActions()
	-- upvalues: (copy) v_u13
	return v_u13
end
return v_u1