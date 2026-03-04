local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("ContentProvider")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("GamepadService")
local v_u_6 = game:GetService("TweenService")
local v_u_7 = game:GetService("RunService")
local v_u_8 = game:GetService("GuiService")
local v9 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_10 = v9.LocalPlayer
local v_u_11 = v_u_10:WaitForChild("PlayerGui")
local v_u_12 = require(v_u_2.Controllers.DataController)
local v_u_13 = require(v_u_2.Database.Security.Router)
local v14 = require(v_u_2.Database.Components.Libraries.Collections)
local v_u_15 = require(v_u_2.Database.Components.Libraries.Skins)
require(v_u_2.Database.Components.Libraries.Cases)
local v_u_16 = require(v_u_2.Database.Security.Remotes)
local v_u_17 = require(v_u_2.Interface.MenuState)
local v_u_18 = require(v_u_2.Database.Custom.GameStats.UI.Inventory.WeaponDropShadows)
local v_u_19 = require(v_u_2.Database.Custom.GameStats.UI.Inventory.Sort)
local v_u_20 = require(v_u_2.Components.Common.GetSkinDisplayName)
local v_u_21 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_22 = require(v_u_2.Database.Custom.GameStats.Rarities)
local v_u_23 = v_u_2.Assets.Characters
local v_u_24 = require(v_u_2.Database.Custom.GameStats.Character.Attachments)
local v_u_25 = require(v_u_2.Database.Custom.GameStats.Character.Viewport)
local v_u_26 = require(v_u_2.Database.Components.Common.AttachGlovesToCharacter)
local v_u_27 = "Counter-Terrorists"
local v_u_28 = nil
local v_u_29 = "Newest"
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = false
local v_u_33 = nil
local v_u_34 = nil
local v_u_35 = nil
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = nil
local v_u_39 = nil
local v_u_40 = nil
local v_u_41 = false
local v_u_42 = nil
local v_u_43 = false
local v_u_44 = nil
local v_u_45 = nil
local v_u_46 = nil
local v_u_47 = false
local v_u_48 = false
local v_u_49 = false
local v_u_50 = false
local v_u_51 = nil
local v_u_52 = nil
local v_u_53 = nil
local v_u_54 = nil
local function v_u_62(p55, p56)
    local v57 = v_u_12.Get(v_u_10, "Loadout")
    if not v57 then
        return false
    end
    local v58 = v57[p56]
    if not v58 then
        return false
    end
    if v58.Loadout then
        for _, v59 in pairs(v58.Loadout) do
            if v59 and v59.Options then
                for _, v60 in ipairs(v59.Options) do
                    if v60 == p55 then
                        return true
                    end
                end
            end
        end
    end
    if v58.Equipped then
        for _, v61 in pairs(v58.Equipped) do
            if v61 == p55 then
                return true
            end
        end
    end
    return false
end
local function v_u_70(p63, p64)
    local v65 = p63:FindFirstChild("Status")
    if v65 then
        local v66 = v65:FindFirstChild("Counter-Terrorists")
        local v67 = v65:FindFirstChild("Terrorists")
        if v66 and v67 then
            local v68 = v_u_62(p64, "Counter-Terrorists")
            local v69 = v_u_62(p64, "Terrorists")
            v66.Visible = v68
            v67.Visible = v69
        end
    end
end
local v_u_71 = {}
local v_u_72 = {
    ["CT"] = nil,
    ["T"] = nil
}
local v_u_73 = {
    ["CT"] = nil,
    ["T"] = nil
}
local v_u_74 = {
    ["CT"] = {},
    ["T"] = {}
}
local v_u_75 = {}
local v_u_76 = {
    ["CT"] = nil,
    ["T"] = nil
}
local v_u_77 = {}
local v_u_78 = 0
local v_u_79 = false
local v_u_80 = false
local v_u_81 = UDim2.fromScale(0.2, 0.2)
local v_u_82 = Vector2.new(0, 0)
local v_u_83 = {
    ["Pistol"] = "Pistols",
    ["SMG"] = "Mid Tier",
    ["Heavy"] = "Mid Tier",
    ["Rifle"] = "Rifles"
}
local v_u_84 = {
    ["Incendiary Grenade"] = true,
    ["Decoy Grenade"] = true,
    ["Smoke Grenade"] = true,
    ["HE Grenade"] = true,
    ["Flashbang"] = true,
    ["Molotov"] = true
}
local v_u_85 = {
    ["Charm"] = true,
    ["Charm Capsule"] = true,
    ["Sticker"] = true,
    ["Sticker Capsule"] = true,
    ["Grenade"] = true,
    ["Case"] = true
}
local v_u_86 = {
    ["Pistol"] = 1,
    ["SMG"] = 2,
    ["Heavy"] = 3,
    ["Rifle"] = 4,
    ["Equipment"] = 5,
    ["Miscellaneous"] = 6
}
local v_u_87 = {
    ["Glove"] = "Equipped Gloves",
    ["Melee"] = "Equipped Melee",
    ["Zeus x27"] = "Equipped Zeus x27",
    ["Badge"] = "Equipped Badge",
    ["Music Kit"] = "Equipped Music Kit",
    ["Graffiti"] = "Equipped Graffiti"
}
local v_u_88 = {
    ["Equipped Gloves"] = "Gloves",
    ["Equipped Melee"] = "Melee",
    ["Equipped Zeus x27"] = "Zeus",
    ["Equipped Badge"] = "Badge",
    ["Equipped Music Kit"] = "Music Kit",
    ["Equipped Graffiti"] = "Graffiti"
}
local v_u_89 = {
    ["Terrorists"] = { "Glock-18" },
    ["Counter-Terrorists"] = { "USP-S", "P2000" }
}
local v_u_90 = nil
local function v_u_94(p91, p92)
    for _, v93 in ipairs(p91:GetChildren()) do
        if not table.find(p92, v93.Name) then
            v93:Destroy()
        end
    end
end
local function v_u_99(p95, p96, p97, p98)
    if p95 == nil then
        return nil
    else
        return p96 == "SniperScope" and "Sniper" or (p95 == "Heavy" and (p97 == "MachineGun" and "LMG" or "Heavy") or (p95 == "Equipment" and p98 == "Grenade" and "Grenade" or ({
            ["Pistol"] = "Pistol",
            ["Rifle"] = "Rifle",
            ["SMG"] = "SMG",
            ["Equipment"] = nil,
            ["Miscellaneous"] = nil
        })[p95]))
    end
end
local function v_u_102()
    if v_u_52 then
        local v100 = v_u_52
        local v101 = v_u_90.ActionFrame
        if v101 then
            v101.Visible = false
        end
        v_u_52 = nil
        v_u_13.broadcastRouter("WeaponInspect", v100.Name, v100.Skin, v100.Float, v100.StatTrack, v100.NameTag, v100.Charm, v100.Stickers, v100.Type, v100.Pattern, v100._id, v100.Serial, v100.IsTradeable)
    end
end
local _ = {
    ["Pistols"] = 1,
    ["Mid Tier"] = 2,
    ["Rifles"] = 3
}
local _ = {
    ["Equipped Melee"] = 1,
    ["Equipped Gloves"] = 2,
    ["Equipped Badge"] = 3,
    ["Equipped Music Kit"] = 4,
    ["Equipped Graffiti"] = 5,
    ["Equipped Zeus x27"] = 6
}
local v_u_103 = nil
v14.ObserveAvailableCollections(function(p104)
    v_u_103 = p104
end)
local function v_u_142()
    local v105 = v_u_12.Get(v_u_10, "Inventory")
    if not v105 then
        return {}
    end
    local v106 = v_u_19.GetSortComparisonFunction(v_u_29, v_u_10, function()
        return v_u_103
    end)
    local v107 = {}
    local v108 = {}
    for _, v109 in ipairs(v105) do
        if v109 and (v109._id and (not v107[v109._id] and (not v_u_85[v109.Type] and (v109.Type ~= "Case" and (not v_u_84[v109.Name] and v109.Name))))) then
            local v110 = v109.Name
            if type(v110) == "string" then
                if v_u_87[v109.Type] ~= nil then
                    local v111, v112 = pcall(v_u_21, v109.Name)
                    local v113 = not (v111 and (v112 and v112.Team))
                    local v114 = v109.Name
                    local v115 = v_u_27
                    local v116
                    if v114 and (type(v114) == "string" and v114 ~= "") then
                        local v117, v118 = pcall(v_u_21, v114)
                        if v117 and (v118 and v118.Team) then
                            v116 = v118.Team == "Both" and true or v118.Team == v115
                        else
                            v116 = false
                        end
                    else
                        v116 = false
                    end
                    if v113 or v116 then
                        v107[v109._id] = true
                        table.insert(v108, v109)
                    end
                else
                    local v119 = v109.Name
                    local v120 = v_u_27
                    local v121
                    if v119 and (type(v119) == "string" and v119 ~= "") then
                        local v122, v123 = pcall(v_u_21, v119)
                        if v122 and (v123 and v123.Team) then
                            v121 = v123.Team == "Both" and true or v123.Team == v120
                        else
                            v121 = false
                        end
                    else
                        v121 = false
                    end
                    if v121 then
                        v107[v109._id] = true
                        table.insert(v108, v109)
                    else
                        local v124, v125 = pcall(v_u_21, v109.Name)
                        if not (v124 and (v125 and v125.Team)) then
                            v107[v109._id] = true
                            table.insert(v108, v109)
                        end
                    end
                end
            end
        end
    end
    if v_u_28 then
        v108 = {}
        for _, v126 in ipairs(v108) do
            if v126.Type ~= "Case" and (v126.Type ~= "Charm Capsule" and (v126.Type ~= "Sticker Capsule" and v126.Name)) then
                local v127 = v126.Name
                if type(v127) == "string" then
                    local v128, v129 = pcall(v_u_21, v126.Name)
                    if v128 and (v129 and v129.Type == v_u_28) then
                        table.insert(v108, v126)
                    end
                end
            end
        end
    end
    if v_u_30 then
        local v130 = v_u_30.sidebarName == "Melee" and "Melee" or "Glove"
        local v131 = v_u_30.teamKey == "CT" and "Counter-Terrorists" or "Terrorists"
        v108 = {}
        for _, v132 in ipairs(v108) do
            if v132.Type == v130 then
                local v133, v134 = pcall(v_u_21, v132.Name)
                if not v133 or (not v134 or (not v134.Class or v134.Class == v130)) then
                    local v135 = v132.Name
                    if v131 == "Counter-Terrorists" then
                        if v135 ~= "T Knife" and v135 ~= "T Gloves" then
                            ::l89::
                            local v136 = not (v133 and (v134 and v134.Team))
                            local v137 = v132.Name
                            local v138
                            if v137 and (type(v137) == "string" and v137 ~= "") then
                                local v139, v140 = pcall(v_u_21, v137)
                                if v139 and (v140 and v140.Team) then
                                    v138 = v140.Team == "Both" and true or v140.Team == v131
                                else
                                    v138 = false
                                end
                            else
                                v138 = false
                            end
                            if v136 or v138 then
                                table.insert(v108, v132)
                            end
                        end
                    elseif v131 ~= "Terrorists" or v135 ~= "CT Knife" and v135 ~= "CT Gloves" then
                        goto l89
                    end
                end
            end
        end
    end
    if v_u_31 then
        v108 = {}
        for _, v141 in ipairs(v108) do
            if v141.Name == v_u_31.weaponName and (v_u_31.skinName == nil and true or v141.Skin == v_u_31.skinName) then
                table.insert(v108, v141)
            end
        end
    end
    if v106 then
        table.sort(v108, v106)
    end
    return v108
end
local function v_u_153()
    if not v_u_90 then
        return
    end
    local v143 = v_u_90.Tabs.Container.Container
    local v144 = v_u_78 + 1
    local v145 = v_u_78 + 25
    local v146 = #v_u_77
    local v147 = math.min(v145, v146)
    for v148 = v144, v147 do
        local v149 = v_u_77[v148]
        if v149 and not v143:FindFirstChild(v149._id) then
            v_u_1.CreateItemTemplate(v149)
        end
    end
    v_u_78 = v147
    for _, v150 in ipairs(v143:GetChildren()) do
        if v150:IsA("Frame") and (v150.Name ~= "UIGridLayout" and (v150.Name ~= "UIListLayout" and v150.Name ~= "UIPadding")) then
            for v151, v152 in ipairs(v_u_77) do
                if v152._id == v150.Name then
                    v150.LayoutOrder = v151
                    break
                end
            end
        end
    end
end
local function v_u_157()
    if v_u_90 then
        local v154 = v_u_90.Tabs.Container.Container
        local v155 = v154.CanvasPosition.Y
        local v156 = v154.AbsoluteCanvasSize.Y - v154.AbsoluteSize.Y
        if v156 > 0 and (v_u_78 < #v_u_77 and v156 - v155 < 200) then
            v_u_153()
        end
    else
        return
    end
end
local function v_u_184()
    if not (v_u_90 and v_u_90.Visible) then
        return 50
    end
    local v158 = v_u_90.Tabs.Container.Container
    local v159 = v158:FindFirstChildOfClass("UIGridLayout")
    if not v159 then
        return 50
    end
    local v160 = v158.AbsoluteSize
    local v161 = v160.Y
    local v162 = v160.X
    local v163 = v159.CellSize
    local v164 = v159.CellPadding
    local v165 = v163.Y.Scale * v161 + v163.Y.Offset
    local v166 = v164.Y.Scale * v161 + v164.Y.Offset
    local v167 = v163.X.Scale * v162 + v163.X.Offset
    local v168 = v164.X.Scale * v162 + v164.X.Offset
    local v169 = v158:FindFirstChildOfClass("UIPadding")
    local v170, v171, v172, v173
    if v169 then
        v170 = v169.PaddingTop.Scale * v161 + v169.PaddingTop.Offset
        v171 = v169.PaddingBottom.Scale * v161 + v169.PaddingBottom.Offset
        v172 = v169.PaddingLeft.Scale * v162 + v169.PaddingLeft.Offset
        v173 = v169.PaddingRight.Scale * v162 + v169.PaddingRight.Offset
    else
        v170 = 0
        v171 = 0
        v172 = 0
        v173 = 0
    end
    local v174 = v161 - v170 - v171
    local v175 = v162 - v172 - v173
    local v176 = v167 + v168
    local v177
    if v176 > 0 then
        local v178 = (v175 + v168) / v176
        local v179 = math.floor(v178)
        v177 = math.max(1, v179)
    else
        v177 = 1
    end
    local v180 = v165 + v166
    local v181
    if v180 > 0 then
        local v182 = (v174 + v166) / v180
        local v183 = math.floor(v182)
        v181 = math.max(1, v183)
    else
        v181 = 1
    end
    return v181 * v177 + v177
end
local function v_u_195()
    if not (v_u_90 and v_u_90.Visible) then
        return
    end
    local v185 = v_u_90.Tabs.Container.Container
    v_u_78 = 0
    local v186 = v_u_184()
    local v187 = math.max(v186, 50)
    local v188 = #v_u_77
    local v189 = math.min(v187, v188)
    for v190 = 1, v189 do
        local v191 = v_u_77[v190]
        if v191 and not v185:FindFirstChild(v191._id) then
            v_u_1.CreateItemTemplate(v191)
        end
    end
    for _, v192 in ipairs(v185:GetChildren()) do
        if v192:IsA("Frame") and (v192.Name ~= "UIGridLayout" and (v192.Name ~= "UIListLayout" and v192.Name ~= "UIPadding")) then
            for v193, v194 in ipairs(v_u_77) do
                if v194._id == v192.Name then
                    v192.LayoutOrder = v193
                    break
                end
            end
        end
    end
    v_u_78 = v189
    v_u_79 = false
end
local function v_u_200()
    if v_u_90 then
        local v196 = v_u_90.Tabs.Container.Container
        local v197 = {}
        for _, v198 in ipairs(v_u_77) do
            if v198 and v198._id then
                v197[v198._id] = true
            end
        end
        for _, v199 in ipairs(v196:GetChildren()) do
            if v199:IsA("Frame") and (v199.Name ~= "UIGridLayout" and (v199.Name ~= "UIPadding" and not v197[v199.Name])) then
                v199:Destroy()
            end
        end
        v_u_78 = 0
        v_u_79 = true
        if v_u_90.Visible then
            v_u_195()
        end
    end
end
local function v_u_203(p201, p202)
    v_u_6:Create(p201, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["BackgroundTransparency"] = p202 and 0.85 or 1
    }):Play()
end
local function v_u_209(p204, p205)
    local v206 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v207 = p205 and 0 or 1
    for _, v208 in ipairs(p204:GetChildren()) do
        if v208:IsA("Frame") and (v208:FindFirstChild("Price") and v208:FindFirstChild("WeaponName")) then
            v_u_6:Create(v208:FindFirstChild("Price"), v206, {
                ["TextTransparency"] = v207
            }):Play()
            v_u_6:Create(v208:FindFirstChild("WeaponName"), v206, {
                ["TextTransparency"] = v207
            }):Play()
        end
    end
end
local function v_u_215(p210, p211)
    for _, v212 in ipairs(p210:GetChildren()) do
        if v212:IsA("TextButton") then
            local v213 = v212:FindFirstChild("Frame")
            if v213 then
                local v214 = v212.Name == p211
                v213.BackgroundTransparency = v214 and 0 or 1
                if v214 then
                    v213.BackgroundColor3 = Color3.fromRGB(53, 83, 99)
                end
            end
        end
    end
end
local function v_u_225(p216, p217, p218, p219, p220)
    local v221 = v_u_2.Assets.UI.Loadout:FindFirstChild("SortingTemplate")
    if not v221 then
        return nil
    end
    local v_u_222 = v221:Clone()
    v_u_222.Name = p217
    v_u_222.LayoutOrder = p219
    v_u_222.Parent = p216
    local v223 = v_u_222:FindFirstChild("Frame")
    if v223 then
        local v224 = v223:FindFirstChild("TextButton")
        if v224 then
            v224.Text = p218
        end
        v223.BackgroundTransparency = 1
        v223.Active = false
    end
    v_u_222.MouseEnter:Connect(function()
        v_u_203(v_u_222, true)
    end)
    v_u_222.MouseLeave:Connect(function()
        v_u_203(v_u_222, false)
    end)
    v_u_222.MouseButton1Click:Connect(p220)
    return v_u_222
end
local function v_u_228(p226)
    for _, v227 in ipairs(p226:GetChildren()) do
        if v227:IsA("TextButton") then
            v227:Destroy()
        end
    end
end
local function v_u_238()
    local v229 = v_u_12.Get(v_u_10, "Inventory")
    if not v229 then
        return {}
    end
    local v230 = {}
    for _, v231 in ipairs(v229) do
        if not (v_u_85[v231.Type] or v_u_84[v231.Name]) then
            local v232, v233 = pcall(v_u_21, v231.Name)
            if v232 and (v233 and v233.Type) then
                v230[v233.Type] = true
            end
        end
    end
    local v234 = {}
    for v235 in pairs(v230) do
        table.insert(v234, v235)
    end
    table.sort(v234, function(p236, p237)
        return (v_u_86[p236] or 99) < (v_u_86[p237] or 99)
    end)
    return v234
end
local function v_u_247(p239)
    local v240 = v_u_12.Get(v_u_10, "Inventory")
    if not v240 then
        return {}
    end
    local v241 = {}
    for _, v242 in ipairs(v240) do
        if not (v_u_85[v242.Type] or v_u_84[v242.Name]) then
            local v243, v244 = pcall(v_u_21, v242.Name)
            if v243 and (v244 and (not p239 or v244.Type == p239)) then
                v241[v242.Name] = true
            end
        end
    end
    local v245 = {}
    for v246 in pairs(v241) do
        table.insert(v245, v246)
    end
    table.sort(v245)
    return v245
end
local function v_u_252(p248)
    local v249 = v_u_11:GetGuiObjectsAtPosition(p248.X, p248.Y)
    for _, v250 in ipairs(v249) do
        if v250.Name ~= "DragIcon" and (v250:IsA("ViewportFrame") and v250.Name == "Player") then
            local v251 = v250.Parent
            if v251 and (v251.Name == "CT" or v251.Name == "T") then
                return true
            end
        end
    end
    return false
end
local function v_u_257(p253)
    local v254 = v_u_15.GetSkinInformation(p253.Name, p253.Skin)
    if not v254 then
        return nil
    end
    local v255 = v_u_15.GetWearImageForFloat(v254, p253.Float or 0.9999) or v254.imageAssetId or ""
    local v256 = Instance.new("ImageLabel")
    v256.Name = "DragIcon"
    v256.Size = v_u_81
    v256.AnchorPoint = Vector2.new(0.5, 0.5)
    v256.BackgroundTransparency = 1
    v256.Image = v255
    v256.ScaleType = Enum.ScaleType.Fit
    v256.ZIndex = 100
    v256.Active = false
    return v256
end
local function v_u_269(p258, p259)
    local v260 = v_u_90.Teams
    local v261 = (v_u_27 == "Counter-Terrorists" and v260.GunsCT or v260.GunsT):FindFirstChild(p258)
    if v261 then
        local v262 = 0
        for _, v263 in ipairs(v261:GetChildren()) do
            if v263:IsA("Frame") and (v263.Name ~= "Frame" and v263:FindFirstChild("Button")) then
                v262 = v262 + 1
                local v264
                if p258 == "Pistols" and (v262 == 1 and p259) then
                    local v265 = v_u_89[v_u_27]
                    if v265 then
                        v264 = table.find(v265, p259) ~= nil
                    else
                        v264 = false
                    end
                else
                    v264 = true
                end
                local v266 = v263:FindFirstChild("MoveFrame")
                if v266 and v266:IsA("GuiObject") then
                    v266.Visible = v264
                end
                if v264 then
                    local v267 = v263:FindFirstChild("Weapon")
                    if v267 then
                        local v268 = v267:FindFirstChild("Icon")
                        if v268 then
                            v268.Size = UDim2.fromScale(0.9, 0.85)
                        end
                    end
                end
            end
        end
    end
end
local function v_u_273()
    local v270 = v_u_90.Teams:FindFirstChild(v_u_27 == "Counter-Terrorists" and "CT" or "T")
    local v271 = v270 and v270:FindFirstChild("Player")
    if v271 then
        local v272 = v271:FindFirstChild("MoveFrame")
        if v272 and v272:IsA("GuiObject") then
            v272.Visible = true
        end
    end
end
local function v_u_286()
    local v274 = v_u_90.Teams
    for _, v275 in ipairs({ v274.GunsCT, v274.GunsT }) do
        for _, v276 in ipairs({ "Mid Tier", "Pistols", "Rifles" }) do
            local v277 = v275:FindFirstChild(v276)
            if v277 then
                for _, v278 in ipairs(v277:GetChildren()) do
                    if v278:IsA("Frame") and v278.Name ~= "Frame" then
                        local v279 = v278:FindFirstChild("MoveFrame")
                        if v279 and v279:IsA("GuiObject") then
                            v279.Visible = false
                        end
                        local v280 = v278:FindFirstChild("Weapon")
                        if v280 then
                            local v281 = v280:FindFirstChild("Icon")
                            if v281 then
                                v281.Size = UDim2.fromScale(1, 0.95)
                            end
                        end
                    end
                end
            end
        end
    end
    for _, v282 in ipairs({ "CT", "T" }) do
        local v283 = v274:FindFirstChild(v282)
        if v283 then
            local v284 = v283:FindFirstChild("Player")
            if v284 then
                local v285 = v284:FindFirstChild("MoveFrame")
                if v285 and v285:IsA("GuiObject") then
                    v285.Visible = false
                end
            end
        end
    end
end
local function v_u_293(p287)
    local v288 = p287.Parent
    if not (v288 and v288:IsA("Frame")) then
        return nil, nil
    end
    local v289 = v288.Parent
    if not (v289 and v289:IsA("Frame")) then
        return nil, nil
    end
    local v290 = v289.Name
    if v290 ~= "Mid Tier" and (v290 ~= "Pistols" and v290 ~= "Rifles") then
        return nil, nil
    end
    local v291 = 0
    for _, v292 in ipairs(v289:GetChildren()) do
        if v292:IsA("Frame") and (v292.Name ~= "Frame" and v292:FindFirstChild("Button")) then
            v291 = v291 + 1
            if v292 == v288 then
                return v290, v291
            end
        end
    end
    return nil, nil
end
local function v_u_302(p294)
    local v295 = v_u_12.Get(v_u_10, "Inventory")
    if not v295 then
        return nil, nil, nil
    end
    local v296 = p294.Parent
    if v296 and v296:IsA("Frame") then
        local v297 = v296.Name
        local v298, v299 = v_u_293(p294)
        if v298 and v299 then
            for _, v301 in ipairs(v295) do
                if v301._id == v297 then
                    ::l11::
                    return v301, v298, v299
                end
            end
            local v301 = nil
            goto l11
        end
    end
    return nil, nil, nil
end
local function v_u_318(p_u_303)
    local v304 = v_u_12.Get(v_u_10, "Inventory")
    local v308
    if v304 then
        local v306 = p_u_303.Parent
        if not (v306 and v306:IsA("Frame")) then
            v308 = nil
            goto l3
        end
        local v307 = v306.Name
        for _, v308 in ipairs(v304) do
            if v308._id == v307 then
                goto l3
            end
        end
        v308 = nil
        goto l3
    else
        v308 = nil
        ::l3::
        if v308 then
            v_u_42 = v308
            v_u_43 = false
            v_u_44 = p_u_303
            v_u_45 = nil
            v_u_46 = nil
            if not v_u_48 then
                v_u_48 = true
                v_u_8.AutoSelectGuiEnabled = false
                v_u_8.SelectedObject = nil
                pcall(function()
                    v_u_5:EnableGamepadCursor(p_u_303 or v_u_90)
                end)
            end
            local v309 = v308.Name
            local v310, v311 = pcall(v_u_21, v309)
            local v312
            if v310 and (v311 and v311.Type) then
                v312 = v_u_83[v311.Type]
            else
                v312 = nil
            end
            if v312 then
                v_u_269(v312, v308.Name)
                return
            elseif v_u_87[v308.Type] then
                v_u_273()
            else
                local v313, v314 = pcall(v_u_21, v308.Name)
                if v313 and (v314 and (v314.Class == "Melee" or v314.Class == "Glove")) then
                    v_u_273()
                end
            end
        else
            local v315, v316, v317 = v_u_302(p_u_303)
            if v315 and (v316 and v317) then
                v_u_42 = v315
                v_u_43 = true
                v_u_44 = p_u_303
                v_u_45 = v316
                v_u_46 = v317
                if not v_u_48 then
                    v_u_48 = true
                    v_u_8.AutoSelectGuiEnabled = false
                    v_u_8.SelectedObject = nil
                    pcall(function()
                        v_u_5:EnableGamepadCursor(p_u_303 or v_u_90)
                    end)
                end
                v_u_269(v316, v315.Name)
            end
        end
    end
end
local function v_u_328(p319)
    local v320 = v_u_11:GetGuiObjectsAtPosition(p319.X, p319.Y)
    for _, v321 in ipairs(v320) do
        if v321.Name ~= "DragIcon" and (v321:IsA("ImageButton") and (v321.Name == "Button" and v321.Parent)) then
            local v322 = v321.Parent
            if v322:IsA("Frame") and v322.Parent then
                local v323 = v322.Parent
                if v323:IsA("Frame") then
                    local v324 = v323.Name
                    if v324 == "Mid Tier" or (v324 == "Pistols" or v324 == "Rifles") then
                        local v325 = 0
                        local v326 = 1
                        for _, v327 in ipairs(v323:GetChildren()) do
                            if v327:IsA("Frame") and (v327.Name ~= "Frame" and v327:FindFirstChild("Button")) then
                                v325 = v325 + 1
                                if v327 == v322 then
                                    v326 = v325
                                    break
                                end
                            end
                        end
                        return v324, v326, v321
                    end
                end
            end
        end
    end
    return nil, nil, nil
end
local function v_u_336(p329, p330)
    local v331 = v_u_12.Get(v_u_10, "Loadout")
    if not v331 then
        return false, nil
    end
    local v332 = v331[v_u_27]
    if not (v332 and (v332.Loadout and v332.Loadout[p330])) then
        return false, nil
    end
    local v333 = v332.Loadout[p330].Options
    for v334, v335 in ipairs(v333) do
        if v335 == p329 then
            return true, v334
        end
    end
    return false, nil
end
local function v_u_337()
    -- failed to decompile
end
local function v_u_341(p338, p339, p340)
    if v_u_50 then
        return false
    end
    v_u_50 = true
    v_u_16.Inventory.EquipLoadoutSkin.Send({
        ["Type"] = p338,
        ["Slot"] = p339 - 1,
        ["Team"] = v_u_27,
        ["Identifier"] = p340
    })
    task.delay(5, function()
        v_u_50 = false
    end)
    return true
end
local function v_u_345(p342, p343, p344)
    if v_u_50 then
        return false
    end
    v_u_50 = true
    v_u_16.Inventory.SwapLoadoutSkins.Send({
        ["Type"] = p342,
        ["SlotOne"] = p343 - 1,
        ["SlotTwo"] = p344 - 1,
        ["Team"] = v_u_27
    })
    task.delay(5, function()
        v_u_50 = false
    end)
    return true
end
local function v_u_349(p346, p347)
    if v_u_50 then
        return false
    end
    v_u_50 = true
    local v348 = {
        ["Path"] = p346,
        ["Team"] = v_u_27,
        ["Identifier"] = p347
    }
    v_u_16.Inventory.EquipSpecialItem.Send(v348)
    task.delay(5, function()
        v_u_50 = false
    end)
    return true
end
local function v_u_374()
    if v_u_42 then
        local v350 = v_u_4:GetMouseLocation()
        local v351 = v_u_8:GetGuiInset()
        local v352 = Vector2.new(v350.X - v351.X, v350.Y - v351.Y)
        local v353, v354, _ = v_u_328(v352)
        if v353 and v354 then
            local v355 = v_u_42.Name
            local v356 = v_u_27
            local v357
            if v355 and (type(v355) == "string" and v355 ~= "") then
                local v358, v359 = pcall(v_u_21, v355)
                if v358 and (v359 and v359.Team) then
                    v357 = v359.Team == "Both" and true or v359.Team == v356
                else
                    v357 = false
                end
            else
                v357 = false
            end
            if v357 then
                local v360 = v_u_42.Name
                local v361, v362 = pcall(v_u_21, v360)
                local v363
                if v361 and (v362 and v362.Type) then
                    v363 = v_u_83[v362.Type]
                else
                    v363 = nil
                end
                if v363 == v353 then
                    local v364, v365 = v_u_336(v_u_42._id, v353)
                    if v364 and v365 then
                        if v365 ~= v354 then
                            v_u_345(v353, v365, v354)
                        end
                    else
                        local v366, v367 = v_u_337(v_u_42.Name, v353)
                        if v366 and v367 then
                            v_u_341(v353, v367, v_u_42._id)
                        else
                            v_u_341(v353, v354, v_u_42._id)
                        end
                    end
                    v_u_42 = nil
                    v_u_43 = false
                    v_u_44 = nil
                    v_u_45 = nil
                    v_u_46 = nil
                    v_u_49 = false
                    if v_u_48 then
                        v_u_48 = false
                        pcall(function()
                            v_u_5:DisableGamepadCursor()
                        end)
                        v_u_8.AutoSelectGuiEnabled = true
                    end
                    v_u_286()
                else
                    v_u_42 = nil
                    v_u_43 = false
                    v_u_44 = nil
                    v_u_45 = nil
                    v_u_46 = nil
                    v_u_49 = false
                    if v_u_48 then
                        v_u_48 = false
                        pcall(function()
                            v_u_5:DisableGamepadCursor()
                        end)
                        v_u_8.AutoSelectGuiEnabled = true
                    end
                    v_u_286()
                end
            else
                v_u_42 = nil
                v_u_43 = false
                v_u_44 = nil
                v_u_45 = nil
                v_u_46 = nil
                v_u_49 = false
                if v_u_48 then
                    v_u_48 = false
                    pcall(function()
                        v_u_5:DisableGamepadCursor()
                    end)
                    v_u_8.AutoSelectGuiEnabled = true
                end
                v_u_286()
                return
            end
        else
            local v368 = v_u_42.Type
            if v368 then
                v368 = v_u_87[v_u_42.Type]
            end
            if not v368 then
                local v369, v370 = pcall(v_u_21, v_u_42.Name)
                v368 = v369 and (v370 and (v370.Class == "Melee" or v370.Class == "Glove")) and true or v368
            end
            if v368 and v_u_252(v352) then
                local v371 = v_u_87[v_u_42.Type]
                if not v371 then
                    local v372, v373 = pcall(v_u_21, v_u_42.Name)
                    if v372 and v373 then
                        v371 = v373.Class == "Melee" and "Equipped Melee" or (v373.Class == "Glove" and "Equipped Gloves" or v371)
                    end
                end
                if v371 then
                    v_u_349(v371, v_u_42._id)
                end
                v_u_42 = nil
                v_u_43 = false
                v_u_44 = nil
                v_u_45 = nil
                v_u_46 = nil
                v_u_49 = false
                if v_u_48 then
                    v_u_48 = false
                    pcall(function()
                        v_u_5:DisableGamepadCursor()
                    end)
                    v_u_8.AutoSelectGuiEnabled = true
                end
                v_u_286()
            else
                v_u_42 = nil
                v_u_43 = false
                v_u_44 = nil
                v_u_45 = nil
                v_u_46 = nil
                v_u_49 = false
                if v_u_48 then
                    v_u_48 = false
                    pcall(function()
                        v_u_5:DisableGamepadCursor()
                    end)
                    v_u_8.AutoSelectGuiEnabled = true
                end
                v_u_286()
            end
        end
    else
        return
    end
end
local function v_u_375()
    if v_u_90 and v_u_90.Visible then
        if v_u_42 then
            v_u_42 = nil
            v_u_43 = false
            v_u_44 = nil
            v_u_45 = nil
            v_u_46 = nil
            v_u_49 = false
            if v_u_48 then
                v_u_48 = false
                pcall(function()
                    v_u_5:DisableGamepadCursor()
                end)
                v_u_8.AutoSelectGuiEnabled = true
            end
            v_u_286()
        end
    end
end
function v_u_1.HandleSpecialItemDrop()
    if v_u_34 and v_u_36 then
        local v376 = v_u_87[v_u_36]
        if not v376 and v_u_35 then
            local v377, v378 = pcall(v_u_21, v_u_35)
            if v377 and v378 then
                v376 = v378.Class == "Melee" and "Equipped Melee" or (v378.Class == "Glove" and "Equipped Gloves" or v376)
            end
        end
        if v376 then
            v_u_349(v376, v_u_34)
        end
    else
        return
    end
end
function v_u_1.HandleDrop(p379, p380)
    if v_u_34 and v_u_35 then
        local v381 = v_u_35
        local v382 = v_u_27
        local v383
        if v381 and (type(v381) == "string" and v381 ~= "") then
            local v384, v385 = pcall(v_u_21, v381)
            if v384 and (v385 and v385.Team) then
                v383 = v385.Team == "Both" and true or v385.Team == v382
            else
                v383 = false
            end
        else
            v383 = false
        end
        if v383 then
            local v386 = v_u_35
            local v387, v388 = pcall(v_u_21, v386)
            local v389
            if v387 and (v388 and v388.Type) then
                v389 = v_u_83[v388.Type]
            else
                v389 = nil
            end
            if v389 == p379 then
                local v390 = v_u_12.Get(v_u_10, "Loadout")
                if v390 then
                    local v391 = v390[v_u_27]
                    if v391 and (v391.Loadout and v391.Loadout[p379]) then
                        local v392 = v391.Loadout[p379].Options
                        if p380 < 1 or #v392 < p380 then
                            return
                        else
                            local v393, v394 = v_u_336(v_u_34, p379)
                            if v393 and v394 then
                                if v394 ~= p380 then
                                    v_u_345(p379, v394, p380)
                                end
                                return
                            else
                                local v395, v396 = v_u_337(v_u_35, p379)
                                if v395 and v396 then
                                    v_u_341(p379, v396, v_u_34)
                                else
                                    v_u_341(p379, p380, v_u_34)
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
    else
        return
    end
end
local function v_u_408(p397)
    if v_u_40 then
        v_u_40:Disconnect()
        v_u_40 = nil
    end
    v_u_38 = nil
    v_u_39 = nil
    v_u_41 = false
    if v_u_32 then
        return
    else
        local v398 = v_u_257(p397)
        if v398 then
            v_u_32 = true
            v_u_33 = v398
            v_u_34 = p397._id
            v_u_35 = p397.Name
            v_u_36 = p397.Type
            local v399 = p397.Name
            local v400, v401 = pcall(v_u_21, v399)
            local v402
            if v400 and (v401 and v401.Type) then
                v402 = v_u_83[v401.Type]
            else
                v402 = nil
            end
            if v402 then
                v_u_269(v402, p397.Name)
            elseif v_u_87[p397.Type] then
                v_u_273()
            else
                local v403, v404 = pcall(v_u_21, p397.Name)
                if v403 and (v404 and (v404.Class == "Melee" or v404.Class == "Glove")) then
                    v_u_273()
                end
            end
            local v405 = v_u_11:FindFirstChild("MainGui")
            if v405 then
                v398.Parent = v405
            else
                v398.Parent = v_u_11
            end
            local v406 = v_u_4:GetMouseLocation()
            v398.Position = UDim2.fromOffset(v406.X + v_u_82.X, v406.Y + v_u_82.Y)
            v_u_37 = v_u_7.RenderStepped:Connect(function()
                if v_u_33 then
                    local v407 = v_u_4:GetMouseLocation()
                    v_u_33.Position = UDim2.fromOffset(v407.X + v_u_82.X, v407.Y + v_u_82.Y)
                end
            end)
        end
    end
end
function v_u_1.OnItemMouseDown(p409, p410)
    if v_u_42 or v_u_48 then
        return
    elseif not (v_u_32 or v_u_38) then
        v_u_38 = p409
        v_u_39 = v_u_4:GetMouseLocation()
        v_u_41 = p410 or false
        v_u_40 = v_u_7.RenderStepped:Connect(function()
            if v_u_38 and (v_u_39 and (v_u_4:GetMouseLocation() - v_u_39).Magnitude >= 10) then
                local v411 = v_u_38
                if v_u_40 then
                    v_u_40:Disconnect()
                    v_u_40 = nil
                end
                v_u_38 = nil
                v_u_39 = nil
                v_u_41 = false
                v_u_408(v411)
            end
        end)
    end
end
function v_u_1.OnItemClick(p412)
    local v413 = p412.Name
    v_u_30 = nil
    local v414, v415 = pcall(v_u_21, v413)
    if v414 and (v415 and v415.Type) then
        v_u_28 = v415.Type
        v_u_90.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = v415.Type
        v_u_1.PopulateWeaponDropdown()
    end
    v_u_1.SortByWeapon(v413)
end
function v_u_1.EndDrag()
    if v_u_38 and not v_u_32 then
        local v416 = v_u_38
        local v417 = v_u_41
        if v_u_40 then
            v_u_40:Disconnect()
            v_u_40 = nil
        end
        v_u_38 = nil
        v_u_39 = nil
        v_u_41 = false
        if v417 then
            v_u_1.OnItemClick(v416)
        end
        return
    elseif v_u_32 then
        local v418 = v_u_4:GetMouseLocation()
        local v419 = v_u_8:GetGuiInset()
        local v420 = Vector2.new(v418.X - v419.X, v418.Y - v419.Y)
        local v421 = v_u_36
        if v421 then
            v421 = v_u_87[v_u_36]
        end
        if not v421 and v_u_35 then
            local v422, v423 = pcall(v_u_21, v_u_35)
            v421 = v422 and (v423 and (v423.Class == "Melee" or v423.Class == "Glove")) and true or v421
        end
        if v421 and v_u_252(v420) then
            v_u_1.HandleSpecialItemDrop()
        else
            local v424, v425 = v_u_328(v420)
            if v424 and v425 then
                v_u_1.HandleDrop(v424, v425)
            end
        end
        if v_u_40 then
            v_u_40:Disconnect()
            v_u_40 = nil
        end
        v_u_38 = nil
        v_u_39 = nil
        v_u_41 = false
        if v_u_37 then
            v_u_37:Disconnect()
            v_u_37 = nil
        end
        if v_u_33 then
            v_u_33:Destroy()
            v_u_33 = nil
        end
        v_u_32 = false
        v_u_34 = nil
        v_u_35 = nil
        v_u_36 = nil
        v_u_286()
    end
end
function v_u_1.CreateItemTemplate(p_u_426)
    local v427 = v_u_15.GetSkinInformation(p_u_426.Name, p_u_426.Skin)
    if v427 then
        local v_u_428 = v_u_2.Assets.UI.Inventory.ItemTemplate:Clone()
        v_u_428.Main.RarityFrame.UIGradient.Color = v_u_22[v427.rarity].ColorSequence
        v_u_428.Main.Glow.UIGradient.Color = v_u_22[v427.rarity].ColorSequence
        v_u_428.Parent = v_u_90.Tabs.Container.Container
        local v429 = v_u_15.GetWearImageForFloat(v427, p_u_426.Float or 0.9999) or (v427.imageAssetId or "")
        v_u_428.Main.Icon.Image = v429
        local v430 = p_u_426.StatTrack and "KillTrak\226\132\162 " .. p_u_426.Name or p_u_426.Name
        if p_u_426.Type == "Melee" then
            v430 = "\226\152\133 " .. v430
        end
        v_u_428.Information.Weapon.Text = v430
        v_u_428.Information.Skin.Text = v_u_20(p_u_426.Skin)
        v_u_428.Name = p_u_426._id
        local v431
        if typeof(v429) == "string" and v429 ~= "" then
            v431 = v429:gsub("^rbxassetid://", "")
        else
            v431 = nil
        end
        local v432 = not (v_u_18[p_u_426.Name] or v_u_18[p_u_426.Skin]) and (not (v429 and v_u_18[v429]) and v431)
        if v432 then
            v432 = v_u_18[v431]
        end
        local v_u_433
        if v432 then
            v_u_433 = v_u_428.Main.Icon:Clone()
            v_u_433.Name = "DropShadow"
            v_u_433.Image = v432
            v_u_433.ImageTransparency = 1
            v_u_433.ZIndex = v_u_428.Main.Icon.ZIndex - 1
            v_u_433.Parent = v_u_428.Main
        else
            v_u_433 = nil
        end
        local v_u_434 = v_u_428.Main.Icon
        local v_u_435 = v_u_434.Position
        local v_u_436 = UDim2.new(0, 0, -0.05, 0)
        local v_u_437 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v_u_428.Button.MouseEnter:Connect(function()
            v_u_6:Create(v_u_434, v_u_437, {
                ["Position"] = UDim2.new(v_u_435.X.Scale + v_u_436.X.Scale, v_u_435.X.Offset + v_u_436.X.Offset, v_u_435.Y.Scale + v_u_436.Y.Scale, v_u_435.Y.Offset + v_u_436.Y.Offset)
            }):Play()
            if v_u_433 then
                v_u_6:Create(v_u_433, v_u_437, {
                    ["ImageTransparency"] = 0.3
                }):Play()
            end
        end)
        v_u_428.Button.MouseLeave:Connect(function()
            v_u_6:Create(v_u_434, v_u_437, {
                ["Position"] = v_u_435
            }):Play()
            if v_u_433 then
                v_u_6:Create(v_u_433, v_u_437, {
                    ["ImageTransparency"] = 1
                }):Play()
            end
        end)
        v_u_428.Button.MouseButton1Down:Connect(function()
            v_u_1.OnItemMouseDown(p_u_426)
        end)
        v_u_428.Button.Selectable = true
        v_u_428.Button.SelectionGained:Connect(function()
            v_u_6:Create(v_u_434, v_u_437, {
                ["Position"] = UDim2.new(v_u_435.X.Scale + v_u_436.X.Scale, v_u_435.X.Offset + v_u_436.X.Offset, v_u_435.Y.Scale + v_u_436.Y.Scale, v_u_435.Y.Offset + v_u_436.Y.Offset)
            }):Play()
            if v_u_433 then
                v_u_6:Create(v_u_433, v_u_437, {
                    ["ImageTransparency"] = 0.3
                }):Play()
            end
        end)
        v_u_428.Button.SelectionLost:Connect(function()
            v_u_6:Create(v_u_434, v_u_437, {
                ["Position"] = v_u_435
            }):Play()
            if v_u_433 then
                v_u_6:Create(v_u_433, v_u_437, {
                    ["ImageTransparency"] = 1
                }):Play()
            end
        end)
        v_u_428.Button.Activated:Connect(function(p438)
            if p438 and (p438.UserInputType == Enum.UserInputType.Gamepad1 and not v_u_42) then
                v_u_318(v_u_428.Button)
            end
        end)
        v_u_70(v_u_428, p_u_426._id)
    end
end
function v_u_1.CreateLoadoutTemplate(p439, p_u_440, p441)
    local v442 = v_u_15.GetSkinInformation(p_u_440.Name, p_u_440.Skin)
    local v443, v444 = pcall(v_u_21, p_u_440.Name)
    local v445 = v443 and (v444 and v444.Cost) or 0
    if v442 then
        local v446 = p441 == "Counter-Terrorists" and "LoadoutTemplateCT" or "LoadoutTemplateT"
        local v_u_447 = v_u_2.Assets.UI.Loadout:FindFirstChild(v446):Clone()
        v_u_447:WaitForChild("Weapon")
        v_u_447.Weapon:WaitForChild("Icon")
        v_u_447.Weapon.Rarity.UIGradient.Color = v_u_22[v442.rarity].ColorSequence
        v_u_447.Weapon.Glow.ImageColor3 = v_u_22[v442.rarity].Color
        v_u_447.Parent = p439
        v_u_447.Name = p_u_440._id
        local v448 = v_u_15.GetWearImageForFloat(v442, p_u_440.Float or 0.9999) or (v442.imageAssetId or "")
        v_u_447.Price.Text = "$" .. tostring(v445)
        v_u_447.WeaponName.Text = p_u_440.Name
        v_u_447.Weapon.Icon.Image = v448
        local v449
        if typeof(v448) == "string" and v448 ~= "" then
            v449 = v448:gsub("^rbxassetid://", "")
        else
            v449 = nil
        end
        local v450 = not (v_u_18[p_u_440.Name] or v_u_18[p_u_440.Skin]) and (not (v448 and v_u_18[v448]) and v449)
        if v450 then
            v450 = v_u_18[v449]
        end
        local v_u_451
        if v450 then
            v_u_451 = v_u_447.Weapon.Icon:Clone()
            v_u_451.Name = "DropShadow"
            v_u_451.Image = v450
            v_u_451.ImageTransparency = 1
            v_u_451.ZIndex = v_u_447.Weapon.Icon.ZIndex - 1
            v_u_451.Parent = v_u_447.Weapon
        else
            v_u_451 = nil
        end
        local v_u_452 = v_u_447.Weapon.Icon
        local v_u_453 = v_u_452.Position
        local v_u_454 = UDim2.new(0, 0, -0.05, 0)
        local v_u_455 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v_u_447.Button.MouseEnter:Connect(function()
            v_u_6:Create(v_u_452, v_u_455, {
                ["Position"] = UDim2.new(v_u_453.X.Scale + v_u_454.X.Scale, v_u_453.X.Offset + v_u_454.X.Offset, v_u_453.Y.Scale + v_u_454.Y.Scale, v_u_453.Y.Offset + v_u_454.Y.Offset)
            }):Play()
            if v_u_451 then
                v_u_6:Create(v_u_451, v_u_455, {
                    ["ImageTransparency"] = 0.3
                }):Play()
            end
        end)
        v_u_447.Button.MouseLeave:Connect(function()
            v_u_6:Create(v_u_452, v_u_455, {
                ["Position"] = v_u_453
            }):Play()
            if v_u_451 then
                v_u_6:Create(v_u_451, v_u_455, {
                    ["ImageTransparency"] = 1
                }):Play()
            end
        end)
        local v456 = v_u_51 == p439.Name
        v_u_447.Price.TextTransparency = v456 and 0 or 1
        v_u_447.WeaponName.TextTransparency = v456 and 0 or 1
        v_u_447.Button.MouseButton1Down:Connect(function()
            v_u_1.OnItemMouseDown(p_u_440, true)
        end)
        v_u_447.Button.MouseEnter:Connect(function()
            v_u_1.OnLoadoutItemHover(p_u_440)
        end)
        v_u_447.Button.MouseLeave:Connect(function()
            v_u_1.OnLoadoutItemUnhover()
        end)
        v_u_447.Button.Selectable = true
        v_u_447.Button.SelectionGained:Connect(function()
            v_u_1.OnLoadoutItemHover(p_u_440)
            v_u_6:Create(v_u_452, v_u_455, {
                ["Position"] = UDim2.new(v_u_453.X.Scale + v_u_454.X.Scale, v_u_453.X.Offset + v_u_454.X.Offset, v_u_453.Y.Scale + v_u_454.Y.Scale, v_u_453.Y.Offset + v_u_454.Y.Offset)
            }):Play()
            if v_u_451 then
                v_u_6:Create(v_u_451, v_u_455, {
                    ["ImageTransparency"] = 0.3
                }):Play()
            end
        end)
        v_u_447.Button.SelectionLost:Connect(function()
            v_u_6:Create(v_u_452, v_u_455, {
                ["Position"] = v_u_453
            }):Play()
            if v_u_451 then
                v_u_6:Create(v_u_451, v_u_455, {
                    ["ImageTransparency"] = 1
                }):Play()
            end
        end)
        v_u_447.Button.Activated:Connect(function(p457)
            if p457 and (p457.UserInputType == Enum.UserInputType.Gamepad1 and not v_u_42) then
                v_u_318(v_u_447.Button)
            end
        end)
    end
end
function v_u_1.PopulateCategoryDropdown()
    local v_u_458 = v_u_90.Tabs.Container.WeaponSort.Category.ScrollingFrame
    if v_u_458 then
        v_u_228(v_u_458)
        v_u_225(v_u_458, "All", "All Categories", 0, function()
            v_u_1.SortByCategory(nil)
            v_u_215(v_u_458, "All")
            v_u_458.Visible = false
        end)
        local v459 = v_u_238()
        for v460, v_u_461 in ipairs(v459) do
            v_u_225(v_u_458, v_u_461, v_u_461, v460, function()
                v_u_1.SortByCategory(v_u_461)
                v_u_215(v_u_458, v_u_461)
                v_u_458.Visible = false
            end)
        end
        v_u_215(v_u_458, "All")
    end
end
function v_u_1.PopulateWeaponDropdown()
    local v_u_462 = v_u_90.Tabs.Container.WeaponSort.Weapon:FindFirstChild("Options")
    if v_u_462 and (v_u_462:IsA("Frame") or v_u_462:IsA("ScrollingFrame")) then
        v_u_228(v_u_462)
        v_u_225(v_u_462, "All", "All Weapons", 0, function()
            v_u_1.SortByWeapon(nil)
            v_u_215(v_u_462, "All")
            v_u_462.Visible = false
        end)
        local v463 = v_u_247(v_u_28)
        for v464, v_u_465 in ipairs(v463) do
            v_u_225(v_u_462, v_u_465, v_u_465, v464, function()
                v_u_1.SortByWeapon(v_u_465)
                v_u_215(v_u_462, v_u_465)
                v_u_462.Visible = false
            end)
        end
        v_u_215(v_u_462, "All")
    end
end
function v_u_1.SortByCategory(p466)
    v_u_28 = p466
    v_u_31 = nil
    local _ = v_u_90.Tabs.Container.Container
    v_u_90.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = p466 or "All Categories"
    v_u_1.PopulateWeaponDropdown()
    v_u_90.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
    local v467 = v_u_90.Tabs.Container.WeaponSort:FindFirstChild("Reset")
    if v467 then
        local v468 = v_u_90.Tabs.Container.WeaponSort.Weapon
        v467.Visible = v_u_28 ~= nil and true or v468.Frame.TextLabel.Text ~= "All Weapons"
    end
    if v_u_90 and v_u_90.Visible then
        v_u_77 = v_u_142()
        v_u_200()
    else
        v_u_80 = true
        v_u_79 = true
    end
end
function v_u_1.SortByWeapon(p469, p470)
    v_u_31 = p469 and ({
        ["weaponName"] = p469,
        ["skinName"] = p470
    } or nil) or nil
    local _ = v_u_90.Tabs.Container.Container
    v_u_90.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = p469 or "All Weapons"
    if v_u_19.GetSortComparisonFunction(v_u_29, v_u_10, function()
        return v_u_103
    end) then
        if v_u_90 and v_u_90.Visible then
            v_u_77 = v_u_142()
            v_u_200()
        else
            v_u_80 = true
            v_u_79 = true
        end
    end
    local v471 = v_u_90.Tabs.Container.WeaponSort:FindFirstChild("Reset")
    if v471 then
        local v472 = v_u_90.Tabs.Container.WeaponSort.Weapon
        v471.Visible = v_u_28 ~= nil and true or v472.Frame.TextLabel.Text ~= "All Weapons"
    end
end
function v_u_1.SortBySkinMetadata(p473)
    v_u_29 = p473
    local _ = v_u_90.Tabs.Container.Container
    v_u_90.Tabs.Container.SkinSort.Sort.Frame.TextLabel.Text = p473
    if v_u_19.GetSortComparisonFunction(p473, v_u_10, function()
        return v_u_103
    end) then
        if not (v_u_90 and v_u_90.Visible) then
            v_u_80 = true
            v_u_79 = true
            return
        end
        v_u_77 = v_u_142()
        v_u_200()
    end
end
function v_u_1.UpdateInventoryContainer()
    if v_u_90 then
        if v_u_90.Visible then
            v_u_42 = nil
            v_u_43 = false
            v_u_44 = nil
            v_u_45 = nil
            v_u_46 = nil
            v_u_49 = false
            if v_u_48 then
                v_u_48 = false
                pcall(function()
                    v_u_5:DisableGamepadCursor()
                end)
                v_u_8.AutoSelectGuiEnabled = true
            end
            v_u_286()
            local v474 = v_u_12.Get(v_u_10, "Inventory")
            local v475 = {}
            for _, v476 in ipairs(v474) do
                if v476 and v476._id then
                    v475[v476._id] = true
                end
            end
            local v477 = v_u_90.Tabs.Container.Container
            for _, v478 in ipairs(v477:GetChildren()) do
                if v478:IsA("Frame") and (v478.Name ~= "UIGridLayout" and (v478.Name ~= "UIPadding" and not v475[v478.Name])) then
                    v478:Destroy()
                end
            end
            v_u_1.PopulateCategoryDropdown()
            v_u_1.PopulateWeaponDropdown()
            v_u_1.SortBySkinMetadata(v_u_29)
        else
            v_u_80 = true
            v_u_79 = true
        end
    else
        return
    end
end
function v_u_1.UpdateLoadoutContainer()
    -- failed to decompile
end
function v_u_1.UpdateSidebarFrames(p479, p480)
    local v481 = v_u_12.Get(v_u_10, "Inventory")
    local v482 = p480 or v_u_27
    local v483 = v482 == "Counter-Terrorists" and "CT" or "T"
    local v484 = v_u_90.Teams:FindFirstChild(v483)
    if not v484 then
        return
    end
    local v485 = v484:FindFirstChild("Sidebar")
    if not v485 then
        return
    end
    local v486 = p479[v482]
    if not (v486 and v486.Equipped) then
        return
    end
    for v487, v488 in pairs(v_u_88) do
        local v489 = v486.Equipped[v487]
        local v490 = v485:FindFirstChild(v488)
        if v490 then
            local v491 = v490:FindFirstChild("Weapon")
            local v492
            if v491 then
                v492 = v491:FindFirstChild("Icon")
            else
                v492 = v491
            end
            local v493
            if v491 then
                v493 = v491:FindFirstChild("Rarity")
            else
                v493 = v491
            end
            local v494
            if v491 then
                v494 = v491:FindFirstChild("Glow")
            else
                v494 = v491
            end
            local v495 = nil
            local v496 = false
            local v498
            if v489 and v489 ~= "" then
                for _, v498 in ipairs(v481) do
                    if v498._id == v489 then
                        goto l28
                    end
                end
                v498 = nil
                ::l28::
                if v498 then
                    local v499 = v_u_15.GetSkinInformation(v498.Name, v498.Skin)
                    if v499 then
                        v496 = true
                        if v492 then
                            v492.Image = v_u_15.GetWearImageForFloat(v499, v498.Float or 0.9999) or (v499.imageAssetId or "")
                            v492.Visible = true
                        end
                        if v493 then
                            v493.Visible = true
                            local v500 = v493:FindFirstChild("UIGradient")
                            if v500 then
                                v500.Color = v_u_22[v499.rarity].ColorSequence
                            end
                        end
                        if v494 then
                            v494.Visible = true
                            v494.ImageColor3 = v_u_22[v499.rarity].Color
                        end
                    end
                else
                    v498 = v495
                end
            else
                v498 = v495
            end
            if not v496 then
                if v492 then
                    v492.Visible = false
                end
                if v493 then
                    v493.Visible = false
                end
                if v494 then
                    v494.Visible = false
                end
            end
            if v491 and (v488 == "Melee" or v488 == "Gloves") then
                if v498 then
                    v491:SetAttribute("EquippedItemId", v498._id)
                else
                    v491:SetAttribute("EquippedItemId", nil)
                end
                v491:SetAttribute("SidebarName", v488)
                v491:SetAttribute("TeamKey", v482 == "Counter-Terrorists" and "CT" or "T")
            end
        end
    end
end
local function v_u_516()
    local v501 = v_u_90.Teams
    for _, v502 in ipairs({ "CT", "T" }) do
        local v503 = v_u_25.VIEWPORT_CHARACTER_CONFIG[v502]
        local v504 = v501:FindFirstChild(v502)
        if v504 then
            local v505 = v504:FindFirstChild("Player")
            if v505 then
                for _, v506 in ipairs(v505:GetChildren()) do
                    if v506:IsA("WorldModel") or v506:IsA("Camera") then
                        v506:Destroy()
                    end
                end
                local v507 = v_u_23:FindFirstChild(v503.Character)
                if v507 then
                    local v508 = Instance.new("WorldModel")
                    v508.Name = "CharacterWorldModel"
                    v508.Parent = v505
                    local v509 = v507:Clone()
                    v509.Name = "ViewportCharacter"
                    v509.Parent = v508
                    v_u_71[v502] = v509
                    local v510 = v503.CharacterOffset or CFrame.new(0, 0, 0)
                    if v509.PrimaryPart then
                        v509:SetPrimaryPartCFrame(v510)
                    else
                        v509:PivotTo(v510)
                    end
                    local v511 = v509:FindFirstChildOfClass("Humanoid")
                    if v511 and v503.IdleAnimation then
                        local v512 = v511:FindFirstChildOfClass("Animator")
                        if not v512 then
                            v512 = Instance.new("Animator")
                            v512.Parent = v511
                        end
                        local v513 = Instance.new("Animation")
                        v513.AnimationId = v503.IdleAnimation
                        local v514 = v512:LoadAnimation(v513)
                        v514.Looped = true
                        v514:Play()
                    end
                    local v515 = Instance.new("Camera")
                    v515.Name = "ViewportCamera"
                    v515.CameraType = Enum.CameraType.Scriptable
                    v515.FieldOfView = 50
                    v515.CFrame = CFrame.new(0, 0, 0) * v503.CameraOffset
                    v515.Parent = v505
                    v505.CurrentCamera = v515
                end
            end
        end
    end
end
local function v_u_528(p517)
    local v518 = v_u_71[p517]
    if not v518 then
        return
    end
    local v519 = v_u_74[p517]
    if v519 then
        for _, v520 in ipairs(v519) do
            if v520 and v520.Parent then
                v520:Destroy()
            end
        end
        v_u_74[p517] = {}
    end
    local v521 = p517 == "CT" and "Counter-Terrorists" or "Terrorists"
    local v522 = v_u_12.Get(v_u_10, "Loadout")
    if not (v522 and v522[v521]) then
        return
    end
    local v523 = v522[v521].Equipped
    if v523 then
        v523 = v522[v521].Equipped["Equipped Gloves"]
    end
    if not v523 then
        return
    end
    local v524 = v_u_12.Get(v_u_10, "Inventory")
    local v525 = nil
    for _, v526 in ipairs(v524) do
        if v526._id == v523 then
            v525 = v526
            break
        end
    end
    if v525 then
        local v527 = v_u_15.GetGloves(v525.Name, v525.Skin, v525.Float)
        if v527 then
            v_u_74[p517] = v_u_26(v527:GetChildren(), v518, v518)
            v527:Destroy()
        end
    else
        return
    end
end
local function v_u_582(p529, p530)
    local v531 = v_u_71[p529]
    if v531 then
        if p530 and v_u_76[p529] == p530._id then
            local v532 = v_u_73[p529]
            if not (v532 and v532.IsPlaying) then
                local v533 = v531:FindFirstChildOfClass("Humanoid")
                local v534 = v533 and v533:FindFirstChildOfClass("Animator")
                if v534 then
                    local v535 = nil
                    if p530.Type == "Melee" then
                        v535 = "Melee"
                    else
                        local v536, v537 = pcall(v_u_21, p530.Name)
                        if v536 and v537 then
                            v535 = v_u_99(v537.Type, v537.AimingOptions, v537.MuzzleType, v537.Class)
                        end
                    end
                    if v535 then
                        local v538 = p530.Name
                        local v539
                        if v535 and v_u_25.ANIMATION_MAPPING[v535] then
                            local v540 = v_u_25.ANIMATION_MAPPING[v535]
                            if v538 and v540[v538] then
                                v539 = v540[v538]
                            else
                                v539 = v540.Default
                            end
                        else
                            v539 = nil
                        end
                        if v539 then
                            local v541 = v534:LoadAnimation(v539)
                            v541.Looped = true
                            v541.Priority = Enum.AnimationPriority.Action
                            v541:Play()
                            v_u_73[p529] = v541
                        end
                    end
                end
            end
            return
        else
            local v542 = v_u_73[p529]
            if v542 then
                v542:Stop()
                v_u_73[p529] = nil
            end
            local v543 = v_u_72[p529]
            if v543 then
                v543:Destroy()
                v_u_72[p529] = nil
            end
            v_u_76[p529] = nil
            for _, v544 in pairs({ v_u_24.DEFAULT_JOINT_PART, "UpperTorso", "LeftHand" }) do
                local v545 = v531:FindFirstChild(v544)
                if v545 then
                    local v546 = v545:FindFirstChild("WeaponAttachment")
                    if v546 then
                        v546:Destroy()
                    end
                    local v547 = v545:FindFirstChild("WeaponAttachmentHandleR")
                    if v547 then
                        v547:Destroy()
                    end
                    local v548 = v545:FindFirstChild("WeaponAttachmentHandleL")
                    if v548 then
                        v548:Destroy()
                    end
                end
            end
            if p530 then
                local v549 = v_u_15.GetCharacterModel(p530.Name, p530.Skin, p530.Float, p530.StatTrack, p530.NameTag)
                if v549 then
                    v549.Name = p530.Name
                    local v550 = v531:FindFirstChild(v_u_24.WEAPON_JOINT_PARTS[p530.Name] or v_u_24.DEFAULT_JOINT_PART)
                    if v550 then
                        if not v549.PrimaryPart then
                            local v551 = v549:FindFirstChild("Weapon")
                            if v551 then
                                v551 = v551:FindFirstChild("Insert")
                            end
                            if v551 then
                                v549.PrimaryPart = v551
                            else
                                local v552 = v549:FindFirstChild("Insert", true)
                                if v552 then
                                    v549.PrimaryPart = v552
                                end
                            end
                        end
                        if v549.PrimaryPart then
                            for _, v553 in ipairs(v549:GetDescendants()) do
                                if v553:IsA("BasePart") then
                                    v553.CanCollide = false
                                    v553.CanQuery = false
                                    v553.CanTouch = false
                                    v553.Anchored = false
                                    v553.Massless = true
                                end
                            end
                            v549.Parent = v531
                            local v554, v555 = pcall(v_u_21, p530.Name)
                            local v556
                            if v554 and v555 then
                                v556 = v555.ShootingOptions == "Dual"
                            else
                                v556 = false
                            end
                            local v557 = v549:FindFirstChild("Properties")
                            if not v557 then
                                local v558 = v549:FindFirstChild("Weapon")
                                if v558 then
                                    v557 = v558:FindFirstChild("Properties")
                                end
                            end
                            local v559 = v557 or v549:FindFirstChild("Properties", true)
                            if v556 then
                                local v560 = v531:FindFirstChild("RightHand")
                                local v561 = v531:FindFirstChild("LeftHand")
                                if v560 and v561 then
                                    local v562 = v549:FindFirstChild("HandleR", true)
                                    if v562 then
                                        local v563 = Instance.new("Motor6D")
                                        v563.Name = "WeaponAttachmentHandleR"
                                        v563.Part0 = v560
                                        v563.Part1 = v562
                                        v563.Parent = v560
                                        if v559 then
                                            local v564 = v559:FindFirstChild("C0RIGHT")
                                            if v564 then
                                                v563.C0 = v564.Value
                                            end
                                            local v565 = v559:FindFirstChild("C1RIGHT")
                                            if v565 then
                                                v563.C1 = v565.Value
                                            end
                                        end
                                    end
                                    local v566 = v549:FindFirstChild("HandleL", true)
                                    if v566 then
                                        local v567 = Instance.new("Motor6D")
                                        v567.Name = "WeaponAttachmentHandleL"
                                        v567.Part0 = v561
                                        v567.Part1 = v566
                                        v567.Parent = v561
                                        if v559 then
                                            local v568 = v559:FindFirstChild("C0LEFT")
                                            if v568 then
                                                v567.C0 = v568.Value
                                            end
                                            local v569 = v559:FindFirstChild("C1LEFT")
                                            if v569 then
                                                v567.C1 = v569.Value
                                            end
                                        end
                                    end
                                end
                            else
                                local v570 = Instance.new("Motor6D")
                                v570.Name = "WeaponAttachment"
                                v570.Part0 = v550
                                v570.Part1 = v549.PrimaryPart
                                v570.Parent = v550
                                if v559 then
                                    local v571 = v559:FindFirstChild("C0")
                                    if v571 then
                                        v570.C0 = v571.Value
                                    end
                                    local v572 = v559:FindFirstChild("C1")
                                    if v572 then
                                        v570.C1 = v572.Value
                                    end
                                end
                            end
                            v_u_72[p529] = v549
                            v_u_76[p529] = p530._id
                            local v573 = v531:FindFirstChildOfClass("Humanoid")
                            if v573 then
                                local v574 = v573:FindFirstChildOfClass("Animator")
                                if v574 then
                                    local v575 = nil
                                    if p530.Type == "Melee" then
                                        v575 = "Melee"
                                    elseif v555 then
                                        v575 = v_u_99(v555.Type, v555.AimingOptions, v555.MuzzleType, v555.Class)
                                    else
                                        local v576, v577 = pcall(v_u_21, p530.Name)
                                        if v576 and v577 then
                                            v575 = v_u_99(v577.Type, v577.AimingOptions, v577.MuzzleType, v577.Class)
                                        end
                                    end
                                    if v575 then
                                        local v578 = p530.Name
                                        local v579
                                        if v575 and v_u_25.ANIMATION_MAPPING[v575] then
                                            local v580 = v_u_25.ANIMATION_MAPPING[v575]
                                            if v578 and v580[v578] then
                                                v579 = v580[v578]
                                            else
                                                v579 = v580.Default
                                            end
                                        else
                                            v579 = nil
                                        end
                                        if v579 then
                                            local v581 = v574:LoadAnimation(v579)
                                            v581.Looped = true
                                            v581.Priority = Enum.AnimationPriority.Action
                                            v581:Play()
                                            v_u_73[p529] = v581
                                        end
                                    end
                                end
                            else
                                return
                            end
                        else
                            v549:Destroy()
                            return
                        end
                    else
                        v549:Destroy()
                        return
                    end
                else
                    return
                end
            else
                return
            end
        end
    else
        return
    end
end
local function v_u_591(p583)
    local v584 = p583 == "CT" and "Counter-Terrorists" or "Terrorists"
    local v585 = v_u_12.Get(v_u_10, "Loadout")
    local v586 = v_u_12.Get(v_u_10, "Inventory")
    if not (v585 and v586) then
        return
    end
    local v587 = v585[v584]
    if not (v587 and v587.Equipped) then
        return
    end
    local v588 = v587.Equipped["Equipped Melee"]
    if v588 and v588 ~= "" then
        for _, v590 in ipairs(v586) do
            if v590._id == v588 then
                goto l16
            end
        end
        local v590 = nil
        ::l16::
        if v590 then
            v_u_582(p583, v590)
            return
        end
    end
    v_u_582(p583, {
        ["_id"] = "default_knife",
        ["Type"] = "Melee",
        ["Serial"] = 0,
        ["Name"] = p583 == "CT" and "CT Knife" or "T Knife",
        ["Skin"] = "Stock",
        ["Float"] = 0,
        ["StatTrack"] = false,
        ["IsTradeable"] = false,
        ["NameTag"] = false,
        ["Charm"] = false
    })
end
function v_u_1.OnLoadoutItemHover(p592)
    v_u_582(v_u_27 == "Counter-Terrorists" and "CT" or "T", p592)
end
function v_u_1.OnLoadoutItemUnhover() end
local function v_u_609()
    local v_u_593 = v_u_12.Get(v_u_10, "Inventory")
    if v_u_593 then
        local v594 = v_u_90.Teams
        for _, v_u_595 in ipairs({ "CT", "T" }) do
            local v596 = v594:FindFirstChild(v_u_595)
            if v596 then
                local v597 = v596:FindFirstChild("Sidebar")
                if v597 then
                    for _, v_u_598 in ipairs({ "Melee", "Gloves" }) do
                        local v599 = v597:FindFirstChild(v_u_598)
                        if v599 then
                            local v600 = v599:FindFirstChild("Weapon")
                            if v600 then
                                local v601 = v_u_595 .. "_" .. v_u_598
                                local v602 = v_u_75[v601]
                                if v602 then
                                    if v602.MouseEnter then
                                        v602.MouseEnter:Disconnect()
                                    end
                                    if v602.MouseLeave then
                                        v602.MouseLeave:Disconnect()
                                    end
                                end
                                local v_u_603 = v600:GetAttribute("EquippedItemId")
                                local v_u_604 = v600:GetAttribute("TeamKey")
                                v_u_75[v601] = {
                                    ["MouseEnter"] = v600.MouseEnter:Connect(function()
                                        if not v_u_603 or v_u_603 == "" then
                                            if v_u_598 == "Melee" then
                                                v_u_591(v_u_604 or v_u_595)
                                            end
                                            goto l10
                                        end
                                        local v605 = v_u_593
                                        local v606 = v_u_603
                                        for _, v608 in ipairs(v605) do
                                            if v608._id == v606 then
                                                goto l7
                                            end
                                        end
                                        local v608 = nil
                                        ::l7::
                                        if v608 and v_u_598 == "Melee" then
                                            v_u_582(v_u_604 or v_u_595, v608)
                                            return
                                        end
                                        ::l10::
                                    end),
                                    ["MouseLeave"] = v600.MouseLeave:Connect(function() end)
                                }
                            end
                        end
                    end
                end
            end
        end
    end
end
function v_u_1.SelectTeam(p610)
    local v611 = v_u_90.Teams
    v611.GunsCT.Visible = p610 == "CT"
    v611.GunsT.Visible = p610 == "T"
    if v_u_53 == nil then
        v_u_53 = v_u_90.Teams.CT.BackgroundTransparency
    end
    if v_u_54 == nil then
        v_u_54 = v_u_90.Teams.T.BackgroundTransparency
    end
    v_u_90.Teams.CT.Visible = true
    v_u_90.Teams.T.Visible = true
    local v612 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v613 = v_u_90.Teams.CT:FindFirstChild("Sidebar")
    local v614 = v_u_90.Teams.T:FindFirstChild("Sidebar")
    local v615 = v_u_90.Teams.CT:FindFirstChild("Equip")
    local v616 = v_u_90.Teams.T:FindFirstChild("Equip")
    local v617
    if v615 then
        v617 = v615:FindFirstChild("Frame")
    else
        v617 = v615
    end
    local v618
    if v616 then
        v618 = v616:FindFirstChild("Frame")
    else
        v618 = v616
    end
    local v619
    if v617 then
        v619 = v617:FindFirstChild("UIStroke")
    else
        v619 = v617
    end
    local v620
    if v618 then
        v620 = v618:FindFirstChild("UIStroke")
    else
        v620 = v618
    end
    if v615 then
        v615 = v615:FindFirstChild("skin")
    end
    if v616 then
        v616 = v616:FindFirstChild("skin")
    end
    local v621 = v_u_90.Teams.CT:FindFirstChild("Player")
    local v622 = v_u_90.Teams.T:FindFirstChild("Player")
    local v623 = Color3.fromRGB(104, 140, 175)
    local v624 = Color3.fromRGB(136, 115, 56)
    local v625 = Color3.fromRGB(0, 0, 0)
    if p610 == "CT" then
        local v626 = {
            ["BackgroundTransparency"] = v_u_53
        }
        v_u_6:Create(v_u_90.Teams.CT, v612, v626):Play()
        v_u_90.Teams.CT.Border.Visible = true
        v_u_6:Create(v_u_90.Teams.T, v612, {
            ["BackgroundTransparency"] = 1
        }):Play()
        v_u_90.Teams.T.Frame.Visible = false
        if v613 then
            v_u_6:Create(v613, v612, {
                ["GroupTransparency"] = 0
            }):Play()
        end
        if v614 then
            v_u_6:Create(v614, v612, {
                ["GroupTransparency"] = 0.65
            }):Play()
        end
        if v621 then
            v_u_6:Create(v621, v612, {
                ["ImageTransparency"] = 0
            }):Play()
        end
        if v622 then
            v_u_6:Create(v622, v612, {
                ["ImageTransparency"] = 0.6
            }):Play()
        end
        if v617 then
            v_u_6:Create(v617, v612, {
                ["BackgroundTransparency"] = 0
            }):Play()
        end
        if v619 then
            v_u_6:Create(v619, v612, {
                ["Transparency"] = 0
            }):Play()
        end
        if v615 then
            v_u_6:Create(v615, v612, {
                ["TextColor3"] = v625
            }):Play()
        end
        if v618 then
            v_u_6:Create(v618, v612, {
                ["BackgroundTransparency"] = 1
            }):Play()
        end
        if v620 then
            v_u_6:Create(v620, v612, {
                ["Transparency"] = 0.6
            }):Play()
        end
        if v616 then
            v_u_6:Create(v616, v612, {
                ["TextColor3"] = v624
            }):Play()
        end
    else
        local v627 = {
            ["BackgroundTransparency"] = v_u_54
        }
        v_u_6:Create(v_u_90.Teams.T, v612, v627):Play()
        v_u_90.Teams.T.Frame.Visible = true
        v_u_6:Create(v_u_90.Teams.CT, v612, {
            ["BackgroundTransparency"] = 1
        }):Play()
        v_u_90.Teams.CT.Border.Visible = false
        if v613 then
            v_u_6:Create(v613, v612, {
                ["GroupTransparency"] = 0.65
            }):Play()
        end
        if v614 then
            v_u_6:Create(v614, v612, {
                ["GroupTransparency"] = 0
            }):Play()
        end
        if v621 then
            v_u_6:Create(v621, v612, {
                ["ImageTransparency"] = 0.6
            }):Play()
        end
        if v622 then
            v_u_6:Create(v622, v612, {
                ["ImageTransparency"] = 0
            }):Play()
        end
        if v618 then
            v_u_6:Create(v618, v612, {
                ["BackgroundTransparency"] = 0
            }):Play()
        end
        if v620 then
            v_u_6:Create(v620, v612, {
                ["Transparency"] = 0
            }):Play()
        end
        if v616 then
            v_u_6:Create(v616, v612, {
                ["TextColor3"] = v625
            }):Play()
        end
        if v617 then
            v_u_6:Create(v617, v612, {
                ["BackgroundTransparency"] = 1
            }):Play()
        end
        if v619 then
            v_u_6:Create(v619, v612, {
                ["Transparency"] = 0.6
            }):Play()
        end
        if v615 then
            v_u_6:Create(v615, v612, {
                ["TextColor3"] = v623
            }):Play()
        end
    end
    v_u_27 = p610 == "CT" and "Counter-Terrorists" or (p610 == "T" and "Terrorists" or false)
    v_u_28 = nil
    v_u_31 = nil
    v_u_30 = nil
    v_u_90.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = "All Categories"
    v_u_90.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
    local v628 = v_u_12.Get(v_u_10, "Loadout")
    v_u_1.UpdateLoadoutContainer(v628)
    v_u_1.UpdateSidebarFrames(v628)
    v_u_1.UpdateInventoryContainer()
    v_u_1.PopulateCategoryDropdown()
    v_u_1.PopulateWeaponDropdown()
end
function v_u_1.Initialize(p629, p630)
    v_u_90 = p630
    v_u_90:GetPropertyChangedSignal("Visible"):Connect(function()
        if v_u_90.Visible then
            if v_u_80 then
                v_u_80 = false
                v_u_1.SortBySkinMetadata(v_u_29)
            end
            if v_u_79 then
                v_u_195()
            end
        else
            if v_u_40 then
                v_u_40:Disconnect()
                v_u_40 = nil
            end
            v_u_38 = nil
            v_u_39 = nil
            v_u_41 = false
            if v_u_37 then
                v_u_37:Disconnect()
                v_u_37 = nil
            end
            if v_u_33 then
                v_u_33:Destroy()
                v_u_33 = nil
            end
            v_u_32 = false
            v_u_34 = nil
            v_u_35 = nil
            v_u_36 = nil
            v_u_286()
            v_u_42 = nil
            v_u_43 = false
            v_u_44 = nil
            v_u_45 = nil
            v_u_46 = nil
            v_u_49 = false
            if v_u_48 then
                v_u_48 = false
                pcall(function()
                    v_u_5:DisableGamepadCursor()
                end)
                v_u_8.AutoSelectGuiEnabled = true
            end
            v_u_286()
        end
    end)
    local v631 = v_u_90.Tabs.Container.Container
    v631:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        if v_u_90 then
            local v632 = v_u_90.Tabs.Container.Container
            local v633 = v632.CanvasPosition.Y
            local v634 = v632.AbsoluteCanvasSize.Y - v632.AbsoluteSize.Y
            if v634 > 0 and (v_u_78 < #v_u_77 and v634 - v633 < 200) then
                v_u_153()
            end
        else
            return
        end
    end)
    v631:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
        task.defer(v_u_157)
    end)
    local v_u_635 = p629:FindFirstChild("Menu")
    if v_u_635 then
        v_u_635:GetPropertyChangedSignal("Visible"):Connect(function()
            if not v_u_635.Visible then
                if v_u_40 then
                    v_u_40:Disconnect()
                    v_u_40 = nil
                end
                v_u_38 = nil
                v_u_39 = nil
                v_u_41 = false
                if v_u_37 then
                    v_u_37:Disconnect()
                    v_u_37 = nil
                end
                if v_u_33 then
                    v_u_33:Destroy()
                    v_u_33 = nil
                end
                v_u_32 = false
                v_u_34 = nil
                v_u_35 = nil
                v_u_36 = nil
                v_u_286()
                v_u_42 = nil
                v_u_43 = false
                v_u_44 = nil
                v_u_45 = nil
                v_u_46 = nil
                v_u_49 = false
                if v_u_48 then
                    v_u_48 = false
                    pcall(function()
                        v_u_5:DisableGamepadCursor()
                    end)
                    v_u_8.AutoSelectGuiEnabled = true
                end
                v_u_286()
                local v636 = v_u_90.ActionFrame
                if v636 then
                    v636.Visible = false
                end
                v_u_52 = nil
                if v_u_17.IsInspectActive() then
                    v_u_13.broadcastRouter("WeaponInspectClose")
                end
            end
        end)
    end
    local v_u_637 = v_u_90.ActionFrame
    if v_u_637 then
        v_u_637.Visible = false
        local v638 = v_u_637:FindFirstChild("Inspect")
        if v638 then
            v638.MouseButton1Click:Connect(v_u_102)
        end
        local v639 = v_u_637:FindFirstChild("Charm")
        if v639 then
            v639.MouseButton1Click:Connect(function()
                if v_u_52 then
                    local v640 = v_u_52
                    local v641
                    if v640.Charm == nil or v640.Charm == false then
                        v641 = false
                    else
                        local v642 = v640.Charm
                        if type(v642) == "string" or v640.Charm == true then
                            v641 = true
                        else
                            local v643 = v640.Charm
                            v641 = type(v643) == "table"
                        end
                    end
                    local v644 = v_u_90.ActionFrame
                    if v644 then
                        v644.Visible = false
                    end
                    v_u_52 = nil
                    if v641 then
                        v_u_16.Inventory.RemoveWeaponCharm.Send({
                            ["WeaponId"] = v640._id
                        })
                    end
                end
            end)
        end
        v_u_4.InputBegan:Connect(function(p645, p646)
            if not p646 then
                if p645.UserInputType == Enum.UserInputType.MouseButton1 or (p645.UserInputType == Enum.UserInputType.MouseButton2 or p645.UserInputType == Enum.UserInputType.Touch) then
                    task.defer(function()
                        if v_u_637.Visible and v_u_52 then
                            local v647 = v_u_4:GetMouseLocation()
                            local v648 = v_u_637.AbsolutePosition
                            local v649 = v_u_637.AbsoluteSize
                            local v650
                            if v647.X >= v648.X then
                                v650 = v647.X <= v648.X + v649.X
                            else
                                v650 = false
                            end
                            local v651
                            if v647.Y >= v648.Y then
                                v651 = v647.Y <= v648.Y + v649.Y
                            else
                                v651 = false
                            end
                            if not (v650 and v651) then
                                local v652 = v_u_90.ActionFrame
                                if v652 then
                                    v652.Visible = false
                                end
                                v_u_52 = nil
                            end
                        end
                    end)
                end
            end
        end)
    end
    task.spawn(function()
        local v653 = {}
        for _, v654 in pairs(v_u_18) do
            table.insert(v653, v654)
        end
        v_u_3:PreloadAsync(v653)
    end)
    v_u_516()
    v_u_528("CT")
    v_u_528("T")
    v_u_591("CT")
    v_u_591("T")
    local v655 = v_u_90.Teams
    for _, v656 in ipairs({ v655.GunsCT, v655.GunsT }) do
        for _, v_u_657 in ipairs({ "Mid Tier", "Pistols", "Rifles" }) do
            local v_u_658 = v656:FindFirstChild(v_u_657)
            if v_u_658 and v_u_658:IsA("Frame") then
                v_u_658.MouseEnter:Connect(function()
                    v_u_51 = v_u_657
                    v_u_209(v_u_658, true)
                end)
                v_u_658.MouseLeave:Connect(function()
                    v_u_51 = nil
                    v_u_209(v_u_658, false)
                end)
            end
        end
    end
    v_u_12.CreateListener(v_u_10, "Loadout", function(p659)
        v_u_50 = false
        v_u_1.UpdateLoadoutContainer(p659)
        v_u_1.UpdateSidebarFrames(p659, "Counter-Terrorists")
        v_u_1.UpdateSidebarFrames(p659, "Terrorists")
        v_u_528("CT")
        v_u_528("T")
        v_u_609()
        if v_u_90 and v_u_90.Visible then
            local v660 = v_u_90.Tabs.Container.Container
            for _, v661 in ipairs(v660:GetChildren()) do
                if v661:IsA("Frame") and (v661.Name ~= "UIGridLayout" and (v661.Name ~= "UIListLayout" and v661.Name ~= "UIPadding")) then
                    v_u_70(v661, v661.Name)
                end
            end
        end
    end)
    v_u_16.Inventory.LoadoutResponse.Listen(function()
        v_u_50 = false
    end)
    v_u_12.CreateListener(v_u_10, "Inventory", function()
        v_u_1.UpdateInventoryContainer()
        if v_u_90 and v_u_90.Visible then
            local v662 = v_u_90.Tabs.Container.Container
            for _, v663 in ipairs(v662:GetChildren()) do
                if v663:IsA("Frame") and (v663.Name ~= "UIGridLayout" and (v663.Name ~= "UIListLayout" and v663.Name ~= "UIPadding")) then
                    v_u_70(v663, v663.Name)
                end
            end
        end
    end)
    v_u_4.InputEnded:Connect(function(p664, _)
        if (p664.UserInputType == Enum.UserInputType.MouseButton1 or p664.UserInputType == Enum.UserInputType.Touch) and (v_u_32 or v_u_38) then
            v_u_1.EndDrag()
        end
    end)
    v_u_4.InputBegan:Connect(function(p665, _)
        if p665.UserInputType == Enum.UserInputType.Gamepad1 then
            if p665.KeyCode == Enum.KeyCode.ButtonA then
                if v_u_42 and v_u_48 then
                    v_u_49 = true
                    return
                end
            elseif p665.KeyCode == Enum.KeyCode.ButtonB then
                v_u_375()
            end
        end
    end)
    v_u_4.InputEnded:Connect(function(p666, _)
        if p666.UserInputType == Enum.UserInputType.Gamepad1 then
            if p666.KeyCode == Enum.KeyCode.ButtonA and (v_u_42 and (v_u_48 and v_u_49)) then
                v_u_374()
            end
        end
    end)
    v_u_4.LastInputTypeChanged:Connect(function(p667)
        local v668 = v_u_47
        v_u_47 = p667 == Enum.UserInputType.Gamepad1
        if v668 and not v_u_47 then
            v_u_42 = nil
            v_u_43 = false
            v_u_44 = nil
            v_u_45 = nil
            v_u_46 = nil
            v_u_49 = false
            if v_u_48 then
                v_u_48 = false
                pcall(function()
                    v_u_5:DisableGamepadCursor()
                end)
                v_u_8.AutoSelectGuiEnabled = true
            end
            v_u_286()
        end
        if not v668 and v_u_47 then
            if v_u_40 then
                v_u_40:Disconnect()
                v_u_40 = nil
            end
            v_u_38 = nil
            v_u_39 = nil
            v_u_41 = false
            if v_u_37 then
                v_u_37:Disconnect()
                v_u_37 = nil
            end
            if v_u_33 then
                v_u_33:Destroy()
                v_u_33 = nil
            end
            v_u_32 = false
            v_u_34 = nil
            v_u_35 = nil
            v_u_36 = nil
            v_u_286()
        end
    end)
    v_u_47 = v_u_4:GetLastInputType() == Enum.UserInputType.Gamepad1
    local v669 = v_u_90.Tabs.Container.SkinSort.Sort
    local v_u_670 = v669.Options
    v669.MouseButton1Click:Connect(function()
        local v671 = v_u_670.Visible
        local v672 = v_u_90.Tabs.Container.SkinSort.Sort.Options
        local v673 = v_u_90.Tabs.Container.WeaponSort.Category
        local v674 = v_u_90.Tabs.Container.WeaponSort.Weapon
        v672.Visible = false
        if v673.ScrollingFrame then
            v673.ScrollingFrame.Visible = false
        end
        local v675 = v674:FindFirstChild("Options")
        if v675 then
            v675.Visible = false
        end
        v_u_670.Visible = not v671
    end)
    for _, v_u_676 in ipairs(v_u_670:GetChildren()) do
        if v_u_676:IsA("TextButton") then
            v_u_676.MouseEnter:Connect(function()
                v_u_203(v_u_676, true)
            end)
            v_u_676.MouseLeave:Connect(function()
                v_u_203(v_u_676, false)
            end)
            v_u_676.MouseButton1Click:Connect(function()
                v_u_1.SortBySkinMetadata(v_u_676.Name)
                v_u_215(v_u_670, v_u_676.Name)
                v_u_670.Visible = false
            end)
        end
    end
    local v_u_677 = v_u_90.Tabs.Container.WeaponSort.Category
    local v_u_678 = v_u_677.ScrollingFrame
    if v_u_678 then
        v_u_228(v_u_678)
        v_u_677.MouseButton1Click:Connect(function()
            local v679 = v_u_678.Visible
            local v680 = v_u_90.Tabs.Container.SkinSort.Sort.Options
            local v681 = v_u_90.Tabs.Container.WeaponSort.Category
            local v682 = v_u_90.Tabs.Container.WeaponSort.Weapon
            v680.Visible = false
            if v681.ScrollingFrame then
                v681.ScrollingFrame.Visible = false
            end
            local v683 = v682:FindFirstChild("Options")
            if v683 then
                v683.Visible = false
            end
            v_u_678.Visible = not v679
        end)
    end
    local v_u_684 = v_u_90.Tabs.Container.WeaponSort.Weapon
    local v_u_685 = v_u_684:FindFirstChild("Options")
    if v_u_685 and (v_u_685:IsA("Frame") or v_u_685:IsA("ScrollingFrame")) then
        v_u_228(v_u_685)
        v_u_684.MouseButton1Click:Connect(function()
            local v686 = v_u_685.Visible
            local v687 = v_u_90.Tabs.Container.SkinSort.Sort.Options
            local v688 = v_u_90.Tabs.Container.WeaponSort.Category
            local v689 = v_u_90.Tabs.Container.WeaponSort.Weapon
            v687.Visible = false
            if v688.ScrollingFrame then
                v688.ScrollingFrame.Visible = false
            end
            local v690 = v689:FindFirstChild("Options")
            if v690 then
                v690.Visible = false
            end
            v_u_685.Visible = not v686
        end)
    end
    local v_u_691 = v_u_90.Tabs.Container.WeaponSort:FindFirstChild("Reset")
    if v_u_691 then
        v_u_691.Visible = false
        v_u_691.MouseButton1Click:Connect(function()
            v_u_28 = nil
            v_u_31 = nil
            v_u_677.Frame.TextLabel.Text = "All Categories"
            v_u_684.Frame.TextLabel.Text = "All Weapons"
            v_u_691.Visible = false
            v_u_1.PopulateWeaponDropdown()
            local v692 = v_u_90.Tabs.Container.Container
            for _, v693 in ipairs(v692:GetChildren()) do
                if v693:IsA("Frame") then
                    v693.Visible = true
                end
            end
            v_u_1.SortBySkinMetadata(v_u_29)
        end)
    end
end
function v_u_1.ViewInLoadout(p694)
    local v695 = v_u_12.Get(v_u_10, "Inventory")
    for _, v697 in ipairs(v695) do
        if v697._id == p694 then
            goto l4
        end
    end
    local v697 = nil
    ::l4::
    if v697 then
        local v698 = v697.Name
        local v699 = v697.Skin
        local v700, v701 = pcall(v_u_21, v698)
        if v700 and (v701 and v701.Type) then
            v_u_28 = v701.Type
            v_u_90.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = v701.Type
            v_u_1.PopulateWeaponDropdown()
        end
        v_u_90.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = v698
        v_u_1.SortByWeapon(v698, v699)
        local v702 = v_u_90.Tabs.Container.WeaponSort:FindFirstChild("Reset")
        if v702 then
            local v703 = v_u_90.Tabs.Container.WeaponSort.Weapon
            v702.Visible = v_u_28 ~= nil and true or v703.Frame.TextLabel.Text ~= "All Weapons"
        end
        if not v_u_90.Visible then
            v_u_17.SetScreen("Loadout")
            v_u_90.Visible = true
        end
    else
        return
    end
end
function v_u_1.Start()
    v_u_12.WaitForDataLoaded(v_u_10)
    v_u_1.SelectTeam("CT")
    local v704 = v_u_12.Get(v_u_10, "Loadout")
    if v704 then
        v_u_1.UpdateSidebarFrames(v704, "Counter-Terrorists")
        v_u_1.UpdateSidebarFrames(v704, "Terrorists")
        v_u_609()
    end
    v_u_1.PopulateCategoryDropdown()
    v_u_1.PopulateWeaponDropdown()
    v_u_1.SortBySkinMetadata("Newest")
    v_u_215(v_u_90.Tabs.Container.SkinSort.Sort.Options, "Newest")
    local function v_u_709()
        v_u_28 = nil
        v_u_31 = nil
        v_u_30 = nil
        v_u_90.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = "All Categories"
        v_u_90.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
        local v705 = v_u_90.Tabs.Container.Container
        for _, v706 in ipairs(v705:GetChildren()) do
            if v706:IsA("Frame") then
                v706.Visible = true
            end
        end
        v_u_1.SortBySkinMetadata(v_u_29)
        local v707 = v_u_90.Tabs.Container.WeaponSort:FindFirstChild("Reset")
        if v707 then
            local v708 = v_u_90.Tabs.Container.WeaponSort.Weapon
            v707.Visible = v_u_28 ~= nil and true or v708.Frame.TextLabel.Text ~= "All Weapons"
        end
    end
    local v_u_710 = {}
    local function v_u_723()
        local v711 = v_u_90.Teams
        for _, v_u_712 in ipairs({ "CT", "T" }) do
            local v713 = v711:FindFirstChild(v_u_712)
            if v713 then
                local v714 = v713:FindFirstChild("Sidebar")
                if v714 then
                    for _, v_u_715 in ipairs({ "Melee", "Gloves" }) do
                        local v716 = v714:FindFirstChild(v_u_715)
                        if v716 then
                            local v717 = v716:FindFirstChild("Button")
                            if v717 then
                                local function v721()
                                    local v718 = v_u_30
                                    if v718 then
                                        if v_u_30.teamKey == v_u_712 then
                                            v718 = v_u_30.sidebarName == v_u_715
                                        else
                                            v718 = false
                                        end
                                    end
                                    if v718 then
                                        v_u_30 = nil
                                        v_u_709()
                                    else
                                        v_u_28 = nil
                                        v_u_31 = nil
                                        v_u_90.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = "All Categories"
                                        v_u_90.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
                                        v_u_30 = {
                                            ["teamKey"] = v_u_712,
                                            ["sidebarName"] = v_u_715
                                        }
                                        v_u_1.SortBySkinMetadata(v_u_29)
                                        local v719 = v_u_90.Tabs.Container.WeaponSort:FindFirstChild("Reset")
                                        if v719 then
                                            local v720 = v_u_90.Tabs.Container.WeaponSort.Weapon
                                            v719.Visible = v_u_28 ~= nil and true or v720.Frame.TextLabel.Text ~= "All Weapons"
                                        end
                                    end
                                end
                                local v722 = ("%*_%*"):format(v_u_712, v_u_715)
                                if v_u_710[v722] then
                                    v_u_710[v722]:Disconnect()
                                end
                                v_u_710[v722] = v717.MouseButton1Click:Connect(v721)
                            end
                        end
                    end
                end
            end
        end
    end
    v_u_723()
    v_u_90.Teams.ButtonCT.MouseButton1Click:Connect(function()
        if v_u_27 ~= "Counter-Terrorists" then
            v_u_1.SelectTeam("CT")
            v_u_90.Teams.ButtonCT.Interactable = false
            v_u_90.Teams.ButtonT.Interactable = true
            v_u_30 = nil
            v_u_28 = nil
            v_u_31 = nil
            v_u_90.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = "All Categories"
            v_u_90.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
            local v724 = v_u_90.Tabs.Container.Container
            for _, v725 in ipairs(v724:GetChildren()) do
                if v725:IsA("Frame") then
                    v725.Visible = true
                end
            end
            v_u_1.SortBySkinMetadata(v_u_29)
            local v726 = v_u_90.Tabs.Container.WeaponSort:FindFirstChild("Reset")
            if v726 then
                local v727 = v_u_90.Tabs.Container.WeaponSort.Weapon
                v726.Visible = v_u_28 ~= nil and true or v727.Frame.TextLabel.Text ~= "All Weapons"
            end
            task.defer(v_u_723)
        end
    end)
    v_u_90.Teams.ButtonT.MouseButton1Click:Connect(function()
        if v_u_27 ~= "Terrorists" then
            v_u_1.SelectTeam("T")
            v_u_90.Teams.ButtonT.Interactable = false
            v_u_90.Teams.ButtonCT.Interactable = true
            v_u_30 = nil
            v_u_709()
            task.defer(v_u_723)
        end
    end)
    v_u_90.Teams.ButtonCT.Interactable = false
    v_u_90.Teams.ButtonT.Interactable = true
end
return v_u_1