local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v_u_5 = game:GetService("UserInputService")
local v_u_6 = game:GetService("CollectionService")
require(script:WaitForChild("Types"))
local v_u_7 = require(v2.Database.Security.Remotes)
local v_u_8 = require(v2.Database.Security.Router)
local v_u_9 = require(v2.Shared.Janitor)
local v_u_10 = require(v2.Packages.Signal)
local v_u_11 = require(v2.Controllers.SpectateController)
local v_u_12 = require(v2.Controllers.InputController)
local v13 = require(v2.Components.Common.GetUserPlatform)
local v_u_14 = v4.LocalPlayer
local v_u_15 = table.find(v13(), "Mobile")
if v_u_15 then
    v_u_15 = #v13() <= 1
end
local v_u_16 = nil
local v_u_17 = 0
local v_u_18 = Color3.fromRGB(219, 159, 47)
local v_u_19 = Color3.fromRGB(43, 172, 43)
local v_u_20 = Color3.fromRGB(182, 45, 45)
local v_u_21 = nil
local v_u_22 = nil
local function v_u_26(p23)
    if v_u_12 and (v_u_12.isActionActive and v_u_12.isActionActive("Use")) then
        return true
    end
    if p23 and #p23 > 0 then
        for _, v24 in ipairs(p23) do
            if typeof(v24) == "EnumItem" then
                local v25 = v24.EnumType
                if v25 == Enum.KeyCode then
                    if v_u_5:IsKeyDown(v24) then
                        return true
                    end
                elseif v25 == Enum.UserInputType and v_u_5:IsMouseButtonPressed(v24) then
                    return true
                end
            end
        end
    end
    return false
end
function v_u_1.InitializeProgressBar(p27)
    if p27.Frame and p27.Frame.ProgressBar then
        local v28 = p27.Frame.ProgressBar
        local v29 = v28:FindFirstChild("LeftGradient")
        local v30 = v28:FindFirstChild("RightGradient")
        local v31 = v29:FindFirstChild("ProgressBarImage")
        local v32 = v30:FindFirstChild("ProgressBarImage")
        local v33 = v31:FindFirstChild("UIGradient")
        local v34 = v32:FindFirstChild("UIGradient")
        p27.LeftProgressImage = v31
        p27.RightProgressImage = v32
        p27.LeftGradient = v33
        p27.RightGradient = v34
        v31.ImageColor3 = v_u_20
        v32.ImageColor3 = v_u_20
        v31.ImageTransparency = 0
        v32.ImageTransparency = 0
        v29.Visible = true
        v30.Visible = true
        v31.Visible = true
        v32.Visible = true
        v33.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.5, 0),
            NumberSequenceKeypoint.new(0.501, 1),
            NumberSequenceKeypoint.new(1, 1)
        })
        v34.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.5, 0),
            NumberSequenceKeypoint.new(0.501, 1),
            NumberSequenceKeypoint.new(1, 1)
        })
        v33.Rotation = 0
        v34.Rotation = 0
    else
        warn("DefuseBomb: Frame or ProgressBar not found")
    end
end
function v_u_1.UpdateProgressBar(p35, p36)
    if p35.Frame and p35.Frame.ProgressBar then
        if p35.LeftGradient and p35.RightGradient then
            if p35.LeftProgressImage and p35.RightProgressImage then
                local v37 = math.clamp(p36, 0, 1)
                local v38 = math.clamp(v37, 0, 1)
                local v39
                if v38 <= 0.5 then
                    v39 = v_u_20:Lerp(v_u_18, v38 * 2)
                else
                    v39 = v_u_18:Lerp(v_u_19, (v38 - 0.5) * 2)
                end
                p35.LeftProgressImage.ImageColor3 = v39
                p35.RightProgressImage.ImageColor3 = v39
                local v40 = v37 * 180
                p35.RightGradient.Rotation = 360 - v40
                p35.LeftGradient.Rotation = v40 + 180
                p35:AnimateBomb(v37)
                if p35.Frame.UIGradient then
                    local v41 = math.clamp(v37, 0, 1)
                    local v42
                    if v41 <= 0.5 then
                        v42 = v_u_20:Lerp(v_u_18, v41 * 2)
                    else
                        v42 = v_u_18:Lerp(v_u_19, (v41 - 0.5) * 2)
                    end
                    local v43 = v42:Lerp(Color3.new(0, 0, 0), 0.3)
                    p35.Frame.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v42), ColorSequenceKeypoint.new(1, v43) })
                end
                local v44 = math.clamp(v37, 0, 1)
                local v45
                if v44 <= 0.5 then
                    v45 = v_u_20:Lerp(v_u_18, v44 * 2)
                else
                    v45 = v_u_18:Lerp(v_u_19, (v44 - 0.5) * 2)
                end
                local v46 = v45:Lerp(Color3.new(0, 0, 0), 0.2)
                if p35.Frame.Frame1 then
                    p35.Frame.Frame1.BackgroundColor3 = v46
                end
                if p35.Frame.Frame2 then
                    p35.Frame.Frame2.BackgroundColor3 = v46
                end
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.AnimateBomb(p47, p48)
    if p47.Frame and p47.Frame.ProgressBar then
        local v49 = p47.Frame.ProgressBar:FindFirstChild("Bomb")
        if v49 then
            local v50 = tick() * (p48 * 0.5 + 0.5) * 3.141592653589793 * 2
            local v51 = math.sin(v50)
            local v52 = Vector2.new(0.5, 0.45)
            local v53 = v51 * 0.05 + 1
            local v54 = UDim2.new(v52.X * v53, 0, v52.Y * v53, 0)
            local v55 = Color3.fromRGB(255, 200, 0):Lerp(Color3.fromRGB(255, 255, 255), (v51 + 1) / 2)
            v49.Size = v54
            v49.ImageColor3 = v55
        end
    else
        return
    end
end
function v_u_1.UpdateTimer(p56, p57)
    if p56.Frame and p56.Frame.Timer then
        local v58 = p56.Frame.Timer
        local v59 = p57 / 60
        local v60 = math.floor(v59)
        local v61 = p57 % 60
        local v62 = math.floor(v61)
        local v63 = (v61 - v62) * 1000
        local v64 = math.floor(v63)
        v58.Text = string.format("%02d:%02d.%03d", v60, v62, v64)
        p56.Frame.Timer.TextStrokeColor3 = Color3.new(0, 0, 0)
        p56.Frame.Timer.TextColor3 = Color3.new(1, 1, 1)
        p56.Frame.Timer.TextStrokeTransparency = 0
    end
end
function v_u_1.UpdateTitle(p65)
    if p65.Frame and p65.Frame.Title then
        p65.Frame.Title.Text = string.format("%s is defusing the bomb %s a kit.", p65.PlayerName, p65.HasDefuseKit and "with" or "without")
        p65.Frame.Title.TextStrokeColor3 = Color3.new(0, 0, 0)
        p65.Frame.Title.TextColor3 = Color3.new(1, 1, 1)
        p65.Frame.Title.TextStrokeTransparency = 0
    end
end
function v_u_1.StartDefuse(p_u_66, p67)
    local v68 = v_u_14:GetAttribute("IsSpectating")
    local v69 = v_u_11.GetCurrentSpectateInstance()
    local v70 = p67 or (v68 and (v69 and v69.Player) or v_u_14)
    if p_u_66.IsDefusing and p_u_66.PlayerName == v70.Name then
        return
    else
        local v71 = v_u_6:GetTagged("Bomb")[1]
        local v72
        if v71 then
            v72 = (v71:GetAttribute("Defused") == true or v71:GetAttribute("Exploding") == true) and true or v71:GetAttribute("Exploded") == true
        else
            v72 = false
        end
        if not v72 then
            p_u_66.HasDefuseKit = v70:GetAttribute("HasDefuseKit") == true
            p_u_66.PlayerName = v70.Name
            p_u_66.DefuseTime = p_u_66.HasDefuseKit and 5 or 10
            local v73 = p_u_66.DefuseTime
            local v74 = v70:GetAttribute("DefuseStartTime")
            if typeof(v74) == "number" then
                local v75 = workspace:GetServerTimeNow()
                local v76 = v75 - v74
                if v74 > v75 or (v76 < 0 or v76 > math.max(v73, 12)) then
                    v74 = nil
                end
            else
                v74 = nil
            end
            p_u_66.DefuseStartTime = v74 or workspace:GetServerTimeNow()
            p_u_66.DefuseProgress = 0
            p_u_66.IsDefusing = true
            p_u_66.IsFinished = false
            p_u_66.HasSentDefuseRequest = false
            p_u_66.HasReceivedServerStartAck = false
            p_u_66.DefuseSessionId = nil
            p_u_66.UseKeybinds = nil
            if p_u_66.Frame then
                p_u_66.Frame.Visible = true
            end
            p_u_66:UpdateProgressBar(0)
            p_u_66:UpdateTimer(p_u_66.DefuseTime)
            p_u_66:UpdateTitle()
            p_u_66.Janitor:Add(v_u_3.Heartbeat:Connect(function()
                if p_u_66.IsDefusing and not p_u_66.IsFinished then
                    local v77 = v_u_6:GetTagged("Bomb")[1]
                    local v78
                    if v77 then
                        v78 = (v77:GetAttribute("Defused") == true or v77:GetAttribute("Exploding") == true) and true or v77:GetAttribute("Exploded") == true
                    else
                        v78 = false
                    end
                    if v78 then
                        if v77 and v77:GetAttribute("Defused") == true then
                            p_u_66:FinishDefuse(true)
                        else
                            p_u_66:CancelDefuse(true)
                        end
                    else
                        local v79 = v_u_14:GetAttribute("IsSpectating")
                        local v80 = v_u_11.GetCurrentSpectateInstance()
                        if v79 then
                            if v80 then
                                v79 = p_u_66.PlayerName ~= v_u_14.Name
                            else
                                v79 = v80
                            end
                        end
                        local v81 = v79 and v80 and v80.Player or v_u_14
                        local v82 = p_u_66.DefuseTime
                        local v83 = v81:GetAttribute("DefuseStartTime")
                        if typeof(v83) == "number" then
                            local v84 = workspace:GetServerTimeNow()
                            local v85 = v84 - v83
                            if v83 > v84 or (v85 < 0 or v85 > math.max(v82, 12)) then
                                v83 = nil
                            end
                        else
                            v83 = nil
                        end
                        if v83 then
                            local v86 = v83 - p_u_66.DefuseStartTime
                            if math.abs(v86) > 0.001 then
                                p_u_66.DefuseStartTime = v83
                            end
                        end
                        if v79 and v80 then
                            if not v80.Player:GetAttribute("IsDefusingBomb") then
                                if v77 and v77:GetAttribute("Defused") == true then
                                    p_u_66:FinishDefuse(true)
                                else
                                    p_u_66:CancelDefuse(true)
                                end
                            end
                        else
                            local v87 = v_u_14.Character
                            if v87 and (v87.PrimaryPart and (v77 and (v77.PrimaryPart and (v87.PrimaryPart.Position - v77.PrimaryPart.Position).Magnitude > 10))) then
                                p_u_66:CancelDefuse(false)
                                return
                            end
                            if not (v_u_15 or v_u_26(p_u_66.UseKeybinds)) then
                                p_u_66:CancelDefuse(false)
                                return
                            end
                        end
                        local v88
                        if v79 then
                            v88 = false
                        else
                            v88 = v_u_14:GetAttribute("IsDefusingBomb") == true
                            if v88 then
                                p_u_66.HasReceivedServerStartAck = true
                            end
                            if not v88 and (p_u_66.HasReceivedServerStartAck or p_u_66.HasSentDefuseRequest) then
                                if v77 and v77:GetAttribute("Defused") == true then
                                    p_u_66:FinishDefuse(true)
                                else
                                    p_u_66:CancelDefuse(true)
                                end
                            end
                        end
                        local v89 = workspace:GetServerTimeNow() - p_u_66.DefuseStartTime
                        local v90 = p_u_66
                        local v91 = v89 / p_u_66.DefuseTime
                        v90.DefuseProgress = math.min(v91, 1)
                        local v92 = p_u_66.DefuseTime - v89
                        local v93 = math.max(v92, 0)
                        p_u_66:UpdateProgressBar(p_u_66.DefuseProgress)
                        p_u_66:UpdateTimer(v93)
                        if not v79 and (p_u_66.DefuseProgress >= 1 and (not p_u_66.HasSentDefuseRequest and v88)) then
                            p_u_66.HasSentDefuseRequest = true
                            v_u_7.C4.Defused.Send()
                        end
                    end
                else
                    return
                end
            end), "Disconnect", "ProgressConnection")
            if not v68 or v70 == v_u_14 then
                v_u_17 = v_u_17 + 1
                p_u_66.DefuseSessionId = v_u_17
                v_u_7.C4.StartDefuse.Send({
                    ["SessionId"] = p_u_66.DefuseSessionId
                })
            end
            p_u_66.DefuseStarted:Fire()
        end
    end
end
function v_u_1.CancelDefuse(p_u_94, p95)
    if p_u_94.IsDefusing then
        local v96 = v_u_14:GetAttribute("IsSpectating")
        local v97 = v_u_11.GetCurrentSpectateInstance()
        if v96 then
            if v97 then
                v97 = p_u_94.PlayerName ~= v_u_14.Name
            end
        else
            v97 = v96
        end
        p_u_94.IsDefusing = false
        p_u_94.IsFinished = true
        p_u_94:UpdateProgressBar(0)
        if p_u_94.Frame then
            p_u_94.Frame.Visible = false
        end
        if not (p95 or v97) then
            v_u_7.C4.CancelDefuse.Send({
                ["SessionId"] = p_u_94.DefuseSessionId
            })
        end
        p_u_94.DefuseCancelled:Fire()
        task.defer(function()
            p_u_94:Destroy()
        end)
    end
end
function v_u_1.FinishDefuse(p_u_98, p99)
    if p_u_98.IsDefusing and not p_u_98.IsFinished then
        local v100 = v_u_14:GetAttribute("IsSpectating")
        local v101 = v_u_11.GetCurrentSpectateInstance()
        if v100 then
            if v101 then
                v101 = p_u_98.PlayerName ~= v_u_14.Name
            end
        else
            v101 = v100
        end
        p_u_98.IsFinished = true
        p_u_98.IsDefusing = false
        if not (p99 or v101) then
            v_u_7.C4.Defused.Send()
        end
        p_u_98.DefuseFinished:Fire()
        if p99 then
            task.defer(function()
                p_u_98:Destroy()
            end)
        else
            task.delay(0.5, function()
                p_u_98:Destroy()
            end)
        end
    else
        return
    end
end
function v_u_1.new(p102)
    local v103 = v_u_1
    local v104 = setmetatable({}, v103)
    v104.Janitor = v_u_9.new()
    v104.Frame = p102
    v104.RightProgressImage = nil
    v104.LeftProgressImage = nil
    v104.RightGradient = nil
    v104.LeftGradient = nil
    v104.DefuseTime = 10
    v104.HasDefuseKit = false
    v104.DefuseStartTime = 0
    v104.DefuseProgress = 0
    v104.IsDefusing = false
    v104.IsFinished = false
    v104.HasSentDefuseRequest = false
    v104.HasReceivedServerStartAck = false
    v104.PlayerName = ""
    v104.DefuseCancelled = v104.Janitor:Add(v_u_10.new())
    v104.DefuseFinished = v104.Janitor:Add(v_u_10.new())
    v104.DefuseStarted = v104.Janitor:Add(v_u_10.new())
    if v104.Frame then
        v104.Frame.Visible = false
    end
    v104:InitializeProgressBar()
    return v104
end
function v_u_1.Destroy(p105)
    if v_u_22 == p105 then
        v_u_22 = nil
    end
    if p105.Frame then
        p105.Frame.Visible = false
    end
    p105.Janitor:Destroy()
end
function v_u_1.Initialize(_, p106)
    v_u_21 = p106
    v_u_8.observerRouter("Start Defuse Bomb", function()
        if v_u_16 and workspace:GetServerTimeNow() < v_u_16 then
            return nil
        end
        local v107 = v_u_6:GetTagged("Bomb")[1]
        local v108
        if v107 then
            v108 = (v107:GetAttribute("Defused") == true or v107:GetAttribute("Exploding") == true) and true or v107:GetAttribute("Exploded") == true
        else
            v108 = false
        end
        if v108 then
            return nil
        end
        if not v_u_22 then
            v_u_22 = v_u_1.new(v_u_21)
        end
        if v_u_22 then
            v_u_22:StartDefuse()
        end
        return nil
    end)
    v_u_8.observerRouter("Cancel Defuse Bomb", function()
        if v_u_22 then
            v_u_22:CancelDefuse(false)
            v_u_22 = nil
        end
        return nil
    end)
    local v_u_109 = nil
    local function v_u_116()
        local v110 = v_u_14:GetAttribute("IsSpectating")
        local v111 = v_u_11.GetCurrentSpectateInstance()
        if v110 and v111 then
            local v112 = v111.Player
            local v113 = v112:GetAttribute("IsDefusingBomb")
            local v114 = v_u_6:GetTagged("Bomb")[1]
            local v115
            if v114 then
                v115 = (v114:GetAttribute("Defused") == true or v114:GetAttribute("Exploding") == true) and true or v114:GetAttribute("Exploded") == true
            else
                v115 = false
            end
            if v115 then
                if v_u_22 then
                    if v114 and v114:GetAttribute("Defused") == true then
                        v_u_22:FinishDefuse(true)
                    else
                        v_u_22:CancelDefuse(true)
                    end
                    v_u_22 = nil
                end
                return
            end
            if v113 then
                if not v_u_22 then
                    v_u_22 = v_u_1.new(v_u_21)
                end
                if v_u_22 then
                    v_u_22:StartDefuse(v112)
                    return
                end
            elseif v_u_22 then
                v_u_22:CancelDefuse(false)
                v_u_22 = nil
                return
            end
        elseif v_u_22 and not v_u_14:GetAttribute("IsDefusingBomb") then
            v_u_22:CancelDefuse(false)
            v_u_22 = nil
        end
    end
    v_u_14:GetAttributeChangedSignal("IsSpectating"):Connect(function()
        v_u_116()
    end)
    local function v_u_118()
        if v_u_109 then
            v_u_109:Disconnect()
            v_u_109 = nil
        end
        local v117 = v_u_11.GetCurrentSpectateInstance()
        if v117 then
            v_u_109 = v117.Player:GetAttributeChangedSignal("IsDefusingBomb"):Connect(function()
                v_u_116()
            end)
            v_u_116()
        end
    end
    v_u_11.ListenToSpectate:Connect(function(_)
        v_u_118()
    end)
    task.wait(0.1)
    v_u_118()
end
function v_u_1.SetDefuseBlockedUntil(p119)
    v_u_16 = p119
end
return v_u_1