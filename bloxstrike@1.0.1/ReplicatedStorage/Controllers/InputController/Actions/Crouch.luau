local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = v2.LocalPlayer
local v_u_4 = require(v1.Controllers.CharacterController)
v_u_3:GetAttributeChangedSignal("IsPlayerChatting"):Connect(function()
    if v_u_3:GetAttribute("IsPlayerChatting") then
        v_u_4.crouch(false)
    end
end)
return table.freeze({
    ["Name"] = "Crouch",
    ["Group"] = "Gameplay",
    ["Category"] = "Movement Keys",
    ["Callback"] = function(p5, _)
        if v_u_3:GetAttribute("IsPlayerChatting") then
            return
        elseif p5 == Enum.UserInputState.Begin then
            v_u_4.crouch(true)
            return
        elseif p5 == Enum.UserInputState.End then
            v_u_4.crouch(false)
        end
    end
})