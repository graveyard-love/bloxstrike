local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Controllers.InventoryController)
return function()
    local v3 = v_u_2.getCurrentEquipped()
    if v3 then
        local v4 = v3.Slot or 1
        local v5 = v_u_2.getInventorySlot(v4)._items
        local v6 = v3.Identifier
        for v9, v8 in ipairs(v5) do
            if v8.Identifier == v6 then
                goto l6
            end
        end
        local v9 = 0
        ::l6::
        if v9 <= 1 then
            local v10 = v_u_2.getCurrentInventory()
            local v11 = v4
            for v12 = #v10, 1, -1 do
                if #v10[v12]._items > 0 and v12 < v4 then
                    v4 = v12
                    break
                end
            end
            if v4 == v11 then
                for v13 = #v10, 1, -1 do
                    if #v10[v13]._items > 0 and v4 < v13 then
                        v4 = v13
                    end
                end
            end
            local v14 = v_u_2.getInventorySlot(v4)
            v_u_2.equip(v4, #v14._items)
            return
        end
        local v15 = v9 - 1
        v_u_2.equip(v4, v15)
    end
end