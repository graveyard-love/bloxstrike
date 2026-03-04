local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("GuiService")
local v_u_6 = require(v2.Database.Custom.GameStats.UI.Mobile)
local v_u_7 = require(v2.Controllers.DataController)
local v_u_8 = require(v2.Components.Common.InterfaceAnimations.ActivateButton)
local v_u_9 = require(v2.Database.Security.Remotes)
local v_u_10 = require(v2.Database.Security.Router)
local v_u_11 = v3.LocalPlayer
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = false
local v_u_16 = false
local v_u_17 = v_u_6.GetDefaultLayout()
local v_u_18 = v_u_6.GetDefaultLayout()
local v_u_19 = false
local v_u_20 = {}
local v_u_21 = {}
local v_u_22 = nil
local v_u_23 = nil
local function v_u_28(p24)
    local v25 = {}
    for _, v26 in ipairs(v_u_6.REQUIRED_BUTTONS) do
        local v27 = p24[v26] or v_u_6.GetDefaultButtonLayout(v26)
        v25[v26] = {
            ["Position"] = {
                ["X"] = v27.Position.X,
                ["Y"] = v27.Position.Y
            },
            ["Size"] = {
                ["X"] = v27.Size.X,
                ["Y"] = v27.Size.Y
            }
        }
    end
    return v25
end
local function v_u_32()
    local v29 = v_u_13
    if v29 then
        local v30 = v29:FindFirstChild("Holder")
        if v30 and v30:IsA("Frame") then
            local v31 = v30:FindFirstChild("EditMobile")
            if v31 and v31:IsA("Frame") then
                return v31:FindFirstChild("EditMobile")
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
local function v_u_36()
    local v33 = v_u_12
    if v33 then
        local v34 = v33:FindFirstChild("Menu")
        if v34 and v34:IsA("Frame") then
            local v35 = v34:FindFirstChild("Top")
            if v35 and v35:IsA("Frame") then
                return v35
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
local function v_u_43(p37)
    local v38 = v_u_14
    if not (v38 and v38.Parent) then
        v38 = v_u_13
        if v38 then
            local v39 = v38:FindFirstChild("EditMobile")
            if v39 then
                v38 = v39
            elseif v38.Name ~= "EditMobile" then
                v38 = v39
            end
            v_u_14 = v38
        else
            v38 = nil
        end
    end
    local v40
    if v38 then
        v40 = v38:FindFirstChild("MobileButtons")
    else
        v40 = nil
    end
    if v40 then
        local v41 = v40:FindFirstChild(p37)
        local v42 = v_u_18[p37]
        if v41 and v42 then
            v41.Position = UDim2.fromScale(v42.Position.X, v42.Position.Y)
            v41.Size = UDim2.fromScale(v42.Size.X, v42.Size.Y)
        end
    else
        return
    end
end
local function v_u_49(p44, p45)
    for _, v46 in ipairs(v_u_6.REQUIRED_BUTTONS) do
        local v47 = p44[v46] or v_u_6.GetDefaultButtonLayout(v46)
        local v48 = p45[v46] or v_u_6.GetDefaultButtonLayout(v46)
        if v47.Position.X ~= v48.Position.X or (v47.Position.Y ~= v48.Position.Y or (v47.Size.X ~= v48.Size.X or v47.Size.Y ~= v48.Size.Y)) then
            return false
        end
    end
    return true
end
local function v_u_62(p50)
    local v51 = v_u_14
    if not (v51 and v51.Parent) then
        v51 = v_u_13
        if v51 then
            local v52 = v51:FindFirstChild("EditMobile")
            if v52 then
                v51 = v52
            elseif v51.Name ~= "EditMobile" then
                v51 = v52
            end
            v_u_14 = v51
        else
            v51 = nil
        end
    end
    if v51 then
        v51.Visible = p50
        if v51 then
            local v53 = v51:FindFirstChild("Action")
            if v53 and v53:IsA("Frame") then
                v53.Visible = p50
            end
        end
        if v51 then
            local v54 = v51:FindFirstChild("Notification")
            if v54 and v54:IsA("Frame") then
                v54.Visible = p50
            end
        end
        if v51 then
            local v55 = v51:FindFirstChild("MobileButtons")
            if v55 and v55:IsA("Frame") then
                v55.Visible = p50
            end
        end
        if v51 then
            local v56 = v51:FindFirstChild("GameDashboard")
            if v56 and v56:IsA("Frame") then
                v56.Visible = false
            end
        end
    end
    local v57 = v_u_36()
    if v57 then
        v57.Visible = not p50
    end
    local v58 = v_u_13
    local v59
    if v58 then
        v59 = v58:FindFirstChild("Container")
        if not (v59 and v59:IsA("Frame")) then
            v59 = nil
        end
    else
        v59 = nil
    end
    if v59 then
        v59.Visible = not p50
    end
    local v60 = v_u_13
    local v61
    if v60 then
        v61 = v60:FindFirstChild("Holder")
        if not (v61 and v61:IsA("Frame")) then
            v61 = nil
        end
    else
        v61 = nil
    end
    if v61 then
        v61.Visible = not p50
    end
end
local function v_u_83()
    if v_u_19 then
        return
    else
        local v63 = v_u_36()
        local v64 = v_u_13
        local v65
        if v64 then
            v65 = v64:FindFirstChild("Container")
            if not (v65 and v65:IsA("Frame")) then
                v65 = nil
            end
        else
            v65 = nil
        end
        local v66 = v_u_13
        local v67
        if v66 then
            v67 = v66:FindFirstChild("Holder")
            if not (v67 and v67:IsA("Frame")) then
                v67 = nil
            end
        else
            v67 = nil
        end
        if v63 or (v65 or v67) then
            v_u_19 = true
            if v63 then
                v63:GetPropertyChangedSignal("Visible"):Connect(function()
                    if v_u_15 then
                        local v68 = v_u_36()
                        if v68 and v68.Visible then
                            v68.Visible = false
                        end
                        local v69 = v_u_13
                        local v70
                        if v69 then
                            v70 = v69:FindFirstChild("Container")
                            if not (v70 and v70:IsA("Frame")) then
                                v70 = nil
                            end
                        else
                            v70 = nil
                        end
                        if v70 and v70.Visible then
                            v70.Visible = false
                        end
                        local v71 = v_u_13
                        local v72
                        if v71 then
                            v72 = v71:FindFirstChild("Holder")
                            if not (v72 and v72:IsA("Frame")) then
                                v72 = nil
                            end
                        else
                            v72 = nil
                        end
                        if v72 and v72.Visible then
                            v72.Visible = false
                        end
                    end
                end)
            end
            if v65 then
                v65:GetPropertyChangedSignal("Visible"):Connect(function()
                    if v_u_15 then
                        local v73 = v_u_36()
                        if v73 and v73.Visible then
                            v73.Visible = false
                        end
                        local v74 = v_u_13
                        local v75
                        if v74 then
                            v75 = v74:FindFirstChild("Container")
                            if not (v75 and v75:IsA("Frame")) then
                                v75 = nil
                            end
                        else
                            v75 = nil
                        end
                        if v75 and v75.Visible then
                            v75.Visible = false
                        end
                        local v76 = v_u_13
                        local v77
                        if v76 then
                            v77 = v76:FindFirstChild("Holder")
                            if not (v77 and v77:IsA("Frame")) then
                                v77 = nil
                            end
                        else
                            v77 = nil
                        end
                        if v77 and v77.Visible then
                            v77.Visible = false
                        end
                    end
                end)
            end
            if v67 then
                v67:GetPropertyChangedSignal("Visible"):Connect(function()
                    if v_u_15 then
                        local v78 = v_u_36()
                        if v78 and v78.Visible then
                            v78.Visible = false
                        end
                        local v79 = v_u_13
                        local v80
                        if v79 then
                            v80 = v79:FindFirstChild("Container")
                            if not (v80 and v80:IsA("Frame")) then
                                v80 = nil
                            end
                        else
                            v80 = nil
                        end
                        if v80 and v80.Visible then
                            v80.Visible = false
                        end
                        local v81 = v_u_13
                        local v82
                        if v81 then
                            v82 = v81:FindFirstChild("Holder")
                            if not (v82 and v82:IsA("Frame")) then
                                v82 = nil
                            end
                        else
                            v82 = nil
                        end
                        if v82 and v82.Visible then
                            v82.Visible = false
                        end
                    end
                end)
            end
        end
    end
end
local function v_u_88(p84)
    local v85 = v_u_21[p84]
    if not v85 then
        return {}
    end
    local v86 = {}
    for v87 in pairs(v85) do
        table.insert(v86, v87)
    end
    return v86
end
local function v_u_95(p89, p90)
    local v91 = v_u_18[p89]
    if v91 then
        v_u_23 = nil
        local v92 = {
            ["buttonName"] = p89,
            ["input"] = p90
        }
        local v93 = v_u_5:GetGuiInset()
        v92.startPosition = Vector2.new(p90.Position.X - v93.X, p90.Position.Y - v93.Y)
        local v94 = {
            ["Position"] = {
                ["X"] = v91.Position.X,
                ["Y"] = v91.Position.Y
            },
            ["Size"] = {
                ["X"] = v91.Size.X,
                ["Y"] = v91.Size.Y
            }
        }
        v92.startLayout = v94
        v_u_22 = v92
    end
end
local function v_u_111(p96, p97, p98)
    local v99 = v_u_18[p96]
    if v99 then
        local v100 = v_u_14
        if not (v100 and v100.Parent) then
            v100 = v_u_13
            if v100 then
                local v101 = v100:FindFirstChild("EditMobile")
                if v101 then
                    v100 = v101
                elseif v100.Name ~= "EditMobile" then
                    v100 = v101
                end
                v_u_14 = v100
            else
                v100 = nil
            end
        end
        local v102
        if v100 then
            v102 = v100:FindFirstChild("MobileButtons")
        else
            v102 = nil
        end
        if v102 then
            local v103 = v102.AbsoluteSize
            if v103.X > 0 and v103.Y > 0 then
                local v104 = Vector2.new(p97.Position.X, p97.Position.Y)
                local v105 = v102.AbsolutePosition
                local v106 = (Vector2.new(p98.Position.X, p98.Position.Y) - v104).Magnitude
                local v107 = math.max(v106, 1)
                local v108 = Vector2.new((v104.X - v105.X) / v103.X, (v104.Y - v105.Y) / v103.Y)
                local v109 = v99.Size.X <= 0 and 0.5 or (v108.X - v99.Position.X) / v99.Size.X
                local v110 = v99.Size.Y <= 0 and 0.5 or (v108.Y - v99.Position.Y) / v99.Size.Y
                v_u_22 = nil
                v_u_23 = {
                    ["buttonName"] = p96,
                    ["anchorInput"] = p97,
                    ["scaleInput"] = p98,
                    ["anchorLocalScale"] = Vector2.new(math.clamp(v109, 0, 1), (math.clamp(v110, 0, 1))),
                    ["lastDistance"] = v107,
                    ["lastLayout"] = {
                        ["Position"] = {
                            ["X"] = v99.Position.X,
                            ["Y"] = v99.Position.Y
                        },
                        ["Size"] = {
                            ["X"] = v99.Size.X,
                            ["Y"] = v99.Size.Y
                        }
                    }
                }
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_117(p112)
    if v_u_23 and v_u_23.buttonName == p112 then
        return
    end
    local v113 = v_u_88(p112)
    if #v113 <= 0 then
        if v_u_22 and v_u_22.buttonName == p112 then
            v_u_22 = nil
        end
        if v_u_23 and v_u_23.buttonName == p112 then
            v_u_23 = nil
        end
        return
    end
    local v114 = v113[1]
    local v115 = v_u_22
    if v115 and v115.buttonName == p112 then
        for _, v116 in ipairs(v113) do
            if v116 == v115.input then
                v114 = v116
                break
            end
        end
    end
    v_u_95(p112, v114)
end
local function v_u_131(p118)
    local v119 = v_u_22
    if v119 and p118 == v119.input then
        local v120 = v_u_14
        if not (v120 and v120.Parent) then
            v120 = v_u_13
            if v120 then
                local v121 = v120:FindFirstChild("EditMobile")
                if v121 then
                    v120 = v121
                elseif v120.Name ~= "EditMobile" then
                    v120 = v121
                end
                v_u_14 = v120
            else
                v120 = nil
            end
        end
        local v122
        if v120 then
            v122 = v120:FindFirstChild("MobileButtons")
        else
            v122 = nil
        end
        local v123 = v_u_18[v119.buttonName]
        if v122 and v123 then
            local v124 = v122.AbsoluteSize
            if v124.X > 0 and v124.Y > 0 then
                local v125 = v_u_5:GetGuiInset()
                local v126 = Vector2.new(p118.Position.X - v125.X, p118.Position.Y - v125.Y) - v119.startPosition
                local v127 = v126.X / v124.X
                local v128 = v126.Y / v124.Y
                local v129 = v119.buttonName
                local v130 = {
                    ["Position"] = {
                        ["X"] = v119.startLayout.Position.X + v127,
                        ["Y"] = v119.startLayout.Position.Y + v128
                    },
                    ["Size"] = {
                        ["X"] = v123.Size.X,
                        ["Y"] = v123.Size.Y
                    }
                }
                v_u_18[v129] = v_u_6.ClampButtonLayout(v130)
                v_u_43(v129)
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_156(p132)
    local v133 = v_u_23
    if v133 then
        if p132 == v133.scaleInput or p132 == v133.anchorInput then
            local v134 = v133.anchorInput
            local v135 = Vector2.new(v134.Position.X, v134.Position.Y)
            local v136 = v133.scaleInput
            local v137 = Vector2.new(v136.Position.X, v136.Position.Y)
            local v138 = (v137 - v135).Magnitude
            local v139 = math.max(v138, 1)
            local v140 = v133.lastDistance
            local v141 = v139 / math.max(v140, 1)
            local v142 = v133.lastLayout.Size.X * v141
            local v143 = v133.lastLayout.Size.Y * v141
            local v144 = v_u_14
            if not (v144 and v144.Parent) then
                v144 = v_u_13
                if v144 then
                    local v145 = v144:FindFirstChild("EditMobile")
                    if v145 then
                        v144 = v145
                    elseif v144.Name ~= "EditMobile" then
                        v144 = v145
                    end
                    v_u_14 = v144
                else
                    v144 = nil
                end
            end
            local v146
            if v144 then
                v146 = v144:FindFirstChild("MobileButtons")
            else
                v146 = nil
            end
            if v146 then
                local v147 = v146.AbsoluteSize
                if v147.X > 0 and v147.Y > 0 then
                    local v148 = v146.AbsolutePosition
                    local v149 = Vector2.new((v135.X - v148.X) / v147.X, (v135.Y - v148.Y) / v147.Y)
                    local v150 = v149.X - v133.anchorLocalScale.X * v142
                    local v151 = v149.Y - v133.anchorLocalScale.Y * v143
                    if v150 ~= v150 or v151 ~= v151 then
                        local v152 = (v135 + v137) * 0.5
                        local v153 = Vector2.new((v152.X - v148.X) / v147.X, (v152.Y - v148.Y) / v147.Y)
                        v150 = v153.X - v142 / 2
                        v151 = v153.Y - v143 / 2
                    end
                    local v154 = v133.buttonName
                    v_u_18[v154] = v_u_6.ClampButtonLayout({
                        ["Position"] = {
                            ["X"] = v150,
                            ["Y"] = v151
                        },
                        ["Size"] = {
                            ["X"] = v142,
                            ["Y"] = v143
                        }
                    })
                    v_u_43(v154)
                    local v155 = v_u_18[v133.buttonName]
                    if v155 then
                        v133.lastLayout = {
                            ["Position"] = {
                                ["X"] = v155.Position.X,
                                ["Y"] = v155.Position.Y
                            },
                            ["Size"] = {
                                ["X"] = v155.Size.X,
                                ["Y"] = v155.Size.Y
                            }
                        }
                    end
                    v133.lastDistance = v139
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
local function v_u_160()
    if v_u_15 or v_u_16 then
        return
    else
        v_u_16 = true
        local v157 = pcall(function()
            v_u_7.WaitForDataLoaded(v_u_11)
        end)
        v_u_16 = false
        if v157 then
            v_u_20 = {}
            v_u_21 = {}
            v_u_22 = nil
            v_u_23 = nil
            local v158 = v_u_7.Get(v_u_11, "MobileButtons")
            v_u_17 = v_u_6.SanitizeLayout(v158)
            v_u_18 = v_u_28(v_u_17)
            for _, v159 in ipairs(v_u_6.REQUIRED_BUTTONS) do
                v_u_43(v159)
            end
            v_u_15 = true
            v_u_62(true)
        else
            v_u_10.broadcastRouter("CreateMenuNotification", "Error", "Profile data is still loading. Please try again.")
        end
    end
end
local function v_u_166()
    local v161 = v_u_14
    if not (v161 and v161.Parent) then
        v161 = v_u_13
        if v161 then
            local v162 = v161:FindFirstChild("EditMobile")
            if v162 then
                v161 = v162
            elseif v161.Name ~= "EditMobile" then
                v161 = v162
            end
            v_u_14 = v161
        else
            v161 = nil
        end
    end
    if v161 then
        local v163 = v161:FindFirstChild("Notification")
        if v163 then
            local v164 = v163:FindFirstChild("Frame")
            if v164 then
                for _, v165 in ipairs(v164:GetChildren()) do
                    if v165:IsA("Frame") and v165.Name == "SliderTemplate" then
                        v165.Visible = false
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
local function v_u_174()
    local v167 = v_u_14
    if not (v167 and v167.Parent) then
        v167 = v_u_13
        if v167 then
            local v168 = v167:FindFirstChild("EditMobile")
            if v168 then
                v167 = v168
            elseif v167.Name ~= "EditMobile" then
                v167 = v168
            end
            v_u_14 = v167
        else
            v167 = nil
        end
    end
    local v169
    if v167 then
        v169 = v167:FindFirstChild("MobileButtons")
    else
        v169 = nil
    end
    if v169 then
        for _, v170 in ipairs(v169:GetChildren()) do
            if v170:IsA("TextButton") then
                local v_u_171 = v170.Name
                v170.InputBegan:Connect(function(p172)
                    if v_u_15 then
                        if p172.UserInputType == Enum.UserInputType.Touch and p172.UserInputState == Enum.UserInputState.Begin then
                            local v173 = not (v_u_23 and v_u_23.buttonName) and v_u_22
                            if v173 then
                                v173 = v_u_22.buttonName
                            end
                            if not v173 or v173 == v_u_171 then
                                v_u_20[p172] = v_u_171
                                v_u_21[v_u_171] = v_u_21[v_u_171] or {}
                                v_u_21[v_u_171][p172] = true
                                v_u_117(v_u_171)
                            end
                        else
                            return
                        end
                    else
                        return
                    end
                end)
            end
        end
    end
end
local function v_u_176()
    local v175 = v_u_6.SanitizeLayout(v_u_18)
    v_u_18 = v_u_28(v175)
    v_u_17 = v_u_28(v175)
    v_u_9.Player.UpdateMobileButtons.Send({
        ["Layout"] = v175
    })
end
local function v_u_177()
    if v_u_15 then
        v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
        if v_u_49(v_u_6.SanitizeLayout(v_u_18), (v_u_6.SanitizeLayout(v_u_17))) then
            if v_u_15 then
                v_u_15 = false
                v_u_62(false)
                v_u_20 = {}
                v_u_21 = {}
                v_u_22 = nil
                v_u_23 = nil
            end
        else
            v_u_176()
            if v_u_15 then
                v_u_15 = false
                v_u_62(false)
                v_u_20 = {}
                v_u_21 = {}
                v_u_22 = nil
                v_u_23 = nil
            end
        end
    else
        return
    end
end
local function v_u_179()
    if v_u_15 then
        v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_18 = v_u_6.GetDefaultLayout()
        for _, v178 in ipairs(v_u_6.REQUIRED_BUTTONS) do
            v_u_43(v178)
        end
    end
end
local function v_u_181()
    if v_u_15 then
        v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
        if v_u_15 then
            v_u_18 = v_u_28(v_u_17)
            for _, v180 in ipairs(v_u_6.REQUIRED_BUTTONS) do
                v_u_43(v180)
            end
            v_u_15 = false
            v_u_62(false)
            v_u_20 = {}
            v_u_21 = {}
            v_u_22 = nil
            v_u_23 = nil
        end
    else
        return
    end
end
local function v_u_191()
    local v182 = v_u_14
    if not (v182 and v182.Parent) then
        v182 = v_u_13
        if v182 then
            local v183 = v182:FindFirstChild("EditMobile")
            if v183 then
                v182 = v183
            elseif v182.Name ~= "EditMobile" then
                v182 = v183
            end
            v_u_14 = v182
        else
            v182 = nil
        end
    end
    if v182 then
        local v184 = v182:FindFirstChild("Action")
        if v184 and v184:IsA("Frame") then
            local v185 = v_u_177
            local v186 = v184:FindFirstChild("Confirm")
            if v186 and v186:IsA("TextButton") then
                v_u_8(v186)
                v186.MouseButton1Click:Connect(v185)
            end
            local v187 = v_u_179
            local v188 = v184:FindFirstChild("Reset")
            if v188 and v188:IsA("TextButton") then
                v_u_8(v188)
                v188.MouseButton1Click:Connect(v187)
            end
            local v189 = v_u_181
            local v190 = v184:FindFirstChild("Back")
            if v190 and v190:IsA("TextButton") then
                v_u_8(v190)
                v190.MouseButton1Click:Connect(v189)
            end
        end
        v_u_166()
        v_u_174()
    end
end
local function v_u_206()
    v_u_4.LastInputTypeChanged:Connect(function(p192)
        local v193 = v_u_32()
        if v193 then
            v193.Visible = (p192 or v_u_4:GetLastInputType()) == Enum.UserInputType.Touch
        end
    end)
    v_u_4.InputBegan:Connect(function(p194)
        if v_u_15 then
            if p194.UserInputType == Enum.UserInputType.Touch and p194.UserInputState == Enum.UserInputState.Begin then
                local v195 = v_u_22
                if v195 then
                    if v_u_23 then
                        return
                    end
                    if v195.input == p194 then
                        return
                    end
                    v_u_111(v195.buttonName, v195.input, p194)
                end
            end
        else
            return
        end
    end)
    v_u_4.InputChanged:Connect(function(p196)
        if v_u_15 then
            if p196.UserInputType == Enum.UserInputType.Touch then
                if v_u_23 then
                    v_u_156(p196)
                elseif v_u_22 then
                    v_u_131(p196)
                end
            else
                return
            end
        else
            return
        end
    end)
    v_u_4.InputEnded:Connect(function(p197)
        if p197.UserInputType == Enum.UserInputType.Touch then
            local v198 = false
            local v199 = nil
            local v200 = v_u_23
            local v201
            if v200 and (p197 == v200.anchorInput or p197 == v200.scaleInput) then
                v201 = v200.buttonName
                if p197 == v200.scaleInput then
                    v199 = v200.anchorInput
                    v198 = true
                end
                v_u_23 = nil
            else
                v201 = nil
            end
            local v202 = v_u_20[p197]
            if v202 then
                v_u_20[p197] = nil
                local v203 = v_u_21[v202]
                if v203 then
                    v203[p197] = nil
                    if next(v203) == nil then
                        v_u_21[v202] = nil
                    end
                end
            else
                v202 = nil
            end
            local v204 = v_u_22
            if v204 and p197 == v204.input then
                v_u_22 = nil
            end
            local v205 = v202 or v201
            if v198 and (v199 and (v205 and v_u_20[v199] == v205)) then
                v_u_95(v205, v199)
            end
            if v205 then
                v_u_117(v205)
            end
        end
    end)
end
function v1.Initialize(p207, p208)
    v_u_12 = p207
    local v209 = p208:FindFirstChild("EditMobile")
    local v210
    if p208.Name == "EditMobile" then
        v210 = p208.Parent
        if v210 then
            if not v210:IsA("Frame") then
                v210 = p208
            end
        else
            v210 = p208
        end
    else
        v210 = p208
        p208 = v209
    end
    v_u_13 = v210
    v_u_14 = p208
    v_u_83()
    v_u_62(false)
    local v211 = v_u_4:GetLastInputType()
    local v212 = v_u_32()
    if v212 then
        v212.Visible = (v211 or v_u_4:GetLastInputType()) == Enum.UserInputType.Touch
    end
    local v213 = v_u_32()
    if v213 then
        v_u_8(v213)
        v213.MouseButton1Click:Connect(function()
            v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
            v_u_160()
        end)
    end
    v_u_191()
    v_u_206()
end
function v1.Start() end
v1.PointerPath = "Dashboard/EditMobile"
return v1