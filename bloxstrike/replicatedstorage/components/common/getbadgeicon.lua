-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_replicatedstorage.Database.Custom.Types)
local v_u1 = require(v_replicatedstorage.Controllers.DataController)
local v_u2 = require(v_replicatedstorage.Database.Components.Libraries.Skins)
return function(arg1, arg2)
	-- upvalues: (copy) v_u1, (copy) v_u2
	local v_get, v1 = v_u1.Get(arg1, "Loadout", "Inventory")
	if not (v_get and v1) then
		return ""
	end
	local v2 = v_get[arg2]
	if not (v2 and v2.Equipped) then
		return ""
	end
	local v_equipped badge = v2.Equipped["Equipped Badge"]
	if not v_equipped badge or v_equipped badge == "" then
		return ""
	end
	local v3 = nil
	for _, v4 in ipairs(v1) do
		if v4._id == v_equipped badge then
			v3 = v4
			break
		end
	end
	if not v3 then
		return ""
	end
	local v_getskininformation = v_u2.GetSkinInformation(v3.Name, v3.Skin)
	return v_getskininformation and (v_u2.GetWearImageForFloat(v_getskininformation, v3.Float or 0.9999) or v_getskininformation.imageAssetId or "") or ""
end