local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = game:GetService("TextService")
local v_u_7 = game:GetService("Lighting")
local v8 = game:GetService("Players")
local v_u_9 = game:GetService("HttpService")
require(v_u_2.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v10 = require(v_u_2.Shared.Janitor)
local v_u_11 = require(v_u_2.Controllers.MenuSceneController)
local v_u_12 = require(v_u_2.Controllers.CaseSceneController)
local v_u_13 = require(v_u_2.Controllers.CameraController)
local v_u_14 = require(v_u_2.Controllers.InputController)
local v_u_15 = require(v_u_2.Controllers.DataController)
local v_u_16 = require(v_u_2.Classes.WeaponComponent.Classes.Viewmodel)
local v_u_17 = require(v_u_2.Components.Common.InterfaceAnimations.ActivateButton)
local v_u_18 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_19 = require(v_u_2.Database.Components.Libraries.Collections)
local v20 = require(v_u_2.Components.Common.GetUserPlatform)
local v_u_21 = require(v_u_2.Database.Components.Libraries.Skins)
local v_u_22 = require(v_u_2.Database.Custom.GameStats.Rarities)
local v_u_23 = require(v_u_2.Shared.CloseButtonRegistry)
local v_u_24 = require(v_u_2.Database.Security.Router)
local v_u_25 = require(v_u_2.Interface.MenuState)
local v_u_26 = require(v_u_2.Database.Custom.Constants)
local v_u_27 = v8.LocalPlayer
local v_u_28 = v_u_27:WaitForChild("PlayerGui")
local v29 = v20()
local v_u_30 = table.find(v29, "Mobile")
if v_u_30 then
    v_u_30 = #v29 <= 1
end
local v_u_31 = workspace.CurrentCamera
local v_u_32 = nil
local v_u_33 = v_u_2.Assets.Lighting
local v_u_34 = v_u_2.Database.Custom.GameStats.Maps
local v_u_35 = nil
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = nil
local v_u_39 = nil
local v_u_40 = nil
local v_u_41 = nil
local v_u_42 = nil
local v_u_43 = false
local v_u_44 = nil
local v_u_45 = nil
local v_u_46 = nil
local v_u_47 = {}
local v_u_48 = v10.new()
local v_u_49 = "Weapon"
local v_u_50 = false
local v_u_51 = v_u_26.DEFAULT_CAMERA_FOV
local v_u_52 = false
local v_u_53 = Vector2.zero
local v_u_54 = 40
local v_u_55 = 40
local v_u_56 = 0
local v_u_57 = 0
local v_u_58 = 0
local v_u_59 = 0
local v_u_60 = {
    ["WEAPON_NAME_NO_COLLECTION_POSITION"] = UDim2.fromScale(0.5, 0.04),
    ["WEAPON_NAME_NO_COLLECTION_SIZE"] = UDim2.fromScale(0.317, 0.054),
    ["WEAPON_NAME_COLLECTION_POSITION"] = UDim2.fromScale(0.541, 0.03),
    ["WEAPON_NAME_COLLECTION_SIZE"] = UDim2.fromScale(0.243, 0.054),
    ["RARITY_FRAME_NO_COLLECTION_POSITION"] = UDim2.fromScale(0.5, 0.08),
    ["RARITY_FRAME_COLLECTION_POSITION"] = UDim2.fromScale(0.5, 0.143)
}
local v_u_61 = {}
local v_u_62 = nil
local v_u_63 = nil
local v_u_64 = 1
local function v_u_73()
    local v65 = workspace:FindFirstChild("Map")
    if v65 then
        local v66 = v65:GetAttribute("MapName")
        if v66 and typeof(v66) == "string" then
            local v67 = v_u_34:FindFirstChild(v66)
            if v67 and v67:IsA("ModuleScript") then
                local v68 = require(v67)
                if v68.Lighting then
                    local v69 = v68.Lighting.Properties
                    if v69 then
                        v_u_41 = v69.GlobalShadows
                        v_u_7.Ambient = v69.Ambient
                        v_u_7.Brightness = v69.Brightness
                        v_u_7.ColorShift_Bottom = v69.ColorShift_Bottom
                        v_u_7.ColorShift_Top = v69.ColorShift_Top
                        v_u_7.EnvironmentDiffuseScale = v69.EnvironmentDiffuseScale
                        v_u_7.EnvironmentSpecularScale = v69.EnvironmentSpecularScale
                        v_u_7.GlobalShadows = v69.GlobalShadows
                        v_u_7.OutdoorAmbient = v69.OutdoorAmbient
                        v_u_7.ShadowSoftness = v69.ShadowSoftness
                        v_u_7.ClockTime = v69.ClockTime
                        v_u_7.GeographicLatitude = v69.GeographicLatitude
                        v_u_7.ExposureCompensation = v69.ExposureCompensation
                    end
                    for _, v70 in ipairs(v_u_7:GetChildren()) do
                        if v70.Name ~= "Menu" then
                            v70:Destroy()
                        end
                    end
                    local v71 = v68.Lighting.Assets
                    if v71 then
                        for _, v72 in ipairs(v71:GetChildren()) do
                            v72:Clone().Parent = v_u_7
                        end
                    end
                    if v_u_15.Get(v_u_27, "Settings.Video.Presets.Global Shadows") ~= false then
                        if v_u_41 ~= nil then
                            v_u_7.GlobalShadows = v_u_41
                        end
                    else
                        v_u_7.GlobalShadows = false
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
local function v_u_81(p74)
    local v75 = v_u_33:FindFirstChild(p74) or v_u_33:FindFirstChild("Menu")
    if v75 then
        local v76 = v_u_34:FindFirstChild(p74)
        if v76 and v76:IsA("ModuleScript") then
            local v77 = require(v76)
            if v77.Lighting and v77.Lighting.Properties then
                local v78 = v77.Lighting.Properties
                v_u_41 = v78.GlobalShadows
                v_u_7.Ambient = v78.Ambient
                v_u_7.Brightness = v78.Brightness
                v_u_7.ColorShift_Bottom = v78.ColorShift_Bottom
                v_u_7.ColorShift_Top = v78.ColorShift_Top
                v_u_7.EnvironmentDiffuseScale = v78.EnvironmentDiffuseScale
                v_u_7.EnvironmentSpecularScale = v78.EnvironmentSpecularScale
                v_u_7.GlobalShadows = v78.GlobalShadows
                v_u_7.OutdoorAmbient = v78.OutdoorAmbient
                v_u_7.ShadowSoftness = v78.ShadowSoftness
                v_u_7.ClockTime = v78.ClockTime
                v_u_7.GeographicLatitude = v78.GeographicLatitude
                v_u_7.ExposureCompensation = v78.ExposureCompensation
            end
        end
        for _, v79 in ipairs(v_u_7:GetChildren()) do
            if v79.Name ~= "Menu" then
                v79:Destroy()
            end
        end
        for _, v80 in ipairs(v75:GetChildren()) do
            v80:Clone().Parent = v_u_7
        end
        if v_u_15.Get(v_u_27, "Settings.Video.Presets.Global Shadows") ~= false then
            if v_u_41 ~= nil then
                v_u_7.GlobalShadows = v_u_41
            end
        else
            v_u_7.GlobalShadows = false
        end
    else
        return
    end
end
local function v_u_86()
    local v82
    if v_u_32 then
        v82 = v_u_32
    else
        local v83 = v_u_2:FindFirstChild("Assets")
        if v83 then
            v_u_32 = v83:WaitForChild("InspectScenes", 10)
        end
        v82 = v_u_32
    end
    if v82 then
        local v84 = {}
        for _, v85 in ipairs(v82:GetChildren()) do
            if v85:IsA("Model") then
                table.insert(v84, v85)
            end
        end
        if #v84 > 0 then
            return v84[math.random(1, #v84)]
        else
            return nil
        end
    else
        return nil
    end
end
local function v_u_93()
    if v_u_44 and v_u_46 then
        local v87 = v_u_46:FindFirstChild("WeaponPart")
        if v87 then
            local v88 = CFrame.Angles(0, -1.5707963267948966, 0)
            local v89 = v_u_57
            local v90 = v_u_56
            local v91 = CFrame.Angles(0, math.rad(v89), (math.rad(v90)))
            if v_u_38 then
                local v92 = v_u_44:GetPivot():ToObjectSpace(v_u_38.WorldCFrame)
                v_u_44:PivotTo(v87.CFrame * v91 * v88 * v92:Inverse())
            else
                v_u_44:PivotTo(v87.CFrame * v91 * v88)
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_96()
    local v94 = {}
    for _, v95 in pairs(v_u_61) do
        table.insert(v94, v95)
    end
    if #v94 >= 2 then
        return (v94[1] - v94[2]).Magnitude
    else
        return nil
    end
end
local function v_u_101()
    v_u_25.EnterInspect()
    local v97 = v_u_25.GetMenuFrame()
    if v97 then
        v_u_43 = v_u_11.IsActive()
        if v_u_43 then
            v_u_11.HideMenuScene(true)
            v_u_11.SetMusicVolumeMultiplier(0.5, 0.5)
        end
        v_u_25.SetBlurEnabled(false)
        v97.BackgroundTransparency = 1
        local v98 = v97:FindFirstChild("Pattern")
        if v98 then
            v98.Visible = false
        end
        local v99 = v97:FindFirstChild("Top")
        if v99 then
            v99.Visible = false
        end
        for _, v100 in ipairs(v97:GetChildren()) do
            if v100:IsA("Frame") and v100.Name ~= "Top" then
                if v100.Name == "Inspect" or v100.Name == "InspectFrame" then
                    v100.Visible = true
                else
                    v100.Visible = false
                end
            end
        end
    end
end
local function v_u_113()
    local v102 = v_u_25.GetMenuFrame()
    if v102 then
        local v103 = v102:FindFirstChild("Inspect") or v102:FindFirstChild("InspectFrame")
        if v103 then
            local v104 = v103:FindFirstChild("Bottom")
            if v104 then
                local v105 = v104:FindFirstChild("Close")
                if v105 and v105:IsA("GuiButton") then
                    v_u_17(v105)
                    v_u_23.Add(v103, v105, function()
                        v_u_1.HideInspect()
                    end)
                end
                local v106 = v103:FindFirstChild("MobileButtons")
                if v106 then
                    local v107 = v106:FindFirstChild("Inspect")
                    if v107 and v107:IsA("TextButton") then
                        v_u_17(v107)
                        v107.MouseButton1Click:Connect(function()
                            v_u_1.PlayInspectAnimation()
                        end)
                        local v108 = v_u_15.Get(v_u_27, "MobileButtons")
                        if v108 and v108.Inspect then
                            local v109 = v108.Inspect
                            if v109.Position and v109.Size then
                                v107.Position = UDim2.fromScale(v109.Position.X, v109.Position.Y)
                                v107.Size = UDim2.fromScale(v109.Size.X, v109.Size.Y)
                            end
                        end
                    end
                    v106.Visible = false
                end
                local v110 = v104:FindFirstChild("Charm")
                if v110 then
                    local v111 = v110:FindFirstChild("Next")
                    if v111 and v111:IsA("GuiButton") then
                        v_u_17(v111)
                        v111.MouseButton1Click:Connect(function()
                            v_u_1.CycleCharmPosition()
                        end)
                    end
                    local v112 = v110:FindFirstChild("Confirm")
                    if v112 and v112:IsA("GuiButton") then
                        v_u_17(v112)
                        v112.MouseButton1Click:Connect(function()
                            v_u_24.broadcastRouter("ConfirmCharmAttachment")
                        end)
                    end
                end
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_119()
    local v114 = v_u_25.GetMenuFrame()
    if v114 then
        local v115 = v114:FindFirstChild("Inspect") or v114:FindFirstChild("InspectFrame")
        if v115 then
            local v116 = v115:FindFirstChild("MobileButtons")
            if v116 then
                local v117 = v116:FindFirstChild("Inspect")
                if v117 then
                    local v118 = v_u_50
                    if v118 then
                        if v_u_49 == "Viewmodel" then
                            v118 = v_u_30
                        else
                            v118 = false
                        end
                    end
                    v116.Visible = v118
                    v117.Visible = v118
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
local function v_u_124()
    local v120 = v_u_25.GetMenuFrame()
    if v120 then
        local v121 = v120:FindFirstChild("Inspect") or v120:FindFirstChild("InspectFrame")
        if v121 then
            local v122 = v121:FindFirstChild("Bottom")
            if v122 then
                local v123 = v122:FindFirstChild("Charm")
                if v123 then
                    v123.Visible = v_u_24.broadcastRouter("HasPendingCharmAttachment") or false
                end
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_128(p125)
    if p125.Type == "Weapon" or (p125.Type == "Melee" or p125.Type == "Glove") then
        return true
    end
    if p125.Name then
        local v126, v127 = pcall(v_u_18, p125.Name)
        if v126 and (v127 and v127.Class) then
            return (v127.Class == "Weapon" or v127.Class == "Melee") and true or v127.Class == "Glove"
        end
    end
    return false
end
local function v_u_133()
    if v_u_35 then
        if v_u_35.IsPlaying then
            v_u_35:Stop(0)
        end
        v_u_35:Destroy()
        v_u_35 = nil
    end
    if v_u_36 then
        v_u_36:Destroy()
        v_u_36 = nil
    end
    if v_u_37 and v_u_37.Animation then
        local v_u_129 = v_u_37.Animation.Animator
        if v_u_129 then
            local v_u_130 = Instance.new("Animation")
            v_u_130.AnimationId = "rbxassetid://135926544677482"
            local v131, v132 = pcall(function()
                return v_u_129:LoadAnimation(v_u_130)
            end)
            if v131 and v132 then
                v_u_36 = v_u_130
                v_u_35 = v132
                if v_u_35 then
                    if v_u_37 and v_u_37.Animation then
                        v_u_37.Animation:stopAnimations()
                    end
                    if v_u_35.IsPlaying then
                        v_u_35:Stop(0)
                    end
                    v_u_35.TimePosition = 0
                    v_u_35:Play(0, 1, 1)
                end
            else
                v_u_130:Destroy()
                return
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_138(p134, p135)
    local v136 = (not p135 or (p135 == "" or not p135)) and "Vanilla" or p135
    if v_u_21.GetSkinInformation(p134, v136) then
        return v136
    elseif v_u_21.GetSkinInformation(p134, "Vanilla") then
        return "Vanilla"
    elseif v_u_21.GetSkinInformation(p134, "Default") then
        return "Default"
    else
        local v137 = v_u_21.GetAllSkinsForWeapon(p134)
        if v137 and (v137[1] and v137[1].skin) then
            return v137[1].skin
        else
            return v136
        end
    end
end
local function v_u_141()
    for _, v139 in ipairs({
        "FAMAS",
        "AK-47",
        "M4A1-S",
        "Glock-18",
        "USP-S"
    }) do
        local v140 = v_u_21.GetBaseWeaponModel(v139, "Camera")
        if v140 then
            v140:Destroy()
            return v139
        end
    end
    return "FAMAS"
end
local function v_u_148(p142)
    if p142 and p142.Model then
        local v143 = p142.Model:FindFirstChild("Stats")
        if v143 then
            local v144 = v143:FindFirstChild("Default")
            if v144 then
                local v145 = v144.Value
                if typeof(v145) == "Vector3" then
                    local v146 = v145.Y
                    local v147 = v145.Z
                    v144.Value = Vector3.new(0.05, v146, v147)
                end
            end
        end
    else
        return
    end
end
local function v_u_165(p149)
    if v_u_46 then
        local v150 = v_u_46:FindFirstChild("WeaponPart")
        if v150 then
            local v151 = nil
            local v152 = p149.Type == "Glove"
            local v153 = p149.Type == "Charm"
            local v154 = p149.Type == "Badge"
            if v152 then
                local v155 = v_u_21.GetGloves(p149.Name, p149.Skin, p149.Float)
                if v155 then
                    if v155:IsA("BasePart") then
                        v151 = Instance.new("Model")
                        v151.Name = p149.Name
                        v155.Parent = v151
                        v151.PrimaryPart = v155
                    else
                        v151 = v155
                    end
                end
            elseif v153 then
                v151 = v_u_21.GetCharmModel(p149.Skin, p149.Pattern or 1) or v151
            elseif v154 then
                v151 = v_u_21.GetBadgeModel(p149.Skin) or v151
            else
                v151 = v_u_21.GetCharacterModel(p149.Name, p149.Skin, p149.Float, p149.StatTrack, p149.NameTag, p149.Charm, p149.Stickers)
            end
            if v151 then
                v151.Name = "InspectWeapon"
                v_u_44 = v151
                v_u_38 = v151:FindFirstChild("InspectPivot", true)
                if v_u_38 then
                    warn((("[InspectController]: Found InspectPivot at %*"):format((v_u_38:GetFullName()))))
                else
                    warn((("[InspectController]: No InspectPivot found for %*"):format(p149.Name)))
                end
                local v156 = v151:FindFirstChild("CharmBase", true)
                for _, v157 in ipairs(v151:GetDescendants()) do
                    if v157:IsA("BasePart") then
                        local v158
                        if v156 then
                            v158 = v157:IsDescendantOf(v156)
                        else
                            v158 = v156
                        end
                        v157.CastShadow = false
                        if v153 then
                            if v151.PrimaryPart == v157 then
                                v157.CanCollide = false
                                v157.CanQuery = false
                                v157.CanTouch = false
                                v157.Anchored = true
                            else
                                v157.CanCollide = false
                                v157.CanQuery = false
                                v157.CanTouch = false
                                v157.Anchored = false
                            end
                        elseif v158 then
                            v157.Anchored = false
                        else
                            v157.CanCollide = v157:IsA("MeshPart") and true or false
                            v157.CanQuery = false
                            v157.CanTouch = false
                            v157.Anchored = true
                        end
                    end
                end
                if v152 and (p149.Name == "T Glove" or p149.Name == "CT Glove") then
                    local v159 = {}
                    for _, v160 in ipairs(v151:GetChildren()) do
                        if v160:IsA("BasePart") then
                            table.insert(v159, v160)
                        end
                    end
                    if #v159 >= 2 then
                        local v161 = v151:FindFirstChild("RightGlove") or v159[1]
                        for _, v162 in ipairs(v159) do
                            if v162 ~= v161 then
                                v162:Destroy()
                            end
                        end
                    end
                end
                v151.Parent = v_u_46
                local v163 = CFrame.Angles(0, -1.5707963267948966, 0)
                if v_u_38 then
                    local v164 = v151:GetPivot():ToObjectSpace(v_u_38.WorldCFrame)
                    v151:PivotTo(v150.CFrame * v163 * v164:Inverse())
                else
                    v151:PivotTo(v150.CFrame * v163)
                end
            else
                warn(("[InspectController]: Failed to get model for \"%*\""):format(p149.Name), p149)
                return
            end
        else
            warn("[InspectController]: Inspect scene missing WeaponPart")
            return
        end
    else
        return
    end
end
local function v_u_187(p_u_166)
    if v_u_35 then
        if v_u_35.IsPlaying then
            v_u_35:Stop(0)
        end
        v_u_35:Destroy()
        v_u_35 = nil
    end
    if v_u_36 then
        v_u_36:Destroy()
        v_u_36 = nil
    end
    if v_u_37 then
        v_u_37:destroy()
        v_u_37 = nil
    end
    if v_u_40 then
        v_u_40:Destroy()
        v_u_40 = nil
    end
    v_u_14.enableGroup("Gameplay")
    local v167 = v_u_27:GetAttribute("Team") == "Counter-Terrorists" and "CT" or "T"
    local v168
    if p_u_166 then
        if p_u_166.Type == "Glove" then
            v168 = true
        elseif p_u_166.Name then
            local v169, v170 = pcall(v_u_18, p_u_166.Name)
            if v169 and (v170 and v170.Class) then
                v168 = v170.Class == "Glove"
            else
                v168 = false
            end
        else
            v168 = false
        end
    else
        v168 = false
    end
    local v171 = v_u_11.CreateStandaloneCharacter(v167)
    if v171 then
        if v168 then
            local v172 = {
                ["Name"] = p_u_166.Name,
                ["Skin"] = p_u_166.Skin,
                ["Float"] = p_u_166.Float
            }
            if p_u_166._id and p_u_166._id ~= "" then
                v172.SkinIdentifier = p_u_166._id
            end
            v171:SetAttribute("EquippedGloves", v_u_9:JSONEncode(v172))
        end
        v_u_40 = v171
        local v173 = p_u_166.Charm
        if v_u_24.broadcastRouter("HasPendingCharmAttachment") and type(v173) == "table" then
            v173 = {
                ["_id"] = v173._id
            }
            local v174 = v_u_64
            v173.Position = tostring(v174)
        end
        local v_u_175 = {
            ["Player"] = v_u_27,
            ["Character"] = v171,
            ["StatTrack"] = p_u_166.StatTrack,
            ["Stickers"] = p_u_166.Stickers,
            ["NameTag"] = p_u_166.NameTag,
            ["Float"] = p_u_166.Float,
            ["Charm"] = v173
        }
        local v176 = p_u_166.Name
        local v177 = p_u_166.Skin
        local v178 = false
        local v_u_179
        if v168 then
            v176 = v_u_141()
            v178 = true
            v_u_179 = "Stock"
        else
            v_u_179 = v_u_138(v176, v177)
        end
        v_u_175.ViewmodelCameraWeapon = v176
        v_u_175.ViewmodelHideWeaponGeometry = v178
        local v180, v181 = pcall(function()
            return v_u_16.new(v_u_175, p_u_166.Name, v_u_179)
        end)
        local v182
        if v180 and v181 then
            v182 = nil
        else
            v182 = v181
            v181 = nil
        end
        if v181 then
            v_u_37 = v181
            if v_u_37 then
                v_u_37:equip(v168)
                if v_u_37.Model then
                    if v_u_37.Model.Parent ~= v_u_31 then
                        v_u_37.Model.Parent = v_u_31
                    end
                    if v_u_37.Hidden then
                        v_u_37:unhide()
                    end
                    if v168 then
                        v_u_148(v_u_37)
                    end
                    if v168 then
                        v_u_133()
                    end
                    task.defer(function()
                        if v_u_37 and v_u_37.Model then
                            for _, v183 in ipairs(v_u_37.Model:GetDescendants()) do
                                if v183:IsA("BasePart") then
                                    v183.CastShadow = false
                                    if v183.Name ~= "HumanoidRootPart" and (v183.Name ~= "ViewmodelLight" and (v183.Name ~= "MuzzlePart" and v183.Name ~= "MuzzlePartL")) and v183.Name ~= "MuzzlePartR" then
                                        local v184 = v183:GetAttribute("HiddenTransparency")
                                        if v184 == nil then
                                            v184 = nil
                                        else
                                            v183:SetAttribute("HiddenTransparency", nil)
                                        end
                                        local v185
                                        if v184 == nil then
                                            v185 = v183:GetAttribute("_CaseScenePrevTransparency")
                                            if v185 == nil then
                                                v185 = v184
                                            else
                                                v183:SetAttribute("_CaseScenePrevTransparency", nil)
                                            end
                                        else
                                            v185 = v184
                                        end
                                        local v186
                                        if v185 == nil then
                                            v186 = v183:GetAttribute("_InspectPrevTransparency")
                                            if v186 == nil then
                                                v186 = v185
                                            else
                                                v183:SetAttribute("_InspectPrevTransparency", nil)
                                            end
                                        else
                                            v186 = v185
                                        end
                                        if v186 == nil then
                                            if v183.Transparency >= 1 and (v183.Name == "Right Arm" or v183.Name == "Left Arm") then
                                                v183.Transparency = 0
                                            end
                                        else
                                            v183.Transparency = v186
                                        end
                                    end
                                elseif v183:IsA("SurfaceGui") then
                                    if v183:GetAttribute("_InspectPrevSurfaceGuiEnabled") then
                                        v183.Enabled = true
                                        v183:SetAttribute("_InspectPrevSurfaceGuiEnabled", nil)
                                    end
                                    if v183:GetAttribute("_CaseScenePrevSurfaceGuiEnabled") then
                                        v183.Enabled = true
                                        v183:SetAttribute("_CaseScenePrevSurfaceGuiEnabled", nil)
                                    end
                                    if not v183.Enabled then
                                        v183.Enabled = true
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        else
            warn(("[InspectController]: Failed to create viewmodel (%* | %*)"):format(v176, v_u_179), v182)
            if v_u_35 then
                if v_u_35.IsPlaying then
                    v_u_35:Stop(0)
                end
                v_u_35:Destroy()
                v_u_35 = nil
            end
            if v_u_36 then
                v_u_36:Destroy()
                v_u_36 = nil
            end
            if v_u_37 then
                v_u_37:destroy()
                v_u_37 = nil
            end
            if v_u_40 then
                v_u_40:Destroy()
                v_u_40 = nil
            end
            v_u_14.enableGroup("Gameplay")
        end
    else
        warn("[InspectController]: Failed to create standalone character for viewmodel")
        return
    end
end
local function v_u_194(p188)
    local v189 = v_u_39
    if v189 then
        local v190
        if v189 then
            if v189.Type == "Glove" then
                v190 = true
            elseif v189.Name then
                local v191, v192 = pcall(v_u_18, v189.Name)
                if v191 and (v192 and v192.Class) then
                    v190 = v192.Class == "Glove"
                else
                    v190 = false
                end
            else
                v190 = false
            end
        else
            v190 = false
        end
        local v193 = v190 and p188 == "Weapon" and "Viewmodel" or p188
        if v_u_49 == v193 then
            return
        else
            if v_u_49 == "Weapon" then
                if v_u_44 then
                    v_u_44:Destroy()
                    v_u_44 = nil
                end
                v_u_38 = nil
            elseif v_u_49 == "Viewmodel" then
                if v_u_35 then
                    if v_u_35.IsPlaying then
                        v_u_35:Stop(0)
                    end
                    v_u_35:Destroy()
                    v_u_35 = nil
                end
                if v_u_36 then
                    v_u_36:Destroy()
                    v_u_36 = nil
                end
                if v_u_37 then
                    v_u_37:destroy()
                    v_u_37 = nil
                end
                if v_u_40 then
                    v_u_40:Destroy()
                    v_u_40 = nil
                end
                v_u_14.enableGroup("Gameplay")
            end
            v_u_49 = v193
            v_u_119()
            if v193 == "Weapon" then
                v_u_165(v189)
                v_u_55 = 40
                v_u_14.enableGroup("Gameplay")
            elseif v193 == "Viewmodel" then
                v_u_14.disableGroup("Gameplay")
                v_u_187(v189)
                v_u_55 = v_u_51
            end
        end
    else
        return
    end
end
local function v_u_208(p195, p196, p197)
    local v198 = p196:FindFirstChild("HoverFrame")
    local v199 = p196:FindFirstChild("SelectFrame")
    local v200 = p196:FindFirstChild("ImageLabel")
    local v201
    if v_u_49 == p195 then
        v201 = p195 ~= "Info"
    else
        v201 = false
    end
    if v201 then
        local v202 = {
            ["BackgroundTransparency"] = 1
        }
        if v198 then
            v_u_5:Create(v198, TweenInfo.new(0.2), v202):Play()
        end
        local v203 = {
            ["BackgroundTransparency"] = 0
        }
        if v199 then
            v_u_5:Create(v199, TweenInfo.new(0.2), v203):Play()
        end
        if v200 then
            local v204 = {
                ["ImageColor3"] = Color3.fromRGB(0, 0, 0)
            }
            if v200 then
                v_u_5:Create(v200, TweenInfo.new(0.2), v204):Play()
                return
            end
        end
    else
        local v205 = {
            ["BackgroundTransparency"] = 1
        }
        if v199 then
            v_u_5:Create(v199, TweenInfo.new(0.2), v205):Play()
        end
        if v200 then
            local v206 = {
                ["ImageColor3"] = Color3.fromRGB(255, 255, 255)
            }
            if v200 then
                v_u_5:Create(v200, TweenInfo.new(0.2), v206):Play()
            end
        end
        local v207 = {
            ["BackgroundTransparency"] = p197 and 0 or 1
        }
        if v198 then
            v_u_5:Create(v198, TweenInfo.new(0.2), v207):Play()
        end
    end
end
local function v_u_213(p209, p210)
    for v211, v212 in pairs(p209) do
        if v212 and v212:IsA("GuiButton") then
            v_u_208(v211, v212, v211 == p210)
        end
    end
end
local function v_u_224(p214, p215)
    local v216 = v_u_31.ViewportSize.Y * 0.025
    local v217 = math.floor(v216)
    local v218 = math.min(v217, 32)
    local v219 = math.max(8, v218)
    local v220 = Enum.Font.Gotham
    local v221 = 0
    for _, v222 in ipairs(p215) do
        if v222 and (v222:IsA("TextLabel") and v222.Text ~= "") then
            v222.TextScaled = false
            local v223 = v_u_6:GetTextSize(v222.Text:gsub("<[^>]*>", ""), v219, v220, Vector2.new((1 / 0), (1 / 0)))
            if v221 < v223.X then
                v221 = v223.X
            end
            v222.TextSize = v219
            v222.TextWrapped = false
        end
    end
    if v221 > 0 then
        p214.Size = UDim2.new(0.05, v221, p214.Size.Y.Scale, p214.Size.Y.Offset)
    end
end
local function v_u_247(p225, p226, p227)
    local v_u_228 = p225:FindFirstChild("Information")
    if v_u_228 then
        if p227 then
            local v229 = v_u_228.Parent.AbsolutePosition.X
            local v230 = p227.AbsolutePosition.X + p227.AbsoluteSize.X / 2 - v229
            v_u_228.Position = UDim2.new(0, v230 + v_u_228.AbsoluteSize.X / 2, v_u_228.Position.Y.Scale, v_u_228.Position.Y.Offset)
        end
        v_u_228.Visible = true
        local v231 = v_u_21.GetSkinInformation(p226.Name, p226.Skin)
        local v232 = "Factory New"
        if v231 then
            v232 = v_u_21.GetWearNameForFloat(v231, p226.Float or 0) or v232
        end
        local v_u_233 = v_u_228:FindFirstChild("Exterior")
        if v_u_233 then
            v_u_233.RichText = true
            v_u_233.Text = ("<b><font color=\"rgb(175,175,175)\">Exterior</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format(v232)
        end
        local v_u_234 = v_u_228:FindFirstChild("Tradeable")
        if v_u_234 then
            v_u_234.RichText = true
            v_u_234.Text = ("<b><font color=\"rgb(175,175,175)\">Tradeable</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format(p226.IsTradeable and "Yes" or "No")
        end
        local v_u_235 = v_u_228:FindFirstChild("Serial")
        if v_u_235 then
            v_u_235.RichText = true
            local v236
            if p226.Serial then
                local v237 = p226.Serial
                v236 = "#" .. tostring(v237)
            else
                v236 = "N/A"
            end
            v_u_235.Text = ("<b><font color=\"rgb(175,175,175)\">Serial</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format(v236)
        end
        local v_u_238 = v_u_228:FindFirstChild("Pattern")
        if v_u_238 then
            if p226.Type == "Charm" then
                v_u_238.Visible = true
                v_u_238.RichText = true
                local v239 = p226.Pattern or 0
                v_u_238.Text = ("<b><font color=\"rgb(175,175,175)\">Pattern</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format((tostring(v239)))
            else
                v_u_238.Visible = false
            end
        end
        local v_u_240 = v_u_228:FindFirstChild("Float")
        if v_u_240 then
            v_u_240.RichText = true
            v_u_240.Text = ("<b><font color=\"rgb(175,175,175)\">Float</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format((string.format("%.14f", p226.Float or 0)))
        end
        task.defer(function()
            local v241 = {}
            if v_u_233 then
                local v242 = v_u_233
                table.insert(v241, v242)
            end
            if v_u_234 then
                local v243 = v_u_234
                table.insert(v241, v243)
            end
            if v_u_235 then
                local v244 = v_u_235
                table.insert(v241, v244)
            end
            if v_u_238 and v_u_238.Visible then
                local v245 = v_u_238
                table.insert(v241, v245)
            end
            if v_u_240 then
                local v246 = v_u_240
                table.insert(v241, v246)
            end
            v_u_224(v_u_228, v241)
        end)
    end
end
local function v_u_252()
    if v_u_25.IsCaseSceneActive() then
        return true
    end
    if v_u_25.GetScreenBeforeCaseScene() == "Store" then
        return true
    end
    if v_u_25.GetCurrentScreen() == "Store" then
        return true
    end
    local v248 = v_u_28:FindFirstChild("MainGui")
    if v248 then
        local v249 = v248:FindFirstChild("Menu")
        local v250 = v249 and v249:FindFirstChild("Store")
        if v250 then
            local v251 = v250:FindFirstChild("CaseContent")
            if v251 and v251:GetAttribute("WasVisibleBeforeInspect") == true then
                return true
            end
        end
    end
    return false
end
local function v_u_258(p_u_253, p_u_254, p_u_255, p_u_256)
    v_u_48:Add(p_u_253.MouseEnter:Connect(function()
        v_u_208(p_u_254, p_u_253, true)
        if p_u_254 == "Info" and (p_u_256 and v_u_39) and (not v_u_252() and v_u_39.Type ~= "Badge") then
            v_u_247(p_u_256, v_u_39, p_u_253)
        end
    end), "Disconnect", "InspectButton_Enter_" .. p_u_254)
    v_u_48:Add(p_u_253.MouseLeave:Connect(function()
        v_u_208(p_u_254, p_u_253, false)
        local v257 = p_u_254 == "Info" and (p_u_256 and p_u_256:FindFirstChild("Information"))
        if v257 then
            v257.Visible = false
        end
    end), "Disconnect", "InspectButton_Leave_" .. p_u_254)
    if p_u_254 == "Info" then
        v_u_48:Add(p_u_253.Activated:Connect(function()
            if p_u_256 and (v_u_39 and (not v_u_252() and v_u_39.Type ~= "Badge")) then
                v_u_247(p_u_256, v_u_39, p_u_253)
            end
        end), "Disconnect", "InspectButton_Activated_Info")
    else
        v_u_48:Add(p_u_253.MouseButton1Click:Connect(function()
            if v_u_49 ~= p_u_254 then
                v_u_194(p_u_254)
                v_u_213(p_u_255, p_u_254)
            end
        end), "Disconnect", "InspectButton_Click_" .. p_u_254)
    end
end
local function v_u_273(p259, p260)
    local v261 = p259:FindFirstChild("Bottom")
    if v261 then
        v261 = v261:FindFirstChild("Frame")
    end
    if v261 then
        local v262 = v_u_128(p260)
        local v263
        if p260 then
            if p260.Type == "Glove" then
                v263 = true
            elseif p260.Name then
                local v264, v265 = pcall(v_u_18, p260.Name)
                if v264 and (v265 and v265.Class) then
                    v263 = v265.Class == "Glove"
                else
                    v263 = false
                end
            else
                v263 = false
            end
        else
            v263 = false
        end
        local v266 = {
            ["Info"] = v261:FindFirstChild("Info"),
            ["Viewmodel"] = v261:FindFirstChild("Viewmodel"),
            ["Weapon"] = v261:FindFirstChild("Weapon")
        }
        local v267 = v_u_252()
        local v268 = p260.Type == "Badge"
        for v269, v270 in pairs(v266) do
            if v270 and v270:IsA("GuiButton") then
                if v269 == "Info" then
                    local v271 = not v267
                    if v271 then
                        v271 = not v268
                    end
                    v270.Visible = v271
                elseif v269 == "Weapon" then
                    local v272
                    if v262 then
                        v272 = not v263
                    else
                        v272 = v262
                    end
                    v270.Visible = v272
                else
                    v270.Visible = v262
                end
                v_u_208(v269, v270, false)
                v_u_258(v270, v269, v266, p259)
            end
        end
    end
end
local function v_u_282(p274, p275)
    if p275 then
        p275 = p275.collection
    end
    local v276 = v_u_19.GetCollectionByName(p275)
    local v277 = v276 ~= nil
    local v278 = p274:FindFirstChild("CollectionName")
    if v278 and v278:IsA("TextLabel") then
        v278.Visible = v277
        v278.Text = p275 or ""
    end
    local v279 = p274:FindFirstChild("CollectionIcon")
    if v279 and v279:IsA("ImageLabel") then
        v279.Image = v276 and v276.imageAssetId or ""
        v279.Visible = v277
    end
    local v280 = p274:FindFirstChild("WeaponName")
    if v280 and v280:IsA("TextLabel") then
        v280.Position = v277 and v_u_60.WEAPON_NAME_COLLECTION_POSITION or v_u_60.WEAPON_NAME_NO_COLLECTION_POSITION
        v280.Size = v277 and v_u_60.WEAPON_NAME_COLLECTION_SIZE or v_u_60.WEAPON_NAME_NO_COLLECTION_SIZE
        v280.TextXAlignment = v277 and Enum.TextXAlignment.Left or Enum.TextXAlignment.Center
    end
    local v281 = p274:FindFirstChild("Rarity")
    if v281 and v281:IsA("Frame") then
        v281.Position = v277 and v_u_60.RARITY_FRAME_COLLECTION_POSITION or v_u_60.RARITY_FRAME_NO_COLLECTION_POSITION
    end
end
local function v_u_295(p283)
    local v284 = v_u_28:FindFirstChild("MainGui")
    if v284 then
        local v285 = v284:FindFirstChild("Menu")
        if v285 then
            local v286 = v285:FindFirstChild("Inspect") or v285:FindFirstChild("InspectFrame")
            if v286 then
                v_u_273(v286, p283)
                local v287 = v_u_252() and v286:FindFirstChild("Information")
                if v287 then
                    v287.Visible = false
                end
                local v288 = v_u_21.GetSkinInformation(p283.Name, p283.Skin)
                local v289 = v286:FindFirstChild("WeaponName")
                if v289 and v289:IsA("TextLabel") then
                    local v290 = v288 and v288.type == "Melee" and "\226\152\133 " or ""
                    local v291 = " | " .. p283.Skin
                    local v292 = v291 and v291 == "Vanilla" and "" or v291
                    v289.Text = v290 .. p283.Name .. v292
                end
                if v288 then
                    v_u_282(v286, v288)
                    local v293 = v286:FindFirstChild("Rarity")
                    local v294 = v293 and (v293:IsA("Frame") and (v288.rarity and v_u_22[v288.rarity]))
                    if v294 then
                        v293.BackgroundColor3 = v294.Color
                    end
                end
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_299()
    v_u_47 = {}
    for _, v296 in ipairs(v_u_31:GetChildren()) do
        if v296:IsA("Model") and (v296.Name ~= "InspectScene" and (not v_u_37 or v_u_37.Model ~= v296)) then
            for _, v297 in ipairs(v296:GetDescendants()) do
                if v297:IsA("BasePart") then
                    if v297.Transparency < 1 then
                        v297:SetAttribute("_InspectPrevTransparency", v297.Transparency)
                        v297.Transparency = 1
                    end
                elseif v297:IsA("SurfaceGui") then
                    if v297.Enabled then
                        v297:SetAttribute("_InspectPrevSurfaceGuiEnabled", true)
                        v297.Enabled = false
                    end
                elseif v297:IsA("Texture") and v297.Transparency < 1 then
                    v297:SetAttribute("_InspectPrevTransparency", v297.Transparency)
                    v297.Transparency = 1
                end
            end
            local v298 = v_u_47
            table.insert(v298, v296)
        end
    end
end
local function v_u_304()
    for _, v300 in ipairs(v_u_47) do
        if v300 and v300.Parent then
            for _, v301 in ipairs(v300:GetDescendants()) do
                if v301:IsA("BasePart") then
                    local v302 = v301:GetAttribute("_InspectPrevTransparency")
                    if v302 ~= nil then
                        v301.Transparency = v302
                        v301:SetAttribute("_InspectPrevTransparency", nil)
                    end
                elseif v301:IsA("SurfaceGui") then
                    if v301:GetAttribute("_InspectPrevSurfaceGuiEnabled") ~= nil then
                        v301.Enabled = true
                        v301:SetAttribute("_InspectPrevSurfaceGuiEnabled", nil)
                    end
                elseif v301:IsA("Texture") then
                    local v303 = v301:GetAttribute("_InspectPrevTransparency")
                    if v303 == nil then
                        v301.Transparency = 0.3
                    else
                        v301.Transparency = v303
                        v301:SetAttribute("_InspectPrevTransparency", nil)
                    end
                end
            end
        end
    end
    v_u_47 = {}
end
local function v_u_318()
    local v305 = v_u_25.GetMenuFrame()
    if v305 and v305.Visible then
        local v306 = v305:FindFirstChild("Inspect") or v305:FindFirstChild("InspectFrame")
        if v306 and v306:IsA("GuiObject") then
            local v307 = v306:FindFirstChild("MobileButtons")
            v306.Visible = false
            if v307 then
                v307.Visible = false
            end
        end
        if v_u_43 then
            v_u_11.ShowMenuScene()
            v_u_11.SetMusicVolumeMultiplier(1, 0.5)
        end
        v_u_43 = false
        local v308 = v_u_25.GetScreenBeforeInspect()
        v_u_25.ExitInspect()
        local v309 = v305:FindFirstChild("Top")
        if v309 then
            v309.Visible = true
        end
        if v308 then
            local v310 = v305:FindFirstChild(v308)
            if v310 then
                for _, v311 in ipairs(v305:GetChildren()) do
                    if v311:IsA("Frame") and (v311.Name ~= "Top" and (v311.Name ~= v308 and (v311.Name ~= "Inspect" and v311.Name ~= "InspectFrame"))) then
                        v311.Visible = false
                    end
                end
                v310.Visible = true
                if v_u_25.IsCaseSceneActive() and v308 == "Store" then
                    v_u_25.SetBlurEnabled(false)
                    v305.BackgroundTransparency = 1
                    local v312 = v305:FindFirstChild("Pattern")
                    if v312 then
                        v312.Visible = false
                        return
                    end
                else
                    local v313
                    if v308 == "Dashboard" then
                        v313 = false
                    else
                        v313 = v308 ~= "Play"
                    end
                    v_u_25.SetBlurEnabled(v313)
                    v305.BackgroundTransparency = v313 and 0.15 or 1
                    local v314 = v305:FindFirstChild("Pattern")
                    if v314 then
                        v314.Visible = not v313
                        return
                    end
                end
            end
        else
            for _, v315 in ipairs(v305:GetChildren()) do
                if v315:IsA("Frame") and (v315.Name ~= "Top" and (v315.Name ~= "Dashboard" and (v315.Name ~= "Inspect" and v315.Name ~= "InspectFrame"))) then
                    v315.Visible = false
                end
            end
            local v316 = v305:FindFirstChild("Dashboard")
            if v316 then
                v316.Visible = true
            end
            v_u_25.SetBlurEnabled(false)
            v305.BackgroundTransparency = 1
            local v317 = v305:FindFirstChild("Pattern")
            if v317 then
                v317.Visible = true
            end
        end
    else
        v_u_43 = false
        v_u_25.ExitInspect()
    end
end
function v_u_1.ShowInspect(p319)
    if v_u_50 then
        v_u_1.HideInspect()
    end
    if v_u_24.broadcastRouter("HasPendingCharmAttachment") then
        v_u_63 = p319
        v_u_64 = 1
    else
        v_u_63 = nil
    end
    v_u_39 = p319
    local v320
    if p319 then
        if p319.Type == "Glove" then
            v320 = true
        elseif p319.Name then
            local v321, v322 = pcall(v_u_18, p319.Name)
            if v321 and (v322 and v322.Class) then
                v320 = v322.Class == "Glove"
            else
                v320 = false
            end
        else
            v320 = false
        end
    else
        v320 = false
    end
    v_u_49 = v320 and "Viewmodel" or "Weapon"
    v_u_101()
    v_u_299()
    v_u_124()
    v_u_295(p319)
    if v_u_42 then
        if v_u_42 and v_u_42.Parent ~= workspace then
            v_u_42.Parent = workspace
        end
        v_u_46 = v_u_42
        if v_u_45 then
            v_u_81(v_u_45)
        end
        local v_u_323
        if v_u_46 then
            v_u_323 = v_u_46:FindFirstChild("CamPart")
        else
            v_u_323 = nil
        end
        if v_u_323 then
            local v324
            if v_u_46 then
                v324 = v_u_46:FindFirstChild("WeaponPart")
            else
                v324 = nil
            end
            if v324 then
                if v_u_49 == "Viewmodel" then
                    v_u_14.disableGroup("Gameplay")
                    v_u_187(p319)
                else
                    v_u_14.enableGroup("Gameplay")
                    v_u_165(p319)
                end
                v_u_56 = 0
                v_u_57 = 0
                v_u_58 = 0
                v_u_59 = 0
                if v_u_49 == "Viewmodel" then
                    v_u_54 = v_u_51
                    v_u_55 = v_u_51
                else
                    v_u_54 = 40
                    v_u_55 = 40
                end
                v_u_31.CameraType = Enum.CameraType.Scriptable
                v_u_31.CFrame = v_u_323.CFrame
                v_u_31.Focus = v_u_323.CFrame
                v_u_13.updateCameraFOV(v_u_49 ~= "Viewmodel" and 40 or v_u_51)
                v_u_13.setForceLockOverride("Inspect", true)
                v_u_48:Add(v_u_4.RenderStepped:Connect(function(p325)
                    local v326 = p325 * 8
                    local v327 = math.min(1, v326)
                    v_u_54 = v_u_54 + (v_u_55 - v_u_54) * v327
                    if v_u_46 and v_u_323 then
                        v_u_31.CameraType = Enum.CameraType.Scriptable
                        v_u_31.CFrame = v_u_323.CFrame
                        v_u_31.Focus = v_u_323.CFrame
                        v_u_31.FieldOfView = v_u_54
                    end
                    if v_u_49 == "Weapon" and v_u_3.GamepadEnabled then
                        local v328 = v_u_3:GetLastInputType()
                        local v329 = v_u_3:GetGamepadState((v328 == Enum.UserInputType.Gamepad1 or (v328 == Enum.UserInputType.Gamepad2 or (v328 == Enum.UserInputType.Gamepad3 or v328 == Enum.UserInputType.Gamepad4))) and v328 and v328 or Enum.UserInputType.Gamepad1)
                        if v329 then
                            for _, v330 in pairs(v329) do
                                if v330.KeyCode == Enum.KeyCode.Thumbstick2 then
                                    local v331 = Vector2.new(v330.Position.X, v330.Position.Y)
                                    if v331.Magnitude > 0.1 then
                                        local v332 = Vector2.new(v331.X * 0.5 * 60 * p325 * 4.75, v331.Y * 0.5 * 60 * p325 * 4.75)
                                        v_u_59 = v_u_59 + v332.X * 0.5
                                        v_u_58 = v_u_58 + v332.Y * 0.5
                                        local v333 = v_u_58
                                        v_u_58 = math.clamp(v333, -80, 80)
                                    end
                                elseif v330.KeyCode == Enum.KeyCode.ButtonR2 then
                                    if v330.Position.Z > 0.1 then
                                        local v334 = -v330.Position.Z * 2 * 30 * p325 * 0.55
                                        if v_u_49 ~= "Viewmodel" then
                                            local v335 = v_u_55 - v334 * 2
                                            v_u_55 = math.clamp(v335, 20, 70)
                                        end
                                    end
                                elseif v330.KeyCode == Enum.KeyCode.ButtonL2 and v330.Position.Z > 0.1 then
                                    local v336 = v330.Position.Z * 2 * 30 * p325 * 0.55
                                    if v_u_49 ~= "Viewmodel" then
                                        local v337 = v_u_55 - v336 * 2
                                        v_u_55 = math.clamp(v337, 20, 70)
                                    end
                                end
                            end
                        end
                    end
                    if v_u_49 == "Viewmodel" and v_u_37 then
                        v_u_37:render(p325)
                    elseif v_u_49 == "Weapon" then
                        local v338 = p325 * 10
                        local v339 = math.min(1, v338)
                        v_u_56 = v_u_56 + (v_u_58 - v_u_56) * v339
                        v_u_57 = v_u_57 + (v_u_59 - v_u_57) * v339
                        v_u_93()
                    end
                end), "Disconnect", "CameraUpdate")
                v_u_48:Add(v_u_3.InputBegan:Connect(function(p340, _)
                    if p340.UserInputType == Enum.UserInputType.MouseButton1 then
                        v_u_52 = true
                        v_u_53 = Vector2.new(p340.Position.X, p340.Position.Y)
                    end
                    local v341 = v_u_14.getActionKeybinds("Inspect")
                    if table.find(v341, p340.KeyCode) then
                        if v_u_27:GetAttribute("IsPlayerChatting") then
                            return
                        end
                        v_u_1.PlayInspectAnimation()
                    end
                    if p340.UserInputType == Enum.UserInputType.Touch then
                        v_u_61[p340] = Vector2.new(p340.Position.X, p340.Position.Y)
                        local v342 = 0
                        for _ in pairs(v_u_61) do
                            v342 = v342 + 1
                        end
                        if v342 == 1 then
                            v_u_52 = true
                            v_u_53 = Vector2.new(p340.Position.X, p340.Position.Y)
                        end
                        v_u_62 = v_u_96()
                    end
                end), "Disconnect", "InputBegan")
                v_u_48:Add(v_u_3.InputChanged:Connect(function(p343, _)
                    if p343.UserInputType == Enum.UserInputType.MouseMovement and v_u_52 then
                        local v344 = Vector2.new(p343.Position.X, p343.Position.Y)
                        local v345 = v344 - v_u_53
                        v_u_59 = v_u_59 + v345.X * 0.5
                        v_u_58 = v_u_58 + v345.Y * 0.5
                        local v346 = v_u_58
                        v_u_58 = math.clamp(v346, -80, 80)
                        v_u_53 = v344
                    end
                    if p343.UserInputType == Enum.UserInputType.Touch then
                        local v347 = Vector2.new(p343.Position.X, p343.Position.Y)
                        v_u_61[p343] = v347
                        local v348 = 0
                        for _ in pairs(v_u_61) do
                            v348 = v348 + 1
                        end
                        if v348 == 1 and v_u_52 then
                            local v349 = v347 - v_u_53
                            v_u_59 = v_u_59 + v349.X * 0.5
                            v_u_58 = v_u_58 + v349.Y * 0.5
                            local v350 = v_u_58
                            v_u_58 = math.clamp(v350, -80, 80)
                            v_u_53 = v347
                        end
                        if v348 >= 2 then
                            local v351 = v_u_96()
                            if v351 and v_u_62 then
                                local v352 = (v351 - v_u_62) * 0.01
                                if v_u_49 ~= "Viewmodel" then
                                    local v353 = v_u_55 - v352 * 2
                                    v_u_55 = math.clamp(v353, 20, 70)
                                end
                            end
                            v_u_62 = v351
                        end
                    end
                    if p343.UserInputType == Enum.UserInputType.MouseWheel then
                        local v354 = p343.Position.Z
                        if v_u_49 == "Viewmodel" then
                            return
                        end
                        local v355 = v_u_55 - v354 * 2
                        v_u_55 = math.clamp(v355, 20, 70)
                    end
                end), "Disconnect", "InputChanged")
                v_u_48:Add(v_u_3.InputEnded:Connect(function(p356, _)
                    if p356.UserInputType == Enum.UserInputType.MouseButton1 then
                        v_u_52 = false
                    end
                    if p356.UserInputType == Enum.UserInputType.Touch then
                        v_u_61[p356] = nil
                        local v357 = 0
                        for _ in pairs(v_u_61) do
                            v357 = v357 + 1
                        end
                        if v357 == 0 then
                            v_u_52 = false
                        end
                        v_u_62 = v_u_96()
                    end
                end), "Disconnect", "InputEnded")
                v_u_48:Add(function()
                    if v_u_44 then
                        v_u_44:Destroy()
                        v_u_44 = nil
                    end
                    if v_u_46 and v_u_46 == v_u_42 then
                        v_u_46.Parent = v_u_2
                        v_u_46 = nil
                    elseif v_u_46 then
                        v_u_46:Destroy()
                        v_u_46 = nil
                    end
                    v_u_52 = false
                    v_u_61 = {}
                    v_u_62 = nil
                    v_u_56 = 0
                    v_u_57 = 0
                    v_u_58 = 0
                    v_u_59 = 0
                    v_u_54 = 40
                    v_u_55 = 40
                    v_u_38 = nil
                end, true, "InspectCleanup")
                v_u_50 = true
                v_u_119()
            else
                warn("[InspectController]: Inspect scene missing WeaponPart")
                if v_u_46 then
                    v_u_46.Parent = v_u_2
                    v_u_46 = nil
                end
                v_u_73()
                v_u_318()
            end
        else
            warn("[InspectController]: Inspect scene missing CamPart")
            if v_u_46 then
                v_u_46.Parent = v_u_2
                v_u_46 = nil
            end
            v_u_73()
            v_u_318()
            return
        end
    else
        warn("[InspectController]: No preloaded inspect scene available")
        v_u_318()
        return
    end
end
function v_u_1.HideInspect(p358)
    if v_u_50 then
        v_u_48:Cleanup()
        if v_u_35 then
            if v_u_35.IsPlaying then
                v_u_35:Stop(0)
            end
            v_u_35:Destroy()
            v_u_35 = nil
        end
        if v_u_36 then
            v_u_36:Destroy()
            v_u_36 = nil
        end
        if v_u_37 then
            v_u_37:destroy()
            v_u_37 = nil
        end
        if v_u_40 then
            v_u_40:Destroy()
            v_u_40 = nil
        end
        v_u_14.enableGroup("Gameplay")
        if v_u_44 then
            v_u_44:Destroy()
            v_u_44 = nil
        end
        v_u_38 = nil
        if v_u_25.IsCaseSceneActive() then
            v_u_12.ApplyCaseSceneLighting()
        else
            v_u_73()
        end
        v_u_31.CameraType = Enum.CameraType.Custom
        v_u_13.updateCameraFOV(v_u_26.DEFAULT_CAMERA_FOV)
        v_u_13.setForceLockOverride("Inspect", false)
        if p358 then
            v_u_25.ExitInspect()
            v_u_43 = false
        else
            v_u_318()
        end
        if v_u_25.IsCaseSceneActive() then
            v_u_47 = {}
        else
            v_u_304()
        end
        v_u_63 = nil
        v_u_64 = 1
        v_u_50 = false
        v_u_119()
    end
end
function v_u_1.IsActive()
    return v_u_50
end
function v_u_1.ToggleInspect(p359)
    if v_u_50 then
        v_u_1.HideInspect()
    elseif p359 then
        v_u_1.ShowInspect(p359)
    end
end
function v_u_1.CycleCharmPosition()
    if v_u_50 and v_u_63 then
        v_u_64 = v_u_64 % 4 + 1
        local v360 = v_u_64
        v_u_1.RefreshWeaponWithCharm((tostring(v360)))
    end
end
function v_u_1.RefreshWeaponWithCharm(p361)
    if v_u_50 and (v_u_46 and v_u_63) then
        local v362 = v_u_46
        local v363 = v_u_63
        if v362:FindFirstChild("WeaponPart") then
            local v364 = v_u_56
            local v365 = v_u_57
            local v366 = v_u_58
            local v367 = v_u_59
            local v368 = v363.Charm
            local v369 = type(v368) == "table" and {
                ["_id"] = v368._id,
                ["Position"] = p361
            } or p361
            if v_u_49 == "Weapon" then
                if v_u_44 then
                    v_u_44:Destroy()
                    v_u_44 = nil
                end
                local v370 = v_u_21.GetCharacterModel(v363.Name, v363.Skin, v363.Float, v363.StatTrack, v363.NameTag, v369, v363.Stickers)
                if not v370 then
                    warn((("[InspectController]: Failed to refresh weapon model for charm position %*"):format(p361)))
                    return
                end
                v370.Name = "InspectWeapon"
                v_u_44 = v370
                v_u_38 = v370:FindFirstChild("InspectPivot", true)
                local v371 = v370:FindFirstChild("CharmBase", true)
                for _, v372 in ipairs(v370:GetDescendants()) do
                    if v372:IsA("BasePart") then
                        local v373
                        if v371 then
                            v373 = v372:IsDescendantOf(v371)
                        else
                            v373 = v371
                        end
                        v372.CastShadow = false
                        if v373 then
                            v372.Anchored = false
                        else
                            v372.CanCollide = v372:IsA("MeshPart") and true or false
                            v372.CanQuery = false
                            v372.CanTouch = false
                            v372.Anchored = true
                        end
                    end
                end
                v370.Parent = v362
                v_u_56 = v364
                v_u_57 = v365
                v_u_58 = v366
                v_u_59 = v367
                v_u_93()
            end
            if v_u_37 and v_u_40 then
                v_u_37.Charm = v369
                v_u_37:construct(v_u_40, nil)
            end
        end
    else
        return
    end
end
function v_u_1.GetCurrentCharmPosition()
    return v_u_64
end
function v_u_1.PlayInspectAnimation()
    if v_u_49 == "Viewmodel" and v_u_37 then
        local v374 = v_u_39
        local v375
        if v374 then
            if v374.Type == "Glove" then
                v375 = true
            elseif v374.Name then
                local v376, v377 = pcall(v_u_18, v374.Name)
                if v376 and (v377 and v377.Class) then
                    v375 = v377.Class == "Glove"
                else
                    v375 = false
                end
            else
                v375 = false
            end
        else
            v375 = false
        end
        if v375 then
            if v_u_35 then
                if v_u_37 and v_u_37.Animation then
                    v_u_37.Animation:stopAnimations()
                end
                if v_u_35.IsPlaying then
                    v_u_35:Stop(0)
                end
                v_u_35.TimePosition = 0
                v_u_35:Play(0, 1, 1)
            end
        elseif v_u_37.Animation then
            v_u_37.Animation:stopAnimations()
            v_u_37.Animation:play("Idle")
            v_u_37.Animation:play("Inspect")
        end
    else
        return
    end
end
function v_u_1.Initialize()
    v_u_15.CreateListener(v_u_27, "Settings.Video.Presets.Global Shadows", function()
        if v_u_15.Get(v_u_27, "Settings.Video.Presets.Global Shadows") ~= false then
            if v_u_41 ~= nil then
                v_u_7.GlobalShadows = v_u_41
            end
        else
            v_u_7.GlobalShadows = false
        end
    end)
    local v378 = v_u_86()
    if v378 then
        v_u_45 = v378.Name
        v_u_42 = v378
        if v_u_42 then
            v_u_42.Name = "InspectScene"
            v_u_42.Parent = v_u_2
        end
    else
        warn("[InspectController]: No inspect scene found to preload in ReplicatedStorage.Assets.InspectScenes")
    end
    v_u_3.InputBegan:Connect(function(p379, p380)
        if not p380 then
            if p379.KeyCode == Enum.KeyCode.Escape and v_u_50 then
                v_u_1.HideInspect()
            end
        end
    end)
    v_u_27.CharacterAdded:Connect(function()
        if v_u_50 then
            v_u_1.HideInspect()
        end
    end)
    v_u_24.observerRouter("WeaponInspect", function(p381, p382, p383, p384, p385, p386, p387, p388, p389, p390, p391, p392)
        if not require(v_u_2.Controllers.EndScreenController).IsActive() then
            local v393 = {
                ["_id"] = p390 or "inspect_" .. p381 .. "_" .. p382,
                ["Name"] = p381,
                ["Skin"] = p382,
                ["Float"] = p383,
                ["StatTrack"] = p384,
                ["NameTag"] = p385,
                ["Charm"] = p386,
                ["Stickers"] = p387,
                ["Type"] = p388,
                ["Pattern"] = p389,
                ["Serial"] = p391,
                ["IsTradeable"] = p392
            }
            v_u_1.ShowInspect(v393)
        end
    end)
    v_u_24.observerRouter("WeaponInspectClose", function()
        v_u_1.HideInspect()
    end)
    v_u_24.observerRouter("WeaponInspectCloseForGameEnd", function()
        v_u_1.HideInspect(true)
    end)
    v_u_24.observerRouter("IsInspectActive", function()
        return v_u_1.IsActive()
    end)
    v_u_24.observerRouter("GetCurrentCharmPosition", function()
        return v_u_64
    end)
end
function v_u_1.Start()
    v_u_113()
end
return v_u_1