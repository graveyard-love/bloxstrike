local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = v2.LocalPlayer
local v_u_4 = require(v1.Components.Common.UserInput.EquipSlotRight)
local v_u_5 = require(v1.Controllers.HintController)
local v_u_6 = require(v1.Controllers.CaseSceneController)
local v_u_7 = require(v1.Controllers.InspectController)
local v_u_8 = require(v1.Interface.MenuState)
return table.freeze({
    ["Name"] = "Cycle Weapons Right",
    ["Group"] = "Gameplay",
    ["Category"] = "Weapon Keys",
    ["Callback"] = function(p9, _)
        if v_u_3:GetAttribute("IsPlayerChatting") or p9 ~= Enum.UserInputState.Begin then
            return
        elseif not (v_u_8.GetCurrentScreen() or (v_u_6.IsActive() or v_u_7.IsActive())) then
            v_u_4()
            v_u_5:clearHint("Reload")
        end
    end
})