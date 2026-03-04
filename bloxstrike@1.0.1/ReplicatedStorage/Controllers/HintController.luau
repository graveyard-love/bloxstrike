local v_u_1 = {}
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("ReplicatedStorage")
local v_u_5 = game:GetService("CollectionService")
local v_u_6 = v2.LocalPlayer
local v_u_7 = workspace.CurrentCamera
local v_u_8 = require(v4.Database.Components.GameState)
local v_u_9 = require(script.Parent.InputController)
local v_u_10 = require(v4.Components.Common.GetPreferenceColor)
local v11 = require(v4.Database.Security.Remotes)
local v_u_12 = nil
local v_u_13 = nil
local v14 = v4:WaitForChild("Assets"):WaitForChild("UI"):WaitForChild("Hints")
local v_u_15 = v14:WaitForChild("Static")
local v_u_16 = v14:WaitForChild("Ranged")
local v_u_17 = {
    ["Inspect"] = {
        ["Type"] = "Static",
        ["Action"] = "Inspect",
        ["Blurb"] = "Inspect"
    },
    ["Reload"] = {
        ["Type"] = "Static",
        ["Action"] = "Reload",
        ["Blurb"] = "Reload your Weapon!"
    },
    ["Use"] = {
        ["Type"] = "Static",
        ["Action"] = "Use"
    },
    ["Plant"] = {
        ["Type"] = "Ranged",
        ["Action"] = "Plant",
        ["Blurb"] = "Plant the Bomb!",
        ["HideDistance"] = 5
    },
    ["Defuse"] = {
        ["Type"] = "Ranged",
        ["Action"] = "Defuse",
        ["Blurb"] = "Defuse the Bomb!",
        ["HideDistance"] = 5
    },
    ["Rescue"] = {
        ["Type"] = "Ranged",
        ["Action"] = "Rescue",
        ["Blurb"] = "Rescue the Hostage!",
        ["HideDistance"] = 5
    },
    ["Return"] = {
        ["Type"] = "Ranged",
        ["Action"] = "Return",
        ["Blurb"] = "Return the Hostage",
        ["HideDistance"] = 5
    }
}
local function v_u_22(p18, p19)
    local v20 = {}
    for _, v21 in ipairs(p18:GetDescendants()) do
        if v21:IsA("BasePart") and v21:GetAttribute("Site") == p19 then
            table.insert(v20, v21)
        end
    end
    return v20
end
function isOnScreen(p23)
    local v24, v25 = v_u_7:WorldToViewportPoint(p23)
    local v26 = v_u_7.ViewportSize
    if v25 then
        if v24.X < 100 or (v24.X > v26.X - 100 or (v24.Y < 100 or v24.Y > v26.Y - 100)) then
            return false, v24
        else
            return true, v24
        end
    else
        return false, v24
    end
end
local function v_u_53()
    if v_u_12 and (v_u_12.ui and v_u_12.target) then
        local v27 = v_u_12.icon
        local v28 = v_u_12.arrow
        local v29 = v_u_12.attentionFrame
        if not (v27 and (v28 and v29)) then
            v27 = v_u_12.ui:FindFirstChild("Icon")
            v28 = v_u_12.ui:FindFirstChild("Arrow")
            v29 = v_u_12.ui:FindFirstChild("Attention")
            if not (v27 and (v28 and v29)) then
                return
            end
            v_u_12.icon = v27
            v_u_12.arrow = v28
            v_u_12.attentionFrame = v29
        end
        local v30 = v_u_7.CFrame
        local v31 = v_u_7.ViewportSize
        if v_u_12.target and v_u_12.target.Parent then
            local v32 = v_u_12.target.Position
            local v33 = v_u_6.Character
            if v33 then
                local v34 = v33.PrimaryPart or v33:FindFirstChild("HumanoidRootPart")
                if v34 and (v34.Position - v32).Magnitude <= (v_u_12.hideDistance or 5) then
                    local v35 = v_u_12 and v_u_12.ui
                    if v35 then
                        v35 = v_u_12.ui:GetAttribute("Type")
                    end
                    v_u_1:clearHint()
                    if v35 then
                        if v35 == "Defuse" then
                            v_u_1:createHint("Use", nil, "Defuse the Bomb!")
                            task.delay(3, function()
                                v_u_1:clearHint("Use")
                            end)
                        elseif v35 == "Rescue" then
                            v_u_1:createHint("Use", nil, "Rescue the Hostage!")
                            task.delay(3, function()
                                v_u_1:clearHint("Use")
                            end)
                        end
                    else
                        return
                    end
                end
            end
            local v36, v37 = isOnScreen(v32)
            if v36 then
                v_u_12.ui.BackgroundTransparency = 0.5
                v_u_12.ui.Position = UDim2.new(0, v37.X, 0, v37.Y - 60)
                v_u_12.ui.AnchorPoint = Vector2.new(0.5, 0.5)
                v29.Size = UDim2.new(0.75, 0, 0.75, 0)
                v29.Visible = true
                v28.Visible = false
                v27.Visible = false
                v_u_12.ui.Visible = true
            else
                v_u_12.ui.BackgroundTransparency = 1
                local v38 = (v32 - v30.Position).Unit
                local v39 = Vector2.new(v31.X / 2, v31.Y / 2)
                local v40 = v30.RightVector
                local v41 = v30.UpVector
                local v42 = v38:Dot(v40)
                local v43 = -v38:Dot(v41)
                local v44 = math.atan2(v43, v42)
                local v45 = v31.X
                local v46 = v31.Y
                local v47 = math.min(v45, v46) / 2 - 60
                local v48 = v39.X + math.cos(v44) * v47
                local v49 = v39.Y + math.sin(v44) * v47
                v_u_12.ui.Position = UDim2.new(0, v48, 0, v49)
                v_u_12.ui.AnchorPoint = Vector2.new(0.5, 0.5)
                v28.Visible = true
                v28.Position = UDim2.new(0.5, 0, 0.5, 0)
                v28.AnchorPoint = Vector2.new(0.5, 0.5)
                v28.Rotation = math.deg(v44) - 90
                local v50 = v44 + 3.141592653589793
                local v51 = math.cos(v50) * 55
                local v52 = math.sin(v50) * 55
                v27.Position = UDim2.new(0.5, v51, 0.5, v52)
                v27.Visible = true
                v29.Visible = false
                v_u_12.ui.Visible = true
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_67(p54, p55, p56, p57, p58)
    if p54 and p55 then
        if p54:FindFirstChild("Left") and p54:FindFirstChild("Right") then
            p54.Left.BackgroundColor3 = v_u_10()
            p54.Right.BackgroundColor3 = v_u_10()
            if p55.Type == "Static" then
                local v59 = p54:FindFirstChild("ControlIcon")
                local v60 = p54:FindFirstChild("Instructions")
                if v59 and v60 then
                    local v61 = v59:FindFirstChild("KeycapIcon")
                    if v61 then
                        local v62 = v61:FindFirstChild("Control")
                        if v62 then
                            p54:SetAttribute("Type", p55.Action)
                            v60.Text = p58 or p55.Blurb
                            v62.Text = p56 or "???"
                        end
                    else
                        return
                    end
                else
                    return
                end
            else
                if p55.Type == "Ranged" then
                    local v63 = p54:FindFirstChild("Icon")
                    local v64 = p54:FindFirstChild("Arrow")
                    local v65 = p54:FindFirstChild("Attention")
                    local v66 = v65:FindFirstChild("Instructions")
                    if not (v63 and (v64 and (v65 and (p57 and v66)))) then
                        return
                    end
                    v66.Text = p55.Blurb
                    if v_u_13 then
                        v_u_13:Disconnect()
                        v_u_13 = nil
                    end
                    v_u_13 = v_u_3.RenderStepped:Connect(function()
                        v_u_53()
                    end)
                end
                return
            end
        else
            p54:Destroy()
            return
        end
    else
        return
    end
end
function v_u_1.getKeyOfAction(_, p68)
    if p68 then
        return v_u_9.GetActionKeybind(p68)
    end
end
function v_u_1.createHint(_, p69, p70, p71)
    if v_u_8.GetState() == "Round In Progress" then
        if p69 and v_u_17[p69] then
            v_u_1:clearHint()
            local v72 = v_u_17[p69]
            local v73 = v_u_6:FindFirstChild("PlayerGui")
            if v73 then
                local v74 = v73:FindFirstChild("MainGui")
                if v74 then
                    local v75 = v74:WaitForChild("Gameplay")
                    if v75 then
                        local v76 = v75:WaitForChild("Middle")
                        if v76 then
                            if v72.Type == "Static" then
                                local v77 = v_u_15:Clone()
                                v_u_67(v77, v72, v_u_1:getKeyOfAction(p69), nil, p71)
                                v_u_12 = {
                                    ["ui"] = v77,
                                    ["target"] = nil,
                                    ["hintType"] = p69,
                                    ["hideDistance"] = nil
                                }
                                v77:SetAttribute("Type", p69)
                                v77.Parent = v76
                                v77.Visible = true
                            elseif v72.Type == "Ranged" and p70 then
                                local v78 = v_u_16:Clone()
                                v_u_12 = {
                                    ["ui"] = v78,
                                    ["target"] = p70,
                                    ["hintType"] = p69,
                                    ["hideDistance"] = v72.HideDistance or 5,
                                    ["icon"] = v78:FindFirstChild("Icon"),
                                    ["arrow"] = v78:FindFirstChild("Arrow"),
                                    ["attentionFrame"] = v78:FindFirstChild("Attention")
                                }
                                v_u_67(v78, v72, nil, p70)
                                v78:SetAttribute("Type", p69)
                                v78.Parent = v76
                                v78.Visible = true
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
    else
        return
    end
end
function v_u_1.clearHint(_, p79)
    if p79 then
        if v_u_12 and v_u_12.hintType == p79 then
            if v_u_12.ui then
                v_u_12.ui:Destroy()
            end
            if v_u_13 then
                v_u_13:Disconnect()
                v_u_13 = nil
            end
            v_u_12 = nil
        end
    elseif v_u_12 then
        if v_u_12.ui then
            v_u_12.ui:Destroy()
        end
        if v_u_13 then
            v_u_13:Disconnect()
            v_u_13 = nil
        end
        v_u_12 = nil
    end
end
v11.Hints.BombSiteEntered.Listen(function(p80)
    if p80 and (p80.action and p80.site) then
        local v81 = workspace:FindFirstChild("Map")
        if v81 then
            local v82 = v81:FindFirstChild("Zones")
            if v82 then
                local v83 = v82:FindFirstChild("Sites")
                if v83 then
                    local v84 = v_u_22(v83, p80.site)
                    if p80.action == "Defuse" then
                        local v85 = v_u_5:GetTagged("Bomb")
                        if #v85 == 1 and (v84 and #v84 > 0) then
                            local v86 = v84[math.random(1, #v84)]
                            local v87 = v85[1].PrimaryPart or v86
                            if v86 then
                                v_u_1:createHint(p80.action, v87)
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
    else
        return
    end
end)
v11.Hints.ClearHint.Listen(function()
    v_u_1:clearHint("Rescue")
    v_u_1:clearHint("UseRescue")
end)
v11.Character.CharacterDied.Listen(function()
    v_u_1:clearHint()
end)
v_u_8.ListenToState(function(_, p88)
    if p88 ~= "Round In Progress" then
        v_u_1:clearHint()
    end
end)
local function v_u_95()
    if not (v_u_6 and (v_u_6.Character and v_u_6.Character.PrimaryPart)) then
        return nil, (1 / 0)
    end
    local v89 = v_u_5:GetTagged("Hostage")
    if not v89 or #v89 <= 0 then
        return nil, (1 / 0)
    end
    local v90 = v_u_6.Character.PrimaryPart.Position
    local v91 = (1 / 0)
    local v92 = nil
    for _, v93 in ipairs(v89) do
        if v93.PrimaryPart and v93:GetAttribute("CanRescue") then
            local v94 = (v93.PrimaryPart.Position - v90).Magnitude
            if v94 < v91 then
                v92 = v93
                v91 = v94
            end
        end
    end
    return v92, v91
end
local function v_u_110()
    if v_u_8.GetState() == "Round In Progress" then
        local v96 = v_u_6:GetAttribute("Team")
        if v96 then
            v96 = v_u_6:GetAttribute("Team") == "Counter-Terrorists"
        end
        if v96 then
            if v_u_6:GetAttribute("IsCarryingHostage") == true then
                if v_u_12 and (v_u_12.hintType == "Rescue" or v_u_12.hintType == "UseRescue") then
                    v_u_1:clearHint()
                end
                local v97 = workspace:FindFirstChild("Map")
                if v97 then
                    local v98 = v97:FindFirstChild("Zones")
                    local v99 = v98 and v98:FindFirstChild("Hints")
                    if v99 then
                        local v100 = {}
                        for _, v101 in ipairs(v99:GetChildren()) do
                            if v101:IsA("BasePart") then
                                table.insert(v100, v101)
                            end
                        end
                        if #v100 > 0 and (v_u_6.Character and v_u_6.Character.PrimaryPart) then
                            local v102 = v_u_6.Character.PrimaryPart.Position
                            local v103 = (1 / 0)
                            local v104 = nil
                            for _, v105 in ipairs(v100) do
                                local v106 = (v105.Position - v102).Magnitude
                                if v106 < v103 then
                                    v104 = v105
                                    v103 = v106
                                end
                            end
                            if v104 and (not v_u_12 or (v_u_12.hintType ~= "Return" or v_u_12.target ~= v104)) then
                                v_u_1:clearHint()
                                v_u_1:createHint("Return", v104)
                            end
                        end
                    end
                end
                return
            else
                local v107 = v_u_5:GetTagged("Hostage")
                if v107 and #v107 > 0 then
                    local v108, v109 = v_u_95()
                    if v_u_12 and (v_u_12.hintType == "Rescue" or v_u_12.hintType == "UseRescue") then
                        if v_u_12.target and v108 then
                            if v109 >= 50 then
                                v_u_1:clearHint()
                                return
                            end
                            if v_u_12.target ~= v108.PrimaryPart and (v109 < (v_u_6.Character.PrimaryPart.Position - v_u_12.target.Position).Magnitude - 10 and v109 < 50) then
                                v_u_1:clearHint()
                                v_u_1:createHint("Rescue", v108.PrimaryPart)
                                return
                            end
                        elseif not v108 or v109 >= 50 then
                            v_u_1:clearHint()
                        end
                    elseif v108 and v109 < 50 then
                        v_u_1:createHint("Rescue", v108.PrimaryPart)
                    end
                else
                    if v_u_12 and (v_u_12.hintType == "Rescue" or v_u_12.hintType == "UseRescue") then
                        v_u_1:clearHint()
                    end
                    return
                end
            end
        else
            return
        end
    else
        return
    end
end
task.spawn(function()
    while true do
        v_u_110()
        task.wait(2)
    end
end)
return v_u_1