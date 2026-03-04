local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = v4.LocalPlayer
local v_u_6 = v_u_5:WaitForChild("PlayerGui")
local v_u_7 = require(v_u_2.Controllers.DataController)
local v_u_8 = require(v_u_2.Database.Components.Libraries.Skins)
local v_u_9 = require(v_u_2.Database.Components.Libraries.Cases)
local v_u_10 = require(v_u_2.Database.Components.Libraries.Collections)
local v_u_11 = require(v_u_2.Database.Security.Router)
local v_u_12 = require(v_u_2.Shared.CloseButtonRegistry)
local v13 = require(v_u_2.Packages.Signal)
local v_u_14 = require(v_u_2.Interface.MenuState)
local v_u_15 = require(v_u_2.Database.Custom.GameStats.UI.Inventory.Sort)
local v_u_16 = require(v_u_2.Database.Custom.GameStats.Rarities)
local v_u_17 = require(v_u_2.Database.Custom.GameStats.Grenades)
local v_u_18 = require(script.Actions)
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = false
local v_u_23 = nil
local v_u_24 = nil
local v_u_25 = nil
local v_u_26 = {}
local v_u_27 = 0
local v_u_28 = nil
local v_u_29 = nil
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = nil
local v_u_33 = nil
v_u_1.OnItemSelected = v13.new()
v_u_1.OnClosed = v13.new()
local function v_u_39(p34, p35)
    local v36 = p34:GetChildren()
    for _, v37 in ipairs(v36) do
        if v37.ClassName == p35 then
            v37:Destroy()
        end
    end
    v_u_10.ObserveAvailableCollections(function(p38)
        v_u_24 = p38
    end)
end
local function v_u_45(p_u_40, p_u_41, _, p_u_42, p_u_43, _)
    p_u_41.MouseEnter:Connect(function()
        v_u_3:Create(p_u_41, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["BackgroundTransparency"] = 0.85
        }):Play()
    end)
    p_u_41.MouseLeave:Connect(function()
        v_u_3:Create(p_u_41, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["BackgroundTransparency"] = 1
        }):Play()
    end)
    p_u_41.MouseButton1Click:Connect(function()
        v_u_11.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_25 = p_u_42
        v_u_1.PopulateItems()
        p_u_43.Text = p_u_42
        for _, v44 in ipairs(p_u_40:GetChildren()) do
            if v44:IsA("TextButton") then
                v44.Frame.BackgroundTransparency = v44 == p_u_41 and 0 or 1
            end
        end
        p_u_40.Visible = false
    end)
end
local function v_u_69(p_u_46)
    local v_u_47 = p_u_46.Size
    local v48 = p_u_46.Button
    p_u_46.MouseEnter:Connect(function()
        local v49 = v_u_3
        local v50 = p_u_46
        local v51 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v52 = {}
        local v53 = v_u_47
        v52.Size = UDim2.new(v53.X.Scale * 0.95, v53.X.Offset, v53.Y.Scale * 0.95, v53.Y.Offset)
        v49:Create(v50, v51, v52):Play()
    end)
    p_u_46.MouseLeave:Connect(function()
        local v54 = v_u_3
        local v55 = p_u_46
        local v56 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v57 = {}
        local v58 = v_u_47
        v57.Size = UDim2.new(v58.X.Scale * 1, v58.X.Offset, v58.Y.Scale * 1, v58.Y.Offset)
        v54:Create(v55, v56, v57):Play()
    end)
    v48.MouseButton1Down:Connect(function()
        local v59 = v_u_3
        local v60 = p_u_46
        local v61 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v62 = {}
        local v63 = v_u_47
        v62.Size = UDim2.new(v63.X.Scale * 0.9, v63.X.Offset, v63.Y.Scale * 0.9, v63.Y.Offset)
        v59:Create(v60, v61, v62):Play()
    end)
    v48.MouseButton1Up:Connect(function()
        local v64 = v_u_3
        local v65 = p_u_46
        local v66 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v67 = {}
        local v68 = v_u_47
        v67.Size = UDim2.new(v68.X.Scale * 0.95, v68.X.Offset, v68.Y.Scale * 0.95, v68.Y.Offset)
        v64:Create(v65, v66, v67):Play()
    end)
end
local function v_u_95()
    if not (v_u_29 and v_u_29.Visible) then
        return 50
    end
    local v70 = v_u_29:FindFirstChildOfClass("UIGridLayout")
    if not v70 then
        return 50
    end
    local v71 = v_u_29.AbsoluteSize
    local v72 = v71.Y
    local v73 = v71.X
    local v74 = v70.CellSize
    local v75 = v70.CellPadding
    local v76 = v74.Y.Scale * v72 + v74.Y.Offset
    local v77 = v75.Y.Scale * v72 + v75.Y.Offset
    local v78 = v74.X.Scale * v73 + v74.X.Offset
    local v79 = v75.X.Scale * v73 + v75.X.Offset
    local v80 = v_u_29:FindFirstChildOfClass("UIPadding")
    local v81, v82, v83, v84
    if v80 then
        v81 = v80.PaddingTop.Scale * v72 + v80.PaddingTop.Offset
        v82 = v80.PaddingBottom.Scale * v72 + v80.PaddingBottom.Offset
        v83 = v80.PaddingLeft.Scale * v73 + v80.PaddingLeft.Offset
        v84 = v80.PaddingRight.Scale * v73 + v80.PaddingRight.Offset
    else
        v81 = 0
        v82 = 0
        v83 = 0
        v84 = 0
    end
    local v85 = v72 - v81 - v82
    local v86 = v73 - v83 - v84
    local v87 = v78 + v79
    local v88
    if v87 > 0 then
        local v89 = (v86 + v79) / v87
        local v90 = math.floor(v89)
        v88 = math.max(1, v90)
    else
        v88 = 1
    end
    local v91 = v76 + v77
    local v92
    if v91 > 0 then
        local v93 = (v85 + v77) / v91
        local v94 = math.floor(v93)
        v92 = math.max(1, v94)
    else
        v92 = 1
    end
    return v92 * v88 + v88
end
local function v_u_106()
    if v_u_29 then
        local function v97(p96)
            if v_u_19 then
                v_u_1.OnItemSelected:Fire(p96, v_u_19)
                v_u_1.Hide()
            end
        end
        v_u_10.ObserveAvailableCollections(function(p98)
            v_u_24 = p98
        end)
        local v99 = v_u_27 + 1
        local v100 = v_u_27 + 25
        local v101 = #v_u_26
        local v102 = math.min(v100, v101)
        for v103 = v99, v102 do
            local v104 = v_u_26[v103]
            if v104 and not v_u_29:FindFirstChild(v104._id) then
                v_u_1.CreateItemTemplate(v104, v97)
            end
        end
        v_u_10.ObserveAvailableCollections(function(p105)
            v_u_24 = p105
        end)
        v_u_27 = v102
    end
end
local function v_u_110()
    if v_u_29 then
        local v107 = v_u_29.CanvasPosition.Y
        local v108 = v_u_29.AbsoluteCanvasSize.Y - v_u_29.AbsoluteSize.Y
        if v108 > 0 and (v_u_27 < #v_u_26 and v108 - v107 < 200) then
            v_u_106()
        end
        v_u_10.ObserveAvailableCollections(function(p109)
            v_u_24 = p109
        end)
    end
end
local function v_u_127()
    if v_u_22 then
        return true
    end
    print("Initializing")
    v_u_32 = v_u_6:FindFirstChild("MainGui")
    if not v_u_32 then
        warn("[UseItemFrame] MainGui not found")
        return false
    end
    local v111 = v_u_32:FindFirstChild("Menu")
    if not v111 then
        warn("[UseItemFrame] Menu frame not found")
        return false
    end
    v_u_28 = v111:FindFirstChild("UseItemFrame")
    if not v_u_28 then
        warn("[UseItemFrame] UseItemFrame not found in Menu")
        return false
    end
    local v112 = v_u_28:FindFirstChild("Tabs")
    local v113 = v112 and v112:FindFirstChild("Inventory")
    if v113 then
        v_u_29 = v113:FindFirstChild("Container")
        v_u_33 = v113:FindFirstChild("Sort")
    end
    v_u_10.ObserveAvailableCollections(function(p114)
        v_u_24 = p114
    end)
    local v_u_115 = v_u_33 and v_u_33:FindFirstChild("Button")
    if v_u_115 then
        local v116 = v_u_115:FindFirstChild("Frame"):FindFirstChild("TextLabel")
        if v116 then
            v116.Text = "Newest"
            v_u_25 = "Newest"
        end
        v_u_115.MouseButton1Click:Connect(function()
            local v117 = v_u_115:FindFirstChild("Options")
            if v117 then
                v117.Visible = not v117.Visible
                v_u_11.broadcastRouter("RunInterfaceSound", "UI Click")
            end
        end)
        local v118 = v_u_115:FindFirstChild("Options")
        local v119 = v_u_115:FindFirstChild("Frame"):FindFirstChild("TextLabel")
        if v118 and v119 then
            for _, v120 in ipairs({
                "Alphabetical",
                "Collection",
                "Equipped",
                "Newest",
                "Quality",
                "Type"
            }) do
                local v121 = v118:FindFirstChild(v120)
                if v121 then
                    v_u_45(v118, v121, nil, v120, v119, v_u_29)
                end
            end
        end
    end
    v_u_10.ObserveAvailableCollections(function(p122)
        v_u_24 = p122
    end)
    local v123 = v_u_28:FindFirstChild("Top")
    if v123 then
        v_u_30 = v123:FindFirstChild("TextLabel")
        v_u_31 = v123:FindFirstChild("Close")
        if not v_u_31 then
            return
        end
        v_u_12.Add(v_u_28, v_u_31, function()
            v_u_11.broadcastRouter("RunInterfaceSound", "UI Click")
            v_u_1.OnClosed:Fire(v_u_19)
            v_u_1.Hide()
        end)
    end
    v_u_10.ObserveAvailableCollections(function(p124)
        v_u_24 = p124
    end)
    v_u_7.CreateListener(v_u_5, "Inventory", function(_)
        if v_u_1.IsVisible() then
            v_u_1.PopulateItems()
        end
    end)
    v_u_14.OnScreenChanged:Connect(function(_, _)
        if v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_19)
            v_u_1.Hide()
        end
    end)
    v_u_14.OnInspectStateChanged:Connect(function(p125)
        if p125 and v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_19)
            v_u_1.Hide()
        end
    end)
    v_u_14.OnCaseSceneStateChanged:Connect(function(p126)
        if p126 and v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_19)
            v_u_1.Hide()
        end
    end)
    if v_u_29 then
        v_u_29:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            v_u_110()
        end)
    end
    v_u_22 = true
    return true
end
function v_u_1.CreateItemTemplate(p_u_128, p_u_129)
    if not (p_u_128 and p_u_128._id) then
        return
    end
    if not v_u_29 then
        return
    end
    local v130 = p_u_128.Type == "Case"
    local v131 = v130 and v_u_9.GetCaseByName(p_u_128.Skin) or v_u_8.GetSkinInformation(p_u_128.Name, p_u_128.Skin)
    if not v131 then
        return
    end
    local v132 = v_u_16[v130 and v131.caseRarity or v131.rarity]
    local v133 = nil
    if v130 then
        v133 = v131.imageAssetId or ""
    elseif p_u_128.Type == "Charm" then
        local v134 = p_u_128.Pattern
        if v134 and v131.charmImages then
            for _, v135 in ipairs(v131.charmImages) do
                if v135.pattern == v134 then
                    v133 = v135.assetId
                    break
                end
            end
        end
        if not v133 then
            v133 = v131.imageAssetId or ""
        end
    else
        v133 = v_u_8.GetWearImageForFloat(v131, p_u_128.Float or 0.9999) or (v131.imageAssetId or "")
    end
    local v_u_136 = v_u_2.Assets.UI.Inventory.ItemTemplate:Clone()
    v_u_136.Main.RarityFrame.UIGradient.Color = v132.ColorSequence
    v_u_136.Main.Glow.UIGradient.Color = v132.ColorSequence
    v_u_136.Parent = v_u_29
    v_u_136.Main.Icon.Image = v133
    v_u_136.Name = p_u_128._id
    local v137 = p_u_128.StatTrack and "KillTrak\226\132\162 " .. p_u_128.Name or p_u_128.Name
    v_u_136.Information.Weapon.Text = v137
    v_u_136.Information.Skin.Text = v130 and v131.skin or p_u_128.Skin
    if p_u_128.Type == "Charm" then
        v_u_136.Button.MouseButton2Click:Connect(function()
            v_u_11.broadcastRouter("RunInterfaceSound", "UI Click")
            v_u_11.broadcastRouter("WeaponInspect", p_u_128.Name, p_u_128.Skin, p_u_128.Float, p_u_128.StatTrack, p_u_128.NameTag, p_u_128.Charm, p_u_128.Stickers, p_u_128.Type, p_u_128.Pattern, p_u_128._id, p_u_128.Serial, p_u_128.IsTradeable)
        end)
    end
    v_u_136.Button.MouseButton1Click:Connect(function()
        v_u_11.broadcastRouter("RunInterfaceSound", "UI Click")
        p_u_129(p_u_128)
    end)
    v_u_136.MouseEnter:Connect(function()
        v_u_21 = v_u_136
        v_u_23 = tick()
    end)
    v_u_136.MouseLeave:Connect(function()
        v_u_21 = nil
        v_u_23 = nil
    end)
    v_u_69(v_u_136)
end
function v_u_1.PopulateItems()
    if v_u_29 then
        v_u_39(v_u_29, "Frame")
        v_u_27 = 0
        v_u_26 = {}
        local v138 = v_u_7.Get(v_u_5, "Inventory")
        if v138 and type(v138) == "table" then
            for _, v139 in ipairs(v138) do
                local v140
                if v139 then
                    v140 = v_u_17[v139.Name]
                else
                    v140 = v139
                end
                local v141
                if v139 then
                    v141 = v139.Type == "Case"
                else
                    v141 = v139
                end
                local v142 = v139 and (v139._id and v139.Name)
                if v142 then
                    v142 = v141 or v139.Skin
                end
                if v142 and not (v140 or v141) and (not (v_u_20 and v_u_19) or v_u_20(v139, v_u_19)) then
                    local v143 = v_u_26
                    table.insert(v143, v139)
                end
            end
            v_u_10.ObserveAvailableCollections(function(p144)
                v_u_24 = p144
            end)
            local v145 = v_u_25 or v_u_33 and v_u_33.Button.Frame.TextLabel.Text or "Newest"
            local v146 = v_u_15.GetSortComparisonFunction(v145, v_u_5, function()
                return v_u_24
            end)
            if v146 then
                table.sort(v_u_26, v146)
            end
            local function v148(p147)
                if v_u_19 then
                    v_u_1.OnItemSelected:Fire(p147, v_u_19)
                    v_u_1.Hide()
                end
            end
            v_u_10.ObserveAvailableCollections(function(p149)
                v_u_24 = p149
            end)
            local v150 = v_u_95()
            local v151 = math.max(v150, 50)
            local v152 = #v_u_26
            local v153 = math.min(v151, v152)
            for v154 = 1, v153 do
                local v155 = v_u_26[v154]
                if v155 then
                    v_u_1.CreateItemTemplate(v155, v148)
                end
            end
            v_u_10.ObserveAvailableCollections(function(p156)
                v_u_24 = p156
            end)
            v_u_27 = v153
        end
    else
        return
    end
end
function v_u_1.Show(p157, p158)
    if v_u_127() then
        if v_u_28 then
            v_u_19 = p157
            v_u_20 = p158
            if v_u_30 then
                if p157.SourceItem then
                    local v159 = p157.SourceItem
                    local v160 = v159.Name
                    if v159.StatTrack then
                        v160 = "KillTrak\226\132\162 " .. v160
                    end
                    if v159.Skin then
                        v160 = v160 .. " | " .. v159.Skin
                    end
                    v_u_30.Text = ("Select an item to use with %*"):format(v160)
                elseif p157.Title then
                    v_u_30.Text = p157.Title
                else
                    v_u_30.Text = "Select an item"
                end
            end
            v_u_10.ObserveAvailableCollections(function(p161)
                v_u_24 = p161
            end)
            v_u_1.PopulateItems()
            v_u_28.Visible = true
        end
    else
        warn("[UseItemFrame] Failed to initialize")
        return
    end
end
function v_u_1.Hide()
    if v_u_28 then
        v_u_28.Visible = false
    end
    v_u_19 = nil
    v_u_20 = nil
end
function v_u_1.IsVisible()
    return v_u_28 and v_u_28.Visible or false
end
function v_u_1.GetCurrentContext()
    return v_u_19
end
v_u_1.Filters = {}
function v_u_1.Filters.WeaponsWithoutCharm(p162, _)
    if p162.Type ~= "Weapon" then
        return false
    end
    local v163
    if p162.Charm == nil or p162.Charm == false then
        v163 = false
    else
        local v164 = p162.Charm
        if type(v164) == "string" or p162.Charm == true then
            v163 = true
        else
            local v165 = p162.Charm
            v163 = type(v165) == "table"
        end
    end
    return not v163
end
local function v173(p166, _)
    if p166.Type ~= "Charm" then
        return false
    end
    local v167 = v_u_7.Get(v_u_5, "Inventory")
    if v167 then
        for _, v168 in ipairs(v167) do
            if v168.Charm then
                local v169 = v168.Charm
                local v170 = type(v169) == "table" and v168.Charm._id
                if not v170 then
                    local v171 = v168.Charm
                    if type(v171) == "string" then
                        v170 = v168.Charm
                    else
                        v170 = false
                    end
                end
                if v170 == p166._id then
                    return false
                end
            end
        end
    end
    v_u_10.ObserveAvailableCollections(function(p172)
        v_u_24 = p172
    end)
    return true
end
v_u_1.Filters.AllCharms = v173
function v_u_1.Filters.AllWeapons(p174, _)
    return p174.Type == "Weapon"
end
function v_u_1.Filters.AllMelees(p175, _)
    return p175.Type == "Melee"
end
function v_u_1.Filters.AllGloves(p176, _)
    return p176.Type == "Glove"
end
function v_u_1.Initialize(p177, p178)
    v_u_32 = p177
    v_u_28 = p178
    local v179 = p178:FindFirstChild("Tabs")
    local v180 = v179 and v179:FindFirstChild("Inventory")
    if v180 then
        v_u_29 = v180:FindFirstChild("Container")
        v_u_33 = v180:FindFirstChild("Sort")
    end
    v_u_10.ObserveAvailableCollections(function(p181)
        v_u_24 = p181
    end)
    if v_u_33 then
        local v_u_182 = v_u_33:FindFirstChild("Button")
        if v_u_182 then
            local v183 = v_u_182:FindFirstChild("Frame"):FindFirstChild("TextLabel")
            if v183 then
                v183.Text = "Newest"
                v_u_25 = "Newest"
            end
            v_u_182.MouseButton1Click:Connect(function()
                local v184 = v_u_182:FindFirstChild("Options")
                if v184 then
                    v184.Visible = not v184.Visible
                    v_u_11.broadcastRouter("RunInterfaceSound", "UI Click")
                end
            end)
            local v185 = v_u_182:FindFirstChild("Options")
            local v186 = v_u_182:FindFirstChild("Frame"):FindFirstChild("TextLabel")
            if v185 and v186 then
                for _, v187 in ipairs({
                    "Alphabetical",
                    "Collection",
                    "Equipped",
                    "Newest",
                    "Quality",
                    "Type"
                }) do
                    local v188 = v185:FindFirstChild(v187)
                    if v188 then
                        v_u_45(v185, v188, nil, v187, v186, v_u_29)
                    end
                end
            end
        end
    end
    v_u_10.ObserveAvailableCollections(function(p189)
        v_u_24 = p189
    end)
    local v190 = p178:FindFirstChild("Top")
    if v190 then
        v_u_30 = v190:FindFirstChild("TextLabel")
        v_u_31 = v190:FindFirstChild("Close")
        if not v_u_31 then
            return
        end
        v_u_12.Add(v_u_28, v_u_31, function()
            v_u_11.broadcastRouter("RunInterfaceSound", "UI Click")
            v_u_1.OnClosed:Fire(v_u_19)
            v_u_1.Hide()
        end)
    end
    v_u_10.ObserveAvailableCollections(function(p191)
        v_u_24 = p191
    end)
    if v_u_29 then
        v_u_29:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            v_u_110()
        end)
    end
    p178.Visible = false
    v_u_22 = true
end
function v_u_1.Start()
    v_u_18.InitializeAll()
    v_u_7.CreateListener(v_u_5, "Inventory", function(_)
        if v_u_1.IsVisible() then
            v_u_1.PopulateItems()
        end
    end)
    v_u_14.OnScreenChanged:Connect(function(_, _)
        if v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_19)
            v_u_1.Hide()
        end
    end)
    v_u_14.OnInspectStateChanged:Connect(function(p192)
        if p192 and v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_19)
            v_u_1.Hide()
        end
    end)
    v_u_14.OnCaseSceneStateChanged:Connect(function(p193)
        if p193 and v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_19)
            v_u_1.Hide()
        end
    end)
end
function v_u_1.TriggerAction(p194, p195)
    local v196 = v_u_18.Get(p194)
    if v196 then
        local v197 = v196.GetContext(p195)
        local v198 = v196.GetFilter(p195)
        v_u_1.Show(v197, v198)
    else
        warn((("[UseItemFrame] Unknown action type: %*"):format(p194)))
    end
end
function v_u_1.GetActions()
    return v_u_18
end
return v_u_1