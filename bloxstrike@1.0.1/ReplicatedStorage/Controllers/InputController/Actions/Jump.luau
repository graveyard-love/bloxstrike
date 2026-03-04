local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = require(v1.Controllers.CharacterController)
local v_u_4 = v2.LocalPlayer
return table.freeze({
    ["Name"] = "Jump",
    ["Group"] = "Gameplay",
    ["Category"] = "Movement Keys",
    ["Callback"] = function(p5, _)
        if not v_u_4:GetAttribute("IsPlayerChatting") then
            if p5 == Enum.UserInputState.Begin then
                v_u_3.jump()
            end
        end
    end
})