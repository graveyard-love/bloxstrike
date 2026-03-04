local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = v2.LocalPlayer
local v_u_4 = nil
local v8 = {
    ["Name"] = "Team Message",
    ["Group"] = "Default",
    ["Category"] = "Communication Options",
    ["Callback"] = function(p5, _)
        if p5 == Enum.UserInputState.Begin then
            if not v_u_4 then
                v_u_4 = require(v_u_1.Interface.Screens.Gameplay.Middle.Chat)
            end
            local v6 = v_u_3:GetAttribute("Team")
            local v7 = not v6 or v6 == "Spectators"
            v_u_4.OpenChat(v7 and 1 or 0)
        end
    end
}
return table.freeze(v8)