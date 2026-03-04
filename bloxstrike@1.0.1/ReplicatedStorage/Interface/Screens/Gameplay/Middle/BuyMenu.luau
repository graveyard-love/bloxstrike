local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v5 = game:GetService("Players")
local v_u_6 = game:GetService("HttpService")
require(script:WaitForChild("Types"))
local v_u_7 = v5.LocalPlayer
local v_u_8 = require(v_u_2.Controllers.InventoryController)
local v_u_9 = require(v_u_2.Controllers.EndScreenController)
local v_u_10 = require(v_u_2.Controllers.CameraController)
local v_u_11 = require(v_u_2.Controllers.DataController)
local v_u_12 = require(v_u_2.Database.Components.Common.AttachGlovesToCharacter)
local v_u_13 = require(v_u_2.Database.Components.Common.RemoveFromArray)
local v_u_14 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_15 = require(v_u_2.Components.Common.GetPreferenceColor)
local v_u_16 = require(v_u_2.Database.Components.Common.IsInBuyArea)
local v_u_17 = require(v_u_2.Components.Common.GetTimerFormat)
local v_u_18 = require(v_u_2.Database.Components.GameState)
local v_u_19 = require(v_u_2.Packages.Observers)
local v20 = require(v_u_2.Shared.Janitor)
local v21 = require(v_u_2.Shared.Spring)
local v_u_22 = require(v_u_2.Database.Security.Remotes)
local v_u_23 = require(v_u_2.Database.Security.Router)
local v_u_24 = require(v_u_2.Database.Custom.GameStats.Grenades)
local v_u_25 = v_u_2.Assets.Characters
local v_u_26 = require(v_u_2.Database.Custom.GameStats.NumberSlots)
local v_u_27 = require(v_u_2.Database.Custom.GameStats.Character.Attachments)
local v_u_28 = require(v_u_2.Database.Custom.GameStats.Character.Viewport)
local v_u_29 = require(v_u_2.Shared.ViewportModel)
local v_u_30 = v20.new()
local v_u_31 = v20.new()
local v_u_32 = v21.new(1, 8, 0)
local v_u_33 = nil
local v_u_34 = nil
local v_u_35 = nil
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = nil
local v_u_39 = nil
local v_u_40 = {}
local v_u_41 = nil
local v_u_42 = nil
local v_u_43 = {
    ["1"] = "Kevlar",
    ["2"] = "Kevlar + Helmet"
}
local v_u_44 = {
    ["Kevlar"] = true,
    ["Kevlar + Helmet"] = true,
    ["Defuse Kit"] = true,
    ["Rescue Kit"] = true
}
local function v_u_48(p45)
    if v_u_44[p45] and workspace:GetAttribute("ServerGamemode") ~= "Competitive" then
        return false
    elseif p45 == "Defuse Kit" or p45 == "Rescue Kit" then
        local v46 = v_u_7:GetAttribute("Team")
        local v47 = workspace:GetAttribute("Gamemode")
        if v46 == "Counter-Terrorists" then
            if p45 == "Defuse Kit" then
                return v47 == "Bomb Defusal"
            else
                return p45 ~= "Rescue Kit" and true or v47 == "Hostage Rescue"
            end
        else
            return false
        end
    else
        return true
    end
end
local function v_u_53(p49, p50, p51, p52)
    if p49 == nil then
        return nil
    else
        return p50 == "SniperScope" and "Sniper" or (p49 == "Heavy" and (p51 == "MachineGun" and "LMG" or "Heavy") or (p49 == "Equipment" and p52 == "Grenade" and "Grenade" or ({
            ["Pistol"] = "Pistol",
            ["Rifle"] = "Rifle",
            ["SMG"] = "SMG",
            ["Equipment"] = nil,
            ["Miscellaneous"] = nil
        })[p49]))
    end
end
local function v_u_60()
    local v_u_54 = v_u_7:GetAttribute("Armor")
    if typeof(v_u_54) == "string" and v_u_54 ~= "" then
        local v55, v56 = pcall(function()
            return v_u_6:JSONDecode(v_u_54)
        end)
        if v55 and typeof(v56) == "table" then
            local v57 = {}
            local v58 = v56.Type or ""
            v57.Type = tostring(v58)
            local v59 = v56.Health
            v57.Health = tonumber(v59) or 0
            return v57
        end
    end
    return {
        ["Type"] = "",
        ["Health"] = 0
    }
end
local function v_u_65(p61)
    if p61 == "Defuse Kit" then
        return v_u_7:GetAttribute("HasDefuseKit") == true
    end
    if p61 == "Rescue Kit" then
        return v_u_7:GetAttribute("HasRescueKit") == true
    end
    local v62 = v_u_60()
    if p61 == "Kevlar" then
        local v63
        if v62.Health > 0 then
            v63 = v62.Type == "Kevlar"
        else
            v63 = false
        end
        return v63
    end
    if p61 ~= "Kevlar + Helmet" then
        return false
    end
    local v64
    if v62.Health > 0 then
        v64 = v62.Type == "Kevlar + Helmet"
    else
        v64 = false
    end
    return v64
end
local function v_u_71(p66)
    if v_u_48(p66) then
        if p66 == "Defuse Kit" or p66 == "Rescue Kit" then
            return v_u_65(p66)
        else
            local v67 = v_u_60()
            if p66 == "Kevlar" then
                local v68
                if v67.Type == "Kevlar + Helmet" then
                    v68 = v67.Health > 0
                else
                    v68 = false
                end
                local v69
                if v67.Type == "Kevlar" then
                    v69 = v67.Health >= 100
                else
                    v69 = false
                end
                return v68 or v69
            else
                if p66 ~= "Kevlar + Helmet" then
                    return false
                end
                local v70
                if v67.Type == "Kevlar + Helmet" then
                    v70 = v67.Health >= 100
                else
                    v70 = false
                end
                return v70
            end
        end
    else
        return true
    end
end
local function v_u_84()
    for _, v72 in ipairs(v_u_41.Menu.Container:GetDescendants()) do
        if v72:IsA("TextButton") then
            if v72.Parent.Name == "Equipment" then
                local v73 = v72.Name
                local v74 = v_u_43[v73]
                if v74 then
                    if not v_u_48(v74) then
                        v74 = nil
                    end
                elseif v73 == "3" then
                    local v75
                    if v_u_44["Defuse Kit"] and workspace:GetAttribute("ServerGamemode") ~= "Competitive" then
                        v75 = false
                    else
                        local v76 = v_u_7:GetAttribute("Team")
                        local v77 = workspace:GetAttribute("Gamemode")
                        if v76 == "Counter-Terrorists" then
                            v75 = v77 == "Bomb Defusal"
                        else
                            v75 = false
                        end
                    end
                    if v75 then
                        v74 = "Defuse Kit"
                    else
                        local v78
                        if v_u_44["Rescue Kit"] and workspace:GetAttribute("ServerGamemode") ~= "Competitive" then
                            v78 = false
                        else
                            local v79 = v_u_7:GetAttribute("Team")
                            local v80 = workspace:GetAttribute("Gamemode")
                            if v79 == "Counter-Terrorists" then
                                v78 = v80 == "Hostage Rescue"
                            else
                                v78 = false
                            end
                        end
                        v74 = v78 and "Rescue Kit" or nil
                    end
                else
                    v74 = nil
                end
                if v74 then
                    v_u_1.createTemplate(v72, {
                        ["Name"] = v74,
                        ["_id"] = ("equipment:%*"):format(v74)
                    }, true, nil)
                else
                    v72:SetAttribute("IsEquipment", nil)
                    v72:SetAttribute("Weapon", nil)
                    v72.Visible = false
                end
            else
                local v81 = v_u_1.setupTemplate
                local v82 = v72.Parent.Name
                local v83 = v72.Name
                v81(v72, (("Loadout.%*.Options.%*"):format(v82, (tonumber(v83)))))
            end
        end
    end
end
local function v_u_89(p85, p86)
    for _, v87 in ipairs(p85) do
        for _, v88 in ipairs(v87._items) do
            if v88.Name == p86 then
                return v88
            end
        end
    end
    return false
end
local function v_u_94(p90, p91)
    for _, v92 in ipairs(p90) do
        for _, v93 in ipairs(v92._items) do
            if v93.Name == p91 and table.find(v_u_40, v93.Identifier) then
                return v93
            end
        end
    end
    return v_u_89(p90, p91)
end
local function v_u_100(p95, p96)
    local v97 = 0
    for _, v98 in ipairs(p95) do
        for _, v99 in ipairs(v98._items) do
            if v99.Name == p96 then
                v97 = v97 + 1
            end
        end
    end
    return v97
end
local function v_u_104(p101, p102)
    local v103 = p101:GetAttribute(p102)
    while not v103 do
        v103 = p101:GetAttribute(p102)
        task.wait()
    end
    return v103
end
local function v_u_113()
    local v105 = 0
    local v106 = v_u_18.GetState()
    if v106 == "Buy Period" or v106 == "Round In Progress" then
        local v107 = workspace:GetAttribute("BuyTimerRemaining")
        if typeof(v107) == "number" then
            local v108 = math.floor(v107)
            v105 = math.max(0, v108)
        else
            local v109 = workspace:GetAttribute("Timer")
            if typeof(v109) == "number" then
                local v110 = math.floor(v109)
                v105 = math.max(0, v110)
            end
        end
    else
        local v111 = workspace:GetAttribute("Timer")
        if typeof(v111) == "number" then
            local v112 = math.floor(v111)
            v105 = math.max(0, v112)
        end
    end
    v_u_41.Menu.TopFrame.Timer.Text = v_u_17(v105)
end
function v_u_1.purchase(p114, p115, p116, p117)
    local v118 = v_u_7:GetAttribute("Money")
    local v119 = workspace:GetAttribute("Gamemode")
    if p117 and v_u_71(p114) then
        return
    elseif v_u_16(v_u_7) then
        local v120 = (v119 == "Deathmatch" or v_u_18.GetState() == "Warmup") and 0 or p116
        local v121 = not p117
        if v121 then
            v121 = v_u_24[p114] ~= nil
        end
        local v122 = v121 and v_u_8.getCurrentInventory()
        if v122 then
            local v123 = v122[v_u_26.Grenade]
            if v123 and #v123._items >= v123._settings._strict_slot_space then
                return
            end
        end
        if not p117 and (v_u_7:GetAttribute("BuyMenu") and (v119 == "Hostage Rescue" or v119 == "Bomb Defusal")) then
            local v124 = v_u_8.getCurrentInventory()
            local v125 = v_u_2.Database.Custom.Weapons:FindFirstChild(p114) or v_u_2.Database.Custom.GameStats.Equipment:FindFirstChild(p114)
            local v126
            if v125 then
                v126 = require(v125)
            else
                v126 = nil
            end
            local v127 = v_u_26[v126.Slot]
            if v124 and v126 then
                local v128 = v124[v127]
                if v128 and #v128._items > 0 then
                    local v129 = v128._items[1]
                    if table.find(v_u_40, v129.Identifier) then
                        local v130 = v129.Name
                        local v131 = v_u_2.Database.Custom.Weapons:FindFirstChild(v130) or v_u_2.Database.Custom.GameStats.Equipment:FindFirstChild(v130)
                        local v132
                        if v131 then
                            v132 = require(v131)
                        else
                            v132 = nil
                        end
                        if v132 then
                            local v133 = v132.Cost
                            v120 = p116 - (v129.Name == "Molotov" and v_u_7:GetAttribute("Team") == "Counter-Terrorists" and 500 or v133)
                        end
                    end
                end
            end
        end
        if v118 and v120 <= v118 then
            v_u_23.broadcastRouter("RunInterfaceSound", "Successful Buy Menu Purchase")
            v_u_22.Inventory.BuyMenuPurchase.Send({
                ["Equipment"] = p117,
                ["Name"] = p114,
                ["Path"] = p115 or ""
            })
        end
    end
end
function v_u_1.createTemplate(p_u_134, p_u_135, p_u_136, p_u_137)
    local v138 = p_u_135.Name
    local v139 = v_u_2.Database.Custom.Weapons:FindFirstChild(v138) or v_u_2.Database.Custom.GameStats.Equipment:FindFirstChild(v138)
    local v140
    if v139 then
        v140 = require(v139)
    else
        v140 = nil
    end
    if v140 then
        local v141 = workspace:GetAttribute("Gamemode")
        local v142 = p_u_135.Name
        local v_u_143
        if workspace:GetAttribute("Gamemode") == "Deathmatch" or v_u_18.GetState() == "Warmup" then
            v_u_143 = 0
        else
            local v144 = v140.Cost
            v_u_143 = v142 == "Molotov" and v_u_7:GetAttribute("Team") == "Counter-Terrorists" and 500 or v144
        end
        local v145 = v140.ReverseIcon or v140.Icon
        p_u_134.Icon.Image = v145
        p_u_134.Cost.Text = "$" .. tostring(v_u_143):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        local v146 = p_u_134.Keybind
        local v147 = p_u_134.Name
        local v148 = tonumber(v147)
        v146.Text = tostring(v148)
        p_u_134.Cost.Visible = v141 ~= "Deathmatch"
        local v149 = p_u_134.Name
        p_u_134.LayoutOrder = tonumber(v149)
        p_u_134.ItemName.Text = p_u_135.Name
        p_u_134.Teammates.Visible = false
        p_u_134.Visible = true
        local v150 = v_u_7
        local v151 = tonumber(v150:GetAttribute("Money")) or 0
        local v152
        if p_u_136 then
            v152 = v_u_71(p_u_135.Name)
        else
            v152 = p_u_136
        end
        local v153 = (v151 < v_u_143 or v152) and Color3.fromRGB(149, 149, 149) or v_u_15()
        p_u_134.ItemName.TextColor3 = v153
        p_u_134.Keybind.TextColor3 = v153
        p_u_134.Icon.ImageColor3 = v153
        p_u_134.Cost.TextColor3 = v153
        p_u_134:SetAttribute("Weapon", p_u_135.Name)
        p_u_134:SetAttribute("IsEquipment", p_u_136)
        p_u_134:SetAttribute("InventoryItemId", p_u_135._id)
        local v154 = v_u_8.getCurrentInventory()
        local v155 = false
        local v156 = false
        if p_u_136 then
            v155 = v_u_65(p_u_135.Name)
        elseif v154 then
            v155 = v_u_100(v154, p_u_135.Name) > 0
            local v157 = p_u_135.Name
            local v158 = v_u_100(v154, v157)
            local v159 = v_u_24[v157]
            if v159 then
                v156 = v158 < v159
            elseif v158 == 0 then
                v156 = true
            else
                v156 = false
            end
        end
        local v160 = p_u_134.Return
        local v161
        if v155 then
            if v_u_18.GetState() == "Warmup" or v141 == "Deathmatch" then
                v161 = false
            elseif p_u_136 then
                v161 = p_u_136
            else
                local v162
                if p_u_134.Parent.Name == "Pistols" then
                    v162 = p_u_134.Name == "1"
                else
                    v162 = false
                end
                v161 = not v162
            end
        else
            v161 = v155
        end
        v160.Visible = v161
        p_u_134.Hover.Visible = v155
        p_u_134.Hover.UIStroke.Transparency = v155 and not v156 and 0 or 1
        v_u_30:Add(p_u_134.MouseEnter:Connect(function()
            local v163 = v_u_8.getCurrentInventory()
            v_u_23.broadcastRouter("RunInterfaceSound", "UI Highlight")
            local v164 = p_u_136 and v_u_65(p_u_135.Name)
            if v164 then
                v163 = v164
            elseif v163 then
                v163 = v_u_89(v163, p_u_135.Name)
            end
            if not v163 then
                p_u_134.Hover.UIStroke.Transparency = 1
                p_u_134.Hover.Visible = true
                v_u_3:Create(p_u_134.Hover.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Transparency"] = 0.8
                }):Play()
            end
            v_u_3:Create(p_u_134.Icon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = UDim2.fromScale(0.7, 0.7)
            }):Play()
            if not p_u_136 then
                v_u_35 = p_u_135._id
            end
        end))
        v_u_30:Add(p_u_134.MouseLeave:Connect(function()
            local v165 = v_u_8.getCurrentInventory()
            local v166 = p_u_136 and v_u_65(p_u_135.Name)
            if v166 then
                v165 = v166
            elseif v165 then
                v165 = v_u_89(v165, p_u_135.Name)
            end
            if not v165 then
                p_u_134.Hover.UIStroke.Transparency = 1
                p_u_134.Hover.Visible = false
            end
            v_u_3:Create(p_u_134.Icon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = UDim2.fromScale(0.75, 0.75)
            }):Play()
            if not p_u_136 and v_u_35 == p_u_135._id then
                v_u_35 = nil
            end
        end))
        v_u_30:Add(p_u_134.MouseButton1Down:Connect(function()
            v_u_3:Create(p_u_134.Icon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = UDim2.fromScale(0.65, 0.65)
            }):Play()
        end))
        v_u_30:Add(p_u_134.MouseButton1Up:Connect(function()
            v_u_3:Create(p_u_134.Icon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = UDim2.fromScale(0.7, 0.7)
            }):Play()
        end))
        v_u_30:Add(p_u_134.MouseButton1Click:Connect(function()
            v_u_1.purchase(p_u_135.Name, p_u_137, v_u_143, p_u_136)
        end))
        v_u_30:Add(p_u_134.Return.MouseButton1Click:Connect(function()
            if p_u_136 then
                if v_u_16(v_u_7) then
                    v_u_22.Inventory.ReturnBuyMenuPurchase.Send({
                        ["Identifier"] = p_u_135.Name,
                        ["Equipment"] = true
                    })
                end
                return
            else
                local v167 = v_u_8.getCurrentInventory()
                if v167 then
                    local v168 = v_u_94(v167, p_u_135.Name)
                    if v168 and v_u_16(v_u_7) then
                        v_u_22.Inventory.ReturnBuyMenuPurchase.Send({
                            ["Identifier"] = v168.Identifier,
                            ["Equipment"] = false
                        })
                    end
                end
            end
        end))
    else
        p_u_134.Visible = false
    end
end
function v_u_1.setupTemplate(p169, p170)
    local v171 = v_u_23.broadcastRouter("GetEquippedInventoryItem", v_u_7, p170)
    if v171 and v171.Name then
        v_u_1.createTemplate(p169, v171, false, p170)
    else
        p169:SetAttribute("IsEquipment", nil)
        p169:SetAttribute("Weapon", nil)
        p169.Visible = false
    end
end
function v_u_1.updateBuyMenuTemplate(p172, p173)
    local v174 = p173:GetAttribute("IsEquipment")
    local v175 = p173:GetAttribute("Weapon")
    if v175 then
        local v176 = v_u_2.Database.Custom.Weapons:FindFirstChild(v175) or v_u_2.Database.Custom.GameStats.Equipment:FindFirstChild(v175)
        local v177
        if v176 then
            v177 = require(v176)
        else
            v177 = nil
        end
        if v177 then
            local v178
            if workspace:GetAttribute("Gamemode") == "Deathmatch" or v_u_18.GetState() == "Warmup" then
                v178 = 0
            else
                local v179 = v177.Cost
                v178 = v175 == "Molotov" and v_u_7:GetAttribute("Team") == "Counter-Terrorists" and 500 or v179
            end
            p173.Cost.Text = "$" .. tostring(v178):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
            local v180 = v_u_7:GetAttribute("Money")
            local v181
            if v174 then
                v181 = v_u_71(v175)
            else
                v181 = v174
            end
            if v180 then
                local v182 = (v180 < v178 or v181) and Color3.fromRGB(149, 149, 149) or v_u_15()
                p173.ItemName.TextColor3 = v182
                p173.Keybind.TextColor3 = v182
                p173.Icon.ImageColor3 = v182
                p173.Cost.TextColor3 = v182
            end
        end
        if p173.Visible then
            local v183 = false
            local v184 = false
            if v174 then
                v183 = v_u_65(v175)
            elseif p172 then
                v183 = v_u_100(p172, v175) > 0
                local v185 = v_u_100(p172, v175)
                local v186 = v_u_24[v175]
                if v186 then
                    v184 = v185 < v186
                elseif v185 == 0 then
                    v184 = true
                else
                    v184 = false
                end
            end
            local v187 = workspace:GetAttribute("Gamemode")
            local v188 = p173.Return
            if v183 then
                if v187 == "Deathmatch" or v_u_18.GetState() == "Warmup" then
                    v174 = false
                elseif not v174 then
                    local v189
                    if p173.Parent.Name == "Pistols" then
                        v189 = p173.Name == "1"
                    else
                        v189 = false
                    end
                    v174 = not v189
                end
            else
                v174 = v183
            end
            v188.Visible = v174
            p173.Hover.Visible = v183
            if v183 then
                v_u_3:Create(p173.Hover.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Transparency"] = v184 and 1 or 0
                }):Play()
            else
                p173.Hover.UIStroke.Transparency = 1
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_241(p190)
    local v191 = v_u_37
    if v191 then
        if p190 and v_u_34 == p190._id then
            local v192 = v_u_33
            if not (v192 and v192.IsPlaying) then
                local v193 = v191:FindFirstChildOfClass("Humanoid")
                local v194 = v193 and v193:FindFirstChildOfClass("Animator")
                if v194 then
                    local v195 = nil
                    if p190.Type == "Melee" then
                        v195 = "Melee"
                    else
                        local v196, v197 = pcall(v_u_14, p190.Name)
                        if v196 and v197 then
                            v195 = v_u_53(v197.Type, v197.AimingOptions, v197.MuzzleType, v197.Class)
                        end
                    end
                    if v195 then
                        local v198 = p190.Name
                        local v199
                        if v195 and v_u_28.ANIMATION_MAPPING[v195] then
                            local v200 = v_u_28.ANIMATION_MAPPING[v195]
                            if v198 and v200[v198] then
                                v199 = v200[v198]
                            else
                                v199 = v200.Default
                            end
                        else
                            v199 = nil
                        end
                        if v199 then
                            local v201 = v194:LoadAnimation(v199)
                            v201.Looped = true
                            v201.Priority = Enum.AnimationPriority.Action
                            v201:Play()
                            v_u_33 = v201
                        end
                    end
                end
            end
            return
        else
            if v_u_33 then
                v_u_33:Stop()
                v_u_33 = nil
            end
            if v_u_36 then
                v_u_36:Destroy()
                v_u_36 = nil
            end
            v_u_34 = nil
            for _, v202 in pairs({ v_u_27.DEFAULT_JOINT_PART, "UpperTorso", "LeftHand" }) do
                local v203 = v191:FindFirstChild(v202)
                if v203 then
                    for _, v204 in ipairs(v203:GetChildren()) do
                        if v204:IsA("Motor6D") and (v204.Name == "WeaponAttachment" or (v204.Name == "WeaponAttachmentHandleR" or v204.Name == "WeaponAttachmentHandleL")) then
                            v204:Destroy()
                        end
                    end
                end
            end
            local v205 = { v191, v_u_38 }
            for _, v206 in ipairs(v205) do
                if v206 then
                    for _, v207 in ipairs(v206:GetChildren()) do
                        if v207:IsA("Model") and (v207 ~= v191 and v207.Name ~= "CharacterArmor") and (v207:FindFirstChild("Insert", true) or v207:FindFirstChild("Weapon", true)) then
                            v207:Destroy()
                        end
                    end
                end
            end
            if p190 then
                local v208 = require(v_u_2.Database.Components.Libraries.Skins).GetCharacterModel(p190.Name, p190.Skin, p190.Float, p190.StatTrack, p190.NameTag)
                if v208 then
                    v208.Name = p190.Name
                    local v209 = v191:FindFirstChild(v_u_27.WEAPON_JOINT_PARTS[p190.Name] or v_u_27.DEFAULT_JOINT_PART)
                    if v209 then
                        if not v208.PrimaryPart then
                            local v210 = v208:FindFirstChild("Weapon")
                            if v210 then
                                v210 = v210:FindFirstChild("Insert")
                            end
                            if v210 then
                                v208.PrimaryPart = v210
                            else
                                local v211 = v208:FindFirstChild("Insert", true)
                                if v211 then
                                    v208.PrimaryPart = v211
                                end
                            end
                        end
                        if v208.PrimaryPart then
                            for _, v212 in ipairs(v208:GetDescendants()) do
                                if v212:IsA("BasePart") then
                                    v212.CanCollide = false
                                    v212.CanQuery = false
                                    v212.CanTouch = false
                                    v212.Anchored = false
                                    v212.Massless = true
                                end
                            end
                            v208.Parent = v_u_38
                            local v213, v214 = pcall(v_u_14, p190.Name)
                            local v215
                            if v213 and v214 then
                                v215 = v214.ShootingOptions == "Dual"
                            else
                                v215 = false
                            end
                            local v216 = v208:FindFirstChild("Properties")
                            if not v216 then
                                local v217 = v208:FindFirstChild("Weapon")
                                if v217 then
                                    v216 = v217:FindFirstChild("Properties")
                                end
                            end
                            local v218 = v216 or v208:FindFirstChild("Properties", true)
                            if v215 then
                                local v219 = v191:FindFirstChild("RightHand")
                                local v220 = v191:FindFirstChild("LeftHand")
                                if v219 and v220 then
                                    local v221 = v208:FindFirstChild("HandleR", true)
                                    if v221 then
                                        local v222 = Instance.new("Motor6D")
                                        v222.Name = "WeaponAttachmentHandleR"
                                        v222.Part0 = v219
                                        v222.Part1 = v221
                                        v222.Parent = v219
                                        if v218 then
                                            local v223 = v218:FindFirstChild("C0RIGHT")
                                            if v223 then
                                                v222.C0 = v223.Value
                                            end
                                            local v224 = v218:FindFirstChild("C1RIGHT")
                                            if v224 then
                                                v222.C1 = v224.Value
                                            end
                                        end
                                    end
                                    local v225 = v208:FindFirstChild("HandleL", true)
                                    if v225 then
                                        local v226 = Instance.new("Motor6D")
                                        v226.Name = "WeaponAttachmentHandleL"
                                        v226.Part0 = v220
                                        v226.Part1 = v225
                                        v226.Parent = v220
                                        if v218 then
                                            local v227 = v218:FindFirstChild("C0LEFT")
                                            if v227 then
                                                v226.C0 = v227.Value
                                            end
                                            local v228 = v218:FindFirstChild("C1LEFT")
                                            if v228 then
                                                v226.C1 = v228.Value
                                            end
                                        end
                                    end
                                end
                            else
                                local v229 = Instance.new("Motor6D")
                                v229.Name = "WeaponAttachment"
                                v229.Part0 = v209
                                v229.Part1 = v208.PrimaryPart
                                v229.Parent = v209
                                if v218 then
                                    local v230 = v218:FindFirstChild("C0")
                                    if v230 then
                                        v229.C0 = v230.Value
                                    end
                                    local v231 = v218:FindFirstChild("C1")
                                    if v231 then
                                        v229.C1 = v231.Value
                                    end
                                end
                            end
                            v_u_36 = v208
                            v_u_34 = p190._id
                            local v232 = v191:FindFirstChildOfClass("Humanoid")
                            if v232 then
                                local v233 = v232:FindFirstChildOfClass("Animator")
                                if v233 then
                                    local v234 = nil
                                    if p190.Type == "Melee" then
                                        v234 = "Melee"
                                    elseif v214 then
                                        v234 = v_u_53(v214.Type, v214.AimingOptions, v214.MuzzleType, v214.Class)
                                    else
                                        local v235, v236 = pcall(v_u_14, p190.Name)
                                        if v235 and v236 then
                                            v234 = v_u_53(v236.Type, v236.AimingOptions, v236.MuzzleType, v236.Class)
                                        end
                                    end
                                    if v234 then
                                        local v237 = p190.Name
                                        local v238
                                        if v234 and v_u_28.ANIMATION_MAPPING[v234] then
                                            local v239 = v_u_28.ANIMATION_MAPPING[v234]
                                            if v237 and v239[v237] then
                                                v238 = v239[v237]
                                            else
                                                v238 = v239.Default
                                            end
                                        else
                                            v238 = nil
                                        end
                                        if v238 then
                                            local v240 = v233:LoadAnimation(v238)
                                            v240.Looped = true
                                            v240.Priority = Enum.AnimationPriority.Action
                                            v240:Play()
                                            v_u_33 = v240
                                        end
                                    end
                                end
                            else
                                return
                            end
                        else
                            v208:Destroy()
                            return
                        end
                    else
                        v208:Destroy()
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
local function v_u_251()
    local v242 = v_u_37
    if not v242 then
        return
    end
    local v243 = v_u_7:GetAttribute("Team")
    if not v243 or v243 ~= "Counter-Terrorists" and v243 ~= "Terrorists" then
        return
    end
    local v244 = (v243 == "Counter-Terrorists" and "CT" or "T") == "CT" and "Counter-Terrorists" or "Terrorists"
    local v245 = v_u_11.Get(v_u_7, "Loadout")
    if not (v245 and v245[v244]) then
        return
    end
    local v246 = v245[v244].Equipped
    if v246 then
        v246 = v245[v244].Equipped["Equipped Gloves"]
    end
    if not v246 then
        return
    end
    local v247 = v_u_11.Get(v_u_7, "Inventory")
    local v248 = nil
    if v247 and type(v247) == "table" then
        for _, v249 in ipairs(v247) do
            if v249 and v249._id == v246 then
                v248 = v249
                break
            end
        end
    end
    if v248 then
        local v250 = require(v_u_2.Database.Components.Libraries.Skins).GetGloves(v248.Name, v248.Skin, v248.Float)
        if v250 then
            v_u_12(v250:GetChildren(), v242, v242)
            v250:Destroy()
        end
    else
        return
    end
end
local function v_u_265()
    v_u_11.WaitForDataLoaded(v_u_7)
    if v_u_35 then
        local v252 = v_u_11.Get(v_u_7, "Inventory")
        if v252 and type(v252) == "table" then
            for _, v253 in ipairs(v252) do
                if v253 and v253._id == v_u_35 then
                    v_u_241(v253)
                    return
                end
            end
        end
        return
    end
    local v254 = v_u_8.getCurrentInventory()
    local v255 = v_u_11.Get(v_u_7, "Inventory")
    if not v254 or (not v255 or type(v255) ~= "table") then
        return
    end
    local v264 = nil
    local v257 = v254[1]
    if v257 and (v257._items and #v257._items > 0) then
        local v258 = v257._items[1]
        if not (v258 and v258._id) then
            goto l16
        end
        local v259 = v258._id
        for _, v264 in ipairs(v255) do
            if v264._id == v259 then
                goto l16
            end
        end
        v264 = nil
        goto l16
    else
        ::l16::
        if v264 then
            ::l26::
            if v264 then
                v_u_241(v264)
            end
            return
        else
            local v261 = v254[2]
            if not v261 or (not v261._items or #v261._items <= 0) then
                goto l26
            end
            local v262 = v261._items[1]
            if not (v262 and v262._id) then
                goto l26
            end
            local v263 = v262._id
            for _, v264 in ipairs(v255) do
                if v264._id == v263 then
                    goto l26
                end
            end
            v264 = nil
            goto l26
        end
    end
end
local function v_u_283()
    local v266 = v_u_41.Player
    if v266 then
        local v267 = v_u_7:GetAttribute("Team")
        if v267 and (v267 == "Counter-Terrorists" or v267 == "Terrorists") then
            local v268 = v267 == "Counter-Terrorists" and "CT" or "T"
            local v269 = v_u_28.VIEWPORT_CHARACTER_CONFIG[v268]
            if v269 then
                if v_u_37 and v_u_37.Parent then
                    return
                else
                    if v_u_38 then
                        v_u_38:Destroy()
                        v_u_38 = nil
                    end
                    if v_u_39 then
                        v_u_39:Destroy()
                        v_u_39 = nil
                    end
                    for _, v270 in ipairs(v266:GetChildren()) do
                        if v270:IsA("WorldModel") or v270:IsA("Camera") then
                            v270:Destroy()
                        end
                    end
                    local v271 = v_u_25:FindFirstChild(v269.Character)
                    if v271 then
                        local v272 = Instance.new("WorldModel")
                        v272.Name = "CharacterWorldModel"
                        v272.Parent = v266
                        v_u_38 = v272
                        local v273 = v271:Clone()
                        v273.Name = "BuyMenuCharacter"
                        v273.Parent = v272
                        v_u_37 = v273
                        if v273.PrimaryPart then
                            v273:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
                        end
                        local v274 = -v273:GetBoundingBox().Y
                        local v275 = CFrame.new(0, v274, 0.4)
                        if v273.PrimaryPart then
                            v273:SetPrimaryPartCFrame(v275)
                        end
                        local v276 = Instance.new("Camera")
                        v276.CameraType = Enum.CameraType.Scriptable
                        v276.Name = "ViewportCamera"
                        v276.FieldOfView = 55
                        v276.Parent = v266
                        v266.CurrentCamera = v276
                        v_u_39 = v276
                        local v277 = v273:FindFirstChildOfClass("Humanoid")
                        if v277 and v269.IdleAnimation then
                            local v278 = v277:FindFirstChildOfClass("Animator")
                            if not v278 then
                                v278 = Instance.new("Animator")
                                v278.Parent = v277
                            end
                            local v279 = Instance.new("Animation")
                            v279.AnimationId = v269.IdleAnimation
                            local v280 = v278:LoadAnimation(v279)
                            v280.Looped = true
                            v280:Play()
                            v_u_31:Add(v280, "Stop", "BuyMenuIdleAnimTrack")
                            v_u_31:Add(v279, "Destroy", "BuyMenuIdleAnim")
                        end
                        local v281 = v_u_29.new(v266, v276)
                        v281:SetModel(v273)
                        local v282 = v281:GetMinimumFitCFrame(CFrame.new(0, v274, 0) * CFrame.Angles(0, -3.141592653589793, 0))
                        v276.CFrame = CFrame.new(0, v274, v282.Position.Z) * CFrame.Angles(0, -3.141592653589793, 0)
                        v_u_251()
                        v_u_265()
                        v_u_31:Add(function()
                            if v_u_38 then
                                v_u_38:Destroy()
                                v_u_38 = nil
                            end
                            if v_u_39 then
                                v_u_39:Destroy()
                                v_u_39 = nil
                            end
                            if v_u_37 then
                                v_u_37:Destroy()
                                v_u_37 = nil
                            end
                            v_u_34 = nil
                            v_u_33 = nil
                            v_u_36 = nil
                        end, true, "BuyMenuCharacter")
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
local function v_u_285()
    local v284 = v_u_41.Player
    if v284 then
        if v284.Visible and (v284.AbsoluteSize.X > 0 and v284.AbsoluteSize.Y > 0) then
            if not (v_u_37 and v_u_37.Parent) then
                v_u_283()
            end
            if v_u_39 and v_u_39.Parent then
                v284.CurrentCamera = v_u_39
            end
            v_u_265()
        end
    else
        return
    end
end
function v_u_1.openFrame()
    if v_u_9.IsActive() then
        return
    else
        local v286 = v_u_7:GetAttribute("BuyMenu")
        if v_u_16(v_u_7) then
            if v286 and not v_u_41.Visible then
                v_u_10.setForceLockOverride("BuyMenu", true)
                v_u_10.setPerspective(true, true)
                v_u_42.Gameplay.Bottom.Health.Visible = false
                v_u_42.Gameplay.Bottom.Middle.Visible = false
                v_u_42.Gameplay.Bottom.Armor.Visible = false
                v_u_42.Gameplay.Bottom.Money.Visible = false
                v_u_42.Gameplay.Bottom.Ammo.Visible = false
                v_u_41.Visible = true
                v_u_35 = nil
                v_u_285()
            end
        else
            return
        end
    end
end
function v_u_1.closeFrame()
    if v_u_41.Visible then
        v_u_10.setForceLockOverride("BuyMenu", false)
        v_u_10.setPerspective(true, false)
        v_u_42.Gameplay.Bottom.Health.Visible = true
        v_u_42.Gameplay.Bottom.Middle.Visible = true
        v_u_42.Gameplay.Bottom.Armor.Visible = v_u_60().Health > 0
        v_u_42.Gameplay.Bottom.Money.Visible = true
        v_u_42.Gameplay.Bottom.Ammo.Visible = true
        v_u_41.Visible = false
        v_u_35 = nil
    end
end
function v_u_1.toggleFrame()
    if v_u_9.IsActive() then
        return
    elseif v_u_7:GetAttribute("BuyMenu") and not v_u_41.Visible then
        v_u_1.openFrame()
        return
    elseif v_u_41.Visible then
        v_u_1.closeFrame()
    end
end
function v_u_1.characterAdded(_)
    if v_u_104(v_u_7, "Money") then
        v_u_30:Cleanup()
        v_u_283()
        v_u_84()
    end
end
function v_u_1.characterRemoving(_)
    v_u_31:Cleanup()
    if v_u_36 then
        v_u_36:Destroy()
        v_u_36 = nil
    end
    if v_u_33 then
        v_u_33:Stop()
        v_u_33 = nil
    end
    v_u_34 = nil
    v_u_35 = nil
    v_u_37 = nil
    v_u_38 = nil
    v_u_39 = nil
end
function v_u_1.Initialize(p287, p288)
    v_u_42 = p287
    v_u_41 = p288
    v_u_113()
    local function v_u_291()
        local v289 = v_u_8.getCurrentInventory()
        for _, v290 in ipairs(v_u_41.Menu.Container:GetDescendants()) do
            if v290:IsA("TextButton") then
                v_u_1.updateBuyMenuTemplate(v289, v290)
            end
        end
    end
    v_u_19.observeAttribute(v_u_7, "Team", function(_)
        if v_u_37 and v_u_7.Character then
            v_u_1.characterRemoving(v_u_7.Character)
        end
        if v_u_7.Character then
            v_u_283()
            if v_u_41.Visible then
                v_u_285()
            end
        end
        v_u_30:Cleanup()
        v_u_84()
        v_u_291()
    end)
    v_u_19.observeAttribute(workspace, "Gamemode", function()
        v_u_30:Cleanup()
        v_u_84()
        v_u_291()
    end)
    v_u_19.observeAttribute(workspace, "ServerGamemode", function()
        v_u_30:Cleanup()
        v_u_84()
        v_u_291()
    end)
    v_u_22.Inventory.NewInventoryItem.Listen(function(p292)
        local v293 = v_u_40
        local v294 = p292.identifier
        table.insert(v293, v294)
    end)
    v_u_22.Inventory.RemoveInventoryItem.Listen(function(p_u_295)
        v_u_13(v_u_40, function(_, p296)
            return p296 == p_u_295
        end)
    end)
    v_u_19.observeAttribute(v_u_7, "MinimumNextRoundIncome", function(p297)
        v_u_41.Menu.TopFrame.NextRoundMoney.Text = "Next Round Minimum:  $" .. tostring(p297):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end)
    v_u_19.observeAttribute(v_u_7, "Money", function(p298)
        v_u_32:setGoal(p298)
        v_u_291()
    end)
    v_u_19.observeAttribute(v_u_7, "Armor", function()
        v_u_291()
    end)
    v_u_19.observeAttribute(v_u_7, "HasDefuseKit", function()
        v_u_291()
    end)
    v_u_19.observeAttribute(v_u_7, "HasRescueKit", function()
        v_u_291()
    end)
    v_u_19.observeAttribute(v_u_7, "BuyMenu", function(_)
        return function()
            v_u_1.closeFrame()
        end
    end)
    v_u_19.observeAttribute(workspace, "Timer", function()
        v_u_113()
    end)
    v_u_19.observeAttribute(workspace, "BuyTimerRemaining", function()
        v_u_113()
    end)
    v_u_18.ListenToState(function(_, p299)
        if p299 == "Buy Period" then
            table.clear(v_u_40)
        end
        v_u_113()
    end)
    v_u_4.Heartbeat:Connect(function(p300)
        local v301 = v_u_32:getPosition()
        local v302 = math.round(v301)
        local v303 = tostring(v302):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        v_u_41.Menu.TopFrame.Money.TextColor3 = v_u_15()
        v_u_41.Menu.TopFrame.Money.Text = "$" .. v303
        v_u_32:update(p300)
        if v_u_41.Visible and not v_u_16(v_u_7) then
            local v304 = workspace:GetAttribute("Gamemode")
            if v304 == "Bomb Defusal" or v304 == "Hostage Rescue" then
                v_u_1.closeFrame()
                return
            end
        end
    end)
    v_u_8.OnInventoryChanged:Connect(function(p305)
        for _, v306 in ipairs(v_u_41.Menu.Container:GetDescendants()) do
            if v306:IsA("TextButton") then
                v_u_1.updateBuyMenuTemplate(p305, v306)
            end
        end
        if v_u_41.Visible then
            task.defer(v_u_265)
        end
    end)
    v_u_11.CreateListener(v_u_7, "Settings.Game.HUD.Color", function()
        v_u_291()
    end)
    v_u_11.CreateListener(v_u_7, "Loadout", function()
        if v_u_7.Character then
            v_u_30:Cleanup()
            v_u_31:Cleanup()
            v_u_84()
            v_u_291()
        end
    end)
end
function v_u_1.Start()
    if v_u_7.Character then
        v_u_1.characterAdded(v_u_7.Character)
    end
    v_u_7.CharacterAdded:Connect(function(p307)
        v_u_1.characterAdded(p307)
    end)
    v_u_7.CharacterRemoving:Connect(function(p308)
        v_u_1.characterRemoving(p308)
    end)
end
return v_u_1