local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = v2.LocalPlayer
local v_u_4 = require(v1.Controllers.InventoryController)
local v_u_5 = require(v1.Controllers.HintController)
local v_u_6 = require(v1.Controllers.CaseSceneController)
local v_u_7 = require(v1.Controllers.InspectController)
return table.freeze({
    ["Name"] = "Inspect",
    ["Group"] = "Gameplay",
    ["Category"] = "Weapon Keys",
    ["Callback"] = function(p8, _)
        if v_u_3:GetAttribute("IsPlayerChatting") then
            return
        elseif p8 == Enum.UserInputState.Begin then
            if v_u_6.IsActive() or v_u_7.IsActive() then
                return
            else
                local v9 = v_u_4.getCurrentEquipped()
                if v9 then
                    v9:inspect()
                    v_u_5:clearHint("Inspect")
                end
            end
        else
            return
        end
    end
})