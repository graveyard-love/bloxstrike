local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
require(v2.Database.Custom.Types)
local v_u_5 = v4.LocalPlayer
local v_u_6 = require(v2.Controllers.InputController)
local v_u_7 = require(v2.Controllers.DataController)
local v_u_8 = workspace.CurrentCamera
local v_u_9 = RaycastParams.new()
v_u_9.FilterType = Enum.RaycastFilterType.Exclude
v_u_9.IgnoreWater = true
local v_u_10 = nil
function v_u_1.GetHoverState()
    if v_u_5:GetAttribute("Team") ~= "Counter-Terrorists" then
        return false
    end
    v_u_9.FilterDescendantsInstances = { v_u_5.Character, v_u_8 }
    local v11 = workspace:Raycast(v_u_8.CFrame.Position, v_u_8.CFrame.LookVector * 5, v_u_9)
    if v11 then
        local v12 = v11.Instance
        if v12 and (v12.Parent and v12.Parent:HasTag("Hostage")) or false then
            local v13 = v11.Instance.Parent
            if v13 and v13:GetAttribute("CanRescue") == true then
                return true
            end
        end
    end
    return false
end
function v_u_1.Initialize(_, p14)
    v_u_10 = p14
    local function v_u_16()
        local v15 = v_u_6.GetActionKeybind("Use")
        v_u_10.Text = ("[%*] Pick Up Hostage"):format(not v15 and "E" or v15:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", ""))
    end
    local v17 = v_u_6.GetActionKeybind("Use")
    v_u_10.Text = ("[%*] Pick Up Hostage"):format(not v17 and "E" or v17:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", ""))
    v_u_7.CreateListener(v_u_5, "Settings.Keyboard/Mouse", function(p18)
        if p18 then
            task.defer(v_u_16)
        end
    end)
    v_u_3.Heartbeat:Connect(function(_)
        local v19 = v_u_5.Character
        local v20
        if v19 and v19:IsDescendantOf(workspace) then
            local v21 = v19:FindFirstChild("Humanoid")
            v20 = v21 and v21.Health > 0 and true or false
        else
            v20 = false
        end
        if v20 then
            v_u_10.Visible = v_u_1.GetHoverState()
        end
    end)
end
return v_u_1