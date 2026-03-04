local v1 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_2 = v1.LocalPlayer
local v_u_3 = require(v_u_2:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls()
return table.freeze({
    ["Name"] = "Move Backward",
    ["Group"] = "Default",
    ["Category"] = "Movement Keys",
    ["Callback"] = function(p4, _)
        if v_u_2:GetAttribute("IsPlayerChatting") then
            return
        else
            local v5 = v_u_2.Character
            local v6
            if v5 and v5:IsDescendantOf(workspace) then
                local v7 = v5:FindFirstChildOfClass("Humanoid")
                v6 = v7 and v7.Health > 0 and true or false
            else
                v6 = false
            end
            if v6 then
                local v8 = v_u_3.activeController
                if v8 then
                    if v8.UpdateMovement then
                        v8.backwardValue = p4 == Enum.UserInputState.Begin and 1 or 0
                        v8:UpdateMovement(p4)
                    end
                else
                    return
                end
            else
                return
            end
        end
    end
})