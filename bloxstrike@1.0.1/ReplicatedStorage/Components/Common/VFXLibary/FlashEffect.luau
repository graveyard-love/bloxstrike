local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Lighting")
local v_u_5 = game:GetService("Workspace")
local v_u_6 = game:GetService("RunService")
local v_u_7 = v2.LocalPlayer
local v_u_8 = v_u_7:WaitForChild("PlayerGui")
local v_u_9 = v_u_5.CurrentCamera
local v_u_10 = v_u_5:WaitForChild("Debris")
local v_u_11 = require(v1.Controllers.CaptureController)
local v_u_12 = require(v1.Classes.Sound)
local v_u_13 = Color3.new(1, 1, 1)
local v_u_14 = RaycastParams.new()
v_u_14.FilterType = Enum.RaycastFilterType.Exclude
v_u_14.IgnoreWater = true
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = nil
local v_u_23 = nil
local v_u_24 = nil
local v_u_25 = nil
local v_u_26 = nil
local v_u_27 = 0
local v_u_28 = nil
local function v_u_29()
    if v_u_18 then
        v_u_18:Cancel()
        v_u_18 = nil
    end
    if v_u_19 then
        v_u_19:Cancel()
        v_u_19 = nil
    end
    if v_u_15 then
        v_u_15:Destroy()
        v_u_15 = nil
        v_u_16 = nil
    end
    if v_u_17 then
        v_u_17:Destroy()
        v_u_17 = nil
    end
    if v_u_22 then
        v_u_22:Cancel()
        v_u_22 = nil
    end
    if v_u_20 then
        v_u_20:Destroy()
        v_u_20 = nil
        v_u_21 = nil
    end
    v_u_25 = nil
    v_u_26 = nil
end
local function v_u_32()
    local v30 = Instance.new("ScreenGui")
    v30.Name = "FlashbangEffect"
    v30.DisplayOrder = 999
    v30.IgnoreGuiInset = true
    v30.ResetOnSpawn = false
    local v31 = Instance.new("Frame")
    v31.Name = "FlashOverlay"
    v31.Size = UDim2.new(1, 0, 1, 0)
    v31.Position = UDim2.new(0, 0, 0, 0)
    v31.BackgroundColor3 = v_u_13
    v31.BackgroundTransparency = 1
    v31.BorderSizePixel = 0
    v31.ZIndex = 999
    v31.Parent = v30
    v30.Parent = v_u_8
    return v30, v31
end
local function v_u_42(p33)
    task.wait(0.05)
    while v_u_27 == p33 do
        local v34 = v_u_25
        local v35 = v_u_26
        if not (v34 and v35) then
            break
        end
        local v36 = os.clock()
        if v34 <= v36 then
            break
        end
        local v37 = v_u_15
        local v38 = v_u_16
        local v39 = v_u_17
        if not (v37 and v38) then
            v37, v38 = v_u_32()
            v_u_15 = v37
            v_u_16 = v38
        end
        if not v39 then
            v39 = Instance.new("ColorCorrectionEffect")
            v39.Name = "FlashbangColorCorrection"
            v39.Brightness = 0
            v39.Contrast = 0
            v39.Saturation = 0
            v39.TintColor = Color3.new(1, 1, 1)
            v39.Parent = v_u_4
            v_u_17 = v39
        end
        if v36 < v35 then
            if v_u_18 then
                v_u_18:Cancel()
                v_u_18 = nil
            end
            if v_u_19 then
                v_u_19:Cancel()
                v_u_19 = nil
            end
            v38.BackgroundTransparency = 0
            v39.Brightness = 1
            v39.Saturation = -1
            task.wait(0.05)
        else
            local v40 = v34 - v36
            if v40 <= 0 then
                break
            end
            if v_u_18 then
                v_u_18:Cancel()
                v_u_18 = nil
            end
            if v_u_19 then
                v_u_19:Cancel()
                v_u_19 = nil
            end
            v_u_18 = v_u_3:Create(v38, TweenInfo.new(v40, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["BackgroundTransparency"] = 1
            })
            v_u_19 = v_u_3:Create(v39, TweenInfo.new(v40, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["Brightness"] = 0,
                ["Saturation"] = 0
            })
            v_u_18:Play()
            v_u_19:Play()
            while v_u_27 == p33 do
                local v41 = os.clock()
                if v34 <= v41 or v_u_26 and v41 < v_u_26 then
                    break
                end
                task.wait(0.05)
            end
        end
    end
    if v_u_27 == p33 then
        v_u_29()
    end
end
local v_u_43 = { -0.5, 0, 0.5 }
local v_u_44 = nil
local function v_u_58(p45, p46)
    local v47 = { v_u_10 }
    local v48 = v_u_7.Character
    if v48 then
        table.insert(v47, v48)
    end
    local v49 = not v_u_44 and v_u_5:FindFirstChild("Map")
    if v49 then
        v_u_44 = v49:FindFirstChild("Barriers")
    end
    local v50 = v_u_44
    if v50 then
        table.insert(v47, v50)
    end
    v_u_14.FilterDescendantsInstances = v47
    for _, v51 in ipairs(v_u_43) do
        for _, v52 in ipairs(v_u_43) do
            for _, v53 in ipairs(v_u_43) do
                local v54 = p45 + Vector3.new(v51, v52, v53)
                local v55 = p46 - v54
                local v56 = v55.Magnitude
                if v56 < 0.1 then
                    return true
                end
                local v57 = v_u_5:Raycast(v54, v55, v_u_14)
                if not v57 or v57.Distance >= v56 - 0.5 then
                    return true
                end
            end
        end
    end
    return false
end
return {
    ["Flash"] = function(p59)
        local v60 = p59.Position
        local v61 = v_u_9.CFrame.Position
        local v62 = v_u_9.CFrame.LookVector
        local v_u_63
        if p59.Duration then
            v_u_63 = p59.Duration
        else
            local v64 = v60 - v61
            local v65 = v64.Magnitude
            if v65 > 100 then
                return
            end
            if not v_u_58(v60, v61) then
                return
            end
            local v66 = v62:Dot(v64.Unit)
            local v67
            if v66 >= 0 then
                v67 = 0.5 + 0.5 * v66
            else
                local v68 = v66 + 1
                v67 = math.pow(v68, 1.5) * 0.5
            end
            v_u_63 = (0.05 + 4.95 * v67) * (v65 <= 20 and 1 or (v65 >= 100 and 0 or 1 - (v65 - 20) / 80))
        end
        if v_u_63 >= 0.025 then
            if v_u_23 then
                if v_u_24 then
                    v_u_24:Disconnect()
                    v_u_24 = nil
                end
                if v_u_23.Parent then
                    v_u_23:Stop()
                    v_u_23:Destroy()
                end
                v_u_23 = nil
            end
            local v69 = {
                ["Parent"] = v_u_9,
                ["Name"] = "Flashed"
            }
            local v_u_70 = v_u_12.new("Flashbang"):play(v69)
            if v_u_70 then
                v_u_23 = v_u_70
                local v_u_71 = tick()
                local v_u_72 = v_u_70.Volume
                v_u_24 = v_u_6.Heartbeat:Connect(function()
                    local v73 = tick() - v_u_71
                    if v73 >= 4 then
                        if v_u_24 then
                            v_u_24:Disconnect()
                            v_u_24 = nil
                        end
                        if v_u_70 and v_u_70.Parent then
                            v_u_70:Stop()
                            v_u_70:Destroy()
                        end
                        if v_u_23 == v_u_70 then
                            v_u_23 = nil
                            return
                        end
                    else
                        if v_u_70 and v_u_70.Parent then
                            v_u_70.Volume = v_u_72 * (v73 >= 4 and 0 or 1 - v73 * 0.225)
                            return
                        end
                        if not (v_u_70 and v_u_70.Parent) then
                            if v_u_24 then
                                v_u_24:Disconnect()
                                v_u_24 = nil
                            end
                            if v_u_23 == v_u_70 then
                                v_u_23 = nil
                            end
                        end
                    end
                end)
            end
            local function v_u_92()
                local v74 = os.clock()
                local v75
                if v_u_25 then
                    local v76 = v_u_25 - v74
                    v75 = math.max(0, v76) or 0
                else
                    v75 = 0
                end
                local v77 = v75 + v_u_63
                local v78 = math.min(5, v77)
                v_u_28 = v74
                v_u_25 = v74 + v78
                local v79 = v_u_63 * 0.3
                local v80 = v74 + 0.05 + v79
                local v81 = v_u_25
                local v82 = v_u_26 or 0
                local v83 = math.max(v82, v80)
                v_u_26 = math.min(v81, v83)
                if v_u_63 >= 0.5 and v_u_21 then
                    if v_u_22 then
                        v_u_22:Cancel()
                        v_u_22 = nil
                    end
                    v_u_21.ImageTransparency = 0
                    local v84 = v78 * 1.25 + 0.25
                    local v_u_85 = v_u_3:Create(v_u_21, TweenInfo.new(v84, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        ["ImageTransparency"] = 1
                    })
                    v_u_22 = v_u_85
                    v_u_85:Play()
                    v_u_85.Completed:Connect(function()
                        if v_u_20 then
                            v_u_20:Destroy()
                            v_u_20 = nil
                            v_u_21 = nil
                        end
                        if v_u_22 == v_u_85 then
                            v_u_22 = nil
                        end
                    end)
                end
                local v86 = v_u_15
                local v87 = v_u_16
                local v88 = v_u_17
                if not (v86 and v87) then
                    v86, v87 = v_u_32()
                    v_u_15 = v86
                    v_u_16 = v87
                end
                if not v88 then
                    v88 = Instance.new("ColorCorrectionEffect")
                    v88.Name = "FlashbangColorCorrection"
                    v88.Brightness = 0
                    v88.Contrast = 0
                    v88.Saturation = 0
                    v88.TintColor = Color3.new(1, 1, 1)
                    v88.Parent = v_u_4
                    v_u_17 = v88
                end
                if v_u_18 then
                    v_u_18:Cancel()
                    v_u_18 = nil
                end
                if v_u_19 then
                    v_u_19:Cancel()
                    v_u_19 = nil
                end
                local v89 = v_u_3:Create(v87, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["BackgroundTransparency"] = 0
                })
                local v90 = v_u_3:Create(v88, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Brightness"] = 1,
                    ["Saturation"] = -1
                })
                v89:Play()
                v90:Play()
                v_u_27 = v_u_27 + 1
                local v_u_91 = v_u_27
                task.spawn(function()
                    v_u_42(v_u_91)
                end)
            end
            if v_u_63 >= 0.5 then
                v_u_11.CaptureScreenshot(function(p93)
                    if v_u_22 then
                        v_u_22:Cancel()
                        v_u_22 = nil
                    end
                    if v_u_20 then
                        if v_u_21 then
                            v_u_21.Image = p93
                            v_u_21.ImageTransparency = 0
                        end
                    else
                        local v94 = Instance.new("ScreenGui")
                        v94.Name = "FlashScreenshot"
                        v94.DisplayOrder = 998
                        v94.IgnoreGuiInset = true
                        v94.ResetOnSpawn = false
                        v94.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                        local v95 = Instance.new("ImageLabel")
                        v95.Name = "ScreenshotImage"
                        v95.Size = UDim2.new(1, 0, 1, 0)
                        v95.Position = UDim2.new(0, 0, 0, 0)
                        v95.BackgroundTransparency = 1
                        v95.BorderSizePixel = 0
                        v95.Image = p93
                        v95.ImageTransparency = 0
                        v95.ScaleType = Enum.ScaleType.Fit
                        v95.ZIndex = 998
                        v95.Parent = v94
                        v94.Parent = v_u_8
                        v_u_20 = v94
                        v_u_21 = v95
                    end
                    if v_u_21 then
                        local v96 = os.clock()
                        local v97
                        if v_u_25 and v96 < v_u_25 then
                            local v98 = v_u_25 - v96
                            v97 = math.max(0, v98)
                        else
                            v97 = 0
                        end
                        local v99 = v97 + 0.25
                        if v_u_22 then
                            v_u_22:Cancel()
                            v_u_22 = nil
                        end
                        local v_u_100 = v_u_3:Create(v_u_21, TweenInfo.new(v99, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            ["ImageTransparency"] = 1
                        })
                        v_u_22 = v_u_100
                        v_u_100:Play()
                        v_u_100.Completed:Connect(function()
                            if v_u_20 then
                                v_u_20:Destroy()
                                v_u_20 = nil
                                v_u_21 = nil
                            end
                            if v_u_22 == v_u_100 then
                                v_u_22 = nil
                            end
                        end)
                    end
                end):catch(function() end)
                task.delay(0.01, function()
                    v_u_92()
                end)
            else
                v_u_92()
            end
        end
    end,
    ["CancelFlash"] = function()
        v_u_27 = v_u_27 + 1
        v_u_29()
        v_u_28 = nil
        if v_u_24 then
            v_u_24:Disconnect()
            v_u_24 = nil
        end
        if v_u_23 and v_u_23.Parent then
            v_u_23:Stop()
            v_u_23:Destroy()
        end
        v_u_23 = nil
    end,
    ["IsFlashed"] = function()
        if v_u_25 then
            return os.clock() < v_u_25
        else
            return false
        end
    end,
    ["GetAudioFadeMultiplier"] = function()
        if not v_u_28 then
            return 1
        end
        local v101 = os.clock() - v_u_28
        if v101 >= 1.5 then
            return 1
        end
        if v101 < 0.5 then
            return 0
        end
        local v102 = (v101 - 0.5) / 1
        return math.clamp(v102, 0, 1)
    end
}