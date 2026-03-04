local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("CollectionService")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("RunService")
local v_u_6 = game:GetService("Players").LocalPlayer
local v_u_7 = require(v2.Controllers.InputController)
local v_u_8 = require(v2.Controllers.DataController)
local v_u_9 = require(v2.Database.Security.Router)
local v10 = require(v2.Components.Common.GetUserPlatform)
local v_u_11 = table.find(v10(), "Mobile")
if v_u_11 then
    v_u_11 = #v10() <= 1
end
local v_u_12 = nil
local v_u_13 = false
local v_u_14 = nil
function v_u_1.GetHoverState()
    if v_u_6:GetAttribute("Team") == "Counter-Terrorists" then
        local v15 = v_u_3:GetTagged("Bomb")[1]
        if v15 then
            return v15:GetAttribute("CanDefuse") and not v15:GetAttribute("Defused") and true or false
        else
            return false
        end
    else
        return false
    end
end
function v_u_1.Initialize(_, p16)
    v_u_14 = p16
    local function v_u_18()
        if v_u_11 then
            v_u_14.Text = "Hold to Defuse"
        else
            local v17 = v_u_7.GetActionKeybind("Use")
            v_u_14.Text = ("[%*] Defuse Bomb"):format(not v17 and "E" or v17:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", ""))
        end
    end
    if v_u_11 then
        v_u_14.Text = "Hold to Defuse"
    else
        local v19 = v_u_7.GetActionKeybind("Use")
        v_u_14.Text = ("[%*] Defuse Bomb"):format(not v19 and "E" or v19:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", ""))
    end
    v_u_8.CreateListener(v_u_6, "Settings.Keyboard/Mouse", function(p20)
        if p20 then
            task.defer(v_u_18)
        end
    end)
    v_u_6:GetAttributeChangedSignal("Dead"):Connect(function()
        if v_u_6:GetAttribute("Dead") then
            v_u_14.Visible = false
        end
    end)
    v_u_6.CharacterRemoving:Connect(function()
        v_u_14.Visible = false
    end)
    v_u_5.Heartbeat:Connect(function(_)
        local v21 = v_u_6.Character
        local v22
        if v21 and v21:IsDescendantOf(workspace) then
            local v23 = v21:FindFirstChild("Humanoid")
            v22 = v23 and v23.Health > 0 and true or false
        else
            v22 = false
        end
        if v22 then
            local v24 = v_u_1.GetHoverState()
            v_u_14.Visible = v24
            if v_u_11 and (v_u_13 and not v24) then
                local v25 = v_u_3:GetTagged("Bomb")[1]
                if v25 then
                    v25 = v25:GetAttribute("Defused")
                end
                v_u_13 = false
                v_u_12 = nil
                if not v25 then
                    v_u_9.broadcastRouter("Cancel Defuse Bomb")
                    return
                end
            end
        else
            v_u_14.Visible = false
            if v_u_11 and v_u_13 then
                v_u_13 = false
                v_u_12 = nil
            end
        end
    end)
    if v_u_11 then
        v_u_4.TouchStarted:Connect(function(p26, p27)
            if not p27 then
                if v_u_1.GetHoverState() then
                    local v28 = v_u_6.Character
                    local v29
                    if v28 and v28:IsDescendantOf(workspace) then
                        local v30 = v28:FindFirstChild("Humanoid")
                        v29 = v30 and v30.Health > 0 and true or false
                    else
                        v29 = false
                    end
                    if v29 and not v_u_13 then
                        v_u_12 = p26
                        v_u_13 = true
                        v_u_9.broadcastRouter("Start Defuse Bomb")
                    end
                end
            end
        end)
        v_u_4.TouchEnded:Connect(function(p31, _)
            if p31 == v_u_12 then
                v_u_12 = nil
                if v_u_13 then
                    v_u_13 = false
                    v_u_9.broadcastRouter("Cancel Defuse Bomb")
                end
            end
        end)
    end
end
return v_u_1