local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Workspace")
local v5 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_6 = v5.LocalPlayer
local v_u_7 = require(v_u_2.Controllers.InventoryController)
local v_u_8 = require(v_u_2.Controllers.CameraController)
local v_u_9 = require(v_u_2.Controllers.DataController)
local v_u_10 = require(v_u_2.Database.Security.Remotes)
local v_u_11 = v4.CurrentCamera
local v_u_12 = require(script:WaitForChild("Settings"))
local v_u_13 = nil
local function v_u_23(p14)
    if not p14.getSpread then
        return 1
    end
    local v15 = (p14:getSpread() or 0) / 2
    local v16 = math.clamp(v15, 0, 30)
    local v17 = v_u_11.ViewportSize
    local v18, v19
    if v17.X > v17.Y then
        v18 = v_u_11.MaxAxisFieldOfView
        v19 = v_u_11.FieldOfView
    else
        v18 = v_u_11.FieldOfView
        v19 = v_u_11.MaxAxisFieldOfView
    end
    local v20
    if typeof(v16) == "number" then
        v20 = v16 / v19 * v17.Y
    else
        v20 = v16 / Vector2.new(v18, v19) * v17
    end
    if typeof(v20) ~= "Vector2" then
        return 1 + v20 / 15
    end
    local v21 = v20.X
    local v22 = v20.Y
    return math.max(v21, v22) / 15 + 1
end
local function v_u_41(p24)
    if not (p24.Recoil and (p24.Properties and (p24.Properties.Recoil and v_u_12["Follow Recoil"]))) then
        return UDim2.new()
    end
    local v25 = 1 - p24.Properties.Recoil.CameraScale
    local v26 = v_u_8.getWeaponKickRotation()
    local v27 = p24.Recoil.RotationValue
    local v28 = 0
    if game:GetService("UserInputService").TouchEnabled then
        local v29, v30 = pcall(function()
            return require(v_u_2.Controllers.AimAssistController)
        end)
        if v29 and (v30 and v30.GetRecoilAssistMultiplier) then
            v28 = v30.GetRecoilAssistMultiplier()
        end
    end
    local v31 = v27.X * (1 - v28)
    local v32 = v27.Y * (1 - v28)
    local v33 = v27.Z
    local v34 = Vector3.new(v31, v32, v33)
    local v35 = Vector2.new(v34.Y - v26.Y, v34.X - v26.X) * 57.29577951308232
    local v36 = v_u_11.ViewportSize
    local v37, v38
    if v36.X > v36.Y then
        v37 = v_u_11.MaxAxisFieldOfView
        v38 = v_u_11.FieldOfView
    else
        v37 = v_u_11.FieldOfView
        v38 = v_u_11.MaxAxisFieldOfView
    end
    local v39
    if typeof(v35) == "number" then
        v39 = v35 / v38 * v36.Y
    else
        v39 = v35 / Vector2.new(v37, v38) * v36
    end
    if typeof(v39) ~= "Vector2" then
        return UDim2.new()
    end
    local v40 = v39 * -v25 / v_u_11.ViewportSize
    return UDim2.fromScale(v40.X, v40.Y)
end
local function v_u_54(p42, p43)
    if p42.IsAiming and p42.Properties.AimingOptions == "AutomaticScope" then
        if p42.getBaseSpread then
            local v44 = p42.Viewmodel.Bobble.ScopeReticlePart
            if v44 then
                local v45 = p42:getBaseSpread() or 0
                local v46 = v44.SurfaceGui.Frame.Frame
                local v47 = v_u_11.FieldOfView / 2
                local v48 = math.rad(v47)
                local v49 = math.tan(v48) * 2 * 0.15
                local v50 = v_u_11.ViewportSize
                local v51 = v50.X / v50.Y * v49 / 0.15
                local v52 = v49 / 0.15
                local v53 = math.clamp(v45, 0, 2) * 2
                v46.Size = UDim2.fromScale(v53 + 2.5, v53 + 2.5)
                v46.Position = UDim2.fromScale(0.5, 0.5) + UDim2.new(p43.X.Scale * v51, 0, p43.Y.Scale * v52, 0)
                local _ = v_u_12["Use Crosshair Color for Scope Dot"]
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_57(p55)
    local v56 = 5 + v_u_12.Gap * 5 / 5 + (p55 - 1) * 15
    v_u_13.Ticks.Right.Position = UDim2.new(0.5, v56, 0.5, 0)
    v_u_13.Ticks.Down.Position = UDim2.new(0.5, 0, 0.5, v56)
    v_u_13.Ticks.Left.Position = UDim2.new(0.5, -v56, 0.5, 0)
    v_u_13.Ticks.Up.Position = UDim2.new(0.5, 0, 0.5, -v56)
end
function v_u_1.ResetCrosshair()
    if v_u_13 then
        v_u_13.Position = UDim2.fromScale(0.5, 0.5)
        if v_u_13.Ticks then
            local v58 = 5 + v_u_12.Gap * 5 / 5
            v_u_13.Ticks.Right.Position = UDim2.new(0.5, v58, 0.5, 0)
            v_u_13.Ticks.Down.Position = UDim2.new(0.5, 0, 0.5, v58)
            v_u_13.Ticks.Left.Position = UDim2.new(0.5, -v58, 0.5, 0)
            v_u_13.Ticks.Up.Position = UDim2.new(0.5, 0, 0.5, -v58)
        end
        local v59 = v_u_7.getCurrentEquipped()
        if v59 and typeof(v59) == "table" then
            if v59.IsAiming and (v59.Properties and v59.Properties.AimingOptions == "AutomaticScope") then
                local v60 = v59.Viewmodel
                if v60 and v60.Bobble then
                    local v61 = v60.Bobble.ScopeReticlePart
                    local v62 = v61 and (v61.SurfaceGui and v61.SurfaceGui.Frame) and v61.SurfaceGui.Frame:FindFirstChild("Frame")
                    if v62 then
                        v62.Position = UDim2.fromScale(0.5, 0.5)
                        v62.Size = UDim2.fromScale(2.5, 2.5)
                    end
                end
            end
            local v63 = v59.Recoil
            if v63 then
                v63.Value = Vector2.zero
                v63.RecoveryStartTime = 0
                v63.Time = 0
                v63.RotationValue = Vector3.new(0, 0, 0)
            end
        end
    end
end
function v_u_1.UpdateCrosshair(_)
    local v64 = v_u_6:GetAttribute("IsSpectating") == true
    local v65 = false
    local v66 = nil
    if v64 then
        local v67 = require(v_u_2.Controllers.SpectateController).GetCurrentSpectateInstance()
        if v67 and v_u_12["Show Player Crosshairs"] == true then
            v66 = v_u_9.Get(v67.Player, "Settings.Game.Crosshair")
            if v66 then
                v65 = true
            end
        end
        if v67 and (v67.PerspectiveState == "First-Person" and v67.CurrentEquipped) then
            local v68 = v67.CurrentEquipped.Name
            if v68 == "AWP" and true or v68 == "SSG 08" or (v68 == "AUG" and true or v68 == "SG 553") and (v67.Player:GetAttribute("ScopeIncrement") or 0) > 0 then
                v_u_13.Visible = false
                if v_u_13.Ticks then
                    for _, v69 in pairs(v_u_13.Ticks:GetChildren()) do
                        if v69:IsA("Frame") then
                            v69.Visible = false
                        end
                    end
                end
                if v_u_13.Dot then
                    v_u_13.Dot.Visible = false
                end
                if v_u_13.Crosshair then
                    v_u_13.Crosshair.Visible = false
                end
                return
            end
            local v70 = v65 and v66 and v66 or v_u_12
            local v71 = v70["Crosshair Style"] == "Image"
            if v_u_13.Ticks then
                v_u_13.Ticks.Visible = not v71
                for _, v72 in pairs(v_u_13.Ticks:GetChildren()) do
                    if v72:IsA("Frame") then
                        v72.Visible = true
                    end
                end
            end
            if v_u_13.Dot then
                local v73 = v_u_13.Dot
                local v74 = not v71
                if v74 then
                    v74 = v70["Center Dot"]
                end
                v73.Visible = v74
            end
            if v_u_13.Crosshair then
                v_u_13.Crosshair.Visible = v71
            end
        elseif v67 and v67.PerspectiveState == "First-Person" then
            v_u_13.Visible = true
        end
    end
    local v75 = v_u_6.Character
    local v76 = v_u_7.getCurrentEquipped()
    local v77 = v64 and not v76 and {
        ["Properties"] = {
            ["ShowCrosshair"] = true,
            ["AimingOptions"] = "None"
        },
        ["IsAiming"] = false
    } or v76
    if v64 or v75 then
        if v77 or v64 then
            local v78 = v64 and not v77 and {
                ["Properties"] = {
                    ["ShowCrosshair"] = true,
                    ["AimingOptions"] = "None"
                },
                ["IsAiming"] = false
            } or v77
            local v79 = v65 and v66 and v66 or v_u_12
            local v80 = v79.Alpha.Enabled and (v79.Alpha.Value / 255 or 1) or 1
            local v81 = Color3.fromRGB(v79.Red, v79.Green, v79.Blue)
            local v82 = v79["Crosshair Style"] == "Image"
            v_u_13.Ticks.Visible = not v82
            local v83 = v_u_13.Dot
            local v84 = not v82
            if v84 then
                v84 = v79["Center Dot"]
            end
            v83.Visible = v84
            v_u_13.Crosshair.Visible = v82
            if v82 then
                local v85 = v_u_13.Crosshair
                local v86 = v79["Crosshair Image"]
                v85.Image = "rbxassetid://" .. tostring(v86)
                v_u_13.Crosshair.ImageColor3 = v81
                v_u_13.Crosshair.ImageTransparency = 1 - v80
            else
                for _, v87 in ipairs({
                    "Up",
                    "Down",
                    "Left",
                    "Right"
                }) do
                    local v88 = v_u_13.Ticks:FindFirstChild(v87)
                    if v88 then
                        v88.BackgroundColor3 = v81
                        v88.BackgroundTransparency = 1 - v80
                        v88.Visible = true
                        local v89 = 15 * (v79.Length / 5)
                        local v90 = 2 * (v79.Thickness / 1)
                        if v87 == "Up" or v87 == "Down" then
                            v88.Size = UDim2.new(0, v90, 0, v89)
                        else
                            v88.Size = UDim2.new(0, v89, 0, v90)
                        end
                        if v79.Outline.Enabled then
                            v88.BorderSizePixel = v79.Outline.Value
                            v88.BorderColor3 = Color3.new(0, 0, 0)
                        else
                            v88.BorderSizePixel = 0
                        end
                    end
                end
                if v_u_13.Ticks.Up then
                    v_u_13.Ticks.Up.Visible = not v79["T Style"]
                end
                if v_u_13.Dot and v79["Center Dot"] then
                    v_u_13.Dot.BackgroundColor3 = v81
                    v_u_13.Dot.BackgroundTransparency = 1 - v80
                    if v79.Outline.Enabled then
                        v_u_13.Dot.BorderSizePixel = v79.Outline.Value
                        v_u_13.Dot.BorderColor3 = Color3.new(0, 0, 0)
                    else
                        v_u_13.Dot.BorderSizePixel = 0
                    end
                end
            end
            local v91 = v_u_13
            local v92 = v78.Properties.ShowCrosshair
            local v93 = v_u_13.Parent
            local v94 = v92 and not (v93.TeamSelection.Visible or v93.Leaderboard.Visible or (v93.EndScreen.Visible or v93.BuyMenu.Visible))
            if v94 then
                v94 = not v78.IsAiming
            end
            v91.Visible = v94
            local v95 = UDim2.new()
            local v96 = 1
            if v_u_13.Visible or v78.Properties.AimingOptions == "AutomaticScope" then
                if v79["Crosshair Style"] == "Classic Static" or v79["Crosshair Style"] == "Image" then
                    v96 = 1
                elseif v79["Crosshair Style"] == "Classic" then
                    v96 = v_u_23(v78)
                end
                v95 = v_u_41(v78)
            end
            v_u_54(v78, v95)
            v_u_13.Position = UDim2.fromScale(0.5, 0.5) + v95
            if not v82 then
                v_u_57(v96)
            end
        end
    else
        return
    end
end
function v_u_1.Initialize(_, p97)
    v_u_13 = p97
    v_u_9.CreateListener(v_u_6, "Settings.Game.Crosshair", function(p98)
        v_u_12 = p98
        task.delay(0.1, function()
            v_u_1.UpdateCrosshair(0)
        end)
    end)
    v_u_3.Heartbeat:Connect(function(p99)
        v_u_1.UpdateCrosshair(p99)
    end)
    v_u_10.Character.CharacterDied.Listen(function()
        v_u_1.ResetCrosshair()
    end)
end
return v_u_1