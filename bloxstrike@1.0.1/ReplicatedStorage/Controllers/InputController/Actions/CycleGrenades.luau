local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = v2.LocalPlayer
require(v1.Controllers.InventoryController)
local v_u_4 = require(v1.Controllers.CaseSceneController)
local v_u_5 = require(v1.Controllers.InspectController)
local v_u_6 = require(v1.Components.Common.UserInput.EquipInventorySlot)
return table.freeze({
    ["Name"] = "Cycle Grenades",
    ["Group"] = "Gameplay",
    ["Category"] = "Weapon Keys",
    ["Callback"] = function(p7, _)
        if v_u_3:GetAttribute("IsPlayerChatting") then
            return
        elseif p7 == Enum.UserInputState.Begin then
            if not (v_u_4.IsActive() or v_u_5.IsActive()) then
                v_u_6(4)
            end
        else
            return
        end
    end
})