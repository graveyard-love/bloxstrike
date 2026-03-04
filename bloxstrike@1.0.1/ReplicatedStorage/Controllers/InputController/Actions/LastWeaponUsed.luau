local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = v2.LocalPlayer
local v_u_4 = require(v1.Controllers.InventoryController)
local v_u_5 = require(v1.Controllers.CaseSceneController)
local v_u_6 = require(v1.Controllers.InspectController)
return table.freeze({
    ["Name"] = "Last Weapon Used",
    ["Group"] = "Gameplay",
    ["Category"] = "Weapon Keys",
    ["Callback"] = function(p7, _)
        if v_u_3:GetAttribute("IsPlayerChatting") then
            return
        end
        if p7 ~= Enum.UserInputState.Begin then
            return
        end
        if v_u_5.IsActive() or v_u_6.IsActive() then
            return
        end
        local v8 = v_u_4.getPreviousEquipped()
        if v8 then
            local _, v9, v10 = v_u_4.getInventoryItemFromLoadout(v8.Identifier)
            if v9 and v10 then
                v_u_4.equip(v9, v10)
                return
            end
        else
            local v11 = v_u_4.getCurrentInventory()
            local v12 = v_u_4.getCurrentEquipped()
            if v11 and v12 then
                local v13 = nil
                local v14 = nil
                for _, v15 in ipairs(v11) do
                    if #v15._items > 0 then
                        for v16, v17 in ipairs(v15._items) do
                            if v17.Identifier ~= v12.Identifier then
                                v13 = v17.Slot
                                v14 = v16
                                break
                            end
                        end
                    end
                end
                if v13 and v14 then
                    v_u_4.equip(v13, v14)
                end
            end
        end
    end
})