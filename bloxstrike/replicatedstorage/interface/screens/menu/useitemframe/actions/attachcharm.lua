-- Decompiled with Bunni.lol Decompiler

local v_u1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_players = game:GetService("Players")
require(script.Parent.Types)
local v_u_localplayer = v_players.LocalPlayer
local v_u2 = require(v_replicatedstorage.Controllers.DataController)
local v_u3 = require(v_replicatedstorage.Database.Security.Remotes)
local v_u4 = require(v_replicatedstorage.Database.Security.Router)
local v_u5 = require(v_replicatedstorage.Interface.MenuState)
local v_u6 = nil
local v_u7 = nil
v_u1.ActionType = "AttachCharm"
local function v_u8(arg1, _)
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
local function v_u9(arg1, _)
	-- upvalues: (copy) v_u2, (copy) v_u_localplayer
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
	return true
end
function v_u1.GetFilter(arg1)
	-- upvalues: (copy) v_u9, (copy) v_u8
	if arg1.Type == "Weapon" then
		return v_u9
	else
		return arg1.Type ~= "Charm" and function()
			return false
		end or v_u8
	end
end
function v_u1.GetContext(arg1)
	-- upvalues: (copy) v_u1
	return {
		["ActionType"] = v_u1.ActionType,
		["SourceItem"] = arg1,
		["Title"] = arg1.Type == "Charm" and "Select Weapon" or "Select Charm"
	}
end
function v_u1.OnItemSelected(arg1, arg2)
	-- upvalues: (ref) v_u6, (copy) v_u4
	if arg2.SourceItem then
		local v_sourceitem = arg2.SourceItem
		local v1, v2
		if v_sourceitem.Type == "Weapon" then
			v1 = v_sourceitem._id
			v2 = arg1._id
			arg1 = v_sourceitem
		else
			if v_sourceitem.Type ~= "Charm" then
				return
			end
			v1 = arg1._id
			v2 = v_sourceitem._id
		end
		v_u6 = {
			["WeaponId"] = v1,
			["CharmId"] = v2,
			["WeaponItem"] = arg1
		}
		v_u4.broadcastRouter("WeaponInspect", arg1.Name, arg1.Skin, arg1.Float, arg1.StatTrack, arg1.NameTag, {
			["_id"] = v2,
			["Position"] = "1"
		}, arg1.Stickers, arg1.Type, arg1.Pattern, arg1._id, arg1.Serial, arg1.IsTradeable)
	end
end
function v_u1.OnCancelled(_)
	-- upvalues: (ref) v_u6
	v_u6 = nil
end
function v_u1.ConfirmAttachment()
	-- upvalues: (ref) v_u6, (copy) v_u4, (copy) v_u3
	if not v_u6 then
		return false
	end
	v_u3.Inventory.UpdateWeaponCharm.Send({
		["WeaponId"] = v_u6.WeaponId,
		["CharmId"] = v_u6.CharmId,
		["Position"] = tostring(v_u4.broadcastRouter("GetCurrentCharmPosition") or 1)
	})
	v_u6 = nil
	v_u4.broadcastRouter("WeaponInspectClose")
	return true
end
function v_u1.CancelAttachment()
	-- upvalues: (ref) v_u6, (copy) v_u4
	if not v_u6 then
		return false
	end
	v_u6 = nil
	v_u4.broadcastRouter("WeaponInspectClose")
	return true
end
function v_u1.HasPendingAttachment()
	-- upvalues: (ref) v_u6
	return v_u6 ~= nil
end
function v_u1.Initialize()
	-- upvalues: (ref) v_u7, (copy) v_u5, (ref) v_u6, (copy) v_u4, (copy) v_u1
	v_u7 = v_u5.OnInspectStateChanged:Connect(function(arg1)
		-- upvalues: (ref) v_u6
		if not arg1 and v_u6 then
			v_u6 = nil
		end
	end)
	v_u4.observerRouter("ConfirmCharmAttachment", function()
		-- upvalues: (ref) v_u1
		return v_u1.ConfirmAttachment()
	end)
	v_u4.observerRouter("HasPendingCharmAttachment", function()
		-- upvalues: (ref) v_u1
		return v_u1.HasPendingAttachment()
	end)
	v_u4.observerRouter("CancelCharmAttachment", function()
		-- upvalues: (ref) v_u1
		return v_u1.CancelAttachment()
	end)
end
function v_u1.Destroy()
	-- upvalues: (ref) v_u7, (ref) v_u6
	if v_u7 then
		v_u7:Disconnect()
		v_u7 = nil
	end
	v_u6 = nil
end
return v_u1