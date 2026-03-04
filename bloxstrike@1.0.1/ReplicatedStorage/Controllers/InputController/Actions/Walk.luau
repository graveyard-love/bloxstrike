local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = require(v1.Controllers.CharacterController)
local v_u_4 = require(v1.Controllers.DataController)
local v_u_5 = v2.LocalPlayer
v_u_5:GetAttributeChangedSignal("IsPlayerChatting"):Connect(function()
    if v_u_5:GetAttribute("IsPlayerChatting") then
        v_u_3.walk(false)
    end
end)
return table.freeze({
    ["Name"] = "Walk",
    ["Group"] = "Default",
    ["Category"] = "Movement Keys",
    ["Callback"] = function(p6, _)
        if v_u_5:GetAttribute("IsPlayerChatting") then
            return
        else
            local v7 = v_u_5.Character
            local v8
            if v7 and v7:IsDescendantOf(workspace) then
                local v9 = v7:FindFirstChildOfClass("Humanoid")
                v8 = v9 and v9.Health > 0 and true or false
            else
                v8 = false
            end
            if v8 then
                local v10 = v_u_4.Get(v_u_5, "Settings.Keyboard/Mouse.Keyboard & Mouse Settings.Walk Mode")
                if ((not v10 or v10 == "") and "Hold" or v10) == "Toggle" then
                    if p6 == Enum.UserInputState.Begin then
                        local v11 = v_u_3.GetWalkState() or false
                        v_u_3.walk(not v11)
                    end
                elseif p6 == Enum.UserInputState.Begin then
                    v_u_3.walk(true)
                    return
                elseif p6 == Enum.UserInputState.End then
                    v_u_3.walk(false)
                end
            else
                return
            end
        end
    end
})