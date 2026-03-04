local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = v4.LocalPlayer
local v_u_6 = v_u_5:WaitForChild("PlayerGui")
local v_u_7 = require(v2.Components.Common.GetWeaponProperties)
local v_u_8 = require(v2.Components.Common.VFXLibary.FlashEffect)
local v_u_9 = require(v2.Shared.Janitor)
local v_u_10 = require(v2.Database.Security.Remotes)
local v_u_11 = {
    "7",
    "73",
    "735",
    "7355",
    "73556",
    "735560",
    "7355608"
}
function v_u_1.getAnimation(p12, p13)
    return p12.Animations[p13]
end
function v_u_1.adjustAnimationSpeed(p14, p15, p16)
    local v17 = p14:getAnimation(p15)
    if v17 then
        v17:AdjustSpeed(v17.Length / p16)
    end
end
function v_u_1.play(p18, p19, ...)
    local v20 = p18:getAnimation(p19)
    p18.CurrentAnimation = p19
    if not v20 then
        return nil
    end
    v20:Play(...)
    return v20
end
function v_u_1.stop(p21, p22, p23)
    local v24 = p21:getAnimation(p22)
    if v24 and v24.IsPlaying then
        v24:Stop(p23 or 0)
    end
end
function v_u_1.cancelCrossfade(p25)
    if p25.CrossfadeConnection then
        p25.CrossfadeConnection:Disconnect()
        p25.CrossfadeConnection = nil
    end
    if p25.CrossfadeTempTrack then
        p25.CrossfadeTempTrack:Stop(0)
        p25.CrossfadeTempTrack:Destroy()
        p25.CrossfadeTempTrack = nil
    end
    p25.IsCrossfading = false
end
function v_u_1.isCrossfading(p26)
    return p26.IsCrossfading == true
end
function v_u_1.crossfadeRestart(p_u_27, p28, p29)
    local v_u_30 = p29 or 0.25
    p_u_27:cancelCrossfade()
    local v_u_31 = p_u_27:getAnimation(p28)
    if not v_u_31 then
        return nil
    end
    local v32 = v_u_31.WeightCurrent
    if not v_u_31.IsPlaying then
        v_u_31:Play(0, 1, 1)
        return v_u_31
    end
    local v_u_33 = math.max(v32, 0.5)
    local v_u_34 = v_u_31.Animation
    if not v_u_34 then
        v_u_31:Stop(0)
        v_u_31:Play(0, 1, 1)
        return v_u_31
    end
    local v35, v_u_36 = pcall(function()
        return p_u_27.Animator:LoadAnimation(v_u_34)
    end)
    if not (v35 and v_u_36) then
        v_u_31:Stop(0)
        v_u_31:Play(0, 1, 1)
        return v_u_31
    end
    local v_u_37 = p_u_27.Sound
    local v_u_40 = v_u_36.KeyframeReached:Connect(function(p38)
        if not p_u_27.IsDestroyed then
            local v39 = v_u_37.Sounds:FindFirstChild(p38)
            if v39 and #v39:GetChildren() > 0 then
                v_u_37:play({
                    ["Parent"] = game:GetService("Players").LocalPlayer.PlayerGui,
                    ["Name"] = p38
                })
            end
        end
    end)
    v_u_36:Play(0, 0.01, 1)
    v_u_36.TimePosition = 0
    p_u_27.CrossfadeTempTrack = v_u_36
    local v_u_41 = tick()
    p_u_27.CurrentAnimation = p28
    p_u_27.IsCrossfading = true
    p_u_27.CrossfadeConnection = v_u_3.RenderStepped:Connect(function()
        if p_u_27.IsDestroyed then
            v_u_40:Disconnect()
            p_u_27:cancelCrossfade()
        else
            local v42 = (tick() - v_u_41) / v_u_30
            local v43 = math.clamp(v42, 0, 1)
            local v44 = v43 * 3 * v43 - v43 * 2 * v43 * v43
            local v45 = v_u_33 * (1 - v44)
            local v46 = math.max(v44, 0.01)
            v_u_31:AdjustWeight(v45, 0)
            v_u_36:AdjustWeight(v46, 0)
            if v43 >= 1 then
                v_u_40:Disconnect()
                local v47 = v_u_36.TimePosition
                v_u_31:Stop(0)
                v_u_31:Play(0, 1, 1)
                v_u_31.TimePosition = v47
                v_u_31:AdjustWeight(1, 0)
                v_u_36:Stop(0)
                v_u_36:Destroy()
                p_u_27.CrossfadeTempTrack = nil
                p_u_27:cancelCrossfade()
            end
        end
    end)
    return v_u_31
end
function v_u_1.crossfadeTo(p_u_48, p49, p50)
    p_u_48:cancelCrossfade()
    local v_u_51 = {}
    local v_u_52 = p50 or 0.25
    for v53, v54 in pairs(p_u_48.Animations) do
        if v54.IsPlaying and (v53 ~= "Idle" and v53 ~= p49) then
            local v55 = {
                ["track"] = v54,
                ["startWeight"] = v54.WeightCurrent
            }
            table.insert(v_u_51, v55)
        end
    end
    local v_u_56 = p_u_48:getAnimation(p49)
    local v_u_57 = p49 == "Idle"
    if not (v_u_56 or v_u_57) then
        return nil
    end
    p_u_48.CurrentAnimation = p49
    p_u_48.IsCrossfading = true
    if v_u_56 and not v_u_57 then
        v_u_56:Play(0, 0, 1)
    end
    local v_u_58 = tick()
    p_u_48.CrossfadeConnection = v_u_3.RenderStepped:Connect(function()
        if p_u_48.IsDestroyed then
            p_u_48:cancelCrossfade()
        else
            local v59 = (tick() - v_u_58) / v_u_52
            local v60 = math.clamp(v59, 0, 1)
            local v61 = 1 - v60
            local v62 = v61 * 3 * v61 - v61 * 2 * v61 * v61
            for _, v63 in ipairs(v_u_51) do
                if v63.track then
                    v63.track:AdjustWeight(v63.startWeight * v62, 0)
                end
            end
            if v_u_56 and not v_u_57 then
                v_u_56:AdjustWeight(1 - v62, 0)
            end
            if v60 >= 1 then
                for _, v64 in ipairs(v_u_51) do
                    if v64.track and v64.track.IsPlaying then
                        v64.track:Stop(0)
                    end
                end
                if v_u_57 and v_u_56 then
                    v_u_56:Play(0, 1, 1)
                elseif v_u_56 then
                    v_u_56:AdjustWeight(1, 0)
                end
                p_u_48:cancelCrossfade()
            end
        end
    end)
    return v_u_56
end
function v_u_1.stopAnimations(p65, p66)
    p65:cancelCrossfade()
    for _, v67 in pairs(p65.Animations) do
        if v67.IsPlaying then
            v67:Stop(p66 or 0)
        end
    end
    p65:stopSounds()
end
function v_u_1.stopSounds(p68)
    for v69, v71 in pairs(p68.ActiveSounds) do
        if v71 then
            local v71 = string.find(v71, "Shoot") ~= nil
        end
        if not v71 then
            p68.ActiveSounds[v69] = nil
            if v69 and v69.Parent then
                v69:Destroy()
            end
        end
    end
end
function v_u_1.unregister(p72, p73)
    if p72.Animations[p73] then
        p72.Janitor:Remove("AnimationConnection_" .. p73)
        p72.Janitor:RemoveNoClean("AnimationCleanup_" .. p73)
        if p72.Animations[p73] then
            local v74 = p72.Animations[p73]
            p72.Animations[p73] = nil
            if v74.IsPlaying then
                v74:Stop()
            end
            v74:Destroy()
        end
    end
end
function v_u_1.unregisterGroup(p75, ...)
    for _, v76 in ipairs({ ... }) do
        p75:unregister(v76)
    end
end
function v_u_1.register(p_u_77, p_u_78, p_u_79)
    p_u_77:unregister(p_u_78)
    local v80, v81 = pcall(function()
        return p_u_77.Animator:LoadAnimation(p_u_79)
    end)
    if v80 then
        p_u_77.Animations[p_u_78] = v81
        local v_u_82 = p_u_77.Sound
        local v_u_83 = v_u_82.SoundGroupName
        local v_u_84 = v_u_82.Sounds
        local v_u_85 = p_u_77.Player
        local v_u_86 = setmetatable({}, {
            ["__mode"] = "v"
        })
        v_u_86.instance = p_u_77
        p_u_77.Janitor:Add(function()
            local v87 = v_u_86.instance
            if v87 and not v87.IsDestroyed then
                v87:unregister(p_u_78)
            end
        end, true, "AnimationCleanup_" .. p_u_78)
        local v95 = v81.KeyframeReached:Connect(function(p88)
            local v89 = v_u_84:FindFirstChild(p88)
            local v_u_90 = v_u_86.instance
            if v_u_90 and not v_u_90.IsDestroyed then
                local v91 = v_u_85.Character
                if v91 then
                    if v89 and #v89:GetChildren() > 0 then
                        local v_u_92 = v_u_82:play({
                            ["Parent"] = v_u_6,
                            ["Name"] = p88
                        }, (v_u_8.GetAudioFadeMultiplier()))
                        if v_u_92 then
                            v_u_90.ActiveSounds[v_u_92] = p_u_78
                            v_u_92.Ended:Once(function()
                                if v_u_90 and not v_u_90.IsDestroyed then
                                    v_u_90.ActiveSounds[v_u_92] = nil
                                end
                            end)
                        end
                        if v91:FindFirstChild("Head") then
                            local v93 = v91:WaitForChild("Head")
                            if p_u_78 == "Equip" or p_u_78 == "Inspect" then
                                return
                            end
                            if v_u_5 ~= v_u_85 then
                                return
                            end
                            local v94 = {
                                ["Parent"] = v93,
                                ["Class"] = v_u_83,
                                ["Name"] = p88
                            }
                            v_u_10.Sound.ReplicateSound.Send(v94)
                        end
                    end
                end
            else
                return
            end
        end)
        p_u_77.Janitor:Add(v95, "Disconnect", "AnimationConnection_" .. p_u_78)
    end
end
function v_u_1.construct(p96)
    local v97 = v_u_7(p96.Animation)
    if v97 then
        local v98 = v97.CameraAnimations
        if typeof(v98) == "Instance" and v98:IsA("Folder") then
            for _, v99 in ipairs(v98:GetChildren()) do
                if v99:IsA("Animation") then
                    p96:register(v99.Name, v99)
                end
            end
        end
    else
        return
    end
end
function v_u_1.setModel(p_u_100, p101)
    if p101 then
        p_u_100.Animation = p101.Name
        p_u_100.Animator = p101:WaitForChild("AnimationController"):WaitForChild("Animator")
        p_u_100:stopAnimations()
        p_u_100:construct()
        if p_u_100.Animation == "C4" then
            local v_u_102 = p101:FindFirstChild("Weapon")
            if v_u_102 then
                v_u_102 = p101.Weapon:FindFirstChild("Interactive")
            end
            if v_u_102 and v_u_102:FindFirstChild("SurfaceGui") then
                v_u_102.SurfaceGui.TextLabel.Text = "*******"
            end
            for _, v103 in pairs(p_u_100.Animations) do
                p_u_100.Janitor:Add(v103.KeyframeReached:Connect(function(p104)
                    if table.find(v_u_11, p104) then
                        if v_u_102 and v_u_102:FindFirstChild("SurfaceGui") then
                            v_u_102.SurfaceGui.TextLabel.Text = string.rep("*", 7 - #p104) .. p104
                        end
                        p_u_100.Sound:play({
                            ["Parent"] = v_u_5.PlayerGui,
                            ["Name"] = p104
                        })
                    end
                end))
            end
        end
    end
end
function v_u_1.new(_, p105, p106, p107)
    local v108 = v_u_1
    local v109 = setmetatable({}, v108)
    v109.Janitor = v_u_9.new()
    v109.IsDestroyed = false
    v109.IsCrossfading = false
    v109.CrossfadeConnection = nil
    v109.CrossfadeTempTrack = nil
    v109.Player = p105
    v109.ActiveSounds = {}
    v109.Animations = {}
    v109.CurrentAnimation = nil
    v109.Sound = p107
    if p106 then
        v109:setModel(p106)
    end
    return v109
end
function v_u_1.destroy(p110)
    if not p110.IsDestroyed then
        p110.IsDestroyed = true
        p110:cancelCrossfade()
        p110:stopAnimations()
        local v111 = {}
        for v112, _ in pairs(p110.Animations) do
            table.insert(v111, v112)
        end
        for _, v113 in ipairs(v111) do
            p110:unregister(v113)
        end
        p110:stopSounds()
        table.clear(p110.ActiveSounds)
        table.clear(p110.Animations)
        p110.CurrentAnimation = nil
        p110.Animation = nil
        p110.Animator = nil
        p110.Player = nil
        p110.Sound = nil
        p110.Janitor:Destroy()
        p110.Janitor = nil
    end
end
return v_u_1