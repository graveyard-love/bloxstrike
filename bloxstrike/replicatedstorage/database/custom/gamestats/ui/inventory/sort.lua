-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u_localplayer = game:GetService("Players").LocalPlayer
local v_u1 = require(v_replicatedstorage.Controllers.DataController)
local v_u2 = require(v_replicatedstorage.Components.Common.GetWeaponProperties)
local v_u3 = require(v_replicatedstorage.Database.Components.Libraries.Skins)
local v_u4 = {
	["Forbidden"] = 7,
	["Special"] = 6,
	["Red"] = 5,
	["Pink"] = 4,
	["Purple"] = 3,
	["Blue"] = 2,
	["Stock"] = 1
}
local function v_u5(arg1, arg2)
	-- upvalues: (copy) v_u1, (copy) v_u_localplayer
	local v_get = v_u1.Get(v_u_localplayer, "Inventory")
	if v_get then
		local v_clone = table.clone(v_get)
		table.sort(v_clone, arg2)
		for v1, v2 in ipairs(v_clone) do
			local v3 = arg1:FindFirstChild(v2._id)
			if v3 and v3:IsA("GuiObject") then
				v3.LayoutOrder = v1
			end
		end
	end
end
return table.freeze({
	["Alphabetical"] = function(arg1)
		-- upvalues: (copy) v_u5
		v_u5(arg1, function(arg1, arg2)
			return (arg1.Name or "") < (arg2.Name or "")
		end)
	end,
	["Collection"] = function(arg1)
		-- upvalues: (copy) v_u5
		v_u5(arg1, function(arg1, arg2)
			return (arg1.Skin or "") < (arg2.Skin or "")
		end)
	end,
	["Equipped"] = function(arg1)
		-- upvalues: (copy) v_u5
		v_u5(arg1, function(arg1, arg2)
			return (arg1.Name or "") < (arg2.Name or "")
		end)
	end,
	["Newest"] = function(arg1)
		-- upvalues: (copy) v_u5
		v_u5(arg1, function(arg1, arg2)
			return (arg1.MetaData and arg1.MetaData.CreatedAt or 0) > (arg2.MetaData and arg2.MetaData.CreatedAt or 0)
		end)
	end,
	["Quality"] = function(arg1)
		-- upvalues: (copy) v_u5, (copy) v_u3, (copy) v_u4
		v_u5(arg1, function(arg1, arg2)
			-- upvalues: (ref) v_u3, (ref) v_u4
			local v_getskininformation = v_u3.GetSkinInformation(arg1.Name, arg1.Skin)
			local v_getskininformation = v_u3.GetSkinInformation(arg2.Name, arg2.Skin)
			return (v_getskininformation and v_u4[v_getskininformation.rarity] or 0) > (v_getskininformation and v_u4[v_getskininformation.rarity] or 0)
		end)
	end,
	["Type"] = function(arg1)
		-- upvalues: (copy) v_u5, (copy) v_u2
		v_u5(arg1, function(arg1, arg2)
			-- upvalues: (ref) v_u2
			local v1 = v_u2(arg1.Name)
			local v2 = v_u2(arg2.Name)
			local v3 = v1 and v1.Type or "ZZZ"
			local v4 = v2 and v2.Type or "ZZZ"
			if v3 == v4 then
				return (arg1.Name or "") < (arg2.Name or "")
			else
				return v3 < v4
			end
		end)
	end
})