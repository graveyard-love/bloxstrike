local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Controllers.InventoryController)
return function()
    local v3 = v_u_2.getCurrentEquipped()
    if v3 then
        local v4 = v3.Slot or 1
        local v5 = v_u_2.getInventorySlot(v4)
        local v6 = v5._items
        local v7 = v3.Identifier
        for v10, v9 in ipairs(v6) do
            if v9.Identifier == v7 then
                goto l6
            end
        end
        local v10 = 0
        ::l6::
        if #v5._items <= v10 then
            local v11 = v_u_2.getCurrentInventory()
            local v12 = v4
            for v13 = 1, #v11 do
                if #v11[v13]._items > 0 and v4 < v13 then
                    v4 = v13
                    break
                end
            end
            if v4 == v12 then
                for v14 = 1, #v11 do
                    if #v11[v14]._items > 0 and v14 < v4 then
                        v4 = v14
                        break
                    end
                end
            end
            v_u_2.equip(v4, 1)
            return
        end
        local v15 = v10 + 1
        v_u_2.equip(v4, v15)
    end
end