local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Players")
local v_u_5 = game:GetService("RunService")
local v6 = require(v_u_2.Shared.Janitor)
local v_u_7 = require(v_u_2.Database.Security.Remotes)
local v_u_8 = require(v_u_2.Database.Components.Libraries.Skins)
local v_u_9 = require(v_u_2.Database.Components.Libraries.Cases)
local v_u_10 = require(v_u_2.Controllers.CameraController)
local v_u_11 = require(v_u_2.Controllers.SpectateController)
local v_u_12 = require(v_u_2.Controllers.DataController)
local v_u_13 = require(v_u_2.Database.Security.Router)
local v_u_14 = require(v_u_2.Interface.MenuState)
local v_u_15 = require(v_u_2.Shared.CloseButtonRegistry)
local v_u_16 = require(v_u_2.Database.Custom.GameStats.Rarities)
local v_u_17 = require(v_u_2.Database.Custom.GameStats.LevelsIcon)
local v_u_18 = require(v_u_2.Classes.Sound)
local v_u_19 = require(v_u_2.Components.Common.InterfaceAnimations.ActivateButton)
local v_u_20 = require(v_u_2.Database.Components.Common.AttachGlovesToCharacter)
local v_u_21 = require(v_u_2.Interface.Screens.Gameplay.Middle.Halftime)
local v_u_22 = CFrame.new(-0.251, 0.806, -0.406) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966)
local v_u_23 = {
    {
        ["maxLevel"] = 5,
        ["title"] = "Recruit"
    },
    {
        ["maxLevel"] = 10,
        ["title"] = "Private"
    },
    {
        ["maxLevel"] = 15,
        ["title"] = "Corporal"
    },
    {
        ["maxLevel"] = 20,
        ["title"] = "Sergeant"
    },
    {
        ["maxLevel"] = 25,
        ["title"] = "Master Sergeant"
    },
    {
        ["maxLevel"] = 30,
        ["title"] = "Lieutenant"
    },
    {
        ["maxLevel"] = 35,
        ["title"] = "Captain"
    },
    {
        ["maxLevel"] = 40,
        ["title"] = "Global Elite"
    }
}
local v_u_24 = v_u_4.LocalPlayer
local v_u_25 = v_u_24:WaitForChild("PlayerGui")
local v_u_26 = workspace.CurrentCamera
local v_u_27 = v_u_2.Assets.Characters
local v_u_28 = {
    {
        ["Entrance"] = "rbxassetid://100747011940776",
        ["Idle"] = "rbxassetid://100747011940776"
    },
    {
        ["Entrance"] = "rbxassetid://103701913618746",
        ["Idle"] = "rbxassetid://100955283476946"
    },
    {
        ["Entrance"] = "rbxassetid://91396952135880",
        ["Idle"] = "rbxassetid://120200138438261"
    },
    {
        ["Entrance"] = "rbxassetid://136102955582599",
        ["Idle"] = "rbxassetid://74544097369437"
    },
    {
        ["Entrance"] = "rbxassetid://71439100344953",
        ["Idle"] = "rbxassetid://122693948164334"
    }
}
local v_u_29 = {
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
local v_u_30 = {
    ["Counter-Terrorists"] = "CT",
    ["Terrorists"] = "T"
}
local v_u_31 = v6.new()
local v_u_32 = false
local v_u_33 = 0
local v_u_34 = true
local v_u_35 = "EndScreen"
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = {
    ["RoundWonCT"] = true,
    ["RoundWonT"] = true,
    ["RoundLost"] = true,
    ["PlayerMVPCT"] = true,
    ["PlayerMVPT"] = true
}
local function v_u_49(p39)
    local v40 = {}
    for v41, v42 in pairs(p39) do
        local v43 = v42.Team
        if v43 == "Counter-Terrorists" and true or v43 == "Terrorists" then
            table.insert(v40, {
                ["userId"] = v41,
                ["data"] = v42
            })
        end
    end
    table.sort(v40, function(p44, p45)
        if (p44.data.ADR or 0) ~= (p45.data.ADR or 0) then
            return (p44.data.ADR or 0) > (p45.data.ADR or 0)
        end
        if (p44.data.Score or 0) ~= (p45.data.Score or 0) then
            return (p44.data.Score or 0) > (p45.data.Score or 0)
        end
        local v46 = p44.userId
        local v47 = tonumber(v46) or (1 / 0)
        local v48 = p45.userId
        return v47 < (tonumber(v48) or (1 / 0))
    end)
    return v40
end
local function v_u_60(p50)
    local v51 = {}
    for v52, v53 in pairs(p50) do
        local v54 = v53.Team
        if v54 == "Counter-Terrorists" and true or v54 == "Terrorists" then
            table.insert(v51, {
                ["userId"] = v52,
                ["data"] = v53
            })
        end
    end
    table.sort(v51, function(p55, p56)
        if (p55.data.Score or 0) ~= (p56.data.Score or 0) then
            return (p55.data.Score or 0) > (p56.data.Score or 0)
        end
        if (p55.data.Kills or 0) ~= (p56.data.Kills or 0) then
            return (p55.data.Kills or 0) > (p56.data.Kills or 0)
        end
        if (p55.data.Assists or 0) ~= (p56.data.Assists or 0) then
            return (p55.data.Assists or 0) > (p56.data.Assists or 0)
        end
        local v57 = p55.userId
        local v58 = tonumber(v57) or (1 / 0)
        local v59 = p56.userId
        return v58 < (tonumber(v59) or (1 / 0))
    end)
    return v51
end
local function v_u_66()
    local v61 = workspace:FindFirstChild("Debris")
    if v61 then
        for _, v62 in v61:GetChildren() do
            v62:Destroy()
        end
    end
    local v63 = workspace:FindFirstChild("Characters")
    if v63 then
        for _, v64 in v63:GetChildren() do
            if v64:IsA("Folder") then
                for _, v65 in v64:GetChildren() do
                    v65:Destroy()
                end
            end
        end
    end
    if v_u_24.Character then
        v_u_24.Character:Destroy()
    end
end
local function v_u_69(p67, p68)
    if p67:IsA("TextLabel") then
        p67.TextTransparency = p68
        return
    elseif p67:IsA("TextButton") then
        p67.TextTransparency = p68
        return
    elseif p67:IsA("ImageLabel") then
        p67.ImageTransparency = p68
        return
    elseif p67:IsA("ImageButton") then
        p67.ImageTransparency = p68
        return
    elseif p67:IsA("Frame") then
        p67.BackgroundTransparency = p68
    elseif p67:IsA("UIStroke") then
        p67.Transparency = p68
    end
end
local function v_u_73(p70, p71)
    local v72 = TweenInfo.new(0.5)
    if p70:IsA("TextLabel") or p70:IsA("TextButton") then
        v_u_3:Create(p70, v72, {
            ["TextTransparency"] = p71
        }):Play()
        return
    elseif p70:IsA("ImageLabel") or p70:IsA("ImageButton") then
        v_u_3:Create(p70, v72, {
            ["ImageTransparency"] = p71
        }):Play()
        return
    elseif p70:IsA("Frame") then
        v_u_3:Create(p70, v72, {
            ["BackgroundTransparency"] = p71
        }):Play()
    elseif p70:IsA("UIStroke") then
        v_u_3:Create(p70, v72, {
            ["Transparency"] = p71
        }):Play()
    end
end
local function v_u_76(p74)
    if p74:GetAttribute("SkipFade") then
        return true
    end
    local v75 = p74.Parent
    while v75 and v75:IsA("GuiObject") do
        if v75:GetAttribute("SkipFade") then
            return true
        end
        v75 = v75.Parent
    end
    return false
end
local function v_u_81(p77, p78)
    local v79
    if v_u_76(p77) then
        v79 = nil
    else
        v79 = v_u_3:Create(p77, TweenInfo.new(0.5), {
            ["BackgroundTransparency"] = p78
        })
    end
    for _, v80 in p77:GetDescendants() do
        if not v_u_76(v80) then
            v_u_73(v80, p78)
        end
    end
    if v79 then
        v79:Play()
    end
    return v79
end
local function v_u_84(p82)
    if not v_u_76(p82) then
        p82.BackgroundTransparency = 1
    end
    for _, v83 in p82:GetDescendants() do
        if not v_u_76(v83) then
            v_u_69(v83, 1)
        end
    end
    p82.Visible = true
    return v_u_81(p82, 0)
end
local function v_u_88(p85)
    local v86 = {}
    for _, v87 in p85:GetDescendants() do
        if v87:IsA("UIStroke") then
            v86[v87] = v87.Transparency
        end
    end
    return {
        ["BackgroundTransparency"] = p85.BackgroundTransparency,
        ["Strokes"] = v86
    }
end
local function v_u_116(p89)
    local v90 = v_u_25:FindFirstChild("MainGui")
    local v91
    if v90 then
        local v92 = v90:FindFirstChild("Gameplay")
        if v92 then
            v91 = v92:FindFirstChild("Middle")
        else
            v91 = nil
        end
    else
        v91 = nil
    end
    local v93
    if v91 then
        v93 = v91:FindFirstChild("EndScreen")
    else
        v93 = nil
    end
    if not v93 then
        return nil
    end
    local v94 = v93:FindFirstChild("Level")
    if not v94 then
        return nil
    end
    local v95 = v_u_37 or v_u_12.Get(v_u_24, "Level")
    if not v95 then
        return nil
    end
    local v96 = v95.Level or 1
    local v97 = v95.Experience or 0
    local v98 = v95.NextExperienceRequirement or 1000
    local v99 = v94:FindFirstChild("TextLabel")
    if not v99 then
        ::l18::
        local v100 = v94:FindFirstChild("Rank")
        if v100 then
            v100.Image = v_u_17[tostring(v96)] or ""
        end
        local v101 = v94:FindFirstChild("LevelBar")
        if not v101 then
            return nil
        end
        local v102 = v101:FindFirstChild("Current")
        local v103 = v101:FindFirstChild("Earned")
        if not (v102 and v103) then
            return nil
        end
        local v104 = v94:FindFirstChild("CurrentInfo", true)
        local v105 = v94:FindFirstChild("EarnedInfo", true)
        if not (v104 and v105) then
            return nil
        end
        v102:SetAttribute("SkipFade", true)
        v103:SetAttribute("SkipFade", true)
        v104:SetAttribute("SkipFade", true)
        v105:SetAttribute("SkipFade", true)
        local v106 = ("%*xp"):format(v97)
        local v107 = v104:FindFirstChild("Amount")
        if v107 then
            v107.Text = v106
        end
        local v108 = ("+%*xp"):format(p89)
        local v109 = v105:FindFirstChild("Amount")
        if v109 then
            v109.Text = v108
        end
        local v110 = v102.Size.Y
        local v111 = v_u_88(v104)
        local v112 = v_u_88(v105)
        return {
            ["currentXP"] = v97,
            ["xpEarned"] = p89,
            ["nextLevelXP"] = math.max(v98, 1),
            ["currentLevel"] = v96,
            ["barHeight"] = v110,
            ["levelBar"] = v101,
            ["levelFrame"] = v94,
            ["currentBar"] = v102,
            ["earnedBar"] = v103,
            ["currentInfo"] = v104,
            ["earnedInfo"] = v105,
            ["currentInfoTransparency"] = v111,
            ["earnedInfoTransparency"] = v112
        }
    end
    local v113 = "[%* Rank %*]"
    for _, v114 in ipairs(v_u_23) do
        if v96 <= v114.maxLevel then
            v115 = v114.title
            ::l22::
            v99.Text = v113:format(v115, v96)
            goto l18
        end
    end
    local v115 = "Global Elite"
    goto l22
end
local function v_u_127(p117, p118, p119, p120)
    local v121 = p117.Position
    local v122 = p118.AbsolutePosition.X + p119 * p118.AbsoluteSize.X
    local v123 = p117.Parent
    local v124 = v123 and v123.AbsolutePosition.X or 0
    local v125 = p117.AnchorPoint.X * p117.AbsoluteSize.X
    local v126 = v122 - v124 + v125
    return v_u_3:Create(p117, p120, {
        ["Position"] = UDim2.new(0, v126, v121.Y.Scale, v121.Y.Offset)
    })
end
local function v_u_144(p128, p129, p130)
    local v131 = p128.AbsolutePosition.Y
    local v132 = p128.AbsolutePosition.X + p128.AbsoluteSize.X
    local v133 = p129.Parent.AbsolutePosition.X
    local v134 = p129.AnchorPoint.X * p129.AbsoluteSize.X
    if v133 + p130 - v134 >= v132 + 5 then
        local v135 = p129.Parent
        local v136 = v135 and v135.AbsolutePosition.Y or 0
        local v137 = p129.AnchorPoint.Y * p129.AbsoluteSize.Y
        local v138 = v131 - v136 + v137
        return UDim2.new(0, p130, 0, v138)
    end
    local v139 = v131 + p128.AbsoluteSize.Y + -2
    local v140 = p129.Parent
    local v141 = v140 and v140.AbsolutePosition.Y or 0
    local v142 = p129.AnchorPoint.Y * p129.AbsoluteSize.Y
    local v143 = v139 - v141 + v142
    return UDim2.new(0, p130, 0, v143)
end
local function v_u_154(p145, p146, p147, p148, p149)
    local v150 = p147.AbsolutePosition.X + p148 * p147.AbsoluteSize.X
    local v151 = p145.Parent
    local v152 = v151 and v151.AbsolutePosition.X or 0
    local v153 = p145.AnchorPoint.X * p145.AbsoluteSize.X
    return v_u_3:Create(p145, p149, {
        ["Position"] = v_u_144(p146, p145, v150 - v152 + v153)
    })
end
local function v_u_258(p155)
    if not v_u_32 then
        return
    end
    local v156 = p155.currentXP / p155.nextLevelXP
    local v157 = math.clamp(v156, 0, 1)
    local v158 = p155.currentXP + p155.xpEarned
    local v159 = v158 / p155.nextLevelXP
    local v160 = math.clamp(v159, 0, 1)
    local v161 = p155.nextLevelXP <= v158
    p155.currentBar.Visible = false
    p155.earnedBar.Visible = false
    local v162 = p155.currentBar
    local v163 = p155.barHeight
    v162.Size = UDim2.new(0, 0, v163.Scale, v163.Offset)
    local v164 = p155.earnedBar
    local v165 = p155.barHeight
    v164.Size = UDim2.new(0, 0, v165.Scale, v165.Offset)
    p155.currentInfo.Visible = false
    p155.earnedInfo.Visible = false
    local v166 = p155.currentInfo
    local v167 = p155.currentInfoTransparency
    v166.BackgroundTransparency = v167.BackgroundTransparency
    for v168, v169 in pairs(v167.Strokes) do
        if v168 and v168.Parent then
            v168.Transparency = v169
        end
    end
    local v170 = p155.earnedInfo
    local v171 = p155.earnedInfoTransparency
    v170.BackgroundTransparency = v171.BackgroundTransparency
    for v172, v173 in pairs(v171.Strokes) do
        if v172 and v172.Parent then
            v172.Transparency = v173
        end
    end
    local v174 = p155.levelBar
    local v175 = p155.currentInfo
    local v176 = v174.AbsolutePosition.X + 0 * v174.AbsoluteSize.X
    local v177 = v175.Parent
    local v178 = v177 and v177.AbsolutePosition.X or 0
    local v179 = v175.AnchorPoint.X * v175.AbsoluteSize.X
    local v180 = v176 - v178 + v179
    local v181 = p155.levelBar
    local v182 = p155.earnedInfo
    local v183 = v181.AbsolutePosition.X + 0 * v181.AbsoluteSize.X
    local v184 = v182.Parent
    local v185 = v184 and v184.AbsolutePosition.X or 0
    local v186 = v182.AnchorPoint.X * v182.AbsoluteSize.X
    local v187 = v183 - v185 + v186
    local v188 = p155.currentInfo.Position
    local v189 = p155.earnedInfo.Position
    p155.currentInfo.Position = UDim2.new(0, v180, v188.Y.Scale, v188.Y.Offset)
    p155.earnedInfo.Position = UDim2.new(0, v187, v189.Y.Scale, v189.Y.Offset)
    task.wait(0.5)
    if not v_u_32 then
        return
    end
    p155.currentBar.Visible = true
    p155.currentInfo.Visible = true
    if v157 > 0 then
        local v190 = TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local v191 = v_u_3
        local v192 = p155.currentBar
        local v193 = {}
        local v194 = p155.barHeight
        v193.Size = UDim2.new(v157, 0, v194.Scale, v194.Offset)
        local v195 = v191:Create(v192, v190, v193)
        local v196 = v_u_127(p155.currentInfo, p155.levelBar, v157, v190)
        local v197 = {
            ["Parent"] = v_u_26,
            ["Name"] = "XP Bar Fill"
        }
        v_u_18.new("Interface"):play(v197)
        v195:Play()
        v196:Play()
        v195.Completed:Wait()
        if not v_u_32 then
            return
        end
    end
    if p155.xpEarned <= 0 then
        return
    end
    task.wait(0.6)
    if not v_u_32 then
        return
    end
    local v198 = p155.earnedBar
    local v199 = p155.barHeight
    v198.Size = UDim2.new(v157, 0, v199.Scale, v199.Offset)
    p155.earnedBar.Visible = true
    p155.earnedInfo.Visible = true
    local v200 = p155.levelBar
    local v201 = p155.earnedInfo
    local v202 = v200.AbsolutePosition.X + v157 * v200.AbsoluteSize.X
    local v203 = v201.Parent
    local v204 = v203 and v203.AbsolutePosition.X or 0
    local v205 = v201.AnchorPoint.X * v201.AbsoluteSize.X
    local v206 = v202 - v204 + v205
    local v207 = v_u_144(p155.currentInfo, p155.earnedInfo, v206)
    p155.earnedInfo.Position = v207
    if not v161 then
        local v208 = TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local v209 = v_u_3
        local v210 = p155.earnedBar
        local v211 = {}
        local v212 = p155.barHeight
        v211.Size = UDim2.new(v160, 0, v212.Scale, v212.Offset)
        local v213 = v209:Create(v210, v208, v211)
        local v214 = v_u_154(p155.earnedInfo, p155.currentInfo, p155.levelBar, v160, v208)
        local v215 = {
            ["Parent"] = v_u_26,
            ["Name"] = "XP Bar Fill"
        }
        local v216 = v_u_18.new("Interface"):play(v215)
        if v216 then
            v216.PlaybackSpeed = 1.15
        end
        v213:Play()
        v214:Play()
        v213.Completed:Wait()
        return
    end
    local v217 = TweenInfo.new(0.375, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local v218 = v_u_3
    local v219 = p155.earnedBar
    local v220 = {}
    local v221 = p155.barHeight
    v220.Size = UDim2.new(1, 0, v221.Scale, v221.Offset)
    local v222 = v218:Create(v219, v217, v220)
    local v223 = v_u_154(p155.earnedInfo, p155.currentInfo, p155.levelBar, 1, v217)
    local v224 = {
        ["Parent"] = v_u_26,
        ["Name"] = "XP Bar Fill"
    }
    local v225 = v_u_18.new("Interface"):play(v224)
    if v225 then
        v225.PlaybackSpeed = 1.15
    end
    v222:Play()
    v223:Play()
    v222.Completed:Wait()
    if not v_u_32 then
        return
    end
    local v226 = {
        ["Parent"] = v_u_26,
        ["Name"] = "Level Up"
    }
    v_u_18.new("Interface"):play(v226)
    local v227 = (v158 - p155.nextLevelXP) / p155.nextLevelXP
    local v228 = math.clamp(v227, 0, 1)
    local v229 = p155.currentLevel + 1
    local v230 = p155.levelFrame:FindFirstChild("TextLabel")
    if not v230 then
        ::l41::
        local v231 = p155.levelFrame:FindFirstChild("Rank")
        if v231 then
            v231.Image = v_u_17[tostring(v229)] or ""
        end
        local v232 = p155.currentBar
        local v233 = p155.barHeight
        v232.Size = UDim2.new(0, 0, v233.Scale, v233.Offset)
        local v234 = p155.earnedBar
        local v235 = p155.barHeight
        v234.Size = UDim2.new(0, 0, v235.Scale, v235.Offset)
        p155.currentInfo.Visible = false
        local v236 = p155.levelBar
        local v237 = p155.earnedInfo
        local v238 = v236.AbsolutePosition.X + 0 * v236.AbsoluteSize.X
        local v239 = v237.Parent
        local v240 = v239 and v239.AbsolutePosition.X or 0
        local v241 = v237.AnchorPoint.X * v237.AbsoluteSize.X
        local v242 = v238 - v240 + v241
        local v243 = p155.earnedInfo
        local v244 = p155.currentInfo.AbsolutePosition.Y
        local v245 = v243.Parent
        local v246 = v245 and v245.AbsolutePosition.Y or 0
        local v247 = v243.AnchorPoint.Y * v243.AbsoluteSize.Y
        local v248 = v244 - v246 + v247
        p155.earnedInfo.Position = UDim2.new(0, v242, 0, v248)
        local v249 = v_u_3
        local v250 = p155.earnedBar
        local v251 = {}
        local v252 = p155.barHeight
        v251.Size = UDim2.new(v228, 0, v252.Scale, v252.Offset)
        local v253 = v249:Create(v250, v217, v251)
        local v254 = v_u_127(p155.earnedInfo, p155.levelBar, v228, v217)
        v253:Play()
        v254:Play()
        v253.Completed:Wait()
        return
    end
    local v255 = "[%* Rank %*]"
    for _, v256 in ipairs(v_u_23) do
        if v229 <= v256.maxLevel then
            v257 = v256.title
            ::l45::
            v230.Text = v255:format(v257, v229)
            goto l41
        end
    end
    local v257 = "Global Elite"
    goto l45
end
local function v_u_264(p259)
    local v260 = not p259.Type and "" or string.lower(p259.Type)
    local v261 = p259.Name
    if v260 == "credits" then
        return "rbxassetid://115958498634807"
    end
    if v260 == "case" or (v260 == "sticker capsule" or (v260 == "charm pack" or v260 == "charm capsule")) then
        local v262 = v_u_9.GetCaseByName(v261)
        if v262 and v262.imageAssetId then
            return v262.imageAssetId
        end
    end
    local v263 = p259.Skin and (v261 and v_u_8.GetSkinInformation(v261, p259.Skin))
    if v263 then
        if v263.wearImages and v263.wearImages[1] then
            return v263.wearImages[1].assetId
        end
        if v263.charmImages and v263.charmImages[1] then
            return v263.charmImages[1].assetId
        end
        if v263.imageAssetId then
            return v263.imageAssetId
        end
    end
    return "rbxassetid://18822070027"
end
local function v_u_292(p265)
    if v_u_32 and (p265 and #p265 ~= 0) then
        local v266 = v_u_25:FindFirstChild("MainGui")
        local v267
        if v266 then
            local v268 = v266:FindFirstChild("Gameplay")
            if v268 then
                v267 = v268:FindFirstChild("Middle")
            else
                v267 = nil
            end
        else
            v267 = nil
        end
        local v269
        if v267 then
            v269 = v267:FindFirstChild("EndScreen")
        else
            v269 = nil
        end
        if v269 then
            local v270 = v269:FindFirstChild("Drops")
            local v271
            if v270 then
                v271 = v270:FindFirstChild("Container")
            else
                v271 = v270
            end
            local v272
            if v271 then
                v272 = v271:FindFirstChild("ItemTemplate")
            else
                v272 = v271
            end
            if v272 then
                v271:SetAttribute("SkipFade", true)
                v272.Visible = false
                for _, v273 in v271:GetChildren() do
                    if v273:IsA("Frame") and v273.Name ~= "ItemTemplate" then
                        v273:Destroy()
                    end
                end
                v270.Visible = false
                task.wait(0.8)
                if v_u_32 then
                    local v274 = {}
                    for v275, v276 in ipairs(p265) do
                        local v277 = v276.reward
                        local v278 = v277.type == "credits"
                        local v279 = v277.inventoryItem
                        if v278 or v279 then
                            local v280 = v272:Clone()
                            v280.Name = "Drop_" .. v275
                            v280.Visible = false
                            v280.Parent = v271
                            local v281 = v280:FindFirstChild("Content")
                            if v281 then
                                local v282 = v281:FindFirstChild("Icon")
                                if v282 then
                                    v282.Image = v278 and "rbxassetid://115958498634807" or v_u_264(v279)
                                end
                                local v283 = v281:FindFirstChild("amount") or v281:FindFirstChild("Amount")
                                if v283 then
                                    if v278 and v277.amount then
                                        v283.Visible = true
                                        v283.Text = ("x%*"):format(v277.amount)
                                    else
                                        v283.Visible = false
                                    end
                                end
                                local v284 = v281:FindFirstChild("RarityFrame")
                                if v284 then
                                    v284 = v284:FindFirstChild("UIGradient")
                                end
                                if v284 then
                                    if v278 then
                                        v279 = "Rare"
                                    elseif v279 then
                                        v279 = v279.Rarity
                                    end
                                    if v279 then
                                        local v285 = v_u_16[v279]
                                        if v285 and v285.ColorSequence then
                                            v284.Color = v285.ColorSequence
                                        end
                                    end
                                end
                                local v286 = v281.Size
                                v281.Size = UDim2.new(v286.X.Scale * 1.25, v286.X.Offset * 1.25, v286.Y.Scale * 1.25, v286.Y.Offset * 1.25)
                                local v287 = v280:FindFirstChild("Player", true)
                                if v287 and v276.userId > 0 then
                                    v287.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(v276.userId)
                                end
                                table.insert(v274, {
                                    ["item"] = v280,
                                    ["content"] = v281,
                                    ["originalSize"] = v286
                                })
                            else
                                v280:Destroy()
                            end
                        end
                    end
                    if #v274 == 0 then
                        return
                    else
                        v_u_84(v270)
                        task.wait(0.5)
                        if v_u_32 then
                            local v_u_288 = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                            for v289, v_u_290 in ipairs(v274) do
                                task.delay((v289 - 1) * 0.35, function()
                                    if v_u_32 then
                                        v_u_290.item.Visible = true
                                        local v291 = v_u_3:Create(v_u_290.content, v_u_288, {
                                            ["Size"] = v_u_290.originalSize
                                        })
                                        v_u_31:Add(v291, "Cancel")
                                        v291:Play()
                                    end
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
        else
            return
        end
    else
        return
    end
end
local function v_u_301(p293)
    local v294 = p293:FindFirstChild("Gameplay")
    local v295 = p293:FindFirstChild("Menu")
    local v296
    if v294 then
        v296 = v294:FindFirstChild("Middle") or nil
    else
        v296 = nil
    end
    local v297 = {}
    local v298
    if v294 then
        v298 = v294.Visible or false
    else
        v298 = false
    end
    v297.GameplayVisible = v298
    v297.MenuVisible = v295 and v295.Visible or false
    v297.GameplayChildren = {}
    v297.MiddleChildren = {}
    if v294 then
        for _, v299 in v294:GetChildren() do
            if v299:IsA("Frame") or v299:IsA("CanvasGroup") then
                v297.GameplayChildren[v299.Name] = v299.Visible
            end
        end
    end
    if v296 then
        for _, v300 in v296:GetChildren() do
            if v300:IsA("Frame") or v300:IsA("CanvasGroup") then
                v297.MiddleChildren[v300.Name] = v300.Visible
            end
        end
    end
    v_u_36 = v297
end
local function v_u_314(p302, p303)
    if v_u_36 then
        local v304 = v_u_36
        v_u_36 = nil
        local v305 = p302:FindFirstChild("Gameplay")
        local v306 = p302:FindFirstChild("Menu")
        local v307
        if v305 then
            v307 = v305:FindFirstChild("Middle") or nil
        else
            v307 = nil
        end
        if v306 then
            v306.Visible = v304.MenuVisible
        end
        if v305 then
            v305.Visible = v304.GameplayVisible
            for _, v308 in v305:GetChildren() do
                if v308:IsA("Frame") or v308:IsA("CanvasGroup") then
                    local v309 = v304.GameplayChildren[v308.Name]
                    if v309 ~= nil then
                        v308.Visible = v309
                    end
                end
            end
        end
        if v307 then
            for _, v310 in v307:GetChildren() do
                if v310:IsA("Frame") or v310:IsA("CanvasGroup") then
                    local v311 = v304.MiddleChildren[v310.Name]
                    if v311 ~= nil then
                        v310.Visible = v311
                    end
                end
            end
            if p303 then
                for v312 in pairs(v_u_38) do
                    local v313 = v307:FindFirstChild(v312)
                    if v313 and (v313:IsA("Frame") or v313:IsA("CanvasGroup")) then
                        v313.Visible = false
                    end
                end
            end
        end
    end
end
local function v_u_324(p315)
    local v316 = v_u_35 == "Halftime"
    local v317 = p315:FindFirstChild("Menu")
    if v317 then
        v317.Visible = false
    end
    local v318 = p315:FindFirstChild("Gameplay")
    if v318 then
        local v319 = v318:FindFirstChild("Middle")
        local v320
        if v319 then
            v320 = v319:FindFirstChild("EndScreen") or nil
        else
            v320 = nil
        end
        local v321
        if v319 then
            v321 = v319:FindFirstChild("Halftime") or nil
        else
            v321 = nil
        end
        v318.Visible = true
        for _, v322 in v318:GetChildren() do
            if v322:IsA("Frame") or v322:IsA("CanvasGroup") then
                v322.Visible = v322 == v319
            end
        end
        if v319 then
            v319.Visible = true
            for _, v323 in v319:GetChildren() do
                if v323:IsA("Frame") or v323:IsA("CanvasGroup") then
                    if v323 == v320 then
                        v323.Visible = not v316
                    elseif v323 == v321 then
                        v323.Visible = v316
                    else
                        v323.Visible = false
                    end
                end
            end
            if v320 then
                v320.Visible = not v316
            end
            if v321 then
                v321.Visible = v316
            end
        end
    else
        return
    end
end
local function v_u_363(p325)
    local v326 = p325.didWin
    local v327 = p325.isDraw
    local v328 = p325.winningTeam
    local v329 = p325.ctScore
    local v330 = p325.tScore
    local v331 = p325.scoreTextOverride
    local v332 = p325.showAccolades
    local v333 = p325.returnToMenu
    local v334 = p325.overlayMode == "Halftime"
    local v335 = p325.halftimeTeam
    local v_u_336 = v_u_25:FindFirstChild("MainGui")
    if v_u_336 then
        v_u_301(v_u_336)
        v_u_10.setForceLockOverride("EndScreen", true)
        v_u_10.setPerspective(false, true)
        local v337 = v_u_336:FindFirstChild("Menu")
        if v337 then
            v337.Visible = false
            v_u_10.setForceLockOverride("Menu", false)
        end
        local v338 = v_u_336:FindFirstChild("Gameplay")
        if v338 then
            v338.Visible = true
            for _, v339 in v338:GetChildren() do
                if v339:IsA("Frame") or v339:IsA("CanvasGroup") then
                    v339.Visible = false
                end
            end
            local v340 = v338:FindFirstChild("Middle")
            if v340 then
                for _, v341 in v340:GetChildren() do
                    if v341:IsA("Frame") or v341:IsA("CanvasGroup") then
                        v341.Visible = false
                    end
                end
                v340.Visible = true
                local v342 = v340:FindFirstChild("EndScreen")
                local v343 = v340:FindFirstChild("Halftime")
                if v334 then
                    if v342 then
                        v342.Visible = false
                    end
                    if v343 and (v335 == "Counter-Terrorists" or v335 == "Terrorists") then
                        v_u_21.Show(v335)
                    else
                        v_u_21.Hide()
                    end
                    v_u_31:Add(v_u_5.RenderStepped:Connect(function()
                        v_u_324(v_u_336)
                    end), "Disconnect", "EndScreenVisibilityLock")
                    return
                else
                    v_u_21.Hide()
                    if v342 then
                        v342.Visible = true
                        local v344 = v342:FindFirstChild("Victory")
                        local v345 = v342:FindFirstChild("Defeat")
                        if v344 then
                            v344.BackgroundTransparency = 0
                            for _, v346 in v344:GetDescendants() do
                                v_u_69(v346, 0)
                            end
                            v344.Visible = v327 or v326
                        end
                        if v345 then
                            v345.BackgroundTransparency = 0
                            for _, v347 in v345:GetDescendants() do
                                v_u_69(v347, 0)
                            end
                            local v348 = not v327
                            if v348 then
                                v348 = not v326
                            end
                            v345.Visible = v348
                        end
                        local v349 = v342:FindFirstChild("MVP")
                        if v349 then
                            v349.Visible = v332
                        end
                        local v350 = v342:FindFirstChild("Close")
                        if v350 then
                            v350.Visible = v333
                        end
                        local v351
                        if v327 then
                            v351 = v331 or ("<b>%*</b> - %*"):format(v329, v330)
                        else
                            if v328 == "Counter-Terrorists" then
                                local v352 = v329
                                v329 = v330
                                v330 = v352
                            end
                            v351 = v331 or ("<b>%*</b> - %*"):format(v330, v329)
                        end
                        if v344 then
                            local v353 = v344:FindFirstChild("Score")
                            local v354 = v353 and v353:FindFirstChild("TextLabel")
                            if v354 then
                                v354.Text = v351
                            end
                        end
                        if v345 then
                            local v355 = v345:FindFirstChild("Score")
                            local v356 = v355 and v355:FindFirstChild("TextLabel")
                            if v356 then
                                v356.Text = v351
                            end
                        end
                        local v357 = v344 and v344:FindFirstChild("TextLabel")
                        if v357 then
                            v357.Text = v327 and "Draw" or "Victory"
                        end
                        local v358 = v345 and v345:FindFirstChild("TextLabel")
                        if v358 then
                            v358.Text = v327 and "Draw" or "Defeat"
                        end
                        local v359 = v342:FindFirstChild("MapVote")
                        if v359 then
                            v359.Visible = false
                        end
                        local v360 = v342:FindFirstChild("Top")
                        if v360 then
                            v360.Visible = false
                        end
                        local v361 = v342:FindFirstChild("Level")
                        if v361 then
                            v361.Visible = false
                        end
                        local v362 = v342:FindFirstChild("Drops")
                        if v362 then
                            v362.Visible = false
                        end
                        v_u_31:Add(v_u_5.RenderStepped:Connect(function()
                            v_u_324(v_u_336)
                        end), "Disconnect", "EndScreenVisibilityLock")
                    end
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
local function v_u_384()
    local v364 = v_u_25:FindFirstChild("MainGui")
    if v364 then
        local v365 = v364:FindFirstChild("Gameplay")
        if v365 then
            local v366 = v365:FindFirstChild("Middle")
            if v366 then
                local v367 = v366:FindFirstChild("EndScreen")
                if v367 then
                    v367.Visible = false
                    v_u_21.Hide()
                    local v368 = v367:FindFirstChild("Victory")
                    local v369 = v367:FindFirstChild("Defeat")
                    local v370 = v367:FindFirstChild("Level")
                    if v368 then
                        v368.Visible = false
                    end
                    if v369 then
                        v369.Visible = false
                    end
                    if v370 then
                        v370.Visible = false
                        local v371 = v370:FindFirstChild("LevelBar")
                        if v371 then
                            local v372 = v371:FindFirstChild("Current")
                            local v373 = v371:FindFirstChild("Earned")
                            if v372 then
                                v372:SetAttribute("SkipFade", nil)
                            end
                            if v373 then
                                v373:SetAttribute("SkipFade", nil)
                            end
                        end
                        local v374 = v370:FindFirstChild("CurrentInfo", true)
                        local v375 = v370:FindFirstChild("EarnedInfo", true)
                        if v374 then
                            v374:SetAttribute("SkipFade", nil)
                        end
                        if v375 then
                            v375:SetAttribute("SkipFade", nil)
                        end
                    end
                    local v376 = v367:FindFirstChild("MVP")
                    if v376 then
                        v376.Visible = false
                        for v377 = 1, 5 do
                            local v378 = v376:FindFirstChild((tostring(v377)))
                            if v378 then
                                v378.Visible = false
                            end
                        end
                    end
                    local v379 = v367:FindFirstChild("Drops")
                    if v379 then
                        v379.Visible = false
                        local v380 = v379:FindFirstChild("Container")
                        if v380 then
                            v380:SetAttribute("SkipFade", nil)
                            for _, v381 in v380:GetChildren() do
                                if v381:IsA("Frame") and v381.Name ~= "ItemTemplate" then
                                    v381:Destroy()
                                end
                            end
                        end
                    end
                    local v382 = v367:FindFirstChild("MapVote")
                    if v382 then
                        v382.Visible = true
                    end
                    local v383 = v367:FindFirstChild("Top")
                    if v383 then
                        v383.Visible = true
                    end
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
local function v_u_388(p385)
    local v386 = v_u_12.Get(v_u_24, "Inventory")
    if type(v386) ~= "table" then
        return nil
    end
    for _, v387 in ipairs(v386) do
        if v387 and v387._id == p385 then
            return v387
        end
    end
    return nil
end
local function v_u_405(p389, p390, p391)
    local v392 = nil
    local v393 = nil
    local v394 = nil
    if p391 then
        v392 = p391.Name
        v393 = p391.Skin
        v394 = p391.Float
    else
        local v395 = p390 == "CT" and "Counter-Terrorists" or "Terrorists"
        local v396 = v_u_12.Get(v_u_24, "Loadout")
        local v397
        if type(v396) == "table" then
            local v398 = v396[v395]
            if type(v398) == "table" and v398.Equipped then
                v397 = v398.Equipped["Equipped Gloves"]
                if type(v397) ~= "string" or v397 == "" then
                    v397 = nil
                end
            else
                v397 = nil
            end
        else
            v397 = nil
        end
        if v397 then
            local v399 = v_u_388(v397)
            if v399 then
                v392 = v399.Name
                v393 = v399.Skin
                v394 = v399.Float
            end
        end
    end
    local v400 = v392 or v_u_29[p390].Glove
    local v401
    if v393 and (v393 ~= "" and v394 ~= nil) then
        v401 = v_u_8.GetGloves(v400, v393, v394) or nil
    else
        v401 = nil
    end
    local v402
    if v401 then
        v402 = v401:GetChildren()
    else
        local v403 = v_u_2.Assets.Weapons:FindFirstChild(v400)
        if not v403 then
            return
        end
        v402 = v403:GetChildren()
    end
    local v404 = p389:FindFirstChild("CharacterArmor") or Instance.new("Folder")
    v404.Name = "CharacterArmor"
    v404.Parent = p389
    v_u_20(v402, p389, v404)
end
local function v_u_415(p406, p407)
    local v408 = v_u_12.Get(v_u_24, "Loadout")
    if type(v408) ~= "table" then
        return nil
    end
    local v409 = v408[p406]
    if type(v409) ~= "table" or not v409.Loadout then
        return nil
    end
    local v410 = v409.Loadout.Rifles
    if v410 then
        local v411 = v410.Options
        if type(v411) == "table" then
            local v412 = v_u_12.Get(v_u_24, "Inventory")
            if type(v412) ~= "table" then
                return nil
            end
            for _, v413 in ipairs(v410.Options) do
                if type(v413) == "string" and v413 ~= "" then
                    for _, v414 in ipairs(v412) do
                        if v414 and (v414._id == v413 and v414.Name == p407) then
                            return {
                                ["Skin"] = v414.Skin,
                                ["Float"] = v414.Float,
                                ["StatTrack"] = v414.StatTrack,
                                ["NameTag"] = v414.NameTag
                            }
                        end
                    end
                end
            end
            return nil
        end
    end
    return nil
end
local function v_u_430(p416, p417, p418)
    local v419 = v_u_29[p417].Weapon
    local v420 = nil
    if p418 and (p418.Skin and p418.Skin ~= "") then
        v420 = v_u_8.GetCharacterModel(v419, p418.Skin, p418.Float, p418.StatTrack, p418.NameTag)
    else
        local v421 = v_u_415(p417 == "CT" and "Counter-Terrorists" or "Terrorists", v419)
        if v421 and (v421.Skin and v421.Skin ~= "") then
            v420 = v_u_8.GetCharacterModel(v419, v421.Skin, v421.Float, v421.StatTrack, v421.NameTag)
        end
    end
    local v422 = v420 or v_u_8.GetBaseWeaponModel(v419, "Character")
    if v422 then
        v422.Name = v419
        local v423 = p416:FindFirstChild("RightHand")
        if v423 then
            if not v422.PrimaryPart then
                local v424 = v422:FindFirstChild("Weapon")
                if v424 then
                    v424 = v424:FindFirstChild("Insert")
                end
                if not v424 then
                    v422:Destroy()
                    return
                end
                v422.PrimaryPart = v424
            end
            for _, v425 in v422:GetDescendants() do
                if v425:IsA("BasePart") then
                    v425.CanCollide = false
                    v425.CanQuery = false
                    v425.CanTouch = false
                    v425.Anchored = false
                    v425.Massless = true
                end
            end
            v422.Parent = p416
            local v426 = Instance.new("Motor6D")
            v426.Name = "WeaponAttachment"
            v426.Part0 = v423
            v426.Part1 = v422.PrimaryPart
            v426.Parent = v423
            if v419 == "AK-47" then
                v426.C0 = v_u_22
            else
                local v427 = v422:FindFirstChild("Properties")
                if v427 then
                    local v428 = v427:FindFirstChild("C0")
                    local v429 = v427:FindFirstChild("C1")
                    if v428 then
                        v426.C0 = v428.Value
                    end
                    if v429 then
                        v426.C1 = v429.Value
                    end
                end
            end
        else
            v422:Destroy()
            return
        end
    else
        return
    end
end
local function v_u_471(p431)
    local v432 = v_u_25:FindFirstChild("MainGui")
    if not v432 then
        return
    end
    local v433 = v432:FindFirstChild("Gameplay")
    if not v433 then
        return
    end
    local v434 = v433:FindFirstChild("Middle")
    if not v434 then
        return
    end
    local v435 = v434:FindFirstChild("EndScreen")
    if not v435 then
        return
    end
    local v436 = v435:FindFirstChild("MVP")
    if not v436 then
        return
    end
    local v437 = {
        3,
        2,
        4,
        1,
        5
    }
    for v438 = 1, 5 do
        local v439 = v436:FindFirstChild((tostring(v438)))
        if v439 then
            v439.Visible = false
        end
    end
    for v440, v441 in ipairs(p431) do
        local v442 = v437[v440]
        local v443 = v436:FindFirstChild((tostring(v442)))
        if v443 then
            local v444 = v441.data
            local v445 = v441.userId
            local v446 = v_u_4:GetPlayerByUserId((tonumber(v445)))
            local v447 = v446 and v446.Name or ("Player_%*"):format(v445)
            local v448 = v443:FindFirstChild("Username")
            if v448 then
                v448.Text = v447
            end
            local v449 = v443:FindFirstChild("KDA")
            if v449 then
                v449.Text = ("%*-%*-%*"):format(v444.Kills or 0, v444.Deaths or 0, v444.Assists or 0)
            end
            local v450 = v443:FindFirstChild("HSP")
            if v450 then
                local v451 = v444.Kills or 0
                local v452 = v444.Headshots or 0
                local v453
                if v451 <= 0 then
                    v453 = "0%"
                else
                    local v454 = v452 / v451 * 100
                    v453 = ("%*%%"):format((math.floor(v454)))
                end
                v450.Text = v453
            end
            local v455 = v443:FindFirstChild("APR")
            if v455 then
                local v456 = v444.ADR or 0
                local v457 = math.floor(v456)
                v455.Text = tostring(v457)
            end
            local v458 = v443:FindFirstChild("Score")
            if v458 then
                local v459 = v444.Score or 0
                v458.Text = tostring(v459)
            end
            local v460 = v443:FindFirstChild("Category")
            if v460 then
                v460.Text = v444.Accolade or "Participant"
            end
            local v461 = v443:FindFirstChild("Player")
            local v462 = v461 and v461:FindFirstChild("Avatar")
            if v462 then
                v462.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(v445)
            end
            local v463 = v443:FindFirstChild("Pin")
            if v463 then
                if v446 and v444.Team then
                    local v464, v465 = v_u_12.Get(v446, "Loadout", "Inventory")
                    local v466 = ""
                    if v464 and v465 then
                        local v467 = v464[v444.Team]
                        if v467 and v467.Equipped then
                            local v468 = v467.Equipped["Equipped Badge"]
                            if v468 and v468 ~= "" then
                                for _, v469 in ipairs(v465) do
                                    if v469._id == v468 then
                                        local v470 = v_u_8.GetSkinInformation(v469.Name, v469.Skin)
                                        if v470 and v470.imageAssetId then
                                            v466 = v470.imageAssetId
                                        end
                                        break
                                    end
                                end
                            end
                        end
                    end
                    if v466 == "" then
                        v463.Visible = false
                    else
                        v463.Image = v466
                        v463.Visible = true
                    end
                else
                    v463.Visible = false
                end
            end
            v443.Visible = true
        end
    end
end
local function v_u_496(p472, p473)
    local v474 = workspace:FindFirstChild("Map")
    if v474 then
        v474 = workspace.Map:FindFirstChild("EndScreen")
    end
    if not v474 then
        return {}
    end
    local v475 = #p472
    local v476 = {}
    for v477 = 1, math.min(5, v475) do
        local v478 = p472[v477]
        table.insert(v476, v478)
    end
    if p473 then
        v_u_471(v476)
    end
    local v479 = {
        3,
        2,
        4,
        1,
        5
    }
    local v480 = {}
    for v481, v482 in ipairs(v476) do
        local v483 = v479[v481]
        local v484 = v474:FindFirstChild((tostring(v483)))
        if v484 then
            local v485 = v_u_30[v482.data.Team]
            if v485 then
                local v486 = v_u_29[v485]
                if v486 then
                    local v487 = v_u_27:FindFirstChild(v486.Character)
                    if v487 then
                        local v488 = v487:Clone()
                        v488.Name = "EndScreenCharacter_" .. v482.userId
                        v488:PivotTo(v484.CFrame)
                        v488.Parent = v474
                        v_u_405(v488, v485, v482.data.Gloves)
                        v_u_430(v488, v485, v482.data.Weapon)
                        local v489 = v488:FindFirstChild("Humanoid")
                        if v489 then
                            local v490 = v489:FindFirstChildOfClass("Animator")
                            if not v490 then
                                v490 = Instance.new("Animator")
                                v490.Parent = v489
                            end
                            local v491 = v_u_28[v483]
                            if v491 then
                                local v492 = Instance.new("Animation")
                                v492.AnimationId = v491.Entrance
                                local v493 = v490:LoadAnimation(v492)
                                v493.Looped = false
                                v493.Priority = Enum.AnimationPriority.Action
                                v493:Play()
                                local v494 = Instance.new("Animation")
                                v494.AnimationId = v491.Idle
                                local v495 = v490:LoadAnimation(v494)
                                v495.Looped = true
                                v495.Priority = Enum.AnimationPriority.Idle
                                v495:Play()
                                v_u_31:Add(v492)
                                v_u_31:Add(v493)
                                v_u_31:Add(v494)
                                v_u_31:Add(v495)
                            end
                        end
                        v_u_31:Add(v488, "Destroy")
                        table.insert(v480, v488)
                    end
                end
            end
        end
    end
    return v480
end
local function v_u_501()
    local v497 = workspace:FindFirstChild("Map")
    if v497 then
        v497 = workspace.Map:FindFirstChild("EndScreen")
    end
    if not v497 then
        return nil
    end
    local v498 = v497:FindFirstChild("Start")
    local v499 = v497:FindFirstChild("End")
    if not (v498 and v499) then
        warn("[EndScreen] Missing Start or End part!")
        return nil
    end
    v_u_26.CameraType = Enum.CameraType.Scriptable
    v_u_26.CFrame = v498.CFrame
    v_u_26.Focus = v498.CFrame
    v_u_26.FieldOfView = 60
    v_u_10.setMouseEnabled(true)
    local v500 = v_u_3:Create(v_u_26, TweenInfo.new(14, Enum.EasingStyle.Linear), {
        ["CFrame"] = v499.CFrame
    })
    v500:Play()
    return v500
end
local function v_u_509()
    v_u_14.SetBlurEnabled(false)
    if v_u_14.IsCaseSceneActive() then
        v_u_13.broadcastRouter("CaseSceneCloseForGameEnd")
    end
    if v_u_14.IsInspectActive() then
        v_u_13.broadcastRouter("WeaponInspectCloseForGameEnd")
    end
    local v502 = v_u_25:FindFirstChild("MainGui")
    if v502 then
        local v503 = v502:FindFirstChild("Menu")
        if v503 and v503.Visible then
            v503.Visible = false
            v_u_10.setForceLockOverride("Menu", false)
        end
        if v503 then
            v503.BackgroundTransparency = 1
        end
    end
    local v504 = v_u_25:FindFirstChild("MainGui")
    local v505
    if v504 then
        local v506 = v504:FindFirstChild("Gameplay")
        if v506 then
            v505 = v506:FindFirstChild("Middle")
        else
            v505 = nil
        end
    else
        v505 = nil
    end
    if v505 then
        local v507 = v505:FindFirstChild("BuyMenu")
        if v507 and v507.Visible then
            require(v_u_2.Interface.Screens.Gameplay.Middle.BuyMenu).closeFrame()
        end
        local v508 = v505:FindFirstChild("TeamSelection")
        if v508 and v508.Visible then
            require(v_u_2.Interface.Screens.Gameplay.Middle.TeamSelection).closeFrame()
        end
    end
end
function v_u_1.IsActive()
    return v_u_32
end
function v_u_1._runSequence(p_u_510)
    v_u_33 = v_u_33 + 1
    local v_u_511 = v_u_33
    v_u_34 = p_u_510.returnToMenu
    v_u_35 = p_u_510.overlayMode
    v_u_66()
    v_u_363(p_u_510)
    v_u_496(p_u_510.displayPlayers, p_u_510.showAccolades)
    local v512 = v_u_501()
    if v512 then
        v_u_31:Add(v512, "Cancel")
    end
    if p_u_510.showProgression then
        task.delay(4, function()
            if v_u_511 == v_u_33 then
                local v513 = v_u_25:FindFirstChild("MainGui")
                local v514
                if v513 then
                    local v515 = v513:FindFirstChild("Gameplay")
                    if v515 then
                        v514 = v515:FindFirstChild("Middle")
                    else
                        v514 = nil
                    end
                else
                    v514 = nil
                end
                local v516
                if v514 then
                    v516 = v514:FindFirstChild("EndScreen")
                else
                    v516 = nil
                end
                if v516 then
                    local v_u_517 = v516:FindFirstChild("Victory")
                    local v_u_518 = v516:FindFirstChild("Defeat")
                    local v_u_519 = v516:FindFirstChild("Level")
                    local v_u_520 = v_u_116(p_u_510.xpEarned)
                    local v521 = p_u_510.isDraw and v_u_517 and v_u_517 or (p_u_510.didWin and v_u_517 and v_u_517 or v_u_518)
                    if v521 and v521.Visible then
                        v_u_81(v521, 1)
                    end
                    task.delay(0.5, function()
                        if v_u_511 == v_u_33 then
                            if v_u_517 then
                                v_u_517.Visible = false
                            end
                            if v_u_518 then
                                v_u_518.Visible = false
                            end
                            if v_u_519 then
                                v_u_84(v_u_519)
                                task.spawn(function()
                                    if v_u_520 then
                                        v_u_258(v_u_520)
                                    end
                                    if p_u_510.levelRewards and #p_u_510.levelRewards > 0 then
                                        v_u_292(p_u_510.levelRewards)
                                    end
                                end)
                            end
                        end
                    end)
                end
            else
                return
            end
        end)
    end
    local v522 = p_u_510.sequenceDuration or (p_u_510.showProgression and 14 or 4)
    task.delay(v522, function()
        if v_u_511 == v_u_33 then
            v_u_1._finishSequence(p_u_510.returnToMenu)
        end
    end)
end
function v_u_1._finishSequence(p523)
    if p523 == nil then
        p523 = v_u_34
    end
    v_u_33 = v_u_33 + 1
    v_u_35 = "EndScreen"
    v_u_10.setForceLockOverride("EndScreen", false)
    v_u_31:Cleanup()
    v_u_384()
    v_u_32 = false
    v_u_10.SetEnabled(true)
    local v524 = v_u_25:FindFirstChild("MainGui")
    if p523 then
        local v525 = require(v_u_2.Controllers.MenuSceneController)
        v525.ShowMenuScene()
        if v525.IsActive() then
            require(v_u_2.Interface.Screens.Menu.Top).ResetToMainMenu()
            if v524 then
                if not v524.Menu.Visible then
                    v_u_10.setForceLockOverride("Menu", true)
                    v524.Menu.Visible = true
                end
                v524.Gameplay.Visible = false
            end
        end
    else
        if v524 then
            v_u_314(v524, true)
            v524.Menu.Visible = false
            v524.Gameplay.Visible = true
        end
        v_u_10.setPerspective(true, false)
    end
    if p523 then
        v_u_36 = nil
    end
    local v526 = v_u_12.Get(v_u_24, "Level")
    if v526 then
        v_u_37 = {
            ["Level"] = v526.Level,
            ["Experience"] = v526.Experience,
            ["NextExperienceRequirement"] = v526.NextExperienceRequirement
        }
    end
end
function v_u_1.Begin(p527)
    local v528 = p527.Halftime == true and "Halftime" or "EndScreen"
    if v_u_32 then
        if v_u_35 ~= "Halftime" or v528 == "Halftime" then
            warn("[EndScreen] Begin skipped: already active")
            return
        end
        warn("[EndScreen] Interrupting halftime sequence for final end screen")
        v_u_1._finishSequence(false)
    end
    if v_u_14.IsCaseSceneActive() and v_u_13.broadcastRouter("IsCaseSceneRolling") == true then
        return
    end
    local v529 = workspace:GetAttribute("Gamemode") == "Deathmatch"
    local v530
    if p527.Players then
        local v531 = p527.Players
        local v532 = v_u_24.UserId
        v530 = v531[tostring(v532)] or nil
    else
        v530 = nil
    end
    if not v530 then
        local v533 = warn
        local v534 = v_u_24.UserId
        local v535 = tostring(v534)
        local v536 = v_u_24
        local v537 = tostring(v536:GetAttribute("Team"))
        local v538 = p527.WinningTeam
        v533(("[EndScreen] Local player missing from payload (userId=%s, teamAttr=%s, winningTeam=%s)"):format(v535, v537, (tostring(v538))))
        if v529 then
            return
        end
    end
    local v539 = v530 and v530.Team or v_u_24:GetAttribute("Team")
    local v540 = p527.WinningTeam == "Draw"
    local v541 = nil
    local v542 = p527.ShowAccolades ~= false
    local v543 = p527.ShowProgression ~= false
    local v544 = p527.SequenceDuration
    local v545 = p527.ReturnToMenu ~= false
    local v546, v547
    if v529 then
        if v530 then
            local v548 = v530.Team
            if v548 == "Counter-Terrorists" and true or v548 == "Terrorists" then
                v546 = v_u_60(p527.Players)
                if #v546 == 0 then
                    warn("[EndScreen] Begin skipped for Deathmatch: no eligible ranked players")
                    return
                end
                local v549 = nil
                for v550, v551 in ipairs(v546) do
                    local v552 = v551.userId
                    local v553 = v_u_24.UserId
                    if v552 == tostring(v553) then
                        v549 = v550
                        break
                    end
                end
                if not v549 then
                    local v554 = warn
                    local v555 = v_u_24.UserId
                    v554(("[EndScreen] Begin skipped for Deathmatch: local player missing from ranked list (userId=%s)"):format((tostring(v555))))
                    return
                end
                v547 = v549 == 1
                if not v541 then
                    local v556 = "You placed %*"
                    local v557 = v549 % 100
                    local v558
                    if v557 >= 11 and v557 <= 13 then
                        v558 = ("%*th"):format(v549)
                    else
                        local v559 = v549 % 10
                        if v559 == 1 then
                            v558 = ("%*st"):format(v549)
                        elseif v559 == 2 then
                            v558 = ("%*nd"):format(v549)
                        elseif v559 == 3 then
                            v558 = ("%*rd"):format(v549)
                        else
                            v558 = ("%*th"):format(v549)
                        end
                    end
                    v541 = v556:format(v558)
                end
                ::l77::
                v_u_509()
                v_u_11.Stop(false, true)
                v_u_10.SetEnabled(false)
                v_u_32 = true
                local v560 = v530 and v530.ExperienceEarned or 0
                local v561 = {}
                for v562 in pairs(p527.Players) do
                    local v563 = tonumber(v562)
                    if v563 then
                        table.insert(v561, v563)
                    end
                end
                table.sort(v561)
                local v564 = {}
                for _, v565 in ipairs(v561) do
                    local v566 = p527.Players[tostring(v565)]
                    if v566 then
                        v566 = v566.LevelRewards
                    end
                    if v566 then
                        for _, v567 in ipairs(v566) do
                            table.insert(v564, {
                                ["userId"] = v565,
                                ["reward"] = v567
                            })
                        end
                    end
                end
                v_u_1._runSequence({
                    ["displayPlayers"] = v546,
                    ["didWin"] = v547,
                    ["isDraw"] = v540,
                    ["winningTeam"] = p527.WinningTeam,
                    ["xpEarned"] = v560,
                    ["levelRewards"] = v564,
                    ["ctScore"] = p527.CTScore or 0,
                    ["tScore"] = p527.TScore or 0,
                    ["scoreTextOverride"] = v541,
                    ["showAccolades"] = v542,
                    ["showProgression"] = v543,
                    ["sequenceDuration"] = v544,
                    ["returnToMenu"] = v545,
                    ["overlayMode"] = v528,
                    ["halftimeTeam"] = v539
                })
                return
            end
        end
        local v568 = warn
        local v569 = "[EndScreen] Begin skipped for Deathmatch: invalid team data (team=%s)"
        if v530 then
            v530 = v530.Team
        end
        v568(v569:format((tostring(v530))))
        return
    else
        if v539 ~= "Counter-Terrorists" and v539 ~= "Terrorists" then
            local v570 = warn
            local v571 = tostring(v539)
            local v572 = v_u_24
            local v573 = tostring(v572:GetAttribute("Team"))
            local v574 = p527.WinningTeam
            v570(("[EndScreen] Begin skipped: invalid team (team=%s, teamAttr=%s, winningTeam=%s)"):format(v571, v573, (tostring(v574))))
            return
        end
        v547 = not v540
        if v547 then
            v547 = p527.WinningTeam == v539
        end
        local v575 = {}
        for v576, v577 in pairs(p527.Players) do
            if v577.Team == v539 then
                v575[v576] = v577
            end
        end
        v546 = v_u_49(v575)
        goto l77
    end
end
function v_u_1.Initialize()
    local v578 = v_u_25:FindFirstChild("MainGui")
    local v579
    if v578 then
        local v580 = v578:FindFirstChild("Gameplay")
        if v580 then
            v579 = v580:FindFirstChild("Middle")
        else
            v579 = nil
        end
    else
        v579 = nil
    end
    local v581
    if v579 then
        v581 = v579:FindFirstChild("EndScreen")
    else
        v581 = nil
    end
    if v581 then
        local v582 = v581:FindFirstChild("Drops")
        if v582 then
            v582.Visible = false
        end
        local v583 = v581:FindFirstChild("Close")
        if v583 then
            v_u_19(v583)
            v_u_15.Add(v581, v583, function()
                v_u_1._finishSequence()
            end)
        end
    end
    v_u_12.CreateListener(v_u_24, "Level", function(p584)
        if v_u_37 == nil and p584 then
            v_u_37 = {
                ["NextExperienceRequirement"] = p584.NextExperienceRequirement,
                ["Experience"] = p584.Experience,
                ["Level"] = p584.Level
            }
        end
    end)
    v_u_7.Match.EndScreen.Listen(function(p585)
        v_u_1.Begin(p585)
    end)
end
return v_u_1