local v_u_1 = {}
local v_u_2 = game:GetService("ContextActionService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = game:GetService("Lighting")
local v_u_7 = game:GetService("RunService")
local v_u_8 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui")
require(script:WaitForChild("Types"))
local v_u_9 = require(script:WaitForChild("SceneRegistry"))
local v10 = require(v_u_3.Shared.Janitor)
local v_u_11 = require(v_u_3.Controllers.MenuSceneController)
local v_u_12 = require(v_u_3.Controllers.CameraController)
local v_u_13 = require(v_u_3.Database.Security.Router)
local v_u_14 = require(v_u_3.Interface.MenuState)
local v_u_15 = require(v_u_3.Database.Custom.Constants)
local v_u_16 = workspace.CurrentCamera
local v_u_17 = false
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = v10.new()
local v_u_23 = false
local v_u_24 = nil
local v_u_25 = {}
local v_u_26 = false
local v_u_27 = nil
local v_u_28 = nil
local v_u_29 = 0
local v_u_30 = nil
local v_u_31 = {}
local v_u_32 = nil
local v_u_33 = nil
local function v_u_34(...) end
local v_u_35 = false
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = nil
local v_u_39 = 0
local v_u_40 = 1
local v_u_41 = 0
local v_u_42 = nil
local v_u_43 = false
local v_u_44 = false
local function v_u_50()
    v_u_14.EnterCaseScene()
    local v45 = v_u_14.GetMenuFrame()
    if v45 then
        v_u_17 = v_u_11.IsActive()
        if v_u_17 then
            v_u_11.HideMenuScene(true, true)
            v_u_11.SetMusicVolumeMultiplier(0.5, 0.5)
        end
        v_u_14.SetBlurEnabled(false)
        v45.BackgroundTransparency = 1
        local v46 = v45:FindFirstChild("Pattern")
        if v46 then
            v46.Visible = false
        end
        local v47 = v45:FindFirstChild("Top")
        if v47 then
            v47.Visible = false
        end
        local v48 = v45:FindFirstChild("Store")
        if v48 then
            v48.Visible = true
        end
        for _, v49 in v45:GetChildren() do
            if v49:IsA("Frame") and (v49.Name ~= "Top" and (v49.Name ~= "Store" and v49.Name ~= "OpenCase")) then
                v49.Visible = false
            end
        end
    end
end
local function v_u_54(p51)
    for _, v52 in p51:GetDescendants() do
        if v52:IsA("BasePart") then
            if v52.Transparency < 1 then
                v52:SetAttribute("_CaseScenePrevTransparency", v52.Transparency)
                v52.Transparency = 1
            end
        elseif v52:IsA("SurfaceGui") then
            if v52.Enabled then
                v52:SetAttribute("_CaseScenePrevSurfaceGuiEnabled", true)
                v52.Enabled = false
            end
        elseif v52:IsA("Texture") and v52.Transparency < 1 then
            v52:SetAttribute("_CaseScenePrevTransparency", v52.Transparency)
            v52.Transparency = 1
        end
    end
    local v53 = v_u_25
    table.insert(v53, p51)
end
local function v_u_57()
    v_u_25 = {}
    local v55 = v_u_20 and v_u_20.AssetFolder or nil
    for _, v56 in v_u_16:GetChildren() do
        if v56:IsA("Model") and v56.Name ~= v55 then
            v_u_54(v56)
        end
    end
end
local function v_u_62()
    for _, v58 in v_u_25 do
        if v58 and v58.Parent then
            for _, v59 in v58:GetDescendants() do
                if v59:IsA("BasePart") then
                    local v60 = v59:GetAttribute("_CaseScenePrevTransparency")
                    if v60 ~= nil then
                        v59.Transparency = v60
                        v59:SetAttribute("_CaseScenePrevTransparency", nil)
                    end
                elseif v59:IsA("SurfaceGui") then
                    if v59:GetAttribute("_CaseScenePrevSurfaceGuiEnabled") ~= nil then
                        v59.Enabled = true
                        v59:SetAttribute("_CaseScenePrevSurfaceGuiEnabled", nil)
                    end
                elseif v59:IsA("Texture") then
                    local v61 = v59:GetAttribute("_CaseScenePrevTransparency")
                    if v61 == nil then
                        v59.Transparency = 0.3
                    else
                        v59.Transparency = v61
                        v59:SetAttribute("_CaseScenePrevTransparency", nil)
                    end
                end
            end
        end
    end
    v_u_25 = {}
end
local function v_u_72()
    local v63 = v_u_14.GetMenuFrame()
    if v63 and v63.Visible then
        local v64 = v_u_14.GetScreenBeforeCaseScene()
        local v65 = v_u_17
        v_u_17 = false
        v_u_14.ExitCaseScene()
        if v65 then
            v_u_11.ShowMenuScene()
            v_u_11.SetMusicVolumeMultiplier(1, 0.5)
        else
            v_u_11.ApplyMapLighting()
        end
        local v66 = v63:FindFirstChild("Top")
        if v66 then
            v66.Visible = true
        end
        if v64 then
            local v67 = v63:FindFirstChild(v64)
            if v67 then
                v67.Visible = true
                local v68
                if v64 == "Dashboard" then
                    v68 = false
                else
                    v68 = v64 ~= "Play"
                end
                v_u_14.SetBlurEnabled(v68)
                v63.BackgroundTransparency = v68 and 0.15 or 1
                local v69 = v63:FindFirstChild("Pattern")
                if v69 then
                    v69.Visible = not v68
                    return
                end
            end
        else
            local v70 = v63:FindFirstChild("Dashboard")
            if v70 then
                v70.Visible = true
            end
            v_u_14.SetBlurEnabled(false)
            v63.BackgroundTransparency = 1
            local v71 = v63:FindFirstChild("Pattern")
            if v71 then
                v71.Visible = true
            end
        end
    else
        v_u_17 = false
        v_u_14.ExitCaseScene()
        v_u_11.ApplyMapLighting()
    end
end
local function v_u_80(p73, p74)
    local v75 = p73:FindFirstChild("CaseMod")
    if v75 and v75:GetAttribute("IsDynamicModel") then
        v75:Destroy()
    end
    local v76 = v_u_3.Assets:FindFirstChild("CaseModels")
    if v76 then
        local v77 = v76:FindFirstChild(p74)
        if v77 then
            local v78 = v77:Clone()
            v78.Name = "CaseMod"
            v78:SetAttribute("IsDynamicModel", true)
            local v79 = p73:FindFirstChild("CasePivot")
            if v79 then
                v78:PivotTo(v79.CFrame)
                v78.Parent = p73
                return v78
            else
                warn("[CaseSceneController]: CasePivot not found in CaseScene")
                v78.Parent = p73
                return v78
            end
        else
            warn("[CaseSceneController]: Case model not found for case: " .. p74)
            return nil
        end
    else
        warn("[CaseSceneController]: CaseModels folder not found in ReplicatedStorage.Assets")
        return nil
    end
end
local function v_u_86(p81, p82)
    local v83
    if p82.InteractionType == "Drag" then
        v83 = p81:FindFirstChild("Pack")
    else
        v83 = p81:FindFirstChild("CaseMod")
    end
    if not v83 then
        return nil
    end
    local v84 = v83:FindFirstChildOfClass("AnimationController")
    if not v84 then
        return nil
    end
    local v85 = v84:FindFirstChildOfClass("Animator")
    if not v85 then
        v85 = Instance.new("Animator")
        v85.Parent = v84
    end
    return v85
end
local function v_u_96(p87, p88, p89)
    local v90
    if p88.InteractionType == "Click" and p89 then
        local v91 = p89:FindFirstChildOfClass("AnimationController")
        v90 = not v91 or v91:FindFirstChildOfClass("Animator")
        if not v90 then
            v90 = Instance.new("Animator")
            v90.Parent = v91
        end
    else
        v90 = nil
    end
    local v92 = v90 or v_u_86(p87, p88)
    if v92 then
        v_u_32 = v92
        for v93, v94 in p88.Animations do
            if v94 then
                local v95 = Instance.new("Animation")
                v95.AnimationId = v94
                v_u_31[v93] = v92:LoadAnimation(v95)
                v95:Destroy()
            end
        end
    else
        warn("[CaseSceneController]: No animator found for scene")
    end
end
local function v_u_100(p97, p98)
    if p97 then
        for _, v99 in p97:GetDescendants() do
            if v99:IsA("Beam") or v99:IsA("ParticleEmitter") then
                v99.Enabled = p98
            end
        end
    end
end
local function v_u_102()
    local v101 = v_u_18
    if v101 then
        v101 = v_u_18:FindFirstChild("CaseMod")
    end
    if v101 then
        v_u_100(v101:FindFirstChild("IdleEffect"), true)
        v_u_100(v101:FindFirstChild("OpeningEffect"), false)
        v_u_100(v101:FindFirstChild("EffectsPart"), true)
    end
end
local function v_u_104()
    local v103 = v_u_18
    if v103 then
        v103 = v_u_18:FindFirstChild("CaseMod")
    end
    if v103 then
        v_u_100(v103:FindFirstChild("IdleEffect"), false)
        v_u_100(v103:FindFirstChild("OpeningEffect"), false)
        v_u_100(v103:FindFirstChild("EffectsPart"), false)
    end
end
local function v_u_109(p105, p106)
    for v107, v_u_108 in p106 do
        v_u_22:Add((p105:GetMarkerReachedSignal(v107):Connect(function()
            v_u_13.broadcastRouter("RunStoreSound", v_u_108)
        end)))
    end
end
local function v_u_116()
    if v_u_31.CaseFall and v_u_31.CloseIdle then
        v_u_102()
        local v110 = v_u_31.CaseFall
        local v111 = v_u_20 and v_u_20.AnimationKeyframeSounds
        if v111 then
            v111 = v_u_20.AnimationKeyframeSounds.CaseFall
        end
        if v111 then
            v_u_109(v110, v111)
        else
            local v_u_112 = v_u_20 and (v_u_20.Sounds and v_u_20.Sounds.Drop) or "Case Fall"
            v_u_22:Add((v110:GetMarkerReachedSignal("Dropped"):Connect(function()
                v_u_13.broadcastRouter("RunStoreSound", v_u_112)
            end)))
        end
        v_u_22:Add((v110:GetMarkerReachedSignal(v111 and v111.Drop and "Drop" or "Dropped"):Connect(function()
            local v113 = v_u_18 and v_u_18:FindFirstChild("DropParticle")
            if v113 then
                for _, v114 in v113:GetChildren() do
                    if v114:IsA("ParticleEmitter") then
                        local v115 = v114:GetAttribute("EmitCount")
                        if typeof(v115) == "number" and v115 > 0 then
                            v114:Emit(v115)
                        end
                    end
                end
            end
        end)))
        v110:Play()
        v_u_31.CloseIdle.Looped = true
        v_u_31.CloseIdle:Play()
    end
end
local function v_u_121()
    if v_u_31.CaseOpening then
        if v_u_31.CloseIdle then
            v_u_31.CloseIdle:Stop()
        end
        local v117 = v_u_31.CaseOpening
        local v118 = v_u_20 and v_u_20.AnimationKeyframeSounds
        if v118 then
            v118 = v_u_20.AnimationKeyframeSounds.CaseOpening
        end
        if v118 then
            v_u_109(v117, v118)
        else
            local v119 = v_u_20 and (v_u_20.Sounds and v_u_20.Sounds.Opening) or "Case Opening"
            v_u_13.broadcastRouter("RunStoreSound", v119)
        end
        local v120 = v_u_18
        if v120 then
            v120 = v_u_18:FindFirstChild("CaseMod")
        end
        if v120 then
            v_u_100(v120:FindFirstChild("OpeningEffect"), true)
            v_u_100(v120:FindFirstChild("IdleEffect"), false)
        end
        v117:Play()
        if v_u_31.OpenIdle then
            v_u_31.OpenIdle.Looped = true
            v_u_31.OpenIdle:Play()
        end
    end
end
local function v_u_123()
    for _, v122 in v_u_31 do
        if v122.IsPlaying then
            v122:Stop()
        end
    end
    if v_u_33 then
        v_u_33:Stop()
        v_u_33:Destroy()
        v_u_33 = nil
    end
end
local function v_u_131()
    v_u_34("finishCharmOpeningAndStartRoll called")
    if v_u_33 then
        v_u_33:Stop()
    end
    v_u_38 = nil
    if v_u_42 then
        v_u_42.Enabled = false
    end
    local v124 = v_u_8:FindFirstChild("CameraPerspective")
    if v124 then
        v124.Interactable = true
    end
    local v_u_125 = v_u_31.PackOpening
    v_u_34("  packOpeningTrack:", v_u_125 and "exists" or "nil")
    v_u_34("  CharmDragCallback:", v_u_36 and "exists" or "nil")
    if v_u_125 then
        local v126 = not (v_u_20 and (v_u_20.Sounds and v_u_20.Sounds.DragLoop)) and "Charm Drag Loop" or v_u_20.Sounds.DragLoop
        v_u_13.broadcastRouter("RunStoreSound", v126)
        if not v_u_125.IsPlaying then
            v_u_125:Play()
        end
        v_u_125:AdjustSpeed(1)
        v_u_125.Looped = false
        local v127 = v_u_125.Length - v_u_125.TimePosition - 0.1
        local v128 = math.max(0, v127)
        task.delay(v128, function()
            if v_u_125.IsPlaying then
                v_u_125:AdjustSpeed(0)
                v_u_125.TimePosition = v_u_125.Length * 0.99
                if v_u_36 then
                    local v129 = v_u_36
                    v_u_36 = nil
                    v129()
                end
            end
        end)
    else
        v_u_34("  No packOpeningTrack, calling callback directly")
        if v_u_36 then
            local v130 = v_u_36
            v_u_36 = nil
            v_u_34("  Calling CharmDragCallback")
            v130()
        end
    end
end
local function v_u_140(p132, p133)
    local v134 = v_u_31.PackOpening
    if v134 then
        local v135 = math.clamp(p132, 0, 1)
        local v136
        if v_u_41 > 0 then
            v136 = v_u_41
        else
            v136 = v134.Length
        end
        local v137 = v136 * v135
        if not v134.IsPlaying then
            v134:Play()
            v134:AdjustSpeed(0)
        end
        v134.TimePosition = v137
        if v135 >= 1 then
            v_u_35 = false
            v_u_131()
        end
        if v_u_33 and p133 then
            local v138 = not v_u_38 and 0 or (p133 - v_u_38).Magnitude
            v_u_38 = p133
            if v138 > 0.001 then
                v_u_39 = tick()
                if not v_u_33.IsPlaying then
                    v_u_33:Play()
                end
                local v139 = v138 * 20
                v_u_33.PlaybackSpeed = math.clamp(v139, 0, 0.7) + 0.8
            end
        end
    end
end
local function v_u_171(p141)
    if v_u_18 then
        local v_u_142 = v_u_18:FindFirstChild("Pack")
        if v_u_142 then
            local v_u_143 = v_u_142:FindFirstChild("Drag")
            if v_u_143 then
                local v_u_144 = v_u_143:FindFirstChildOfClass("DragDetector")
                if v_u_144 then
                    v_u_2:UnbindAction("Fire")
                    v_u_2:UnbindAction("Secondary Fire")
                    v_u_43 = true
                    v_u_36 = p141
                    v_u_35 = false
                    v_u_37 = v_u_143.Position
                    v_u_40 = v_u_144.MaxDragTranslation.Magnitude
                    if v_u_40 <= 0 then
                        v_u_40 = 1
                    end
                    local v_u_145 = v_u_31.PackOpening
                    if v_u_145 then
                        local v_u_146 = not (v_u_20 and (v_u_20.DragSettings and v_u_20.DragSettings.EndKeyframe)) and "DragEndPoint" or v_u_20.DragSettings.EndKeyframe
                        local v147, v148 = pcall(function()
                            return v_u_145:GetTimeOfKeyframe(v_u_146)
                        end)
                        if v147 and v148 then
                            v_u_41 = v148
                        else
                            v_u_41 = v_u_145.Length
                            warn("[CaseSceneController]: " .. v_u_146 .. " keyframe not found, using full animation length")
                        end
                    end
                    v_u_144.Enabled = true
                    local v149 = v_u_8:FindFirstChild("CameraPerspective")
                    if v149 then
                        v149.Interactable = false
                    end
                    local v150 = v_u_143:FindFirstChildOfClass("SurfaceGui")
                    if v150 then
                        v150.Enabled = true
                        v_u_42 = v150
                        local v151 = v150:FindFirstChildOfClass("Frame")
                        local v_u_152 = v151 and v151:FindFirstChildOfClass("ImageLabel")
                        if v_u_152 then
                            v_u_22:Add(v151.MouseEnter:Connect(function()
                                v_u_44 = true
                                v_u_152.ImageTransparency = 1
                            end), "Disconnect", "CharmImageHoverEnter")
                            v_u_22:Add(v151.MouseLeave:Connect(function()
                                v_u_44 = false
                                v_u_152.ImageTransparency = 0
                            end), "Disconnect", "CharmImageHoverLeave")
                            local v_u_153 = 0
                            v_u_22:Add(v_u_7.RenderStepped:Connect(function(p154)
                                if not v_u_44 then
                                    v_u_153 = v_u_153 + p154 * 2
                                    local v155 = v_u_153
                                    v_u_152.ImageTransparency = (math.sin(v155) + 1) / 2 * 0.2
                                end
                            end), "Disconnect", "CharmImageBreathing")
                        end
                    end
                    v_u_22:Add(v_u_144.DragStart:Connect(function()
                        v_u_35 = true
                        v_u_38 = v_u_143.Position
                        v_u_39 = tick()
                        if not v_u_33 then
                            local v156 = not (v_u_20 and (v_u_20.Sounds and v_u_20.Sounds.DragStart)) and "Charm Drag Start" or v_u_20.Sounds.DragStart
                            local v157 = require(v_u_3.Database.Audio.Store)[v156]
                            if v157 and (v157.Identifiers and v157.Identifiers[1]) then
                                local v158 = Instance.new("Sound")
                                v158.Name = "DragProgress"
                                v158.SoundId = "rbxassetid://" .. v157.Identifiers[1]
                                v158.Volume = v157.Properties.Volume or 1
                                v158.Looped = true
                                v158.PlaybackSpeed = 0.8
                                v158.Parent = v_u_142
                                v_u_33 = v158
                                v_u_22:Add(v158, "Destroy")
                            end
                        end
                    end), "Disconnect", "CharmDragStart")
                    v_u_22:Add(v_u_7.Heartbeat:Connect(function()
                        if v_u_35 and (v_u_33 and (v_u_33.IsPlaying and tick() - v_u_39 > 0.05)) then
                            v_u_33:Stop()
                        end
                    end), "Disconnect", "CharmDragSoundCheck")
                    v_u_22:Add(v_u_144.DragContinue:Connect(function()
                        if v_u_35 and v_u_37 then
                            local v159 = (v_u_143.Position - v_u_37).Magnitude / v_u_40
                            local v160 = math.clamp(v159, 0, 1)
                            if (not (v_u_20 and (v_u_20.DragSettings and v_u_20.DragSettings.Threshold)) and 0.5 or v_u_20.DragSettings.Threshold) <= v160 then
                                v_u_35 = false
                                v_u_144.Enabled = false
                                if v_u_37 then
                                    v_u_143.Position = v_u_37
                                end
                                v_u_131()
                            else
                                v_u_140(v160, v_u_143.Position)
                            end
                        else
                            return
                        end
                    end), "Disconnect", "CharmDragContinue")
                    v_u_22:Add(v_u_144.DragEnd:Connect(function()
                        if v_u_35 and v_u_37 then
                            v_u_35 = false
                            if v_u_33 then
                                v_u_33:Stop()
                            end
                            local v161 = (v_u_143.Position - v_u_37).Magnitude / v_u_40
                            local v162 = math.clamp(v161, 0, 1)
                            v_u_143.Position = v_u_37
                            local v163
                            if v_u_20 and (v_u_20.DragSettings and v_u_20.DragSettings.Threshold) then
                                local v164 = v_u_20.DragSettings.Threshold
                                v163 = math.max(v164, 0.8)
                            else
                                v163 = 0.8
                            end
                            if v163 <= v162 then
                                v_u_144.Enabled = false
                                v_u_131()
                            else
                                local v165 = v_u_31.PackOpening
                                if v165 then
                                    v165.TimePosition = 0
                                end
                                v_u_38 = nil
                            end
                        else
                            return
                        end
                    end), "Disconnect", "CharmDragEnd")
                    v_u_22:Add(v_u_4.InputBegan:Connect(function(p166, p167)
                        if v_u_23 and v_u_24 == "Unboxing" then
                            local v168 = p166.UserInputType == Enum.UserInputType.Gamepad1
                            local v169 = p166.UserInputType == Enum.UserInputType.Keyboard
                            if not (v169 and p167) then
                                if v168 then
                                    v168 = p166.KeyCode == Enum.KeyCode.ButtonX and true or p166.KeyCode == Enum.KeyCode.ButtonA
                                end
                                if v169 then
                                    v169 = p166.KeyCode == Enum.KeyCode.Return and true or p166.KeyCode == Enum.KeyCode.Space
                                end
                                if v168 or v169 then
                                    v_u_144.Enabled = false
                                    if v_u_35 then
                                        v_u_35 = false
                                        if v_u_37 then
                                            v_u_143.Position = v_u_37
                                        end
                                    end
                                    if v_u_33 then
                                        v_u_33:Stop()
                                    end
                                    local v170 = not (v_u_20 and (v_u_20.Sounds and v_u_20.Sounds.DragStart)) and "Charm Drag Start" or v_u_20.Sounds.DragStart
                                    v_u_13.broadcastRouter("RunStoreSound", v170)
                                    v_u_131()
                                end
                            end
                        else
                            return
                        end
                    end), "Disconnect", "CharmControllerSkip")
                else
                    warn("[CaseSceneController]: DragDetector not found on Drag part")
                end
            else
                warn("[CaseSceneController]: Drag part not found in Pack")
                return
            end
        else
            warn("[CaseSceneController]: Pack not found in CharmScene")
            return
        end
    else
        return
    end
end
function v_u_1.ShowCaseScene(p172, p173)
    v_u_34("ShowCaseScene called")
    v_u_34("  caseType:", p172 or "nil")
    v_u_34("  caseName:", p173 or "nil")
    v_u_34("  IsCaseSceneActive:", v_u_23)
    if v_u_23 then
        v_u_34("  BLOCKED: Scene already active")
        return
    else
        local v174 = v_u_9.GetSceneForCaseType(p172 or "Case")
        v_u_34("  sceneName:", v174)
        local v_u_175 = v_u_9.GetConfig(v174)
        if v_u_175 then
            v_u_34("  config.AssetFolder:", v_u_175.AssetFolder)
            v_u_34("  config.InteractionType:", v_u_175.InteractionType)
            v_u_19 = v174
            v_u_20 = v_u_175
            v_u_21 = p173
            local v176 = workspace:FindFirstChild(v_u_175.AssetFolder)
            if v176 then
                v_u_18 = v176
                local v177 = v_u_175.InteractionType == "Drag" and v176:FindFirstChild("Pack")
                if v177 then
                    local v178 = v177:FindFirstChild("Drag")
                    local v179 = v178 and v178:FindFirstChildOfClass("SurfaceGui")
                    if v179 then
                        v179.Enabled = false
                    end
                end
                v_u_24 = "Inspecting"
                local v180
                if v_u_18 then
                    local v181 = v_u_18:FindFirstChild("Camera")
                    if v181 then
                        v180 = v181:FindFirstChild("Inspecting")
                    else
                        v180 = nil
                    end
                else
                    v180 = nil
                end
                if v180 then
                    v_u_16.CameraType = Enum.CameraType.Scriptable
                    v_u_16.CFrame = v180.CFrame
                    v_u_16.Focus = v180.CFrame
                    v_u_50()
                    if not v_u_17 then
                        v_u_11.ApplyMenuSceneLighting()
                    end
                    local v182 = v176:FindFirstChild("CaseFog", true)
                    if v182 and v182:IsA("Atmosphere") then
                        for _, v183 in v_u_6:GetChildren() do
                            if v183:IsA("Atmosphere") then
                                v183:Destroy()
                            end
                        end
                        v182:Clone().Parent = v_u_6
                    end
                    v_u_57()
                    v_u_22:Add(v_u_16.ChildAdded:Connect(function(p184)
                        if p184:IsA("Model") and p184.Name ~= v_u_175.AssetFolder then
                            v_u_54(p184)
                        end
                    end), "Disconnect", "ViewmodelListener")
                    local v185
                    if p173 and v_u_175.InteractionType == "Click" then
                        v185 = v_u_80(v176, p173)
                    else
                        v185 = nil
                    end
                    v_u_96(v176, v_u_175, v185)
                    if v_u_175.InteractionType == "Click" then
                        v_u_116()
                    end
                    v_u_12.setFOVLock("CaseScene", true, 50)
                    v_u_12.setForceLockOverride("CaseScene", true)
                    v_u_7:BindToRenderStep("CaseSceneCameraUpdate", Enum.RenderPriority.Camera.Value + 10, function()
                        if v_u_18 then
                            v_u_16.CameraType = Enum.CameraType.Scriptable
                            if v_u_26 and (v_u_27 and v_u_28) then
                                local v186 = (tick() - v_u_29) / 0.8
                                local v187 = math.min(v186, 1)
                                v_u_16.CFrame = v_u_27:Lerp(v_u_28, (v_u_5:GetValue(v187, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)))
                                v_u_16.Focus = v_u_16.CFrame
                                if v187 >= 1 then
                                    v_u_26 = false
                                    v_u_16.CFrame = v_u_28
                                    if v_u_30 then
                                        local v188 = v_u_30
                                        v_u_30 = nil
                                        v188()
                                    end
                                    v_u_27 = nil
                                    v_u_28 = nil
                                    return
                                end
                            else
                                local v189 = v_u_24
                                local v190
                                if v_u_18 then
                                    local v191 = v_u_18:FindFirstChild("Camera")
                                    if v191 then
                                        if v189 == "Inspecting" then
                                            v190 = v191:FindFirstChild("Inspecting")
                                        elseif v189 == "Unboxing" then
                                            v190 = v191:FindFirstChild("Unboxing")
                                        else
                                            v190 = nil
                                        end
                                    else
                                        v190 = nil
                                    end
                                else
                                    v190 = nil
                                end
                                if v190 then
                                    v_u_16.CFrame = v190.CFrame
                                    v_u_16.Focus = v190.CFrame
                                end
                            end
                        end
                    end)
                    v_u_22:Add(function()
                        v_u_7:UnbindFromRenderStep("CaseSceneCameraUpdate")
                    end, true, "CameraUpdate")
                    v_u_22:Add(function()
                        v_u_34("CaseSceneCleanup running")
                        v_u_24 = nil
                        v_u_26 = false
                        v_u_27 = nil
                        v_u_28 = nil
                        v_u_30 = nil
                        v_u_104()
                        if v_u_43 then
                            v_u_13.broadcastRouter("RebindKeybinds")
                            v_u_43 = false
                        end
                        v_u_35 = false
                        v_u_36 = nil
                        v_u_37 = nil
                        v_u_38 = nil
                        v_u_39 = 0
                        v_u_40 = 1
                        v_u_41 = 0
                        v_u_42 = nil
                        v_u_44 = false
                        if v_u_18 then
                            local v192 = v_u_18:FindFirstChild("CaseMod")
                            if v192 and v192:GetAttribute("IsDynamicModel") then
                                v192:Destroy()
                            end
                        end
                        v_u_123()
                        v_u_31 = {}
                        v_u_32 = nil
                        v_u_34("CaseSceneCleanup complete")
                    end, true, "CaseSceneCleanup")
                    v_u_23 = true
                    v_u_34("ShowCaseScene complete, IsCaseSceneActive = true")
                else
                    warn("[CaseSceneController]: Scene missing Camera.Inspecting")
                    v_u_18 = nil
                    v_u_19 = nil
                    v_u_20 = nil
                    v_u_24 = nil
                end
            else
                warn("[CaseSceneController]: Scene not found in workspace: " .. v_u_175.AssetFolder)
                v_u_19 = nil
                v_u_20 = nil
                v_u_21 = nil
                return
            end
        else
            warn("[CaseSceneController]: No config found for scene: " .. v174)
            v_u_34("  BLOCKED: No config found")
            return
        end
    end
end
function v_u_1.TransitionToUnboxing(p_u_193)
    v_u_34("TransitionToUnboxing called")
    v_u_34("  IsCaseSceneActive:", v_u_23)
    v_u_34("  CurrentScene:", v_u_18 and "exists" or "nil")
    v_u_34("  CurrentSceneConfig:", v_u_20 and "exists" or "nil")
    v_u_34("  CurrentCaseSceneState:", v_u_24 or "nil")
    v_u_34("  callback:", p_u_193 and "provided" or "nil")
    if v_u_23 and (v_u_18 and v_u_20) then
        if v_u_24 == "Unboxing" then
            v_u_34("  BLOCKED: Already in Unboxing state")
            return
        else
            local v194
            if v_u_18 then
                local v195 = v_u_18:FindFirstChild("Camera")
                if v195 then
                    v194 = v195:FindFirstChild("Unboxing")
                else
                    v194 = nil
                end
            else
                v194 = nil
            end
            if v194 then
                v_u_34("  InteractionType:", v_u_20.InteractionType)
                if v_u_20.InteractionType == "Click" then
                    v_u_34("  Playing opening animations and starting camera lerp")
                    v_u_121()
                    local v196 = v_u_24
                    local v197
                    if v_u_18 then
                        local v198 = v_u_18:FindFirstChild("Camera")
                        if v198 then
                            if v196 == "Inspecting" then
                                v197 = v198:FindFirstChild("Inspecting")
                            elseif v196 == "Unboxing" then
                                v197 = v198:FindFirstChild("Unboxing")
                            else
                                v197 = nil
                            end
                        else
                            v197 = nil
                        end
                    else
                        v197 = nil
                    end
                    local v199
                    if v197 then
                        v199 = v197.CFrame
                    else
                        v199 = v_u_16.CFrame
                    end
                    v_u_26 = true
                    v_u_27 = v199
                    v_u_28 = v194.CFrame
                    v_u_29 = tick()
                    v_u_30 = p_u_193
                else
                    v_u_34("  Starting camera lerp, will setup drag detector after")
                    local function v200()
                        v_u_34("  Camera lerp complete, setting up drag detector")
                        v_u_171(p_u_193)
                    end
                    local v201 = v_u_24
                    local v202
                    if v_u_18 then
                        local v203 = v_u_18:FindFirstChild("Camera")
                        if v203 then
                            if v201 == "Inspecting" then
                                v202 = v203:FindFirstChild("Inspecting")
                            elseif v201 == "Unboxing" then
                                v202 = v203:FindFirstChild("Unboxing")
                            else
                                v202 = nil
                            end
                        else
                            v202 = nil
                        end
                    else
                        v202 = nil
                    end
                    local v204
                    if v202 then
                        v204 = v202.CFrame
                    else
                        v204 = v_u_16.CFrame
                    end
                    v_u_26 = true
                    v_u_27 = v204
                    v_u_28 = v194.CFrame
                    v_u_29 = tick()
                    v_u_30 = v200
                end
                v_u_24 = "Unboxing"
                v_u_34("  TransitionToUnboxing complete, CurrentCaseSceneState = Unboxing")
            else
                warn("[CaseSceneController]: Scene missing Camera.Unboxing")
                v_u_34("  BLOCKED: Missing Camera.Unboxing")
            end
        end
    else
        v_u_34("  BLOCKED: Scene not active or missing config")
        return
    end
end
function v_u_1.TransitionToInspecting(p205)
    if v_u_23 and v_u_18 then
        if v_u_24 == "Inspecting" then
            return
        else
            local v206
            if v_u_18 then
                local v207 = v_u_18:FindFirstChild("Camera")
                if v207 then
                    v206 = v207:FindFirstChild("Inspecting")
                else
                    v206 = nil
                end
            else
                v206 = nil
            end
            if v206 then
                local v208 = v_u_24
                local v209
                if v_u_18 then
                    local v210 = v_u_18:FindFirstChild("Camera")
                    if v210 then
                        if v208 == "Inspecting" then
                            v209 = v210:FindFirstChild("Inspecting")
                        elseif v208 == "Unboxing" then
                            v209 = v210:FindFirstChild("Unboxing")
                        else
                            v209 = nil
                        end
                    else
                        v209 = nil
                    end
                else
                    v209 = nil
                end
                local v211
                if v209 then
                    v211 = v209.CFrame
                else
                    v211 = v_u_16.CFrame
                end
                v_u_26 = true
                v_u_27 = v211
                v_u_28 = v206.CFrame
                v_u_29 = tick()
                v_u_30 = p205
                v_u_24 = "Inspecting"
            else
                warn("[CaseSceneController]: Scene missing Camera.Inspecting")
            end
        end
    else
        return
    end
end
function v_u_1.HideCaseScene(p212)
    v_u_34("HideCaseScene called")
    v_u_34("  IsCaseSceneActive:", v_u_23)
    v_u_34("  skipFrameRestore:", p212 or false)
    if v_u_23 then
        v_u_34("  Running CaseSceneJanitor:Cleanup()")
        v_u_22:Cleanup()
        v_u_16.CameraType = Enum.CameraType.Custom
        v_u_12.setFOVLock("CaseScene", false)
        v_u_12.updateCameraFOV(v_u_15.DEFAULT_CAMERA_FOV)
        local v213 = require(v_u_3.Controllers.SpectateController).GetCurrentSpectateInstance()
        if v213 then
            v213:UpdateScopeState()
        end
        v_u_12.setForceLockOverride("CaseScene", false)
        if p212 then
            v_u_14.ExitCaseScene()
            v_u_17 = false
        else
            v_u_72()
        end
        v_u_62()
        v_u_18 = nil
        v_u_19 = nil
        v_u_20 = nil
        v_u_21 = nil
        v_u_23 = false
        v_u_24 = nil
        v_u_34("HideCaseScene complete, IsCaseSceneActive = false")
    else
        v_u_34("  BLOCKED: Scene not active")
    end
end
function v_u_1.IsActive()
    return v_u_23
end
function v_u_1.GetCurrentState()
    return v_u_24
end
function v_u_1.GetSceneName()
    return v_u_19
end
function v_u_1.GetSceneConfig()
    return v_u_20
end
function v_u_1.ApplyCaseSceneLighting()
    if v_u_23 and v_u_18 then
        v_u_11.ApplyMenuSceneLighting()
        local v214 = v_u_18:FindFirstChild("CaseFog", true)
        if v214 and v214:IsA("Atmosphere") then
            for _, v215 in v_u_6:GetChildren() do
                if v215:IsA("Atmosphere") then
                    v215:Destroy()
                end
            end
            v214:Clone().Parent = v_u_6
        end
    else
        return
    end
end
function v_u_1.WaitForOpeningAnimation()
    local v216 = v_u_31.CaseOpening
    if v216 then
        if v216.IsPlaying then
            v216.Stopped:Wait()
        end
    end
end
function v_u_1.Initialize()
    local v_u_217 = v_u_3:FindFirstChild("Assets")
    if v_u_217 then
        local function v223(p218)
            local v219 = v_u_217:FindFirstChild(p218)
            if not v219 then
                return
            end
            local v220 = nil
            for _, v221 in v219:GetChildren() do
                if v221:IsA("Model") then
                    v220 = v221
                    break
                end
            end
            if v220 then
                local v222 = v220:Clone()
                v222.Name = p218
                v222.Parent = workspace
            else
                warn("[CaseSceneController]: No model found in Assets." .. p218)
            end
        end
        for _, v224 in v_u_9.GetAllSceneNames() do
            local v225 = v_u_9.GetConfig(v224)
            if v225 then
                v223(v225.AssetFolder)
            end
        end
        v_u_4.InputBegan:Connect(function(p226, p227)
            if not p227 then
                if p226.KeyCode == Enum.KeyCode.Escape and v_u_23 then
                    v_u_1.HideCaseScene()
                end
            end
        end)
        v_u_13.observerRouter("CaseSceneShow", function(p228, p229)
            v_u_1.ShowCaseScene(p228, p229)
        end)
        v_u_13.observerRouter("CaseSceneUnboxing", function(p230)
            v_u_1.TransitionToUnboxing(p230)
        end)
        v_u_13.observerRouter("CaseSceneClose", function()
            v_u_1.HideCaseScene()
        end)
        v_u_13.observerRouter("CaseSceneCloseForGameEnd", function()
            v_u_1.HideCaseScene(true)
        end)
    else
        warn("[CaseSceneController]: Assets folder not found in ReplicatedStorage")
    end
end
function v_u_1.Start() end
v_u_13.observerRouter("IsCaseSceneRolling", function()
    local v231 = v_u_1.IsActive()
    if v231 then
        v231 = v_u_1.GetCurrentState() == "Unboxing"
    end
    return v231
end)
return v_u_1