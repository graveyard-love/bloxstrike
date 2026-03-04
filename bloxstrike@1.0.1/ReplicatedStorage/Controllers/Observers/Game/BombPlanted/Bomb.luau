local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v_u_4 = game:GetService("RunService")
local v5 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_6 = v5.LocalPlayer
local v_u_7 = require(v_u_2.Controllers.HapticsController)
local v_u_8 = require(v_u_2.Controllers.CameraController)
local v_u_9 = require(v_u_2.Classes.Sound)
local v_u_10 = require(v_u_2.Database.Security.Router)
local v_u_11 = require(v_u_2.Shared.Janitor)
local v_u_12 = workspace.CurrentCamera
function v_u_1.updateHeartbeat(p13, p14)
    if p13.Model:GetAttribute("IsGettingDefused") then
        return
    elseif p14.PrimaryPart and p13.Model.PrimaryPart then
        if (p14.PrimaryPart.Position - p13.Model.PrimaryPart.Position).Magnitude > 5 then
            p13.Model:SetAttribute("CanDefuse", false)
            return
        else
            local v15 = v_u_12.CFrame.Position
            local v16 = p13.Model.PrimaryPart.Position - v15
            local v17 = v16.Magnitude
            if v17 > 0 then
                local v18 = v16 / v17
                if v_u_12.CFrame.LookVector:Dot(v18) >= 0.966 then
                    p13.Model:SetAttribute("CanDefuse", true)
                else
                    p13.Model:SetAttribute("CanDefuse", false)
                end
            else
                p13.Model:SetAttribute("CanDefuse", false)
                return
            end
        end
    else
        return
    end
end
function v_u_1.new(p19)
    local v20 = v_u_1
    local v_u_21 = setmetatable({}, v20)
    v_u_21.Janitor = v_u_11.new()
    v_u_21.Sound = v_u_9.new("C4")
    v_u_21.Janitor:Add(function()
        v_u_21.Sound:destroy()
    end)
    v_u_21.Model = p19
    v_u_21.Data = v_u_3:JSONDecode(p19:GetAttribute("BombPlanted"))
    local v22 = v_u_21.Data.Time
    local v23 = typeof(v22) == "number" and v_u_21.Data.Time or workspace:GetServerTimeNow()
    local v24 = v_u_21.Data.TimeUntilExplode
    local v25 = typeof(v24) == "number" and (v_u_21.Data.TimeUntilExplode or 40) or 40
    v_u_21.TimeUntilExplode = math.max(v25, 0.1)
    v_u_21.ExplodeAt = v23 + v_u_21.TimeUntilExplode
    v_u_21.MinimumInterval = 0.15
    v_u_21.NextBeepAt = workspace:GetServerTimeNow()
    local v26 = workspace:GetServerTimeNow() - v23
    v_u_21.Elapsed = math.max(v26, 0)
    v_u_21.IsDefused = false
    v_u_10.broadcastRouter("CreateNotification", "Bomb", "The bomb has been planted.", 2.5)
    for _, v27 in ipairs(v_u_21.Model:GetDescendants()) do
        if v27:IsA("BasePart") then
            v27.CanQuery = true
        end
    end
    v_u_21.Janitor:Add(v_u_21.Model:GetAttributeChangedSignal("Defused"):Connect(function()
        v_u_10.broadcastRouter("Cancel Defuse Bomb")
        v_u_10.broadcastRouter("CreateNotification", "Bomb", "The bomb has been defused.", 2.5)
        v_u_21.IsDefused = true
    end))
    v_u_21.Janitor:Add(v_u_21.Model:GetAttributeChangedSignal("Exploding"):Connect(function()
        v_u_10.broadcastRouter("Cancel Defuse Bomb")
        local v28 = require(v_u_2.Interface.Screens.Gameplay.Middle.DefuseBomb)
        if v28 and v28.SetDefuseBlockedUntil then
            local v29 = workspace:GetServerTimeNow()
            v28.SetDefuseBlockedUntil(v29 + 5)
        end
    end))
    v_u_21.Janitor:Add(v_u_21.Model:GetAttributeChangedSignal("Exploded"):Connect(function()
        local v30 = v_u_6.Character
        if v30 and v30:IsDescendantOf(workspace) then
            local v31 = v30:FindFirstChild("Humanoid")
            if v31 and v31.Health > 0 then
                v_u_8.BombExploded((v_u_21.Model.PrimaryPart.Position - v30.PrimaryPart.Position).Magnitude)
                v_u_7.vibrate(Enum.VibrationMotor.Large, 1.5, 0.25)
            end
        end
    end))
    v_u_21.Janitor:Add(v_u_4.Heartbeat:Connect(function(_)
        local v32 = v_u_6.Character
        if v32 and v32:IsDescendantOf(workspace) then
            local v33 = v32:FindFirstChild("Humanoid")
            if v33 and (v33.Health > 0 and v_u_6:GetAttribute("Team") == "Counter-Terrorists") then
                v_u_21:updateHeartbeat(v32)
            end
        end
    end))
    v_u_21.Janitor:Add(v_u_4.Heartbeat:Connect(function(_)
        local v34 = workspace:GetServerTimeNow()
        local v35 = v_u_21.ExplodeAt - v34
        local v36 = math.max(v35, 0)
        local v37 = v_u_21
        local v38 = v_u_21.TimeUntilExplode - v36
        v37.Elapsed = math.max(v38, 0)
        local v39 = v_u_21.Model:FindFirstChild("Weapon")
        if v39 then
            v39 = v_u_21.Model.Weapon:FindFirstChild("FlashingLight")
        end
        if v_u_21.IsDefused or v36 <= 0 then
            if v39 and (v39:FindFirstChild("Attachment") and v39.Attachment:FindFirstChild("PointLight")) then
                v39.Attachment.PointLight.Enabled = not v39.Attachment.PointLight.Enabled
            end
        elseif v_u_21.NextBeepAt <= v34 then
            local v40 = v_u_21
            local v41 = v_u_21.TimeUntilExplode
            local v42 = v_u_21.MinimumInterval
            local v43 = v36 / v41 * 0.9 + 0.1
            if v43 > v42 then
                v42 = v43
            end
            v40.NextBeepAt = v34 + v42
            if v39 and (v39:FindFirstChild("Attachment") and v39.Attachment:FindFirstChild("PointLight")) then
                v39.Attachment.PointLight.Enabled = not v39.Attachment.PointLight.Enabled
            end
            local v44 = v_u_21.Model
            if v44 then
                v44 = v_u_21.Model.PrimaryPart
            end
            if not v44 then
                return
            end
            v_u_21.Sound:play({
                ["Parent"] = v44,
                ["Name"] = "Beep"
            })
        end
    end))
    return v_u_21
end
function v_u_1.destroy(p45)
    p45.Janitor:Destroy()
end
return v_u_1