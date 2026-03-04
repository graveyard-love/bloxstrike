local v_u_1 = {}
local v_u_2 = game:GetService("MarketplaceService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = game:GetService("TextService")
local v_u_7 = game:GetService("RunService")
local v_u_8 = game:GetService("GuiService")
local v_u_9 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_10 = v_u_9.LocalPlayer
local v_u_11 = v_u_10:GetMouse()
local v_u_12 = require(v_u_3.Controllers.DataController)
local v_u_13 = require(v_u_3.Database.Components.Libraries.Collections)
local v14 = require(v_u_3.Components.Common.GetUserPlatform)
local v_u_15 = require(v_u_3.Database.Components.Libraries.Skins)
local v_u_16 = require(v_u_3.Database.Components.Libraries.Cases)
local v_u_17 = require(v_u_3.Components.Common.GetWeaponProperties)
local v_u_18 = require(v_u_3.Components.Common.GetSkinDisplayName)
local v_u_19 = require(v_u_3.Database.Security.Remotes)
local v_u_20 = require(v_u_3.Database.Security.Router)
local v_u_21 = require(v_u_3.Database.Custom.GameStats.UI.Inventory.Buttons)
local v_u_22 = require(v_u_3.Database.Custom.GameStats.Monetization.Gamepasses)
local v_u_23 = require(v_u_3.Database.Custom.GameStats.UI.Inventory.Sort)
local v_u_24 = require(v_u_3.Database.Custom.GameStats.Rarities)
local v_u_25 = require(v_u_3.Database.Custom.GameStats.Grenades)
local v_u_26 = require(script.Parent.UseItemFrame)
local v_u_27 = require(script.Parent.Loadout)
local v_u_28 = require(script.Parent.Store)
local v_u_29 = require(v_u_3.Interface.Screens.Menu.Top)
local v_u_30 = require(v_u_3.Shared.CloseButtonRegistry)
local v_u_31 = require(v_u_3.Interface.MenuState)
local v_u_32 = Color3.fromRGB(53, 83, 99)
local v_u_33 = Color3.fromRGB(243, 243, 243)
local v_u_34 = Color3.fromRGB(125, 206, 243)
local v_u_35 = {}
local v_u_36 = table.find(v14(), "PC") ~= nil
local v_u_37 = nil
local v_u_38 = nil
local v_u_39 = nil
local v_u_40 = nil
local v_u_41 = 0
local v_u_42 = false
local v_u_43 = nil
local v_u_44 = nil
local v_u_45 = false
local v_u_46 = false
local v_u_47 = false
local v_u_48 = nil
local v_u_49 = 0
local v_u_50 = nil
local v_u_51 = nil
local v_u_52 = nil
local v_u_53 = nil
local v_u_54 = {}
local v_u_55 = {
    ["Charm Capsule"] = "Charm Pack",
    ["Package"] = "Package"
}
local function v_u_57()
    if not v_u_51 then
        return false
    end
    if v_u_51.Charm and v_u_51.Charm.Visible then
        return true
    end
    if v_u_51.Inspect and v_u_51.Inspect.Visible then
        return true
    end
    if v_u_51.ReplaceCT and v_u_51.ReplaceCT.Visible then
        return true
    end
    if v_u_51.ReplaceT and v_u_51.ReplaceT.Visible then
        return true
    end
    if v_u_51.Unlock and v_u_51.Unlock.Visible then
        return true
    end
    local v56 = v_u_51:FindFirstChild("QuickUnlock")
    return v56 and v56.Visible and true or false
end
local function v_u_62(p58, p59)
    local v60 = p58:GetChildren()
    for _, v61 in ipairs(v60) do
        if v61.ClassName == p59 then
            v61:Destroy()
        end
    end
end
local function v_u_70(p63, p64)
    local v65 = v_u_12.Get(v_u_10, "Loadout")
    if not v65 then
        return false
    end
    local v66 = v65[p64]
    if not v66 then
        return false
    end
    if v66.Loadout then
        for _, v67 in pairs(v66.Loadout) do
            if v67 and v67.Options then
                for _, v68 in ipairs(v67.Options) do
                    if v68 == p63 then
                        return true
                    end
                end
            end
        end
    end
    if v66.Equipped then
        for _, v69 in pairs(v66.Equipped) do
            if v69 == p63 then
                return true
            end
        end
    end
    return false
end
local function v_u_78(p71, p72)
    local v73 = p71:FindFirstChild("Status")
    if v73 then
        local v74 = v73:FindFirstChild("Counter-Terrorists")
        local v75 = v73:FindFirstChild("Terrorists")
        if v74 and v75 then
            local v76 = v_u_70(p72, "Counter-Terrorists")
            local v77 = v_u_70(p72, "Terrorists")
            v74.Visible = v76
            v75.Visible = v77
        end
    end
end
local function v_u_79()
    -- failed to decompile
end
local function v_u_98(p80, p81)
    if p80.Type == "Weapon" then
        local v_u_82 = p80.Name
        local v83 = {
            ["Pistol"] = "Pistols",
            ["SMG"] = "Mid Tier",
            ["Heavy"] = "Mid Tier",
            ["Rifle"] = "Rifles"
        }
        local v84, v85 = pcall(v_u_17, v_u_82)
        local v86
        if v84 and (v85 and v85.Type) then
            v86 = v83[v85.Type]
        else
            v86 = nil
        end
        if v86 then
            local v87, v88 = v_u_79(v_u_82, p81, v86)
            if v87 and v88 then
                v_u_19.Inventory.EquipLoadoutSkin.Send({
                    ["Type"] = v86,
                    ["Slot"] = v88 - 1,
                    ["Team"] = p81,
                    ["Identifier"] = p80._id
                })
            else
                v_u_29.openFrame("Loadout")
                local v89 = v_u_10:WaitForChild("PlayerGui"):FindFirstChild("MainGui")
                if v89 then
                    local v90 = v89:FindFirstChild("Menu")
                    if v90 then
                        local v91 = v90:FindFirstChild("Top")
                        if v91 and v91.Buttons then
                            local v92 = v91.Buttons:FindFirstChild("Loadout")
                            if v92 and v92:IsA("TextButton") then
                                local v93 = game:GetService("TweenService")
                                local v94 = Color3.fromRGB(150, 220, 239)
                                local v95 = Color3.fromRGB(255, 255, 255)
                                for _, v96 in ipairs(v91.Buttons:GetChildren()) do
                                    if v96:IsA("TextButton") and v96 ~= v92 then
                                        v93:Create(v96.TextLabel, TweenInfo.new(0.15), {
                                            ["TextColor3"] = v95
                                        }):Play()
                                    end
                                end
                                v93:Create(v92.TextLabel, TweenInfo.new(0.15), {
                                    ["TextColor3"] = v94
                                }):Play()
                            end
                        end
                    end
                end
                local v97 = p81 == "Counter-Terrorists" and "CT" or "T"
                v_u_27.SelectTeam(v97)
                v_u_27.SortByCategory(nil)
                v_u_27.SortByWeapon(v_u_82)
                task.defer(function()
                    v_u_27.SortByWeapon(v_u_82)
                end)
            end
        else
            return
        end
    elseif p80.Type == "Melee" then
        if p80.Name == "CT Knife" then
            if p81 == "Terrorists" then
                return
            end
        elseif p80.Name == "T Knife" and p81 == "Counter-Terrorists" then
            return
        end
        v_u_19.Inventory.EquipSpecialItem.Send({
            ["Identifier"] = p80._id,
            ["Path"] = "Equipped Melee",
            ["Team"] = p81
        })
        return
    elseif p80.Type == "Glove" then
        v_u_19.Inventory.EquipSpecialItem.Send({
            ["Identifier"] = p80._id,
            ["Path"] = "Equipped Gloves",
            ["Team"] = p81
        })
    elseif p80.Type == "Badge" then
        v_u_19.Inventory.EquipSpecialItem.Send({
            ["Identifier"] = p80._id,
            ["Path"] = "Equipped Badge",
            ["Team"] = p81
        })
    end
end
local function v_u_105()
    local v99 = Vector2.new(v_u_11.X, v_u_11.Y)
    if v_u_52.ItemNotification.Visible then
        return true
    end
    local v100 = v_u_52.Tabs.Inventory.Sort.Button.Options
    if v100.Visible then
        local v101 = v100.AbsolutePosition
        local v102 = v100.AbsoluteSize
        if v99.X >= v101.X and (v99.X <= v101.X + v102.X and (v99.Y >= v101.Y and v99.Y <= v101.Y + v102.Y)) then
            return true
        end
    end
    if v_u_51.Visible then
        local v103 = v_u_51.AbsolutePosition
        local v104 = v_u_51.AbsoluteSize
        if v99.X >= v103.X and (v99.X <= v103.X + v104.X and (v99.Y >= v103.Y and v99.Y <= v103.Y + v104.Y)) then
            return true
        end
    end
    return false
end
local function v_u_121(p106)
    local v107 = v_u_52.AbsolutePosition
    local v108 = v_u_52.Hover.AbsoluteSize
    local v109 = p106.AbsolutePosition
    local v110 = v_u_52.AbsoluteSize
    local v111 = p106.AbsoluteSize
    local v112 = v109.X - v107.X
    local v113 = v109.Y - v107.Y
    local v114 = v110.X - (v112 + v111.X) >= v108.X + 8 and (v112 + v111.X + 8 + v108.X / 2) / v110.X or (v112 - 8 - v108.X / 2) / v110.X
    local v115 = (v113 + v111.Y / 2) / v110.Y
    local v116 = v108.Y / 2 / v110.Y
    local v117 = math.max(v115, v116)
    local v118 = 1 - v108.Y / 2 / v110.Y
    local v119 = math.min(v117, v118)
    if v_u_8:GetGuiInset().Y >= v107.Y + v119 * v110.Y - v108.Y / 2 then
        local v120 = v119 + 30 / v110.Y
        v119 = math.min(v120, v118)
    end
    return UDim2.fromScale(v114, v119)
end
local function v_u_127(p122, p123, p124)
    if not p123 then
        return ""
    end
    if p124 then
        return p123.imageAssetId or ""
    end
    if p122.Type ~= "Charm" then
        return v_u_15.GetWearImageForFloat(p123, p122.Float or 0.9999) or p123.imageAssetId or ""
    end
    local v125 = p122.Pattern
    if v125 and p123.charmImages then
        for _, v126 in ipairs(p123.charmImages) do
            if v126.pattern == v125 then
                return v126.assetId
            end
        end
    end
    return p123.imageAssetId or ""
end
local function v_u_133(p128)
    if p128.Type ~= "Case" then
        local v129 = v_u_15.GetSkinInformation(p128.Name, p128.Skin)
        return v129 and v129.collection or nil
    end
    local v130 = v_u_16.GetCaseByName(p128.Skin)
    if not (v130 and v_u_43) then
        return nil
    end
    for _, v131 in ipairs(v_u_43) do
        if v131.cases then
            for _, v132 in ipairs(v131.cases) do
                if v132 == v130.name then
                    return v131.name
                end
            end
        end
    end
    return nil
end
local function v_u_142()
    local v134 = v_u_12.Get(v_u_10, "Inventory")
    if not v134 then
        return {}
    end
    local v135 = v_u_44 or (v_u_52.Tabs.Inventory.Sort.Button.Frame.TextLabel.Text or "Newest")
    local v136 = v_u_23.GetSortComparisonFunction(v135, v_u_10, function()
        return v_u_43
    end)
    local v137 = {}
    for _, v138 in ipairs(v134) do
        local v139
        if v138 then
            v139 = v_u_25[v138.Name]
        else
            v139 = v138
        end
        local v140
        if v138 then
            v140 = v138.Type == "Case" and true or v138.Type == "Package"
        else
            v140 = v138
        end
        local v141 = v138 and (v138._id and v138.Name)
        if v141 then
            v141 = v140 or v138.Skin
        end
        if v141 and not v139 then
            table.insert(v137, v138)
        end
    end
    if v136 then
        table.sort(v137, v136)
    end
    return v137
end
local function v_u_152(p143, p144)
    if not p144 or #p144 == 0 then
        return true
    end
    local v145 = v_u_21.GetEffectiveItemType(p143)
    local v146 = v_u_21.IsCapsule(p143)
    for _, v147 in ipairs(p144) do
        if v145 == v147 then
            return true
        end
        if p143.Type and (p143.Type == v147 and not v146) then
            return true
        end
        local v148
        if p143.Name then
            v148 = v_u_17(p143.Name)
        else
            v148 = nil
        end
        if string.find(v147, ":") then
            local v149 = string.split(v147, ":")
            local v150 = v149[1]
            local v151 = v149[2]
            if v150 == "Weapon" and (v148 and (v148.Class == "Weapon" and v148.Type == v151)) then
                return true
            end
        elseif v148 and v148.Class == v147 then
            return true
        end
    end
    return false
end
local function v_u_169(p153)
    local v154 = nil
    local v155 = nil
    for _, v156 in ipairs(v_u_52.Top.Filter:GetChildren()) do
        if v156:IsA("TextButton") and v156:GetAttribute("Selected") then
            v155 = v156.Name
            break
        end
    end
    for _, v157 in ipairs(v_u_52.Top.Categories:GetChildren()) do
        if v157:IsA("TextButton") and v157:GetAttribute("Selected") then
            v154 = v157.Name
            break
        end
    end
    local v158 = nil
    if v155 and v154 then
        local v159 = v_u_21[v154]
        if v159 and v159[v155] then
            v158 = v159[v155].Search
        end
    end
    local v160 = {}
    local v161 = v_u_12.Get(v_u_10, "Inventory")
    if v161 then
        for _, v162 in ipairs(v161) do
            if v162.Charm then
                local v163 = v162.Charm
                local v164 = type(v163) == "table" and v162.Charm._id
                if not v164 then
                    local v165 = v162.Charm
                    if type(v165) == "string" then
                        v164 = v162.Charm
                    else
                        v164 = false
                    end
                end
                if v164 then
                    v160[v164] = true
                end
            end
        end
    end
    local v166 = {}
    for _, v167 in ipairs(p153) do
        local v168 = v_u_152(v167, v158)
        if v168 and (v167.Type == "Charm" and v160[v167._id]) then
            v168 = false
        end
        if v168 then
            table.insert(v166, v167)
        end
    end
    return v166
end
local function v_u_180()
    if v_u_52 then
        local v170 = v_u_52.Tabs.Inventory.Container
        local v171 = v_u_49 + 1
        local v172 = v_u_49 + 25
        local v173 = #v_u_35
        local v174 = math.min(v172, v173)
        for v175 = v171, v174 do
            local v176 = v_u_35[v175]
            if v176 and not v170:FindFirstChild(v176._id) then
                v_u_1.CreateItemTemplate(v176)
            end
        end
        v_u_49 = v174
        for _, v177 in ipairs(v170:GetChildren()) do
            if v177:IsA("Frame") and (v177.Name ~= "UIGridLayout" and (v177.Name ~= "UIListLayout" and v177.Name ~= "UIPadding")) then
                for v178, v179 in ipairs(v_u_35) do
                    if v179._id == v177.Name then
                        v177.LayoutOrder = v178
                        break
                    end
                end
            end
        end
    end
end
local function v_u_183()
    if v_u_52 then
        local v181 = v_u_52.Tabs.Inventory.Container.CanvasPosition.Y
        local v182 = v_u_52.Tabs.Inventory.Container.AbsoluteCanvasSize.Y - v_u_52.Tabs.Inventory.Container.AbsoluteSize.Y
        if v182 > 0 and (v_u_49 < #v_u_35 and v182 - v181 < 200) then
            v_u_180()
            return
        end
    end
end
local function v_u_210()
    if not (v_u_52 and v_u_52.Visible) then
        return 50
    end
    local v184 = v_u_52.Tabs.Inventory.Container
    local v185 = v184:FindFirstChildOfClass("UIGridLayout")
    if not v185 then
        return 50
    end
    local v186 = v184.AbsoluteSize
    local v187 = v186.Y
    local v188 = v186.X
    local v189 = v185.CellSize
    local v190 = v185.CellPadding
    local v191 = v189.Y.Scale * v187 + v189.Y.Offset
    local v192 = v190.Y.Scale * v187 + v190.Y.Offset
    local v193 = v189.X.Scale * v188 + v189.X.Offset
    local v194 = v190.X.Scale * v188 + v190.X.Offset
    local v195 = v184:FindFirstChildOfClass("UIPadding")
    local v196, v197, v198, v199
    if v195 then
        v196 = v195.PaddingTop.Scale * v187 + v195.PaddingTop.Offset
        v197 = v195.PaddingBottom.Scale * v187 + v195.PaddingBottom.Offset
        v198 = v195.PaddingLeft.Scale * v188 + v195.PaddingLeft.Offset
        v199 = v195.PaddingRight.Scale * v188 + v195.PaddingRight.Offset
    else
        v196 = 0
        v197 = 0
        v198 = 0
        v199 = 0
    end
    local v200 = v187 - v196 - v197
    local v201 = v188 - v198 - v199
    local v202 = v193 + v194
    local v203
    if v202 > 0 then
        local v204 = (v201 + v194) / v202
        local v205 = math.floor(v204)
        v203 = math.max(1, v205)
    else
        v203 = 1
    end
    local v206 = v191 + v192
    local v207
    if v206 > 0 then
        local v208 = (v200 + v192) / v206
        local v209 = math.floor(v208)
        v207 = math.max(1, v209)
    else
        v207 = 1
    end
    return v207 * v203 + v203
end
local function v_u_221()
    if not (v_u_52 and v_u_52.Visible) then
        return
    end
    local v211 = v_u_52.Tabs.Inventory.Container
    v_u_49 = 0
    local v212 = v_u_210()
    local v213 = math.max(v212, 50)
    local v214 = #v_u_35
    local v215 = math.min(v213, v214)
    for v216 = 1, v215 do
        local v217 = v_u_35[v216]
        if v217 and not v211:FindFirstChild(v217._id) then
            v_u_1.CreateItemTemplate(v217)
        end
    end
    for _, v218 in ipairs(v211:GetChildren()) do
        if v218:IsA("Frame") and (v218.Name ~= "UIGridLayout" and (v218.Name ~= "UIListLayout" and v218.Name ~= "UIPadding")) then
            for v219, v220 in ipairs(v_u_35) do
                if v220._id == v218.Name then
                    v218.LayoutOrder = v219
                    break
                end
            end
        end
    end
    v_u_49 = v215
    v_u_45 = false
end
local function v_u_225()
    if v_u_52 then
        local v222 = v_u_52.Tabs.Inventory.Container
        for _, v223 in ipairs(v222:GetChildren()) do
            local v224 = v223:IsA("Frame")
            if v224 then
                if v223.Name == "UIGridLayout" or (v223.Name == "UIListLayout" or (v223.Name == "UIPadding" or v223.Name == "Title")) then
                    v224 = false
                else
                    v224 = v223.Name ~= "Label"
                end
            end
            if v224 then
                v223:Destroy()
            end
        end
        v_u_49 = 0
        v_u_45 = true
        if v_u_52.Visible then
            v_u_221()
        end
    end
end
local function v_u_233(p_u_226, p_u_227, p_u_228, p_u_229, _)
    p_u_227.MouseEnter:Connect(function()
        v_u_5:Create(p_u_227, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["BackgroundTransparency"] = 0.85
        }):Play()
    end)
    p_u_227.MouseLeave:Connect(function()
        v_u_5:Create(p_u_227, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["BackgroundTransparency"] = 1
        }):Play()
    end)
    p_u_227.Selectable = true
    local function v_u_231()
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        if v_u_51 then
            v_u_51.Visible = false
        end
        v_u_44 = p_u_228
        if v_u_52 then
            if v_u_52.Visible then
                v_u_35 = v_u_142()
                v_u_35 = v_u_169(v_u_35)
                v_u_225()
            else
                v_u_46 = true
                v_u_45 = true
            end
        end
        p_u_229.Text = p_u_228
        for _, v230 in ipairs(p_u_226:GetChildren()) do
            if v230:IsA("TextButton") then
                v230.Frame.BackgroundTransparency = v230 == p_u_227 and 0 or 1
            end
        end
        p_u_226.Visible = false
    end
    p_u_227.MouseButton1Click:Connect(v_u_231)
    p_u_227.Activated:Connect(function(p232)
        if p232 and p232.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_231()
        end
    end)
end
local function v_u_258(p_u_234)
    local v_u_235 = p_u_234:FindFirstChild("HoverFrame")
    local v_u_236 = p_u_234.Size
    p_u_234.MouseEnter:Connect(function()
        local v237 = v_u_5
        local v238 = p_u_234
        local v239 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v240 = {}
        local v241 = v_u_236
        v240.Size = UDim2.new(v241.X.Scale * 0.95, v241.X.Offset, v241.Y.Scale * 0.95, v241.Y.Offset)
        v237:Create(v238, v239, v240):Play()
        if v_u_235 and not p_u_234:GetAttribute("Selected") then
            v_u_235.BackgroundTransparency = 1
            v_u_235.Visible = true
            v_u_5:Create(v_u_235, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["BackgroundTransparency"] = 0.85
            }):Play()
        end
    end)
    p_u_234.MouseLeave:Connect(function()
        local v242 = v_u_5
        local v243 = p_u_234
        local v244 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v245 = {}
        local v246 = v_u_236
        v245.Size = UDim2.new(v246.X.Scale * 1, v246.X.Offset, v246.Y.Scale * 1, v246.Y.Offset)
        v242:Create(v243, v244, v245):Play()
        if v_u_235 and not p_u_234:GetAttribute("Selected") then
            local v247 = v_u_5:Create(v_u_235, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["BackgroundTransparency"] = 1
            })
            v247:Play()
            v247.Completed:Once(function()
                v_u_235.Visible = false
            end)
        end
    end)
    p_u_234.MouseButton1Down:Connect(function()
        local v248 = v_u_5
        local v249 = p_u_234
        local v250 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v251 = {}
        local v252 = v_u_236
        v251.Size = UDim2.new(v252.X.Scale * 0.9, v252.X.Offset, v252.Y.Scale * 0.9, v252.Y.Offset)
        v248:Create(v249, v250, v251):Play()
    end)
    p_u_234.MouseButton1Up:Connect(function()
        local v253 = v_u_5
        local v254 = p_u_234
        local v255 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v256 = {}
        local v257 = v_u_236
        v256.Size = UDim2.new(v257.X.Scale * 0.95, v257.X.Offset, v257.Y.Scale * 0.95, v257.Y.Offset)
        v253:Create(v254, v255, v256):Play()
    end)
end
function v_u_1.CreateItemTemplate(p_u_259)
    if p_u_259 and p_u_259._id then
        local v260 = p_u_259.Type == "Case" and true or p_u_259.Type == "Package"
        local v261 = v260 and v_u_16.GetCaseByName(p_u_259.Skin) or v_u_15.GetSkinInformation(p_u_259.Name, p_u_259.Skin)
        if v261 then
            local v262 = v_u_24[v260 and v261.caseRarity or v261.rarity]
            local v263 = v_u_127(p_u_259, v261, v260)
            local v_u_264 = v_u_3.Assets.UI.Inventory.ItemTemplate:Clone()
            v_u_264.Main.RarityFrame.UIGradient.Color = v262.ColorSequence
            v_u_264.Main.Glow.UIGradient.Color = v262.ColorSequence
            v_u_264.Parent = v_u_52.Tabs.Inventory.Container
            v_u_264.Main.Icon.Image = v263
            v_u_264.Name = p_u_259._id
            local v265 = v_u_17(p_u_259.Name)
            if v265 and v265.InventoryIconData then
                v_u_264.Main.Icon.ScaleType = v265.InventoryIconData.ScaleType or v_u_264.Main.Icon.ScaleType
                v_u_264.Main.Icon.Position = v265.InventoryIconData.Position or v_u_264.Main.Icon.Position
                v_u_264.Main.Icon.Size = v265.InventoryIconData.Size or v_u_264.Main.Icon.Size
            elseif p_u_259.Type == "Case" then
                v_u_264.Main.Icon.ScaleType = Enum.ScaleType.Crop
                v_u_264.Main.Icon.Position = UDim2.fromScale(0.5, 0.45)
                v_u_264.Main.Icon.Size = UDim2.fromScale(1, 1)
            elseif p_u_259.Type == "Package" then
                v_u_264.Main.Icon.ScaleType = Enum.ScaleType.Crop
                v_u_264.Main.Icon.Size = UDim2.fromScale(1, 1)
            end
            local v266 = v260 and v261.caseType and v_u_55[v261.caseType] or v260 and v261.caseType or (p_u_259.StatTrack and "KillTrak\226\132\162 " .. p_u_259.Name or p_u_259.Name)
            local v267 = v_u_18(v260 and v261.skin or (p_u_259.Skin or ""))
            if p_u_259.Type == "Melee" then
                v266 = "\226\152\133 " .. v266
            end
            v_u_264.Information.Weapon.Text = v266
            v_u_264.Information.Skin.Text = v267
            v_u_78(v_u_264, p_u_259._id)
            v_u_264.Button.Selectable = true
            local function v_u_287(p_u_268)
                if v_u_52.ItemNotification.Visible or v_u_105() then
                    return
                end
                local v269 = v_u_12.Get(v_u_10, "Inventory")
                if v269 then
                    for _, v270 in ipairs(v269) do
                        if v270._id == p_u_259._id then
                            p_u_259 = v270
                            break
                        end
                    end
                end
                local v271 = p_u_259.Type == "Case" and true or p_u_259.Type == "Package"
                local v272 = p_u_259.Type == "Charm Capsule" and true or p_u_259.Type == "Sticker Capsule"
                v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                v_u_40 = v_u_264
                v_u_37 = p_u_259
                v_u_1.SetupInformationFrame(p_u_259)
                if v_u_57() then
                    local function v286()
                        local v273 = v_u_51.Parent
                        local v274 = v273.AbsolutePosition
                        local v275 = v273.AbsoluteSize
                        local v276, v277
                        if v_u_4:GetLastInputType() == Enum.UserInputType.Gamepad1 or p_u_268 then
                            if v_u_264 and v_u_264:IsA("GuiObject") then
                                local v278 = v_u_264.AbsolutePosition
                                local v279 = v_u_264.AbsoluteSize
                                local v280 = v278.X + v279.X / 2
                                local v281 = v278.Y + v279.Y / 2
                                local v282 = (v280 - v274.X) / v275.X
                                v276 = (v281 - v274.Y) / v275.Y + v_u_51.Size.Y.Scale / 2
                                if 1 - v282 >= v_u_51.Size.X.Scale + 0.01 then
                                    v277 = v282 + v_u_51.Size.X.Scale / 2 + 0.01
                                else
                                    v277 = v282 - v_u_51.Size.X.Scale / 2 - 0.01
                                end
                            else
                                v277 = 0.5
                                v276 = 0.5
                            end
                        else
                            local v283 = v_u_11.X
                            local v284 = v_u_11.Y
                            local v285 = (v283 - v274.X) / v275.X
                            v276 = (v284 - v274.Y) / v275.Y + v_u_51.Size.Y.Scale / 2
                            if 1 - v285 >= v_u_51.Size.X.Scale + 0.01 then
                                v277 = v285 + v_u_51.Size.X.Scale / 2 + 0.01
                            else
                                v277 = v285 - v_u_51.Size.X.Scale / 2 - 0.01
                            end
                        end
                        v_u_51.Position = UDim2.fromScale(v277, v276)
                    end
                    if v271 or v272 then
                        v_u_51.Visible = true
                        v286()
                        v_u_52.Hover.Visible = false
                        if p_u_268 then
                            task.defer(function()
                                v_u_1.SetupInformationFrameNavigation()
                                v_u_1.SelectFirstInformationFrameButton()
                            end)
                        end
                        return
                    else
                        if p_u_268 then
                            v_u_51.Visible = true
                        else
                            v_u_51.Visible = not v_u_51.Visible
                        end
                        if v_u_51.Visible then
                            v286()
                            v_u_52.Hover.Visible = false
                            task.defer(function()
                                v_u_1.SetupInformationFrameNavigation()
                                if p_u_268 then
                                    v_u_1.SelectFirstInformationFrameButton()
                                end
                            end)
                        elseif v_u_39 then
                            v_u_48 = tick()
                        end
                    end
                else
                    v_u_51.Visible = false
                    return
                end
            end
            v_u_264.Button.MouseButton1Click:Connect(function()
                v_u_287(false)
            end)
            v_u_264.Button.Activated:Connect(function(p288)
                if p288 and p288.UserInputType == Enum.UserInputType.Gamepad1 then
                    v_u_287(true)
                end
            end)
            if v_u_36 then
                v_u_264.MouseEnter:Connect(function()
                    v_u_38 = p_u_259
                    v_u_39 = v_u_264
                    v_u_48 = tick()
                end)
                v_u_264.MouseLeave:Connect(function()
                    v_u_39 = nil
                    v_u_38 = nil
                    v_u_48 = nil
                end)
            end
        else
            print((("[Inventory] Skipping template creation for item: %* | %* (Type: %*) - No item information found"):format(p_u_259.Name, p_u_259.Skin, p_u_259.Type)))
        end
    else
        return
    end
end
function v_u_1.UpdateInventoryFilter()
    if v_u_52 then
        if v_u_52.Visible then
            v_u_35 = v_u_142()
            v_u_35 = v_u_169(v_u_35)
            v_u_225()
        else
            v_u_46 = true
            v_u_45 = true
        end
    else
        return
    end
end
function v_u_1.UpdateInventory(p289)
    if v_u_52 then
        if p289 and type(p289) == "table" then
            if v_u_52.Visible then
                local v290 = v_u_52.Tabs.Inventory.Container
                local v291 = {}
                for _, v292 in ipairs(p289) do
                    if v292 and v292._id then
                        v291[v292._id] = true
                    end
                end
                for _, v293 in ipairs(v290:GetChildren()) do
                    local v294 = v293:IsA("Frame")
                    if v294 then
                        if v293.Name == "UIGridLayout" or (v293.Name == "UIListLayout" or (v293.Name == "UIPadding" or v293.Name == "Title")) then
                            v294 = false
                        else
                            v294 = v293.Name ~= "Label"
                        end
                    end
                    if v294 and not v291[v293.Name] then
                        v293:Destroy()
                    end
                end
                if v_u_52 then
                    if v_u_52.Visible then
                        v_u_35 = v_u_142()
                        v_u_35 = v_u_169(v_u_35)
                        v_u_225()
                    else
                        v_u_46 = true
                        v_u_45 = true
                    end
                else
                    return
                end
            else
                v_u_46 = true
                v_u_45 = true
                return
            end
        else
            print("UpdateInventory received invalid inventory data:", p289)
            return
        end
    else
        return
    end
end
function v_u_1.UpdateTemplates(p295)
    if v_u_52 and v_u_52.Visible then
        local v296 = v_u_52.Tabs.Inventory.Container
        if p295 then
            for _, v297 in ipairs(p295) do
                local v298 = v296:FindFirstChild(v297._id)
                if v298 and v298:IsA("Frame") then
                    local v299 = v_u_15.GetSkinInformation(v297.Name, v297.Skin)
                    if v299 then
                        v298.Main.RarityFrame.UIGradient.Color = v_u_24[v299.rarity].ColorSequence
                        v298.Main.Glow.UIGradient.Color = v_u_24[v299.rarity].ColorSequence
                        v298.Main.Icon.Image = v_u_127(v297, v299, false)
                    end
                    v_u_78(v298, v297._id)
                end
            end
        end
    end
end
function v_u_1.SetupInformationFrameNavigation()
    if v_u_51 then
        local v300 = {}
        if v_u_51.Charm and v_u_51.Charm.Visible then
            local v301 = {
                ["button"] = v_u_51.Charm,
                ["order"] = v_u_51.Charm.LayoutOrder
            }
            table.insert(v300, v301)
        end
        if v_u_51.Inspect and v_u_51.Inspect.Visible then
            local v302 = {
                ["button"] = v_u_51.Inspect,
                ["order"] = v_u_51.Inspect.LayoutOrder
            }
            table.insert(v300, v302)
        end
        if v_u_51.ReplaceCT and v_u_51.ReplaceCT.Visible then
            local v303 = {
                ["button"] = v_u_51.ReplaceCT,
                ["order"] = v_u_51.ReplaceCT.LayoutOrder
            }
            table.insert(v300, v303)
        end
        if v_u_51.ReplaceT and v_u_51.ReplaceT.Visible then
            local v304 = {
                ["button"] = v_u_51.ReplaceT,
                ["order"] = v_u_51.ReplaceT.LayoutOrder
            }
            table.insert(v300, v304)
        end
        if v_u_51.Unlock and v_u_51.Unlock.Visible then
            local v305 = {
                ["button"] = v_u_51.Unlock,
                ["order"] = v_u_51.Unlock.LayoutOrder
            }
            table.insert(v300, v305)
        end
        local v306 = v_u_51:FindFirstChild("QuickUnlock")
        if v306 and v306.Visible then
            local v307 = {
                ["button"] = v306,
                ["order"] = v306.LayoutOrder
            }
            table.insert(v300, v307)
        end
        table.sort(v300, function(p308, p309)
            return p308.order < p309.order
        end)
        local v310 = {}
        for _, v311 in ipairs(v300) do
            local v312 = v311.button
            table.insert(v310, v312)
        end
        for v313, v314 in ipairs(v310) do
            v314.NextSelectionUp = v310[v313 > 1 and v313 - 1 or #v310]
            v314.NextSelectionDown = v310[v313 < #v310 and v313 + 1 or 1]
            v314.NextSelectionLeft = nil
            v314.NextSelectionRight = nil
        end
    end
end
function v_u_1.SetupItemNotificationNavigation()
    if v_u_52 and v_u_52.ItemNotification then
        local v315 = v_u_52.ItemNotification.Holder
        local v316 = {}
        if v315.ViewLoadout and v315.ViewLoadout.Visible then
            local v317 = {
                ["button"] = v315.ViewLoadout,
                ["order"] = v315.ViewLoadout.LayoutOrder or 1
            }
            table.insert(v316, v317)
        end
        if v315.Continue and v315.Continue.Visible then
            local v318 = {
                ["button"] = v315.Continue,
                ["order"] = v315.Continue.LayoutOrder or 2
            }
            table.insert(v316, v318)
        end
        if #v316 ~= 0 then
            table.sort(v316, function(p319, p320)
                return p319.order < p320.order
            end)
            for v321, v322 in ipairs(v316) do
                local v323 = v322.button
                v323.NextSelectionUp = v316[v321 > 1 and v321 - 1 or #v316].button
                v323.NextSelectionDown = v316[v321 < #v316 and v321 + 1 or 1].button
                v323.NextSelectionLeft = nil
                v323.NextSelectionRight = nil
            end
        end
    else
        return
    end
end
function v_u_1.SelectFirstItemNotificationButton()
    if v_u_4.GamepadEnabled then
        if v_u_52 and (v_u_52.ItemNotification and v_u_52.ItemNotification.Visible) then
            local v324 = v_u_52.ItemNotification.Holder
            if v324.ViewLoadout and (v324.ViewLoadout.Visible and v324.ViewLoadout.Selectable) then
                v_u_8.SelectedObject = v324.ViewLoadout
            elseif v324.Continue and (v324.Continue.Visible and v324.Continue.Selectable) then
                v_u_8.SelectedObject = v324.Continue
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.SelectFirstInformationFrameButton()
    if v_u_51 and v_u_51.Visible then
        v_u_1.SetupInformationFrameNavigation()
        if v_u_51.Charm and v_u_51.Charm.Visible then
            v_u_8.SelectedObject = v_u_51.Charm
            return
        elseif v_u_51.Inspect and v_u_51.Inspect.Visible then
            v_u_8.SelectedObject = v_u_51.Inspect
            return
        elseif v_u_51.ReplaceCT and v_u_51.ReplaceCT.Visible then
            v_u_8.SelectedObject = v_u_51.ReplaceCT
            return
        elseif v_u_51.ReplaceT and v_u_51.ReplaceT.Visible then
            v_u_8.SelectedObject = v_u_51.ReplaceT
            return
        elseif v_u_51.Unlock and v_u_51.Unlock.Visible then
            v_u_8.SelectedObject = v_u_51.Unlock
        else
            local v325 = v_u_51:FindFirstChild("QuickUnlock")
            if v325 and v325.Visible then
                v_u_8.SelectedObject = v325
            end
        end
    else
        return
    end
end
function v_u_1.SetupInformationFrame(p326)
    v_u_51.Inspect.Visible = (p326.Type == "Weapon" or (p326.Type == "Glove" or (p326.Type == "Melee" or p326.Type == "Charm"))) and true or p326.Type == "Badge"
    v_u_51.Unlock.Visible = p326.Type == "Case" and true or p326.Type == "Package"
    v_u_51.Loadout.Visible = false
    local v327 = v_u_51:FindFirstChild("QuickUnlock")
    local v328 = v_u_51:FindFirstChild("UnlockDivider")
    if v327 then
        v327.Visible = p326.Type == "Case" and true or p326.Type == "Package"
        if v328 then
            local v329 = v_u_51.Unlock.Visible
            if v329 then
                v329 = v327.Visible
            end
            v328.Visible = v329
        end
    end
    local v330 = p326.Type == "Weapon" and true or p326.Type == "Charm"
    if not v_u_51.Charm then
        warn("[Inventory] InformationFrame.Charm element not found - item type:", p326.Type)
    end
    if v_u_51.Charm then
        v_u_51.Charm.Visible = v330
        local v331 = v330 and v_u_51.Charm:FindFirstChild("TextLabel")
        if v331 then
            if p326.Type == "Charm" then
                v331.Text = "Attach to Weapon"
            else
                local v332
                if p326.Charm == nil or p326.Charm == false then
                    v332 = false
                else
                    local v333 = p326.Charm
                    if type(v333) == "string" or p326.Charm == true then
                        v332 = true
                    else
                        local v334 = p326.Charm
                        v332 = type(v334) == "table"
                    end
                end
                if v332 then
                    v331.Text = "Detach Charm"
                else
                    v331.Text = "Attach Charm"
                end
            end
        end
    end
    local v335 = p326.Type == "Weapon"
    local v336 = p326.Type == "Melee"
    local v337 = p326.Type == "Glove"
    local v338 = p326.Type == "Badge"
    local v339 = false
    local v340 = false
    if v335 then
        local v341, v342 = pcall(v_u_17, p326.Name)
        if v341 and (v342 and v342.Team) then
            if v342.Team == "Both" then
                v339 = true
                v340 = true
            elseif v342.Team == "Counter-Terrorists" then
                v339 = true
            elseif v342.Team == "Terrorists" then
                v340 = true
            end
        end
    elseif v336 then
        if p326.Name == "CT Knife" then
            v339 = true
            v340 = false
        elseif p326.Name == "T Knife" then
            v339 = false
            v340 = true
        else
            v339 = true
            v340 = true
        end
    elseif v337 then
        local v343 = v_u_17(p326.Name)
        if v343 and v343.Team then
            if v343.Team == "Both" then
                v339 = true
                v340 = true
            elseif v343.Team == "Counter-Terrorists" then
                v339 = true
            elseif v343.Team == "Terrorists" then
                v340 = true
            end
        end
    elseif v338 then
        v339 = true
        v340 = true
    end
    local v344 = v_u_70(p326._id, "Counter-Terrorists")
    local v345 = v_u_70(p326._id, "Terrorists")
    local v346 = v335 or (v336 or (v337 or v338))
    if v_u_51.ReplaceCT then
        local v347 = v_u_51.ReplaceCT
        if v346 then
            if v339 then
                v339 = not v344
            end
        else
            v339 = v346
        end
        v347.Visible = v339
    end
    if v_u_51.ReplaceT then
        local v348 = v_u_51.ReplaceT
        if v346 then
            if v340 then
                v340 = not v345
            end
        else
            v340 = v346
        end
        v348.Visible = v340
    end
    local v349 = {
        {
            ["dividerName"] = "CharmDivider",
            ["action"] = v_u_51.Charm
        },
        {
            ["dividerName"] = "InspectDivider",
            ["action"] = v_u_51.Inspect
        },
        {
            ["dividerName"] = "ReplaceCTDivider",
            ["action"] = v_u_51.ReplaceCT
        },
        {
            ["dividerName"] = "ReplaceTDivider",
            ["action"] = v_u_51.ReplaceT
        },
        {
            ["dividerName"] = "LoadoutDivider",
            ["action"] = v_u_51.Loadout
        }
    }
    local v350 = { "UnlockDivider" }
    for _, v351 in ipairs(v349) do
        local v352 = v351.dividerName
        table.insert(v350, v352)
    end
    for _, v353 in ipairs(v349) do
        local v354 = v_u_51:FindFirstChild(v353.dividerName)
        if v354 and v353.action then
            if v353.action.Visible then
                local v355 = v354.LayoutOrder
                local v356 = false
                for _, v357 in ipairs(v_u_51:GetChildren()) do
                    local v358 = false
                    for _, v359 in ipairs(v350) do
                        if v357.Name == v359 then
                            v358 = true
                            break
                        end
                    end
                    if not v358 and (v357 ~= v354 and (v357 ~= v353.action and (v357:IsA("Frame") or v357:IsA("TextButton")))) and (v357.LayoutOrder < v355 and v357.Visible) then
                        v356 = true
                    end
                end
                v354.Visible = v356
            else
                v354.Visible = false
            end
        end
    end
end
function v_u_1.SelectOption(p360, p361)
    if v_u_51 then
        v_u_51.Visible = false
    end
    p360.HoverFrame.BackgroundTransparency = 0
    p360.HoverFrame.Visible = true
    for _, v362 in ipairs(v_u_52.Top.Filter:GetChildren()) do
        if v362:IsA("TextButton") then
            v362.HoverFrame.Visible = v362.Name == p361
            v362.HoverFrame.BackgroundColor3 = v_u_33
            v362.TextLabel.TextColor3 = v_u_33
            v362:SetAttribute("Selected", nil)
            if v362.HoverFrame.Visible then
                v362.HoverFrame.BackgroundColor3 = v_u_32
                v362.TextLabel.TextColor3 = v_u_34
                v362:SetAttribute("Selected", true)
            end
        end
    end
    v_u_1.UpdateInventoryFilter()
end
function v_u_1.ShowNewItemNotification(p363)
    v_u_47 = false
    local v364 = false
    local v365 = 0
    for v366, v367 in ipairs(v_u_54) do
        if v367._id == p363._id then
            v365 = v366
            v364 = true
            break
        end
    end
    if not v364 then
        local v368 = v_u_54
        table.insert(v368, p363)
        v365 = #v_u_54
    end
    v_u_52.Visible = true
    v_u_1.NextInventoryItem(v365)
end
function v_u_1.NextInventoryItem(p369)
    local v370 = v_u_54[p369]
    v_u_41 = p369
    if v370 then
        local v371 = v370.Type == "Case" and true or v370.Type == "Package"
        local v372 = v371 and v_u_16.GetCaseByName(v370.Skin) or v_u_15.GetSkinInformation(v370.Name, v370.Skin)
        local v373 = v_u_24[v372 and (v371 and v372.caseRarity or v372.rarity) or (v370.Rarity or "Blue")] or v_u_24.Blue
        local v374 = v371 and v372 and v372.Skin or ("%* | %*"):format(v370.Name, v370.Skin)
        local v375 = v_u_127(v370, v372, v371)
        local v376 = v_u_52.ItemNotification.Holder.ViewLoadout
        local v377
        if v370.Type == "Case" then
            v377 = false
        else
            v377 = v370.Type ~= "Package"
        end
        v376.Visible = v377
        v_u_52.ItemNotification.Holder.RarityFrame.UIGradient.Color = v373.ColorSequence
        v_u_52.ItemNotification.Holder.Background.ImageColor3 = v373.Color
        v_u_52.ItemNotification.Holder.IconShadow.Image = v375
        v_u_52.ItemNotification.Holder.Light.ImageColor3 = v373.Color
        v_u_52.ItemNotification.Holder.WeaponName.Text = v374
        v_u_52.ItemNotification.Holder.Icon.Image = v375
        v_u_52.ItemNotification.Visible = true
        v_u_20.broadcastRouter("RunInterfaceSound", "New Item Reveal")
        v_u_52.ItemNotification.Holder.Title.TextColor3 = Color3.new(v373.Color.R * 0.56, v373.Color.G * 0.56, v373.Color.B * 0.56)
        task.defer(function()
            v_u_1.SetupItemNotificationNavigation()
            v_u_1.SelectFirstItemNotificationButton()
        end)
    end
end
function v_u_1.SelectCategory(p378)
    if v_u_51 then
        v_u_51.Visible = false
    end
    local v379 = v_u_21[p378]
    if v379 then
        v_u_62(v_u_52.Top.Filter, "TextButton")
        for _, v380 in ipairs(v_u_52.Top.Categories:GetChildren()) do
            if v380:IsA("TextButton") and v380:GetAttribute("IsCategoryButton") then
                v380.HoverFrame.Visible = v380.Name == p378
                v380.HoverFrame.BackgroundColor3 = v_u_33
                v380.TextLabel.TextColor3 = v_u_33
                v380:SetAttribute("Selected", nil)
                if v380.HoverFrame.Visible then
                    v380.HoverFrame.BackgroundColor3 = v_u_32
                    v380.TextLabel.TextColor3 = v_u_34
                    v380:SetAttribute("Selected", true)
                end
            end
        end
        for v_u_381, v382 in pairs(v379) do
            local v_u_383 = v_u_3.Assets.UI.Inventory.OptionTemplate:Clone()
            v_u_383.HoverFrame.BackgroundColor3 = v_u_33
            v_u_383.TextLabel.TextColor3 = v_u_33
            v_u_383.LayoutOrder = v382.LayoutOrder
            v_u_383.Parent = v_u_52.Top.Filter
            v_u_383.Visible = v_u_381 ~= "Default"
            v_u_383.TextLabel.Text = v_u_381
            v_u_383.HoverFrame.Visible = false
            v_u_383.Name = v_u_381
            local v384 = v_u_6:GetTextSize(v_u_381, v_u_383.TextLabel.TextSize, v_u_383.TextLabel.Font, Vector2.new((1 / 0), (1 / 0))).X + 16
            v_u_383.Size = UDim2.new(0, v384, v_u_383.Size.Y.Scale, v_u_383.Size.Y.Offset)
            if v382.LayoutOrder == 0 then
                v_u_1.SelectOption(v_u_383, v_u_381)
            end
            v_u_258(v_u_383)
            v_u_383.Selectable = true
            local function v385()
                v_u_1.SelectOption(v_u_383, v_u_381)
                v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            end
            v_u_383.MouseButton1Click:Connect(v385)
            v_u_383.Activated:Connect(function(p386)
                if p386 and p386.UserInputType == Enum.UserInputType.Gamepad1 then
                    v_u_1.SelectOption(v_u_383, v_u_381)
                    v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                end
            end)
        end
    else
        warn((("[Inventory] Category \"%*\" not found in InventoryButtons"):format(p378)))
    end
end
function v_u_1.SetupCategoryButton(p_u_387)
    v_u_258(p_u_387)
    p_u_387.Selectable = true
    local function v390()
        local v388 = v_u_1.SelectCategory
        local v389 = p_u_387.Name
        v388((tostring(v389)))
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
    end
    p_u_387.MouseButton1Click:Connect(v390)
    p_u_387.Activated:Connect(function(p391)
        if p391 and p391.UserInputType == Enum.UserInputType.Gamepad1 then
            local v392 = v_u_1.SelectCategory
            local v393 = p_u_387.Name
            v392((tostring(v393)))
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        end
    end)
end
function v_u_1.UpdateHoverFrame(_)
    local v394 = tick() - (v_u_48 or 0)
    local v395 = v_u_105()
    if v_u_52.Visible and (not v395 and (not v_u_51.Visible and (v_u_39 and (v_u_38 and v394 > 0.75)))) then
        v_u_52.Hover.Position = v_u_121(v_u_39)
        local v396 = v_u_38
        local v397 = v396.Type == "Case" and true or v396.Type == "Package"
        local v398 = v397 and v_u_16.GetCaseByName(v396.Skin) or v_u_15.GetSkinInformation(v396.Name, v396.Skin)
        if v398 then
            local v399 = v397 and v398.caseType and v_u_55[v398.caseType] or v397 and v398.caseType or (v396.StatTrack and "KillTrak\226\132\162 " .. v396.Name or v396.Name)
            local v400 = v_u_18(v397 and v398.skin or v396.Skin)
            local v401 = v400 == "Vanilla" and "" or (" | " .. v400 or "")
            local v402 = (v396.Type == "Melee" and "\226\152\133 " or "") .. v399
            v_u_52.Hover.ItemName.Frame.ItemName.Text = v402 .. v401
            local v403 = v_u_133(v396)
            v_u_52.Hover.ItemName.Frame.Collection.Text = v403 or ""
            local v404 = v_u_52.Hover.ItemName.CollectionIcon
            if v403 then
                local v405 = v_u_13.GetCollectionByName(v403)
                if v405 and v405.imageAssetId then
                    v404.Image = v405.imageAssetId
                    v404.Visible = true
                else
                    v404.Visible = false
                end
            else
                v404.Visible = false
            end
            local v406 = v_u_52.Hover:FindFirstChild("CollectionName")
            if v406 then
                if v403 then
                    v406.Text = v403 .. ":"
                    v406.Visible = true
                else
                    v406.Visible = false
                end
            end
            if v403 and not v397 then
                local v407 = v_u_13.GetCollectionByName(v403)
                if v407 and v407.items then
                    local v408 = v_u_52.Hover.Collection
                    local v409 = v_u_12.Get(v_u_10, "Inventory")
                    for _, v410 in ipairs(v408:GetChildren()) do
                        if v410:IsA("Frame") and v410.Name ~= "UIListLayout" then
                            v410:Destroy()
                        end
                    end
                    local v411 = {}
                    if v409 then
                        for _, v412 in ipairs(v409) do
                            if v412.Name and v412.Skin then
                                v411[v412.Name .. "|" .. v412.Skin] = true
                            end
                        end
                    end
                    local v413 = {
                        ["Blue"] = 1,
                        ["Purple"] = 2,
                        ["Pink"] = 3,
                        ["Red"] = 4,
                        ["Special"] = 5,
                        ["Forbidden"] = 6,
                        ["Stock"] = 7
                    }
                    local v414 = {}
                    for _, v415 in ipairs(v407.items) do
                        if v415.itemName and v415.skinName then
                            local v416 = v_u_15.GetSkinInformation(v415.itemName, v415.skinName)
                            if v416 then
                                local v417 = {
                                    ["item"] = v415,
                                    ["rarity"] = v416.rarity,
                                    ["rarityOrder"] = v413[v416.rarity] or 99
                                }
                                table.insert(v414, v417)
                            end
                        end
                    end
                    table.sort(v414, function(p418, p419)
                        if p418.rarityOrder == p419.rarityOrder then
                            return p418.item.itemName < p419.item.itemName
                        else
                            return p418.rarityOrder < p419.rarityOrder
                        end
                    end)
                    local v420 = v_u_3.Assets.UI.Inventory.CollectionNameTemplate
                    for v421, v422 in ipairs(v414) do
                        local v423 = v422.item
                        local v424 = v_u_15.GetSkinInformation(v423.itemName, v423.skinName)
                        if v424 and v420 then
                            local v425 = v420:Clone()
                            v425.Parent = v408
                            v425.LayoutOrder = v421
                            v425.Visible = true
                            local v426 = v425:FindFirstChild("CollectionName") or v425:FindFirstChild("gun")
                            if v426 then
                                v426.Text = "[" .. v423.itemName .. "] | " .. v423.skinName
                                local v427 = v424.rarity
                                if v427 then
                                    v427 = v_u_24[v424.rarity]
                                end
                                if v427 then
                                    v426.TextColor3 = v427.Color
                                end
                                v426.Visible = true
                            end
                            local v428 = v425:FindFirstChild("ImageLabel")
                            if v428 then
                                v428.Visible = v411[v423.itemName .. "|" .. v423.skinName] == true
                            end
                        end
                    end
                    if v406 then
                        v406.Visible = true
                    end
                    v408.Visible = true
                    local v429 = v_u_52.Hover:FindFirstChild("CollectionSpacer")
                    if v429 then
                        v429.Visible = true
                    end
                else
                    local v430 = v_u_52.Hover.Collection
                    if v430 then
                        for _, v431 in ipairs(v430:GetChildren()) do
                            if v431:IsA("Frame") and v431.Name ~= "UIListLayout" then
                                v431:Destroy()
                            end
                        end
                        v430.Visible = false
                    end
                    local v432 = v_u_52.Hover:FindFirstChild("CollectionName")
                    if v432 then
                        v432.Visible = false
                    end
                    local v433 = v_u_52.Hover:FindFirstChild("CollectionSpacer")
                    if v433 then
                        v433.Visible = false
                    end
                end
            else
                local v434 = v_u_52.Hover.Collection
                if v434 then
                    for _, v435 in ipairs(v434:GetChildren()) do
                        if v435:IsA("Frame") and v435.Name ~= "UIListLayout" then
                            v435:Destroy()
                        end
                    end
                    v434.Visible = false
                end
                local v436 = v_u_52.Hover:FindFirstChild("CollectionName")
                if v436 then
                    v436.Visible = false
                end
                local v437 = v_u_52.Hover:FindFirstChild("CollectionSpacer")
                if v437 then
                    v437.Visible = false
                end
            end
            if v397 or v396.Type ~= "Weapon" and (v396.Type ~= "Melee" and v396.Type ~= "Glove") then
                if v397 then
                    if v398.description then
                        v_u_52.Hover.Description.Text = v398.description
                    else
                        v_u_52.Hover.Description.Text = ""
                    end
                elseif v398.description then
                    v_u_52.Hover.Description.Text = v398.description
                else
                    v_u_52.Hover.Description.Text = ""
                end
            else
                local v438 = v396.Name
                local v439 = v396.Type == "Melee" and "T Knife" or (v396.Type == "Glove" and "T Glove" or v438)
                local v440 = v_u_15.GetSkinInformation(v439, "Stock")
                if v440 and v440.description then
                    v_u_52.Hover.Description.Text = v440.description
                else
                    v_u_52.Hover.Description.Text = ""
                end
            end
            if v397 or (v396.Type == "Charm Capsule" and true or v396.Type == "Sticker Capsule") then
                v_u_52.Hover.Information.Visible = false
            else
                v_u_52.Hover.Information.Visible = true
            end
            local v441 = v397 and v398.caseRarity or v398.rarity
            if v441 then
                local v442 = v_u_24[v441]
                if v442 then
                    local v443 = ({
                        ["Blue"] = "Blue",
                        ["Purple"] = "Purple",
                        ["Pink"] = "Pink",
                        ["Red"] = "Red",
                        ["Special"] = "\226\152\133 Special",
                        ["Forbidden"] = "\226\152\133 Special"
                    })[v441] or v441
                    v_u_52.Hover.Information.Rarity.Label.Text = v443
                    v_u_52.Hover.Information.Rarity.Label.TextColor3 = v442.Color
                else
                    v_u_52.Hover.Information.Rarity.Label.Text = ""
                end
            else
                v_u_52.Hover.Information.Rarity.Label.Text = ""
            end
            local v444 = v_u_52.Hover.Information.Exterior
            if v397 then
                v444.Visible = false
            else
                local v445 = v_u_15.GetWearNameForFloat(v398, v396.Float or v398.floatRange.max)
                if v445 then
                    v444.Label.Text = v445
                    v444.Visible = true
                else
                    v444.Visible = false
                end
            end
            local v446 = v_u_52.Hover.Information.Team.Team
            if (v396.Type == "Melee" or (v396.Type == "Glove" or v396.Type == "Badge")) and true or v396.Type == "Charm" then
                v446.CT.Visible = true
                v446.T.Visible = true
                v446.Label.Visible = true
                v446.Label.Text = "Both"
            elseif v396.Type == "Weapon" then
                local v447 = v_u_17(v396.Name)
                if v447 and v447.Team then
                    local v448 = v447.Team
                    if v448 == "Counter-Terrorists" then
                        v446.CT.Visible = true
                        v446.T.Visible = false
                        v446.Label.Visible = true
                        v446.Label.Text = "Counter-Terrorists"
                    elseif v448 == "Terrorists" then
                        v446.CT.Visible = false
                        v446.T.Visible = true
                        v446.Label.Visible = true
                        v446.Label.Text = "Terrorists"
                    else
                        v446.CT.Visible = true
                        v446.T.Visible = true
                        v446.Label.Visible = true
                        v446.Label.Text = "Both"
                    end
                end
            end
        end
        v_u_52.Hover.Visible = true
    else
        v_u_52.Hover.Visible = false
    end
end
function v_u_1.Initialize(p449, p450)
    v_u_53 = p449
    v_u_52 = p450
    v_u_51 = p450.Information
    v_u_30.Add(v_u_51, nil, function()
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_51.Visible = false
        if v_u_40 and v_u_40:FindFirstChild("Button") then
            local v451 = v_u_40:FindFirstChild("Button")
            if v451 and v451:IsA("GuiButton") then
                v_u_8.SelectedObject = v451
                return
            end
        end
    end)
    v_u_13.ObserveAvailableCollections(function(p452)
        v_u_43 = p452
    end)
    v_u_51.Inspect.Selectable = true
    local function v453()
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        if v_u_37 then
            v_u_51.Visible = false
            v_u_20.broadcastRouter("WeaponInspect", v_u_37.Name, v_u_37.Skin, v_u_37.Float, v_u_37.StatTrack, v_u_37.NameTag, v_u_37.Charm, v_u_37.Stickers, v_u_37.Type, v_u_37.Pattern, v_u_37._id, v_u_37.Serial, v_u_37.IsTradeable)
        end
    end
    v_u_51.Inspect.MouseButton1Click:Connect(v453)
    v_u_51.Inspect.Activated:Connect(function(p454)
        if p454 and p454.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_37 then
                v_u_51.Visible = false
                v_u_20.broadcastRouter("WeaponInspect", v_u_37.Name, v_u_37.Skin, v_u_37.Float, v_u_37.StatTrack, v_u_37.NameTag, v_u_37.Charm, v_u_37.Stickers, v_u_37.Type, v_u_37.Pattern, v_u_37._id, v_u_37.Serial, v_u_37.IsTradeable)
            end
        else
            return
        end
    end)
    if v_u_51.Charm then
        v_u_51.Charm.Selectable = true
        local function v_u_458()
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_37 then
                local v455
                if v_u_37.Charm == nil or v_u_37.Charm == false then
                    v455 = false
                else
                    local v456 = v_u_37.Charm
                    if type(v456) == "string" or v_u_37.Charm == true then
                        v455 = true
                    else
                        local v457 = v_u_37.Charm
                        v455 = type(v457) == "table"
                    end
                end
                v_u_51.Visible = false
                if v455 then
                    v_u_19.Inventory.RemoveWeaponCharm.Send({
                        ["WeaponId"] = v_u_37._id
                    })
                    return
                end
                v_u_52.Visible = false
                v_u_26.TriggerAction("AttachCharm", v_u_37)
            end
        end
        v_u_51.Charm.MouseButton1Click:Connect(v_u_458)
        v_u_51.Charm.Activated:Connect(function(p459)
            if p459 and p459.UserInputType == Enum.UserInputType.Gamepad1 then
                v_u_458()
            end
        end)
    end
    v_u_26.OnItemSelected:Connect(function(p460, p461)
        local v462 = v_u_26.GetActions().Get(p461.ActionType)
        if v462 then
            v462.OnItemSelected(p460, p461)
        end
    end)
    v_u_26.OnClosed:Connect(function(_)
        if v_u_31.GetCurrentScreen() == "Inventory" then
            v_u_52.Visible = true
        end
    end)
    v_u_51.Unlock.Selectable = true
    local function v464()
        if v_u_47 then
            return
        else
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_37 then
                local v463 = v_u_16.GetCaseByName(v_u_37.Skin)
                v_u_28.OpenCaseContent(v463.caseId, "Open", v_u_37._id)
                v_u_51.Visible = false
                v_u_52.Visible = false
            end
        end
    end
    v_u_51.Unlock.MouseButton1Click:Connect(v464)
    v_u_51.Unlock.Activated:Connect(function(p465)
        if p465 and p465.UserInputType == Enum.UserInputType.Gamepad1 then
            if v_u_47 then
                return
            end
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_37 then
                local v466 = v_u_16.GetCaseByName(v_u_37.Skin)
                v_u_28.OpenCaseContent(v466.caseId, "Open", v_u_37._id)
                v_u_51.Visible = false
                v_u_52.Visible = false
                return
            end
        end
    end)
    local function v_u_469()
        if v_u_47 then
            return
        else
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            local v467 = v_u_12.Get(v_u_10, "Gamepasses")
            if v467 then
                v467 = table.find(v467, "Quick Open")
            end
            if v467 then
                if v_u_37 then
                    local v468 = v_u_16.GetCaseByName(v_u_37.Skin)
                    if v468 then
                        v_u_47 = true
                        v_u_28.SetQuickUnlock(true)
                        v_u_19.Store.OpenCase.Send({
                            ["CaseIdentifiers"] = { v_u_37._id },
                            ["CaseId"] = v468.caseId,
                            ["OpenType"] = "Quick Open"
                        })
                        v_u_51.Visible = false
                    else
                        v_u_20.broadcastRouter("CreateMenuNotification", "Error", "Case not found.")
                    end
                else
                    return
                end
            else
                v_u_2:PromptGamePassPurchase(v_u_10, v_u_22["Quick Open"].GamepassId)
                return
            end
        end
    end
    v_u_51.QuickUnlock.MouseButton1Click:Connect(v_u_469)
    v_u_51.QuickUnlock.Activated:Connect(function(p470)
        if p470 and p470.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_469()
        end
    end)
    if v_u_51.ReplaceT then
        v_u_51.ReplaceT.Selectable = true
        local function v471()
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_37 then
                v_u_51.Visible = false
                v_u_98(v_u_37, "Terrorists")
            end
        end
        v_u_51.ReplaceT.MouseButton1Click:Connect(v471)
        v_u_51.ReplaceT.Activated:Connect(function(p472)
            if p472 and p472.UserInputType == Enum.UserInputType.Gamepad1 then
                v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                if v_u_37 then
                    v_u_51.Visible = false
                    v_u_98(v_u_37, "Terrorists")
                end
            end
        end)
    end
    if v_u_51.ReplaceCT then
        v_u_51.ReplaceCT.Selectable = true
        local function v473()
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_37 then
                v_u_51.Visible = false
                v_u_98(v_u_37, "Counter-Terrorists")
            end
        end
        v_u_51.ReplaceCT.MouseButton1Click:Connect(v473)
        v_u_51.ReplaceCT.Activated:Connect(function(p474)
            if p474 and p474.UserInputType == Enum.UserInputType.Gamepad1 then
                v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                if v_u_37 then
                    v_u_51.Visible = false
                    v_u_98(v_u_37, "Counter-Terrorists")
                end
            end
        end)
    end
    v_u_52.ItemNotification.Holder.Left.MouseButton1Click:Connect(function()
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        if v_u_41 > 0 then
            v_u_1.NextInventoryItem(v_u_41 - 1)
        end
    end)
    v_u_52.ItemNotification.Holder.Right.MouseButton1Click:Connect(function()
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        if v_u_41 <= #v_u_54 then
            v_u_1.NextInventoryItem(v_u_41 + 1)
        end
    end)
    v_u_52.ItemNotification.Holder.Continue.Selectable = true
    v_u_52.ItemNotification.Holder.ViewLoadout.Selectable = true
    local function v475()
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_52.ItemNotification.Visible = false
        v_u_41 = 0
        table.clear(v_u_54)
    end
    v_u_52.ItemNotification.Holder.Continue.MouseButton1Click:Connect(v475)
    v_u_52.ItemNotification.Holder.Continue.Activated:Connect(function(p476)
        if p476 and p476.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            v_u_52.ItemNotification.Visible = false
            v_u_41 = 0
            table.clear(v_u_54)
        end
    end)
    local function v_u_478()
        local v477 = v_u_54[v_u_41]
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_52.ItemNotification.Visible = false
        v_u_41 = 0
        table.clear(v_u_54)
        if v477 and (v477.Type == "Melee" or (v477.Type == "Glove" or v477.Type == "Weapon")) and true or false then
            v_u_52.Visible = false
            v_u_27.ViewInLoadout(v477._id)
        end
    end
    v_u_52.ItemNotification.Holder.ViewLoadout.MouseButton1Click:Connect(v_u_478)
    v_u_52.ItemNotification.Holder.ViewLoadout.Activated:Connect(function(p479)
        if p479 and p479.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_478()
        end
    end)
    v_u_52.Tabs.Inventory.Sort.Button.Selectable = true
    local function v480()
        v_u_52.Tabs.Inventory.Sort.Button.Options.Visible = not v_u_52.Tabs.Inventory.Sort.Button.Options.Visible
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
    end
    v_u_52.Tabs.Inventory.Sort.Button.MouseButton1Click:Connect(v480)
    v_u_52.Tabs.Inventory.Sort.Button.Activated:Connect(function(p481)
        if p481 and p481.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_52.Tabs.Inventory.Sort.Button.Options.Visible = not v_u_52.Tabs.Inventory.Sort.Button.Options.Visible
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        end
    end)
    for _, v482 in ipairs({
        "Alphabetical",
        "Collection",
        "Equipped",
        "Newest",
        "Quality",
        "Type"
    }) do
        local v483 = v_u_52.Tabs.Inventory.Sort.Button.Options:FindFirstChild(v482)
        if v483 then
            v_u_233(v_u_52.Tabs.Inventory.Sort.Button.Options, v483, v482, v_u_52.Tabs.Inventory.Sort.Button.Frame.TextLabel, v_u_52.Tabs.Inventory.Container)
        end
    end
    for _, v484 in ipairs(v_u_52.Top.Categories:GetChildren()) do
        if v484:IsA("TextButton") and v484:GetAttribute("IsCategoryButton") then
            v_u_1.SetupCategoryButton(v484)
        end
    end
    v_u_52:GetPropertyChangedSignal("Visible"):Connect(function()
        if v_u_52.Visible then
            if v_u_50 then
                task.cancel(v_u_50)
                v_u_50 = nil
            end
            if v_u_46 then
                v_u_46 = false
                if v_u_52 then
                    if v_u_52.Visible then
                        v_u_35 = v_u_142()
                        v_u_35 = v_u_169(v_u_35)
                        v_u_225()
                    else
                        v_u_46 = true
                        v_u_45 = true
                    end
                end
            end
            if v_u_45 then
                v_u_221()
            end
            local v485 = #v_u_54
            if v485 > 0 and v_u_41 < v485 then
                v_u_1.NextInventoryItem(v_u_41 + 1)
                return
            end
        else
            if v_u_50 then
                task.cancel(v_u_50)
                v_u_50 = nil
            end
            v_u_50 = task.spawn(function()
                task.wait(20)
                if not v_u_52 or v_u_52.Visible then
                    return
                end
                local v486 = v_u_52.Tabs.Inventory.Container
                v486.CanvasPosition = Vector2.new(0, 0)
                local v487 = {}
                for _, v488 in ipairs(v486:GetChildren()) do
                    local v489 = v488:IsA("Frame")
                    if v489 then
                        if v488.Name == "UIGridLayout" or (v488.Name == "UIListLayout" or (v488.Name == "UIPadding" or v488.Name == "Title")) then
                            v489 = false
                        else
                            v489 = v488.Name ~= "Label"
                        end
                    end
                    if v489 then
                        table.insert(v487, v488)
                    end
                end
                table.sort(v487, function(p490, p491)
                    return p490.LayoutOrder > p491.LayoutOrder
                end)
                for v492 = 1, #v487 do
                    if v_u_52.Visible then
                        break
                    end
                    v487[v492]:Destroy()
                    if v_u_49 > 0 then
                        v_u_49 = v_u_49 - 1
                    end
                    task.wait(1)
                end
                v_u_45 = true
                v_u_50 = nil
            end)
        end
    end)
    v_u_52.Tabs.Inventory.Container:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        v_u_183()
    end)
    v_u_52.Tabs.Inventory.Container:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
        task.defer(v_u_183)
    end)
end
function v_u_1.Start()
    v_u_12.WaitForDataLoaded(v_u_10)
    v_u_1.SelectCategory("Everything")
    local v_u_493 = nil
    local v_u_494 = nil
    if v_u_52 then
        v_u_52:GetPropertyChangedSignal("Visible"):Connect(function()
            if v_u_52.Visible then
                if v_u_493 then
                    v_u_493:Disconnect()
                end
                v_u_493 = v_u_4.InputBegan:Connect(function(p495, p496)
                    if p495.UserInputType == Enum.UserInputType.Gamepad1 then
                        if v_u_52 and (v_u_52.Visible and not p496) then
                            local v497 = p495.KeyCode
                            local v498 = v_u_8.SelectedObject
                            local v499 = v_u_52 and v_u_52.ItemNotification
                            if v499 then
                                v499 = v_u_52.ItemNotification.Visible
                            end
                            if v497 == Enum.KeyCode.ButtonB then
                                if v499 then
                                    v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                                    v_u_52.ItemNotification.Visible = false
                                    v_u_41 = 0
                                    table.clear(v_u_54)
                                    return
                                end
                                if v_u_51 and v_u_51.Visible then
                                    v_u_51.Visible = false
                                    v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                                    return
                                end
                                if v_u_52 and v_u_52.Tabs.Inventory.Sort.Button.Options.Visible then
                                    v_u_52.Tabs.Inventory.Sort.Button.Options.Visible = false
                                    v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                                    return
                                end
                            end
                            if v499 then
                                local v500 = v_u_52.ItemNotification.Holder
                                if v497 == Enum.KeyCode.Thumbstick1 or (v497 == Enum.KeyCode.DPadLeft or v497 == Enum.KeyCode.DPadRight) then
                                    return
                                else
                                    local v501 = v497 == Enum.KeyCode.DPadUp
                                    if v501 or v497 == Enum.KeyCode.DPadDown then
                                        if v498 and v498:IsA("GuiButton") then
                                            local v502 = v501 and v498.NextSelectionUp or v498.NextSelectionDown
                                            if v502 and (v502 == v500.Continue or v502 == v500.ViewLoadout) then
                                                v_u_8.SelectedObject = v502
                                            end
                                        end
                                    end
                                end
                            else
                                local v503 = v_u_51 and v_u_51.Visible
                                if v503 then
                                    if v498 then
                                        v503 = v498:IsDescendantOf(v_u_51)
                                    else
                                        v503 = v498
                                    end
                                end
                                if not v503 or v497 ~= Enum.KeyCode.Thumbstick1 and (v497 ~= Enum.KeyCode.DPadLeft and v497 ~= Enum.KeyCode.DPadRight) then
                                    local v504 = v497 == Enum.KeyCode.DPadUp
                                    local v505 = (v504 or v497 == Enum.KeyCode.DPadDown) and (v498 and v498:IsA("GuiButton")) and (v504 and v498.NextSelectionUp or v498.NextSelectionDown)
                                    if v505 then
                                        if v503 then
                                            if v505:IsDescendantOf(v_u_51) then
                                                v_u_8.SelectedObject = v505
                                                return
                                            end
                                        else
                                            v_u_8.SelectedObject = v505
                                        end
                                    end
                                end
                            end
                        else
                            return
                        end
                    else
                        return
                    end
                end)
                if v_u_494 then
                    v_u_494:Disconnect()
                end
                v_u_494 = v_u_8.Changed:Connect(function(p506)
                    if p506 == "SelectedObject" then
                        local v507 = v_u_52
                        if v507 then
                            v507 = v_u_52.ItemNotification
                        end
                        if v507 and v507.Visible then
                            local v508 = v507.Holder
                            local v509 = v_u_8.SelectedObject
                            if v509 and (v509 ~= v508.Continue and (v509 ~= v508.ViewLoadout and not (v509:IsDescendantOf(v508) and v509:IsA("GuiButton")))) then
                                task.defer(function()
                                    v_u_1.SelectFirstItemNotificationButton()
                                end)
                            end
                            return
                        elseif v_u_51 and v_u_51.Visible then
                            local v510 = v_u_8.SelectedObject
                            if v510 and not v510:IsDescendantOf(v_u_51) then
                                task.defer(function()
                                    v_u_1.SelectFirstInformationFrameButton()
                                end)
                            end
                        end
                    else
                        return
                    end
                end)
                if v_u_4.GamepadEnabled then
                    task.defer(function()
                        local v511 = 0
                        while v511 < 5 do
                            task.wait(0.1)
                            v511 = v511 + 1
                            if v_u_8.SelectedObject or not (v_u_52 and v_u_52.Visible) then
                                break
                            end
                            if v_u_52.Tabs.Inventory.Container then
                                for _, v512 in ipairs(v_u_52.Tabs.Inventory.Container:GetChildren()) do
                                    if v512:IsA("Frame") and (v512.Name ~= "UIGridLayout" and (v512.Name ~= "UIListLayout" and v512.Name ~= "UIPadding")) then
                                        local v513 = v512:FindFirstChild("Button")
                                        if v513 and (v513:IsA("GuiButton") and (v513.Selectable and v513.Visible)) then
                                            v_u_8.SelectedObject = v513
                                            return
                                        end
                                    end
                                end
                            end
                        end
                    end)
                    return
                end
            else
                if v_u_493 then
                    v_u_493:Disconnect()
                    v_u_493 = nil
                end
                if v_u_494 then
                    v_u_494:Disconnect()
                    v_u_494 = nil
                end
            end
        end)
    end
    v_u_7.Heartbeat:Connect(function(p514)
        local v515 = v_u_53.Menu.Top.Buttons.Inventory.Alert
        if v_u_36 then
            v_u_1.UpdateHoverFrame(p514)
        else
            v_u_52.Hover.Visible = false
        end
        local v516 = #v_u_54
        v515.TextLabel.Text = v516
        v515.Visible = v516 > 0
        v_u_52.ItemNotification.Holder.Light.Rotation = v_u_52.ItemNotification.Holder.Light.Rotation + p514 * 10
        v_u_52.ItemNotification.Holder.Amount.TextLabel.Text = ("%* / %*"):format(v_u_41, v516)
        v_u_52.ItemNotification.Holder.Right.Visible = v_u_41 < v516
        v_u_52.ItemNotification.Holder.Left.Visible = v_u_41 > 1
    end)
    v_u_15.OnItemStockSchemasUpdated:Connect(function(_)
        local v517 = v_u_12.Get(v_u_10, "Inventory")
        v_u_1.UpdateTemplates(v517)
    end)
    v_u_19.Store.NewInventoryItem.Listen(function(p518)
        local v519 = p518.Player
        local v520 = tonumber(v519)
        if not v520 then
            return
        end
        local v521 = v_u_9:GetPlayerByUserId(v520)
        if not v521 or v_u_10 ~= v521 then
            return
        end
        for _, v522 in ipairs(p518.Items) do
            local v523 = false
            for _, v524 in ipairs(v_u_54) do
                if v524._id == v522._id then
                    v523 = true
                    break
                end
            end
            if not v523 then
                local v525 = v_u_54
                table.insert(v525, v522)
            end
        end
    end)
    v_u_12.CreateListener(v_u_10, "Inventory", function(p526)
        v_u_1.UpdateInventory(p526)
        if not v_u_42 then
            v_u_52.Tabs.Inventory.Sort.Button.Frame.TextLabel.Text = "Newest"
            v_u_44 = "Newest"
            v_u_42 = true
        end
        if v_u_52 then
            if v_u_52.Visible then
                v_u_35 = v_u_142()
                v_u_35 = v_u_169(v_u_35)
                v_u_225()
            else
                v_u_46 = true
                v_u_45 = true
            end
        else
            return
        end
    end)
    v_u_12.CreateListener(v_u_10, "Loadout", function()
        if v_u_52 and v_u_52.Visible then
            local v527 = v_u_52.Tabs.Inventory.Container
            for _, v528 in ipairs(v527:GetChildren()) do
                local v529 = v528:IsA("Frame")
                if v529 then
                    if v528.Name == "UIGridLayout" or (v528.Name == "UIListLayout" or (v528.Name == "UIPadding" or v528.Name == "Title")) then
                        v529 = false
                    else
                        v529 = v528.Name ~= "Label"
                    end
                end
                if v529 then
                    v_u_78(v528, v528.Name)
                end
            end
        end
    end)
    v_u_31.OnInspectStateChanged:Connect(function(p530)
        if not p530 then
            task.defer(function()
                local v531 = #v_u_54
                if v_u_52.Visible and (v531 > 0 and v_u_41 < v531) then
                    v_u_1.NextInventoryItem(v_u_41 + 1)
                end
            end)
        end
    end)
    v_u_20.observerRouter("ShowNewItemNotification", function(p532)
        v_u_1.ShowNewItemNotification(p532)
    end)
    v_u_20.observerRouter("ShowNewItemNotificationAtIndex", function(p533)
        if p533 <= #v_u_54 then
            v_u_1.NextInventoryItem(p533)
        end
    end)
end
return v_u_1