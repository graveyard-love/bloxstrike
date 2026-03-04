local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("TweenService")
local v5 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_6 = v5.LocalPlayer
local v_u_7 = v2:WaitForChild("Assets"):WaitForChild("UI"):WaitForChild("Settings")
local v_u_8 = require(v2.Controllers.DataController)
local v_u_9 = require(v2.Components.Common.GetUserPlatform)
local v_u_10 = require(v2.Shared.Janitor)
local v_u_11 = require(v2.Database.Security.Remotes)
local v_u_12 = require(v2.Database.Custom.GameStats.UI.Settings.Pages)
local v_u_13 = require(script.Templates.CrosshairPreview)
local v_u_14 = require(script.Templates.Dropdown)
local v_u_15 = require(script.Templates.Keybind)
local v_u_16 = require(script.Templates.Number)
local v_u_17 = require(script.Templates.Toggle)
local v_u_18 = require(script.Templates.Slider)
local v_u_19 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v_u_20 = Color3.fromRGB(53, 83, 99)
local v_u_21 = Color3.fromRGB(243, 243, 243)
local v_u_22 = Color3.fromRGB(125, 206, 243)
local v_u_23 = {
    "Keyboard & Mouse Settings",
    "Movement Keys",
    "Weapon Keys",
    "UI Keys",
    "Communication Options"
}
local v_u_24 = {
    "Item",
    "HUD",
    "Crosshair",
    "Viewmodel",
    "Radar/Tablet",
    "Other"
}
local v_u_25 = {
    ["Video"] = "Video",
    ["Audio"] = "Audio",
    ["Game"] = "Game",
    ["Keybinds"] = "Keyboard/Mouse"
}
local v_u_26 = nil
local v_u_27 = {}
local v_u_28 = {}
local v_u_29 = {}
local v_u_30 = {}
local v_u_31 = {}
local v_u_32 = nil
local v_u_33 = nil
local v_u_34 = nil
local v_u_35 = nil
local v_u_36 = nil
local v_u_37 = 0
local v_u_38 = "Video"
local v_u_39 = {
    ["CrosshairPreviewTemplate"] = nil,
    ["DropdownTemplate"] = nil,
    ["KeybindTemplate"] = nil,
    ["NumberTemplate"] = nil,
    ["ToggleTemplate"] = nil,
    ["SliderTemplate"] = nil
}
local function v_u_46(p40, p41)
    if p40 == p41 then
        return true
    end
    if type(p40) ~= type(p41) then
        return false
    end
    if type(p40) ~= "table" then
        return false
    end
    local v42 = {}
    for v43, v44 in pairs(p40) do
        if not v_u_46(v44, p41[v43]) then
            return false
        end
        v42[v43] = true
    end
    for v45 in pairs(p41) do
        if not v42[v45] then
            return false
        end
    end
    return true
end
local function v_u_50(p47)
    local v48 = v_u_38
    if v_u_30[v48] then
        v_u_30[v48]:Cleanup()
        v_u_30[v48] = nil
    end
    if v48 == "Keybinds" then
        table.clear(v_u_31)
        v_u_26 = nil
    end
    for _, v49 in ipairs(p47:GetChildren()) do
        if v49:IsA("GuiObject") and (v49.Name ~= "Header" and v49.Name ~= "Title") then
            v49:Destroy()
        end
    end
end
local function v_u_61(p_u_51, p_u_52)
    local v_u_53 = p_u_51.Frame
    local v_u_54 = p_u_51.Size
    local v_u_55 = v_u_10.new()
    v_u_55:Add(p_u_51.MouseEnter:Connect(function()
        if not p_u_51:GetAttribute("Selected") then
            if not p_u_52 then
                v_u_4:Create(p_u_51, v_u_19, {
                    ["Size"] = UDim2.new(v_u_54.X.Scale * 0.98, 0, v_u_54.Y.Scale, 0)
                }):Play()
            end
            if p_u_52 and v_u_53 then
                v_u_4:Create(v_u_53, v_u_19, {
                    ["BackgroundTransparency"] = 0.85
                }):Play()
            end
        end
    end), "Disconnect", "HoverEnter")
    v_u_55:Add(p_u_51.MouseLeave:Connect(function()
        if not p_u_51:GetAttribute("Selected") then
            if not p_u_52 then
                v_u_4:Create(p_u_51, v_u_19, {
                    ["Size"] = v_u_54
                }):Play()
            end
            if p_u_52 and v_u_53 then
                v_u_4:Create(v_u_53, v_u_19, {
                    ["BackgroundTransparency"] = 1
                }):Play()
            end
        end
    end), "Disconnect", "HoverLeave")
    v_u_55:Add(p_u_51.MouseButton1Down:Connect(function()
        v_u_4:Create(p_u_51, v_u_19, {
            ["Size"] = UDim2.new(v_u_54.X.Scale * 0.95, 0, v_u_54.Y.Scale, 0)
        }):Play()
    end), "Disconnect", "MouseDown")
    v_u_55:Add(p_u_51.MouseButton1Up:Connect(function()
        local v56 = v_u_4
        local v57 = p_u_51
        local v58 = v_u_19
        local v59 = {}
        local v60
        if p_u_51:GetAttribute("Selected") then
            v60 = v_u_54
        else
            v60 = UDim2.new(v_u_54.X.Scale * 0.98, 0, v_u_54.Y.Scale, 0)
        end
        v59.Size = v60
        v56:Create(v57, v58, v59):Play()
    end), "Disconnect", "MouseUp")
    return function()
        v_u_55:Cleanup()
    end
end
local function v_u_66(p62, p63, p64)
    local v65 = Instance.new("TextLabel")
    v65.Name = ("Category_%*"):format(p62)
    v65.Text = string.upper(p62)
    v65.Font = Enum.Font.GothamBold
    v65.TextSize = 14
    v65.TextColor3 = v_u_22
    v65.TextXAlignment = Enum.TextXAlignment.Left
    v65.TextYAlignment = Enum.TextYAlignment.Bottom
    v65.BackgroundTransparency = 1
    v65.Size = UDim2.new(1, 0, 0, 35)
    v65.LayoutOrder = p64
    v65.Parent = p63
    return v65
end
local function v_u_70(p67, p68)
    if v_u_28.Keybinds and v_u_28.Keybinds[p67] then
        local v69 = v_u_28.Keybinds[p67]:FindFirstChild(p68)
        if v69 and v69.TextBox then
            v69.TextBox.TextColor3 = Color3.fromRGB(255, 90, 90)
        end
    else
        return
    end
end
local function v_u_75(p71, p72)
    if v_u_28.Keybinds and v_u_28.Keybinds[p71] then
        local v73 = v_u_28.Keybinds[p71]:FindFirstChild(p72)
        if v73 and v73.TextBox then
            local v74 = {
                ["TextColor3"] = v_u_21
            }
            v_u_4:Create(v73.TextBox, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v74):Play()
        end
    else
        return
    end
end
local function v_u_88(p76)
    if v_u_28.Keybinds and v_u_28.Keybinds[p76] then
        local v77 = v_u_28.Keybinds[p76]
        local v78 = v77.Parent
        if v78 and v78:IsA("ScrollingFrame") then
            local v79 = v77.AbsolutePosition.Y
            local v80 = v78.AbsolutePosition.Y
            local v81 = v78.AbsoluteSize.Y
            local v82 = v79 - v80 + v78.CanvasPosition.Y
            local v83 = v77.AbsoluteSize.Y
            local v84 = v82 - v81 / 2 + v83 / 2
            local v85 = math.max(0, v84)
            local v86 = v78.CanvasSize.Y.Offset - v81
            local v87 = math.min(v85, v86)
            v_u_4:Create(v78, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                ["CanvasPosition"] = Vector2.new(0, v87)
            }):Play()
        end
    else
        return
    end
end
local function v_u_112(p_u_89, p_u_90, p91, p92)
    local v93
    if v_u_32 then
        local v94 = v_u_32[v_u_25.Keybinds or "Keybinds"]
        if v94 then
            local function v_u_99(p95)
                for v96, v97 in pairs(p95) do
                    if v96 == p_u_89 then
                        return v97
                    end
                    if type(v97) == "table" then
                        local v98 = v_u_99(v97)
                        if v98 ~= nil then
                            return v98
                        end
                    end
                end
                return nil
            end
            v93 = v_u_99(v94)
        else
            v93 = nil
        end
    else
        v93 = nil
    end
    local v100 = v93 or {}
    local v101
    if type(v100) == "table" then
        v101 = v100[p92]
    else
        v101 = nil
    end
    local v102
    if v_u_32 then
        local v103 = v_u_32[v_u_25.Keybinds or "Keybinds"]
        if v103 then
            local function v_u_108(p104)
                for v105, v106 in pairs(p104) do
                    if v105 == p_u_90 then
                        return v106
                    end
                    if type(v106) == "table" then
                        local v107 = v_u_108(v106)
                        if v107 ~= nil then
                            return v107
                        end
                    end
                end
                return nil
            end
            v102 = v_u_108(v103)
        else
            v102 = nil
        end
    else
        v102 = nil
    end
    local v109 = v102 or {}
    local v110 = type(v109) ~= "table" and {} or v109
    v110[p92] = v101 or ""
    v_u_1.SettingChanged("Keybinds", p_u_90, v110)
    if p91 ~= "" and p91 ~= "None" then
        v_u_31[("%*:%*"):format(p92, p91)] = nil
    end
    if v101 and (v101 ~= "" and (v101 ~= "" and v101 ~= "None")) then
        v_u_31[("%*:%*"):format(p92, v101)] = p_u_90
    end
    if v_u_28.Keybinds and v_u_28.Keybinds[p_u_90] then
        local v111 = v_u_28.Keybinds[p_u_90]:FindFirstChild(p92)
        if v111 and v111.TextBox then
            v111.TextBox.Text = v101 and v101 ~= "" and (v101:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", "") or "None") or "None"
        end
    end
    v_u_70(p_u_89, p92)
    v_u_70(p_u_90, p92)
    v_u_88(p_u_90)
end
local function v_u_133(p113, p114)
    if v_u_36 then
        local v_u_115 = p113.Parent.Name
        local v116 = p113.Name
        local v117
        if p114 == "" or p114 == "None" then
            v117 = nil
        else
            v117 = v_u_31[("%*:%*"):format(v116, p114)]
            if not v117 or v117 == v_u_115 then
                v117 = nil
            end
        end
        local v118 = v117 ~= nil
        local v119 = v_u_38
        local v120
        if v_u_32 then
            local v121 = v_u_32[v_u_25[v119] or v119]
            if v121 then
                local function v_u_126(p122)
                    for v123, v124 in pairs(p122) do
                        if v123 == v_u_115 then
                            return v124
                        end
                        if type(v124) == "table" then
                            local v125 = v_u_126(v124)
                            if v125 ~= nil then
                                return v125
                            end
                        end
                    end
                    return nil
                end
                v120 = v_u_126(v121)
            else
                v120 = nil
            end
        else
            v120 = nil
        end
        local v127 = v120 or {}
        local v128 = {
            ["Computer"] = type(v127) ~= "table" and "" or v127.Computer,
            ["Console"] = type(v127) ~= "table" and "" or v127.Console
        }
        local v129 = v128[v116]
        if v129 and (v129 ~= "" and (v129 ~= "" and v129 ~= "None")) then
            v_u_31[("%*:%*"):format(v116, v129)] = nil
        end
        v128[v116] = p114
        if p114 ~= "" and p114 ~= "None" then
            v_u_31[("%*:%*"):format(v116, p114)] = v_u_115
        end
        v_u_36.Text = p114:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", "")
        local v130 = p113:FindFirstChild("Reset")
        if v130 then
            v130.Visible = true
        end
        if v118 then
            v_u_36.TextColor3 = Color3.fromRGB(255, 90, 90)
        else
            v_u_36.TextColor3 = v_u_21
            v_u_75(v_u_115, v116)
        end
        v_u_1.SettingChanged(v_u_38, v_u_115, v128, false, v118)
        if v118 and v117 then
            v_u_112(v_u_115, v117, p114, v116)
        end
        v_u_36:ReleaseFocus()
        v_u_33 = nil
        v_u_36 = nil
        if v_u_38 == "Keybinds" then
            local v131 = v_u_34.Options:FindFirstChild("Keybinds")
            local v132 = v131 and v131.Container
            if v132 then
                v132.ScrollingEnabled = true
            end
        end
    end
end
local function v_u_138(p134, p135, p136)
    local v137 = v_u_27
    table.insert(v137, {
        ["path"] = p134,
        ["oldValue"] = p135,
        ["newValue"] = p136
    })
    while #v_u_27 > 50 do
        table.remove(v_u_27, 1)
    end
end
function v_u_1.RenderPage(p139)
    if not v_u_12.GetPage(p139) then
        warn((("[Settings] Page \'%*\' not found in configuration"):format(p139)))
        return
    end
    local v140 = v_u_34.Options:FindFirstChild(p139)
    if not v140 then
        warn((("[Settings] Page frame \'%*\' not found in UI"):format(p139)))
        return
    end
    local v_u_141 = v140.Container
    v_u_50(v_u_141)
    local v142 = v_u_141:FindFirstChild("Header")
    if v142 then
        v142.Text = string.upper(p139) .. " SETTINGS"
    end
    local v143 = v_u_141:FindFirstChild("Title")
    if v143 then
        v143.Text = v_u_12.Descriptions[p139] or ""
    end
    local v144 = v_u_12.GetCategories(p139)
    if p139 == "Keybinds" then
        table.sort(v144, function(p145, p146)
            return (table.find(v_u_23, p145) or 999) < (table.find(v_u_23, p146) or 999)
        end)
    elseif p139 == "Game" then
        table.sort(v144, function(p147, p148)
            return (table.find(v_u_24, p147) or 999) < (table.find(v_u_24, p148) or 999)
        end)
    end
    v_u_28[p139] = {}
    if not v_u_30[p139] then
        v_u_30[p139] = v_u_10.new()
    end
    local v149 = 0
    for _, v150 in ipairs(v144) do
        v_u_66(v150, v_u_141, v149)
        v149 = v149 + 1
        local v151 = v_u_12.GetCategory(p139, v150)
        local v152 = {}
        for v153, v154 in pairs(v151) do
            if not v153:match("^_Divider_") then
                table.insert(v152, {
                    ["name"] = v153,
                    ["config"] = v154
                })
            end
        end
        table.sort(v152, function(p155, p156)
            local v157 = p155.config.Order or 999
            local v158 = p156.config.Order or 999
            if v157 == v158 then
                return p155.name < p156.name
            else
                return v157 < v158
            end
        end)
        for _, v159 in ipairs(v152) do
            local v160 = v159.config
            local v_u_161 = v159.name
            local v162 = nil
            local v163 = nil
            if v160.Platform then
                local v164 = v_u_9()
                if table.find(v164, v160.Platform) ~= nil then
                    goto l24
                end
            else
                ::l24::
                v_u_29[v_u_161] = {
                    ["pageName"] = p139,
                    ["categoryName"] = v150,
                    ["settingName"] = v_u_161,
                    ["settingPath"] = ("Settings.%*.%*.%*"):format(v_u_25[p139] or p139, v150, v_u_161)
                }
                if v160.Type ~= "CrosshairPreview" then
                    if v160.Type == "Toggle" then
                        local v165 = v_u_39.ToggleTemplate
                        assert(v165, "ToggleTemplate not loaded")
                        v162 = v_u_39.ToggleTemplate:Clone()
                        local v166 = v_u_38
                        local v167
                        if v_u_32 then
                            local v168 = v_u_32[v_u_25[v166] or v166]
                            if v168 then
                                local function v_u_173(p169)
                                    for v170, v171 in pairs(p169) do
                                        if v170 == v_u_161 then
                                            return v171
                                        end
                                        if type(v171) == "table" then
                                            local v172 = v_u_173(v171)
                                            if v172 ~= nil then
                                                return v172
                                            end
                                        end
                                    end
                                    return nil
                                end
                                v167 = v_u_173(v168)
                            else
                                v167 = nil
                            end
                        else
                            v167 = nil
                        end
                        if v167 == nil then
                            v167 = v160.Default
                        end
                        v163 = v_u_17(v_u_161, v160, v_u_141, v149, v162, v167, v_u_1.SettingChanged, v_u_38)
                        v149 = v149 + 1
                    elseif v160.Type == "Number" then
                        local v174 = v_u_39.NumberTemplate
                        assert(v174, "NumberTemplate not loaded")
                        v162 = v_u_39.NumberTemplate:Clone()
                        local v175 = v_u_38
                        local v176
                        if v_u_32 then
                            local v177 = v_u_32[v_u_25[v175] or v175]
                            if v177 then
                                local function v_u_182(p178)
                                    for v179, v180 in pairs(p178) do
                                        if v179 == v_u_161 then
                                            return v180
                                        end
                                        if type(v180) == "table" then
                                            local v181 = v_u_182(v180)
                                            if v181 ~= nil then
                                                return v181
                                            end
                                        end
                                    end
                                    return nil
                                end
                                v176 = v_u_182(v177)
                            else
                                v176 = nil
                            end
                        else
                            v176 = nil
                        end
                        local v183 = v176 or v160.Default
                        v163 = v_u_16(v_u_161, v160, v_u_141, v149, v162, tonumber(v183) or v160.Default, v_u_1.SettingChanged, v_u_38)
                        v149 = v149 + 1
                    elseif v160.Type == "Slider" then
                        local v184 = v_u_39.SliderTemplate
                        assert(v184, "SliderTemplate not loaded")
                        v162 = v_u_39.SliderTemplate:Clone()
                        local v185 = nil
                        local v186
                        if v160.HasEnabledToggle then
                            local v187 = v_u_38
                            local v188
                            if v_u_32 then
                                local v189 = v_u_32[v_u_25[v187] or v187]
                                if v189 then
                                    local function v_u_194(p190)
                                        for v191, v192 in pairs(p190) do
                                            if v191 == v_u_161 then
                                                return v192
                                            end
                                            if type(v192) == "table" then
                                                local v193 = v_u_194(v192)
                                                if v193 ~= nil then
                                                    return v193
                                                end
                                            end
                                        end
                                        return nil
                                    end
                                    v188 = v_u_194(v189)
                                else
                                    v188 = nil
                                end
                            else
                                v188 = nil
                            end
                            if type(v188) == "table" then
                                local v195 = v188.Value
                                v186 = tonumber(v195) or v160.Default
                                v185 = v188.Enabled
                                if v185 == nil then
                                    if v160.DefaultEnabled == nil then
                                        v185 = true
                                    else
                                        v185 = v160.DefaultEnabled
                                    end
                                end
                            else
                                v186 = tonumber(v188) or v160.Default
                                if v160.DefaultEnabled == nil then
                                    v185 = true
                                else
                                    v185 = v160.DefaultEnabled
                                end
                            end
                        else
                            local v196 = v_u_38
                            local v197
                            if v_u_32 then
                                local v198 = v_u_32[v_u_25[v196] or v196]
                                if v198 then
                                    local function v_u_203(p199)
                                        for v200, v201 in pairs(p199) do
                                            if v200 == v_u_161 then
                                                return v201
                                            end
                                            if type(v201) == "table" then
                                                local v202 = v_u_203(v201)
                                                if v202 ~= nil then
                                                    return v202
                                                end
                                            end
                                        end
                                        return nil
                                    end
                                    v197 = v_u_203(v198)
                                else
                                    v197 = nil
                                end
                            else
                                v197 = nil
                            end
                            local v204 = v197 or v160.Default
                            v186 = tonumber(v204) or v160.Default
                        end
                        v163 = v_u_18(v_u_161, v160, v_u_141, v149, v162, v186, v185, v_u_1.SettingChanged, v_u_38)
                        v149 = v149 + 1
                    elseif v160.Type == "Dropdown" then
                        local v205 = v_u_39.DropdownTemplate
                        assert(v205, "DropdownTemplate not loaded")
                        v162 = v_u_39.DropdownTemplate:Clone()
                        local v206 = v_u_38
                        local v207
                        if v_u_32 then
                            local v208 = v_u_32[v_u_25[v206] or v206]
                            if v208 then
                                local function v_u_213(p209)
                                    for v210, v211 in pairs(p209) do
                                        if v210 == v_u_161 then
                                            return v211
                                        end
                                        if type(v211) == "table" then
                                            local v212 = v_u_213(v211)
                                            if v212 ~= nil then
                                                return v212
                                            end
                                        end
                                    end
                                    return nil
                                end
                                v207 = v_u_213(v208)
                            else
                                v207 = nil
                            end
                        else
                            v207 = nil
                        end
                        v163 = v_u_14(v_u_161, v160, v_u_141, v149, v162, v207 or v160.Default, v_u_1.SettingChanged, v_u_38, v_u_7, function()
                            return v_u_35
                        end, function(p214)
                            v_u_35 = p214
                        end)
                        v149 = v149 + 1
                    elseif v160.Type == "Keybind" then
                        local v215 = v_u_39.KeybindTemplate
                        assert(v215, "KeybindTemplate not loaded")
                        v162 = v_u_39.KeybindTemplate:Clone()
                        local v216 = v_u_38
                        local v217
                        if v_u_32 then
                            local v218 = v_u_32[v_u_25[v216] or v216]
                            if v218 then
                                local function v_u_223(p219)
                                    for v220, v221 in pairs(p219) do
                                        if v220 == v_u_161 then
                                            return v221
                                        end
                                        if type(v221) == "table" then
                                            local v222 = v_u_223(v221)
                                            if v222 ~= nil then
                                                return v222
                                            end
                                        end
                                    end
                                    return nil
                                end
                                v217 = v_u_223(v218)
                            else
                                v217 = nil
                            end
                        else
                            v217 = nil
                        end
                        local v224 = v217 or {}
                        if type(v224) == "table" then
                            for _, v225 in ipairs({ "Computer", "Console" }) do
                                local v226 = v224[v225]
                                if v226 and v226 ~= "" then
                                    local v227
                                    if v226 == "" or v226 == "None" then
                                        v227 = nil
                                    else
                                        v227 = v_u_31[("%*:%*"):format(v225, v226)]
                                        if not v227 or v227 == v_u_161 then
                                            v227 = nil
                                        end
                                    end
                                    if v227 then
                                        if not v_u_26 then
                                            v_u_26 = {}
                                        end
                                        local v228 = v_u_26
                                        if not v228[v225] then
                                            v228[v225] = {}
                                        end
                                        local v229 = v228[v225]
                                        table.insert(v229, {
                                            ["action"] = v_u_161,
                                            ["keybind"] = v226
                                        })
                                        local v230 = v228[v225]
                                        table.insert(v230, {
                                            ["action"] = v227,
                                            ["keybind"] = v226
                                        })
                                    end
                                    if v226 ~= "" then
                                        if v226 ~= "None" then
                                            v_u_31[("%*:%*"):format(v225, v226)] = v_u_161
                                        end
                                    end
                                end
                            end
                        end
                        v163 = v_u_15(v_u_161, v160, v_u_141, v149, v162, v224, v_u_1.SettingChanged, v_u_38, function(p231, p232, p233)
                            v_u_36 = p231
                            v_u_33 = p232
                            v_u_37 = p233
                            p231.Text = "Press a key..."
                            p231.TextColor3 = v_u_22
                            v_u_141.ScrollingEnabled = false
                        end, function(_, _) end)
                        v149 = v149 + 1
                    end
                    goto l32
                end
                if v_u_39.CrosshairPreviewTemplate then
                    v162 = v_u_39.CrosshairPreviewTemplate:Clone()
                    v163 = v_u_13(v_u_141, v149, v162, v_u_34.Share, function()
                        local v234 = v_u_32 and v_u_32.Game
                        if v234 then
                            v234 = v_u_32.Game.Crosshair
                        end
                        return v234
                    end, function() end, function() end, function() end)
                    v149 = v149 + 1
                    ::l32::
                    if v162 then
                        v_u_28[p139][v_u_161] = v162
                    end
                    if v163 then
                        v_u_30[p139]:Add(v163, true, (("Template_%*"):format(v_u_161)))
                    end
                    local v235 = v_u_7:WaitForChild("Divider"):Clone()
                    v235.LayoutOrder = v149
                    v235.Parent = v_u_141
                    v149 = v149 + 1
                else
                    warn("[Settings] CrosshairPreviewTemplate not loaded")
                end
            end
        end
    end
    local v236 = v_u_141:FindFirstChildOfClass("UIListLayout")
    if v236 then
        v_u_141.CanvasSize = UDim2.new(0, 0, 0, v236.AbsoluteContentSize.Y + 50)
    end
    if p139 == "Keybinds" and v_u_26 then
        task.defer(function()
            local v237 = {}
            for v238, v239 in pairs(v_u_26) do
                for _, v240 in ipairs(v239) do
                    local v241 = ("%*:%*"):format(v240.action, v238)
                    if not v237[v241] then
                        v_u_70(v240.action, v238)
                        v237[v241] = true
                    end
                end
            end
            v_u_26 = nil
        end)
    end
end
function v_u_1.Open(p242)
    v_u_38 = p242
    for _, v243 in ipairs(v_u_34.Options:GetChildren()) do
        if v243:IsA("Frame") then
            v243.Visible = false
        end
    end
    local v244 = v_u_34.Options:FindFirstChild(p242)
    if v244 then
        v244.Visible = true
        if not v_u_28[p242] then
            v_u_1.RenderPage(p242)
        end
    end
    for _, v245 in ipairs(v_u_34.Top.List:GetChildren()) do
        if v245:IsA("TextButton") then
            local v246 = v245.Name == p242
            v245:SetAttribute("Selected", v246 and true or nil)
            local v247 = v245.Title
            local v248 = v245.Frame
            if v246 then
                v248.BackgroundColor3 = v_u_20
                v247.TextColor3 = v_u_22
                v248.BackgroundTransparency = 0
            else
                v248.BackgroundColor3 = v_u_21
                v247.TextColor3 = v_u_21
                v248.BackgroundTransparency = 1
            end
        end
    end
end
function v_u_1.SettingChanged(p249, p_u_250, p251, p252, p253)
    if v_u_32 then
        local v254 = v_u_29[p_u_250]
        if not v254 then
            local v255 = v_u_12.GetSetting(p249, p_u_250)
            if not (v255 and v255.Category) then
                warn((("[Settings] Could not find metadata or config for setting: %*"):format(p_u_250)))
                return
            end
            v254 = {
                ["pageName"] = p249,
                ["categoryName"] = v255.Category,
                ["settingName"] = p_u_250
            }
            local v256 = v255.Category
            v254.settingPath = ("Settings.%*.%*.%*"):format(v_u_25[p249] or p249, v256, p_u_250)
        end
        local v257 = v254.settingPath
        if p252 then
            return
        else
            local v258
            if v_u_32 then
                local v259 = v_u_32[v_u_25[p249] or p249]
                if v259 then
                    local function v_u_264(p260)
                        for v261, v262 in pairs(p260) do
                            if v261 == p_u_250 then
                                return v262
                            end
                            if type(v262) == "table" then
                                local v263 = v_u_264(v262)
                                if v263 ~= nil then
                                    return v263
                                end
                            end
                        end
                        return nil
                    end
                    v258 = v_u_264(v259)
                else
                    v258 = nil
                end
            else
                v258 = nil
            end
            if not v_u_46(v258, p251) or p253 then
                local v265 = v_u_32
                local v266 = v_u_25[p249] or p249
                if not v265[v266] then
                    v265[v266] = {}
                end
                local v267 = v265[v266]
                if not v267[v254.categoryName] then
                    v267[v254.categoryName] = {}
                end
                v267[v254.categoryName][p_u_250] = p251
                if p249 == "Keybinds" and type(p251) == "table" then
                    for _, v_u_268 in ipairs({ "Computer", "Console" }) do
                        local v269 = p251[v_u_268]
                        if v269 and v269 ~= "" then
                            local v270
                            if v269 == "" or v269 == "None" then
                                v270 = nil
                            else
                                v270 = v_u_31[("%*:%*"):format(v_u_268, v269)]
                                if not v270 or v270 == p_u_250 then
                                    v270 = nil
                                end
                            end
                            if not v270 then
                                task.defer(function()
                                    v_u_75(p_u_250, v_u_268)
                                end)
                            end
                        else
                            task.defer(function()
                                v_u_75(p_u_250, v_u_268)
                            end)
                        end
                    end
                end
                v_u_138(v257, v258, p251)
                v_u_11.Player.UpdatePlayerSettings.Send({
                    ["Path"] = v257,
                    ["Value"] = p251
                })
            end
        end
    else
        warn("[Settings] CurrentSettings is nil")
        return
    end
end
function v_u_1.UpdateSettings(p271)
    v_u_32 = p271
    if v_u_38 and v_u_28[v_u_38] then
        v_u_1.RenderPage(v_u_38)
    end
end
function v_u_1.ResetCrosshair()
    local v272 = {
        ["Crosshair Style"] = "Classic",
        ["Crosshair Image"] = 0,
        ["Follow Recoil"] = true,
        ["Center Dot"] = true,
        ["T Style"] = false,
        ["Red"] = 0,
        ["Green"] = 255,
        ["Blue"] = 0,
        ["Length"] = 5,
        ["Thickness"] = 1,
        ["Gap"] = 0,
        ["Outline"] = {
            ["Enabled"] = true,
            ["Value"] = 1
        },
        ["Alpha"] = {
            ["Enabled"] = false,
            ["Value"] = 200
        },
        ["Friendly Fire Reticle Warning"] = true,
        ["Use Crosshair Color for Scope Dot"] = true,
        ["Show my crosshair when spectating bots"] = false,
        ["Show Player Crosshairs"] = false
    }
    for v273, v274 in pairs(v272) do
        v_u_1.SettingChanged("Game", v273, v274)
    end
    v_u_1.RenderPage("Game")
end
function v_u_1.ShareCrosshair()
    if v_u_32 and (v_u_32.Game and v_u_32.Game.Crosshair) then
        local v_u_275 = game:GetService("HttpService")
        local v_u_276 = v_u_32.Game.Crosshair
        local v277, v278 = pcall(function()
            return v_u_275:JSONEncode(v_u_276)
        end)
        if v277 and v278 then
            v_u_34.Share.Visible = true
            v_u_34.Share.TextBox.Text = v278
            v_u_34.Share.TextBox:CaptureFocus()
            v_u_34.Share.TextBox.CursorPosition = #v278 + 1
        else
            warn("[Settings] Failed to encode crosshair settings:", v278)
        end
    else
        warn("[Settings] No crosshair settings to share")
        return
    end
end
function v_u_1.ImportCrosshair(p_u_279)
    local v_u_280 = game:GetService("HttpService")
    local v281, v282 = pcall(function()
        return v_u_280:JSONDecode(p_u_279)
    end)
    if v281 and (v282 and type(v282) == "table") then
        for v283, v284 in pairs(v282) do
            v_u_1.SettingChanged("Game", v283, v284)
        end
        v_u_1.RenderPage("Game")
        v_u_34.Share.Visible = false
    else
        warn("[Settings] Failed to import crosshair settings - invalid code")
    end
end
function v_u_1.ResetPage(p285)
    local v286 = v_u_12.GetPage(p285)
    if v286 then
        for v287, v288 in pairs(v286) do
            if not v287:match("^_Divider_") and v288.Default ~= nil then
                local v289 = v288.Default
                local v290 = v288.HasEnabledToggle and {
                    ["Enabled"] = v288.DefaultEnabled or false,
                    ["Value"] = v288.Default
                } or v289
                v_u_1.SettingChanged(p285, v287, v290)
            end
        end
        v_u_1.RenderPage(p285)
    else
        warn((("[Settings] Page \'%*\' not found"):format(p285)))
    end
end
function v_u_1.UndoLastChange()
    if #v_u_27 == 0 then
        warn("[Settings] No changes to undo")
        return
    else
        local v291 = table.remove(v_u_27)
        if v291 then
            v_u_11.Player.UpdatePlayerSettings.Send({
                ["Path"] = v291.path,
                ["Value"] = v291.oldValue
            })
            local v292 = string.split(v291.path, ".")
            if #v292 >= 3 then
                local v293 = v_u_32
                for v294 = 2, #v292 - 1 do
                    local v295 = v292[v294]
                    if not v293[v295] then
                        return
                    end
                    v293 = v293[v295]
                end
                v293[v292[#v292]] = v291.oldValue
            end
            if v_u_38 then
                v_u_1.RenderPage(v_u_38)
            end
        end
    end
end
function v_u_1.Initialize(_, p296)
    v_u_34 = p296
    v_u_39.CrosshairPreviewTemplate = v_u_7:WaitForChild("CrosshairPreviewTemplate")
    v_u_39.ToggleTemplate = v_u_7:WaitForChild("ToggleTemplate")
    v_u_39.DropdownTemplate = v_u_7:WaitForChild("DropdownTemplate")
    v_u_39.NumberTemplate = v_u_7:WaitForChild("NumberTemplate")
    v_u_39.SliderTemplate = v_u_7:WaitForChild("SliderTemplate")
    v_u_39.KeybindTemplate = v_u_7:WaitForChild("KeybindTemplate")
    for _, v_u_297 in ipairs(v_u_34.Top.List:GetChildren()) do
        if v_u_297:IsA("TextButton") then
            v_u_61(v_u_297, true)
            v_u_297.MouseButton1Click:Connect(function()
                v_u_1.Open(v_u_297.Name)
            end)
        end
    end
    if v_u_34.Reset and v_u_34.Reset.Button then
        v_u_34.Reset.Button.MouseButton1Click:Connect(function()
            v_u_1.ResetPage(v_u_38)
        end)
    end
    if v_u_34.Share then
        v_u_34.Share.Visible = false
        v_u_34.Share.List.Cancel.MouseButton1Click:Connect(function()
            v_u_34.Share.Visible = false
        end)
        v_u_34.Share.List.Copy.MouseButton1Click:Connect(function()
            v_u_34.Share.TextBox:CaptureFocus()
            v_u_34.Share.TextBox.CursorPosition = #v_u_34.Share.TextBox.Text + 1
        end)
        v_u_34.Share.List.Import.MouseButton1Click:Connect(function()
            v_u_1.ImportCrosshair(v_u_34.Share.TextBox.Text)
        end)
    end
    v_u_3.InputBegan:Connect(function(p298, _)
        if v_u_36 then
            if p298.UserInputState == Enum.UserInputState.Begin then
                if tick() - v_u_37 < 0.1 then
                    return
                elseif v_u_36.Parent then
                    local v299 = v_u_36.Parent
                    local v300 = v299.Name
                    local v301 = ""
                    if v300 == "Computer" then
                        if p298.UserInputType == Enum.UserInputType.Keyboard then
                            if p298.KeyCode == Enum.KeyCode.Escape then
                                if v_u_36 then
                                    v_u_36.Text = v_u_33 or "None"
                                    v_u_36.TextColor3 = v_u_21
                                    v_u_36:ReleaseFocus()
                                    v_u_33 = nil
                                    v_u_36 = nil
                                    if v_u_38 == "Keybinds" then
                                        local v302 = v_u_34.Options:FindFirstChild("Keybinds")
                                        local v303 = v302 and v302.Container
                                        if v303 then
                                            v303.ScrollingEnabled = true
                                        end
                                    end
                                end
                            end
                            v301 = ("Enum.KeyCode.%*"):format(p298.KeyCode.Name)
                        else
                            v301 = p298.UserInputType == Enum.UserInputType.MouseButton1 and "Enum.UserInputType.MouseButton1" or (p298.UserInputType == Enum.UserInputType.MouseButton2 and "Enum.UserInputType.MouseButton2" or (p298.UserInputType == Enum.UserInputType.MouseButton3 and "Enum.UserInputType.MouseButton3" or v301))
                        end
                    elseif v300 == "Console" then
                        if p298.UserInputType == Enum.UserInputType.Keyboard and p298.KeyCode == Enum.KeyCode.Escape then
                            if v_u_36 then
                                v_u_36.Text = v_u_33 or "None"
                                v_u_36.TextColor3 = v_u_21
                                v_u_36:ReleaseFocus()
                                v_u_33 = nil
                                v_u_36 = nil
                                if v_u_38 == "Keybinds" then
                                    local v304 = v_u_34.Options:FindFirstChild("Keybinds")
                                    local v305 = v304 and v304.Container
                                    if v305 then
                                        v305.ScrollingEnabled = true
                                    end
                                end
                            end
                        end
                        if p298.UserInputType == Enum.UserInputType.Gamepad1 then
                            v301 = ("Enum.KeyCode.%*"):format(p298.KeyCode.Name)
                        end
                    end
                    if v301 ~= "" then
                        v_u_133(v299, v301)
                    end
                else
                    v_u_36 = nil
                    v_u_33 = nil
                    if v_u_38 == "Keybinds" then
                        local v306 = v_u_34.Options:FindFirstChild("Keybinds")
                        local v307 = v306 and v306.Container
                        if v307 then
                            v307.ScrollingEnabled = true
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
    v_u_3.InputChanged:Connect(function(p308, _)
        if v_u_36 then
            if p308.UserInputType == Enum.UserInputType.MouseWheel then
                if tick() - v_u_37 < 0.1 then
                    return
                elseif v_u_36.Parent then
                    local v309 = v_u_36.Parent
                    if v309.Name == "Computer" then
                        local v310 = p308.Position.Z
                        if v310 > 0 then
                            v_u_133(v309, "Enum.CustomInputType.ScrollWheelUp")
                        elseif v310 < 0 then
                            v_u_133(v309, "Enum.CustomInputType.ScrollWheelDown")
                        end
                    else
                        return
                    end
                else
                    v_u_33 = nil
                    v_u_36 = nil
                    if v_u_38 == "Keybinds" then
                        local v311 = v_u_34.Options:FindFirstChild("Keybinds")
                        local v312 = v311 and v311.Container
                        if v312 then
                            v312.ScrollingEnabled = true
                        end
                    end
                    return
                end
            else
                return
            end
        else
            return
        end
    end)
    v_u_3.InputBegan:Connect(function(p313, _)
        if p313.UserInputType == Enum.UserInputType.MouseButton1 then
            local v314 = v_u_35
            if v314 and v314.Visible then
                local v315 = p313.Position
                if v314.Parent and v314.Parent.Parent then
                    local v316 = v314.Parent.Parent:FindFirstChild("Options")
                    if v316 then
                        local v317 = v316.Button
                        if v317 then
                            local v318 = v317.AbsolutePosition
                            local v319 = v317.AbsoluteSize
                            local v320 = v314.AbsolutePosition
                            local v321 = v314.AbsoluteSize
                            local v322
                            if v315.X >= v318.X and (v315.X <= v318.X + v319.X and v315.Y >= v318.Y) then
                                v322 = v315.Y <= v318.Y + v319.Y
                            else
                                v322 = false
                            end
                            local v323
                            if v315.X >= v320.X and (v315.X <= v320.X + v321.X and v315.Y >= v320.Y) then
                                v323 = v315.Y <= v320.Y + v321.Y
                            else
                                v323 = false
                            end
                            if not (v322 or v323) then
                                v314.Visible = false
                                v_u_35 = nil
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
    end)
end
function v_u_1.Start()
    v_u_1.Open("Video")
    v_u_8.CreateListener(v_u_6, "Settings", function(p324)
        v_u_1.UpdateSettings(p324)
    end)
end
return v_u_1