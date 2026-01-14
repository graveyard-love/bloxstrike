-- Decompiled with Bunni.lol Decompiler

local v1 = {}
local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_replicatedstorage.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u2 = require(v_replicatedstorage.Database.Components.Libraries.Skins)
local v_u3 = require(v_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u4 = require(v_replicatedstorage.Shared.Janitor)
local v_u5 = require(script.Classes.CharacterAnimator)
local v_u6 = require(script.Classes.Viewmodel)
function v1.new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
	-- upvalues: (copy) v_u4, (copy) v_u3, (copy) v_u5, (copy) v_u6, (copy) v_u2
	local v_u1 = {
		["Janitor"] = v_u4.new(),
		["IsDestroyed"] = false,
		["OriginalOwner"] = arg10,
		["Identifier"] = arg2,
		["StatTrack"] = arg8,
		["Stickers"] = arg12,
		["NameTag"] = arg9,
		["Player"] = arg1,
		["Float"] = arg7,
		["Name"] = arg5,
		["Charm"] = arg11,
		["Skin"] = arg6,
		["Slot"] = arg4,
		["_id"] = arg3,
		["Properties"] = v_u3(arg5)
	}
	v_u1.CharacterAnimator = v_u5.new(v_u1.Player, arg5)
	debug.profilebegin("WeaponComponent.new.Viewmodel")
	v_u1.Viewmodel = v_u6.new(v_u1, arg5, arg6)
	debug.profileend()
	v_u1.Janitor:Add(function()
		-- upvalues: (copy) v_u1
		if v_u1.CharacterAnimator then
			v_u1.CharacterAnimator:destroy()
			v_u1.CharacterAnimator = nil
		end
	end)
	v_u1.Janitor:Add(function()
		-- upvalues: (copy) v_u1
		if v_u1.Viewmodel then
			v_u1.Viewmodel:destroy()
			v_u1.Viewmodel = nil
		end
	end)
	function v_u1.updateStatTrackCounter(arg1, arg2)
		-- upvalues: (ref) v_u2
		arg1.StatTrack = arg2
		local v1 = arg1.StatTrack and arg1.Viewmodel.Model:FindFirstChild("KillTrak", true)
		if v1 then
			v1.Screen.SurfaceGui.TextLabel.Text = v_u2.GetKillTrackValue(arg2, arg1.Name)
		end
	end
	return v_u1
end
function v1.destroy(arg1)
	if arg1.CharacterAnimator then
		arg1.CharacterAnimator:destroy()
		arg1.CharacterAnimator = nil
	end
	if arg1.Viewmodel then
		arg1.Viewmodel:destroy()
		arg1.Viewmodel = nil
	end
	if arg1.Janitor then
		arg1.Janitor:Destroy()
		arg1.Janitor = nil
	end
	arg1.updateStatTrackCounter = nil
	arg1.OriginalOwner = nil
	arg1.Properties = nil
	arg1.Identifier = nil
	arg1.StatTrack = nil
	arg1.Stickers = nil
	arg1.NameTag = nil
	arg1.Player = nil
	arg1.Float = nil
	arg1.Name = nil
	arg1.Charm = nil
	arg1.Skin = nil
	arg1.Slot = nil
	arg1._id = nil
end
return v1