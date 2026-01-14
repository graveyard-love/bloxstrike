-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v_u1 = require(v_replicatedstorage.Controllers.InventoryController)
return function(arg1)
	-- upvalues: (copy) v_u1
	local v_getcurrentequipped = v_u1.getCurrentEquipped()
	if v_getcurrentequipped then
		local v1 = v_getcurrentequipped.Slot or 1
		local v_getinventoryslot = v_u1.getInventorySlot(arg1)
		if v_getinventoryslot then
			if v1 ~= arg1 then
				v_u1.equip(arg1, 1)
				goto l2
			end
			local v_identifier = v_getcurrentequipped.Identifier
			for v4, v3 in ipairs(v_getinventoryslot._items) do
				if v3.Identifier == v_identifier then
					goto l9
				end
			end
			local v4 = 0
			::l9::
			local v5 = v4 + 1
			v_u1.equip(arg1, #v_getinventoryslot._items < v5 and 1 or v5)
			return
		end
	end
	::l2::
end