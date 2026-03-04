local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("CollectionService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("HttpService")
local v_u_6 = game:GetService("RunService")
local v_u_7 = game:GetService("GuiService")
local v_u_8 = game:GetService("Workspace")
local v_u_9 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_10 = v_u_9.LocalPlayer
local v_u_11 = require(v2.Controllers.CharacterController)
local v_u_12 = require(v2.Controllers.SpectateController)
local v_u_13 = require(v2.Controllers.DataController)
local v_u_14 = require(v2.Database.Custom.GameStats.Settings.Colors)
local v_u_15 = require(v2.Components.Common.GetPreferenceColor)
local v16 = require(v2.Components.Common.GetUserPlatform)
local v_u_17 = require(v2.Database.Security.Remotes)
local v_u_18 = require(v2.Database.Security.Router)
local v_u_19 = require(v2.Shared.Janitor)
local v_u_20 = table.find(v16(), "Mobile")
if v_u_20 then
    v_u_20 = #v16() <= 1
end
local v_u_21 = v2.Assets.UI.Radar
local v_u_22 = workspace.CurrentCamera
local v_u_23 = v_u_20 and 120 or 200
local v_u_24 = v_u_8:WaitForChild("Debris")
local v_u_25 = {
    ["DeadTeammate"] = 13,
    ["LocalPlayer"] = 15,
    ["Teammate"] = 14,
    ["Enemy"] = 17,
    ["Bomb"] = 19,
    ["Site"] = 16,
    ["EnemyQuestionMark"] = 20,
    ["Hostage"] = 18
}
local v_u_26 = Color3.fromRGB(255, 0, 0)
local v_u_27 = nil
local v_u_28 = {
    ["CentersPlayer"] = true,
    ["Rotation"] = false,
    ["Zoom"] = 0.7,
    ["Scale"] = 1
}
local v_u_29 = nil
local function v_u_35()
    local v30 = workspace:FindFirstChild("Map")
    if not v30 then
        return nil
    end
    local v31 = v_u_3:GetTagged("Minimap")
    for _, v32 in ipairs(v31) do
        if v32:IsA("BasePart") and v32:IsDescendantOf(v30) then
            local v33 = v32:FindFirstChild("Lower")
            local v34 = v32:FindFirstChild("Upper")
            return {
                ["Size"] = v32.Size,
                ["Upper"] = v34,
                ["Lower"] = v33,
                ["Part"] = v32
            }
        end
    end
    return nil
end
local function v_u_39(p_u_36, p37, p38)
    if v_u_29 then
        v_u_29:Destroy()
        v_u_29 = nil
    end
    v_u_29 = v_u_1.new(v_u_27, p_u_36)
    if v_u_29 then
        v_u_29.LocalPlayer = p37
        v_u_29.Team = p37:GetAttribute("Team")
        v_u_29.IsSpectating = p38 or false
        if p38 then
            v_u_29.MapImage.Rotation = 90
            if v_u_29.UpperMapImage then
                v_u_29.UpperMapImage.Rotation = 90
            end
        end
    end
    if v_u_29 and p_u_36 then
        v_u_29.Janitor:Add(p_u_36:GetAttributeChangedSignal("Dead"):Connect(function()
            if v_u_29 and p_u_36:GetAttribute("Dead") then
                v_u_29:Destroy()
                v_u_29 = nil
            end
        end))
    end
end
local function v_u_46()
    local v40 = v_u_3:GetTagged("PlantArea")
    local v41 = {}
    for _, v42 in ipairs(v40) do
        if v42:IsA("BasePart") then
            local v43 = v42:GetAttribute("Site")
            if v43 and (v43 == "A" or v43 == "B") then
                if not v41[v43] then
                    v41[v43] = {}
                end
                local v44 = v41[v43]
                local v45 = v42.CFrame
                table.insert(v44, v45)
            end
        end
    end
    return v41
end
local function v_u_78(p47, p48, p49)
    local function v72(p50, p51, p52, p53, p54)
        local v55 = 0
        local v56 = p51.X
        local v57, v58
        if math.abs(v56) < 0.0001 then
            if p50.X < p52.X or p50.X > p53.X then
                return false
            end
            v57 = p54
            v58 = v55
        else
            local v59 = 1 / p51.X
            v57 = (p52.X - p50.X) * v59
            v58 = (p53.X - p50.X) * v59
            if v58 >= v57 then
                local v60 = v57
                v57 = v58
                v58 = v60
            end
            if v55 >= v58 then
                v58 = v55
            end
            if v57 >= p54 then
                v57 = p54
            end
            if v57 < v58 then
                return false
            end
        end
        local v61 = p51.Y
        if math.abs(v61) < 0.0001 then
            if p50.Y < p52.Y or p50.Y > p53.Y then
                return false
            end
        else
            local v62 = 1 / p51.Y
            local v63 = (p52.Y - p50.Y) * v62
            local v64 = (p53.Y - p50.Y) * v62
            if v64 >= v63 then
                local v65 = v63
                v63 = v64
                v64 = v65
            end
            if v58 >= v64 then
                v64 = v58
            end
            if v63 >= v57 then
                v63 = v57
            end
            if v63 < v64 then
                return false
            end
            v57 = v63
            v58 = v64
        end
        local v66 = p51.Z
        if math.abs(v66) < 0.0001 then
            if p50.Z < p52.Z or p50.Z > p53.Z then
                return false
            end
        else
            local v67 = 1 / p51.Z
            local v68 = (p52.Z - p50.Z) * v67
            local v69 = (p53.Z - p50.Z) * v67
            if v69 >= v68 then
                local v70 = v68
                v68 = v69
                v69 = v70
            end
            if v58 >= v69 then
                v69 = v58
            end
            if v68 >= v57 then
                v68 = v57
            end
            if v68 < v69 then
                return false
            end
            v58 = v69
        end
        local v71
        if v58 >= 0 then
            v71 = v58 <= p54
        else
            v71 = false
        end
        return v71
    end
    local v73 = v_u_24
    if v73 then
        for _, v74 in ipairs(v73:GetChildren()) do
            if v74.Name:match("^VoxelSmoke_") and v74:IsA("Folder") then
                for _, v75 in ipairs(v74:GetChildren()) do
                    if v75:IsA("BasePart") and v75.Name == "SmokeVoxel" then
                        local v76 = v75.Size
                        local v77 = v75.Position
                        if v72(p47, p48, v77 - v76 / 2, v77 + v76 / 2, p49) then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end
local function v_u_94(p79, p80, p81)
    if not (p79 and p79.PrimaryPart) then
        return false
    end
    local v82 = p79.PrimaryPart.Position + Vector3.new(0, 1.5, 0)
    for _, v83 in ipairs(v_u_9:GetPlayers()) do
        if v83 ~= p80 and v83:GetAttribute("Team") == p81 then
            local v84 = v83.Character
            if v84 and v84.PrimaryPart then
                local v85 = v84.PrimaryPart
                local v86 = v85.Position + Vector3.new(0, 1.5, 0)
                local v87 = (v82 - v86).Magnitude
                if v87 <= 200 then
                    local v88 = (v82 - v86).Unit
                    if v88:Dot(v85.CFrame.LookVector) > 0.5 and not v_u_78(v86, v88, v87) then
                        local v89 = v_u_3:GetTagged("Hostage")
                        local v90 = { v84, p79 }
                        for _, v91 in ipairs(v89) do
                            if v91:IsA("Model") then
                                table.insert(v90, v91)
                            end
                        end
                        local v92 = RaycastParams.new()
                        v92.FilterType = Enum.RaycastFilterType.Exclude
                        v92.FilterDescendantsInstances = v90
                        local v93 = v_u_8:Raycast(v86, v88 * v87, v92)
                        if not v93 or v93.Instance:IsDescendantOf(p79) then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end
local function v_u_115(p95, p96, _, p97)
    local v98 = p97 or v_u_10
    for _, v99 in ipairs(v_u_9:GetPlayers()) do
        if v99:GetAttribute("Team") == "Counter-Terrorists" then
            local v100 = v99.Character
            if v100 and v100.PrimaryPart then
                local v101, v102, v103
                if v99 == v98 then
                    if v_u_22 then
                        local v104 = v_u_22.CFrame
                        v101 = v104.Position
                        local v105 = v104.LookVector
                        local v106 = p95 - v101
                        v102 = v106.Magnitude
                        if v102 <= 200 and v102 > 0 then
                            v103 = v106.Unit
                            if v103:Dot(v105) > 0.5 then
                                ::l15::
                                local v107 = { v100 }
                                if p96 then
                                    table.insert(v107, p96)
                                end
                                local v108 = v_u_3:GetTagged("Hostage")
                                for _, v109 in ipairs(v108) do
                                    if v109:IsA("Model") then
                                        table.insert(v107, v109)
                                    end
                                end
                                if not v_u_78(v101, v103, v102) then
                                    local v110 = RaycastParams.new()
                                    v110.FilterType = Enum.RaycastFilterType.Exclude
                                    v110.FilterDescendantsInstances = v107
                                    local v111 = v_u_8:Raycast(v101, v103 * v102, v110)
                                    if not v111 then
                                        return true
                                    end
                                    if p96 and v111.Instance:IsDescendantOf(p96) then
                                        return true
                                    end
                                end
                            end
                        end
                    end
                else
                    local v112 = v100.PrimaryPart
                    v101 = v112.Position + Vector3.new(0, 1.5, 0)
                    local v113 = v112.CFrame.LookVector
                    local v114 = p95 - v101
                    v102 = v114.Magnitude
                    if v102 <= 200 and v102 > 0 then
                        v103 = v114.Unit
                        if v103:Dot(v113) > 0.5 then
                            goto l15
                        end
                    end
                end
            end
        end
    end
    return false
end
local function v_u_136(p116, p117, _, p118)
    local v119 = p118 or v_u_10
    for _, v120 in ipairs(v_u_9:GetPlayers()) do
        if v120:GetAttribute("Team") == "Terrorists" then
            local v121 = v120.Character
            if v121 and v121.PrimaryPart then
                local v122, v123, v124
                if v120 == v119 then
                    if v_u_22 then
                        local v125 = v_u_22.CFrame
                        v122 = v125.Position
                        local v126 = v125.LookVector
                        local v127 = p116 - v122
                        v123 = v127.Magnitude
                        if v123 <= 200 and v123 > 0 then
                            v124 = v127.Unit
                            if v124:Dot(v126) > 0.5 then
                                ::l15::
                                local v128 = v_u_3:GetTagged("Hostage")
                                local v129 = { v121 }
                                for _, v130 in ipairs(v128) do
                                    if v130:IsA("Model") then
                                        table.insert(v129, v130)
                                    end
                                end
                                if not v_u_78(v122, v124, v123) then
                                    local v131 = RaycastParams.new()
                                    v131.FilterType = Enum.RaycastFilterType.Exclude
                                    v131.FilterDescendantsInstances = v129
                                    local v132 = v_u_8:Raycast(v122, v124 * v123, v131)
                                    if not v132 then
                                        return true
                                    end
                                    if p117 and v132.Instance:IsDescendantOf(p117) then
                                        return true
                                    end
                                end
                            end
                        end
                    end
                else
                    local v133 = v121.PrimaryPart
                    v122 = v133.Position + Vector3.new(0, 1.5, 0)
                    local v134 = v133.CFrame.LookVector
                    local v135 = p116 - v122
                    v123 = v135.Magnitude
                    if v123 <= 200 and v123 > 0 then
                        v124 = v135.Unit
                        if v124:Dot(v134) > 0.5 then
                            goto l15
                        end
                    end
                end
            end
        end
    end
    return false
end
local function v_u_142(p137, p138, p139)
    local v140 = nil
    if p138 == "Teammate" then
        v140 = v_u_21.Player:Clone()
        v140.ZIndex = v_u_25.Teammate
    elseif p138 == "Enemy" then
        v140 = v_u_21.Enemy:Clone()
        v140.ZIndex = v_u_25.Enemy
    elseif p138 == "DeadTeammate" then
        v140 = v_u_21.Dead:Clone()
        v140.ZIndex = v_u_25.DeadTeammate
    end
    if not v140 then
        error((("Invalid icon type: %*"):format(p138)))
    end
    v140.Position = UDim2.fromScale(0.5, 0.5)
    v140.AnchorPoint = Vector2.new(0.5, 0.5)
    v140.Size = UDim2.fromOffset(p139, p139)
    v140.Parent = p137
    for _, v141 in ipairs(v140:GetChildren()) do
        if v141.Name == "Direction" and v141:IsA("ImageLabel") then
            v141.Visible = false
        end
    end
    return v140
end
local function v_u_154(p143, p144)
    local v145 = p143.X
    local v146 = p143.Z
    local v147 = Vector3.new(v145, 0, v146)
    local v148 = v147.Magnitude < 1e-6 and Vector3.new(0, 0, 1) or v147.Unit
    if p144 then
        v148 = p144.CFrame:VectorToObjectSpace(v148)
    end
    local v149 = v148.X
    local v150 = v148.Z
    local v151 = -v149
    local v152 = -v150
    local v153 = math.atan2(v152, v151)
    return (math.deg(v153) + 90) % 360
end
function v_u_1.WorldToRadar(p155, p156)
    if not p155.MinimapReference then
        return nil
    end
    if not (p155.Character and p155.Character.PrimaryPart) then
        return nil
    end
    local v157 = p155.MinimapReference
    local v158 = v157.Part
    local _ = p155.Character.PrimaryPart.Position
    local v159 = p155.ViewCenterLocal or Vector3.new(0, 0, 0)
    local _ = p155.Settings.CentersPlayer
    local v160 = v158.CFrame:PointToObjectSpace(p156)
    local v161 = v160.X - v159.X
    local v162 = v160.Z - v159.Z
    local v163 = -v161
    local v164 = -v162
    local v165 = p155.Settings.Zoom
    local v166 = v163 / v165
    local v167 = v164 / v165
    if p155.MapImage.Rotation ~= 0 then
        local v168 = -p155.MapImage.Rotation
        local v169 = math.rad(v168)
        local v170 = math.cos(v169)
        local v171 = math.sin(v169)
        v166 = v166 * v170 - v167 * v171
        v167 = v166 * v171 + v167 * v170
    end
    local v172 = v157.Size
    local v173 = v166 / v172.X + 0.5
    local v174 = v167 / v172.Z + 0.5
    return Vector2.new(v173, v174)
end
local function v_u_196(p175, p176, p177)
    local v178 = v_u_22.ViewportSize
    local v179 = v178.X
    local v180 = v178.Y
    local v181 = v_u_7:GetGuiInset().X
    local v182 = v181 + 50
    local v183 = p175.AnchorPoint or Vector2.new(0, 0)
    local v184
    if p177.X.Scale == 0 then
        v184 = p177.X.Offset
    else
        v184 = p177.X.Scale * v179 + p177.X.Offset
    end
    local v185
    if p177.Y.Scale == 0 then
        v185 = p177.Y.Offset
    else
        v185 = p177.Y.Scale * v180 + p177.Y.Offset
    end
    local v186, v187, v188, v189
    if v183.X == 0 and v183.Y == 0 then
        v186 = v184 + p176
        v187 = v185 + p176
        v188 = v185
        v189 = v184
    elseif v183.X == 0.5 and v183.Y == 0.5 then
        v189 = v184 - p176 / 2
        v188 = v185 - p176 / 2
        v186 = v184 + p176 / 2
        v187 = v185 + p176 / 2
    else
        v189 = v184 - v183.X * p176
        v188 = v185 - v183.Y * p176
        v186 = v189 + p176
        v187 = v188 + p176
    end
    local v190 = 0
    local v191 = v189 >= v181 + 10 and 0 or v181 + 10 - v189
    if v179 - 0 - 10 < v186 then
        v191 = v179 - 0 - 10 - v186
    end
    if v188 < v182 + 10 then
        v190 = v182 + 10 - v188
    end
    if v180 - 0 - 10 < v187 then
        v190 = v180 - 0 - 10 - v187
    end
    local v192 = v184 + v191
    local v193 = v185 + v190
    local v194
    if p177.X.Scale == 0 then
        v194 = UDim.new(0, v192)
    else
        v194 = UDim.new(0, v192)
    end
    local v195
    if p177.Y.Scale == 0 then
        v195 = UDim.new(0, v193)
    else
        v195 = UDim.new(0, v193)
    end
    return UDim2.new(v194, v195)
end
function v_u_1.UpdateIcon(p197, p198, p199, p200)
    local v201 = p197.Icons[p198]
    if v201 then
        local v202 = p197:WorldToRadar(p199)
        if v202 then
            local v203 = v202.X - 0.5
            local v204 = v202.Y - 0.5
            local v205 = v203 * v203 + v204 * v204
            local v206 = math.sqrt(v205)
            local v207 = v202.X
            local v208 = v202.Y
            if v206 > 0.5 then
                local v209 = v203 / v206
                local v210 = v204 / v206
                v207 = 0.5 + v209 * 0.5
                v208 = 0.5 + v210 * 0.5
            end
            v201.Instance.Visible = true
            v201.Instance.Position = UDim2.fromScale(v207, v208)
            if p200 then
                v201.Instance.Rotation = math.deg(p200)
            end
        else
            v201.Instance.Visible = false
        end
    else
        return
    end
end
function v_u_1.UpdateTeammateIcon(p211, p212, p213, p214)
    local v215 = p211.Icons[p212]
    if v215 then
        local v216 = v215.Instance
        if v216 and v216:IsA("GuiObject") then
            if p211.MinimapReference then
                local v217 = p211.MinimapReference
                local v218 = v217.Part
                local v219 = v217.Size
                local v220 = v218.CFrame:PointToObjectSpace(p213)
                local v221 = v220.X
                local v222 = v220.Z
                local v223 = -v221
                local v224 = -v222
                local v225 = v223 / v219.X + 0.5
                local v226 = v224 / v219.Z + 0.5
                local v227 = p211.MapImage.ImageRectOffset
                local v228 = p211.MapImage.ImageRectSize
                local v229 = v225 * 1024
                local v230 = v226 * 1024
                local v231 = v229 - v227.X
                local v232 = v230 - v227.Y
                local v233 = v231 / v228.X
                local v234 = v232 / v228.Y
                if p211.MapImage.Rotation ~= 0 then
                    local v235 = p211.MapImage.Rotation
                    local v236 = math.rad(v235)
                    local v237 = math.cos(v236)
                    local v238 = math.sin(v236)
                    local v239 = v233 - 0.5
                    local v240 = v234 - 0.5
                    v233 = 0.5 + (v239 * v237 - v240 * v238)
                    v234 = 0.5 + (v239 * v238 + v240 * v237)
                end
                local v241 = v233 - 0.5
                local v242 = v234 - 0.5
                local v243 = v241 * v241 + v242 * v242
                local v244 = math.sqrt(v243)
                if v244 > 0.5 then
                    local v245 = v241 / v244
                    local v246 = v242 / v244
                    v233 = 0.5 + v245 * 0.5
                    v234 = 0.5 + v246 * 0.5
                end
                v216.Position = UDim2.fromScale(v233, v234)
                v216.Visible = true
                if p214 and v216:IsA("ImageLabel") then
                    v216.Rotation = math.deg(p214)
                end
            else
                v216.Visible = false
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.CreatePlayerIcon(p247, p248, p249)
    local v250
    if p249 == "Enemy" then
        local v251 = p248:GetAttribute("Slot5")
        local v252 = v251 and v_u_5:JSONDecode(v251 or "[]")
        if v252 then
            v252 = v252.Weapon == "C4"
        end
        local v253 = p248:GetAttribute("IsCarryingHostage") == true
        if v252 then
            v250 = v_u_21.Bomb:Clone()
            v250.Size = UDim2.fromOffset(14, 14)
        elseif v253 then
            local v254 = v_u_21:FindFirstChild("Hostage")
            if v254 and v254:IsA("ImageLabel") then
                v250 = v254:Clone()
            else
                v250 = v_u_21.Player:Clone()
            end
            v250.Size = UDim2.fromOffset(30, 30)
        else
            v250 = v_u_21.Player:Clone()
            v250.Size = UDim2.fromOffset(12, 12)
        end
        v250.ImageColor3 = Color3.fromRGB(255, 0, 0)
        v250.ZIndex = v_u_25.Enemy
        v250.Position = UDim2.fromScale(0.5, 0.5)
        v250.AnchorPoint = Vector2.new(0.5, 0.5)
        v250.Parent = p247.RadarContainer
        for _, v255 in ipairs(v250:GetChildren()) do
            if v255.Name == "Direction" and v255:IsA("ImageLabel") then
                v255.Visible = false
            end
        end
    else
        local v256 = p248:GetAttribute("Team")
        local v257 = p248.Character
        local v258
        if v256 then
            v258 = v257 and v257:GetAttribute("CompetitivePlayerColor") or v_u_14["Team Color"][v256]
        else
            v258 = nil
        end
        v250 = v_u_142(p247.RadarContainer, p249, 12)
        if v258 then
            v250.ImageColor3 = v258
        end
        for _, v259 in ipairs(v250:GetChildren()) do
            if v259.Name == "Direction" and v259:IsA("ImageLabel") then
                v259.Visible = false
            end
        end
    end
    v250.Name = p248.Name
    local v260 = p248.UserId .. "_" .. p249
    p247.Icons[v260] = {
        ["Instance"] = v250,
        ["Player"] = p248,
        ["Target"] = nil,
        ["Type"] = p249
    }
    return v260
end
function v_u_1.RemoveIcon(p261, p262)
    local v263 = p261.Icons[p262]
    if v263 then
        v263.Instance:Destroy()
        p261.Icons[p262] = nil
    end
end
function v_u_1.RefreshPlayerIcon(p264, p265)
    local v266 = p265.UserId .. "_Player"
    local v267 = p265.UserId .. "_Dead"
    if p264.Icons[v266] then
        p264:RemoveIcon(v266)
    end
    if p264.Icons[v267] then
        p264:RemoveIcon(v267)
    end
    p264.EnemyVisibilityState[v266] = nil
    p264.EnemyLastSeenPositions[v266] = nil
    p264.EnemyLastSeenPositions[v266 .. "_Frozen"] = nil
    p264.DeadPlayerPositions[p265.UserId] = nil
    p264.FadedDeadIcons[v267] = nil
end
function v_u_1.RefreshIconsOnTeamChange(p268)
    local v269 = p268.Team
    local v270 = v_u_10:GetAttribute("Team")
    if v270 then
        p268.Team = v270
        if p268.Team ~= v269 then
            local v271 = {}
            for v272, v273 in pairs(p268.Icons) do
                if v273.Player and v273.Player ~= v_u_10 then
                    table.insert(v271, v272)
                end
            end
            for _, v274 in ipairs(v271) do
                p268:RemoveIcon(v274)
            end
            p268.EnemyVisibilityState = {}
            p268.EnemyLastSeenPositions = {}
            p268.DeadPlayerPositions = {}
            p268.FadedDeadIcons = {}
            if p268.Icons.LocalPlayer then
                local v275 = p268.Icons.LocalPlayer.Instance
                local v276 = p268.LocalPlayer
                local v277 = p268.Team
                local v278 = v276.Character
                local v279
                if v277 then
                    v279 = v278 and v278:GetAttribute("CompetitivePlayerColor") or v_u_14["Team Color"][v277]
                else
                    v279 = nil
                end
                if v279 then
                    v275.ImageColor3 = v279
                end
            end
        end
    else
        return
    end
end
function v_u_1.UpdatePlayerIcons(p_u_280, _)
    local v281 = v_u_8:GetAttribute("Gamemode") == "Deathmatch" and true or v_u_8:GetAttribute("ServerGamemode") == "Deathmatch"
    local v282 = p_u_280.MinimapReference
    if v282 then
        v282 = p_u_280.MinimapReference.Part
    end
    if p_u_280.Character and p_u_280.Character.PrimaryPart then
        if not p_u_280.Icons.LocalPlayer then
            local v283 = p_u_280.LocalPlayer
            local v284 = p_u_280.Team
            local v285 = v283.Character
            local v286
            if v284 then
                v286 = v285 and v285:GetAttribute("CompetitivePlayerColor") or v_u_14["Team Color"][v284]
            else
                v286 = nil
            end
            local v287 = v_u_21.Player:Clone()
            v287.Position = UDim2.fromScale(0.5, 0.5)
            v287.AnchorPoint = Vector2.new(0.5, 0.5)
            v287.ZIndex = v_u_25.LocalPlayer
            v287.Parent = p_u_280.RadarContainer
            v287.Name = "LocalPlayer"
            if v286 then
                v287.ImageColor3 = v286
            end
            p_u_280.Icons.LocalPlayer = {
                ["Instance"] = v287,
                ["Player"] = p_u_280.LocalPlayer,
                ["Target"] = nil,
                ["Type"] = "Teammate"
            }
        end
        local v288 = p_u_280.Icons.LocalPlayer.Instance
        v288.Visible = true
        local v289 = p_u_280.LocalPlayer:GetAttribute("Slot5")
        local v290 = v289 and v_u_5:JSONDecode(v289 or "[]")
        if v290 then
            v290 = v290.Weapon == "C4"
        end
        local v291 = v288.ImageColor3
        if v290 then
            v288.Image = v_u_21.Bomb.Image
            v288.Size = UDim2.fromOffset(14, 14)
            v288.ImageColor3 = v291
        else
            v288.Image = v_u_21.Player.Image
            v288.Size = UDim2.fromOffset(12, 12)
            v288.ImageColor3 = v291
        end
        local v292 = not (v282 and (p_u_280.Character and p_u_280.Character.PrimaryPart)) and 0 or v_u_154(p_u_280.Character.PrimaryPart.CFrame.LookVector, v282) + p_u_280.MapImage.Rotation + 0
        local _ = p_u_280.Settings.CentersPlayer
        v288.Position = UDim2.fromScale(0.5, 0.5)
        v288.Rotation = v292
    end
    for _, v293 in ipairs(v_u_9:GetPlayers()) do
        if v293 ~= p_u_280.LocalPlayer then
            local v294 = v293.Character
            local v295
            if v294 then
                v295 = v294.PrimaryPart
            else
                v295 = v294
            end
            local v296 = v293:GetAttribute("Team")
            if v296 and v296 ~= "Spectators" then
                local v297 = p_u_280.DeadPlayerPositions[v293.UserId]
                local v298 = v297 ~= nil
                local v299
                if v294 then
                    v299 = v294:GetAttribute("Dead") == true
                else
                    v299 = false
                end
                local v300 = v299 or v298
                local v301 = v296 == p_u_280.Team
                local v_u_302 = v293.UserId .. "_Player"
                local v303 = v293.UserId .. "_Dead"
                if v281 and v301 then
                    if p_u_280.Icons[v_u_302] then
                        p_u_280:RemoveIcon(v_u_302)
                    end
                    if p_u_280.Icons[v303] then
                        p_u_280:RemoveIcon(v303)
                    end
                    p_u_280.DeadPlayerPositions[v293.UserId] = nil
                    p_u_280.FadedDeadIcons[v303] = nil
                    p_u_280.EnemyVisibilityState[v_u_302] = nil
                    p_u_280.EnemyLastSeenPositions[v_u_302] = nil
                    p_u_280.EnemyLastSeenPositions[v_u_302 .. "_Frozen"] = nil
                elseif v300 then
                    if p_u_280.Icons[v_u_302] then
                        local v304 = p_u_280.Icons[v_u_302].Instance
                        if v304 and v304:IsA("GuiObject") then
                            v304.Visible = false
                        end
                        p_u_280:RemoveIcon(v_u_302)
                    end
                    if not v297 and v295 then
                        v297 = v295.Position
                        p_u_280.DeadPlayerPositions[v293.UserId] = v297
                    end
                    if v297 then
                        local v_u_305 = v293.UserId .. "_Dead"
                        if not (p_u_280.Icons[v_u_305] or p_u_280.FadedDeadIcons[v_u_305]) then
                            local v306 = v293:GetAttribute("Team")
                            local v307 = v_u_142(p_u_280.RadarContainer, "DeadTeammate", 12)
                            v307.Name = v293.Name .. "_Dead"
                            v307.ImageTransparency = 0
                            for _, v308 in ipairs(v307:GetChildren()) do
                                if v308.Name == "Direction" and v308:IsA("ImageLabel") then
                                    v308.Visible = false
                                end
                            end
                            if v301 then
                                local v309 = v293.Character
                                local v310
                                if v306 then
                                    v310 = v309 and v309:GetAttribute("CompetitivePlayerColor") or v_u_14["Team Color"][v306]
                                else
                                    v310 = nil
                                end
                                if v310 then
                                    v307.ImageColor3 = v310
                                end
                            else
                                v307.ImageColor3 = Color3.fromRGB(255, 0, 0)
                            end
                            local v311 = {
                                ["Instance"] = v307,
                                ["Player"] = v293,
                                ["Target"] = nil,
                                ["Type"] = "DeadTeammate",
                                ["DefaultSize"] = v_u_21.Dead.Size
                            }
                            p_u_280.Icons[v_u_305] = v311
                            if v297 and p_u_280.MinimapReference then
                                local v312 = p_u_280.MinimapReference
                                local v313 = v312.Part
                                local v314 = v312.Size
                                local v315 = v313.CFrame:PointToObjectSpace(v297)
                                local v316 = v315.X
                                local v317 = v315.Z
                                local v318 = -v316
                                local v319 = -v317
                                local v320 = v318 / v314.X + 0.5
                                local v321 = v319 / v314.Z + 0.5
                                local v322 = p_u_280.MapImage.ImageRectOffset
                                local v323 = p_u_280.MapImage.ImageRectSize
                                local v324 = v320 * 1024
                                local v325 = v321 * 1024
                                local v326 = v324 - v322.X
                                local v327 = v325 - v322.Y
                                local v328 = v326 / v323.X
                                local v329 = v327 / v323.Y
                                if p_u_280.MapImage.Rotation ~= 0 then
                                    local v330 = p_u_280.MapImage.Rotation
                                    local v331 = math.rad(v330)
                                    local v332 = math.cos(v331)
                                    local v333 = math.sin(v331)
                                    local v334 = v328 - 0.5
                                    local v335 = v329 - 0.5
                                    v328 = 0.5 + (v334 * v332 - v335 * v333)
                                    v329 = 0.5 + (v334 * v333 + v335 * v332)
                                end
                                local v336 = v328 - 0.5
                                local v337 = v329 - 0.5
                                local v338 = v336 * v336 + v337 * v337
                                local v339 = math.sqrt(v338)
                                if v339 > 0.5 then
                                    local v340 = v336 / v339
                                    local v341 = v337 / v339
                                    v328 = 0.5 + v340 * 0.5
                                    v329 = 0.5 + v341 * 0.5
                                end
                                v307.Position = UDim2.fromScale(v328, v329)
                                v307.Visible = true
                            end
                            task.delay(2, function()
                                local v342 = p_u_280.Icons[v_u_305]
                                if v342 and (v342.Instance and v342.Instance.Parent) then
                                    p_u_280.FadedDeadIcons[v_u_305] = true
                                    local v343 = v_u_4:Create(v342.Instance, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                        ["ImageTransparency"] = 1
                                    })
                                    v343:Play()
                                    v343.Completed:Connect(function()
                                        if p_u_280.Icons[v_u_305] then
                                            p_u_280:RemoveIcon(v_u_305)
                                        end
                                    end)
                                end
                            end)
                        end
                    end
                    if not v301 then
                        p_u_280.EnemyVisibilityState[v_u_302] = nil
                        p_u_280.EnemyLastSeenPositions[v_u_302] = nil
                        p_u_280.EnemyLastSeenPositions[v_u_302 .. "_Frozen"] = nil
                    end
                else
                    if v294 and v295 then
                        local v344 = v293.UserId .. "_Dead"
                        if p_u_280.Icons[v344] then
                            p_u_280:RemoveIcon(v344)
                        end
                        p_u_280.DeadPlayerPositions[v293.UserId] = nil
                        p_u_280.FadedDeadIcons[v344] = nil
                        if not p_u_280.Icons[v_u_302] then
                            if v301 then
                                local v345 = p_u_280:CreatePlayerIcon(v293, "Teammate")
                                p_u_280.Icons[v_u_302] = p_u_280.Icons[v345]
                                p_u_280.Icons[v345] = nil
                            else
                                local v346 = p_u_280:CreatePlayerIcon(v293, "Enemy")
                                p_u_280.Icons[v_u_302] = p_u_280.Icons[v346]
                                p_u_280.Icons[v346] = nil
                                if p_u_280.Icons[v_u_302] then
                                    p_u_280.Icons[v_u_302].Instance.Visible = false
                                end
                            end
                        end
                    end
                    local v347
                    if v294 then
                        v347 = v294:GetAttribute("Dead") == true
                    else
                        v347 = false
                    end
                    if not (p_u_280.DeadPlayerPositions[v293.UserId] or v347) then
                        if v301 then
                            if p_u_280.Icons[v_u_302] and v295 then
                                p_u_280:UpdateTeammateIcon(v_u_302, v295.Position, nil)
                            elseif p_u_280.Icons[v_u_302] then
                                p_u_280:RemoveIcon(v_u_302)
                            end
                        elseif p_u_280.Icons[v_u_302] then
                            local v348
                            if v294 then
                                v348 = v294:GetAttribute("Dead") == true
                            else
                                v348 = false
                            end
                            local v349 = p_u_280.DeadPlayerPositions[v293.UserId]
                            if not v294 and true or (v349 and true or v348) then
                                if p_u_280.Icons[v_u_302] then
                                    p_u_280:RemoveIcon(v_u_302)
                                end
                                if not v349 then
                                    if v295 then
                                        v349 = v295.Position
                                        p_u_280.DeadPlayerPositions[v293.UserId] = v349
                                    elseif p_u_280.EnemyLastSeenPositions[v_u_302] then
                                        v349 = p_u_280.EnemyLastSeenPositions[v_u_302]
                                        p_u_280.DeadPlayerPositions[v293.UserId] = v349
                                    elseif p_u_280.EnemyLastSeenPositions[v_u_302 .. "_Frozen"] then
                                        v349 = p_u_280.EnemyLastSeenPositions[v_u_302 .. "_Frozen"]
                                        p_u_280.DeadPlayerPositions[v293.UserId] = v349
                                    end
                                end
                                if v349 then
                                    local v_u_350 = v293.UserId .. "_Dead"
                                    if not (p_u_280.Icons[v_u_350] or p_u_280.FadedDeadIcons[v_u_350]) then
                                        local v351 = v293:GetAttribute("Team")
                                        local v352 = v351 == p_u_280.Team
                                        local v353 = v_u_142(p_u_280.RadarContainer, "DeadTeammate", 12)
                                        v353.Name = v293.Name .. "_Dead"
                                        v353.ImageTransparency = 0
                                        for _, v354 in ipairs(v353:GetChildren()) do
                                            if v354.Name == "Direction" and v354:IsA("ImageLabel") then
                                                v354.Visible = false
                                            end
                                        end
                                        if v352 then
                                            local v355 = v293.Character
                                            local v356
                                            if v351 then
                                                v356 = v355 and v355:GetAttribute("CompetitivePlayerColor") or v_u_14["Team Color"][v351]
                                            else
                                                v356 = nil
                                            end
                                            if v356 then
                                                v353.ImageColor3 = v356
                                            end
                                        else
                                            v353.ImageColor3 = Color3.fromRGB(255, 0, 0)
                                        end
                                        local v357 = {
                                            ["Instance"] = v353,
                                            ["Player"] = v293,
                                            ["Target"] = nil,
                                            ["Type"] = "DeadTeammate",
                                            ["DefaultSize"] = v_u_21.Dead.Size
                                        }
                                        p_u_280.Icons[v_u_350] = v357
                                        task.delay(2, function()
                                            local v358 = p_u_280.Icons[v_u_350]
                                            if v358 and (v358.Instance and v358.Instance.Parent) then
                                                p_u_280.FadedDeadIcons[v_u_350] = true
                                                local v359 = v_u_4:Create(v358.Instance, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                                    ["ImageTransparency"] = 1
                                                })
                                                v359:Play()
                                                v359.Completed:Connect(function()
                                                    if p_u_280.Icons[v_u_350] then
                                                        p_u_280:RemoveIcon(v_u_350)
                                                    end
                                                end)
                                            end
                                        end)
                                    end
                                end
                                p_u_280.EnemyVisibilityState[v_u_302] = nil
                                p_u_280.EnemyLastSeenPositions[v_u_302] = nil
                                p_u_280.EnemyLastSeenPositions[v_u_302 .. "_Frozen"] = nil
                            else
                                local v360 = v_u_94(v294, v293, p_u_280.Team)
                                local v361 = p_u_280.EnemyVisibilityState[v_u_302] or false
                                if v360 then
                                    if p_u_280.Icons[v_u_302] and p_u_280.Icons[v_u_302].Type == "EnemyQuestionMark" then
                                        local v362 = p_u_280.Icons[v_u_302].FadeTween
                                        if v362 then
                                            v362:Cancel()
                                            p_u_280.Icons[v_u_302].FadeTween = nil
                                        end
                                        local v363 = p_u_280.Icons[v_u_302].Instance
                                        if v363:IsA("TextLabel") then
                                            local v364 = v363.Position
                                            local v365 = v363.AnchorPoint
                                            v363:Destroy()
                                            local v366 = v293:GetAttribute("Slot5")
                                            local v367 = v366 and v_u_5:JSONDecode(v366 or "[]")
                                            if v367 then
                                                v367 = v367.Weapon == "C4"
                                            end
                                            local v368 = v293:GetAttribute("IsCarryingHostage") == true
                                            local v369 = Instance.new("ImageLabel")
                                            v369.Name = v293.Name .. "_Enemy"
                                            if v367 then
                                                v369.Image = v_u_21.Bomb.Image
                                                v369.Size = UDim2.fromOffset(14, 14)
                                            elseif v368 then
                                                local v370 = v_u_21:FindFirstChild("Hostage")
                                                if v370 and v370:IsA("ImageLabel") then
                                                    v369.Image = v370.Image
                                                else
                                                    v369.Image = v_u_21.Player.Image
                                                end
                                                v369.Size = UDim2.fromOffset(30, 30)
                                            else
                                                v369.Image = v_u_21.Player.Image
                                                v369.Size = UDim2.fromOffset(12, 12)
                                            end
                                            v369.ImageColor3 = Color3.fromRGB(255, 0, 0)
                                            v369.BackgroundTransparency = 1
                                            v369.BorderSizePixel = 0
                                            v369.Position = v364
                                            v369.AnchorPoint = v365
                                            v369.ZIndex = v_u_25.Enemy
                                            v369.Visible = true
                                            v369.Parent = p_u_280.RadarContainer
                                            p_u_280.Icons[v_u_302].Instance = v369
                                            p_u_280.Icons[v_u_302].Type = "Enemy"
                                            p_u_280.Icons[v_u_302].FadeTween = nil
                                            p_u_280.EnemyLastSeenPositions[v_u_302 .. "_Frozen"] = nil
                                        end
                                    end
                                    if p_u_280.Icons[v_u_302] and v295 then
                                        local v371 = p_u_280.Icons[v_u_302].Instance
                                        v371.Visible = true
                                        local v372 = v293:GetAttribute("Slot5")
                                        local v373 = v372 and v_u_5:JSONDecode(v372 or "[]")
                                        if v373 then
                                            v373 = v373.Weapon == "C4"
                                        end
                                        local v374 = v293:GetAttribute("IsCarryingHostage") == true
                                        v371.ImageColor3 = Color3.fromRGB(255, 0, 0)
                                        if v373 then
                                            v371.Image = v_u_21.Bomb.Image
                                            v371.Size = UDim2.fromOffset(14, 14)
                                        elseif v374 then
                                            local v375 = v_u_21:FindFirstChild("Hostage")
                                            if v375 and v375:IsA("ImageLabel") then
                                                v371.Image = v375.Image
                                            else
                                                v371.Image = v_u_21.Player.Image
                                            end
                                            v371.Size = UDim2.fromOffset(30, 30)
                                        else
                                            v371.Image = v_u_21.Player.Image
                                            v371.Size = UDim2.fromOffset(12, 12)
                                        end
                                        p_u_280:UpdateTeammateIcon(v_u_302, v295.Position, nil)
                                        p_u_280.EnemyLastSeenPositions[v_u_302] = v295.Position
                                    elseif p_u_280.Icons[v_u_302] then
                                        p_u_280:RemoveIcon(v_u_302)
                                    end
                                else
                                    local v376
                                    if v294 then
                                        v376 = v294:GetAttribute("Dead") == true
                                    else
                                        v376 = false
                                    end
                                    if not v294 and true or (p_u_280.DeadPlayerPositions[v293.UserId] and true or v376) then
                                        if p_u_280.Icons[v_u_302] then
                                            p_u_280:RemoveIcon(v_u_302)
                                        end
                                        p_u_280.EnemyVisibilityState[v_u_302] = nil
                                        p_u_280.EnemyLastSeenPositions[v_u_302] = nil
                                        p_u_280.EnemyLastSeenPositions[v_u_302 .. "_Frozen"] = nil
                                    elseif v361 and p_u_280.Icons[v_u_302] then
                                        local v377 = p_u_280.Icons[v_u_302].Instance
                                        local v378 = nil
                                        local v379 = nil
                                        local v380 = p_u_280.Icons[v_u_302].FadeTween
                                        if v380 then
                                            v380:Cancel()
                                            p_u_280.Icons[v_u_302].FadeTween = nil
                                        end
                                        if v377:IsA("ImageLabel") then
                                            v378 = v377.Position
                                            v379 = v377.AnchorPoint
                                            v377:Destroy()
                                        elseif v377:IsA("TextLabel") then
                                            v378 = v377.Position
                                            v379 = v377.AnchorPoint
                                            v377:Destroy()
                                        end
                                        local v381 = v_u_21.EnemySeen:Clone()
                                        v381.Name = v293.Name .. "_QuestionMark"
                                        v381.Position = v378
                                        v381.AnchorPoint = v379
                                        v381.ZIndex = v_u_25.EnemyQuestionMark
                                        v381.TextTransparency = 0
                                        v381.Visible = true
                                        v381.Parent = p_u_280.RadarContainer
                                        p_u_280.Icons[v_u_302].Instance = v381
                                        p_u_280.Icons[v_u_302].Type = "EnemyQuestionMark"
                                        p_u_280.Icons[v_u_302].FadeTween = nil
                                        if p_u_280.EnemyLastSeenPositions[v_u_302] then
                                            p_u_280.EnemyLastSeenPositions[v_u_302 .. "_Frozen"] = p_u_280.EnemyLastSeenPositions[v_u_302]
                                        end
                                        task.delay(0.1, function()
                                            if p_u_280.Icons[v_u_302] and p_u_280.Icons[v_u_302].Instance:IsA("TextLabel") then
                                                local v382 = p_u_280.Icons[v_u_302].Instance
                                                v382.TextTransparency = 0
                                                local v383 = v_u_4:Create(v382, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                                    ["TextTransparency"] = 1
                                                })
                                                v383:Play()
                                                p_u_280.Icons[v_u_302].FadeTween = v383
                                                v383.Completed:Connect(function()
                                                    if p_u_280.Icons[v_u_302] then
                                                        p_u_280:RemoveIcon(v_u_302)
                                                        p_u_280.EnemyLastSeenPositions[v_u_302 .. "_Frozen"] = nil
                                                    end
                                                end)
                                            end
                                        end)
                                    end
                                    if p_u_280.Icons[v_u_302] and p_u_280.Icons[v_u_302].Type == "EnemyQuestionMark" then
                                        local v384 = p_u_280.EnemyLastSeenPositions[v_u_302 .. "_Frozen"]
                                        if v384 then
                                            p_u_280:UpdateQuestionMarkIcon(v_u_302, v384)
                                        end
                                    elseif p_u_280.Icons[v_u_302] then
                                        p_u_280.Icons[v_u_302].Instance.Visible = false
                                    end
                                end
                                if p_u_280.Icons[v_u_302] then
                                    p_u_280.EnemyVisibilityState[v_u_302] = v360
                                end
                            end
                        end
                    end
                end
            else
                local v385 = v293.UserId .. "_Player"
                local v386 = v293.UserId .. "_Dead"
                if p_u_280.Icons[v385] then
                    p_u_280:RemoveIcon(v385)
                end
                if p_u_280.Icons[v386] then
                    p_u_280:RemoveIcon(v386)
                end
                p_u_280.EnemyVisibilityState[v385] = nil
                p_u_280.EnemyLastSeenPositions[v385] = nil
                p_u_280.EnemyLastSeenPositions[v385 .. "_Frozen"] = nil
                p_u_280.DeadPlayerPositions[v293.UserId] = nil
                p_u_280.FadedDeadIcons[v386] = nil
            end
        end
    end
    for v387, v388 in pairs(p_u_280.DeadPlayerPositions) do
        local v389 = v387 .. "_Dead"
        local v390 = p_u_280.Icons[v389]
        if v390 and p_u_280.MinimapReference then
            local v391 = p_u_280.MinimapReference
            local v392 = v391.Part
            local v393 = v391.Size
            local v394 = v392.CFrame:PointToObjectSpace(v388)
            local v395 = v394.X
            local v396 = v394.Z
            local v397 = -v395
            local v398 = -v396
            local v399 = v397 / v393.X + 0.5
            local v400 = v398 / v393.Z + 0.5
            local v401 = p_u_280.MapImage.ImageRectOffset
            local v402 = p_u_280.MapImage.ImageRectSize
            local v403 = v399 * 1024
            local v404 = v400 * 1024
            local v405 = v403 - v401.X
            local v406 = v404 - v401.Y
            local v407 = v405 / v402.X
            local v408 = v406 / v402.Y
            if p_u_280.MapImage.Rotation ~= 0 then
                local v409 = p_u_280.MapImage.Rotation
                local v410 = math.rad(v409)
                local v411 = math.cos(v410)
                local v412 = math.sin(v410)
                local v413 = v407 - 0.5
                local v414 = v408 - 0.5
                v407 = 0.5 + (v413 * v411 - v414 * v412)
                v408 = 0.5 + (v413 * v412 + v414 * v411)
            end
            local v415 = v407 - 0.5
            local v416 = v408 - 0.5
            local v417 = v415 * v415 + v416 * v416
            local v418 = math.sqrt(v417)
            if v418 > 0.5 then
                local v419 = v415 / v418
                local v420 = v416 / v418
                v407 = 0.5 + v419 * 0.5
                v408 = 0.5 + v420 * 0.5
            end
            v390.Instance.Position = UDim2.fromScale(v407, v408)
            v390.Instance.Visible = true
        end
    end
end
function v_u_1.UpdateBombIcon(p421)
    local v422 = nil
    local v423 = p421.Team == "Counter-Terrorists"
    local v424 = v_u_8:GetAttribute("ServerGamemode") == "Competitive"
    local v425 = v_u_3:GetTagged("Bomb")[1]
    if v424 and v425 then
        v425 = nil
    end
    if v425 and (v425:IsA("Model") and v425.PrimaryPart) then
        v422 = v425
    else
        local v426 = v_u_3:GetTagged("WeaponDropped")
        for _, v427 in ipairs(v426) do
            if v427:IsA("Model") and (v427.PrimaryPart and v427:GetAttribute("Weapon") == "C4") then
                v422 = v427
                break
            end
        end
    end
    if v422 then
        if not p421.Icons.Bomb then
            local v428 = v_u_21.Bomb:Clone()
            v428.Position = UDim2.fromScale(0.5, 0.5)
            v428.AnchorPoint = Vector2.new(0.5, 0.5)
            v428.Parent = p421.RadarContainer
            v428.Size = UDim2.fromOffset(14, 14)
            v428.ZIndex = v_u_25.Bomb
            v428.Name = "Bomb"
            p421.Icons.Bomb = {
                ["Instance"] = v428,
                ["Player"] = nil,
                ["Target"] = v422.PrimaryPart,
                ["Type"] = "Bomb"
            }
        end
        local v429 = p421.Icons.Bomb
        if not p421.MinimapReference then
            v429.Instance.Visible = false
            return
        end
        local v430 = v422.PrimaryPart.Position
        local v431 = p421.MinimapReference
        local v432 = v431.Part
        local v433 = v431.Size
        local v434 = v432.CFrame:PointToObjectSpace(v430)
        local v435 = v434.X
        local v436 = v434.Z
        local v437 = -v435
        local v438 = -v436
        local v439 = v437 / v433.X + 0.5
        local v440 = v438 / v433.Z + 0.5
        local v441 = p421.MapImage.ImageRectOffset
        local v442 = p421.MapImage.ImageRectSize
        local v443 = v439 * 1024
        local v444 = v440 * 1024
        local v445 = v443 - v441.X
        local v446 = v444 - v441.Y
        local v447 = v445 / v442.X
        local v448 = v446 / v442.Y
        if p421.MapImage.Rotation ~= 0 then
            local v449 = p421.MapImage.Rotation
            local v450 = math.rad(v449)
            local v451 = math.cos(v450)
            local v452 = math.sin(v450)
            local v453 = v447 - 0.5
            local v454 = v448 - 0.5
            v447 = 0.5 + (v453 * v451 - v454 * v452)
            v448 = 0.5 + (v453 * v452 + v454 * v451)
        end
        local v455 = v447 - 0.5
        local v456 = v448 - 0.5
        local v457 = v455 * v455 + v456 * v456
        local v458 = math.sqrt(v457)
        if v458 > 0.5 then
            local v459 = v455 / v458
            local v460 = v456 / v458
            v447 = 0.5 + v459 * 0.5
            v448 = 0.5 + v460 * 0.5
        end
        v429.Instance.Position = UDim2.fromScale(v447, v448)
        if v423 and not v425 then
            local v461 = v_u_115(v430, v422, p421.Character, p421.LocalPlayer)
            local v462 = tick()
            if v461 then
                if not p421.BombIsVisible then
                    p421.BombFadeStartTime = nil
                end
                p421.BombIsVisible = true
                v429.Instance.Visible = true
                if v429.Instance:IsA("ImageLabel") then
                    local v463 = v429.Instance
                    v463.ImageTransparency = 0
                    v463.ImageColor3 = v_u_26
                    return
                end
                if v429.Instance:IsA("ImageButton") then
                    local v464 = v429.Instance
                    v464.ImageTransparency = 0
                    v464.ImageColor3 = v_u_26
                    return
                end
                if v429.Instance:IsA("TextLabel") then
                    v429.Instance.TextTransparency = 0
                    return
                end
                if v429.Instance:IsA("TextButton") then
                    v429.Instance.TextTransparency = 0
                    return
                end
            else
                if p421.BombIsVisible then
                    p421.BombFadeStartTime = v462
                end
                p421.BombIsVisible = false
                if not p421.BombFadeStartTime then
                    v429.Instance.Visible = false
                    return
                end
                local v465 = (v462 - p421.BombFadeStartTime) / 8
                local v466 = math.clamp(v465, 0, 1)
                if v466 >= 1 then
                    v429.Instance.Visible = false
                    return
                end
                v429.Instance.Visible = true
                if v429.Instance:IsA("ImageLabel") then
                    v429.Instance.ImageTransparency = v466
                    return
                end
                if v429.Instance:IsA("ImageButton") then
                    v429.Instance.ImageTransparency = v466
                    return
                end
                if v429.Instance:IsA("TextLabel") then
                    v429.Instance.TextTransparency = v466
                    return
                end
                if v429.Instance:IsA("TextButton") then
                    v429.Instance.TextTransparency = v466
                    return
                end
            end
        else
            v429.Instance.Visible = true
            if v429.Instance:IsA("ImageLabel") then
                local v467 = v429.Instance
                v467.ImageTransparency = 0
                if v425 and (v423 and v458 > 0.5) then
                    v467.ImageColor3 = v_u_26
                    return
                end
            elseif v429.Instance:IsA("ImageButton") then
                local v468 = v429.Instance
                v468.ImageTransparency = 0
                if v425 and (v423 and v458 > 0.5) then
                    v468.ImageColor3 = v_u_26
                    return
                end
            else
                if v429.Instance:IsA("TextLabel") then
                    v429.Instance.TextTransparency = 0
                    return
                end
                if v429.Instance:IsA("TextButton") then
                    v429.Instance.TextTransparency = 0
                    return
                end
            end
        end
    elseif p421.Icons.Bomb then
        p421.Icons.Bomb.Instance.Visible = false
        p421.BombIsVisible = false
        p421.BombFadeStartTime = nil
    end
end
function v_u_1.UpdateQuestionMarkIcon(p469, p470, p471)
    local v472 = p469.Icons[p470]
    if v472 and p469.MinimapReference then
        local v473 = v472.Instance
        if v473 and v473:IsA("TextLabel") then
            local v474 = p469.MinimapReference
            local v475 = v474.Part
            local v476 = v474.Size
            local v477 = v475.CFrame:PointToObjectSpace(p471)
            local v478 = v477.X
            local v479 = v477.Z
            local v480 = -v478
            local v481 = -v479
            local v482 = v480 / v476.X + 0.5
            local v483 = v481 / v476.Z + 0.5
            local v484 = p469.MapImage.ImageRectOffset
            local v485 = p469.MapImage.ImageRectSize
            local v486 = v482 * 1024
            local v487 = v483 * 1024
            local v488 = v486 - v484.X
            local v489 = v487 - v484.Y
            local v490 = v488 / v485.X
            local v491 = v489 / v485.Y
            if p469.MapImage.Rotation ~= 0 then
                local v492 = p469.MapImage.Rotation
                local v493 = math.rad(v492)
                local v494 = math.cos(v493)
                local v495 = math.sin(v493)
                local v496 = v490 - 0.5
                local v497 = v491 - 0.5
                v490 = 0.5 + (v496 * v494 - v497 * v495)
                v491 = 0.5 + (v496 * v495 + v497 * v494)
            end
            local v498 = v490 - 0.5
            local v499 = v491 - 0.5
            local v500 = v498 * v498 + v499 * v499
            local v501 = math.sqrt(v500)
            if v501 > 0.5 then
                local v502 = v498 / v501
                local v503 = v499 / v501
                v490 = 0.5 + v502 * 0.5
                v491 = 0.5 + v503 * 0.5
            end
            v473.Position = UDim2.fromScale(v490, v491)
            v473.Visible = true
        end
    else
        return
    end
end
function v_u_1.UpdateSiteIcons(p504)
    for v505, v506 in pairs(p504.SiteParts) do
        local v507 = "Site_" .. v505
        local v508
        if #v506 == 0 then
            v508 = Vector3.new(0, 0, 0)
        else
            local v509 = Vector3.new(0, 0, 0)
            for _, v510 in ipairs(v506) do
                v509 = v509 + v510.Position
            end
            v508 = v509 / #v506
        end
        if p504.Icons[v507] then
            ::l10::
            local v511 = p504.Icons[v507]
            if p504.MinimapReference then
                local v512 = p504.MinimapReference
                local v513 = v512.Part
                local v514 = v512.Size
                local v515 = v513.CFrame:PointToObjectSpace(v508)
                local v516 = v515.X
                local v517 = v515.Z
                local v518 = -v516
                local v519 = -v517
                local v520 = v518 / v514.X + 0.5
                local v521 = v519 / v514.Z + 0.5
                local v522 = p504.MapImage.ImageRectOffset
                local v523 = p504.MapImage.ImageRectSize
                local v524 = p504.Settings.Zoom or 0.5
                local v525 = 0.5 / math.clamp(v524, 0.1, 1)
                local v526 = workspace:GetAttribute("Map")
                if v526 == "Mirage" and true or v526 == "Winter Mirage" then
                    if v505 == "A" then
                        local v527 = v525 * -0.02 * v523.X / 1024
                        local v528 = v525 * 0.04 * v523.Y / 1024
                        v520 = v520 + v527
                        v521 = v521 + v528
                    elseif v505 == "B" then
                        local v529 = v525 * -0.015 * v523.X / 1024
                        local v530 = v525 * -0.005 * v523.Y / 1024
                        v520 = v520 + v529
                        v521 = v521 + v530
                    end
                elseif v526 == "Vertigo" and true or v526 == "Winter Vertigo" then
                    if v505 == "A" then
                        local v531 = v525 * 0.0425 * v523.X / 1024
                        local v532 = v525 * 0.005 * v523.Y / 1024
                        v520 = v520 + v531
                        v521 = v521 + v532
                    elseif v505 == "B" then
                        local v533 = v525 * -0.01 * v523.X / 1024
                        local v534 = v525 * -0.01 * v523.Y / 1024
                        v520 = v520 + v533
                        v521 = v521 + v534
                    end
                elseif v526 == "Seaside" then
                    if v505 == "A" then
                        local v535 = v525 * -0.01 * v523.X / 1024
                        local v536 = v525 * -0.01 * v523.Y / 1024
                        v520 = v520 + v535
                        v521 = v521 + v536
                    elseif v505 == "B" then
                        local v537 = v525 * 0 * v523.X / 1024
                        local v538 = v525 * 0.02 * v523.Y / 1024
                        v520 = v520 + v537
                        v521 = v521 + v538
                    end
                end
                local v539 = v520 * 1024
                local v540 = v521 * 1024
                local v541 = v539 - v522.X
                local v542 = v540 - v522.Y
                local v543 = v541 / v523.X
                local v544 = v542 / v523.Y
                if p504.MapImage.Rotation ~= 0 then
                    local v545 = p504.MapImage.Rotation
                    local v546 = math.rad(v545)
                    local v547 = math.cos(v546)
                    local v548 = math.sin(v546)
                    local v549 = v543 - 0.5
                    local v550 = v544 - 0.5
                    v543 = 0.5 + (v549 * v547 - v550 * v548)
                    v544 = 0.5 + (v549 * v548 + v550 * v547)
                end
                local v551 = v543 - 0.5
                local v552 = v544 - 0.5
                local v553 = v551 * v551 + v552 * v552
                local v554 = math.sqrt(v553)
                if v554 > 0.5 then
                    local v555 = v551 / v554
                    local v556 = v552 / v554
                    v543 = 0.5 + v555 * 0.485
                    v544 = 0.5 + v556 * 0.485
                end
                v511.Instance.Position = UDim2.fromScale(v543, v544)
                v511.Instance.Visible = true
                local v557 = v554 > 0.5
                local v558 = v511.DefaultSize
                if v558 then
                    if v557 then
                        v511.Instance.Size = v558
                    else
                        v511.Instance.Size = UDim2.new(v558.X.Scale * v525, v558.X.Offset * v525, v558.Y.Scale * v525, v558.Y.Offset * v525)
                    end
                end
            else
                v511.Instance.Visible = false
            end
        else
            local v559 = v_u_21:FindFirstChild(v505)
            if v559 then
                local v560 = v559:Clone()
                v560.Name = v505 .. "_Icon"
                v560.Position = UDim2.fromScale(0.5, 0.5)
                v560.AnchorPoint = Vector2.new(0.5, 0.5)
                v560.ZIndex = v_u_25.Site
                v560.Visible = true
                if v560:IsA("TextLabel") then
                    v560.TextXAlignment = Enum.TextXAlignment.Center
                    v560.TextYAlignment = Enum.TextYAlignment.Center
                end
                v560.Parent = p504.RadarContainer
                local v561 = {
                    ["Instance"] = v560,
                    ["Player"] = nil,
                    ["Target"] = nil,
                    ["Type"] = "Site",
                    ["DefaultSize"] = v559.Size
                }
                p504.Icons[v507] = v561
                goto l10
            end
            warn((("Site icon template not found for: %*"):format(v505)))
        end
    end
end
function v_u_1.UpdateHostageIcons(p562)
    local v563 = v_u_3:GetTagged("Hostage")
    local v564 = {}
    for _, v565 in ipairs(v563) do
        if v565:IsA("Model") and v565.PrimaryPart then
            local v566 = v565.Name
            local v567 = "Hostage_" .. v566
            v564[v567] = true
            if not p562.Icons[v567] then
                local v568 = v_u_21:FindFirstChild("Hostage")
                if not (v568 and v568:IsA("ImageLabel")) then
                    v568 = v_u_21.Player
                end
                local v569 = v568:Clone()
                v569.Position = UDim2.fromScale(0.5, 0.5)
                v569.AnchorPoint = Vector2.new(0.5, 0.5)
                v569.Parent = p562.RadarContainer
                v569.Size = UDim2.fromOffset(30, 30)
                v569.ZIndex = v_u_25.Hostage
                v569.Name = "Hostage_" .. v566
                v569.Visible = true
                for _, v570 in ipairs(v569:GetChildren()) do
                    if v570.Name == "Direction" and v570:IsA("ImageLabel") then
                        v570.Visible = false
                    end
                end
                p562.Icons[v567] = {
                    ["Instance"] = v569,
                    ["Player"] = nil,
                    ["Target"] = v565.PrimaryPart,
                    ["Type"] = "Hostage"
                }
            end
            local v571 = p562.Icons[v567]
            if p562.MinimapReference then
                local v572 = v565:GetAttribute("CarryingPlayer")
                local v573
                if v572 then
                    local v574 = v_u_9:FindFirstChild(v572)
                    if v574 and (v574.Character and v574.Character.PrimaryPart) then
                        v573 = v574.Character.PrimaryPart.Position
                    else
                        v573 = v565.PrimaryPart.Position
                    end
                else
                    v573 = v565.PrimaryPart.Position
                end
                local v575 = p562.MinimapReference
                local v576 = v575.Part
                local v577 = v575.Size
                local v578 = v576.CFrame:PointToObjectSpace(v573)
                local v579 = v578.X
                local v580 = v578.Z
                local v581 = -v579
                local v582 = -v580
                local v583 = v581 / v577.X + 0.5
                local v584 = v582 / v577.Z + 0.5
                local v585 = p562.MapImage.ImageRectOffset
                local v586 = p562.MapImage.ImageRectSize
                local v587 = v583 * 1024
                local v588 = v584 * 1024
                local v589 = v587 - v585.X
                local v590 = v588 - v585.Y
                local v591 = v589 / v586.X
                local v592 = v590 / v586.Y
                if p562.MapImage.Rotation ~= 0 then
                    local v593 = p562.MapImage.Rotation
                    local v594 = math.rad(v593)
                    local v595 = math.cos(v594)
                    local v596 = math.sin(v594)
                    local v597 = v591 - 0.5
                    local v598 = v592 - 0.5
                    v591 = 0.5 + (v597 * v595 - v598 * v596)
                    v592 = 0.5 + (v597 * v596 + v598 * v595)
                end
                local v599 = v591 - 0.5
                local v600 = v592 - 0.5
                local v601 = v599 * v599 + v600 * v600
                local v602 = math.sqrt(v601)
                if v602 > 0.5 then
                    local v603 = v599 / v602
                    local v604 = v600 / v602
                    v591 = 0.5 + v603 * 0.5
                    v592 = 0.5 + v604 * 0.5
                end
                v571.Instance.Position = UDim2.fromScale(v591, v592)
                local v605 = v572 ~= nil
                local v606 = p562.Team
                if v605 then
                    if v606 == "Counter-Terrorists" then
                        v571.Instance.Visible = true
                    elseif v606 == "Terrorists" then
                        v571.Instance.Visible = v_u_136(v573, v565, p562.Character, p562.LocalPlayer)
                    else
                        v571.Instance.Visible = true
                    end
                else
                    v571.Instance.Visible = v606 == "Terrorists"
                end
            else
                v571.Instance.Visible = false
            end
        end
    end
    for v607, v608 in pairs(p562.Icons) do
        if v608.Type == "Hostage" and not v564[v607] then
            p562:RemoveIcon(v607)
        end
    end
end
function v_u_1.UpdateMinimapTexture(p609)
    if p609.MinimapReference then
        local v610 = p609.MinimapReference
        local v611 = v610.Lower or v610.Upper
        if v611 then
            p609.MapImage.Image = v611.Texture
            p609.MapImage.ImageTransparency = 0
            if v611.Texture:match("%d+") then
                local v612 = workspace:GetAttribute("Map")
                local v613 = v612 == "Vertigo" and true or v612 == "Winter Vertigo"
                local v614 = v610.Upper
                local v615 = p609.UpperMapImage
                if v613 then
                    if v614 == nil then
                        v613 = false
                    else
                        v613 = v615 ~= nil
                    end
                end
                if p609.Character and p609.Character.PrimaryPart then
                    local v616 = p609.Character.PrimaryPart.Position.Y
                    if v613 and (v615 and v614) then
                        v615.Image = v614.Texture
                        v615.ImageTransparency = v616 >= 387 and 0 or 1
                    end
                else
                    p609.MapImage.ImageTransparency = 0
                    if v613 and (v615 and v614) then
                        v615.Image = v614.Texture
                    end
                end
                if p609.Character and p609.Character.PrimaryPart then
                    local _ = p609.Settings.CentersPlayer
                    local v617 = p609.Character.PrimaryPart.Position
                    local v618 = v610.Part
                    local v619 = v618.CFrame:PointToObjectSpace(v617)
                    local v620 = v610.Size
                    local v621 = v619.X
                    local v622 = v619.Z
                    local v623 = -v621
                    local v624 = -v622
                    local v625 = v623 / v620.X + 0.5
                    local v626 = v624 / v620.Z + 0.5
                    local v627 = p609.Settings.Zoom or 0.7
                    local v628 = math.clamp(v627, 0.1, 1) * 1024 * 0.5
                    local v629 = v625 * 1024
                    local v630 = v626 * 1024
                    local v631 = v629 - v628 / 2
                    local v632 = v630 - v628 / 2
                    local v633 = 1024 - v628
                    local v634 = math.clamp(v631, 0, v633)
                    local v635 = 1024 - v628
                    local v636 = math.clamp(v632, 0, v635)
                    local v637 = v634 + v628 / 2
                    local v638 = v636 + v628 / 2
                    local v639 = v637 / 1024
                    local v640 = v638 / 1024
                    local v641 = (v639 - 0.5) * v620.X
                    local v642 = (v640 - 0.5) * v620.Z
                    local v643 = -v641
                    local v644 = -v642
                    p609.ViewCenterLocal = Vector3.new(v643, 0, v644)
                    local v645 = Vector2.new(v634, v636)
                    local v646 = Vector2.new(v628, v628)
                    p609.MapImage.ImageRectOffset = v645
                    p609.MapImage.ImageRectSize = v646
                    if v613 and v615 then
                        v615.ImageRectOffset = v645
                        v615.ImageRectSize = v646
                    end
                    local v647 = p609.IsSpectating and 90 or (not p609.Settings.Rotation and 90 or -v_u_154(v_u_22.CFrame.LookVector, v618) + 90 - 90)
                    p609.MapImage.Rotation = v647
                    if v613 and v615 then
                        v615.Rotation = v647
                        return
                    end
                else
                    local v648 = Vector2.new(0, 0)
                    local v649 = Vector2.new(1024, 1024)
                    p609.MapImage.ImageRectOffset = v648
                    p609.MapImage.ImageRectSize = v649
                    p609.MapImage.Rotation = 90
                    if v613 and v615 then
                        v615.ImageRectOffset = v648
                        v615.ImageRectSize = v649
                        v615.Rotation = 90
                    end
                    p609.ViewCenterLocal = Vector3.new(0, 0, 0)
                end
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.ApplySettings(p650)
    p650.MapImage.Size = UDim2.fromScale(1, 1)
    if p650.UpperMapImage then
        p650.UpperMapImage.Size = UDim2.fromScale(1, 1)
    end
    local v651 = p650.Settings.Scale or 1
    if v_u_20 then
        v651 = (v651 - 1) * 0.5 + 1
    end
    local v652 = v_u_23 * v651
    p650.RadarContainer.Size = UDim2.fromOffset(v652, v652)
    local v653 = UDim2.new(0, 10, 0, 10)
    local v654 = v_u_196(p650.Frame, v652, v653)
    p650.Frame.Position = v654
    p650:UpdateMinimapTexture()
end
function v_u_1.CreateRunningCircle(p655)
    if not p655.RunningCircle then
        local v656 = Instance.new("Frame")
        v656.Name = "RunningCircle"
        v656.BackgroundTransparency = 1
        v656.Size = UDim2.fromScale(1, 1)
        v656.Position = UDim2.fromScale(0.5, 0.5)
        v656.AnchorPoint = Vector2.new(0.5, 0.5)
        v656.ZIndex = v_u_25.LocalPlayer - 1
        v656.Parent = p655.RadarContainer
        local v657 = Instance.new("UIStroke")
        v657.Color = Color3.fromRGB(255, 255, 255)
        v657.Thickness = 2
        v657.Transparency = 1
        v657.Parent = v656
        local v658 = Instance.new("UICorner")
        v658.CornerRadius = UDim.new(1, 0)
        v658.Parent = v656
        p655.RunningCircle = v656
    end
end
function v_u_1.CreateKnifeCircle(p659)
    if not p659.KnifeCircle then
        local v660 = Instance.new("Frame")
        v660.Name = "KnifeCircle"
        v660.BackgroundTransparency = 1
        v660.Size = UDim2.fromScale(1, 1)
        v660.Position = UDim2.fromScale(0.5, 0.5)
        v660.AnchorPoint = Vector2.new(0.5, 0.5)
        v660.ZIndex = v_u_25.LocalPlayer - 1
        v660.Parent = p659.RadarContainer
        v660.Visible = false
        local v661 = Instance.new("UIStroke")
        v661.Color = Color3.fromRGB(255, 255, 255)
        v661.Thickness = 2
        v661.Transparency = 1
        v661.Parent = v660
        local v662 = Instance.new("UICorner")
        v662.CornerRadius = UDim.new(1, 0)
        v662.Parent = v660
        p659.KnifeCircle = v660
    end
end
function v_u_1.CreateWeaponCircle(p663)
    if not p663.WeaponCircle then
        local v664 = Instance.new("Frame")
        v664.Name = "WeaponCircle"
        v664.BackgroundTransparency = 1
        v664.Size = UDim2.fromScale(1, 1)
        v664.Position = UDim2.fromScale(0.5, 0.5)
        v664.AnchorPoint = Vector2.new(0.5, 0.5)
        v664.ZIndex = v_u_25.LocalPlayer - 1
        v664.Parent = p663.RadarContainer
        v664.Visible = false
        local v665 = Instance.new("UIStroke")
        v665.Color = Color3.fromRGB(255, 255, 255)
        v665.Thickness = 2
        v665.Transparency = 1
        v665.Parent = v664
        local v666 = Instance.new("UICorner")
        v666.CornerRadius = UDim.new(1, 0)
        v666.Parent = v664
        p663.WeaponCircle = v664
    end
end
function v_u_1.FlashRadarBorder(p_u_667)
    if v_u_27 and v_u_27.Radar then
        local v668 = v_u_27.Radar.UIStroke
        if v668 then
            if not p_u_667.OriginalBorderColor then
                p_u_667.OriginalBorderColor = v668.Color
            end
            v668.Color = Color3.fromRGB(255, 255, 255)
            if p_u_667.BorderRestoreTask then
                task.cancel(p_u_667.BorderRestoreTask)
                p_u_667.BorderRestoreTask = nil
            end
            p_u_667.BorderRestoreTask = task.delay(0.2, function()
                if v_u_27 and (v_u_27.Radar and v_u_27.Radar.UIStroke) then
                    v_u_27.Radar.UIStroke.Color = v_u_15()
                end
                p_u_667.BorderRestoreTask = nil
            end)
        end
    else
        return
    end
end
function v_u_1.ShowWeaponCircle(p_u_669)
    if not p_u_669.WeaponCircle then
        p_u_669:CreateWeaponCircle()
    end
    local v_u_670 = p_u_669.WeaponCircle
    if v_u_670 then
        local v_u_671 = v_u_670:FindFirstChildOfClass("UIStroke")
        if v_u_671 then
            local v672 = p_u_669.Settings.Scale or 1
            if v_u_20 then
                v672 = (v672 - 1) * 0.5 + 1
            end
            local v673 = v_u_23 / 2 * v672 * 2
            v_u_670.Size = UDim2.fromOffset(v673, v673)
            v_u_671.Thickness = 2
            v_u_671.Transparency = 0
            v_u_670.Visible = true
            if p_u_669.WeaponCircleHideTask then
                task.cancel(p_u_669.WeaponCircleHideTask)
                p_u_669.WeaponCircleHideTask = nil
            end
            p_u_669.WeaponCircleHideTask = task.delay(0.2, function()
                if v_u_670 and v_u_671 then
                    v_u_671.Transparency = 1
                    v_u_670.Visible = false
                end
                p_u_669.WeaponCircleHideTask = nil
            end)
        end
    else
        return
    end
end
function v_u_1.ShowKnifeCircle(p674)
    if not p674.KnifeCircle then
        p674:CreateKnifeCircle()
    end
    local v_u_675 = p674.KnifeCircle
    if v_u_675 then
        local v_u_676 = v_u_675:FindFirstChildOfClass("UIStroke")
        if v_u_676 then
            local v677 = p674.Settings.Zoom or 0.5
            local v678 = math.clamp(v677, 0.1, 1)
            local v679 = p674.Settings.Scale or 1
            if v_u_20 then
                v679 = (v679 - 1) * 0.5 + 1
            end
            local v680 = (v_u_20 and 21 or 35) * (0.5 / v678) * v679
            local v681 = v_u_23 / 2 * v679
            local v682 = math.min(v680, v681)
            local v683 = v682 * 2
            v_u_675.Size = UDim2.fromOffset(v683, v683)
            if v682 == v681 then
                v_u_676.Thickness = 2
                v_u_676.Transparency = 0
            else
                v_u_676.Thickness = 1
                v_u_676.Transparency = 0.5
            end
            v_u_675.Visible = true
            task.delay(0.2, function()
                if v_u_675 and v_u_676 then
                    v_u_676.Transparency = 1
                    v_u_675.Visible = false
                end
            end)
        end
    else
        return
    end
end
function v_u_1.UpdateRunningCircle(p_u_684)
    if p_u_684.Character and p_u_684.Character.PrimaryPart then
        if p_u_684.Character:FindFirstChildOfClass("Humanoid") then
            local v685 = v_u_11.getCurrentCharacter()
            local v686 = false
            if v685 then
                local v687 = v685.GlobalDirection
                local v688 = v685.GlobalVelocity
                if v687 and v688 then
                    local v689 = v688.X
                    local v690 = v688.Z
                    local v691 = Vector3.new(v689, 0, v690).Magnitude
                    v686 = v687.Magnitude > 0.1 and true or v691 > 0.1
                end
            end
            local v692 = v_u_11.GetWalkState() or false
            if v686 then
                v686 = not v692
            end
            local v693 = v685 and v685.IsJumping or false
            local v694 = v686 or v693
            if not p_u_684.RunningCircle then
                p_u_684:CreateRunningCircle()
            end
            local v695 = p_u_684.RunningCircle
            if v695 then
                local v696 = v695:FindFirstChildOfClass("UIStroke")
                if v696 then
                    local v697 = p_u_684.Settings.Zoom or 0.5
                    local v698 = math.clamp(v697, 0.1, 1)
                    local v699 = p_u_684.Settings.Scale or 1
                    if v_u_20 then
                        v699 = (v699 - 1) * 0.5 + 1
                    end
                    local v700 = (v_u_20 and 30 or 50) * (0.5 / v698) * v699
                    local v701 = v_u_23 / 2 * v699
                    local v702 = math.min(v700, v701)
                    local v703 = v702 * 2
                    v695.Size = UDim2.fromOffset(v703, v703)
                    local v704 = v702 == v701
                    if v704 then
                        v696.Thickness = 2
                    else
                        v696.Thickness = 1
                    end
                    if v694 then
                        if v704 then
                            v696.Transparency = 0
                        else
                            v696.Transparency = 0.5
                        end
                        if v693 then
                            if p_u_684.RunningCircleDelayTask then
                                task.cancel(p_u_684.RunningCircleDelayTask)
                                p_u_684.RunningCircleDelayTask = nil
                            end
                            v695.Visible = true
                        elseif v686 then
                            if p_u_684.WasRunning then
                                if not p_u_684.RunningCircleDelayTask then
                                    if v704 then
                                        v696.Transparency = 0
                                    else
                                        v696.Transparency = 0.5
                                    end
                                    v695.Visible = true
                                end
                            else
                                if p_u_684.RunningCircleDelayTask then
                                    task.cancel(p_u_684.RunningCircleDelayTask)
                                    p_u_684.RunningCircleDelayTask = nil
                                end
                                v695.Visible = false
                                v696.Transparency = 1
                                p_u_684.RunningCircleDelayTask = task.delay(0.4, function()
                                    if p_u_684.Character and p_u_684.Character.PrimaryPart then
                                        local v705 = v_u_11.getCurrentCharacter()
                                        local v706 = false
                                        if v705 then
                                            local v707 = v705.GlobalDirection
                                            local v708 = v705.GlobalVelocity
                                            if v707 and v708 then
                                                local v709 = v708.X
                                                local v710 = v708.Z
                                                local v711 = Vector3.new(v709, 0, v710).Magnitude
                                                v706 = v707.Magnitude > 0.1 and true or v711 > 0.1
                                            end
                                        end
                                        local v712 = v_u_11.GetWalkState() or false
                                        if v706 then
                                            v706 = not v712
                                        end
                                        if v706 and p_u_684.RunningCircle then
                                            local v713 = p_u_684.RunningCircle
                                            local v714 = v713:FindFirstChildOfClass("UIStroke")
                                            if v714 then
                                                local v715 = p_u_684.Settings.Zoom or 0.5
                                                local v716 = math.clamp(v715, 0.1, 1)
                                                local v717 = p_u_684.Settings.Scale or 1
                                                if v_u_20 then
                                                    v717 = (v717 - 1) * 0.5 + 1
                                                end
                                                local v718 = (v_u_20 and 30 or 50) * (0.5 / v716) * v717
                                                local v719 = v_u_23 / 2 * v717
                                                if math.min(v718, v719) == v719 then
                                                    v714.Transparency = 0
                                                else
                                                    v714.Transparency = 0.5
                                                end
                                                v713.Visible = true
                                            end
                                        end
                                        p_u_684.RunningCircleDelayTask = nil
                                    else
                                        p_u_684.RunningCircleDelayTask = nil
                                    end
                                end)
                            end
                        end
                    else
                        if p_u_684.RunningCircleDelayTask then
                            task.cancel(p_u_684.RunningCircleDelayTask)
                            p_u_684.RunningCircleDelayTask = nil
                        end
                        v695.Visible = false
                        v696.Transparency = 1
                    end
                    p_u_684.WasRunning = v694
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
function v_u_1.CreateDeadIconForPlayer(p_u_720, p721, p722)
    local v723 = p721.UserId .. "_Player"
    if p_u_720.Icons[v723] then
        p_u_720:RemoveIcon(v723)
    end
    local v_u_724 = p721.UserId .. "_Dead"
    if not (p_u_720.Icons[v_u_724] or p_u_720.FadedDeadIcons[v_u_724]) then
        local v725 = p721:GetAttribute("Team")
        local v726 = v725 == p_u_720.Team
        local v727 = v_u_142(p_u_720.RadarContainer, "DeadTeammate", 12)
        v727.Name = p721.Name .. "_Dead"
        v727.ImageTransparency = 0
        for _, v728 in ipairs(v727:GetChildren()) do
            if v728.Name == "Direction" and v728:IsA("ImageLabel") then
                v728.Visible = false
            end
        end
        if v726 then
            local v729 = p721.Character
            local v730
            if v725 then
                v730 = v729 and v729:GetAttribute("CompetitivePlayerColor") or v_u_14["Team Color"][v725]
            else
                v730 = nil
            end
            if v730 then
                v727.ImageColor3 = v730
            end
        else
            v727.ImageColor3 = Color3.fromRGB(255, 0, 0)
        end
        local v731 = {
            ["Instance"] = v727,
            ["Player"] = p721,
            ["Target"] = nil,
            ["Type"] = "DeadTeammate",
            ["DefaultSize"] = v_u_21.Dead.Size
        }
        p_u_720.Icons[v_u_724] = v731
        if p722 and p_u_720.MinimapReference then
            local v732 = p_u_720.MinimapReference
            local v733 = v732.Part
            local v734 = v732.Size
            local v735 = v733.CFrame:PointToObjectSpace(p722)
            local v736 = v735.X
            local v737 = v735.Z
            local v738 = -v736
            local v739 = -v737
            local v740 = v738 / v734.X + 0.5
            local v741 = v739 / v734.Z + 0.5
            local v742 = p_u_720.MapImage.ImageRectOffset
            local v743 = p_u_720.MapImage.ImageRectSize
            local v744 = v740 * 1024
            local v745 = v741 * 1024
            local v746 = v744 - v742.X
            local v747 = v745 - v742.Y
            local v748 = v746 / v743.X
            local v749 = v747 / v743.Y
            if p_u_720.MapImage.Rotation ~= 0 then
                local v750 = p_u_720.MapImage.Rotation
                local v751 = math.rad(v750)
                local v752 = math.cos(v751)
                local v753 = math.sin(v751)
                local v754 = v748 - 0.5
                local v755 = v749 - 0.5
                v748 = 0.5 + (v754 * v752 - v755 * v753)
                v749 = 0.5 + (v754 * v753 + v755 * v752)
            end
            local v756 = v748 - 0.5
            local v757 = v749 - 0.5
            local v758 = v756 * v756 + v757 * v757
            local v759 = math.sqrt(v758)
            if v759 > 0.5 then
                local v760 = v756 / v759
                local v761 = v757 / v759
                v748 = 0.5 + v760 * 0.5
                v749 = 0.5 + v761 * 0.5
            end
            v727.Position = UDim2.fromScale(v748, v749)
            v727.Visible = true
        end
        task.delay(2, function()
            local v762 = p_u_720.Icons[v_u_724]
            if v762 and (v762.Instance and v762.Instance.Parent) then
                p_u_720.FadedDeadIcons[v_u_724] = true
                local v763 = v_u_4:Create(v762.Instance, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    ["ImageTransparency"] = 1
                })
                v763:Play()
                v763.Completed:Connect(function()
                    if p_u_720.Icons[v_u_724] then
                        p_u_720:RemoveIcon(v_u_724)
                    end
                end)
            end
        end)
    end
end
function v_u_1.Render(p764, _)
    p764:UpdateMinimapTexture()
    p764:UpdatePlayerIcons(p764.Settings.Rotation)
    p764:UpdateBombIcon()
    p764:UpdateSiteIcons()
    p764:UpdateHostageIcons()
    p764:UpdateRunningCircle()
end
function v_u_1.new(p765, p766)
    local v767 = v_u_1
    local v_u_768 = setmetatable({}, v767)
    v_u_768.Janitor = v_u_19.new()
    v_u_768.Frame = p765
    v_u_768.RadarContainer = p765.Radar
    v_u_768.MapImage = p765.Radar.Map
    v_u_768.MapImage.AnchorPoint = Vector2.new(0.5, 0.5)
    v_u_768.MapImage.Position = UDim2.fromScale(0.5, 0.5)
    v_u_768.MapImage.ZIndex = 1
    v_u_768.LocalPlayer = v_u_10
    v_u_768.Character = p766
    v_u_768.Team = v_u_10:GetAttribute("Team")
    v_u_768.MinimapReference = v_u_35()
    local v769 = workspace:GetAttribute("Map")
    if (v769 == "Vertigo" and true or v769 == "Winter Vertigo") and (v_u_768.MinimapReference and v_u_768.MinimapReference.Upper) then
        local v770 = v_u_768.MapImage:Clone()
        v770.Name = "UpperMap"
        v770.ZIndex = 2
        v770.BackgroundTransparency = 1
        v770.Parent = v_u_768.RadarContainer
        v_u_768.UpperMapImage = v770
        v_u_768.Janitor:Add(function()
            if v_u_768.UpperMapImage then
                v_u_768.UpperMapImage:Destroy()
            end
        end)
    else
        v_u_768.UpperMapImage = nil
    end
    v_u_768.Frame.Visible = true
    v_u_768.Janitor:Add(function()
        v_u_768.Frame.Visible = true
    end)
    v_u_768.Settings = v_u_28
    v_u_768.IsSpectating = false
    v_u_768.Icons = {}
    v_u_768.SiteParts = v_u_46()
    v_u_768.DeadPlayerPositions = {}
    v_u_768.FadedDeadIcons = {}
    v_u_768.EnemyVisibilityState = {}
    v_u_768.EnemyLastSeenPositions = {}
    v_u_768.RunningCircle = nil
    v_u_768.RunningCircleDelayTask = nil
    v_u_768.WasRunning = false
    v_u_768.KnifeCircle = nil
    v_u_768.WeaponCircle = nil
    v_u_768.WeaponCircleHideTask = nil
    v_u_768.OriginalBorderColor = nil
    v_u_768.BorderRestoreTask = nil
    v_u_768.BombIsVisible = false
    v_u_768.BombFadeStartTime = nil
    v_u_768:ApplySettings()
    local v_u_771 = v_u_18.broadcastRouter
    function v_u_18.broadcastRouter(p772, ...)
        local v773 = v_u_771(p772, ...)
        if p772 == "UpdatePlayerNoiseCone" then
            local v774 = { ... }
            local v775 = v774[1]
            local v776 = v774[2]
            if v776 and (v_u_768.Character and (v_u_768.Character.PrimaryPart and (v776 - v_u_768.Character.PrimaryPart.Position).Magnitude < 5)) then
                if v775 == "Melee" then
                    v_u_768:ShowKnifeCircle()
                    return v773
                end
                if v775 == "Weapon" then
                    v_u_768:ShowWeaponCircle()
                    v_u_768:FlashRadarBorder()
                end
            end
        end
        return v773
    end
    v_u_768.Janitor:Add(function()
        v_u_18.broadcastRouter = v_u_771
    end)
    local v_u_777 = 0
    v_u_768.Janitor:Add(v_u_6.RenderStepped:Connect(function(p778)
        v_u_777 = v_u_777 + p778
        if v_u_777 >= 0.004166666666666667 then
            v_u_768:Render(p778)
            v_u_777 = 0
        end
    end))
    v_u_768.Janitor:Add(v_u_10:GetAttributeChangedSignal("Team"):Connect(function()
        v_u_768:RefreshIconsOnTeamChange()
    end))
    for _, v_u_779 in ipairs(v_u_9:GetPlayers()) do
        if v_u_779 ~= v_u_768.LocalPlayer then
            v_u_768.Janitor:Add(v_u_779:GetAttributeChangedSignal("Team"):Connect(function()
                v_u_768:RefreshPlayerIcon(v_u_779)
            end))
        end
    end
    v_u_768.Janitor:Add(v_u_9.PlayerAdded:Connect(function(p_u_780)
        if p_u_780 ~= v_u_768.LocalPlayer then
            v_u_768.Janitor:Add(p_u_780:GetAttributeChangedSignal("Team"):Connect(function()
                v_u_768:RefreshPlayerIcon(p_u_780)
            end))
        end
    end))
    v_u_768.Janitor:Add(v_u_9.PlayerRemoving:Connect(function(p781)
        for v782, v783 in pairs(v_u_768.Icons) do
            if v783.Player == p781 then
                v_u_768:RemoveIcon(v782)
            end
        end
        v_u_768.DeadPlayerPositions[p781.UserId] = nil
        v_u_768.FadedDeadIcons[p781.UserId .. "_Dead"] = nil
    end))
    v_u_768.Janitor:Add(v_u_17.UI.UIPlayerKilled.Listen(function(p784)
        local v785 = p784.Victim
        local v786 = v_u_9:GetPlayerByUserId((tonumber(v785)))
        if v786 and v786 ~= v_u_10 then
            local v787 = p784.DeathPosition
            if v787 then
                v_u_768.DeadPlayerPositions[v786.UserId] = v787
                v_u_768:CreateDeadIconForPlayer(v786, v787)
            end
        else
            return
        end
    end))
    v_u_768.Janitor:Add(workspace:GetAttributeChangedSignal("Map"):Connect(function()
        v_u_768.MinimapReference = v_u_35()
        v_u_768.SiteParts = v_u_46()
        local v788 = workspace:GetAttribute("Map")
        local v789 = v788 == "Vertigo" and true or v788 == "Winter Vertigo"
        if v_u_768.UpperMapImage then
            v_u_768.UpperMapImage:Destroy()
            v_u_768.UpperMapImage = nil
        end
        for _, v790 in ipairs(v_u_768.RadarContainer:GetChildren()) do
            if v790.Name == "UpperMap" and v790:IsA("ImageLabel") then
                v790:Destroy()
            end
        end
        v_u_768.MapImage.Image = ""
        v_u_768.MapImage.ImageTransparency = 0
        v_u_768.MapImage.ImageRectOffset = Vector2.new(0, 0)
        v_u_768.MapImage.ImageRectSize = Vector2.new(0, 0)
        v_u_768.MapImage.Rotation = 0
        v_u_768.MapImage.Visible = true
        v_u_768.MapImage.Size = UDim2.fromScale(1, 1)
        if v789 and (v_u_768.MinimapReference and v_u_768.MinimapReference.Upper) then
            local v791 = v_u_768.MapImage:Clone()
            v791.Name = "UpperMap"
            v791.ZIndex = 2
            v791.Parent = v_u_768.RadarContainer
            v_u_768.UpperMapImage = v791
        else
            v_u_768.UpperMapImage = nil
        end
        v_u_768:UpdateMinimapTexture()
        for v792, _ in pairs(v_u_768.Icons) do
            v_u_768:RemoveIcon(v792)
        end
        table.clear(v_u_768.EnemyVisibilityState)
        table.clear(v_u_768.EnemyLastSeenPositions)
        table.clear(v_u_768.DeadPlayerPositions)
        table.clear(v_u_768.FadedDeadIcons)
    end))
    v_u_768.Janitor:Add(function()
        for _, v793 in pairs(v_u_768.Icons) do
            if v793.Instance and v793.Instance.Parent then
                v793.Instance:Destroy()
            end
        end
        table.clear(v_u_768.Icons)
        table.clear(v_u_768.EnemyVisibilityState)
        table.clear(v_u_768.EnemyLastSeenPositions)
        if v_u_768.UpperMapImage then
            v_u_768.UpperMapImage:Destroy()
            v_u_768.UpperMapImage = nil
        end
        if v_u_768.RadarContainer then
            for _, v794 in ipairs(v_u_768.RadarContainer:GetChildren()) do
                if v794.Name == "UpperMap" and v794:IsA("ImageLabel") then
                    v794:Destroy()
                end
            end
        end
        if v_u_768.RunningCircleDelayTask then
            task.cancel(v_u_768.RunningCircleDelayTask)
            v_u_768.RunningCircleDelayTask = nil
        end
        if v_u_768.RunningCircle then
            v_u_768.RunningCircle:Destroy()
            v_u_768.RunningCircle = nil
        end
        if v_u_768.KnifeCircle then
            v_u_768.KnifeCircle:Destroy()
            v_u_768.KnifeCircle = nil
        end
        if v_u_768.WeaponCircleHideTask then
            task.cancel(v_u_768.WeaponCircleHideTask)
            v_u_768.WeaponCircleHideTask = nil
        end
        if v_u_768.WeaponCircle then
            v_u_768.WeaponCircle:Destroy()
            v_u_768.WeaponCircle = nil
        end
        local v795 = v_u_768
        if v795.BorderRestoreTask then
            task.cancel(v795.BorderRestoreTask)
            v795.BorderRestoreTask = nil
        end
        if v_u_768.RunningCircle then
            v_u_768.RunningCircle:Destroy()
            v_u_768.RunningCircle = nil
        end
    end)
    return v_u_768
end
function v_u_1.Destroy(p796)
    p796.Janitor:Destroy()
end
function v_u_1.Initialize(_, p797)
    v_u_27 = p797
    v_u_13.CreateListener(v_u_10, "Settings.Game.Radar/Tablet.Radar Centers The Player", function(p798)
        v_u_28.CentersPlayer = p798
        if v_u_29 then
            v_u_29:ApplySettings()
        end
    end)
    v_u_13.CreateListener(v_u_10, "Settings.Game.Radar/Tablet.Radar Hud Size", function(p799)
        v_u_28.Scale = p799
        if v_u_29 then
            v_u_29:ApplySettings()
        end
    end)
    v_u_13.CreateListener(v_u_10, "Settings.Game.Radar/Tablet.Radar Is Rotating", function(p800)
        v_u_28.Rotation = p800
        if v_u_29 then
            v_u_29:ApplySettings()
        end
    end)
    v_u_13.CreateListener(v_u_10, "Settings.Game.Radar/Tablet.Radar Map Zoom", function(p801)
        v_u_28.Zoom = p801
        if v_u_29 then
            v_u_29:ApplySettings()
        end
    end)
    v_u_27.Radar.UIStroke.Color = v_u_15()
    v_u_10.CharacterAdded:Connect(function()
        v_u_27.Radar.UIStroke.Color = v_u_15()
    end)
    v_u_13.CreateListener(v_u_10, "Settings.Game.HUD.Color", function()
        if v_u_27 and (v_u_27.Radar and v_u_27.Radar.UIStroke) then
            local v802 = v_u_27.Radar.UIStroke
            local v803
            if v_u_29 then
                v803 = v_u_29.BorderRestoreTask ~= nil
            else
                v803 = false
            end
            if not v803 or v802.Color ~= Color3.fromRGB(255, 255, 255) then
                v802.Color = v_u_15()
            end
        end
    end)
end
function v_u_1.Start()
    v_u_10.CharacterAdded:Connect(function(p804)
        v_u_39(p804, v_u_10, false)
    end)
    v_u_12.ListenToSpectate:Connect(function(p805)
        if p805 then
            local v806 = p805.Character
            if v806 and v806:IsDescendantOf(workspace) then
                v_u_39(v806, p805, true)
                return
            end
        else
            local v807 = v_u_10.Character
            if v807 and v807:IsDescendantOf(workspace) then
                v_u_39(v807, v_u_10, false)
            end
        end
    end)
end
return v_u_1