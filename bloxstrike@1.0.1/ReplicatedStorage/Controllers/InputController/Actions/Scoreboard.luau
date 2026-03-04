local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = v2.LocalPlayer
local v_u_4 = require(v1.Interface.Screens.Gameplay.Middle.Leaderboard)
return table.freeze({
    ["Name"] = "Scoreboard",
    ["Group"] = "Default",
    ["Category"] = "UI Keys",
    ["Callback"] = function(p5, _)
        if v_u_3:GetAttribute("IsPlayerChatting") then
            return
        elseif p5 == Enum.UserInputState.Begin then
            v_u_4.openFrame()
            return
        elseif p5 == Enum.UserInputState.End then
            v_u_4.closeFrame()
        end
    end
})