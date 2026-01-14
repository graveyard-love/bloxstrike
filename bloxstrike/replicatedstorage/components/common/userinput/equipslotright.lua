-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u1 = require(v_replicatedstorage.Controllers.InventoryController)
return function()
	-- upvalues: (copy) v_u1
	local v_getcurrentequipped = v_u1.getCurrentEquipped()
	if v_getcurrentequipped then
		local v1 = v_getcurrentequipped.Slot or 1
		local v_getinventoryslot = v_u1.getInventorySlot(v1)
		local v_identifier = v_getcurrentequipped.Identifier
		for v4, v3 in ipairs(v_getinventoryslot._items) do
			if v3.Identifier == v_identifier then
				goto l6
			end
		end
		local v4 = 0
		::l6::
		if #v_getinventoryslot._items <= v4 then
			local v_getcurrentinventory = v_u1.getCurrentInventory()
			local v5 = v1
			for v6 = 1, #v_getcurrentinventory do
				if #v_getcurrentinventory[v6]._items > 0 and v1 < v6 then
					v1 = v6
					break
				end
			end
			if v1 == v5 then
				for v7 = 1, #v_getcurrentinventory do
					if #v_getcurrentinventory[v7]._items > 0 and v7 < v1 then
						v1 = v7
						break
					end
				end
			end
			v_u1.equip(v1, 1)
			return
		end
		v_u1.equip(v1, v4 + 1)
	end
end