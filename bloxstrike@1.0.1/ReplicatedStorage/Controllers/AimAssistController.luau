local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Workspace")
local v_u_4 = game:GetService("Players")
local v5 = game:GetService("UserInputService")
local v_u_6 = v_u_4.LocalPlayer
local v_u_7 = require(v2.Controllers.DataController)
local v_u_8 = require(v2.Components.Common.VFXLibary.FlashEffect)
local v9 = require(v2.Components.Common.GetUserPlatform)
local v10 = require(v2.Database.Custom.Constants)
local v11 = v9()
local v_u_12
if table.find(v11, "Mobile") == nil then
    v_u_12 = false
else
    v_u_12 = #v11 <= 1
end
local v_u_13 = v5.GamepadEnabled
local v14
if table.find(v11, "Console") == nil then
    v14 = false
else
    v14 = table.find(v11, "PC") == nil
end
local v15 = table.find(v10.AIM_ASSIST_WHITELIST, v_u_6.UserId) ~= nil
local v_u_16
if v_u_12 then
    v_u_16 = v_u_12
elseif v_u_13 then
    v_u_16 = v14 or v15
else
    v_u_16 = v15
end
local v_u_17 = v_u_3.CurrentCamera
local v_u_18 = false
local v_u_19 = v15 and v10.AIM_ASSIST_CONFIGS.DEVELOPER or v10.AIM_ASSIST_CONFIGS.PLAYER
local function v_u_51(p20, p21, p22)
    local function v45(p23, p24, p25, p26, p27)
        local v28 = 0
        local v29 = p24.X
        local v30, v31
        if math.abs(v29) < 0.0001 then
            if p23.X < p25.X or p23.X > p26.X then
                return false
            end
            v30 = p27
            v31 = v28
        else
            local v32 = 1 / p24.X
            v30 = (p25.X - p23.X) * v32
            v31 = (p26.X - p23.X) * v32
            if v31 >= v30 then
                local v33 = v30
                v30 = v31
                v31 = v33
            end
            if v28 >= v31 then
                v31 = v28
            end
            if v30 >= p27 then
                v30 = p27
            end
            if v30 < v31 then
                return false
            end
        end
        local v34 = p24.Y
        if math.abs(v34) < 0.0001 then
            if p23.Y < p25.Y or p23.Y > p26.Y then
                return false
            end
        else
            local v35 = 1 / p24.Y
            local v36 = (p25.Y - p23.Y) * v35
            local v37 = (p26.Y - p23.Y) * v35
            if v37 >= v36 then
                local v38 = v36
                v36 = v37
                v37 = v38
            end
            if v31 >= v37 then
                v37 = v31
            end
            if v36 >= v30 then
                v36 = v30
            end
            if v36 < v37 then
                return false
            end
            v30 = v36
            v31 = v37
        end
        local v39 = p24.Z
        if math.abs(v39) < 0.0001 then
            if p23.Z < p25.Z or p23.Z > p26.Z then
                return false
            end
        else
            local v40 = 1 / p24.Z
            local v41 = (p25.Z - p23.Z) * v40
            local v42 = (p26.Z - p23.Z) * v40
            if v42 >= v41 then
                local v43 = v41
                v41 = v42
                v42 = v43
            end
            if v31 >= v42 then
                v42 = v31
            end
            if v41 >= v30 then
                v41 = v30
            end
            if v41 < v42 then
                return false
            end
            v31 = v42
        end
        local v44
        if v31 >= 0 then
            v44 = v31 <= p27
        else
            v44 = false
        end
        return v44
    end
    local v46 = v_u_3:FindFirstChild("Debris")
    if not v46 then
        return false
    end
    for _, v47 in ipairs(v46:GetChildren()) do
        if v47.Name:match("^VoxelSmoke_") and v47:IsA("Folder") then
            for _, v48 in ipairs(v47:GetChildren()) do
                if v48:IsA("BasePart") and v48.Name == "SmokeVoxel" then
                    local v49 = v48.Size
                    local v50 = v48.Position
                    if v45(p20, p21, v50 - v49 / 2, v50 + v49 / 2, p22) then
                        return true
                    end
                end
            end
        end
    end
    return false
end
local function v_u_57(p52, p53)
    if p52 and p53 then
        local v54 = p52:GetAttribute("Team")
        local v55 = p53:GetAttribute("Team")
        if v54 and v55 then
            local v56 = {
                ["Counter-Terrorists"] = true,
                ["Terrorists"] = true
            }
            if v56[v54] and v56[v55] then
                return workspace:GetAttribute("Gamemode") == "Deathmatch" and true or v54 ~= v55
            else
                return false
            end
        else
            return false
        end
    else
        return false
    end
end
local function v_u_65(p58, p59)
    if not (p58 and p58.PrimaryPart) then
        return false
    end
    local v60 = not (p58 and p58.PrimaryPart) and Vector3.new(0, 0, 0) or p58.PrimaryPart.Position
    local v61 = (v60 - p59).Unit
    local v62 = (v60 - p59).Magnitude
    if v_u_51(p59, v61, v62) then
        return false
    end
    local v63 = RaycastParams.new()
    v63.FilterType = Enum.RaycastFilterType.Exclude
    v63.FilterDescendantsInstances = { v_u_6.Character }
    local v64 = v_u_3:Raycast(p59, v61 * v62, v63)
    return not v64 and true or (p58:IsAncestorOf(v64.Instance) and true or false)
end
local function v_u_81(p66)
    local v67 = 0
    local v68 = nil
    for _, v69 in ipairs(v_u_4:GetPlayers()) do
        if v69 ~= v_u_6 and v_u_57(v_u_6, v69) then
            local v70 = v69.Character
            if v70 and v70.PrimaryPart then
                local v71 = v70:FindFirstChildOfClass("Humanoid")
                if v71 and (v71.Health > 0 and v70:GetAttribute("Dead") ~= true) then
                    local v72 = not (v70 and v70.PrimaryPart) and Vector3.new(0, 0, 0) or v70.PrimaryPart.Position
                    local v73 = p66.Position
                    local v74 = (v72 - v73).Magnitude
                    if v_u_19.TargetSelection.MaxDistance >= v74 then
                        local v75 = p66.Position
                        local v76 = p66.LookVector:Dot((v72 - v75).Unit)
                        local v77 = math.clamp(v76, -1, 1)
                        local v78 = math.acos(v77)
                        if v_u_19.TargetSelection.MaxAngle >= v78 and v_u_65(v70, v73) then
                            local v79 = v78 / v_u_19.TargetSelection.MaxAngle
                            local v80 = 1 / (v74 + 1) * (1 - v79)
                            if v67 < v80 then
                                v68 = v70
                                v67 = v80
                            end
                        end
                    end
                end
            end
        end
    end
    return v68
end
local function v_u_95(p82, p83)
    if v_u_19.Friction.Enabled and p83 then
        if v_u_17 and p83.PrimaryPart then
            local v84 = not (p83 and p83.PrimaryPart) and Vector3.new(0, 0, 0) or p83.PrimaryPart.Position
            local v85 = p82.Position
            local v86, v87 = v_u_17:WorldToViewportPoint(v84)
            if v87 and v86.Z >= 0 then
                local v88 = v_u_17.ViewportSize / 2
                local v89 = Vector2.new(v88.X, v88.Y)
                local v90 = (Vector2.new(v86.X, v86.Y) - v89).Magnitude
                local v91 = (v84 - v85).Magnitude
                local v92 = 2 / v91 * v88.Y * 2
                local v93 = v_u_19.Friction.BubbleRadius * (v88.Y / v91) * 2
                if v93 + v92 / 2 < v90 then
                    return v_u_19.Friction.MaxSensitivity
                else
                    local v94 = v90 - v92 / 2
                    if math.max(0, v94) <= v93 then
                        return v_u_19.Friction.MinSensitivity
                    else
                        return v_u_19.Friction.MaxSensitivity
                    end
                end
            else
                return v_u_19.Friction.MaxSensitivity
            end
        else
            return v_u_19.Friction.MaxSensitivity
        end
    else
        return v_u_19.Friction.MaxSensitivity
    end
end
function v1.IsEnabled()
    return v_u_18
end
function v1.SetEnabled(p96)
    v_u_18 = p96
end
function v1.GetBestTarget()
    if v_u_16 then
        if v_u_18 and v_u_19.TargetSelection.Enabled then
            if v_u_8.IsFlashed() then
                return nil
            elseif v_u_17 and v_u_6.Character then
                return v_u_81(v_u_17.CFrame)
            else
                return nil
            end
        else
            return nil
        end
    else
        return nil
    end
end
function v1.GetFrictionMultiplier()
    if not v_u_16 then
        return v_u_19.Friction.MaxSensitivity
    end
    if not (v_u_18 and v_u_19.Friction.Enabled) then
        return v_u_19.Friction.MaxSensitivity
    end
    if v_u_8.IsFlashed() then
        return v_u_19.Friction.MaxSensitivity
    end
    if not (v_u_17 and v_u_6.Character) then
        return v_u_19.Friction.MaxSensitivity
    end
    local v97 = v_u_17.CFrame
    return v_u_95(v97, (v_u_81(v97)))
end
local function v_u_114(p98)
    local v99 = p98.Position
    local v100 = v_u_19.Magnetism.MaxDistance
    local v101 = RaycastParams.new()
    v101.FilterType = Enum.RaycastFilterType.Exclude
    v101.FilterDescendantsInstances = { v_u_6.Character }
    local v102 = v_u_19.Magnetism.MaxAngleHorizontal / 2
    local v103 = v_u_19.Magnetism.MaxAngleVertical / 2
    for v104 = -1, 1 do
        for v105 = -1, 1 do
            local v106 = v104 * v102
            local v107 = v105 * v103
            local v108 = (p98 * CFrame.Angles(v107, v106, 0)).LookVector
            local v109 = v_u_3:Raycast(v99, v108 * v100, v101)
            if v109 then
                local v110 = v109.Instance:FindFirstAncestorOfClass("Model")
                if v110 and v110:FindFirstChildOfClass("Humanoid") then
                    local v111 = v_u_4:GetPlayerFromCharacter(v110)
                    if v111 and v_u_57(v_u_6, v111) then
                        local v112 = v110:FindFirstChildOfClass("Humanoid")
                        if v112 and (v112.Health > 0 and v110:GetAttribute("Dead") ~= true) then
                            local v113 = (v109.Position - v99).Magnitude
                            if v113 <= v100 and not v_u_51(v99, v108, v113) then
                                return v110
                            end
                        end
                    end
                end
            end
        end
    end
    return nil
end
local function v_u_140(p115, p116, p117)
    if p116 and p116.PrimaryPart then
        local v118 = not (p116 and p116.PrimaryPart) and Vector3.new(0, 0, 0) or p116.PrimaryPart.Position
        local v119 = p115.Position
        local v120 = p115.LookVector
        if (v118 - v119).Magnitude > v_u_19.Magnetism.MaxDistance then
            return Vector2.zero
        else
            local v121 = (v118 - v119).Unit
            local v122 = v120.X
            local v123 = v120.Z
            local v124 = Vector3.new(v122, 0, v123).Unit
            local v125 = v121.X
            local v126 = v121.Z
            local v127 = v124:Dot(Vector3.new(v125, 0, v126).Unit)
            local v128 = math.clamp(v127, -1, 1)
            local v129 = math.acos(v128)
            if v_u_19.Magnetism.MaxAngleHorizontal < v129 then
                return Vector2.zero
            elseif v129 <= v_u_19.Magnetism.StopThreshold then
                return Vector2.zero
            elseif v129 > 1.5707963267948966 then
                return Vector2.zero
            else
                local v130 = -v120.X
                local v131 = -v120.Z
                local v132 = math.atan2(v130, v131)
                local v133 = -v121.X
                local v134 = -v121.Z
                local v135 = math.atan2(v133, v134) - v132
                if v135 > 3.141592653589793 then
                    v135 = v135 - 6.283185307179586
                elseif v135 < -3.141592653589793 then
                    v135 = v135 + 6.283185307179586
                end
                local v136 = math.abs(v135)
                if v136 < 0.001 then
                    return Vector2.zero
                else
                    local v137 = v_u_19.Magnetism.PullStrength * p117
                    local v138 = math.min(v137, v136)
                    local v139 = v135 > 0 and 1 or -1
                    if v139 == v139 then
                        return Vector2.new(v139 * v138, 0)
                    else
                        return Vector2.zero
                    end
                end
            end
        end
    else
        return Vector2.zero
    end
end
local function v_u_161(p141, p142, p143, p144)
    local v145 = p142:FindFirstChild("Head")
    local v146
    if v145 then
        v146 = v145.Position
    else
        v146 = nil
    end
    if not v146 then
        return 0
    end
    local v147 = v_u_19.VerticalMagnetism
    local v148 = p141.Position
    local v149 = p141.LookVector
    if (v146 - v148).Magnitude > v147.MaxDistance then
        return 0
    end
    local v150 = (v146 - v148).Unit
    local v151 = v149.Y
    local v152 = math.clamp(v151, -1, 1)
    local v153 = math.asin(v152)
    local v154 = v150.Y
    local v155 = math.clamp(v154, -1, 1)
    local v156 = math.asin(v155) - v153
    local v157 = math.abs(v156)
    if not p144 and v147.MaxAngleVertical < v157 then
        return 0
    end
    if v157 <= v147.StopThreshold then
        return 0
    end
    if v157 < 0.001 then
        return 0
    end
    local v158 = v147.PullStrength * p143
    local v159 = math.min(v158, v157)
    local v160 = v156 > 0 and 1 or -1
    return v160 ~= v160 and 0 or v160 * v159
end
function v1.GetMagnetismRotation(p162)
    if not v_u_16 then
        return Vector2.zero
    end
    if not (v_u_18 and v_u_19.Magnetism.Enabled) then
        return Vector2.zero
    end
    if v_u_8.IsFlashed() then
        return Vector2.zero
    end
    if not (v_u_17 and v_u_6.Character) then
        return Vector2.zero
    end
    local v163 = p162 or 0.016666666666666666
    local v164 = v_u_17.CFrame
    local v165 = v_u_81(v164) or v_u_114(v164)
    if not v165 then
        return Vector2.zero
    end
    local v166 = v_u_140(v164, v165, v163)
    local v167 = v166.X
    local v168 = math.abs(v167) > 0.0001
    local v169 = not v_u_19.VerticalMagnetism.Enabled and 0 or v_u_161(v164, v165, v163, v168)
    local v170 = Vector2.new(v166.X, v169)
    if v_u_13 then
        v170 = v170 * 0.5
    end
    return v170
end
function v1.GetRecoilAssistMultiplier()
    if not v_u_16 then
        return 0
    end
    if not (v_u_18 and v_u_19.RecoilAssist.Enabled) then
        return 0
    end
    if v_u_8.IsFlashed() then
        return 0
    end
    if v_u_19.RecoilAssist.RequiresTarget then
        if not (v_u_17 and v_u_6.Character) then
            return 0
        end
        if not v_u_81(v_u_17.CFrame) then
            return 0
        end
    end
    return v_u_19.RecoilAssist.ReductionAmount
end
function v1.Initialize()
    v_u_18 = v_u_16
    v_u_7.CreateListener(v_u_6, "Settings.Game.Other.Mobile Aim Assist", function(p171)
        if v_u_12 then
            v_u_18 = p171 ~= false
        end
    end)
    v_u_7.CreateListener(v_u_6, "Settings.Game.Other.Controller Aim Assist", function(p172)
        if v_u_13 then
            v_u_18 = p172 ~= false
        end
    end)
end
return v1