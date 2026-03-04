local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v_u_4 = game:GetService("Players")
require(v_u_2.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_5 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_6 = nil
local v7 = require(v_u_2.Packages.Signal)
local v_u_8 = v_u_2:WaitForChild("Assets")
local v_u_9 = v_u_8:WaitForChild("Weapons")
local v_u_10 = v_u_8:WaitForChild("Skins")
local v_u_11 = v7.new()
v_u_1.OnItemStockSchemasUpdated = v_u_11
local v_u_12 = {}
local v_u_13 = {
    {
        ["max"] = 0.07,
        ["wear"] = "Factory New"
    },
    {
        ["max"] = 0.15,
        ["wear"] = "Minimal Wear"
    },
    {
        ["max"] = 0.38,
        ["wear"] = "Field-Tested"
    },
    {
        ["max"] = 0.45,
        ["wear"] = "Well-Worn"
    },
    {
        ["max"] = 1,
        ["wear"] = "Battle-Scarred"
    }
}
local function v_u_21(p14)
    if not v_u_6 then
        local v15, v16 = pcall(function()
            return require(v_u_2.Controllers.DataController)
        end)
        if v15 then
            v_u_6 = v16
        end
    end
    local v17 = v_u_6
    if not v17 then
        return nil
    end
    local v18 = v_u_4.LocalPlayer
    if not v18 then
        return nil
    end
    local v19 = v17.Get(v18, "Inventory")
    if not v19 or typeof(v19) ~= "table" then
        return nil
    end
    for _, v20 in ipairs(v19) do
        if v20._id == p14 and v20.Type == "Charm" then
            return {
                ["Skin"] = v20.Skin,
                ["Pattern"] = v20.Pattern
            }
        end
    end
    return nil
end
local function v_u_32(p22, p_u_23)
    local v24 = p22 or 0
    local v25 = typeof(v24) == "number"
    assert(v25, "KillCount must be a number")
    local v26, v27 = pcall(function(...)
        return v_u_5(p_u_23)
    end)
    if v26 and v27 then
        if v27.Class == "Melee" then
            local v28 = math.floor(v24)
            local v29 = math.clamp(v28, 0, 9999)
            return tostring(v29)
        else
            local v30 = math.floor(v24)
            local v31 = math.clamp(v30, 0, 999999)
            return string.format("%06d", v31)
        end
    else
        return nil
    end
end
local function v_u_39(p33, p34, p35)
    local v36 = v_u_10:FindFirstChild(p33)
    if v36 then
        if p35 and p33 == "Smoke Grenade" then
            local v37 = v36:FindFirstChild(p35)
            if v37 and v37:IsA("Folder") then
                return v37
            end
        end
        local v38 = v36:FindFirstChild(p34)
        if v38 and v38:IsA("Folder") then
            return v38
        else
            return nil
        end
    else
        return nil
    end
end
local function v_u_49(p40, p41)
    local v42 = p40.floatRange.min
    local v43 = p40.floatRange.max - 1e-12
    local v44 = math.max(v42, v43)
    local v45 = p40.floatRange.min
    local v46 = math.clamp(p41, v45, v44)
    local v47 = math.clamp(v46, 0, 1)
    for _, v48 in ipairs(v_u_13) do
        if v47 < v48.max then
            return v48.wear
        end
    end
    return "Battle-Scarred"
end
local function v_u_56(p50, p51, p52)
    if not (p50 and p50:IsA("Folder")) then
        warn("[SkinHandler] GetWearTextureFolder: Parent folder not found or invalid")
        return nil
    end
    local v53 = v_u_49(p51, p52)
    if v53 then
        v53 = p50:FindFirstChild(v53)
    end
    if v53 and v53:IsA("Folder") then
        return v53
    end
    for _, v54 in ipairs(v_u_13) do
        local v55 = p50:FindFirstChild(v54.wear)
        if v55 and v55:IsA("Folder") then
            return v55
        end
    end
    return nil
end
local function v_u_62(p57, p58)
    for _, v59 in ipairs(p58:GetChildren()) do
        if v59:IsA("SurfaceAppearance") then
            local v60 = p57:FindFirstChild(v59.Name, true)
            if v60 and v60:IsA("MeshPart") then
                local v61 = v60:FindFirstChildOfClass("SurfaceAppearance")
                if v61 then
                    v61:Destroy()
                end
                v59:Clone().Parent = v60
            end
        end
    end
end
local function v_u_75(p63, p64, p65, p_u_66)
    local v67, v68 = pcall(function(...)
        return v_u_5(p_u_66)
    end)
    local v69 = v67 and (v68 and v68.Class == "Melee") and "KillTrackKnife" or "KillTrak"
    local v70 = v_u_8.Other[v69]:Clone()
    local v71 = p64.PrimaryPart
    if v71 then
        local v72 = p63:FindFirstChild("KillTrack", true)
        if v72 then
            local v73 = v70.PrimaryPart
            local v74 = Instance.new("WeldConstraint")
            v74.Part0 = v73
            v74.Part1 = v71
            v74.Parent = v73
            v70:PivotTo(v72.WorldCFrame)
            v70.Screen.SurfaceGui.TextLabel.Text = v_u_32(p65, p_u_66)
            v70.Parent = p63
        else
            v70:Destroy()
        end
    else
        v70:Destroy()
        return
    end
end
local function v_u_82(p76, p77, p78)
    local v79 = p76:FindFirstChild("Weapon")
    if v79 then
        v_u_75(p76, v79, p77, p78)
    else
        local v80 = p76:FindFirstChild("WeaponL")
        local v81 = p76:FindFirstChild("WeaponR")
        if v80 then
            v_u_75(p76, v80, p77, p78)
        end
        if v81 then
            v_u_75(p76, v81, p77, p78)
        end
    end
end
local function v_u_91(p83, p84, p85)
    local v86 = v_u_8.Other.NamePlate:Clone()
    local v87 = p84.PrimaryPart
    if v87 then
        local v88 = v87:FindFirstChild("Nametag")
        if v88 then
            local v89 = v86.PrimaryPart
            local v90 = Instance.new("WeldConstraint")
            v90.Part0 = v89
            v90.Part1 = v87
            v90.Parent = v89
            v86:PivotTo(v88.WorldCFrame)
            v86.Screen.SurfaceGui.TextLabel.Text = tostring(p85)
            v86.Parent = p83
        else
            v86:Destroy()
        end
    else
        v86:Destroy()
        return
    end
end
local function v_u_97(p92, p93)
    local v94 = p92:FindFirstChild("Weapon")
    if v94 then
        v_u_91(p92, v94, p93)
    else
        local v95 = p92:FindFirstChild("WeaponL")
        local v96 = p92:FindFirstChild("WeaponR")
        if v95 then
            v_u_91(p92, v95, p93)
        end
        if v96 then
            v_u_91(p92, v96, p93)
        end
    end
end
local function v_u_111(p98, p99, p100, p_u_101)
    local v102, v103 = pcall(function(...)
        return v_u_5(p_u_101)
    end)
    local v104 = v102 and (v103 and v103.Class == "Melee") and "KillTrackKnife" or "KillTrak"
    local v105 = v_u_8.Other[v104]:Clone()
    local v106 = p99.PrimaryPart
    if v106 then
        local v107 = p99:FindFirstChild("KillTrack", true)
        if v107 then
            local v108 = v105.PrimaryPart
            local v109 = Instance.new("WeldConstraint")
            v109.Part0 = v108
            v109.Part1 = v106
            v109.Parent = v108
            v105:PivotTo(v107.WorldCFrame)
            local v110 = v105.Screen.SurfaceGui
            v110.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
            v110.CanvasSize = Vector2.new(100, 25)
            v110.TextLabel.Text = v_u_32(p100, p_u_101)
            v110.TextLabel.TextSize = 29
            v110.TextLabel.Size = UDim2.fromScale(1, 1)
            v105.Parent = p98
        else
            v105:Destroy()
        end
    else
        v105:Destroy()
        return
    end
end
local function v_u_118(p112, p113, p114)
    local v115 = p112:FindFirstChild("Weapon")
    if v115 then
        v_u_111(p112, v115, p113, p114)
    else
        local v116 = p112:FindFirstChild("WeaponL")
        local v117 = p112:FindFirstChild("WeaponR")
        if v116 then
            v_u_111(p112, v116, p113, p114)
        end
        if v117 then
            v_u_111(p112, v117, p113, p114)
        end
    end
end
local function v_u_128(p119, p120, p121)
    local v122 = v_u_8.Other.NamePlate:Clone()
    local v123 = p120.PrimaryPart
    if v123 then
        local v124 = v123:FindFirstChild("Nametag")
        if v124 then
            local v125 = v122.PrimaryPart
            local v126 = Instance.new("WeldConstraint")
            v126.Part0 = v125
            v126.Part1 = v123
            v126.Parent = v125
            v122:PivotTo(v124.WorldCFrame)
            local v127 = v122.Screen.SurfaceGui
            v127.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
            v127.CanvasSize = Vector2.new(100, 8)
            v127.TextLabel.Text = tostring(p121)
            v127.TextLabel.TextSize = 8.98
            v127.TextLabel.Size = UDim2.fromScale(0.95, 1)
            v127.TextLabel.Position = UDim2.fromOffset(5, 0)
            v122.Parent = p119
        else
            v122:Destroy()
        end
    else
        v122:Destroy()
        return
    end
end
local function v_u_134(p129, p130)
    local v131 = p129:FindFirstChild("Weapon")
    if v131 then
        v_u_128(p129, v131, p130)
    else
        local v132 = p129:FindFirstChild("WeaponL")
        local v133 = p129:FindFirstChild("WeaponR")
        if v132 then
            v_u_128(p129, v132, p130)
        end
        if v133 then
            v_u_128(p129, v133, p130)
        end
    end
end
local function v_u_151(p135, p136, p137, p138)
    local v139 = v_u_8:FindFirstChild("Charms")
    local v140
    if v139 then
        v140 = v139:FindFirstChild("CharmBase")
    else
        v140 = v139
    end
    if v140 and v140:IsA("Model") then
        local v141 = v139:FindFirstChild(p136)
        if v141 then
            v141 = v141:FindFirstChild((tostring(p137)))
        end
        if v141 and v141:IsA("Model") then
            local v142 = p135:FindFirstChild("Charm" .. p138, true)
            if v142 then
                local v143 = v142.Parent
                if v143 and v143:IsA("BasePart") then
                    local v144 = v140:Clone()
                    v144.Parent = p135
                    v144:PivotTo(v142.WorldCFrame * CFrame.Angles(0, 0, 0))
                    if v144.PrimaryPart then
                        local v145 = v144.PrimaryPart
                        local v146 = Instance.new("WeldConstraint")
                        v146.Part0 = v145
                        v146.Part1 = v143
                        v146.Parent = v145
                    end
                    local v147 = v141:Clone()
                    v147.Parent = v144
                    local v148 = v144:FindFirstChild("Part")
                    if v148 and v148:IsA("BasePart") then
                        v147:PivotTo(v148.CFrame)
                        v148:Destroy()
                    end
                    local v149 = v144:FindFirstChild("HingeConstraint", true)
                    local v150 = v149 and (v147.PrimaryPart and v147.PrimaryPart:FindFirstChild("Attachment"))
                    if v150 then
                        v149.Attachment1 = v150
                    end
                end
            else
                print("Charm attachment not found for weapon:", p135.Name, p138)
                return
            end
        else
            warn("Specific charm not found for weapon:", p135.Name, p136, p137)
            return
        end
    else
        warn("Charm base not found for weapon:", p135.Name)
        return
    end
end
local function v_u_160(p152, p153)
    if typeof(p153) == "table" then
        if p153._id and p153.Position then
            local v154 = p153.Position
            local v155, v156
            if p153.Skin and p153.Pattern then
                v155 = p153.Skin
                v156 = p153.Pattern
            else
                local v157 = v_u_21(p153._id)
                if not v157 then
                    return
                end
                v155 = v157.Skin
                v156 = v157.Pattern
            end
            if v155 and v156 then
                if p152:FindFirstChild("Weapon") then
                    v_u_151(p152, v155, v156, v154)
                else
                    local v158 = p152:FindFirstChild("WeaponL")
                    local v159 = p152:FindFirstChild("WeaponR")
                    if v158 then
                        v_u_151(p152, v155, v156, v154)
                    end
                    if v159 then
                        v_u_151(p152, v155, v156, v154)
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
local function v_u_177(p161, p162, p163, p164)
    local v165 = v_u_8:FindFirstChild("Charms")
    local v166
    if v165 then
        v166 = v165:FindFirstChild("CharmBase")
    else
        v166 = v165
    end
    if v166 and v166:IsA("Model") then
        local v167 = v165:FindFirstChild(p162)
        if v167 then
            v167 = v167:FindFirstChild((tostring(p163)))
        end
        if v167 and v167:IsA("Model") then
            local v168 = p161:FindFirstChild("Charm" .. p164, true)
            if v168 then
                local v169 = v168.Parent
                if v169 and v169:IsA("BasePart") then
                    local v170 = v166:Clone()
                    v170.Parent = p161
                    v170:PivotTo(v168.WorldCFrame * CFrame.Angles(0, 0, 0))
                    if v170.PrimaryPart then
                        local v171 = v170.PrimaryPart
                        local v172 = Instance.new("WeldConstraint")
                        v172.Part0 = v171
                        v172.Part1 = v169
                        v172.Parent = v171
                    end
                    local v173 = v167:Clone()
                    v173.Parent = v170
                    local v174 = v170:FindFirstChild("Part")
                    if v174 and v174:IsA("BasePart") then
                        v173:PivotTo(v174.CFrame)
                        v174:Destroy()
                    end
                    local v175 = v170:FindFirstChild("HingeConstraint", true)
                    local v176 = v175 and (v173.PrimaryPart and v173.PrimaryPart:FindFirstChild("Attachment"))
                    if v176 then
                        v175.Attachment1 = v176
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
local function v_u_186(p178, p179)
    if typeof(p179) == "table" then
        if p179._id and p179.Position then
            local v180 = p179.Position
            local v181, v182
            if p179.Skin and p179.Pattern then
                v181 = p179.Skin
                v182 = p179.Pattern
            else
                local v183 = v_u_21(p179._id)
                if not v183 then
                    return
                end
                v181 = v183.Skin
                v182 = v183.Pattern
            end
            if v181 and v182 then
                if p178:FindFirstChild("Weapon") then
                    v_u_177(p178, v181, v182, v180)
                else
                    local v184 = p178:FindFirstChild("WeaponL")
                    local v185 = p178:FindFirstChild("WeaponR")
                    if v184 then
                        v_u_177(p178, v181, v182, v180)
                    end
                    if v185 then
                        v_u_177(p178, v181, v182, v180)
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
function v_u_1.GetCharmModel(p187, p188)
    local v189 = v_u_8:FindFirstChild("Charms")
    local v190
    if v189 then
        v190 = v189:FindFirstChild("CharmBase")
    else
        v190 = v189
    end
    if not (v190 and v190:IsA("Model")) then
        warn((("Skins.GetCharmModel: Charm base not found for charm \"%*\" with pattern \"%*\""):format(p187, p188)))
        return nil
    end
    local v191 = v189:FindFirstChild(p187)
    if v191 then
        v191 = v191:FindFirstChild((tostring(p188)))
    end
    if not (v191 and v191:IsA("Model")) then
        warn((("Skins.GetCharmModel: Specific charm not found for charm \"%*\" with pattern \"%*\""):format(p187, p188)))
        return nil
    end
    local v192 = v190:Clone()
    v192.Name = p187
    local v193 = v191:Clone()
    v193.Parent = v192
    local v194 = v192:FindFirstChild("Part")
    if v194 and v194:IsA("BasePart") then
        v193:PivotTo(v194.CFrame)
        v194:Destroy()
    end
    local v195 = v192:FindFirstChild("HingeConstraint", true)
    local v196 = v195 and (v193.PrimaryPart and v193.PrimaryPart:FindFirstChild("Attachment"))
    if v196 then
        v195.Attachment1 = v196
    end
    return v192
end
function v_u_1.GetBadgeModel(p197)
    local v198 = v_u_8:FindFirstChild("Badges")
    if not v198 then
        warn((("Skins.GetBadgeModel: Badges folder not found for badge \"%*\""):format(p197)))
        return nil
    end
    local v199 = v198:FindFirstChild(p197)
    if v199 and v199:IsA("Model") then
        return v199:Clone()
    end
    warn((("Skins.GetBadgeModel: Badge model not found for \"%*\""):format(p197)))
    return nil
end
function v_u_1.GetWearNameForFloat(p200, p201)
    return v_u_49(p200, p201)
end
function v_u_1.GetKillTrackValue(p202, p203)
    return v_u_32(p202, p203)
end
function v_u_1.GetMagazine(p204, p205, p206)
    local v207
    if typeof(p204) == "string" and (typeof(p205) == "string" and p204 ~= "") then
        v207 = p205 ~= ""
    else
        v207 = false
    end
    if not v207 then
        return nil
    end
    local v208 = v_u_1.GetSkinInformation(p204, p205)
    if not v208 and next(v_u_12) == nil then
        v_u_11:Wait()
        v208 = v_u_1.GetSkinInformation(p204, p205)
    end
    if not v208 then
        return nil
    end
    local v209 = v_u_9:FindFirstChild(p204)
    if not (v209 and v209:IsA("Folder")) then
        v209 = nil
    end
    if v209 then
        v209 = v209:FindFirstChild("Character")
    end
    if not (v209 and v209:IsA("Model")) then
        return nil
    end
    local v210 = {}
    for _, v211 in ipairs(v209:GetDescendants()) do
        if v211:IsA("BasePart") and v211:HasTag("CharacterMagazine") then
            table.insert(v210, v211)
        end
    end
    if #v210 == 0 then
        return nil
    end
    local v212 = Instance.new("Model")
    v212.Name = "Magazine"
    for _, v213 in ipairs(v210) do
        local v214 = v213:Clone()
        v214.Parent = v212
        if not v212.PrimaryPart then
            v212.PrimaryPart = v214
        end
    end
    local v215 = v_u_10:FindFirstChild(p204)
    local v216
    if v215 then
        v216 = v215:FindFirstChild(p205)
        if not (v216 and v216:IsA("Folder")) then
            v216 = nil
        end
    else
        v216 = nil
    end
    if v216 then
        v216 = v216:FindFirstChild("Character")
    end
    local v217 = v_u_56(v216, v208, p206 or v208.floatRange.min)
    if v217 then
        v_u_62(v212, v217)
    end
    return v212
end
function v_u_1.GetGloves(p218, p219, p220)
    local v221
    if typeof(p218) == "string" and (typeof(p219) == "string" and p218 ~= "") then
        v221 = p219 ~= ""
    else
        v221 = false
    end
    if not v221 then
        return nil
    end
    local v222 = v_u_1.GetSkinInformation(p218, p219)
    if not v222 and next(v_u_12) == nil then
        v_u_11:Wait()
        v222 = v_u_1.GetSkinInformation(p218, p219)
    end
    if not v222 then
        return nil
    end
    local v223 = v_u_9:FindFirstChild(p218)
    if not (v223 and v223:IsA("Folder")) then
        v223 = nil
    end
    if not v223 then
        return nil
    end
    local v224 = Instance.new("Model")
    v224.Name = p218
    for _, v225 in ipairs(v223:GetChildren()) do
        if v225:IsA("BasePart") then
            v225:Clone().Parent = v224
        end
    end
    local v226 = v_u_10:FindFirstChild(p218)
    local v227
    if v226 then
        v227 = v226:FindFirstChild(p219)
        if not (v227 and v227:IsA("Folder")) then
            v227 = nil
        end
    else
        v227 = nil
    end
    if v227 then
        v227 = v227:FindFirstChild("Camera")
    end
    local v228 = v_u_56(v227, v222, p220 or v222.floatRange.min)
    if v228 then
        v_u_62(v224, v228)
    end
    return v224
end
function v_u_1.GetCharacterModel(p229, p230, p231, p232, p233, p234, _, p235)
    local v236
    if typeof(p229) == "string" and (typeof(p230) == "string" and p229 ~= "") then
        v236 = p230 ~= ""
    else
        v236 = false
    end
    if not v236 then
        return nil
    end
    local v237 = v_u_1.GetSkinInformation(p229, p230)
    if not v237 and next(v_u_12) == nil then
        v_u_11:Wait()
        v237 = v_u_1.GetSkinInformation(p229, p230)
    end
    if not v237 then
        warn((("SkinHandler.GetCharacterModel: Skin \"%*\" not found for weapon \"%*\""):format(p230, p229)))
        return nil
    end
    local v238 = v_u_9:FindFirstChild(p229)
    if not (v238 and v238:IsA("Folder")) then
        v238 = nil
    end
    if v238 then
        v238 = v238:FindFirstChild("Character")
    end
    if not (v238 and v238:IsA("Model")) then
        warn((("SkinHandler.GetCharacterModel: Base character model not found for weapon \"%*\""):format(p229)))
        return nil
    end
    local v239 = v238:Clone()
    local v240 = v_u_39(p229, p230, p235)
    if v240 then
        v240 = v240:FindFirstChild("Character")
    end
    local v241 = v_u_56(v240, v237, p231 or v237.floatRange.max)
    if v241 then
        v_u_62(v239, v241)
    end
    if p232 then
        v_u_82(v239, p232, p229)
    end
    if p233 then
        v_u_97(v239, p233)
    end
    if p234 then
        v_u_160(v239, p234)
    end
    return v239
end
function v_u_1.GetWorldModel(p242, p243, p244, p245, p246, p247, _)
    local v248
    if typeof(p242) == "string" and (typeof(p243) == "string" and p242 ~= "") then
        v248 = p243 ~= ""
    else
        v248 = false
    end
    if not v248 then
        return nil
    end
    local v249 = v_u_1.GetSkinInformation(p242, p243)
    if not v249 and next(v_u_12) == nil then
        v_u_11:Wait()
        v249 = v_u_1.GetSkinInformation(p242, p243)
    end
    if not v249 then
        return nil
    end
    local v250 = v_u_9:FindFirstChild(p242)
    if not (v250 and v250:IsA("Folder")) then
        v250 = nil
    end
    if v250 then
        v250 = v250:FindFirstChild("Other")
    end
    if v250 then
        v250 = v250:FindFirstChild("World")
    end
    if not (v250 and v250:IsA("Model")) then
        return nil
    end
    local v251 = v250:Clone()
    local v252 = v_u_10:FindFirstChild(p242)
    local v253
    if v252 then
        v253 = v252:FindFirstChild(p243)
        if not (v253 and v253:IsA("Folder")) then
            v253 = nil
        end
    else
        v253 = nil
    end
    if v253 then
        v253 = v253:FindFirstChild("Character")
    end
    local v254 = v_u_56(v253, v249, p244 or v249.floatRange.max)
    if v254 then
        v_u_62(v251, v254)
    end
    if p245 then
        v_u_82(v251, p245, p242)
    end
    if p246 then
        v_u_97(v251, p246)
    end
    if p247 then
        v_u_160(v251, p247)
    end
    return v251
end
function v_u_1.GetCameraModel(p255, p256, p257, p258, p259, p260, _, p261)
    local v262
    if typeof(p255) == "string" and (typeof(p256) == "string" and p255 ~= "") then
        v262 = p256 ~= ""
    else
        v262 = false
    end
    if not v262 then
        return nil
    end
    local v263 = v_u_1.GetSkinInformation(p255, p256)
    if not v263 and next(v_u_12) == nil then
        v_u_11:Wait()
        v263 = v_u_1.GetSkinInformation(p255, p256)
    end
    if not v263 then
        return nil
    end
    local v264 = v_u_9:FindFirstChild(p255)
    if not (v264 and v264:IsA("Folder")) then
        v264 = nil
    end
    if v264 then
        v264 = v264:FindFirstChild("Camera")
    end
    if not (v264 and v264:IsA("Model")) then
        return nil
    end
    local v265 = v264:Clone()
    local v266 = v_u_39(p255, p256, p261)
    if v266 then
        v266 = v266:FindFirstChild("Camera")
    end
    local v267 = v_u_56(v266, v263, p257 or v263.floatRange.max)
    if v267 then
        v_u_62(v265, v267)
    end
    if p258 then
        v_u_118(v265, p258, p255)
    end
    if p259 then
        v_u_134(v265, p259)
    end
    if p260 then
        v_u_186(v265, p260)
    end
    return v265
end
function v_u_1.GetSkinInformation(p268, p269)
    local v270
    if typeof(p268) == "string" and (typeof(p269) == "string" and p268 ~= "") then
        v270 = p269 ~= ""
    else
        v270 = false
    end
    if v270 then
        local v271 = v_u_12[p268]
        if v271 then
            return v271[p269]
        else
            return nil
        end
    else
        return nil
    end
end
function v_u_1.GetAllSkinsForWeapon(p272)
    if typeof(p272) ~= "string" or p272 == "" then
        return nil
    end
    local v273 = v_u_12[p272]
    if not v273 then
        return nil
    end
    local v274 = {}
    for _, v275 in pairs(v273) do
        table.insert(v274, v275)
    end
    return v274
end
function v_u_1.GetWearImageForFloat(p276, p277)
    local v278 = v_u_49(p276, p277)
    if not v278 then
        return nil
    end
    for _, v279 in ipairs(p276.wearImages) do
        if v279.wear == v278 then
            return v279.assetId
        end
    end
    return nil
end
function v_u_1.GetBaseWeaponModel(p280, p281)
    if typeof(p280) == "string" and p280 ~= "" then
        local v282 = v_u_9:FindFirstChild(p280)
        if not (v282 and v282:IsA("Folder")) then
            v282 = nil
        end
        if v282 then
            local v283 = v282:FindFirstChild(p281)
            if v283 and v283:IsA("Model") then
                return v283:Clone()
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
if v_u_2:GetAttribute("AvaiableSkins") then
    v_u_12 = v_u_3:JSONDecode((v_u_2:GetAttribute("AvaiableSkins")))
    if #v_u_11:GetConnections() > 0 then
        v_u_11:Fire(v_u_12)
    end
end
v_u_2:GetAttributeChangedSignal("AvaiableSkins"):Connect(function()
    local v284 = v_u_2:GetAttribute("AvaiableSkins")
    if v284 then
        v_u_12 = v_u_3:JSONDecode(v284)
        if #v_u_11:GetConnections() > 0 then
            v_u_11:Fire(v_u_12)
        end
    else
        return
    end
end)
return v_u_1