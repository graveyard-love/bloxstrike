local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("GuiService")
local v6 = game:GetService("Lighting")
local v7 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_8 = v7.LocalPlayer
local v_u_9 = require(v_u_2.Controllers.CameraController)
local v_u_10 = require(v_u_2.Components.Common.GetUserPlatform)
local v_u_11 = require(v_u_2.Database.Components.GameState)
local v_u_12 = require(v_u_2.Database.Security.Router)
local v_u_13 = require(v_u_2.Packages.Observers)
local v_u_14 = require(v_u_2.Interface.MenuState)
local v_u_15 = require(v_u_2.Interface.Screens.Gameplay.Middle.TeamSelection)
local v_u_16 = workspace.CurrentCamera
local v_u_17 = Instance.new("BlurEffect", v6)
v_u_17.Enabled = false
v_u_17.Name = "Menu"
v_u_17.Size = 20
local v_u_18 = false
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = Color3.fromRGB(255, 255, 255)
local v_u_22 = Color3.fromRGB(150, 220, 239)
local v_u_23 = Color3.fromRGB(175, 175, 175)
local v_u_24 = nil
local v_u_25 = nil
local function v_u_28(p26, p27)
    if p26:IsA("ImageButton") then
        v_u_4:Create(p26, TweenInfo.new(0.15), {
            ["ImageColor3"] = p27
        }):Play()
    elseif p26:IsA("TextButton") then
        v_u_4:Create(p26.TextLabel, TweenInfo.new(0.15), {
            ["TextColor3"] = p27
        }):Play()
    end
end
local function v_u_32(p_u_29)
    if p_u_29:IsA("ImageButton") then
        p_u_29.ImageColor3 = v_u_21
    elseif p_u_29:IsA("TextButton") then
        p_u_29.TextLabel.TextColor3 = v_u_21
    end
    p_u_29.MouseLeave:Connect(function()
        if v_u_20 ~= p_u_29 then
            v_u_28(p_u_29, v_u_21)
        end
    end)
    p_u_29.MouseEnter:Connect(function()
        v_u_12.broadcastRouter("RunInterfaceSound", "UI Highlight")
        if v_u_20 ~= p_u_29 then
            v_u_28(p_u_29, v_u_23)
        end
    end)
    p_u_29.MouseButton1Click:Connect(function()
        local v30 = v_u_20
        v_u_20 = p_u_29
        if v30 ~= p_u_29 then
            v_u_28(p_u_29, v_u_22)
            if v30 then
                local v31 = v30:FindFirstChild("Alert")
                v_u_28(v30, v_u_21)
                if v31 then
                    v31.Visible = false
                    return
                end
            end
        end
    end)
end
function v_u_1.UpdateBackground(p33)
    if require(v_u_2.Controllers.MenuSceneController).IsActive() then
        return
    elseif v_u_14.IsInspectActive() or v_u_14.IsCaseSceneActive() then
        return
    elseif not v_u_8:GetAttribute("IsSpectating") then
        local v34 = v_u_25.Menu.Visible and (not v_u_8.Character and p33:FindFirstChild("Cameras"))
        if v34 then
            local v35 = v34:GetChildren()
            local v36 = v35[1]
            assert(v36, "Current map doesnt contain any cameras.")
            v_u_16.CameraType = Enum.CameraType.Scriptable
            v_u_16.CameraSubject = nil
            local v37 = v35[math.random(1, #v35)]
            v_u_8.ReplicationFocus = v37
            v_u_16.CFrame = v37.CFrame
            v_u_9.updateCameraFOV(80)
        end
    end
end
function v_u_1.ToggleMenu()
    if v_u_14.IsInspectActive() or v_u_14.IsCaseSceneActive() then
        return
    else
        if workspace:FindFirstChild("Map") then
            v_u_1.UpdateBackground(workspace:FindFirstChild("Map"))
        end
        local v38 = v_u_11.GetState()
        if v38 and (v38 ~= "Map Voting" and v38 ~= "Game Ending") then
            if v_u_25.Menu.Visible then
                v_u_9.setForceLockOverride("Menu", false)
                if not v_u_8:GetAttribute("IsSpectating") then
                    v_u_9.setPerspective(true, false)
                end
                v_u_14.SetBlurEnabled(false)
                v_u_25.Gameplay.Visible = true
                v_u_25.Gameplay.Top.Visible = true
                v_u_25.Menu.Visible = false
                v_u_14.SetScreen(nil)
            else
                if v_u_25.Gameplay.Middle.TeamSelection.Visible then
                    v_u_15.closeFrame()
                end
                v_u_9.setForceLockOverride("Menu", true)
                if not v_u_8:GetAttribute("IsSpectating") then
                    v_u_9.setPerspective(true, true)
                end
                v_u_25.Gameplay.Visible = false
                v_u_25.Menu.Visible = true
                if v_u_8.Character then
                    v_u_1.openFrame("GameDashboard")
                end
                if v_u_19 and v_u_19.Name ~= "Dashboard" then
                    v_u_14.SetBlurEnabled(true)
                end
            end
        else
            return
        end
    end
end
function v_u_1.openFrame(p39)
    if v_u_14.IsInspectActive() then
        return
    elseif v_u_14.IsCaseSceneActive() then
        return
    else
        local v40
        if p39 == "Dashboard" then
            v40 = false
        else
            v40 = p39 ~= "Play"
        end
        v_u_14.SetBlurEnabled(v40)
        local v41 = v_u_25.Menu:FindFirstChild("Pattern")
        v_u_25.Menu.BackgroundTransparency = v40 and 0.15 or 1
        if v41 then
            v41.Visible = not v40
        end
        if p39 == "Play" then
            local v42 = v_u_11.GetState()
            local v43 = require(v_u_2.Controllers.EndScreenController)
            if v42 and (v42 ~= "Game Ending" or not v43.IsActive()) then
                local v44 = nil
                v_u_12.broadcastRouter("RunInterfaceSound", "UI Play Click")
                v_u_9.resetForceLockOverride()
                v_u_9.setPerspective(true, false)
                if v_u_19 and v_u_19.Name ~= "Dashboard" then
                    v_u_19.Visible = false
                    local v45 = v_u_25.Menu:FindFirstChild("Dashboard")
                    if v45 then
                        v45.Visible = true
                        v_u_19 = v45
                    end
                end
                v_u_25.Gameplay.Bottom.Visible = false
                v_u_25.Gameplay.Top.Visible = true
                v_u_25.Gameplay.Visible = true
                v_u_25.Menu.Visible = false
                v_u_14.SetScreen(nil)
                local v46
                if v42 == "Map Voting" then
                    v46 = "EndScreen"
                else
                    local v47 = v_u_8:GetAttribute("Team")
                    v46 = (not v_u_8.Character or (not v47 or v47 == "Spectators")) and "TeamSelection" or v44
                end
                if v46 then
                    v_u_9.setForceLockOverride(v46, true)
                    v_u_9.setPerspective(true, true)
                    for _, v48 in ipairs(v_u_25.Gameplay.Middle:GetChildren()) do
                        if v48.Name == "Chat" then
                            v48.Visible = not table.find(v_u_10(), "Mobile")
                        else
                            v48.Visible = (v48.Name == "Notification" or v48.Name == "Votekick" and v48:GetAttribute("IsVoteKickActive") == true) and true or v48.Name == v46
                        end
                    end
                    return
                end
                v_u_25.Gameplay.Middle.SessionStats.Visible = table.find(v_u_10(), "Mobile") == nil
                v_u_25.Gameplay.Middle.TeamSelection.Visible = false
                v_u_25.Gameplay.Middle.Crosshair.Visible = true
                v_u_25.Gameplay.Top.Visible = true
                v_u_25.Gameplay.Bottom.Visible = true
                if v_u_8.Character then
                    v_u_9.setPerspective(true, false)
                    return
                end
            end
            return
        else
            local v49 = v_u_25.Menu:FindFirstChild(p39)
            if v49 and v49 ~= v_u_19 then
                v49.Visible = true
                if v_u_19 then
                    v_u_19.Visible = false
                end
                v_u_19 = v49
                local v50 = v_u_14.SetScreen
                local v51
                if p39 == "Dashboard" or (p39 == "Inventory" or (p39 == "Loadout" or (p39 == "Modes" or (p39 == "Settings" or (p39 == "Store" or p39 == "GameDashboard"))))) then
                    v51 = p39
                else
                    v51 = nil
                end
                v50(v51)
            end
            if v_u_18 then
                v_u_12.broadcastRouter("RunInterfaceSound", (("UI %* Click"):format(p39)))
            else
                v_u_18 = p39 == "Dashboard"
            end
        end
    end
end
function v_u_1.CloseTeamSelection()
    v_u_25.Gameplay.Middle.TeamSelection.Visible = false
    v_u_25.Gameplay.Middle.Crosshair.Visible = true
    v_u_25.Gameplay.Top.Visible = true
    v_u_25.Gameplay.Bottom.Visible = true
    if v_u_17.Enabled then
        v_u_1.UpdateBackground(workspace:FindFirstChild("Map"))
    end
end
local v_u_52 = {
    "Inventory",
    "Loadout",
    "Play",
    "Store",
    "Modes"
}
local function v_u_56(p53)
    if v_u_24 and v_u_24.Buttons then
        local v54 = v_u_24.Buttons:FindFirstChild(p53)
        if v54 and v54:IsA("GuiButton") then
            local v55 = v_u_20
            v_u_20 = v54
            v_u_28(v_u_20, v_u_22)
            if v55 and v55 ~= v_u_20 then
                v_u_28(v55, v_u_21)
            end
            v_u_5.SelectedObject = v54
            v_u_12.broadcastRouter("RunInterfaceSound", "UI Highlight")
        end
    else
        return
    end
end
local function v_u_60(p57)
    if v_u_24 and v_u_24.Buttons then
        local v58 = v_u_24.Buttons:FindFirstChild(p57)
        if v58 and v58:IsA("GuiButton") then
            v_u_1.openFrame(p57)
            local v59 = v_u_20
            v_u_20 = v58
            v_u_28(v_u_20, v_u_22)
            if v59 and v59 ~= v_u_20 then
                v_u_28(v59, v_u_21)
            end
            v_u_5.SelectedObject = v58
            v_u_12.broadcastRouter("RunInterfaceSound", "UI Highlight")
        end
    else
        return
    end
end
local function v_u_64()
    if not v_u_25 then
        return false
    end
    local v61 = v_u_14.GetCurrentScreen()
    if not (v_u_25.Menu.Visible and v61) then
        return false
    end
    if v61 ~= "Loadout" and (v61 ~= "Inventory" and (v61 ~= "Modes" and v61 ~= "Settings")) and v61 ~= "Store" then
        return false
    end
    local v62 = v_u_25.Menu:FindFirstChild(v61)
    local v63
    if v62 == nil then
        v63 = false
    else
        v63 = v62.Visible
    end
    return v63
end
function v_u_1.ResetToMainMenu()
    if v_u_14.IsInspectActive() or v_u_14.IsCaseSceneActive() then
        return
    elseif not v_u_64() then
        for _, v65 in ipairs(v_u_25.Menu:GetChildren()) do
            if v65:IsA("Frame") and (v65.Name ~= "Top" and v65.Name ~= "Dashboard") then
                v65.Visible = false
            end
        end
        local v66 = v_u_25.Menu:FindFirstChild("Dashboard")
        if v66 then
            v66.Visible = true
            v_u_19 = v66
        end
        local v67 = v_u_25.Menu:FindFirstChild("Top")
        if v67 then
            v67.Visible = true
        end
        v_u_14.SetBlurEnabled(false)
        v_u_25.Menu.BackgroundTransparency = 1
        local v68 = v_u_25.Menu:FindFirstChild("Pattern")
        if v68 then
            v68.Visible = true
        end
        v_u_14.SetScreen("Dashboard")
        if v_u_20 then
            v_u_28(v_u_20, v_u_21)
        end
        v_u_20 = v_u_24.Other.Dashboard
        v_u_28(v_u_20, v_u_22)
    end
end
function v_u_1.Initialize(p69, p70)
    v_u_25 = p69
    v_u_24 = p70
    for _, v_u_71 in ipairs(v_u_24.Other:GetChildren()) do
        if v_u_71:IsA("ImageButton") then
            v_u_32(v_u_71)
            v_u_71.MouseButton1Click:Connect(function()
                v_u_1.openFrame(v_u_71.Name)
            end)
        end
    end
    for _, v_u_72 in ipairs(v_u_24.Buttons:GetChildren()) do
        if v_u_72:IsA("TextButton") then
            v_u_32(v_u_72)
            v_u_72.MouseButton1Click:Connect(function()
                v_u_1.openFrame(v_u_72.Name)
            end)
        end
    end
    if workspace:FindFirstChild("Map") then
        v_u_1.UpdateBackground(workspace:FindFirstChild("Map"))
    end
    workspace.ChildAdded:Connect(function(p73)
        if p73.Name == "Map" then
            task.delay(0.25, v_u_1.UpdateBackground, p73)
        end
    end)
end
function v_u_1.Start()
    v_u_20 = v_u_24.Other.Dashboard
    v_u_28(v_u_20, v_u_22)
    local v74 = v_u_25.Menu:FindFirstChild("Pattern")
    v_u_25.Menu.BackgroundTransparency = 1
    if v74 then
        v74.Visible = false
    end
    if v_u_25.Menu.Visible then
        v_u_9.setForceLockOverride("Menu", true)
    end
    local v75 = v_u_8:GetAttribute("Team")
    local v76 = v75 == "Counter-Terrorists" and true or v75 == "Terrorists"
    if not (v_u_8.Character or v76) then
        if not v_u_9.isForceLockOverrideActive() then
            v_u_9.setForceLockOverride("Menu", true)
        end
        if not v_u_25.Menu.Visible then
            v_u_25.Menu.Visible = true
        end
    end
    v_u_3.InputBegan:Connect(function(p77, _)
        if not (v_u_25 and v_u_25.Menu.Visible) then
            return
        end
        if v_u_14.IsInspectActive() or v_u_14.IsCaseSceneActive() then
            return
        end
        if v_u_8:GetAttribute("IsPlayerChatting") then
            return
        end
        local v78
        if p77.UserInputType == Enum.UserInputType.Gamepad1 then
            v78 = p77.KeyCode == Enum.KeyCode.ButtonL1
        else
            v78 = false
        end
        local v79
        if p77.UserInputType == Enum.UserInputType.Gamepad1 then
            v79 = p77.KeyCode == Enum.KeyCode.ButtonR1
        else
            v79 = false
        end
        if not (v78 or v79) then
            return
        end
        local v80 = v_u_20 and v_u_20.Name or nil
        for _, v82 in ipairs(v_u_52) do
            if v82 == v80 then
                goto l26
            end
        end
        local v82 = "Play"
        ::l26::
        local v83
        if v78 then
            local v84 = table.find(v_u_52, v82)
            if v84 then
                local v85 = #v_u_52
                v83 = v_u_52[(v84 - 2 + v85) % v85 + 1]
            else
                v83 = nil
            end
        else
            local v86 = table.find(v_u_52, v82)
            if v86 then
                v83 = v_u_52[v86 % #v_u_52 + 1]
            else
                v83 = nil
            end
        end
        if v83 then
            if v83 == "Play" then
                v_u_56("Play")
                return
            end
            v_u_60(v83)
        end
    end)
    v_u_3.InputBegan:Connect(function(p87, _)
        if v_u_25 and v_u_25.Menu.Visible then
            if v_u_14.IsInspectActive() or v_u_14.IsCaseSceneActive() then
                return
            elseif v_u_8:GetAttribute("IsPlayerChatting") then
                return
            elseif p87.UserInputType == Enum.UserInputType.Gamepad1 then
                if p87.KeyCode == Enum.KeyCode.ButtonA then
                    local v88 = v_u_24 and v_u_24.Buttons
                    if v88 then
                        v88 = v_u_24.Buttons:FindFirstChild("Play")
                    end
                    if v88 then
                        local v89 = v_u_5.SelectedObject
                        if v89 == v88 or v89 and v89:IsDescendantOf(v88) then
                            v_u_1.openFrame("Play")
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
    v_u_1.openFrame("Dashboard")
    v_u_5:GetPropertyChangedSignal("SelectedObject"):Connect(function()
        if not (v_u_25 and v_u_25.Menu.Visible) then
            return
        end
        if v_u_14.IsInspectActive() or v_u_14.IsCaseSceneActive() then
            return
        end
        if not (v_u_24 and v_u_24.Buttons) then
            return
        end
        local v90 = v_u_5.SelectedObject
        if not v90 then
            return
        end
        local v91 = nil
        for _, v92 in ipairs(v_u_52) do
            local v93 = v_u_24.Buttons:FindFirstChild(v92)
            if v93 and (v93:IsA("GuiButton") and (v90 == v93 or v90:IsDescendantOf(v93))) then
                v91 = v93
                break
            end
        end
        local v94
        if v91 or not v_u_24.Other then
            v94 = v91
        else
            v94 = v_u_24.Other:FindFirstChild("Dashboard")
            if not v94 or (not v94:IsA("GuiButton") or v90 ~= v94 and not v90:IsDescendantOf(v94)) then
                v94 = v91
            end
        end
        if v94 and v_u_20 ~= v94 then
            local v95 = v_u_20
            v_u_20 = v94
            v_u_28(v94, v_u_22)
            if v95 then
                v_u_28(v95, v_u_21)
            end
            v_u_12.broadcastRouter("RunInterfaceSound", "UI Highlight")
        end
    end)
    v_u_14.OnScreenChanged:Connect(function(_, p96)
        if p96 then
            local v97 = v_u_25.Menu:FindFirstChild(p96)
            if v97 and v97:IsA("Frame") then
                v_u_19 = v97
            end
            local v98 = v_u_24.Other:FindFirstChild(p96) or v_u_24.Buttons:FindFirstChild(p96)
            if v98 and (v98:IsA("GuiButton") and v_u_20 ~= v98) then
                local v99 = v_u_20
                v_u_20 = v98
                v_u_28(v98, v_u_22)
                if v99 then
                    v_u_28(v99, v_u_21)
                end
            end
        end
    end)
    v_u_8.CharacterAdded:Connect(function(_)
        task.defer(function()
            if not (v_u_25.Menu.Visible or (v_u_25.Gameplay.Middle.TeamSelection.Visible or (v_u_14.IsCaseSceneActive() or v_u_14.IsInspectActive()))) then
                v_u_9.resetForceLockOverride()
                v_u_9.setPerspective(true, false)
            end
        end)
    end)
    v_u_13.observeAttribute(v_u_8, "Team", function(p100)
        if p100 == "Spectators" then
            v_u_1.CloseTeamSelection()
        end
    end)
    v_u_11.ListenToState(function(p101, p102)
        if v_u_14.IsCaseSceneActive() then
            if p102 == "Game Ending" or p102 == "Map Voting" then
                v_u_25.Gameplay.Bottom.Visible = false
                v_u_25.Gameplay.Visible = false
            end
            return
        elseif v_u_14.IsInspectActive() then
            return
        else
            if p102 == "Game Ending" or p102 == "Map Voting" then
                if require(v_u_2.Controllers.EndScreenController).IsActive() then
                    if v_u_14.IsInspectActive() then
                        v_u_12.broadcastRouter("WeaponInspectCloseForGameEnd")
                    end
                    return
                end
                v_u_25.Gameplay.Visible = false
                v_u_25.Gameplay.Bottom.Visible = false
                if v_u_14.IsInspectActive() then
                    v_u_12.broadcastRouter("WeaponInspectCloseForGameEnd")
                end
                if not v_u_64() then
                    v_u_1.ResetToMainMenu()
                end
                if not v_u_25.Menu.Visible then
                    v_u_9.setForceLockOverride("Menu", true)
                    v_u_25.Menu.Visible = true
                end
            end
            if p102 == "Map Voting" then
                if v_u_8:GetAttribute("FollowGamemode") or v_u_8:GetAttribute("IsSpectating") then
                    v_u_1.openFrame("Play")
                    return
                end
                if not (v_u_25.Menu.Visible or v_u_64()) then
                    v_u_1.openFrame("Dashboard")
                    v_u_1.ToggleMenu()
                end
            end
            if (p101 == "Game Ending" or p101 == "Map Voting") and (p102 ~= "Game Ending" and p102 ~= "Map Voting") then
                if p101 == "Map Voting" then
                    if v_u_25.Menu.Visible then
                        return
                    end
                    local v103 = v_u_8:GetAttribute("Team")
                    if not v_u_8.Character or (not v103 or v103 == "Spectators") then
                        v_u_25.Menu.Visible = false
                        v_u_25.Gameplay.Visible = true
                        v_u_25.Gameplay.Top.Visible = true
                        require(v_u_2.Interface.Screens.Gameplay.Middle.TeamSelection).openFrame()
                        return
                    end
                elseif v_u_25.Menu.Visible and v_u_64() then
                    return
                end
                task.defer(function()
                    if not v_u_14.IsInspectActive() then
                        if require(v_u_2.Controllers.MenuSceneController).IsActive() and not v_u_25.Menu.Visible then
                            if not v_u_64() then
                                v_u_1.ResetToMainMenu()
                            end
                            v_u_9.setForceLockOverride("Menu", true)
                            v_u_25.Gameplay.Visible = false
                            v_u_25.Menu.Visible = true
                        end
                    end
                end)
            end
            if p102 ~= "Game Ending" and (p102 ~= "Map Voting" and (v_u_25.Menu.Visible and v_u_64())) then
            end
        end
    end)
end
return v_u_1