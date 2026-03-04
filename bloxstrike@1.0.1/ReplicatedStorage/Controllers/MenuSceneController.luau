local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("Lighting")
local v6 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_7 = require(v_u_2.Packages.Observers)
local v8 = require(v_u_2.Shared.Janitor)
local v_u_9 = require(v_u_2.Controllers.CameraController)
local v_u_10 = require(v_u_2.Controllers.DataController)
local v_u_11 = nil
local v_u_12 = require(v_u_2.Classes.Sound)
local v_u_13 = require(v_u_2.Database.Custom.Constants)
local v_u_14 = v6.LocalPlayer
local v_u_15 = v_u_14:WaitForChild("PlayerGui")
local v_u_16 = workspace.CurrentCamera
local v_u_17 = nil
local v_u_18 = v_u_2.Assets.Lighting
local v_u_19 = v_u_2.Database.Custom.GameStats.Maps
local v_u_20 = v_u_2.Assets.Characters
local v_u_21 = {
    ["CT"] = {
        ["Entrance"] = "rbxassetid://96240248165206",
        ["Idle"] = "rbxassetid://77870220857645"
    },
    ["T"] = {
        ["Entrance"] = "rbxassetid://100747011940776",
        ["Idle"] = "rbxassetid://99540873384647"
    }
}
local v_u_22 = {
    ["CT"] = {
        ["Character"] = "IDF",
        ["Weapon"] = "M4A1-S",
        ["Glove"] = "CT Glove"
    },
    ["T"] = {
        ["Character"] = "Anarchist",
        ["Weapon"] = "AK-47",
        ["Glove"] = "T Glove"
    }
}
local v_u_23 = require(v_u_2.Database.Components.Common.AttachGlovesToCharacter)
local v_u_24 = nil
local v_u_25 = nil
local v_u_26 = nil
local v_u_27 = nil
local v_u_28 = v8.new()
local v_u_29 = false
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = 1
local v_u_33 = nil
local v_u_34 = nil
local function v_u_43()
    local v35 = workspace:FindFirstChild("Map")
    if v35 then
        local v36 = v35:GetAttribute("MapName")
        if v36 and typeof(v36) == "string" then
            local v37 = v_u_19:FindFirstChild(v36)
            if v37 and v37:IsA("ModuleScript") then
                local v38 = require(v37)
                if v38.Lighting then
                    local v39 = v38.Lighting.Properties
                    if v39 then
                        v_u_34 = v39.GlobalShadows
                        v_u_5.Ambient = v39.Ambient
                        v_u_5.Brightness = v39.Brightness
                        v_u_5.ColorShift_Bottom = v39.ColorShift_Bottom
                        v_u_5.ColorShift_Top = v39.ColorShift_Top
                        v_u_5.EnvironmentDiffuseScale = v39.EnvironmentDiffuseScale
                        v_u_5.EnvironmentSpecularScale = v39.EnvironmentSpecularScale
                        v_u_5.GlobalShadows = v39.GlobalShadows
                        v_u_5.OutdoorAmbient = v39.OutdoorAmbient
                        v_u_5.ShadowSoftness = v39.ShadowSoftness
                        v_u_5.ClockTime = v39.ClockTime
                        v_u_5.GeographicLatitude = v39.GeographicLatitude
                        v_u_5.ExposureCompensation = v39.ExposureCompensation
                    end
                    for _, v40 in ipairs(v_u_5:GetChildren()) do
                        if v40.Name ~= "Menu" then
                            v40:Destroy()
                        end
                    end
                    local v41 = v38.Lighting.Assets
                    if v41 then
                        for _, v42 in ipairs(v41:GetChildren()) do
                            v42:Clone().Parent = v_u_5
                        end
                    end
                    if v_u_10.Get(v_u_14, "Settings.Video.Presets.Global Shadows") ~= false then
                        if v_u_34 ~= nil then
                            v_u_5.GlobalShadows = v_u_34
                        end
                    else
                        v_u_5.GlobalShadows = false
                    end
                else
                    return
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_51(p44)
    local v45 = v_u_18:FindFirstChild(p44)
    if v45 then
        local v46 = v_u_19:FindFirstChild(p44)
        if v46 and v46:IsA("ModuleScript") then
            local v47 = require(v46)
            if v47.Lighting and v47.Lighting.Properties then
                local v48 = v47.Lighting.Properties
                v_u_34 = v48.GlobalShadows
                v_u_5.Ambient = v48.Ambient
                v_u_5.Brightness = v48.Brightness
                v_u_5.ColorShift_Bottom = v48.ColorShift_Bottom
                v_u_5.ColorShift_Top = v48.ColorShift_Top
                v_u_5.EnvironmentDiffuseScale = v48.EnvironmentDiffuseScale
                v_u_5.EnvironmentSpecularScale = v48.EnvironmentSpecularScale
                v_u_5.GlobalShadows = v48.GlobalShadows
                v_u_5.OutdoorAmbient = v48.OutdoorAmbient
                v_u_5.ShadowSoftness = v48.ShadowSoftness
                v_u_5.ClockTime = v48.ClockTime
                v_u_5.GeographicLatitude = v48.GeographicLatitude
                v_u_5.ExposureCompensation = v48.ExposureCompensation
            end
        end
        for _, v49 in ipairs(v_u_5:GetChildren()) do
            if v49.Name ~= "Menu" then
                v49:Destroy()
            end
        end
        for _, v50 in ipairs(v45:GetChildren()) do
            v50:Clone().Parent = v_u_5
        end
        if v_u_10.Get(v_u_14, "Settings.Video.Presets.Global Shadows") ~= false then
            if v_u_34 ~= nil then
                v_u_5.GlobalShadows = v_u_34
            end
        else
            v_u_5.GlobalShadows = false
        end
    else
        warn((("[MenuSceneController]: No lighting found for scene \"%*\""):format(p44)))
        return
    end
end
local function v_u_65()
    local v52 = require(v_u_2.Interface.MenuState)
    if v_u_11 and v_u_11.IsActive() then
        return false
    end
    if v52.IsInspectActive() then
        return false
    end
    if workspace:FindFirstChild("InspectScene") then
        return false
    end
    local v53 = v_u_15:FindFirstChild("MainGui")
    if v53 then
        local v54 = v53:FindFirstChild("Gameplay")
        if v54 then
            v54 = v54:FindFirstChild("Middle")
        end
        if v54 then
            v54 = v54:FindFirstChild("TeamSelection")
        end
        if v54 and v54.Visible then
            return false
        end
    end
    local v55 = v_u_14:GetAttribute("IsSpectating")
    local v56 = v_u_14:GetAttribute("Team")
    local v57 = require(v_u_2.Database.Components.GameState).GetState()
    if v57 == "Game Ending" or v57 == "Map Voting" then
        if v56 == "Counter-Terrorists" or v56 == "Terrorists" then
            return false
        end
        local v58 = v_u_14.Character
        local v59
        if v58 and v58:IsDescendantOf(workspace) then
            local v60 = v58:FindFirstChild("Humanoid")
            v59 = v60 and v60.Health > 0 and true or false
        else
            v59 = false
        end
        return not v59
    end
    if v56 == "Counter-Terrorists" or v56 == "Terrorists" then
        return false
    end
    local v61 = v_u_14.Character
    local v62
    if v61 and v61:IsDescendantOf(workspace) then
        local v63 = v61:FindFirstChild("Humanoid")
        v62 = v63 and v63.Health > 0 and true or false
    else
        v62 = false
    end
    local v64 = not v62
    if v64 then
        v64 = not v55
    end
    return v64
end
local function v_u_84(p66, p67, p68)
    local v69 = require(v_u_2.Database.Components.Libraries.Skins)
    local v70 = nil
    local v71 = nil
    local v72 = nil
    if p68 then
        local v73 = p67 == "CT" and "Counter-Terrorists" or "Terrorists"
        v_u_10.WaitForDataLoaded(v_u_14)
        local v74 = v_u_10.Get(v_u_14, "Loadout")
        if v74 and (type(v74) == "table" and v74[v73]) then
            local v75 = v74[v73]
            if v75 and (type(v75) == "table" and v75.Equipped) then
                local v76 = v75.Equipped["Equipped Gloves"]
                if v76 and (v76 ~= "" and type(v76) == "string") then
                    local v77 = v_u_10.Get(v_u_14, "Inventory")
                    if v77 and type(v77) == "table" then
                        for _, v78 in ipairs(v77) do
                            if v78 and v78._id == v76 then
                                v70 = v78.Name
                                v71 = v78.Skin
                                v72 = v78.Float
                                p66:SetAttribute("EquippedGloves", game:GetService("HttpService"):JSONEncode({
                                    ["SkinIdentifier"] = v76
                                }))
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    local v79 = v70 or v_u_22[p67].Glove
    local v80
    if v71 and (v72 and v79) then
        v80 = v69.GetGloves(v79, v71, v72)
    else
        v80 = nil
    end
    local v81 = v80 or v_u_2:WaitForChild("Assets"):WaitForChild("Weapons"):FindFirstChild(v79)
    if v81 then
        local v82 = p66:FindFirstChild("CharacterArmor")
        if not v82 then
            v82 = Instance.new("Folder")
            v82.Name = "CharacterArmor"
            v82.Parent = p66
        end
        local v83
        if v80 then
            v83 = v80:GetChildren()
        else
            if not v81 then
                warn((("[MenuSceneController]: No glove model or folder available for \"%*\""):format(v79)))
                return
            end
            v83 = v81:GetChildren()
        end
        v_u_23(v83, p66, v82)
        if v80 and v80.Name == "" then
            v80:Destroy()
        end
    else
        warn((("[MenuSceneController]: Glove folder not found for \"%*\""):format(v79)))
    end
end
local function v_u_113(p85, p86, p87)
    local v88 = require(v_u_2.Database.Components.Libraries.Skins)
    local v89 = nil
    local v90 = nil
    local v91 = nil
    local v92 = nil
    local v93 = nil
    if p87 then
        local v94 = p86 == "CT" and "Counter-Terrorists" or "Terrorists"
        local v95 = p86 == "CT" and "M4A1-S" or "AK-47"
        v_u_10.WaitForDataLoaded(v_u_14)
        local v96 = v_u_10.Get(v_u_14, "Loadout")
        local v97 = v_u_10.Get(v_u_14, "Inventory")
        if v96 and (type(v96) == "table" and v96[v94]) then
            local v98 = v96[v94]
            if v98 and (type(v98) == "table" and v98.Loadout) then
                local v99 = v98.Loadout.Rifles
                if v99 and v99.Options then
                    local v100 = v99.Options
                    if type(v100) == "table" and (v97 and type(v97) == "table") then
                        for _, v101 in ipairs(v99.Options) do
                            if v101 and (v101 ~= "" and type(v101) == "string") then
                                for _, v102 in ipairs(v97) do
                                    if v102 and (v102._id == v101 and v102.Name == v95) then
                                        v89 = v102.Name
                                        v90 = v102.Skin
                                        v91 = v102.Float
                                        v92 = v102.StatTrack
                                        v93 = v102.NameTag
                                        break
                                    end
                                end
                                if v89 then
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    local v103 = v89 or v_u_22[p86].Weapon
    if v103 then
        local v104
        if v90 and (typeof(v90) == "string" and (v90 ~= "" and v103)) then
            v104 = v88.GetCharacterModel(v103, v90, v91, v92, v93)
        else
            v104 = nil
        end
        local v105 = v104 or v88.GetBaseWeaponModel(v103, "Character")
        if v105 then
            v105.Name = v103
            local v106 = p85:FindFirstChild("RightHand")
            if v106 then
                if not v105.PrimaryPart then
                    local v107 = v105:FindFirstChild("Weapon")
                    if v107 then
                        v107 = v107:FindFirstChild("Insert")
                    end
                    if not v107 then
                        warn("[MenuSceneController]: Weapon model has no PrimaryPart or Insert")
                        v105:Destroy()
                        return
                    end
                    v105.PrimaryPart = v107
                end
                for _, v108 in ipairs(v105:GetDescendants()) do
                    if v108:IsA("BasePart") then
                        v108.CanCollide = false
                        v108.CanQuery = false
                        v108.CanTouch = false
                        v108.Anchored = false
                        v108.Massless = true
                    end
                end
                v105.Parent = p85
                local v109 = Instance.new("Motor6D")
                v109.Name = "WeaponAttachment"
                v109.Part0 = v106
                v109.Part1 = v105.PrimaryPart
                v109.Parent = v106
                if v103 == "AK-47" then
                    v109.C0 = CFrame.new(-0.251, 0.806, -0.406) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966)
                    return v105
                end
                local v110 = v105:FindFirstChild("Properties")
                if v110 then
                    local v111 = v110:FindFirstChild("C0")
                    if v111 then
                        v109.C0 = v111.Value
                    end
                    local v112 = v110:FindFirstChild("C1")
                    if v112 then
                        v109.C1 = v112.Value
                    end
                end
                return v105
            end
            warn("[MenuSceneController]: Character missing RightHand")
            v105:Destroy()
        else
            warn((("[MenuSceneController]: Failed to get weapon model for \"%*\""):format(v103)))
        end
    else
        warn("[MenuSceneController]: No weapon name available")
        return
    end
end
local function v_u_127(p114)
    local v115 = p114:FindFirstChild("PlayerPart")
    if v115 then
        local v116 = math.random(1, 2) == 1 and "CT" or "T"
        local v117 = v_u_22[v116]
        local v118 = v_u_21[v116]
        local v119 = v_u_20:FindFirstChild(v117.Character)
        if v119 then
            local v120 = v119:Clone()
            v120.Name = "MenuCharacter"
            v_u_25 = v120
            v_u_26 = v116
            if v120:FindFirstChild("HumanoidRootPart") then
                v120:PivotTo(v115.CFrame)
            end
            v120.Parent = p114
            v_u_27 = v_u_113(v120, v116, true)
            v_u_84(v120, v116, true)
            local v121 = v120:FindFirstChild("Humanoid")
            if v121 then
                local v122 = v121:FindFirstChildOfClass("Animator")
                if not v122 then
                    v122 = Instance.new("Animator")
                    v122.Parent = v121
                end
                local v123 = Instance.new("Animation")
                v123.AnimationId = v118.Entrance
                local v124 = Instance.new("Animation")
                v124.AnimationId = v118.Idle
                local v125 = v122:LoadAnimation(v123)
                local v_u_126 = v122:LoadAnimation(v124)
                v_u_28:Add(v123, "Destroy", "EntranceAnimation")
                v_u_28:Add(v124, "Destroy", "IdleAnimation")
                v_u_28:Add(v125, "Stop", "EntranceTrack")
                v_u_28:Add(v_u_126, "Stop", "IdleTrack")
                v125.Priority = Enum.AnimationPriority.Action
                v125:Play()
                v125.Stopped:Once(function()
                    if v_u_29 and v_u_126 then
                        v_u_126.Looped = true
                        v_u_126.Priority = Enum.AnimationPriority.Idle
                        v_u_126:Play()
                    end
                end)
                v_u_28:Add(function()
                    if v_u_25 then
                        v_u_25:Destroy()
                        v_u_25 = nil
                        v_u_26 = nil
                        v_u_27 = nil
                    end
                end, true, "MenuCharacterCleanup")
            else
                warn("[MenuSceneController]: Character missing Humanoid")
            end
        else
            warn((("[MenuSceneController]: Character \"%*\" not found"):format(v117.Character)))
            return
        end
    else
        return
    end
end
local function v_u_130()
    if v_u_31 and v_u_31.Parent then
        local v128 = (v_u_10.Get(v_u_14, "Settings.Audio.Audio.Main Menu Ambience Volume") or 100) / 100
        local v129 = (v_u_10.Get(v_u_14, "Settings.Audio.Audio.Master Volume") or 100) / 100
        v_u_31.Volume = (v_u_31:GetAttribute("BaseVolume") or v_u_31.Volume) * v128 * v129 * v_u_32
    end
end
function v_u_1.ShowMenuScene()
    if v_u_29 then
        v_u_9.updateCameraFOV(50)
        v_u_9.setMouseEnabled(true)
        return
    elseif workspace:FindFirstChild("InspectScene") then
        return
    else
        local v131 = require(v_u_2.Interface.MenuState)
        if v131.IsInspectActive() then
            return
        elseif v131.IsCaseSceneActive() then
            return
        else
            local v132
            if v_u_17 then
                v132 = v_u_17
            else
                local v133 = v_u_2:FindFirstChild("Assets")
                if v133 then
                    v_u_17 = v133:WaitForChild("MenuScenes", 10)
                end
                v132 = v_u_17
            end
            local v134
            if v132 then
                local v135 = v132:GetChildren()
                if #v135 > 0 then
                    v134 = v135[math.random(1, #v135)]
                else
                    v134 = nil
                end
            else
                v134 = nil
            end
            if v134 then
                local v136 = v134:Clone()
                v136.Parent = workspace
                v_u_24 = v136
                v_u_51(v134.Name)
                local v_u_137 = v136:FindFirstChild("CamPart")
                if v_u_137 then
                    v_u_16.CameraType = Enum.CameraType.Scriptable
                    v_u_16.CFrame = v_u_137.CFrame
                    v_u_16.Focus = v_u_137.CFrame
                    v_u_9.updateCameraFOV(50)
                    v_u_9.setMouseEnabled(true)
                    v_u_28:Add(v_u_3.RenderStepped:Connect(function()
                        if v_u_24 and v_u_137 then
                            v_u_16.CFrame = v_u_137.CFrame
                            v_u_16.Focus = v_u_137.CFrame
                        end
                    end), "Disconnect", "CameraUpdate")
                    v_u_28:Add(function()
                        if v_u_24 then
                            v_u_24:Destroy()
                            v_u_24 = nil
                        end
                    end, true, "MenuSceneCleanup")
                    v_u_29 = true
                    v_u_127(v136)
                    if not (v_u_31 and v_u_31.IsPlaying) then
                        local v138 = (v_u_10.Get(v_u_14, "Settings.Audio.Audio.Main Menu Ambience Volume") or 100) / 100
                        local v139 = v_u_12.new("Main Menu")
                        v_u_30 = v139
                        local v_u_140 = v139:play({
                            ["Name"] = "Main Menu Music",
                            ["Parent"] = v_u_15
                        }, v138)
                        v_u_31 = v_u_140
                        if v_u_140 then
                            local v141 = (v_u_10.Get(v_u_14, "Settings.Audio.Audio.Master Volume") or 100) / 100
                            local v142 = v_u_140.Volume
                            if v138 > 0 and v141 > 0 then
                                v142 = v142 / (v138 * v141) or v142
                            end
                            v_u_140:SetAttribute("BaseVolume", v142)
                            v_u_140:SetAttribute("AmbienceVolumeMultiplier", v138)
                            if v_u_32 ~= 1 then
                                v_u_140.Volume = v_u_140.Volume * v_u_32
                            end
                            v_u_140.Destroying:Once(function()
                                if v_u_31 == v_u_140 then
                                    v_u_31 = nil
                                end
                            end)
                        end
                    end
                else
                    warn("[MenuSceneController]: Menu scene missing CamPart")
                    v136:Destroy()
                    v_u_24 = nil
                    v_u_43()
                end
            else
                v_u_9.setMouseEnabled(true)
                return
            end
        end
    end
end
function v_u_1.HideMenuScene(p143, p144)
    if v_u_29 then
        if require(v_u_2.Interface.MenuState).IsInspectActive() or workspace:FindFirstChild("InspectScene") then
            p144 = true
            p143 = true
        end
        v_u_28:Cleanup()
        if not p144 then
            v_u_43()
        end
        if not p144 then
            v_u_16.CameraType = Enum.CameraType.Custom
            v_u_9.updateCameraFOV(v_u_13.DEFAULT_CAMERA_FOV)
        end
        v_u_29 = false
        if not p143 then
            if v_u_31 then
                v_u_31:Stop()
                v_u_31 = nil
            end
            if v_u_30 then
                v_u_30:destroy()
                v_u_30 = nil
            end
        end
    end
end
function v_u_1.IsActive()
    return v_u_29
end
function v_u_1.StopMenuMusic()
    if v_u_31 then
        v_u_31:Stop()
        v_u_31 = nil
    end
    if v_u_30 then
        v_u_30:destroy()
        v_u_30 = nil
    end
end
function v_u_1.IsMusicPlaying()
    local v145
    if v_u_31 == nil then
        v145 = false
    else
        v145 = v_u_31.IsPlaying
    end
    return v145
end
function v_u_1.SetMusicVolumeMultiplier(p146, p147)
    v_u_32 = p146
    if v_u_31 then
        if v_u_33 then
            v_u_33:Cancel()
            v_u_33 = nil
        end
        local v148 = v_u_31:GetAttribute("BaseVolume") or 0.1
        local v149 = (v_u_10.Get(v_u_14, "Settings.Audio.Audio.Main Menu Ambience Volume") or 100) / 100
        local v150 = (v_u_10.Get(v_u_14, "Settings.Audio.Audio.Master Volume") or 100) / 100
        local v151 = v148 * v149 * v150 * v_u_32
        if p147 and p147 > 0 then
            local v152 = v_u_4:Create(v_u_31, TweenInfo.new(p147, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Volume"] = v151
            })
            v_u_33 = v152
            v152:Play()
        else
            v_u_31.Volume = v151
        end
    else
        return
    end
end
function v_u_1.ApplyMapLighting()
    v_u_43()
end
function v_u_1.ApplyMenuSceneLighting()
    local v153
    if v_u_17 then
        v153 = v_u_17
    else
        local v154 = v_u_2:FindFirstChild("Assets")
        if v154 then
            v_u_17 = v154:WaitForChild("MenuScenes", 10)
        end
        v153 = v_u_17
    end
    local v155
    if v153 then
        local v156 = v153:GetChildren()
        if #v156 > 0 then
            v155 = v156[math.random(1, #v156)]
        else
            v155 = nil
        end
    else
        v155 = nil
    end
    if v155 then
        v_u_51(v155.Name)
        v_u_5.GlobalShadows = true
    end
end
function v_u_1.GetMenuCharacter()
    return v_u_25
end
function v_u_1.CreateStandaloneCharacter(p157)
    local v158 = p157 or (math.random(1, 2) == 1 and "CT" or "T")
    local v159 = v_u_22[v158]
    local v160 = v_u_20:FindFirstChild(v159.Character)
    if not v160 then
        warn((("[MenuSceneController]: Character \"%*\" not found"):format(v159.Character)))
        return nil
    end
    local v161 = v160:Clone()
    v161.Name = "StandaloneCharacter"
    v161.Parent = v_u_2
    v_u_84(v161, v158, true)
    return v161
end
function v_u_1.Initialize()
    v_u_10.CreateListener(v_u_14, "Settings.Video.Presets.Global Shadows", function()
        if v_u_10.Get(v_u_14, "Settings.Video.Presets.Global Shadows") ~= false then
            if v_u_34 ~= nil then
                v_u_5.GlobalShadows = v_u_34
            end
        else
            v_u_5.GlobalShadows = false
        end
    end)
    v_u_10.CreateListener(v_u_14, "Settings.Audio.Audio.Main Menu Ambience Volume", v_u_130)
    v_u_10.CreateListener(v_u_14, "Settings.Audio.Audio.Master Volume", v_u_130)
    if v_u_65() then
        v_u_1.ShowMenuScene()
    end
    task.defer(function()
        if not v_u_11 then
            v_u_11 = require(v_u_2.Controllers.EndScreenController)
        end
    end)
    v_u_14.CharacterAdded:Connect(function(p162)
        v_u_1.StopMenuMusic()
        v_u_1.HideMenuScene()
        local v163 = p162:FindFirstChildOfClass("Humanoid")
        if not v163 then
            local v164 = tick()
            repeat
                task.wait(0.1)
                v163 = p162:FindFirstChildOfClass("Humanoid")
            until v163 or tick() - v164 > 5
        end
        if v163 then
            v163.Died:Connect(function()
                task.delay(0.1, function()
                    if v_u_65() then
                        v_u_1.ShowMenuScene()
                    end
                end)
            end)
        end
    end)
    v_u_14.CharacterRemoving:Connect(function()
        task.delay(0.1, function()
            if v_u_65() then
                v_u_1.ShowMenuScene()
            end
        end)
    end)
    v_u_7.observeAttribute(v_u_14, "IsSpectating", function(p165)
        if p165 then
            v_u_1.HideMenuScene()
        elseif v_u_65() then
            v_u_1.ShowMenuScene()
        end
        return function()
            if v_u_65() then
                v_u_1.ShowMenuScene()
            end
        end
    end)
    v_u_7.observeAttribute(v_u_14, "Team", function(p166)
        if p166 == "Counter-Terrorists" or p166 == "Terrorists" then
            v_u_1.HideMenuScene()
        elseif v_u_65() then
            v_u_1.ShowMenuScene()
        end
        return function()
            task.delay(0.1, function()
                if v_u_65() then
                    v_u_1.ShowMenuScene()
                end
            end)
        end
    end)
    local function v_u_171()
        if v_u_25 and v_u_26 then
            if v_u_27 and v_u_27.Parent then
                v_u_27:Destroy()
                v_u_27 = nil
            end
            local v167 = v_u_25:FindFirstChild("RightHand")
            local v168 = v167 and v167:FindFirstChild("WeaponAttachment")
            if v168 then
                v168:Destroy()
            end
            local v169 = v_u_25:FindFirstChild("CharacterArmor")
            if v169 then
                for _, v170 in ipairs(v169:GetChildren()) do
                    if v170:IsA("BasePart") and v170:FindFirstChild("GloveAttachment") then
                        v170:Destroy()
                    end
                end
            end
            v_u_27 = v_u_113(v_u_25, v_u_26, true)
            v_u_84(v_u_25, v_u_26, true)
        end
    end
    local v_u_172 = v_u_10.CreateListener(v_u_14, "Loadout", function()
        v_u_171()
    end)
    v_u_28:Add(function()
        v_u_10.RemoveListener(v_u_14, "Loadout", v_u_172)
    end, true, "LoadoutListener")
    local v173 = require(v_u_2.Database.Components.GameState)
    local v_u_174 = require(v_u_2.Controllers.SpectateController)
    v173.ListenToState(function(_, p175)
        if p175 == "Game Ending" or p175 == "Map Voting" then
            if v_u_14:GetAttribute("IsSpectating") then
                v_u_174.Stop(false, true)
            end
            if v_u_65() then
                v_u_1.ShowMenuScene()
            end
        end
    end)
end
function v_u_1.Start() end
return v_u_1