local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = v2.LocalPlayer
local v_u_4 = require(v1.Interface.Screens.Gameplay.Middle.TeamSelection)
return table.freeze({
    ["Name"] = "Choose Team",
    ["Group"] = "Default",
    ["Category"] = "UI Keys",
    ["Callback"] = function(p5, _)
        if v_u_3:GetAttribute("IsPlayerChatting") then
            return
        elseif p5 == Enum.UserInputState.Begin then
            local v6 = v_u_3:GetAttribute("IsSpectating")
            local v7 = v_u_3:GetAttribute("Team")
            if (v7 == "Counter-Terrorists" or v7 == "Terrorists") and true or v6 == true then
                if v6 then
                    v_u_4.openFrame()
                    return
                elseif v_u_3.Character then
                    v_u_4.ToggleTeamSelection()
                end
            else
                return
            end
        else
            return
        end
    end
})