local v_u_1 = {}
local v_u_2 = game:GetService("MarketplaceService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("CollectionService")
local v_u_5 = game:GetService("PolicyService")
local v_u_6 = game:GetService("TweenService")
local v_u_7 = game:GetService("HttpService")
local v_u_8 = game:GetService("RunService")
local v_u_9 = game:GetService("Players")
require(v_u_3.Database.Custom.Types)
local v_u_10 = require(v_u_3.Database.Custom.Constants)
local v_u_11 = require(v_u_3.Controllers.DataController)
local v_u_12 = require(v_u_3.Controllers.CaseSceneController)
local v_u_13 = require(v_u_3.Components.Common.InterfaceAnimations.ActivateButton)
require(v_u_3.Components.Common.GetWeaponProperties)
local v_u_14 = require(v_u_3.Components.Common.GetUserPlatform)
local v_u_15 = require(v_u_3.Database.Components.Libraries.Bundles)
local v_u_16 = require(v_u_3.Database.Components.Libraries.Skins)
local v_u_17 = require(v_u_3.Database.Components.Libraries.Cases)
local v_u_18 = require(v_u_3.Shared.CloseButtonRegistry)
local v_u_19 = require(v_u_3.Database.Security.Remotes)
local v_u_20 = require(v_u_3.Database.Security.Router)
local v_u_21 = require(v_u_3.Interface.MenuState)
local v_u_22 = require(v_u_3.Packages.Observers)
local v23 = require(v_u_3.Shared.Spring)
local v_u_24 = require(v_u_3.Database.Custom.GameStats.Monetization.DevProducts)
local v_u_25 = require(v_u_3.Database.Custom.GameStats.Monetization.Gamepasses)
local v_u_26 = require(v_u_3.Database.Custom.GameStats.Rarities)
local v_u_27 = v23.new(1, 8, 0)
local v_u_28 = v_u_9.LocalPlayer
local v_u_29 = -1
local v_u_30 = true
local v_u_31 = 0
local v_u_32 = 0
local v_u_33 = nil
local v_u_34 = nil
local v_u_35 = Color3.fromRGB(243, 243, 243)
local v_u_36 = Color3.fromRGB(125, 206, 243)
local v_u_37 = Color3.fromRGB(100, 168, 195)
local v_u_38 = Color3.fromRGB(53, 83, 99)
local v_u_39 = Color3.fromRGB(127, 143, 144)
local v_u_40 = {
    ["AWP"] = {
        ["productName"] = "AWP | High Octane",
        ["weaponName"] = "AWP",
        ["skinName"] = "High Octane"
    },
    ["MP-9"] = {
        ["productName"] = "MP9 | High Octane",
        ["weaponName"] = "MP9",
        ["skinName"] = "High Octane"
    },
    ["DESERT EAGLE"] = {
        ["productName"] = "Desert Eagle | High Octane",
        ["weaponName"] = "Desert Eagle",
        ["skinName"] = "High Octane"
    }
}
local v_u_41 = {
    ["chrysalis"] = "rbxassetid://127888213250008"
}
local v_u_42 = {
    ["Blue"] = 1,
    ["Purple"] = 2,
    ["Pink"] = 3,
    ["Red"] = 4,
    ["Special"] = 5
}
local v_u_43 = nil
local v_u_44 = nil
local v_u_45 = {
    ["isOpening"] = false,
    ["isPendingOpenRequest"] = false,
    ["isQuickUnlock"] = false,
    ["currentTween"] = nil,
    ["currentZoomTween"] = nil,
    ["renderConnection"] = nil,
    ["viewportConnection"] = nil,
    ["currentInventoryItem"] = nil,
    ["currentCaseIdentifier"] = nil,
    ["pendingOpenRequestId"] = nil,
    ["progressRightTween"] = nil,
    ["progressLeftTween"] = nil,
    ["progressRightProxy"] = nil,
    ["progressLeftProxy"] = nil
}
local v_u_46 = {
    ["Special"] = "Drop Gold",
    ["Red"] = "Drop Red",
    ["Pink"] = "Drop Pink",
    ["Purple"] = "Drop Purple",
    ["Blue"] = "Drop Blue"
}
local v_u_47 = {
    ["inventoryItems"] = nil,
    ["bulkIdentifier"] = nil,
    ["caseId"] = nil,
    ["isBulkOpening"] = false,
    ["currentIndex"] = 0,
    ["skipped"] = false,
    ["total"] = 0
}
local function v_u_48(...) end
local function v_u_52(p49, p50)
    for _, v51 in ipairs(p49:GetChildren()) do
        if not table.find(p50, v51.Name) then
            v51:Destroy()
        end
    end
end
local function v_u_56(p53, p54)
    for _, v55 in ipairs(p54) do
        if not p53 then
            return nil
        end
        p53 = p53:FindFirstChild(v55)
    end
    return p53
end
local function v_u_61(p57)
    local v58 = v_u_56(p57, {
        "Content",
        "FullBundle",
        "Content",
        "Buy"
    })
    local v59
    if v58 then
        v59 = v58:FindFirstChild("Gift")
    else
        v59 = v58
    end
    if not (v59 and v59:IsA("GuiButton")) then
        v59 = nil
    end
    if v58 then
        v58 = v58:FindFirstChild("Purchase")
    end
    if not (v58 and v58:IsA("GuiButton")) then
        v58 = nil
    end
    if not v59 then
        v59 = p57:FindFirstChild("Gift")
        if not (v59 and v59:IsA("GuiButton")) then
            v59 = nil
        end
    end
    if not v58 then
        local v60 = p57:FindFirstChild("Purchase")
        if v60 and v60:IsA("GuiButton") then
            return v59, v60
        end
        v58 = nil
    end
    return v59, v58
end
local function v_u_67(p62, p63)
    local v_u_64 = v_u_7:GenerateGUID(false)
    v_u_43.CreatorCode:SetAttribute("ResponseId", v_u_64)
    v_u_43.CreatorCode.Container.Body.Response.Text = p63
    local v65 = v_u_43.CreatorCode.Container.Body.Response
    local v66 = p62 == "Success" and Color3.fromRGB(86, 228, 21)
    if not v66 then
        if p62 == "Error" then
            v66 = Color3.fromRGB(232, 59, 82)
        else
            v66 = false
        end
    end
    v65.TextColor3 = v66
    task.delay(5, function()
        if v_u_43.CreatorCode:GetAttribute("ResponseId") == v_u_64 then
            v_u_43.CreatorCode.Container.Body.Response.Text = ""
        end
    end)
end
local function v_u_73(p68)
    local v69 = p68:FindFirstChild("Purchase")
    if not (v69 and v69:IsA("GuiButton")) then
        v69 = nil
    end
    local v70 = p68:FindFirstChild("Gift")
    if not (v70 and v70:IsA("GuiButton")) then
        v70 = nil
    end
    local v71 = p68:FindFirstChild("Inspect")
    if not (v71 and v71:IsA("GuiButton")) then
        v71 = nil
    end
    local v72 = v_u_56(p68, { "Footer", "Action" })
    if v72 then
        if not v69 then
            v69 = v72:FindFirstChild("Purchase")
            if not (v69 and v69:IsA("GuiButton")) then
                v69 = nil
            end
            if not v69 then
                v69 = v72:FindFirstChild("Buy")
                if not (v69 and v69:IsA("GuiButton")) then
                    v69 = nil
                end
            end
        end
        if not v70 then
            v70 = v72:FindFirstChild("Gift")
            if not (v70 and v70:IsA("GuiButton")) then
                v70 = nil
            end
        end
    end
    return v70, v69, v71
end
local function v_u_74()
    if v_u_45.currentTween then
        v_u_45.currentTween:Cancel()
        v_u_45.currentTween = nil
    end
    if v_u_45.currentZoomTween then
        v_u_45.currentZoomTween:Cancel()
        v_u_45.currentZoomTween = nil
    end
    if v_u_45.renderConnection then
        v_u_45.renderConnection:Disconnect()
        v_u_45.renderConnection = nil
    end
    if v_u_45.viewportConnection then
        v_u_45.viewportConnection:Disconnect()
        v_u_45.viewportConnection = nil
    end
end
local function v_u_93(p_u_75)
    local v76 = workspace:GetServerTimeNow()
    local v77 = math.floor(v76)
    local v78 = nil
    local v79 = typeof(p_u_75) == "number" or tonumber(p_u_75)
    if v79 then
        v78 = v79
    else
        local v80, v81 = pcall(function()
            return DateTime.fromIsoDate(p_u_75)
        end)
        if v80 and v81 then
            v78 = v81.UnixTimestamp
        end
    end
    if not v78 then
        return "00:00:00:00"
    end
    local v82
    if v78 > 10000000000 then
        local v83 = v78 / 1000
        v82 = math.floor(v83)
    else
        v82 = math.floor(v78)
    end
    local v84 = v82 - v77
    if v84 <= 0 then
        return "00:00:00:00"
    end
    local v85 = string.format
    local v86 = v84 / 86400
    local v87 = math.floor(v86)
    local v88 = v84 % 86400 / 3600
    local v89 = math.floor(v88)
    local v90 = v84 % 3600 / 60
    local v91 = math.floor(v90)
    local v92 = v84 % 60
    return v85("%02d:%02d:%02d:%02d", v87, v89, v91, (math.floor(v92)))
end
local function v_u_105(p_u_94)
    local v_u_95 = p_u_94.Size
    p_u_94.MouseEnter:Connect(function()
        local v96 = v_u_6
        local v97 = p_u_94
        local v98 = TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut)
        local v99 = {}
        local v100 = v_u_95
        v99.Size = UDim2.fromScale(v100.X.Scale * 0.9, v100.Y.Scale * 0.9)
        v96:Create(v97, v98, v99):Play()
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Highlight")
        if p_u_94.Name ~= "Credits" and not p_u_94:GetAttribute("Selected") then
            local v101 = {
                ["BackgroundTransparency"] = 0.8,
                ["BackgroundColor3"] = v_u_39
            }
            v_u_6:Create(p_u_94.HoverFrame, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), v101):Play()
            local v102 = {
                ["TextColor3"] = v_u_37
            }
            v_u_6:Create(p_u_94.TextLabel, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), v102):Play()
        end
    end)
    p_u_94.MouseLeave:Connect(function()
        local v103 = {
            ["Size"] = v_u_95
        }
        v_u_6:Create(p_u_94, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), v103):Play()
        if p_u_94.Name ~= "Credits" and not p_u_94:GetAttribute("Selected") then
            local v104 = {
                ["TextColor3"] = v_u_35
            }
            v_u_6:Create(p_u_94.TextLabel, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), v104):Play()
            v_u_6:Create(p_u_94.HoverFrame, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
                ["BackgroundTransparency"] = 1
            }):Play()
        end
    end)
    p_u_94.MouseButton1Click:Connect(function()
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
    end)
end
local function v_u_113(p106)
    local v107 = 0
    for _, v108 in ipairs(p106.contents) do
        v107 = v107 + v108.weight
    end
    local v109 = math.random() * v107
    local v110 = 0
    for _, v111 in ipairs(p106.contents) do
        v110 = v110 + v111.weight
        if v109 <= v110 then
            return v111, v111.isSpecial or false
        end
    end
    local v112 = p106.contents[1]
    return v112, v112.isSpecial or false
end
local function v_u_122(p114, p115, p116, p117)
    local v118 = {}
    for v119 = 1, 75 do
        if v119 == p116 then
            table.insert(v118, {
                ["item"] = p115,
                ["isGold"] = p117
            })
        else
            local v120, v121 = v_u_113(p114)
            table.insert(v118, {
                ["item"] = v120,
                ["isGold"] = v121
            })
        end
    end
    return v118
end
local function v_u_139(p123, p124, p125, p126)
    local v127 = v_u_3.Assets.UI.Store.CaseScroll
    local v128
    if p124.isGold then
        v128 = v127:FindFirstChild("GoldTemplate")
    else
        v128 = v127:FindFirstChild("ItemTemplate")
    end
    if v128 then
        local v129 = v128:Clone()
        v129.Name = tostring(p125)
        v129.LayoutOrder = p125
        v129.Size = p126
        v129.SizeConstraint = Enum.SizeConstraint.RelativeXY
        v129.AutomaticSize = Enum.AutomaticSize.None
        v129.Parent = p123
        if p124.isGold then
            local v130 = string.lower(p124.item.skin.skinName)
            v129.Frame.Icon.Image = "rbxassetid://132217734282843"
            if v_u_41[v130] then
                v129.Frame.Icon.Image = v_u_41[v130]
                return
            end
        else
            local v131 = v_u_26[p124.item.rarity]
            local v132 = v_u_16.GetSkinInformation(p124.item.skin.weaponName, p124.item.skin.skinName)
            local v133 = v129:FindFirstChild("Frame")
            if v131 and (v132 and v133) then
                local v134 = v133:FindFirstChild("RarityFrame")
                local v135 = v134 and v134:FindFirstChild("UIGradient")
                if v135 then
                    v135.Color = v131.ColorSequence
                end
                local v136 = v133:FindFirstChild("Icon")
                if v136 then
                    local v137 = ""
                    if v132.wearImages and #v132.wearImages > 0 then
                        v137 = v132.wearImages[1].assetId
                    elseif v132.charmImages and #v132.charmImages > 0 then
                        v137 = v132.charmImages[1].assetId
                    elseif v132.imageAssetId then
                        v137 = v132.imageAssetId
                    end
                    v136.Image = v137
                end
                local v138 = v133:FindFirstChild("Rarity")
                if v138 then
                    v138.ImageColor3 = v131.Color
                    return
                end
            end
        end
    else
        warn("[Store] Missing case scroll template")
    end
end
local function v_u_148(p140, p141, p142, p143)
    for _, v144 in ipairs(p140:GetChildren()) do
        if v144:IsA("Frame") or (v144:IsA("ImageLabel") or v144:IsA("ImageButton")) then
            v144:Destroy()
        end
    end
    local v145 = p140:FindFirstChildOfClass("UIListLayout")
    if v145 then
        v145.FillDirection = Enum.FillDirection.Horizontal
        v145.HorizontalAlignment = Enum.HorizontalAlignment.Left
        v145.VerticalAlignment = Enum.VerticalAlignment.Center
        v145.Padding = UDim.new(0, p143)
    end
    for v146, v147 in ipairs(p141) do
        v_u_139(p140, v147, v146, p142)
    end
end
local function v_u_156(p149, p150)
    local v151 = p149.AbsoluteSize.X
    local v152 = math.max(v151, 1)
    local v153 = p150 / v152
    local v154 = math.max(v153, 1)
    p149.CanvasSize = UDim2.fromScale(v154, 0)
    local v155 = p150 - v152
    p149:SetAttribute("ScrollMaxOffset", (math.max(0, v155)))
    p149:SetAttribute("ScrollViewportWidth", v152)
end
local function v_u_171(p_u_157, p_u_158, p_u_159, p_u_160, p_u_161, p_u_162)
    local v163 = TweenInfo.new(7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local v_u_164 = v_u_6:Create(p_u_157, v163, {
        ["CanvasPosition"] = Vector2.new(p_u_159, 0)
    })
    local v_u_165 = v_u_6:Create(p_u_158, v163, {
        ["CanvasPosition"] = Vector2.new(p_u_160, 0)
    })
    v_u_45.currentTween = v_u_164
    v_u_45.currentZoomTween = v_u_165
    local v_u_166 = 0
    local v_u_167 = nil
    v_u_167 = v_u_8.RenderStepped:Connect(function()
        if v_u_45.isOpening then
            local v168 = p_u_157.CanvasPosition.X
            local v169 = p_u_161 <= 0 and 0 or v168 / p_u_161
            local v170 = math.floor(v169) + 1
            if v_u_166 < v170 and v170 <= 75 then
                p_u_162(v170)
                v_u_166 = v170
            end
            if v_u_164.PlaybackState == Enum.PlaybackState.Completed and v_u_167 then
                v_u_167:Disconnect()
                v_u_167 = nil
                v_u_45.renderConnection = nil
            end
        elseif v_u_167 then
            v_u_167:Disconnect()
            v_u_167 = nil
            v_u_45.renderConnection = nil
        end
    end)
    v_u_45.renderConnection = v_u_167
    v_u_164.Completed:Connect(function()
        if v_u_164 == v_u_45.currentTween then
            if v_u_167 then
                v_u_167:Disconnect()
                v_u_167 = nil
                v_u_45.renderConnection = nil
            end
        end
    end)
    task.delay(6.02, function()
        if v_u_164 == v_u_45.currentTween then
            if v_u_164.PlaybackState == Enum.PlaybackState.Completed then
                return
            elseif p_u_157.Parent == nil or p_u_158.Parent == nil then
                if v_u_167 then
                    v_u_167:Disconnect()
                    v_u_167 = nil
                    v_u_45.renderConnection = nil
                end
            else
                v_u_164:Cancel()
                v_u_165:Cancel()
                p_u_157.CanvasPosition = Vector2.new(p_u_159, 0)
                p_u_158.CanvasPosition = Vector2.new(p_u_160, 0)
                if v_u_167 then
                    v_u_167:Disconnect()
                    v_u_167 = nil
                    v_u_45.renderConnection = nil
                end
            end
        else
            return
        end
    end)
    v_u_164:Play()
    v_u_165:Play()
    return v_u_164
end
local function v_u_176(p172, p173)
    local v174 = p172:FindFirstChild("Alert")
    if v174 and v174:IsA("GuiObject") then
        if p173.discontinueDate then
            v174.Visible = true
            local v175 = v174:FindFirstChild("TextLabel")
            if v175 and v175:IsA("TextLabel") then
                v175.Text = v_u_93(p173.discontinueDate)
            end
        else
            v174.Visible = p173.status == "featured"
        end
    else
        return
    end
end
local function v_u_181(p177)
    local v178 = v_u_11.Get(v_u_28, "Inventory")
    if not v178 then
        return 0
    end
    local v179 = 0
    for _, v180 in ipairs(v178) do
        if (v180.Type == "Case" or v180.Type == "Package") and v180.Skin == p177 then
            v179 = v179 + 1
        end
    end
    return v179
end
local function v_u_188(p182, p183)
    local v184 = v_u_11.Get(v_u_28, "Inventory")
    local v185 = {}
    if v184 then
        for _, v186 in ipairs(v184) do
            if p183 <= #v185 then
                break
            end
            if (v186.Type == "Case" or v186.Type == "Package") and v186.Skin == p182 then
                local v187 = v186._id
                table.insert(v185, v187)
            end
        end
    end
    return v185
end
local function v_u_194(p189, p190)
    local v191 = p189:GetChildren()
    for _, v192 in ipairs(v191) do
        if v192:IsA("TextButton") then
            local v193 = v192.Name
            v192.Visible = (tonumber(v193) or 0) <= p190
        end
    end
end
local function v_u_198(p195)
    local v196 = p195:GetChildren()
    for _, v197 in ipairs(v196) do
        if v197:IsA("TextButton") then
            v197.Visible = true
        end
    end
end
local function v_u_202(p199, p200)
    if p199.Type == "Melee" or p199.Type == "Glove" then
        return "Special"
    end
    for _, v201 in ipairs(p200.contents) do
        if v201.skin.skinName == p199.Skin and v201.skin.weaponName == p199.Name then
            return v201.rarity or "Blue"
        end
    end
    return "Blue"
end
local function v_u_208(p203, p204)
    for _, v205 in ipairs(p203.contents) do
        if v205.skin.skinName == p204.Skin and v205.skin.weaponName == p204.Name then
            return v205, v205.isSpecial or false
        end
    end
    if p204.Type == "Melee" or p204.Type == "Glove" then
        local v206 = {
            ["skin"] = {
                ["weaponName"] = p204.Name,
                ["skinName"] = p204.Skin,
                ["type"] = p204.Type
            },
            ["isSpecial"] = true,
            ["rarity"] = "Special",
            ["skinId"] = "",
            ["weight"] = 0
        }
        return v206, true
    else
        local v207 = p203.contents[1]
        return v207, v207.isSpecial or false
    end
end
local function v_u_214()
    if v_u_45.progressRightTween then
        v_u_45.progressRightTween:Cancel()
        v_u_45.progressRightTween = nil
    end
    if v_u_45.progressLeftTween then
        v_u_45.progressLeftTween:Cancel()
        v_u_45.progressLeftTween = nil
    end
    if v_u_45.progressRightProxy then
        v_u_45.progressRightProxy:Destroy()
        v_u_45.progressRightProxy = nil
    end
    if v_u_45.progressLeftProxy then
        v_u_45.progressLeftProxy:Destroy()
        v_u_45.progressLeftProxy = nil
    end
    if v_u_44 then
        local v209 = v_u_44.Menu.OpenCase.Contents:FindFirstChild("ProgressBar")
        if v209 then
            local v210 = v209:FindFirstChild("RightGradient")
            local v211 = v209:FindFirstChild("LeftGradient")
            local v212 = v210 and v210:FindFirstChild("ProgressBarImage")
            if v212 then
                v212 = v210.ProgressBarImage:FindFirstChild("UIGradient")
            end
            local v213 = v211 and v211:FindFirstChild("ProgressBarImage")
            if v213 then
                v213 = v211.ProgressBarImage:FindFirstChild("UIGradient")
            end
            if v212 then
                v212.Transparency = NumberSequence.new(1)
            end
            if v213 then
                v213.Transparency = NumberSequence.new(1)
            end
        end
    else
        return
    end
end
local function v_u_216(p215)
    if p215 <= 0.001 then
        return NumberSequence.new(1)
    elseif p215 >= 0.999 then
        return NumberSequence.new(0)
    else
        return NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(p215, 0),
            NumberSequenceKeypoint.new(p215 + 0.001, 1),
            NumberSequenceKeypoint.new(1, 1)
        })
    end
end
local function v_u_218(p217)
    if p217 >= 0.999 then
        return NumberSequence.new(1)
    elseif p217 <= 0.001 then
        return NumberSequence.new(0)
    else
        return NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(p217 - 0.001, 1),
            NumberSequenceKeypoint.new(p217, 0),
            NumberSequenceKeypoint.new(1, 0)
        })
    end
end
local function v_u_231(p219)
    v_u_214()
    if v_u_44 then
        local v220 = v_u_44.Menu.OpenCase.Contents:FindFirstChild("ProgressBar")
        if v220 then
            local v_u_221 = v220.RightGradient.ProgressBarImage:FindFirstChild("UIGradient")
            local v_u_222 = v220.LeftGradient.ProgressBarImage:FindFirstChild("UIGradient")
            if v_u_221 and v_u_222 then
                v220.Visible = true
                v_u_31 = v_u_31 + 1
                local v_u_223 = v_u_31
                local v_u_224 = p219 / 3 / 2
                v_u_221.Transparency = NumberSequence.new(1)
                v_u_222.Transparency = NumberSequence.new(1)
                task.spawn(function()
                    for _ = 1, 3 do
                        if not v_u_45.isOpening or v_u_223 ~= v_u_31 then
                            return
                        end
                        if v_u_45.progressRightProxy then
                            v_u_45.progressRightProxy:Destroy()
                        end
                        local v225 = Instance.new("NumberValue")
                        v225.Value = 0
                        v225.Changed:Connect(function(p226)
                            v_u_221.Transparency = v_u_216(p226)
                        end)
                        v_u_45.progressRightProxy = v225
                        local v227 = v_u_6:Create(v225, TweenInfo.new(v_u_224, Enum.EasingStyle.Linear), {
                            ["Value"] = 1
                        })
                        v_u_45.progressRightTween = v227
                        v227:Play()
                        v227.Completed:Wait()
                        if not v_u_45.isOpening or v_u_223 ~= v_u_31 then
                            return
                        end
                        v_u_222.Transparency = NumberSequence.new(1)
                        if v_u_45.progressLeftProxy then
                            v_u_45.progressLeftProxy:Destroy()
                        end
                        local v228 = Instance.new("NumberValue")
                        v228.Value = 1
                        v228.Changed:Connect(function(p229)
                            v_u_222.Transparency = v_u_218(p229)
                        end)
                        v_u_45.progressLeftProxy = v228
                        local v230 = v_u_6:Create(v228, TweenInfo.new(v_u_224, Enum.EasingStyle.Linear), {
                            ["Value"] = 0
                        })
                        v_u_45.progressLeftTween = v230
                        v230:Play()
                        v230.Completed:Wait()
                        if not v_u_45.isOpening or v_u_223 ~= v_u_31 then
                            return
                        end
                        v_u_221.Transparency = NumberSequence.new(1)
                    end
                end)
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_296(p232, p233)
    if not v_u_45.isOpening then
        return nil
    end
    local v234 = v_u_44.Menu.OpenCase
    local v235 = v234:FindFirstChild("CanvasGroup")
    local v236 = v234:FindFirstChild("Zoom")
    if not (v235 and v236) then
        warn("[Store] Missing CanvasGroup or Zoom group in OpenCase UI")
        return nil
    end
    local v_u_237 = v235:FindFirstChild("Container")
    local v_u_238 = v236:FindFirstChild("Container")
    if not (v_u_237 and v_u_238) then
        warn("[Store] Missing scroll containers for case opening")
        return nil
    end
    local v239, v240 = v_u_208(p232, p233)
    local v241 = v_u_122(p232, v239, 55, v240)
    local v242 = v_u_44 and v_u_44.AbsoluteSize or Vector2.new(1075, 1000)
    local v243 = v242.X / 5
    local v244 = math.max(v243, 1)
    local v245 = v244 * 0.65
    local v246 = math.max(v245, 1)
    local v247 = UDim2.fromOffset(v244, v246)
    local v248 = UDim2.fromOffset(v244, v246 * 1.125)
    local v249 = v234:FindFirstChild("Line")
    if v249 and v249:IsA("GuiObject") then
        v249.Size = UDim2.new(0.003, 0, 0, v246 * 1.125)
    end
    v_u_148(v_u_237, v241, v247, 8)
    v_u_148(v_u_238, v241, v248, 8)
    v_u_237.CanvasPosition = Vector2.new(0, 0)
    v_u_238.CanvasPosition = Vector2.new(0, 0)
    local v_u_250 = v244 + 8
    local v_u_251 = v_u_250 * 75
    task.wait()
    v_u_156(v_u_237, v_u_251)
    v_u_156(v_u_238, v_u_251)
    local v252 = v242.X
    local v253 = math.random
    local v254 = v252 / 11
    local v255 = -math.floor(v254)
    local v256 = v252 / 22
    local v_u_257 = v253(v255, (math.floor(v256)))
    local v258 = v_u_237.AbsoluteSize.X
    local v259 = math.max(v258, 1)
    local v260 = v_u_251 - v259
    local v261 = math.max(0, v260)
    local v262
    if v261 <= 0 then
        v262 = 0
    else
        local v263 = v_u_250 * 54.5 - v259 * 0.5 + v_u_257
        v262 = math.clamp(v263, 0, v261)
    end
    local v264 = v_u_238.AbsoluteSize.X
    local v265 = math.max(v264, 1)
    local v266 = v_u_251 - v265
    local v267 = math.max(0, v266)
    local v268
    if v267 <= 0 then
        v268 = 0
    else
        local v269 = v_u_250 * 54.5 - v265 * 0.5 + v_u_257
        v268 = math.clamp(v269, 0, v267)
    end
    v_u_237:SetAttribute("_scrollTarget", v262)
    v_u_238:SetAttribute("_scrollTarget", v268)
    local v_u_270 = tick()
    local v271 = v_u_171(v_u_237, v_u_238, v262, v268, v_u_250, function()
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
    end)
    v_u_231(7)
    v_u_45.viewportConnection = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        if v_u_45.isOpening then
            local v272 = v_u_251
            local v273 = v_u_250
            local v274 = v_u_257
            local v275 = v_u_237.AbsoluteSize.X
            local v276 = math.max(v275, 1)
            local v277 = v272 - v276
            local v278 = math.max(0, v277)
            local v279
            if v278 <= 0 then
                v279 = 0
            else
                local v280 = v273 * 54.5 - v276 * 0.5 + v274
                v279 = math.clamp(v280, 0, v278)
            end
            local v281 = v_u_251
            local v282 = v_u_250
            local v283 = v_u_257
            local v284 = v_u_238.AbsoluteSize.X
            local v285 = math.max(v284, 1)
            local v286 = v281 - v285
            local v287 = math.max(0, v286)
            local v288
            if v287 <= 0 then
                v288 = 0
            else
                local v289 = v282 * 54.5 - v285 * 0.5 + v283
                v288 = math.clamp(v289, 0, v287)
            end
            if v_u_45.currentTween then
                v_u_45.currentTween:Cancel()
            end
            if v_u_45.currentZoomTween then
                v_u_45.currentZoomTween:Cancel()
            end
            local v290 = 7 - (tick() - v_u_270)
            local v291 = math.max(0.1, v290)
            local v292 = TweenInfo.new(v291, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            local v293 = v_u_6:Create(v_u_237, v292, {
                ["CanvasPosition"] = Vector2.new(v279, 0)
            })
            local v294 = v_u_6:Create(v_u_238, v292, {
                ["CanvasPosition"] = Vector2.new(v288, 0)
            })
            v_u_45.currentTween = v293
            v_u_45.currentZoomTween = v294
            v293:Play()
            v294:Play()
        end
    end)
    if v271 then
        while v_u_45.isOpening do
            local v295 = v_u_45.currentTween
            if not v295 then
                break
            end
            v295.Completed:Wait()
            if v_u_45.currentTween == v295 then
                break
            end
        end
    end
    if v_u_45.viewportConnection then
        v_u_45.viewportConnection:Disconnect()
        v_u_45.viewportConnection = nil
    end
    v_u_45.currentTween = nil
    v_u_45.currentZoomTween = nil
    return v239
end
function v_u_1.PurchaseCase(p297, p298)
    local v299 = v_u_11.Get(v_u_28, "Credits")
    local v300 = p297.price * p298
    if v300 <= v299 then
        v_u_19.Store.PurchaseCase.Send({
            ["CaseId"] = p297.caseId,
            ["Amount"] = p298
        })
        return
    elseif v_u_30 then
        local v301 = v300 - v299
        v_u_2:PromptProductPurchase(v_u_28, v_u_24[v301 <= 400 and "+ 400 Credits" or (v301 <= 950 and "+ 950 Credits" or (v301 <= 3100 and "+ 3,100 Credits" or (v301 <= 6500 and "+ 6,500 Credits" or (v301 <= 13250 and "+ 13,250 Credits" or "+ 27,000 Credits"))))].DevProductId)
        v_u_1.CloseCaseContent("Store")
        v_u_1.OpenTab("Credits")
    end
end
function v_u_1.CreateCaseTemplate(p_u_302, p303)
    local v304 = v_u_26[p_u_302.caseRarity]
    if v304 then
        local v305 = v_u_3.Assets.UI.Store.CaseTemplate:Clone()
        v305.Contents.Rarity.UIGradient.Color = v304.ColorSequence
        local v306 = v305.Buy.Credits.Amount
        local v307 = p_u_302.price
        v306.Text = ("%*"):format((tostring(v307):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
        v305.Contents.Glow.ImageColor3 = v304.Color
        v_u_176(v305, p_u_302)
        v305.Contents.Icon.Image = p_u_302.imageAssetId
        v305.Footer.CaseName.Text = p_u_302.name
        v305.Parent = p303
        v305.Name = p_u_302.caseId
        v_u_13(v305.Purchase)
        v305.Purchase.MouseButton1Click:Connect(function()
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            v_u_1.OpenCaseContent(p_u_302.caseId, "Inspect")
        end)
        v_u_13(v305.Gift)
        v305.Gift.MouseButton1Click:Connect(function()
            v_u_1.OpenGift(p_u_302.caseId, "Case")
        end)
    end
end
function v_u_1.ActivateGiftTemplate(p_u_308, p_u_309)
    p_u_308.Button.MouseEnter:Connect(function()
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Highlight")
        v_u_6:Create(p_u_308.Player.Username, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["TextColor3"] = Color3.fromRGB(255, 200, 0)
        }):Play()
    end)
    p_u_308.Button.MouseLeave:Connect(function()
        v_u_6:Create(p_u_308.Player.Username, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["TextColor3"] = Color3.fromRGB(190, 190, 190)
        }):Play()
    end)
    p_u_308.Button.MouseButton1Click:Connect(function()
        if p_u_309 == v_u_28.UserId then
            return
        else
            local v310 = v_u_43:GetAttribute("GiftProductName")
            local v311 = v_u_43:GetAttribute("GiftProductType")
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
            if v311 == "Case" then
                local v312 = v_u_11.Get(v_u_28, "Credits")
                local v313 = v_u_17.GetCase(v310)
                local v314 = v_u_43.Gift.Amount.Header.TextLabel.Text
                local v315 = tonumber(v314) or 1
                if v312 >= v313.price * v315 then
                    v_u_43.Gift.Visible = false
                    local v316 = v_u_19.Store.GiftCase.Send
                    local v317 = {}
                    local v318 = p_u_309
                    v317.RecipientUserId = tostring(v318)
                    v317.CaseId = v310
                    v317.Amount = v315
                    return v316(v317)
                end
                return
            else
                local v319 = v_u_19.Store.CreateGift.Send
                local v320 = {}
                local v321 = p_u_309
                v320.RecipientUserId = tostring(v321)
                v320.ProductName = v310
                v320.ProductType = v311
                v319(v320)
                if v311 == "Gamepass" then
                    v_u_2:PromptGamePassPurchase(v_u_28, v_u_25[v310].GamepassId)
                else
                    if v311 ~= "DevProduct" then
                        return nil
                    end
                    v_u_2:PromptProductPurchase(v_u_28, v_u_24[v310].DevProductId)
                end
            end
        end
    end)
end
function v_u_1.SetupCreditsFrame(p_u_322)
    local v323 = p_u_322:FindFirstChild("Rewards")
    local v_u_324 = p_u_322.Size
    p_u_322.MouseEnter:Connect(function()
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Highlight")
        p_u_322.Hoverstroke.Enabled = true
        local v325 = v_u_6
        local v326 = p_u_322
        local v327 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v328 = {}
        local v329 = v_u_324
        v328.Size = UDim2.fromScale(v329.X.Scale * 0.975, v329.Y.Scale * 0.975)
        v325:Create(v326, v327, v328):Play()
    end)
    p_u_322.MouseLeave:Connect(function()
        p_u_322.Hoverstroke.Enabled = false
        local v330 = {
            ["Size"] = v_u_324
        }
        v_u_6:Create(p_u_322, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v330):Play()
    end)
    v_u_13(p_u_322.Purchase)
    p_u_322.Purchase.MouseButton1Click:Connect(function()
        if v_u_30 then
            v_u_2:PromptProductPurchase(v_u_28, v_u_24[p_u_322.Name].DevProductId)
            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        end
    end)
    v_u_13(p_u_322.Gift)
    p_u_322.Gift.MouseButton1Click:Connect(function()
        v_u_1.OpenGift("Gift " .. p_u_322.Name, "DevProduct")
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
    end)
    if v323 then
        local v331 = v323:FindFirstChild("Rewards") or v323
        for _, v_u_332 in ipairs(v331:GetChildren()) do
            if v_u_332:IsA("Frame") then
                v_u_332.Icon.Button.MouseButton1Click:Connect(function()
                    v_u_20.broadcastRouter("WeaponInspect", v_u_332.Icon.Button:GetAttribute("WeaponName"), v_u_332.Icon.Button:GetAttribute("SkinName"), 0, nil, nil, nil, nil, nil, 1, nil, 1, nil)
                    v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                end)
            end
        end
    end
end
function v_u_1.UpdateCases()
    local v333 = v_u_17.GetFeaturedCases(6)
    v_u_52(v_u_43.Tabs.Container.Featured.Container.Items, { "UIListLayout" })
    local v334 = v_u_17.GetCases()
    v_u_52(v_u_43.Tabs.Container.Cases.Cases, { "UIListLayout", "UIGridLayout" })
    for _, v335 in ipairs(v333) do
        if v335.caseType ~= "Package" then
            v_u_1.CreateCaseTemplate(v335, v_u_43.Tabs.Container.Featured.Container.Items)
        end
    end
    for _, v336 in ipairs(v334) do
        if v336.caseType ~= "Package" then
            v_u_1.CreateCaseTemplate(v336, v_u_43.Tabs.Container.Cases.Cases)
        end
    end
end
function v_u_1.OpenCaseContent(p337, p338, p339)
    local v340 = v_u_17.GetCase(p337)
    v_u_33 = p339
    v_u_34 = v340
    if v340 then
        if v_u_43.Visible or v_u_21.GetCurrentScreen() == "Store" then
            v_u_21.SetScreen("Store")
            v_u_43.CaseContent:SetAttribute("WasVisibleBeforeInspect", true)
        else
            v_u_43.CaseContent:SetAttribute("WasVisibleBeforeInspect", false)
        end
        v_u_43.CaseContent.List.Amount.Position = p338 == "Open" and UDim2.new(0.687, 0, 0.465, 0) or UDim2.new(0.575, 0, 0.465, 0)
        v_u_43.CaseContent.Title.Text = p338 == "Inspect" and "Inspect Container" or "Unlock Container"
        local v341 = v_u_43.CaseContent.List.Buy.Header.TextLabel
        local v342 = v340.price
        v341.Text = ("BUY (%*)"):format((tostring(v342):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
        v_u_43.CaseContent.List.Amount.Visible = true
        v_u_43.CaseContent.List.Amount.Header.TextLabel.Text = "1"
        v_u_43.CaseContent.List.Buy.Visible = p338 == "Inspect"
        v_u_43.CaseContent.CaseName.Text = v340.name
        v_u_43.CaseContent.List.Open.Visible = p338 == "Open"
        v_u_43.CaseContent:SetAttribute("State", p338)
        v_u_43.OpenCreatorCode.Visible = false
        v_u_43.Tabs.Container.Visible = false
        v_u_43.CaseContent.Visible = true
        v_u_44.Menu.Top.Visible = false
        v_u_43.Top.Visible = false
        v_u_43.Visible = true
        if p338 == "Open" then
            local v343 = v_u_181(v340.name)
            v_u_194(v_u_43.CaseContent.List.Amount.Container, v343)
        else
            v_u_198(v_u_43.CaseContent.List.Amount.Container)
        end
        for _, v344 in ipairs(v_u_43.CaseContent.List.Amount.Container:GetChildren()) do
            if v344:IsA("TextButton") then
                v344.Frame.BackgroundTransparency = v344.Name == "1" and 0 or 1
                v344:SetAttribute("Selected", v344.Name == "1")
            end
        end
        for _, v345 in ipairs(v_u_43.CaseContent.CaseChances:GetChildren()) do
            if v345:IsA("TextLabel") then
                v345.Visible = false
            end
        end
        for _, v346 in ipairs(v340.rarityChances) do
            local v347 = v_u_43.CaseContent.CaseChances:FindFirstChild(v346.rarity)
            v347.Text = ("%*: %*%%"):format(v346.rarity, v346.chance)
            v347.Visible = true
        end
        if v340.caseType == "Case" then
            local v348 = v340.rarityChances
            local v349 = 0
            for _, v350 in ipairs(v348) do
                v349 = v349 + v350.chance
            end
            local v351 = (100 - v349) * 100
            local v352 = math.round(v351) / 100
            v_u_43.CaseContent.CaseChances.Special.Text = ("Special: %*%%"):format(v352)
            v_u_43.CaseContent.CaseChances.Special.Visible = true
        end
        v_u_12.ShowCaseScene(v340.caseType, v340.name)
        task.defer(function()
            v_u_43.Visible = true
            v_u_43.CaseContent.Visible = true
            if v_u_44 and v_u_44.Menu then
                v_u_44.Menu.Visible = true
            end
        end)
        v_u_52(v_u_43.CaseContent.Container, { "UIGridLayout", "UIPadding" })
        local v353 = table.clone(v340.contents)
        table.sort(v353, function(p354, p355)
            return (v_u_42[p354.rarity] or 0) < (v_u_42[p355.rarity] or 0)
        end)
        for _, v_u_356 in ipairs(v353) do
            local v357 = v_u_16.GetSkinInformation(v_u_356.skin.weaponName, v_u_356.skin.skinName)
            local v358 = v_u_26[v_u_356.rarity]
            local v359
            if v357.wearImages and v357.wearImages[1] then
                v359 = v357.wearImages[1].assetId
            elseif v357.charmImages and v357.charmImages[1] then
                v359 = v357.charmImages[1].assetId
            else
                v359 = v357.imageAssetId or ""
            end
            local v360 = v_u_3.Assets.UI.Store.ItemTemplate:Clone()
            v360.Content.RarityFrame.UIGradient.Color = v358.ColorSequence
            v360.Footer.WeaponName.Text = v_u_356.skin.weaponName
            v360.Content.Rarity.ImageColor3 = v358.Color
            v360.Footer.SkinName.Text = v_u_356.skin.skinName
            v360.Parent = v_u_43.CaseContent.Container
            v360.Content.Icon.Image = v359
            local v_u_361 = v360.Content:FindFirstChild("Inspect")
            if v_u_361 then
                v_u_361.Visible = false
                v_u_13(v_u_361)
                v360.Content.MouseEnter:Connect(function()
                    v_u_361.Visible = true
                end)
                v360.Content.MouseLeave:Connect(function()
                    v_u_361.Visible = false
                end)
                v_u_361.MouseButton1Click:Connect(function()
                    v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                    local v362 = v_u_356.skin.type == "Charm" and "Charm" or nil
                    v_u_20.broadcastRouter("WeaponInspect", v_u_356.skin.weaponName, v_u_356.skin.skinName, 0, nil, nil, nil, nil, v362, 1, nil, 1, nil)
                end)
                local v363 = v_u_14()
                local v364
                if table.find(v363, "Mobile") == nil then
                    v364 = false
                else
                    v364 = #v363 <= 1
                end
                local v365 = v360.Content:FindFirstChild("MobileInspect")
                if v365 and not v364 then
                    v365.Visible = false
                end
                if v364 and v365 then
                    v_u_13(v365)
                    v365.Activated:Connect(function()
                        v_u_361.Visible = true
                    end)
                    v_u_361:GetPropertyChangedSignal("Visible"):Connect(function()
                        if v_u_361.Visible then
                            v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                            local v366 = v_u_356.skin.type == "Charm" and "Charm" or nil
                            v_u_20.broadcastRouter("WeaponInspect", v_u_356.skin.weaponName, v_u_356.skin.skinName, 0, nil, nil, nil, nil, v366, 1, nil, 1, nil)
                        end
                    end)
                end
            end
        end
        if v340.caseType == "Case" then
            local v367 = v_u_3.Assets.UI.Store.GoldTemplate:Clone()
            v367.Content.Icon.Image = v_u_41[v340.caseId] or "rbxassetid://132217734282843"
            v367.Parent = v_u_43.CaseContent.Container
            return
        end
    end
end
function v_u_1.OpenGift(p368, p369)
    v_u_43:SetAttribute("GiftProductName", p368)
    v_u_43:SetAttribute("GiftProductType", p369)
    local v370 = v_u_43.Gift.Amount
    v370.Header.TextLabel.Text = "1"
    v370.Visible = p369 == "Case"
    v370.Container.Visible = false
    for _, v371 in ipairs(v370.Container:GetChildren()) do
        if v371:IsA("TextButton") then
            v371.Frame.BackgroundTransparency = v371.Name == "1" and 0 or 1
            v371:SetAttribute("Selected", v371.Name == "1")
        end
    end
    v_u_43.Gift.Visible = true
end
function v_u_1.SearchPlayerGift(p372)
    local v373 = v_u_43.Gift.Container:FindFirstChild("SearchResult")
    if v373 then
        v373:Destroy()
    end
    local v_u_374 = tonumber(p372)
    if p372 == "" or not v_u_374 then
        return
    else
        for _, v375 in ipairs(v_u_43.Gift.Container:GetChildren()) do
            if v375:IsA("Frame") then
                v375.Visible = false
            end
        end
        local v376, v377 = pcall(function()
            return v_u_9:GetNameFromUserIdAsync(v_u_374)
        end)
        if v376 then
            local v378 = v_u_3.Assets.UI.Store.PlayerTemplate:Clone()
            v378.Player.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(v_u_374)
            v378.Player.Username.Text = ("@%*"):format(v377)
            v378.Parent = v_u_43.Gift.Container
            v378.Name = "SearchResult"
            v_u_1.ActivateGiftTemplate(v378, v_u_374)
        end
    end
end
function v_u_1.OpenTab(p379)
    if p379 == "Credits" and not v_u_30 then
        v_u_20.broadcastRouter("CreateMenuNotification", "Error", "Paid random items are not allowed in your region.")
    else
        for _, v380 in ipairs(v_u_43.Top.Categories:GetChildren()) do
            if v380:IsA("TextButton") then
                v380:SetAttribute("Selected", v380.Name == p379)
                if v380.Name == p379 and v380.Name ~= "Credits" then
                    v380.HoverFrame.BackgroundTransparency = 0
                    v380.HoverFrame.BackgroundColor3 = v_u_38
                    v380.TextLabel.TextColor3 = v_u_36
                elseif v380.Name ~= "Credits" then
                    v380.HoverFrame.BackgroundColor3 = Color3.fromRGB(243, 243, 243)
                    v380.TextLabel.TextColor3 = v_u_35
                    v380.HoverFrame.BackgroundTransparency = 1
                end
                v380:SetAttribute("Selected", v380.Name == p379)
            end
        end
        for _, v381 in ipairs(v_u_43.Tabs.Container:GetChildren()) do
            if v381:IsA("Frame") then
                v381.Visible = v381.Name == p379
            end
        end
    end
end
function v_u_1.OpenCase(p382, p_u_383, p384)
    v_u_48("OpenCase called")
    v_u_48("  caseId:", p382)
    v_u_48("  caseIdentifier:", p384 or "nil")
    local v385 = v_u_45.isQuickUnlock
    v_u_45.isPendingOpenRequest = false
    v_u_45.pendingOpenRequestId = nil
    v_u_45.isQuickUnlock = false
    v_u_45.currentCaseIdentifier = p384
    v_u_74()
    local v_u_386 = v_u_17.GetCase(p382)
    if v_u_386 then
        if v385 then
            v_u_48("  Quick Unlock path - skipping animations")
            if p384 then
                v_u_19.Store.CaseOpenSequenceFinished.Send({
                    ["CaseIdentifier"] = p384
                })
            end
            v_u_12.HideCaseScene()
            v_u_43.Tabs.Container.Visible = true
            v_u_43.CaseContent.Visible = false
            v_u_44.Menu.Top.Visible = true
            v_u_43.Top.Visible = true
            v_u_43.Visible = false
            v_u_21.SetScreen("Inventory")
            local v387 = v_u_46[v_u_202(p_u_383, v_u_386)] or "Drop Blue"
            v_u_20.broadcastRouter("RunStoreSound", v387)
            v_u_20.broadcastRouter("RunStoreSound", "Case Close")
            v_u_20.broadcastRouter("ShowNewItemNotification", p_u_383)
        else
            v_u_45.isOpening = true
            v_u_45.currentInventoryItem = p_u_383
            v_u_43.CaseContent.Visible = false
            local v388 = v_u_386.caseType == "Charm Capsule"
            local v389 = v_u_386.caseType == "Package"
            local function v393()
                if v_u_45.isOpening then
                    v_u_44.Menu.OpenCase.CaseName.Text = ("Unlock %*"):format(v_u_386.name)
                    v_u_44.Menu.OpenCase.Visible = true
                    v_u_43.Visible = false
                    v_u_44.Menu.OpenCase.Contents.Close.TextLabel.Text = "CLOSE"
                    local v390 = v_u_296(v_u_386, p_u_383)
                    if v_u_45.isOpening then
                        v_u_20.broadcastRouter("RunInterfaceSound", "UI Notification")
                        task.wait(0.5)
                        if v_u_45.isOpening then
                            v_u_45.isOpening = false
                            v_u_45.currentInventoryItem = nil
                            local v391 = v_u_45.currentCaseIdentifier
                            if v391 then
                                v_u_19.Store.CaseOpenSequenceFinished.Send({
                                    ["CaseIdentifier"] = v391
                                })
                                v_u_45.currentCaseIdentifier = nil
                            end
                            v_u_44.Menu.OpenCase.Visible = false
                            v_u_12.HideCaseScene()
                            v_u_43.Tabs.Container.Visible = true
                            v_u_43.CaseContent.Visible = false
                            v_u_44.Menu.Top.Visible = true
                            v_u_43.Top.Visible = true
                            v_u_43.Visible = false
                            v_u_21.SetScreen("Inventory")
                            local v392 = v_u_46[v390 and v390.rarity or "Blue"] or "Drop Blue"
                            v_u_20.broadcastRouter("RunStoreSound", v392)
                            v_u_20.broadcastRouter("RunStoreSound", "Case Close")
                            v_u_20.broadcastRouter("WeaponInspect", p_u_383.Name, p_u_383.Skin, p_u_383.Float, p_u_383.StatTrack, p_u_383.NameTag, p_u_383.Charm, p_u_383.Stickers, p_u_383.Type, p_u_383.Pattern, p_u_383._id, p_u_383.Serial, p_u_383.IsTradeable)
                        end
                    else
                        return
                    end
                else
                    return
                end
            end
            if v388 then
                v_u_12.TransitionToUnboxing(v393)
            elseif v389 then
                v_u_12.TransitionToUnboxing()
                v_u_12.WaitForOpeningAnimation()
                if v_u_45.isOpening then
                    v_u_45.isOpening = false
                    v_u_45.currentInventoryItem = nil
                    local v394 = v_u_45.currentCaseIdentifier
                    if v394 then
                        v_u_19.Store.CaseOpenSequenceFinished.Send({
                            ["CaseIdentifier"] = v394
                        })
                        v_u_45.currentCaseIdentifier = nil
                    end
                    v_u_12.HideCaseScene()
                    v_u_43.Tabs.Container.Visible = true
                    v_u_43.CaseContent.Visible = false
                    v_u_44.Menu.Top.Visible = true
                    v_u_43.Top.Visible = true
                    v_u_43.Visible = false
                    v_u_21.SetScreen("Inventory")
                    local v395 = v_u_46[v_u_202(p_u_383, v_u_386)] or "Drop Blue"
                    v_u_20.broadcastRouter("RunStoreSound", v395)
                    v_u_20.broadcastRouter("RunStoreSound", "Case Close")
                    v_u_20.broadcastRouter("WeaponInspect", p_u_383.Name, p_u_383.Skin, p_u_383.Float, p_u_383.StatTrack, p_u_383.NameTag, p_u_383.Charm, p_u_383.Stickers, p_u_383.Type, p_u_383.Pattern, p_u_383._id, p_u_383.Serial, p_u_383.IsTradeable)
                end
            else
                v_u_12.TransitionToUnboxing()
                task.wait(0.8)
                v393()
            end
            v_u_48("OpenCase function complete")
        end
    else
        v_u_48("  BLOCKED: caseContents not found for caseId:", p382)
        return
    end
end
function v_u_1.StopCaseOpening()
    v_u_48("StopCaseOpening called")
    if v_u_45.isOpening then
        v_u_20.broadcastRouter("RunStoreSound", "Case Close")
    end
    v_u_74()
    v_u_47.isBulkOpening = false
    v_u_47.inventoryItems = nil
    v_u_47.bulkIdentifier = nil
    v_u_47.currentIndex = 0
    v_u_47.skipped = false
    v_u_47.caseId = nil
    v_u_47.total = 0
    v_u_214()
    local v396 = v_u_45.currentInventoryItem
    v_u_45.isOpening = false
    v_u_45.currentInventoryItem = nil
    v_u_12.HideCaseScene()
    v_u_48("  StopCaseOpening complete")
    return v396
end
function v_u_1.FinishBulkOpening()
    v_u_48("FinishBulkOpening called")
    local v397 = v_u_47.inventoryItems or {}
    local v398 = v_u_47.bulkIdentifier
    v_u_74()
    v_u_214()
    v_u_45.isOpening = false
    v_u_45.currentInventoryItem = nil
    v_u_12.HideCaseScene()
    v_u_44.Menu.OpenCase.Visible = false
    v_u_43.Tabs.Container.Visible = true
    v_u_43.CaseContent.Visible = false
    v_u_44.Menu.Top.Visible = true
    v_u_43.Top.Visible = true
    v_u_43.Visible = false
    v_u_44.Menu.OpenCase.Contents.Close.TextLabel.Text = "CLOSE"
    v_u_20.broadcastRouter("RunStoreSound", "Case Close")
    if v398 then
        v_u_19.Store.CaseOpenSequenceFinished.Send({
            ["CaseIdentifier"] = v398
        })
    end
    v_u_21.SetScreen("Inventory")
    for _, v399 in ipairs(v397) do
        v_u_20.broadcastRouter("ShowNewItemNotification", v399)
    end
    if #v397 > 0 then
        v_u_20.broadcastRouter("ShowNewItemNotificationAtIndex", 1)
    end
    v_u_47.isBulkOpening = false
    v_u_47.inventoryItems = nil
    v_u_47.bulkIdentifier = nil
    v_u_47.currentIndex = 0
    v_u_47.skipped = false
    v_u_47.caseId = nil
    v_u_47.total = 0
    v_u_48("FinishBulkOpening complete")
end
function v_u_1.SkipBulkOpening()
    v_u_48("SkipBulkOpening called")
    v_u_47.skipped = true
    v_u_74()
    v_u_1.FinishBulkOpening()
end
function v_u_1.StartBulkOpening(p400, p401, p402)
    v_u_48("StartBulkOpening called, caseId:", p400, "count:", #p401)
    local v403 = v_u_17.GetCase(p400)
    if not v403 then
        v_u_48("  BLOCKED: caseContents not found")
        return
    end
    v_u_47.isBulkOpening = true
    v_u_47.inventoryItems = p401
    v_u_47.bulkIdentifier = p402
    v_u_47.caseId = p400
    v_u_47.total = #p401
    v_u_47.currentIndex = 0
    v_u_47.skipped = false
    v_u_45.isPendingOpenRequest = false
    v_u_45.pendingOpenRequestId = nil
    v_u_45.isQuickUnlock = false
    v_u_74()
    v_u_45.isOpening = true
    v_u_45.currentInventoryItem = nil
    v_u_43.CaseContent.Visible = false
    v_u_12.TransitionToUnboxing()
    task.wait(0.8)
    if not v_u_45.isOpening or v_u_47.skipped then
        return
    end
    v_u_44.Menu.OpenCase.CaseName.Text = ("Unlock %*"):format(v403.name)
    v_u_44.Menu.OpenCase.Visible = true
    v_u_43.Visible = false
    for v404 = 1, #p401 do
        if not v_u_45.isOpening or v_u_47.skipped then
            break
        end
        v_u_47.currentIndex = v404
        local v405 = p401[v404]
        local v406 = v404 == #p401
        v_u_44.Menu.OpenCase.Contents.Close.TextLabel.Text = "CLOSE"
        local v407 = v_u_296(v403, v405)
        if not v_u_45.isOpening or v_u_47.skipped then
            break
        end
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Notification")
        local v408 = v407 and v407.rarity or "Blue"
        v_u_20.broadcastRouter("RunStoreSound", v_u_46[v408] or "Drop Blue")
        if v406 then
            task.wait(0.5)
        else
            local v409 = tick()
            while tick() - v409 < 1.5 and (not v_u_47.skipped and v_u_45.isOpening) do
                task.wait(0.1)
            end
        end
    end
    if v_u_45.isOpening and not v_u_47.skipped then
        v_u_1.FinishBulkOpening()
    end
end
function v_u_1.SetQuickUnlock(p410)
    v_u_45.isQuickUnlock = p410
end
function v_u_1.OpenCreatorCode()
    v_u_43.CreatorCode.Position = UDim2.fromScale(0.5, -1)
    v_u_43.CreatorCode.Visible = true
    v_u_43.Tabs.Visible = false
    v_u_6:Create(v_u_43.CreatorCode, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.fromScale(0.5, 0.5)
    }):Play()
end
function v_u_1.CloseCreatorCode()
    v_u_6:Create(v_u_43.CreatorCode, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.fromScale(0.5, -1)
    }):Play()
    task.wait(0.25)
    if v_u_43.CreatorCode.Visible then
        v_u_43.CreatorCode.Visible = false
        v_u_43.Tabs.Visible = true
    end
end
function v_u_1.CloseCaseContent(p411)
    v_u_12.HideCaseScene()
    v_u_34 = nil
    v_u_33 = nil
    v_u_43.CaseContent:SetAttribute("WasVisibleBeforeInspect", false)
    if p411 == "Inventory" then
        v_u_21.SetScreen("Inventory")
    end
    v_u_43.OpenCreatorCode.Visible = true
    v_u_43.Tabs.Container.Visible = true
    v_u_43.CaseContent.Visible = false
    v_u_44.Menu.Top.Visible = true
    v_u_43.Top.Visible = true
    if p411 == "Inventory" then
        v_u_44.Menu.Inventory.Visible = true
        v_u_43.Visible = false
    else
        v_u_43.Visible = true
    end
end
function v_u_1.Initialize(p412, p413)
    v_u_44 = p412
    v_u_43 = p413
    v_u_18.Add(v_u_44.Menu.OpenCase, v_u_44.Menu.OpenCase.Contents.Close, function()
        if v_u_47.isBulkOpening then
            v_u_1.SkipBulkOpening()
            return
        else
            local v414 = v_u_1.StopCaseOpening()
            v_u_44.Menu.OpenCase.Visible = false
            local v415 = v_u_45.currentCaseIdentifier
            if v415 then
                v_u_19.Store.CaseOpenSequenceFinished.Send({
                    ["CaseIdentifier"] = v415
                })
                v_u_45.currentCaseIdentifier = nil
            end
            v_u_43.Tabs.Container.Visible = true
            v_u_43.CaseContent.Visible = false
            v_u_44.Menu.Top.Visible = true
            v_u_43.Top.Visible = true
            v_u_43.Visible = false
            v_u_21.SetScreen("Inventory")
            if v414 then
                v_u_20.broadcastRouter("WeaponInspect", v414.Name, v414.Skin, v414.Float, v414.StatTrack, v414.NameTag, v414.Charm, v414.Stickers, v414.Type, v414.Pattern, v414._id, v414.Serial, v414.IsTradeable)
            else
                v_u_44.Menu.Inventory.Visible = true
            end
        end
    end)
    v_u_13(v_u_43.CaseContent.List.Open)
    v_u_43.CaseContent.List.Open.MouseButton1Click:Connect(function()
        if v_u_34 and not (v_u_45.isOpening or v_u_45.isPendingOpenRequest) then
            if v_u_33 then
                local v416 = v_u_43.CaseContent.List.Amount.Header.TextLabel.Text
                local v417 = tonumber(v416) or 1
                local v_u_418
                if v417 > 1 then
                    v_u_418 = v_u_188(v_u_34.name, v417)
                    if #v_u_418 < 2 then
                        v_u_20.broadcastRouter("CreateMenuNotification", "Error", "Not enough cases in your inventory.")
                        return
                    end
                else
                    v_u_418 = { v_u_33 }
                end
                local v419 = v417 > 1 and "Bulk" or (v_u_45.isQuickUnlock and "Quick Open" or "Standard")
                v_u_45.isPendingOpenRequest = true
                v_u_45.pendingOpenRequestId = v_u_418[1]
                v_u_19.Store.OpenCase.Send({
                    ["CaseIdentifiers"] = v_u_418,
                    ["OpenType"] = v419,
                    ["CaseId"] = v_u_34.caseId
                })
                task.delay(12 * (v417 > 1 and 2 or 1), function()
                    if v_u_45.isPendingOpenRequest and v_u_45.pendingOpenRequestId == v_u_418[1] then
                        v_u_45.isPendingOpenRequest = false
                        v_u_45.pendingOpenRequestId = nil
                        v_u_45.isQuickUnlock = false
                        v_u_20.broadcastRouter("CreateMenuNotification", "Error", "Opening case timed out. Please try again.")
                    end
                end)
            else
                v_u_20.broadcastRouter("CreateMenuNotification", "Error", "Case identifier missing. Please reopen the case.")
            end
        else
            return
        end
    end)
    v_u_13(v_u_43.CaseContent.List.Buy)
    v_u_43.CaseContent.List.Buy.MouseButton1Click:Connect(function()
        if v_u_34 then
            local v420 = v_u_1.PurchaseCase
            local v421 = v_u_34
            local v422 = v_u_43.CaseContent.List.Amount.Header.TextLabel.Text
            v420(v421, (tonumber(v422)))
        end
    end)
    v_u_13(v_u_43.CaseContent.List.Close)
    v_u_18.Add(v_u_43.CaseContent, v_u_43.CaseContent.List.Close, function()
        if not v_u_45.isPendingOpenRequest then
            v_u_1.CloseCaseContent(v_u_43.CaseContent:GetAttribute("State") == "Inspect" and "Store" or "Inventory")
        end
    end)
    v_u_13(v_u_43.OpenCreatorCode)
    v_u_43.OpenCreatorCode.MouseButton1Click:Connect(function()
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        if v_u_43.CreatorCode.Visible then
            v_u_1.CloseCreatorCode()
        else
            v_u_1.OpenCreatorCode()
        end
    end)
    v_u_13(v_u_43.CreatorCode.Container.Action.Close)
    v_u_18.Add(v_u_43.CreatorCode, v_u_43.CreatorCode.Container.Action.Close, function()
        v_u_1.CloseCreatorCode()
    end)
    v_u_13(v_u_43.CreatorCode.Container.Action.Confirm)
    v_u_43.CreatorCode.Container.Action.Confirm.MouseButton1Click:Connect(function()
        local v423 = v_u_43.CreatorCode.Container.Body.CreatorName.TextBox.Text
        v_u_43.CreatorCode.Container.Action.Confirm.Title.Text = "SEARCHING.."
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        if v423 and v423 ~= "" then
            v_u_19.UI.EquipCreatorCode.Send({
                ["CreatorCode"] = v423
            })
        else
            v_u_67("Error", "Creator code cannot be empty.")
        end
    end)
    v_u_52(v_u_43.Gift.Container, { "UICorner", "UIListLayout" })
    v_u_18.Add(v_u_43.Gift, v_u_43.Gift.Close, function()
        v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_43.Gift.Visible = false
    end)
    v_u_13(v_u_43.Top.Credits.Buy)
    v_u_43.Top.Credits.Buy.MouseButton1Click:Connect(function()
        v_u_1.OpenTab("Credits")
    end)
    local v424 = v_u_43.Tabs.Container.Featured.Bundle
    local v425, v426 = v_u_61(v424)
    if v425 then
        v_u_13(v425)
        v425.MouseButton1Click:Connect(function()
            v_u_1.OpenGift("Gift Featured Bundle", "DevProduct")
        end)
    end
    if v426 then
        v_u_13(v426)
        v426.MouseButton1Click:Connect(function()
            if v_u_15.GetActiveBundle() then
                v_u_2:PromptProductPurchase(v_u_28, v_u_24["Purchase Featured Bundle"].DevProductId)
            end
        end)
    end
    for _, v427 in ipairs(v_u_43.Tabs.Container.Credits.Container.Special:GetChildren()) do
        if v427:IsA("Frame") then
            v_u_1.SetupCreditsFrame(v427)
        end
    end
    for _, v428 in ipairs(v_u_43.Tabs.Container.Credits.Container.Standard:GetChildren()) do
        if v428:IsA("Frame") then
            v_u_1.SetupCreditsFrame(v428)
        end
    end
    v_u_8.Heartbeat:Connect(function(p429)
        if v_u_43.Visible then
            for _, v430 in ipairs(v_u_4:GetTagged("StoreRotaterFrame")) do
                v430.Rotation = v430.Rotation + p429 * 25
            end
        end
    end)
    local v431 = v_u_56(v424, { "Content", "Parts", "Content" }) or v424:FindFirstChild("Frame")
    for v432, v_u_433 in pairs(v_u_40) do
        local v434
        if v431 then
            v434 = v431:FindFirstChild(v432)
        else
            v434 = v431
        end
        if v434 then
            local v435, v436, v437 = v_u_73(v434)
            if v435 then
                v_u_13(v435)
                v435.MouseButton1Click:Connect(function()
                    v_u_1.OpenGift("Gift " .. v_u_433.productName, "DevProduct")
                end)
            end
            if v436 then
                v_u_13(v436)
                v436.MouseButton1Click:Connect(function()
                    v_u_2:PromptProductPurchase(v_u_28, v_u_24[v_u_433.productName].DevProductId)
                end)
            end
            if v437 then
                v_u_13(v437)
                v437.MouseButton1Click:Connect(function()
                    v_u_20.broadcastRouter("RunInterfaceSound", "UI Click")
                    v_u_20.broadcastRouter("WeaponInspect", v_u_433.weaponName, v_u_433.skinName, 0, nil, nil, nil, nil, nil, 1, nil, 1, nil)
                end)
            end
        end
    end
    v_u_43.Gift.Search.TextBox.Focused:Connect(function()
        local v438 = v_u_43.Gift.Container:FindFirstChild("SearchResult")
        if v438 then
            v438:Destroy()
        end
        for _, v439 in ipairs(v_u_43.Gift.Container:GetChildren()) do
            if v439:IsA("Frame") then
                v439.Visible = true
            end
        end
    end)
    v_u_43.Gift.Search.TextBox.FocusLost:Connect(function()
        v_u_1.SearchPlayerGift(v_u_43.Gift.Search.TextBox.Text)
    end)
    v_u_8.Heartbeat:Connect(function(p440)
        local v441 = v_u_27:getPosition()
        local v442 = v_u_43.Top.Credits.TextLabel
        local v443 = math.round(v441)
        v442.Text = ("%*"):format((tostring(v443):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
        v_u_27:update(p440)
        local v444 = v_u_29 + 0.85 * p440
        v_u_43.Top.Categories.Credits.TextLabel.UIGradient.Offset = Vector2.new(v444, 0)
        v_u_29 = v444
        if v_u_29 > 1 then
            v_u_29 = -1
        end
        local v445 = workspace:GetServerTimeNow()
        if v_u_32 <= v445 then
            v_u_32 = v445 + 1
            local function v449(p446)
                for _, v447 in ipairs(p446:GetChildren()) do
                    if v447:IsA("Frame") then
                        local v448 = v_u_17.GetCase(v447.Name)
                        if v448 then
                            v_u_176(v447, v448)
                        end
                    end
                end
            end
            v449(v_u_43.Tabs.Container.Featured.Container.Items)
            v449(v_u_43.Tabs.Container.Cases.Cases)
        end
        local v450 = v_u_15.GetActiveBundle()
        if v450 then
            v_u_43.Tabs.Container.Featured.Bundle.Header.Timer.Text = v_u_93(v450.discontinueDate)
        end
    end)
end
function v_u_1.Start()
    v_u_1.OpenTab("Featured")
    local v451, v452 = pcall(function()
        return v_u_5:GetPolicyInfoForPlayerAsync(v_u_28)
    end)
    v_u_30 = not (v451 and (v452 and v452.ArePaidRandomItemsRestricted))
    if not v_u_30 then
        v_u_43.Top.Categories.Credits.Visible = false
    end
    for _, v_u_453 in ipairs(v_u_43.Top.Categories:GetChildren()) do
        if v_u_453:IsA("TextButton") then
            v_u_105(v_u_453)
            v_u_453.MouseButton1Click:Connect(function()
                v_u_1.OpenTab(v_u_453.Name)
            end)
        end
    end
    v_u_43.CaseContent.List.Amount.MouseButton1Click:Connect(function()
        local v_u_454 = v_u_43.CaseContent.List.Amount.Container
        v_u_454.Visible = not v_u_454.Visible
        if v_u_454.Visible then
            v_u_43.CaseContent.List.Amount.Header.ImageLabel.Rotation = 0
            task.defer(function()
                local v455 = v_u_454.AbsoluteCanvasSize.Y - v_u_454.AbsoluteWindowSize.Y
                local v456 = math.max(0, v455)
                v_u_454.CanvasPosition = Vector2.new(v_u_454.CanvasPosition.X, v456)
            end)
        else
            v_u_43.CaseContent.List.Amount.Header.ImageLabel.Rotation = 180
        end
    end)
    for _, v_u_457 in ipairs(v_u_43.CaseContent.List.Amount.Container:GetChildren()) do
        if v_u_457:IsA("TextButton") then
            v_u_457.MouseEnter:Connect(function()
                if not v_u_457:GetAttribute("Selected") then
                    v_u_457.Frame.BackgroundTransparency = 0.5
                end
            end)
            v_u_457.MouseLeave:Connect(function()
                if not v_u_457:GetAttribute("Selected") then
                    v_u_457.Frame.BackgroundTransparency = 1
                end
            end)
            v_u_457.MouseButton1Click:Connect(function()
                local v458 = v_u_34.price
                local v459 = v_u_457.Name
                local v460 = v458 * tonumber(v459)
                v_u_43.CaseContent.List.Buy.Header.TextLabel.Text = ("BUY (%*)"):format((tostring(v460):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
                local v461 = v_u_43.CaseContent.List.Amount.Header.TextLabel
                local v462 = v_u_457.Name
                v461.Text = tostring(v462)
                v_u_43.CaseContent.List.Amount.Container.Visible = false
                for _, v463 in ipairs(v_u_43.CaseContent.List.Amount.Container:GetChildren()) do
                    if v463:IsA("TextButton") then
                        v463.Frame.BackgroundTransparency = v463 == v_u_457 and 0 or 1
                        v463:SetAttribute("Selected", v463 == v_u_457)
                    end
                end
            end)
        end
    end
    v_u_43.Gift.Amount.MouseButton1Click:Connect(function()
        local v_u_464 = v_u_43.Gift.Amount.Container
        v_u_464.Visible = not v_u_464.Visible
        if v_u_464.Visible then
            v_u_43.Gift.Amount.Header.ImageLabel.Rotation = 0
            task.defer(function()
                local v465 = v_u_464.AbsoluteCanvasSize.Y - v_u_464.AbsoluteWindowSize.Y
                local v466 = math.max(0, v465)
                v_u_464.CanvasPosition = Vector2.new(v_u_464.CanvasPosition.X, v466)
            end)
        else
            v_u_43.Gift.Amount.Header.ImageLabel.Rotation = 180
        end
    end)
    for _, v_u_467 in ipairs(v_u_43.Gift.Amount.Container:GetChildren()) do
        if v_u_467:IsA("TextButton") then
            v_u_467.MouseEnter:Connect(function()
                if not v_u_467:GetAttribute("Selected") then
                    v_u_467.Frame.BackgroundTransparency = 0.5
                end
            end)
            v_u_467.MouseLeave:Connect(function()
                if not v_u_467:GetAttribute("Selected") then
                    v_u_467.Frame.BackgroundTransparency = 1
                end
            end)
            v_u_467.MouseButton1Click:Connect(function()
                local v468 = v_u_43.Gift.Amount.Header.TextLabel
                local v469 = v_u_467.Name
                v468.Text = tostring(v469)
                v_u_43.Gift.Amount.Container.Visible = false
                for _, v470 in ipairs(v_u_43.Gift.Amount.Container:GetChildren()) do
                    if v470:IsA("TextButton") then
                        v470.Frame.BackgroundTransparency = v470 == v_u_467 and 0 or 1
                        v470:SetAttribute("Selected", v470 == v_u_467)
                    end
                end
            end)
        end
    end
    v_u_11.CreateListener(v_u_28, "Credits", function(p471)
        v_u_27:setGoal(p471)
    end)
    v_u_11.CreateListener(v_u_28, "Statistics.RobuxSpent", function(p472)
        if v_u_10.MINIMUM_CREDITS_FOR_SPECIAL_CREDITS_OPTION <= p472 then
            v_u_43.Tabs.Container.Credits.Container.Seperator.Visible = true
            v_u_43.Tabs.Container.Credits.Container.Special.Visible = true
        else
            v_u_43.Tabs.Container.Credits.Container.Seperator.Visible = false
            v_u_43.Tabs.Container.Credits.Container.Special.Visible = false
        end
    end)
    v_u_11.CreateListener(v_u_28, "CreatorCode", function(p473)
        if p473 and p473 ~= "" then
            v_u_43.OpenCreatorCode.TextLabel.Text = ("SUPPORT-A-CREATOR: \"%*\""):format(p473)
            v_u_43.CreatorCode.Container.Body.CreatorName.TextBox.Text = p473
        else
            v_u_43.OpenCreatorCode.TextLabel.Text = "SUPPORT-A-CREATOR"
        end
    end)
    v_u_17.ObserveAvailableCases(function(_)
        v_u_1.UpdateCases()
    end)
    v_u_19.UI.UpdateCreatorCode.Listen(function(p474)
        v_u_43.CreatorCode.Container.Action.Confirm.Title.Text = "CONFIRM"
        v_u_67(p474.Type, p474.Text)
    end)
    v_u_19.Store.CaseOpened.Listen(function(p475)
        v_u_48("CaseOpened received from server")
        v_u_48("  CaseId:", p475.CaseId)
        v_u_48("  CaseIdentifier:", p475.CaseIdentifier or "nil")
        v_u_48("  InventoryItems count:", p475.InventoryItems and (#p475.InventoryItems or 0) or 0)
        v_u_48("  DeletedCaseIds count:", p475.DeletedCaseIds and (#p475.DeletedCaseIds or 0) or 0)
        if p475.InventoryItems and #p475.InventoryItems > 0 then
            v_u_11.ApplyInventoryDelta(v_u_28, p475.InventoryItems, p475.DeletedCaseIds)
        end
        if #p475.InventoryItems > 1 then
            v_u_45.isPendingOpenRequest = false
            v_u_45.pendingOpenRequestId = nil
            v_u_45.isQuickUnlock = false
            v_u_1.StartBulkOpening(p475.CaseId, p475.InventoryItems, p475.CaseIdentifier)
        else
            v_u_1.OpenCase(p475.CaseId, p475.InventoryItems[1], p475.CaseIdentifier)
        end
    end)
    v_u_19.Store.CaseOpenDenied.Listen(function()
        v_u_48("CaseOpenDenied received from server")
        v_u_48("  Clearing pending request state")
        v_u_45.isPendingOpenRequest = false
        v_u_45.pendingOpenRequestId = nil
        v_u_45.isQuickUnlock = false
    end)
    v_u_21.OnInspectStateChanged:Connect(function(p476)
        if not p476 then
            task.defer(function()
                local v477 = v_u_21.GetCurrentScreen()
                local v478 = v_u_43.CaseContent:GetAttribute("WasVisibleBeforeInspect") == true
                local v479 = v_u_12.IsActive()
                if v_u_34 and (v477 == "Store" and (v478 and v479)) then
                    v_u_43.Visible = true
                    v_u_43.Tabs.Container.Visible = false
                    v_u_43.CaseContent.Visible = true
                    v_u_44.Menu.Top.Visible = false
                    v_u_43.Top.Visible = false
                    v_u_21.SetBlurEnabled(false)
                    local v480 = v_u_21.GetMenuFrame()
                    if v480 then
                        v480.BackgroundTransparency = 1
                        return
                    end
                elseif v_u_43.CaseContent.Visible and v477 == "Inventory" then
                    v_u_43.Visible = true
                    v_u_43.Tabs.Container.Visible = false
                    v_u_43.CaseContent.Visible = true
                    v_u_44.Menu.Top.Visible = false
                    v_u_43.Top.Visible = false
                    local v481 = v_u_44.Menu:FindFirstChild("Inventory")
                    if v481 then
                        v481.Visible = false
                    end
                    v_u_21.SetBlurEnabled(false)
                    local v482 = v_u_21.GetMenuFrame()
                    if v482 then
                        v482.BackgroundTransparency = 1
                    end
                    if not v_u_12.IsActive() and v_u_34 then
                        v_u_12.ShowCaseScene(v_u_34.caseId)
                    end
                end
            end)
        end
    end)
    v_u_22.observePlayer(function(p483)
        if v_u_28 == p483 then
            return function() end
        end
        local v_u_484 = v_u_3.Assets.UI.Store.PlayerTemplate:Clone()
        v_u_484.Player.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(p483.UserId)
        v_u_484.Player.Username.Text = ("@%*"):format(p483.Name)
        v_u_484.Parent = v_u_43.Gift.Container
        local v485 = p483.UserId
        v_u_484.Name = tostring(v485)
        v_u_1.ActivateGiftTemplate(v_u_484, p483.UserId)
        return function()
            if v_u_484 then
                v_u_484:Destroy()
            end
        end
    end)
end
return v_u_1