local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = v2.LocalPlayer
local v_u_4 = require(v1.Interface.Screens.Gameplay.Middle.BuyMenu)
return table.freeze({
    ["Name"] = "Buy Menu",
    ["Group"] = "Gameplay",
    ["Category"] = "Weapon Keys",
    ["Callback"] = function(p5, _)
        if v_u_3:GetAttribute("IsPlayerChatting") then
            return
        elseif p5 == Enum.UserInputState.Begin then
            local v6 = v_u_3.Character
            if v6 and v6:IsDescendantOf(workspace) then
                local v7 = v6:FindFirstChild("Humanoid")
                if v7 and v7.Health > 0 then
                    v_u_4.toggleFrame()
                    return
                end
            end
        end
    end
})