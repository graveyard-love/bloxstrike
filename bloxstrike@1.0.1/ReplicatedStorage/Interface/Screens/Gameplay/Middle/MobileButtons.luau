local v_u_1 = {}
local v_u_2 = game:GetService("CollectionService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = game:GetService("RunService")
local v7 = game:GetService("Players")
require(v3.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_8 = require(v3.Controllers.CharacterController)
local v_u_9 = require(v3.Controllers.InventoryController)
local v_u_10 = require(v3.Controllers.CaseSceneController)
local v_u_11 = require(v3.Controllers.SpectateController)
local v_u_12 = require(v3.Controllers.InspectController)
local v_u_13 = require(v3.Controllers.DataController)
local v_u_14 = require(v3.Controllers.HintController)
local v_u_15 = require(v3.Database.Components.Libraries.Skins)
local v_u_16 = require(v3.Database.Components.GameState)
local v_u_17 = require(v3.Database.Components.Common.IsInBuyArea)
local v18 = require(v3.Components.Common.GetUserPlatform)
local v_u_19 = require(v3.Database.Security.Remotes)
local v_u_20 = require(v3.Database.Security.Router)
local v_u_21 = require(v3.Shared.Promise)
local v_u_22 = require(v3.Interface.Screens.Gameplay.Middle.TeamSelection)
local v_u_23 = require(v3.Interface.Screens.Gameplay.Middle.BuyMenu)
local v_u_24 = require(v3.Interface.Screens.Menu.Top)
local v_u_25 = require(v3.Database.Custom.GameStats.Rarities)
local v26 = require(script.Buttons)
local v_u_27 = v7.LocalPlayer
local v_u_28 = workspace.CurrentCamera
local v_u_29 = require(v_u_27:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("CameraInput"))
local v_u_30 = RaycastParams.new()
v_u_30.FilterType = Enum.RaycastFilterType.Exclude
v_u_30.IgnoreWater = true
local v_u_31 = RaycastParams.new()
v_u_31.FilterType = Enum.RaycastFilterType.Exclude
v_u_31.IgnoreWater = false
local v32 = v18()
local v_u_33 = table.find(v32, "Mobile")
if v_u_33 then
    v_u_33 = #v32 <= 1
end
local v_u_34 = nil
local v_u_35 = nil
local v_u_36 = 0
local v_u_37 = {}
local v_u_38 = {}
local v_u_39 = TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
local v_u_40 = v26.BUTTONS_WITH_EXPLICIT_INPUT_ENDED
local v_u_41 = v26.BUTTONS_WITH_EXPLICIT_HANDLERS
local v_u_42 = v26.BUTTONS_EXCLUDED_FROM_CLEARING
local v_u_43 = v26.SPECTATE_MOBILE_BUTTONS
local v_u_44 = v26.GAMEPLAY_MOBILE_BUTTONS
local v_u_45 = nil
local function v_u_49(p46)
    while p46 do
        if v_u_2:HasTag(p46, "WeaponDropped") then
            local v47 = p46:GetAttribute("Weapon")
            local v48 = p46:GetAttribute("Skin")
            if v47 and v48 then
                return v47, v48, p46.Name
            end
            break
        end
        p46 = p46.Parent
    end
    return nil, nil, nil
end
local function v_u_53(...)
    local v50 = { v_u_28, ... }
    v_u_31.FilterDescendantsInstances = v50
    local v51 = workspace:Raycast(v_u_28.CFrame.Position, v_u_28.CFrame.LookVector * 1000, v_u_31)
    while v51 and v51.Instance do
        local v52 = v51.Instance
        if not v52:IsA("BasePart") or v52.Transparency <= 0.98 then
            break
        end
        table.insert(v50, v52)
        v_u_31.FilterDescendantsInstances = v50
        v51 = workspace:Raycast(v51.Position, v_u_28.CFrame.LookVector.Unit * (1000 - v51.Distance), v_u_31)
    end
    return v51 or nil
end
local function v_u_58()
    if not (v_u_28 and v_u_27.Character) then
        return nil
    end
    if v_u_27:GetAttribute("Team") ~= "Counter-Terrorists" then
        return nil
    end
    v_u_30.FilterDescendantsInstances = { v_u_27.Character, v_u_28 }
    local v54 = workspace:Raycast(v_u_28.CFrame.Position, v_u_28.CFrame.LookVector * 5, v_u_30)
    if v54 then
        local v55 = v54.Instance
        if v55 and (v55.Parent and v55.Parent:HasTag("Hostage")) or false then
            local v56 = v54.Instance.Parent
            if v56 and v56:GetAttribute("CanRescue") == true then
                local v57 = v56:GetAttribute("RescuingPlayer")
                if v57 and v57 ~= v_u_27.Name then
                    return nil
                elseif v56:GetAttribute("CarryingPlayer") then
                    return nil
                else
                    return v56
                end
            end
        end
    end
    return nil
end
local function v_u_65(p59, p60)
    local v61 = v_u_5
    local v62 = v_u_39
    local v63 = {}
    local v64 = v_u_38[p59] or p59.Size
    v63.Size = UDim2.fromScale(v64.X.Scale * p60, v64.Y.Scale * p60)
    v61:Create(p59, v62, v63):Play()
end
local function v_u_69()
    if v_u_45 then
        local v66 = v_u_2:GetTagged("Bomb")[1]
        if v66 then
            v66 = v66:GetAttribute("CanDefuse")
        end
        local v67 = #v_u_2:GetTagged("IsHoveringInteractable") > 0
        local v68 = v_u_58() ~= nil
        if v66 then
            v_u_45.Interact.Defuse.Visible = true
            v_u_45.Interact.Use.Visible = false
            v_u_45.Interact.Visible = true
            return
        elseif v67 or v68 then
            v_u_45.Interact.Defuse.Visible = false
            v_u_45.Interact.Use.Visible = true
            v_u_45.Interact.Visible = true
        else
            v_u_45.Interact.Defuse.Visible = false
            v_u_45.Interact.Use.Visible = false
            v_u_45.Interact.Visible = false
        end
    else
        return
    end
end
local function v_u_72()
    if v_u_11.IsLocalPlayerDead() then
        v_u_45.Drop.Visible = false
        return
    else
        local v70 = v_u_9.getCurrentEquipped()
        if v70 then
            local v71
            if v70.Properties.Class == "Melee" then
                v71 = workspace:GetAttribute("VIPKnifeDropEnabled") == true
            else
                v71 = false
            end
            if v70.Properties.Droppable or v71 then
                if v_u_16.GetState() == "Warmup" then
                    v_u_45.Drop.Visible = false
                    return
                elseif workspace:GetAttribute("Gamemode") == "Deathmatch" then
                    v_u_45.Drop.Visible = false
                    return
                elseif v70.Properties.Class == "C4" and v70.IsPlanting then
                    v_u_45.Drop.Visible = false
                else
                    v_u_45.Drop.Visible = true
                end
            else
                v_u_45.Drop.Visible = false
                return
            end
        else
            v_u_45.Drop.Visible = false
            return
        end
    end
end
function v_u_1.setupButton(p_u_73)
    v_u_38[p_u_73] = p_u_73.Size
    p_u_73.InputBegan:Connect(function(p74)
        if p74.UserInputType == Enum.UserInputType.Touch or p74.UserInputType == Enum.UserInputType.MouseButton1 then
            if p74.UserInputState == Enum.UserInputState.Begin then
                if not v_u_41[p_u_73.Name] then
                    local v75 = p_u_73
                    if not v_u_37[v75] and p74.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v75] = p74
                    end
                end
                if v_u_37[p_u_73] == p74 then
                    v_u_65(p_u_73, 0.9)
                end
            end
        end
    end)
    if not v_u_42[p_u_73.Name] then
        p_u_73.InputChanged:Connect(function(p76)
            if p76.UserInputType == Enum.UserInputType.Touch then
                if v_u_37[p_u_73] == p76 then
                    local v77 = p_u_73
                    local v78 = p76.Position
                    local v79 = v77.AbsolutePosition
                    local v80 = v77.AbsoluteSize
                    local v81
                    if v78.X >= v79.X and (v78.X <= v79.X + v80.X and v78.Y >= v79.Y) then
                        v81 = v78.Y <= v79.Y + v80.Y
                    else
                        v81 = false
                    end
                    if not v81 then
                        local v82 = p_u_73
                        if v_u_37[v82] == p76 then
                            v_u_37[v82] = nil
                        end
                        v_u_65(p_u_73, 1)
                    end
                end
            end
        end)
    end
    p_u_73.InputEnded:Connect(function(p83)
        if p83.UserInputType == Enum.UserInputType.Touch or p83.UserInputType == Enum.UserInputType.MouseButton1 then
            v_u_65(p_u_73, 1)
            if not v_u_40[p_u_73.Name] then
                local v84 = p_u_73
                if v_u_37[v84] == p83 then
                    v_u_37[v84] = nil
                end
            end
        end
    end)
end
function v_u_1.Initialize(_, p85)
    v_u_45 = p85
    for _, v86 in ipairs(v_u_45:GetChildren()) do
        if v86:IsA("TextButton") then
            v_u_38[v86] = v86.Size
        end
    end
    if v_u_33 then
        local v87 = v_u_45.Parent.Parent:FindFirstChild("Top")
        local v88 = v87 and v87:FindFirstChild("Bomb Defusal")
        if v88 then
            v88.Size = UDim2.new(0.6, 0, 0.75, 0)
        end
        v_u_45.Jump.InputBegan:Connect(function(p89)
            if p89.UserInputType == Enum.UserInputType.Touch or p89.UserInputType == Enum.UserInputType.MouseButton1 then
                if p89.UserInputState == Enum.UserInputState.Begin then
                    local v90 = v_u_45.Jump
                    if not v_u_37[v90] and p89.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v90] = p89
                    end
                end
                local v91 = v_u_37[v_u_45.Jump]
                local v92
                if v91 then
                    v92 = (not p89 or p89 == v91) and true or false
                else
                    v92 = false
                end
                if v92 then
                    v_u_8.jump()
                end
            end
        end)
        v_u_45.Crouch.InputBegan:Connect(function(p93)
            if p93.UserInputType == Enum.UserInputType.Touch or p93.UserInputType == Enum.UserInputType.MouseButton1 then
                if p93.UserInputState == Enum.UserInputState.Begin then
                    local v94 = v_u_45.Crouch
                    if not v_u_37[v94] and p93.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v94] = p93
                    end
                    if v_u_37[v_u_45.Crouch] == p93 then
                        v_u_65(v_u_45.Crouch, 0.9)
                    end
                end
            end
        end)
        v_u_45.Crouch.InputEnded:Connect(function(p95)
            if p95.UserInputType == Enum.UserInputType.Touch or p95.UserInputType == Enum.UserInputType.MouseButton1 then
                v_u_65(v_u_45.Crouch, 1)
                local v96 = v_u_37[v_u_45.Crouch]
                local v97
                if v96 then
                    v97 = (not p95 or p95 == v96) and true or false
                else
                    v97 = false
                end
                if v97 then
                    v_u_8.crouch(not v_u_8.GetCrouchState())
                end
                local v98 = v_u_45.Crouch
                if v_u_37[v98] == p95 then
                    v_u_37[v98] = nil
                end
            end
        end)
        v_u_45.Drop.InputEnded:Connect(function(p99)
            if p99.UserInputType == Enum.UserInputType.Touch or p99.UserInputType == Enum.UserInputType.MouseButton1 then
                local v100 = v_u_37[v_u_45.Drop]
                local v101
                if v100 then
                    v101 = (not p99 or p99 == v100) and true or false
                else
                    v101 = false
                end
                if v101 then
                    local v102 = v_u_45.Drop
                    if v_u_37[v102] == p99 then
                        v_u_37[v102] = nil
                    end
                    v_u_21.new(function(p103, p104)
                        local v105 = v_u_9.getCurrentEquipped()
                        if v105 then
                            p103(v105)
                        else
                            p104("Failed to fetch current equipped")
                        end
                    end):catch(warn):andThen(function(p106)
                        if p106 then
                            local v107 = v_u_15.GetSkinInformation(p106.Name, p106.Skin)
                            local v108 = "Skin data not found for weapon: " .. p106.Name .. " and skin: " .. p106.Skin
                            assert(v107, v108)
                            local v109 = v_u_25[v107.rarity]
                            local v110 = v109.Color.R * 255
                            local v111 = math.floor(v110)
                            local v112 = v109.Color.G * 255
                            local v113 = math.floor(v112)
                            local v114 = v109.Color.B * 255
                            local v115 = math.floor(v114)
                            if p106:drop() then
                                v_u_20.broadcastRouter("CreateNotification", "Item Dropped", ("You dropped your <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v111, v113, v115, p106.Name, p106.Skin), 2)
                            end
                        end
                    end)
                else
                    local v116 = v_u_45.Drop
                    if v_u_37[v116] == p99 then
                        v_u_37[v116] = nil
                    end
                end
            else
                return
            end
        end)
        v_u_45.Reload.InputBegan:Connect(function(p117)
            if p117.UserInputType == Enum.UserInputType.Touch or p117.UserInputType == Enum.UserInputType.MouseButton1 then
                if p117.UserInputState == Enum.UserInputState.Begin then
                    local v118 = v_u_45.Reload
                    if not v_u_37[v118] and p117.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v118] = p117
                    end
                    if v_u_37[v_u_45.Reload] == p117 then
                        v_u_65(v_u_45.Reload, 0.9)
                    end
                end
            end
        end)
        v_u_45.Reload.InputEnded:Connect(function(p119)
            if p119.UserInputType == Enum.UserInputType.Touch or p119.UserInputType == Enum.UserInputType.MouseButton1 then
                v_u_65(v_u_45.Reload, 1)
                local v120 = v_u_37[v_u_45.Reload]
                local v121
                if v120 then
                    v121 = (not p119 or p119 == v120) and true or false
                else
                    v121 = false
                end
                if v121 then
                    local v122 = v_u_45.Reload
                    if v_u_37[v122] == p119 then
                        v_u_37[v122] = nil
                    end
                    v_u_21.new(function(p123, p124)
                        local v125 = v_u_9.getCurrentEquipped()
                        if v125 then
                            p123(v125)
                        else
                            p124("Failed to fetch current equipped")
                        end
                    end):catch(warn):andThen(function(p126)
                        if p126 then
                            p126:reload()
                        end
                    end)
                else
                    local v127 = v_u_45.Reload
                    if v_u_37[v127] == p119 then
                        v_u_37[v127] = nil
                    end
                end
            else
                return
            end
        end)
        v_u_45.Shoot.Active = true
        local v_u_128 = false
        local function v135(p129, p130)
            if p129 == v_u_34 then
                if p130 or p129.UserInputState == Enum.UserInputState.End then
                    v_u_34 = nil
                    if v_u_128 then
                        v_u_128 = false
                        v_u_65(v_u_45.Shoot, 1)
                        v_u_21.new(function(p131, p132)
                            local v133 = v_u_9.getCurrentEquipped()
                            if v133 then
                                p131(v133)
                            else
                                p132("Failed to fetch current equipped")
                            end
                        end):catch(warn):andThen(function(p134)
                            if p134 then
                                if p134.Properties.Class == "Weapon" then
                                    p134.IsFireHeld = false
                                    return
                                elseif p134.Properties.Class == "Melee" then
                                    p134.IsFireHeld = false
                                    return
                                elseif p134.Properties.Class == "C4" then
                                    p134:cancel()
                                    return
                                elseif p134.Properties.Slot == "Grenade" then
                                    p134:Throw("Far")
                                end
                            else
                                return
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
        v_u_45.Shoot.InputBegan:Connect(function(p136)
            if p136.UserInputType == Enum.UserInputType.Touch or p136.UserInputType == Enum.UserInputType.MouseButton1 then
                if v_u_34 then
                    return
                elseif p136.UserInputState == Enum.UserInputState.Begin then
                    v_u_34 = p136
                    if v_u_27:GetAttribute("IsPlayerChatting") then
                        return
                    elseif v_u_11.IsLocalPlayerDead() then
                        return
                    elseif v_u_27.Character then
                        if v_u_16.GetState() ~= "Buy Period" then
                            v_u_20.broadcastRouter("Cancel Defuse Bomb")
                            v_u_128 = true
                            v_u_65(v_u_45.Shoot, 0.9)
                            v_u_21.new(function(p137, p138)
                                local v139 = v_u_9.getCurrentEquipped()
                                if v139 then
                                    p137(v139)
                                else
                                    p138("Failed to fetch current equipped")
                                end
                            end):catch(warn):andThen(function(p140)
                                if p140 then
                                    if p140.Properties.Class == "Weapon" then
                                        p140.IsFireHeld = true
                                        p140:shoot()
                                        return
                                    elseif p140.Properties.Class == "Melee" then
                                        p140.IsFireHeld = true
                                        p140:shoot()
                                        return
                                    elseif p140.Properties.Class == "C4" then
                                        p140:shoot()
                                        return
                                    elseif p140.Properties.Slot == "Grenade" then
                                        p140:StartThrow()
                                    end
                                else
                                    return
                                end
                            end)
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
        v_u_45.Shoot.InputEnded:Connect(v135)
        v_u_45.Shoot.InputChanged:Connect(function(p141)
            if p141 == v_u_34 and p141.UserInputType == Enum.UserInputType.Touch then
                v_u_29.addTouchMove(Vector2.new(p141.Delta.X, p141.Delta.Y))
            end
        end)
        v_u_45.Aim.Active = true
        local function v148(p142, p143)
            if p142 == v_u_35 then
                if p143 or p142.UserInputState == Enum.UserInputState.End then
                    v_u_35 = nil
                    v_u_65(v_u_45.Aim, 1)
                    v_u_21.new(function(p144, p145)
                        local v146 = v_u_9.getCurrentEquipped()
                        if v146 then
                            p144(v146)
                        else
                            p145("Failed to fetch current equipped")
                        end
                    end):catch(warn):andThen(function(p147)
                        if p147 then
                            if p147.Properties.HasScope then
                                p147:unscope()
                            end
                        else
                            return
                        end
                    end)
                end
            else
                return
            end
        end
        v_u_45.Aim.InputBegan:Connect(function(p149)
            if p149.UserInputType == Enum.UserInputType.Touch or p149.UserInputType == Enum.UserInputType.MouseButton1 then
                if v_u_35 then
                    return
                elseif p149.UserInputState == Enum.UserInputState.Begin then
                    v_u_35 = p149
                    v_u_65(v_u_45.Aim, 0.9)
                    v_u_21.new(function(p150, p151)
                        local v152 = v_u_9.getCurrentEquipped()
                        if v152 then
                            p150(v152)
                        else
                            p151("Failed to fetch current equipped")
                        end
                    end):catch(warn):andThen(function(p153)
                        if p153 then
                            if p153.Properties.HasScope then
                                p153:scope(true)
                                return
                            elseif p153.Properties.HasSuppressor then
                                if p153.IsSuppressed then
                                    p153:removeSuppressor()
                                else
                                    p153:addSuppressor()
                                end
                            elseif p153.Properties.ShootingOptions == "Burst" then
                                p153:updateFireMode()
                            end
                        else
                            return
                        end
                    end)
                end
            else
                return
            end
        end)
        v_u_45.Aim.InputEnded:Connect(v148)
        v_u_45.Aim.InputChanged:Connect(function(p154)
            if p154 == v_u_35 and p154.UserInputType == Enum.UserInputType.Touch then
                v_u_29.addTouchMove(Vector2.new(p154.Delta.X, p154.Delta.Y))
            end
        end)
        v_u_45.Interact.Active = true
        local v_u_155 = nil
        v_u_45.Interact.InputBegan:Connect(function(p156)
            if p156.UserInputType == Enum.UserInputType.Touch or p156.UserInputType == Enum.UserInputType.MouseButton1 then
                if v_u_155 then
                    return
                elseif p156.UserInputState == Enum.UserInputState.Begin then
                    v_u_155 = p156
                    local v157 = v_u_45.Interact
                    if not v_u_37[v157] and p156.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v157] = p156
                    end
                    local v158 = v_u_2:GetTagged("Bomb")[1]
                    if v158 and (v158:GetAttribute("CanDefuse") and not v158:GetAttribute("Defused")) then
                        v_u_20.broadcastRouter("Start Defuse Bomb")
                        return
                    else
                        local v159 = v_u_58()
                        if v159 then
                            local v160 = v_u_27:GetAttribute("Team")
                            if not v_u_27:GetAttribute("IsCarryingHostage") and (not v_u_27:GetAttribute("IsRescuingHostage") and v160 == "Counter-Terrorists") then
                                local v161 = v159:GetAttribute("RescuingPlayer")
                                local v162 = v159:GetAttribute("CarryingPlayer")
                                if (not v161 or v161 == v_u_27.Name) and not v162 then
                                    v_u_20.broadcastRouter("Start Rescue Hostage")
                                    return
                                end
                            end
                        end
                        local v163 = v_u_2:GetTagged("IsHoveringInteractable")
                        if #v163 == 0 then
                            return
                        else
                            local v164 = v163[1]
                            local v165 = v164:GetAttribute("Weapon")
                            local v166 = v164:GetAttribute("Skin")
                            if v165 ~= "C4" or v_u_27:GetAttribute("Team") == "Terrorists" then
                                if v164:GetAttribute("CanPickup") then
                                    local v167 = v_u_15.GetSkinInformation(v165, v166)
                                    if v167 then
                                        local v168 = v_u_25[v167.rarity]
                                        local v169 = v168.Color.R * 255
                                        local v170 = math.floor(v169)
                                        local v171 = v168.Color.G * 255
                                        local v172 = math.floor(v171)
                                        local v173 = v168.Color.B * 255
                                        local v174 = math.floor(v173)
                                        v_u_20.broadcastRouter("CreateNotification", "Item Picked Up", ("You picked up a <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v170, v172, v174, v165, v166), 2)
                                    end
                                    v_u_19.Inventory.PickupWeapon.Send({
                                        ["Identity"] = v164.Name
                                    })
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
        local function v_u_177(p175)
            if p175 == v_u_155 then
                v_u_155 = nil
                local v176 = v_u_45.Interact
                if v_u_37[v176] == p175 then
                    v_u_37[v176] = nil
                end
                if v_u_2:GetTagged("Bomb")[1] and v_u_27:GetAttribute("IsDefusingBomb") then
                    v_u_20.broadcastRouter("Cancel Defuse Bomb")
                    return
                elseif v_u_27:GetAttribute("IsRescuingHostage") then
                    v_u_20.broadcastRouter("Cancel Rescue Hostage")
                end
            else
                return
            end
        end
        v_u_45.Interact.InputEnded:Connect(v_u_177)
        v_u_45.Interact.InputChanged:Connect(function(p178)
            if p178 == v_u_155 and p178.UserInputType == Enum.UserInputType.Touch then
                v_u_29.addTouchMove(Vector2.new(p178.Delta.X, p178.Delta.Y))
            end
        end)
        v_u_45.Shop.InputBegan:Connect(function(p179)
            if p179.UserInputType == Enum.UserInputType.Touch or p179.UserInputType == Enum.UserInputType.MouseButton1 then
                if p179.UserInputState == Enum.UserInputState.Begin then
                    local v180 = v_u_45.Shop
                    if not v_u_37[v180] and p179.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v180] = p179
                    end
                    if v_u_37[v_u_45.Shop] == p179 then
                        v_u_65(v_u_45.Shop, 0.9)
                    end
                end
            end
        end)
        v_u_45.Shop.InputEnded:Connect(function(p181)
            if p181.UserInputType == Enum.UserInputType.Touch or p181.UserInputType == Enum.UserInputType.MouseButton1 then
                v_u_65(v_u_45.Shop, 1)
                local v182 = v_u_37[v_u_45.Shop]
                local v183
                if v182 then
                    v183 = (not p181 or p181 == v182) and true or false
                else
                    v183 = false
                end
                if v183 then
                    local v184 = v_u_45.Shop
                    if v_u_37[v184] == p181 then
                        v_u_37[v184] = nil
                    end
                    v_u_23.toggleFrame()
                else
                    local v185 = v_u_45.Shop
                    if v_u_37[v185] == p181 then
                        v_u_37[v185] = nil
                    end
                end
            else
                return
            end
        end)
        v_u_45.Menu.InputBegan:Connect(function(p186)
            if p186.UserInputType == Enum.UserInputType.Touch or p186.UserInputType == Enum.UserInputType.MouseButton1 then
                if p186.UserInputState == Enum.UserInputState.Begin then
                    local v187 = v_u_45.Menu
                    if not v_u_37[v187] and p186.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v187] = p186
                    end
                    if v_u_37[v_u_45.Menu] == p186 then
                        v_u_65(v_u_45.Menu, 0.9)
                    end
                end
            end
        end)
        v_u_45.Menu.InputEnded:Connect(function(p188)
            if p188.UserInputType == Enum.UserInputType.Touch or p188.UserInputType == Enum.UserInputType.MouseButton1 then
                v_u_65(v_u_45.Menu, 1)
                local v189 = v_u_37[v_u_45.Menu]
                local v190
                if v189 then
                    v190 = (not p188 or p188 == v189) and true or false
                else
                    v190 = false
                end
                if v190 then
                    local v191 = v_u_45.Menu
                    if v_u_37[v191] == p188 then
                        v_u_37[v191] = nil
                    end
                    v_u_24.ToggleMenu()
                else
                    local v192 = v_u_45.Menu
                    if v_u_37[v192] == p188 then
                        v_u_37[v192] = nil
                    end
                end
            else
                return
            end
        end)
        v_u_45.Inspect.InputBegan:Connect(function(p193)
            if p193.UserInputType == Enum.UserInputType.Touch or p193.UserInputType == Enum.UserInputType.MouseButton1 then
                if p193.UserInputState == Enum.UserInputState.Begin then
                    local v194 = v_u_45.Inspect
                    if not v_u_37[v194] and p193.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v194] = p193
                    end
                    if v_u_37[v_u_45.Inspect] == p193 then
                        v_u_65(v_u_45.Inspect, 0.9)
                    end
                end
            end
        end)
        v_u_45.Inspect.InputEnded:Connect(function(p195)
            if p195.UserInputType == Enum.UserInputType.Touch or p195.UserInputType == Enum.UserInputType.MouseButton1 then
                v_u_65(v_u_45.Inspect, 1)
                local v196 = v_u_37[v_u_45.Inspect]
                local v197
                if v196 then
                    v197 = (not p195 or p195 == v196) and true or false
                else
                    v197 = false
                end
                if v197 then
                    local v198 = v_u_45.Inspect
                    if v_u_37[v198] == p195 then
                        v_u_37[v198] = nil
                    end
                    if v_u_27:GetAttribute("IsPlayerChatting") then
                        return
                    elseif not (v_u_10.IsActive() or v_u_12.IsActive()) then
                        local v199 = v_u_9.getCurrentEquipped()
                        if v199 then
                            v199:inspect()
                            v_u_14:clearHint("Inspect")
                        end
                    end
                else
                    local v200 = v_u_45.Inspect
                    if v_u_37[v200] == p195 then
                        v_u_37[v200] = nil
                    end
                    return
                end
            else
                return
            end
        end)
        v_u_45.SwapTeam.InputBegan:Connect(function(p201)
            if p201.UserInputType == Enum.UserInputType.Touch or p201.UserInputType == Enum.UserInputType.MouseButton1 then
                if p201.UserInputState == Enum.UserInputState.Begin then
                    local v202 = v_u_45.SwapTeam
                    if not v_u_37[v202] and p201.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v202] = p201
                    end
                    if v_u_37[v_u_45.SwapTeam] == p201 then
                        v_u_65(v_u_45.SwapTeam, 0.9)
                    end
                end
            end
        end)
        v_u_45.SwapTeam.InputEnded:Connect(function(p203)
            if p203.UserInputType == Enum.UserInputType.Touch or p203.UserInputType == Enum.UserInputType.MouseButton1 then
                v_u_65(v_u_45.SwapTeam, 1)
                local v204 = v_u_37[v_u_45.SwapTeam]
                local v205
                if v204 then
                    v205 = (not p203 or p203 == v204) and true or false
                else
                    v205 = false
                end
                if v205 then
                    local v206 = v_u_45.SwapTeam
                    if v_u_37[v206] == p203 then
                        v_u_37[v206] = nil
                    end
                    if v_u_27:GetAttribute("IsSpectating") then
                        v_u_22.openFrame()
                        return
                    elseif v_u_27.Character then
                        v_u_22.ToggleTeamSelection()
                    end
                else
                    local v207 = v_u_45.SwapTeam
                    if v_u_37[v207] == p203 then
                        v_u_37[v207] = nil
                    end
                    return
                end
            else
                return
            end
        end)
        v_u_45.Ping.InputBegan:Connect(function(p208)
            if p208.UserInputType == Enum.UserInputType.Touch or p208.UserInputType == Enum.UserInputType.MouseButton1 then
                if p208.UserInputState == Enum.UserInputState.Begin then
                    local v209 = v_u_45.Ping
                    if not v_u_37[v209] and p208.UserInputState == Enum.UserInputState.Begin then
                        v_u_37[v209] = p208
                    end
                    if v_u_37[v_u_45.Ping] == p208 then
                        v_u_65(v_u_45.Ping, 0.9)
                        return
                    end
                end
            end
        end)
        v_u_45.Ping.InputEnded:Connect(function(p210)
            if p210.UserInputType == Enum.UserInputType.Touch or p210.UserInputType == Enum.UserInputType.MouseButton1 then
                v_u_65(v_u_45.Ping, 1)
                local v211 = v_u_37[v_u_45.Ping]
                local v212
                if v211 then
                    v212 = (not p210 or p210 == v211) and true or false
                else
                    v212 = false
                end
                if v212 then
                    local v213 = v_u_45.Ping
                    if v_u_37[v213] == p210 then
                        v_u_37[v213] = nil
                    end
                    if workspace:GetAttribute("Gamemode") == "Deathmatch" then
                        return
                    elseif v_u_13.Get(v_u_27, "Settings.Game.HUD.Player Pings") == "Disabled" then
                        return
                    else
                        local v214 = v_u_27.Character
                        local v215
                        if v214 and v214:IsDescendantOf(workspace) then
                            local v216 = v214:FindFirstChildOfClass("Humanoid")
                            v215 = v216 and v216.Health > 0 and true or false
                        else
                            v215 = false
                        end
                        if v215 then
                            local v217 = v_u_53(v_u_27.Character)
                            if v217 then
                                local v218, v219, v220 = v_u_49(v217.Instance)
                                local v221
                                if v218 then
                                    if v219 then
                                        v221 = v220
                                    else
                                        v221 = v219
                                    end
                                else
                                    v221 = v218
                                end
                                if v221 then
                                    v_u_19.Ping.CreatePlayerPositionPing.Send({
                                        ["Position"] = v217.Position,
                                        ["WeaponIdentity"] = v220,
                                        ["WeaponName"] = v218,
                                        ["WeaponSkin"] = v219,
                                        ["IsDanger"] = false
                                    })
                                else
                                    v_u_19.Ping.CreatePlayerPositionPing.Send({
                                        ["IsDanger"] = tick() - v_u_36 < 0.5,
                                        ["Position"] = v217.Position
                                    })
                                end
                                v_u_36 = tick()
                            end
                        else
                            return
                        end
                    end
                else
                    local v222 = v_u_45.Ping
                    if v_u_37[v222] == p210 then
                        v_u_37[v222] = nil
                    end
                    return
                end
            else
                return
            end
        end)
        local v_u_223 = v_u_155
        local v_u_224 = v_u_128
        for _, v225 in ipairs(v_u_45:GetChildren()) do
            if v225:IsA("TextButton") and (v225.Name ~= "Shoot" and v225.Name ~= "Aim") then
                v_u_1.setupButton(v225)
            end
        end
        v_u_6.Heartbeat:Connect(function()
            local _ = v_u_27:GetAttribute("IsSpectating") == true
            local v226 = v_u_45.Shop
            local v227 = v_u_27:GetAttribute("BuyMenu")
            if v227 then
                v227 = v_u_17(v_u_27)
            end
            v226.Visible = v227
            v_u_69()
            if v_u_45:FindFirstChild("Inspect") then
                if v_u_11.IsLocalPlayerDead() then
                    v_u_45.Inspect.Visible = false
                else
                    local v228 = v_u_9.getCurrentEquipped()
                    v_u_45.Inspect.Visible = v228 ~= nil
                end
            end
            if v_u_11.IsLocalPlayerDead() then
                v_u_45.Reload.Visible = false
            else
                local v229 = v_u_9.getCurrentEquipped()
                if v229 then
                    if v229.Properties.Class == "Weapon" then
                        v_u_45.Reload.Visible = true
                    else
                        v_u_45.Reload.Visible = false
                    end
                else
                    v_u_45.Reload.Visible = false
                end
            end
            v_u_72()
            if v_u_27:GetAttribute("IsSpectating") == true or v_u_11.IsLocalPlayerDead() then
                v_u_45.Ping.Visible = false
            else
                v_u_45.Ping.Visible = workspace:GetAttribute("Gamemode") ~= "Deathmatch"
            end
            local v230 = v_u_9.getCurrentEquipped()
            if v230 then
                local v231 = v230.Properties.ShootingOptions == "Burst"
                local v232 = v230.Properties.HasSuppressor == true
                local v233 = v230.Properties.HasScope == true
                v_u_45.Aim.Visible = v233 or (v232 or v231)
            else
                v_u_45.Aim.Visible = false
            end
        end)
        v_u_4.InputChanged:Connect(function(p234)
            if p234 == v_u_34 or (p234 == v_u_35 or p234 == v_u_223) then
                v_u_29.addTouchMove(Vector2.new(p234.Delta.X, p234.Delta.Y))
            end
        end)
        v_u_4.InputEnded:Connect(function(p235)
            if p235.UserInputType == Enum.UserInputType.Touch or p235.UserInputType == Enum.UserInputType.MouseButton1 then
                if p235 == v_u_34 then
                    v_u_34 = nil
                    if v_u_224 then
                        v_u_224 = false
                        v_u_65(v_u_45.Shoot, 1)
                        v_u_21.new(function(p236, p237)
                            local v238 = v_u_9.getCurrentEquipped()
                            if v238 then
                                p236(v238)
                            else
                                p237("Failed to fetch current equipped")
                            end
                        end):catch(warn):andThen(function(p239)
                            if p239 then
                                if p239.Properties.Class == "Weapon" then
                                    p239.IsFireHeld = false
                                    return
                                elseif p239.Properties.Class == "Melee" then
                                    p239.IsFireHeld = false
                                    return
                                elseif p239.Properties.Class == "C4" then
                                    p239:cancel()
                                    return
                                elseif p239.Properties.Slot == "Grenade" then
                                    p239:Throw("Far")
                                end
                            else
                                return
                            end
                        end)
                    end
                end
                if p235 == v_u_35 then
                    v_u_35 = nil
                    v_u_65(v_u_45.Aim, 1)
                    v_u_21.new(function(p240, p241)
                        local v242 = v_u_9.getCurrentEquipped()
                        if v242 then
                            p240(v242)
                        else
                            p241("Failed to fetch current equipped")
                        end
                    end):catch(warn):andThen(function(p243)
                        if p243 then
                            if p243.Properties.HasScope then
                                p243:unscope()
                            end
                        else
                            return
                        end
                    end)
                end
                v_u_177(p235)
                for v244, v245 in pairs(v_u_37) do
                    if v245 == p235 then
                        v_u_37[v244] = nil
                    end
                end
            end
        end)
    else
        v_u_45.Visible = false
    end
end
function v_u_1.Start()
    v_u_45.Visible = false
    if v_u_33 then
        if v_u_27:GetAttribute("IsSpectating") == true then
            if v_u_45 then
                for _, v246 in ipairs(v_u_44) do
                    local v247 = v_u_45:FindFirstChild(v246)
                    if v247 then
                        v247.Visible = table.find(v_u_43, v246) ~= nil
                    end
                end
            end
            v_u_45.Visible = true
        elseif v_u_27.Character then
            if v_u_45 then
                for _, v248 in ipairs(v_u_44) do
                    local v249 = v_u_45:FindFirstChild(v248)
                    if v249 then
                        v249.Visible = true
                    end
                end
            end
            v_u_45.Visible = true
        end
    end
    v_u_27.CharacterAdded:Connect(function()
        v_u_45.Visible = v_u_33
        if v_u_45 then
            for _, v250 in ipairs(v_u_44) do
                local v251 = v_u_45:FindFirstChild(v250)
                if v251 then
                    v251.Visible = true
                end
            end
        end
    end)
    v_u_27.CharacterRemoving:Connect(function()
        local v252 = v_u_27:GetAttribute("IsSpectating") == true
        v_u_35 = nil
        if v252 and v_u_33 then
            if v_u_45 then
                for _, v253 in ipairs(v_u_44) do
                    local v254 = v_u_45:FindFirstChild(v253)
                    if v254 then
                        v254.Visible = table.find(v_u_43, v253) ~= nil
                    end
                end
            end
            v_u_45.Visible = true
        else
            v_u_45.Visible = false
        end
    end)
    v_u_27:GetAttributeChangedSignal("IsSpectating"):Connect(function()
        local v255 = v_u_27:GetAttribute("IsSpectating") == true
        if v_u_33 then
            if v255 then
                if v_u_45 then
                    for _, v256 in ipairs(v_u_44) do
                        local v257 = v_u_45:FindFirstChild(v256)
                        if v257 then
                            v257.Visible = table.find(v_u_43, v256) ~= nil
                        end
                    end
                end
                v_u_45.Visible = true
                return
            elseif v_u_27.Character then
                if v_u_45 then
                    for _, v258 in ipairs(v_u_44) do
                        local v259 = v_u_45:FindFirstChild(v258)
                        if v259 then
                            v259.Visible = true
                        end
                    end
                end
                v_u_45.Visible = true
            else
                v_u_45.Visible = false
            end
        elseif not v255 then
            v_u_45.Visible = false
        end
    end)
    v_u_13.CreateListener(v_u_27, "MobileButtons", function(p260)
        if typeof(p260) == "table" then
            for v261, v262 in pairs(p260) do
                local v263 = v_u_45:FindFirstChild(v261)
                if v263 then
                    v263.Position = UDim2.fromScale(v262.Position.X, v262.Position.Y)
                    v263.Size = UDim2.fromScale(v262.Size.X, v262.Size.Y)
                    v_u_38[v263] = v263.Size
                end
            end
        end
    end)
end
return v_u_1