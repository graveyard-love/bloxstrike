local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Controllers.InventoryController)
return function(p3)
    local v4 = v_u_2.getCurrentEquipped()
    local v5 = v_u_2.getInventorySlot(p3)
    if not v5 then
        ::l2::
        return
    end
    if not v4 then
        if #v5._items > 0 then
            v_u_2.equip(p3, 1)
        end
        goto l2
    end
    if (v4.Slot or 1) ~= p3 then
        v_u_2.equip(p3, 1)
        return
    end
    local v6 = v5._items
    local v7 = v4.Identifier
    for v10, v9 in ipairs(v6) do
        if v9.Identifier == v7 then
            goto l10
        end
    end
    local v10 = 0
    ::l10::
    local v11 = v10 + 1
    local v12 = #v5._items < v11 and 1 or v11
    v_u_2.equip(p3, v12)
end