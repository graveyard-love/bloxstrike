local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Players")
require(v2.Database.Custom.Types)
local v_u_5 = v_u_4.LocalPlayer
local v_u_6 = require(v2.Controllers.InventoryController)
local v_u_7 = require(v2.Controllers.SpectateController)
local v_u_8 = require(v2.Controllers.DataController)
local v9 = require(v2.Components.Common.GetUserPlatform)
local v_u_10 = require(v2.Components.Common.GetPreferenceColor)
local v_u_11 = require(v2.Components.Common.GetSkinDisplayName)
local v_u_12 = require(v2.Database.Security.Remotes)
local v_u_13 = require(v2.Database.Components.Libraries.Skins)
local v_u_14 = require(v2.Database.Custom.GameStats.Rarities)
local v_u_15 = nil
local v_u_16 = 0
local v_u_17 = {}
local v_u_18 = nil
local v_u_19 = table.find(v9(), "Console")
if v_u_19 then
    v_u_19 = #v9() <= 1
end
local v_u_20 = {
    {
        ["type"] = "Primary",
        ["space"] = 1
    },
    {
        ["type"] = "Secondary",
        ["space"] = 1
    },
    {
        ["type"] = "Melee",
        ["space"] = 1
    },
    {
        ["type"] = "Grenade",
        ["space"] = 4
    },
    {
        ["type"] = "C4",
        ["space"] = 1
    }
}
local v_u_21 = Color3.new(1, 1, 1)
local v_u_22 = {}
local v_u_23 = {}
local v_u_24 = nil
local function v_u_30()
    if v_u_18 then
        task.cancel(v_u_18)
        v_u_18 = nil
    end
    for _, v25 in pairs(v_u_17) do
        v25:Cancel()
    end
    table.clear(v_u_17)
    local v26 = v_u_24 and { v_u_24.Primary, v_u_24.Secondary, v_u_24.Melee } or nil
    if v26 then
        for _, v27 in ipairs(v26) do
            if v27:IsA("Frame") then
                local v28 = v27:FindFirstChild("Equip")
                if v28 and v28:IsA("Frame") then
                    v28.BackgroundTransparency = 0.225
                end
                for _, v29 in ipairs(v27:GetDescendants()) do
                    if v29:IsA("ImageLabel") then
                        v29.ImageTransparency = 0.225
                    elseif v29:IsA("TextLabel") then
                        v29.TextTransparency = 0.225
                    end
                end
            end
        end
    end
end
local function v_u_38()
    if v_u_8.Get(v_u_5, "Settings.Game.Item.Always Show Inventory") ~= false then
        v_u_30()
        return
    end
    v_u_30()
    local v31 = v_u_24 and { v_u_24.Primary, v_u_24.Secondary, v_u_24.Melee } or nil
    if not v31 then
        return
    end
    for _, v32 in ipairs(v31) do
        if v32:IsA("Frame") then
            local v33 = v32:FindFirstChild("Equip")
            if v33 and v33:IsA("Frame") then
                local v34 = v_u_3:Create(v33, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    ["BackgroundTransparency"] = 1
                })
                v_u_17[v32.Name .. "_Equip"] = v34
                v34:Play()
            end
            for _, v35 in ipairs(v32:GetDescendants()) do
                local v36
                if v35:IsA("ImageLabel") then
                    v36 = {
                        ["ImageTransparency"] = 1
                    }
                    ::l21::
                    local v37 = v_u_3:Create(v35, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), v36)
                    v_u_17[v32.Name .. "_" .. v35:GetFullName()] = v37
                    v37:Play()
                elseif v35:IsA("TextLabel") then
                    v36 = {
                        ["TextTransparency"] = 1
                    }
                    goto l21
                end
            end
        end
    end
    v_u_18 = task.delay(5, function()
        v_u_18 = nil
    end)
end
local function v_u_42(p39)
    if p39 then
        if v_u_8.Get(v_u_5, "Settings.Game.HUD.Glow Weapon with Rarity Color") == true then
            local v40 = v_u_13.GetSkinInformation(p39.Name, p39.Skin)
            if v40 and v40.rarity then
                local v41 = v_u_14[v40.rarity]
                if v41 then
                    return v41.Color
                else
                    return v_u_10()
                end
            else
                return v_u_10()
            end
        else
            return v_u_10()
        end
    else
        return v_u_10()
    end
end
local function v_u_50(p43, p44)
    local v45 = p43:GetAttribute("DefaultSize")
    if v45 then
        local v46 = UDim2.new(v45.X.Scale * 1.1, v45.X.Offset * 1.1, v45.Y.Scale * 1.1, v45.Y.Offset * 1.1)
        for _ = 1, 6 do
            local v47 = {
                ["ImageColor3"] = v_u_21,
                ["Size"] = v46
            }
            local v48 = v_u_3:Create(p43, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), v47)
            v48:Play()
            v48.Completed:Wait()
            local v49 = v_u_3:Create(p43, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                ["ImageColor3"] = p44,
                ["Size"] = v45
            })
            v49:Play()
            v49.Completed:Wait()
        end
    end
end
local function v_u_55(p_u_51, p_u_52, p_u_53)
    if v_u_22[p_u_51] then
        task.cancel(v_u_22[p_u_51])
        v_u_22[p_u_51] = nil
    end
    local v54 = p_u_52:GetAttribute("DefaultSize")
    if v54 then
        p_u_52.ImageColor3 = p_u_53
        p_u_52.Size = v54
    end
    v_u_22[p_u_51] = task.spawn(function()
        v_u_50(p_u_52, p_u_53)
        v_u_22[p_u_51] = nil
    end)
end
local function v_u_62(p56)
    local v57 = {}
    for _, v58 in ipairs(p56) do
        local v59 = v58._settings._strict_type
        v57[v59] = {}
        for _, v60 in ipairs(v58._items) do
            local v61 = v60.Identifier
            if v61 then
                v57[v59][v61] = true
            end
        end
    end
    return v57
end
local function v_u_77(p63)
    local v64 = v_u_62(p63)
    for _, v65 in ipairs(p63) do
        local v66 = v65._settings._strict_type
        local v67 = v_u_23[v66] or {}
        for v68, v69 in ipairs(v65._items) do
            local v70 = v69.Identifier
            if v70 and not v67[v70] then
                if v66 == "Grenade" then
                    local v71 = v_u_24.Grenade.Grenades:FindFirstChild((tostring(v68)))
                    if v71 then
                        local v72 = v71:FindFirstChild("Grenade")
                        if v72 and v72.Visible then
                            v_u_55("Grenade_" .. v68, v72, v_u_10())
                        end
                    end
                elseif v66 == "C4" then
                    local v73 = v_u_24.Grenade:FindFirstChild("Bomb")
                    if v73 and v73.Visible then
                        v_u_55("C4", v73, v_u_10())
                    end
                else
                    local v74 = v_u_24:FindFirstChild(v66)
                    if v74 then
                        local v75 = v74:FindFirstChild("Weapon")
                        if v75 then
                            for _, v76 in v75:GetChildren() do
                                if v76:IsA("ImageLabel") and v76.Visible then
                                    v_u_55(v66, v76, v_u_42(v69))
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    v_u_23 = v64
end
local function v_u_90(p78, p79)
    if v_u_15 then
        if v_u_15.Name == "Grenade" then
            local v80 = v_u_16
            local v81 = v_u_15:WaitForChild("Grenades"):FindFirstChild((tostring(v80)))
            if v81 then
                local v82 = v81:FindFirstChild("Grenade")
                v_u_3:Create(v82, TweenInfo.new(0.1), {
                    ["Size"] = v82:GetAttribute("DefaultSize")
                }):Play()
            end
        else
            local v83 = v_u_15.Weapon:FindFirstChildOfClass("ImageLabel")
            v_u_15.Weapon.WeaponName.Visible = false
            v_u_15.Equip.Visible = false
            v_u_3:Create(v83, TweenInfo.new(0.1), {
                ["Size"] = v83:GetAttribute("DefaultSize")
            }):Play()
        end
    end
    local v84 = v_u_24
    local v85 = p79.Properties.Slot
    local v86 = v84:FindFirstChild((tostring(v85)))
    v_u_15 = v86
    if v86 then
        if v86.Name == "Grenade" then
            local v87 = v86.Grenades:FindFirstChild((tostring(p78)))
            v_u_16 = p78
            if v87 then
                local v88 = v87:FindFirstChild("Grenade")
                v88.ImageColor3 = v_u_10()
                v_u_3:Create(v88, TweenInfo.new(0.1), {
                    ["Size"] = v88:GetAttribute("DefaultSize") + UDim2.fromScale(0.1, 0.1)
                }):Play()
            end
        else
            local v89 = v86.Weapon:FindFirstChildOfClass("ImageLabel")
            v89.ImageColor3 = v_u_42(p79)
            v86.Weapon.WeaponName.Visible = true
            v86.Equip.Visible = true
            v_u_3:Create(v89, TweenInfo.new(0.1), {
                ["Size"] = v89:GetAttribute("DefaultSize") + UDim2.fromScale(0.1, 0.1)
            }):Play()
        end
    end
    if v86 then
        v86 = v86:FindFirstChild("CycleWeaponsIcons")
    end
    if v_u_19 then
        if v86 then
            v86.Visible = v_u_19
        end
    else
        return
    end
end
local function v_u_99(p91)
    local v92 = {}
    if not p91 or #p91 == 0 then
        return nil
    end
    for v93 = 1, 5 do
        local v94 = p91[v93]
        if v94 then
            local v95 = {
                ["_items"] = {},
                ["_settings"] = {
                    ["_strict_slot_space"] = v94._settings._strict_slot_space,
                    ["_strict_type"] = v94._settings._strict_type
                }
            }
            v92[v93] = v95
            for _, v96 in ipairs(v94._items) do
                local v97 = v92[v93]._items
                table.insert(v97, v96)
            end
        else
            local v98 = {
                ["_items"] = {},
                ["_settings"] = {
                    ["_strict_slot_space"] = v_u_20[v93].space,
                    ["_strict_type"] = v_u_20[v93].type
                }
            }
            v92[v93] = v98
        end
    end
    return v92
end
local function v_u_127(p100, p101)
    local v102 = v_u_10()
    v_u_24.Grenade.DefuseKit.ImageColor3 = v102
    v_u_24.Grenade.Bomb.ImageColor3 = v102
    local v103 = p101 or v_u_5
    local v104 = v_u_24.Grenade.DefuseKit
    local v105
    if v103 and v103:GetAttribute("Team") == "Counter-Terrorists" then
        local v106 = workspace:GetAttribute("Gamemode")
        local v107 = v106 == "Bomb Defusal" and "HasDefuseKit" or (v106 == "Hostage Rescue" and "HasRescueKit" or nil)
        if v107 then
            v105 = v103:GetAttribute(v107) == true
        else
            v105 = false
        end
    else
        v105 = false
    end
    v104.Visible = v105
    if workspace:GetAttribute("Gamemode") == "Hostage Rescue" then
        v_u_24.Grenade.Bomb.Visible = false
    end
    local v108 = v_u_6.getCurrentEquipped()
    for _, v109 in ipairs(p100) do
        if v109._settings._strict_slot_space == 1 then
            local v110 = v_u_24:FindFirstChild(v109._settings._strict_type)
            if v110 then
                local v111 = v109._items[1]
                if v111 then
                    local v112 = v110:FindFirstChild("Weapon")
                    v110:SetAttribute("Slot", v111.Slot)
                    v110.Keybind.Text = v111.Slot
                    if v112 then
                        local v113 = v110.Weapon:FindFirstChild(v111.Properties.Class)
                        local v114 = (v109._settings._strict_type == "Melee" and "\226\152\133 " or "") .. v111.Name
                        if v111.Skin then
                            local v115 = v_u_11(v111.Skin)
                            v114 = v114 .. (v115 == "Vanilla" and "" or (" | " .. v115 or ""))
                        end
                        local v116 = (v111.Name == "T Knife" or v111.Name == "CT Knife") and "Knife" or v114
                        if v111.NameTag then
                            v116 = ("\"%*\""):format(v111.NameTag)
                        end
                        local v117 = v111.OriginalOwner
                        if v117 and (v117 ~= "" and v117 ~= v_u_5.Name) then
                            v116 = ("\"%*\'s %*\""):format(v117, v116)
                        end
                        v110.Weapon.WeaponName.TextColor3 = v_u_42(v111)
                        v110.Weapon.WeaponName.Text = v116
                        local v118
                        if v108 then
                            v118 = v108.Properties.Slot == v109._settings._strict_type
                        else
                            v118 = v108
                        end
                        v110.Weapon.WeaponName.Visible = v118
                        if v113 then
                            for _, v119 in ipairs(v110.Weapon:GetChildren()) do
                                if v119:IsA("ImageLabel") then
                                    v119.Visible = v119 == v113
                                end
                            end
                            v113.Image = v111.Properties.Icon
                            v113.ImageColor3 = v_u_42(v111)
                        end
                    end
                else
                    v110.Equip.Visible = false
                    v110.Weapon.WeaponName.Text = ""
                    v110.Weapon.WeaponName.Visible = false
                    for _, v120 in ipairs(v110.Weapon:GetChildren()) do
                        if v120:IsA("ImageLabel") then
                            v120.Visible = false
                        end
                    end
                end
            elseif v109._settings._strict_type == "C4" then
                v_u_24.Grenade.Bomb.Visible = v109._items[1]
            end
        elseif v109._settings._strict_type == "Grenade" then
            for v121 = 1, 4 do
                local v122 = v_u_24.Grenade.Grenades:FindFirstChild((tostring(v121)))
                if v122 then
                    local v123 = v109._items[v121]
                    if v123 then
                        v122.Grenade.ImageColor3 = v102
                        v122.Grenade.Visible = true
                        v122.Dot.Visible = false
                        if v123.Properties and v123.Properties.Icon then
                            v122.Grenade.Image = v123.Properties.Icon
                        end
                    else
                        v122.Grenade.Visible = false
                        v122.Dot.Visible = true
                    end
                end
            end
        end
    end
    for _, v124 in ipairs(v_u_24:GetChildren()) do
        if v124:IsA("Frame") then
            local v125 = v124.Name == "Grenade"
            for _, v126 in ipairs(p100) do
                if #v126._items > 0 and v126._settings._strict_type == v124.Name then
                    v125 = true
                    break
                end
            end
            v124.Visible = v125
        end
    end
end
function v1.Initialize(_, p128)
    v_u_24 = p128
    if v_u_24.Active then
        v_u_24.Active = false
    end
    for _, v129 in ipairs(v_u_24:GetDescendants()) do
        if v129:IsA("GuiObject") then
            v129.Active = false
        end
    end
    for _, v130 in ipairs(v_u_24:GetDescendants()) do
        if (v130:IsA("ImageLabel") or v130:IsA("ImageButton")) and (v130.Parent.Name == "Weapon" or (v130.Name == "Grenade" or v130.Name == "Bomb")) then
            v130:SetAttribute("DefaultSize", v130.Size)
        end
    end
    for _, v_u_131 in ipairs(v_u_24:GetChildren()) do
        if v_u_131:IsA("Frame") and v_u_131:FindFirstChild("Button") then
            v_u_131.Button.MouseButton1Click:Connect(function()
                local v132 = v_u_131:GetAttribute("Slot")
                v_u_6.equip(v132, 1)
            end)
        end
    end
    for _, v_u_133 in ipairs(v_u_24.Grenade.Grenades:GetChildren()) do
        if v_u_133:IsA("Frame") then
            v_u_133:FindFirstChild("Button").MouseButton1Click:Connect(function()
                local v134 = v_u_6.equip
                local v135 = v_u_133.Name
                v134(4, (tonumber(v135)))
            end)
        end
    end
    local v_u_136 = v_u_24.Grenade.Bomb
    if v_u_136:IsA("ImageButton") then
        v_u_136.MouseButton1Click:Connect(function()
            if v_u_136.Visible then
                v_u_6.equip(5, 1)
            end
        end)
    end
end
function v1.Start()
    v_u_6.OnInventoryChanged:Connect(function(p137)
        if not v_u_5:GetAttribute("IsSpectating") then
            v_u_127(p137)
            v_u_77(p137)
        end
    end)
    v_u_6.OnInventoryItemEquipped:Connect(function(p138, p139)
        v_u_90(p138, p139)
        if v_u_8.Get(v_u_5, "Settings.Game.Item.Always Show Inventory") == false then
            local v140 = p139.Properties.Slot
            if v140 == "Primary" or (v140 == "Secondary" or (v140 == "Melee" or v140 == "Grenade")) then
                v_u_30()
                v_u_38()
            end
        end
    end)
    v_u_8.CreateListener(v_u_5, "Settings.Game.HUD.Glow Weapon with Rarity Color", function()
        local v141 = v_u_6.getCurrentInventory()
        if v141 then
            v_u_127(v141)
        end
        local v142 = v_u_6.getCurrentEquipped()
        if v142 then
            local v143 = v_u_24
            local v144 = v142.Properties.Slot
            local v145 = v143:FindFirstChild((tostring(v144)))
            if v145 and v145.Name ~= "Grenade" then
                local v146 = v_u_42(v142)
                local v147 = v145.Weapon:FindFirstChildOfClass("ImageLabel")
                if v147 then
                    v147.ImageColor3 = v146
                end
                if v145.Weapon.WeaponName then
                    v145.Weapon.WeaponName.TextColor3 = v146
                end
            end
        end
    end)
    v_u_8.CreateListener(v_u_5, "Settings.Game.HUD.Color", function()
        if v_u_5:GetAttribute("IsSpectating") == true then
            local v148 = v_u_7.GetPlayer()
            if v148 then
                v_u_12.Inventory.RequestSpectatedPlayerInventory.Send(v148)
                return
            end
        else
            local v149 = v_u_6.getCurrentInventory()
            if v149 then
                v_u_127(v149)
            end
        end
    end)
    local function v155()
        if not v_u_5:GetAttribute("IsSpectating") then
            local v150 = v_u_5
            local v151 = v_u_24.Grenade.DefuseKit
            local v152
            if v150 and v150:GetAttribute("Team") == "Counter-Terrorists" then
                local v153 = workspace:GetAttribute("Gamemode")
                local v154 = v153 == "Bomb Defusal" and "HasDefuseKit" or (v153 == "Hostage Rescue" and "HasRescueKit" or nil)
                if v154 then
                    v152 = v150:GetAttribute(v154) == true
                else
                    v152 = false
                end
            else
                v152 = false
            end
            v151.Visible = v152
        end
    end
    v_u_5:GetAttributeChangedSignal("HasDefuseKit"):Connect(v155)
    v_u_5:GetAttributeChangedSignal("HasRescueKit"):Connect(v155)
    v_u_5:GetAttributeChangedSignal("Team"):Connect(v155)
    v_u_12.Inventory.SpectatedPlayerInventory.Listen(function(p156)
        if v_u_5:GetAttribute("IsSpectating") == true then
            local v157 = v_u_7.GetPlayer()
            local v158 = v157 and (p156.Player == v157 and v_u_99(p156.Inventory))
            if v158 then
                v_u_127(v158, v157)
                local v159 = p156.EquippedSlot or 0
                local v160 = p156.EquippedSlotSpace or 0
                if v159 > 0 and v160 > 0 then
                    local v161 = v158[v159]
                    if v161 and (v161._items and v161._items[v160]) then
                        v_u_90(v160, v161._items[v160])
                    end
                end
            end
        end
    end)
    v_u_7.ListenToSpectate:Connect(function(p162)
        if p162 then
            v_u_12.Inventory.RequestSpectatedPlayerInventory.Send(p162)
            local v163 = v_u_24.Grenade.DefuseKit
            local v164
            if p162 and p162:GetAttribute("Team") == "Counter-Terrorists" then
                local v165 = workspace:GetAttribute("Gamemode")
                local v166 = v165 == "Bomb Defusal" and "HasDefuseKit" or (v165 == "Hostage Rescue" and "HasRescueKit" or nil)
                if v166 then
                    v164 = p162:GetAttribute(v166) == true
                else
                    v164 = false
                end
            else
                v164 = false
            end
            v163.Visible = v164
            return
        end
        local v167 = v_u_6.getCurrentInventory()
        if v167 then
            v_u_127(v167)
        end
        local v168 = v_u_6.getCurrentEquipped()
        if v167 and (v168 and v168.Identifier) then
            local v169 = false
            for v170 = 1, 5 do
                if v169 then
                    break
                end
                local v171 = v167[v170]
                if v171 and v171._items then
                    for v172, v173 in ipairs(v171._items) do
                        if v173.Identifier == v168.Identifier then
                            v_u_90(v172, v173)
                            v169 = true
                            break
                        end
                    end
                end
            end
        end
        local v174 = v_u_5
        local v175 = v_u_24.Grenade.DefuseKit
        local v176
        if v174 and v174:GetAttribute("Team") == "Counter-Terrorists" then
            local v177 = workspace:GetAttribute("Gamemode")
            local v178 = v177 == "Bomb Defusal" and "HasDefuseKit" or (v177 == "Hostage Rescue" and "HasRescueKit" or nil)
            if v178 then
                v176 = v174:GetAttribute(v178) == true
            else
                v176 = false
            end
        else
            v176 = false
        end
        v175.Visible = v176
    end)
    local function v_u_184()
        local v179 = v_u_5:GetAttribute("IsSpectating") == true and v_u_7.GetPlayer()
        if v179 then
            local v180 = v_u_24.Grenade.DefuseKit
            local v181
            if v179 and v179:GetAttribute("Team") == "Counter-Terrorists" then
                local v182 = workspace:GetAttribute("Gamemode")
                local v183 = v182 == "Bomb Defusal" and "HasDefuseKit" or (v182 == "Hostage Rescue" and "HasRescueKit" or nil)
                if v183 then
                    v181 = v179:GetAttribute(v183) == true
                else
                    v181 = false
                end
            else
                v181 = false
            end
            v180.Visible = v181
        end
    end
    for _, v185 in ipairs(v_u_4:GetPlayers()) do
        if v185 ~= v_u_5 then
            v185:GetAttributeChangedSignal("HasDefuseKit"):Connect(v_u_184)
            v185:GetAttributeChangedSignal("HasRescueKit"):Connect(v_u_184)
            v185:GetAttributeChangedSignal("Team"):Connect(v_u_184)
        end
    end
    v_u_4.PlayerAdded:Connect(function(p186)
        if p186 ~= v_u_5 then
            p186:GetAttributeChangedSignal("HasDefuseKit"):Connect(v_u_184)
            p186:GetAttributeChangedSignal("HasRescueKit"):Connect(v_u_184)
            p186:GetAttributeChangedSignal("Team"):Connect(v_u_184)
        end
    end)
    workspace:GetAttributeChangedSignal("Gamemode"):Connect(function()
        if v_u_5:GetAttribute("IsSpectating") then
            local v187 = v_u_5:GetAttribute("IsSpectating") == true and v_u_7.GetPlayer()
            if v187 then
                local v188 = v_u_24.Grenade.DefuseKit
                local v189
                if v187 and v187:GetAttribute("Team") == "Counter-Terrorists" then
                    local v190 = workspace:GetAttribute("Gamemode")
                    local v191 = v190 == "Bomb Defusal" and "HasDefuseKit" or (v190 == "Hostage Rescue" and "HasRescueKit" or nil)
                    if v191 then
                        v189 = v187:GetAttribute(v191) == true
                    else
                        v189 = false
                    end
                else
                    v189 = false
                end
                v188.Visible = v189
                return
            end
        else
            local v192 = v_u_5
            local v193 = v_u_24.Grenade.DefuseKit
            local v194
            if v192 and v192:GetAttribute("Team") == "Counter-Terrorists" then
                local v195 = workspace:GetAttribute("Gamemode")
                local v196 = v195 == "Bomb Defusal" and "HasDefuseKit" or (v195 == "Hostage Rescue" and "HasRescueKit" or nil)
                if v196 then
                    v194 = v192:GetAttribute(v196) == true
                else
                    v194 = false
                end
            else
                v194 = false
            end
            v193.Visible = v194
        end
    end)
    if v_u_5:GetAttribute("IsSpectating") then
        local v197 = v_u_5:GetAttribute("IsSpectating") == true and v_u_7.GetPlayer()
        if v197 then
            local v198 = v_u_24.Grenade.DefuseKit
            local v199
            if v197 and v197:GetAttribute("Team") == "Counter-Terrorists" then
                local v200 = workspace:GetAttribute("Gamemode")
                local v201 = v200 == "Bomb Defusal" and "HasDefuseKit" or (v200 == "Hostage Rescue" and "HasRescueKit" or nil)
                if v201 then
                    v199 = v197:GetAttribute(v201) == true
                else
                    v199 = false
                end
            else
                v199 = false
            end
            v198.Visible = v199
        end
    else
        local v202 = v_u_5
        local v203 = v_u_24.Grenade.DefuseKit
        local v204
        if v202 and v202:GetAttribute("Team") == "Counter-Terrorists" then
            local v205 = workspace:GetAttribute("Gamemode")
            local v206 = v205 == "Bomb Defusal" and "HasDefuseKit" or (v205 == "Hostage Rescue" and "HasRescueKit" or nil)
            if v206 then
                v204 = v202:GetAttribute(v206) == true
            else
                v204 = false
            end
        else
            v204 = false
        end
        v203.Visible = v204
    end
    v_u_12.Inventory.NewInventoryItem.Listen(function(_)
        local v207 = v_u_5:GetAttribute("IsSpectating") == true and v_u_7.GetPlayer()
        if v207 then
            v_u_12.Inventory.RequestSpectatedPlayerInventory.Send(v207)
        end
    end)
    v_u_12.Inventory.RemoveInventoryItem.Listen(function(_)
        local v208 = v_u_5:GetAttribute("IsSpectating") == true and v_u_7.GetPlayer()
        if v208 then
            v_u_12.Inventory.RequestSpectatedPlayerInventory.Send(v208)
        end
    end)
    v_u_8.CreateListener(v_u_5, "Settings.Game.Item.Always Show Inventory", function()
        local v209 = v_u_8.Get(v_u_5, "Settings.Game.Item.Always Show Inventory") ~= false
        v_u_30()
        if not v209 then
            v_u_38()
        end
    end)
    task.wait(0.1)
    if v_u_8.Get(v_u_5, "Settings.Game.Item.Always Show Inventory") == false then
        v_u_38()
    end
end
return v1