local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("HapticService")
local v_u_5 = game:GetService("RunService")
local v6 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_7 = v6.LocalPlayer
local v_u_8 = require(v2.Controllers.DataController)
local v_u_9 = {}
function v1.vibrate(p10, p11, p12)
    local v13 = v_u_3:GetLastInputType() == Enum.UserInputType.Touch and "Mobile" or "Controller"
    local v14 = v_u_8.Get(v_u_7, "Settings.Game.Other." .. v13 .. " Haptics/Vibrations")
    local v15
    if v14 == nil then
        v15 = false
    else
        v15 = v14 ~= false
    end
    if v15 then
        local v16 = Enum.UserInputType.Gamepad1
        if v_u_9[p10] then
            local v17 = v_u_9[p10]
            v17.InputMotor = v16
            if v17.Length < p12 then
                v17.Length = p12
            end
            if v17.Intensity < p11 then
                v17.Intensity = p11
                return
            end
        else
            v_u_9[p10] = {
                ["InputMotor"] = v16,
                ["Intensity"] = p11,
                ["Length"] = p12
            }
        end
    end
end
function v1.Initialize()
    v_u_5.RenderStepped:Connect(function(p18)
        for v19, v20 in pairs(v_u_9) do
            v20.Length = v20.Length - p18
            if v_u_4:IsMotorSupported(v20.InputMotor, v19) then
                v_u_4:SetMotor(v20.InputMotor, v19, v20.Intensity)
            end
            if v20.Length <= 0 then
                v_u_4:SetMotor(v20.InputMotor, v19, 0)
                v_u_9[v19] = nil
            end
        end
    end)
end
return v1