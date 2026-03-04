local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = require(v2.Database.Security.Remotes)
local v_u_6 = require(v2.Database.Security.Router)
local v_u_7 = require(v2.Database.Components.GameState)
local v_u_8 = require(v2.Shared.Janitor)
local v_u_9 = require(v2.Packages.Signal)
local v_u_10 = require(v2.Controllers.SpectateController)
local v_u_11 = v4.LocalPlayer
local v_u_12 = Color3.fromRGB(219, 159, 47)
local v_u_13 = Color3.fromRGB(43, 172, 43)
local v_u_14 = Color3.fromRGB(182, 45, 45)
local v_u_15 = nil
local v_u_16 = nil
function v_u_1.InitializeProgressBar(p17)
    if p17.Frame and p17.Frame.ProgressBar then
        local v18 = p17.Frame.ProgressBar
        local v19 = v18:FindFirstChild("LeftGradient")
        local v20 = v18:FindFirstChild("RightGradient")
        local v21 = v19:FindFirstChild("ProgressBarImage")
        local v22 = v20:FindFirstChild("ProgressBarImage")
        local v23 = v21:FindFirstChild("UIGradient")
        local v24 = v22:FindFirstChild("UIGradient")
        p17.LeftProgressImage = v21
        p17.RightProgressImage = v22
        p17.LeftGradient = v23
        p17.RightGradient = v24
        v21.ImageColor3 = v_u_14
        v22.ImageColor3 = v_u_14
        v21.ImageTransparency = 0
        v22.ImageTransparency = 0
        v19.Visible = true
        v20.Visible = true
        v21.Visible = true
        v22.Visible = true
        v23.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.5, 0),
            NumberSequenceKeypoint.new(0.501, 1),
            NumberSequenceKeypoint.new(1, 1)
        })
        v24.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.5, 0),
            NumberSequenceKeypoint.new(0.501, 1),
            NumberSequenceKeypoint.new(1, 1)
        })
        v23.Rotation = 0
        v24.Rotation = 0
    else
        warn("RescueHostage: Frame or ProgressBar not found")
    end
end
function v_u_1.UpdateProgressBar(p25, p26)
    if p25.Frame and p25.Frame.ProgressBar then
        if p25.LeftGradient and p25.RightGradient then
            if p25.LeftProgressImage and p25.RightProgressImage then
                local v27 = math.clamp(p26, 0, 1)
                local v28 = math.clamp(v27, 0, 1)
                local v29
                if v28 <= 0.5 then
                    v29 = v_u_14:Lerp(v_u_12, v28 * 2)
                else
                    v29 = v_u_12:Lerp(v_u_13, (v28 - 0.5) * 2)
                end
                p25.LeftProgressImage.ImageColor3 = v29
                p25.RightProgressImage.ImageColor3 = v29
                local v30 = v27 * 180
                p25.RightGradient.Rotation = 360 - v30
                p25.LeftGradient.Rotation = v30 + 180
                p25:AnimateRescue(v27)
                if p25.Frame.UIGradient then
                    local v31 = math.clamp(v27, 0, 1)
                    local v32
                    if v31 <= 0.5 then
                        v32 = v_u_14:Lerp(v_u_12, v31 * 2)
                    else
                        v32 = v_u_12:Lerp(v_u_13, (v31 - 0.5) * 2)
                    end
                    local v33 = v32:Lerp(Color3.new(0, 0, 0), 0.3)
                    p25.Frame.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v32), ColorSequenceKeypoint.new(1, v33) })
                end
                local v34 = math.clamp(v27, 0, 1)
                local v35
                if v34 <= 0.5 then
                    v35 = v_u_14:Lerp(v_u_12, v34 * 2)
                else
                    v35 = v_u_12:Lerp(v_u_13, (v34 - 0.5) * 2)
                end
                local v36 = v35:Lerp(Color3.new(0, 0, 0), 0.2)
                if p25.Frame.Frame1 then
                    p25.Frame.Frame1.BackgroundColor3 = v36
                end
                if p25.Frame.Frame2 then
                    p25.Frame.Frame2.BackgroundColor3 = v36
                end
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.AnimateRescue(p37, p38)
    if p37.Frame and p37.Frame.ProgressBar then
        local v39 = p37.Frame.ProgressBar:FindFirstChild("Hostage")
        if v39 then
            local v40 = tick() * (p38 * 0.5 + 0.5) * 3.141592653589793 * 2
            local v41 = math.sin(v40)
            local v42 = Vector2.new(0.85, 0.85)
            local v43 = v41 * 0.05 + 1
            local v44 = UDim2.new(v42.X * v43, 0, v42.Y * v43, 0)
            local v45 = Color3.fromRGB(255, 200, 0):Lerp(Color3.fromRGB(255, 255, 255), (v41 + 1) / 2)
            v39.Size = v44
            v39.ImageColor3 = v45
        end
    else
        return
    end
end
function v_u_1.UpdateTimer(p46, p47)
    if p46.Frame and p46.Frame.Timer then
        local v48 = p46.Frame.Timer
        local v49 = p47 / 60
        local v50 = math.floor(v49)
        local v51 = p47 % 60
        local v52 = math.floor(v51)
        local v53 = (v51 - v52) * 1000
        local v54 = math.floor(v53)
        v48.Text = string.format("%02d:%02d.%03d", v50, v52, v54)
        p46.Frame.Timer.TextStrokeColor3 = Color3.new(0, 0, 0)
        p46.Frame.Timer.TextColor3 = Color3.new(1, 1, 1)
        p46.Frame.Timer.TextStrokeTransparency = 0
    end
end
function v_u_1.UpdateTitle(p55)
    if p55.Frame and p55.Frame.Title then
        p55.Frame.Title.Text = string.format("%s is rescuing the hostage %s a kit.", p55.PlayerName, p55.HasRescueKit and "with" or "without")
        p55.Frame.Title.TextStrokeColor3 = Color3.new(0, 0, 0)
        p55.Frame.Title.TextColor3 = Color3.new(1, 1, 1)
        p55.Frame.Title.TextStrokeTransparency = 0
    end
end
function v_u_1.StartRescue(p_u_56, p57)
    if not p_u_56.IsRescuing then
        local v58 = v_u_11:GetAttribute("IsSpectating")
        local v59 = v_u_10.GetCurrentSpectateInstance()
        local v60 = p57 or (v58 and (v59 and v59.Player) or v_u_11)
        p_u_56.HasRescueKit = v60:GetAttribute("HasRescueKit")
        p_u_56.PlayerName = v60.Name
        p_u_56.RescueTime = p_u_56.HasRescueKit and 1 or 4
        local v61 = v60:GetAttribute("RescueStartTime")
        if v61 and (v58 or v60 ~= v_u_11) then
            local v62 = tick()
            if v61 <= v62 and v62 - v61 <= p_u_56.RescueTime then
                p_u_56.RescueStartTime = v61
            else
                p_u_56.RescueStartTime = v62
            end
        else
            p_u_56.RescueStartTime = tick()
        end
        p_u_56.RescueProgress = 0
        p_u_56.IsRescuing = true
        if p_u_56.Frame then
            p_u_56.Frame.Visible = true
        end
        p_u_56:UpdateProgressBar(0)
        p_u_56:UpdateTimer(p_u_56.RescueTime)
        p_u_56:UpdateTitle()
        p_u_56.Janitor:Add(v_u_3.Heartbeat:Connect(function()
            if p_u_56.IsRescuing and not p_u_56.IsFinished then
                local v63 = v_u_11:GetAttribute("IsSpectating")
                local v64 = v_u_10.GetCurrentSpectateInstance()
                if v63 then
                    if v64 then
                        v63 = p_u_56.PlayerName ~= v_u_11.Name
                    else
                        v63 = v64
                    end
                end
                if v63 and v64 then
                    local v65 = v64.Player
                    if not v65:GetAttribute("IsRescuingHostage") then
                        if p_u_56.RescueProgress >= 0.95 then
                            p_u_56:FinishRescue()
                        else
                            p_u_56:CancelRescue()
                        end
                    end
                    local v66 = v65:GetAttribute("RescueStartTime")
                    if v66 then
                        local v67 = tick()
                        if v66 < p_u_56.RescueStartTime and (v66 <= v67 and v67 - v66 <= p_u_56.RescueTime) then
                            p_u_56.RescueStartTime = v66
                        end
                    end
                end
                local v68 = tick() - p_u_56.RescueStartTime
                local v69 = p_u_56
                local v70 = v68 / p_u_56.RescueTime
                v69.RescueProgress = math.min(v70, 1)
                local v71 = p_u_56.RescueTime - v68
                local v72 = math.max(v71, 0)
                p_u_56:UpdateProgressBar(p_u_56.RescueProgress)
                p_u_56:UpdateTimer(v72)
                if p_u_56.RescueProgress >= 1 and not (p_u_56.IsFinished or v63) then
                    p_u_56:FinishRescue()
                end
            else
                return
            end
        end), "Disconnect", "ProgressConnection")
        if not v58 or v60 == v_u_11 then
            v_u_5.Hostage.StartRescue.Send()
        end
        p_u_56.RescueStarted:Fire()
    end
end
function v_u_1.CancelRescue(p_u_73)
    if p_u_73.IsRescuing then
        local v74 = v_u_11:GetAttribute("IsSpectating")
        local v75 = v_u_10.GetCurrentSpectateInstance()
        if v74 then
            if v75 then
                v75 = p_u_73.PlayerName ~= v_u_11.Name
            end
        else
            v75 = v74
        end
        p_u_73.IsRescuing = false
        p_u_73.IsFinished = true
        p_u_73:UpdateProgressBar(0)
        if p_u_73.Frame then
            p_u_73.Frame.Visible = false
        end
        if not v75 then
            v_u_5.Hostage.CancelRescue.Send()
        end
        p_u_73.RescueCancelled:Fire()
        task.defer(function()
            p_u_73:Destroy()
        end)
    end
end
function v_u_1.FinishRescue(p_u_76)
    if p_u_76.IsRescuing and not p_u_76.IsFinished then
        local v77 = v_u_11:GetAttribute("IsSpectating")
        local v78 = v_u_10.GetCurrentSpectateInstance()
        if v77 then
            if v78 then
                v78 = p_u_76.PlayerName ~= v_u_11.Name
            end
        else
            v78 = v77
        end
        p_u_76.IsFinished = true
        p_u_76.IsRescuing = false
        if not v78 then
            v_u_5.Hostage.PickedUp.Send()
        end
        p_u_76.RescueFinished:Fire()
        task.delay(0.5, function()
            p_u_76:Destroy()
        end)
    end
end
function v_u_1.new(p79)
    local v80 = v_u_1
    local v81 = setmetatable({}, v80)
    v81.Janitor = v_u_8.new()
    v81.Frame = p79
    v81.RightProgressImage = nil
    v81.LeftProgressImage = nil
    v81.RightGradient = nil
    v81.LeftGradient = nil
    v81.RescueTime = 4
    v81.HasRescueKit = false
    v81.RescueStartTime = 0
    v81.RescueProgress = 0
    v81.IsRescuing = false
    v81.IsFinished = false
    v81.PlayerName = ""
    v81.RescueCancelled = v81.Janitor:Add(v_u_9.new())
    v81.RescueFinished = v81.Janitor:Add(v_u_9.new())
    v81.RescueStarted = v81.Janitor:Add(v_u_9.new())
    if v81.Frame then
        v81.Frame.Visible = false
    end
    v81:InitializeProgressBar()
    return v81
end
function v_u_1.Destroy(p82)
    if v_u_16 == p82 then
        v_u_16 = nil
    end
    if p82.Frame then
        p82.Frame.Visible = false
    end
    p82.Janitor:Destroy()
end
function v_u_1.Initialize(_, p83)
    v_u_15 = p83
    v_u_7.ListenToState(function(_, p84)
        if (p84 == "Buy Period" or p84 == "Warmup") and v_u_16 then
            v_u_16:Destroy()
            v_u_16 = nil
        end
    end)
    v_u_6.observerRouter("Start Rescue Hostage", function()
        if not v_u_16 then
            v_u_16 = v_u_1.new(v_u_15)
        end
        if v_u_16 then
            v_u_16:StartRescue()
        end
        return nil
    end)
    v_u_6.observerRouter("Cancel Rescue Hostage", function()
        if v_u_16 then
            v_u_16:CancelRescue()
            v_u_16 = nil
        end
        return nil
    end)
    local v_u_85 = nil
    local function v_u_89()
        local v86 = v_u_11:GetAttribute("IsSpectating")
        local v87 = v_u_10.GetCurrentSpectateInstance()
        if v86 and v87 then
            local v88 = v87.Player
            if v88:GetAttribute("IsRescuingHostage") then
                if not v_u_16 then
                    v_u_16 = v_u_1.new(v_u_15)
                end
                if v_u_16 then
                    v_u_16:StartRescue(v88)
                    return
                end
            elseif v_u_16 then
                v_u_16:CancelRescue()
                v_u_16 = nil
                return
            end
        elseif v_u_16 and not v_u_11:GetAttribute("IsRescuingHostage") then
            v_u_16:CancelRescue()
            v_u_16 = nil
        end
    end
    v_u_11:GetAttributeChangedSignal("IsSpectating"):Connect(function()
        v_u_89()
    end)
    local function v_u_91()
        if v_u_85 then
            v_u_85:Disconnect()
            v_u_85 = nil
        end
        local v90 = v_u_10.GetCurrentSpectateInstance()
        if v90 then
            v_u_85 = v90.Player:GetAttributeChangedSignal("IsRescuingHostage"):Connect(function()
                v_u_89()
            end)
            v_u_89()
        end
    end
    v_u_10.ListenToSpectate:Connect(function(_)
        v_u_91()
    end)
    task.wait(0.1)
    v_u_91()
end
return v_u_1