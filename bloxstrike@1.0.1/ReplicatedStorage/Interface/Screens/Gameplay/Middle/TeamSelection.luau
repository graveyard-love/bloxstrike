local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = require(v_u_2.Controllers.EndScreenController)
local v_u_6 = require(v_u_2.Controllers.CameraController)
local v_u_7 = require(v_u_2.Database.Components.GameState)
local v_u_8 = require(v_u_2.Components.Common.GetTimerFormat)
local v_u_9 = require(v_u_2.Components.Common.GetUserPlatform)
local v_u_10 = require(v_u_2.Packages.Observers)
local v_u_11 = require(v_u_2.Database.Security.Remotes)
local v_u_12 = require(v_u_2.Interface.MenuState)
local v_u_13 = v_u_4.LocalPlayer
local v_u_14 = false
local v_u_15 = 0
local v_u_16 = nil
local v_u_17 = nil
local function v_u_22(p18, p19)
    local v20 = 0
    for _, v21 in ipairs(v_u_4:GetPlayers()) do
        if v21 ~= p19 and v21:GetAttribute("Team") == p18 then
            v20 = v20 + 1
        end
    end
    return v20
end
local v_u_23 = ColorSequence.new(Color3.fromRGB(32, 32, 32))
local v_u_24 = {}
local v_u_25 = {}
local function v_u_32()
    local v26 = v_u_22("Counter-Terrorists")
    local v27 = v_u_22("Terrorists")
    for _, v28 in ipairs({ "Counter-Terrorists", "Terrorists" }) do
        local v29 = v_u_16:FindFirstChild(v28)
        if v29 then
            if not v_u_24[v28] then
                v_u_24[v28] = {
                    ["TeamTransparency"] = v29.Team.TextTransparency,
                    ["PlayersTransparency"] = v29.Players.TextTransparency,
                    ["UIGradient"] = v29.UIGradient.Color,
                    ["IconOutline"] = v29.Icon.Outline.ImageTransparency,
                    ["IconTeam"] = v29.Icon.Team.ImageTransparency,
                    ["IconTeamIcon"] = v29.Icon.Team.Icon.ImageTransparency
                }
            end
            local v30
            if v28 == "Counter-Terrorists" and v27 < v26 then
                v30 = true
            elseif v28 == "Terrorists" then
                v30 = v26 < v27
            else
                v30 = false
            end
            v_u_25[v28] = v30
            local v31 = v_u_24[v28]
            v29.Team.TextTransparency = v30 and 0.5 or v31.TeamTransparency
            v29.Players.TextTransparency = v30 and 0.5 or v31.PlayersTransparency
            v29.UIGradient.Color = v30 and v_u_23 or v31.UIGradient
            v29.Icon.Outline.ImageTransparency = v30 and 0.4 or v31.IconOutline
            v29.Icon.Team.ImageTransparency = v30 and 0.4 or v31.IconTeam
            v29.Icon.Team.Icon.ImageTransparency = v30 and 0.4 or v31.IconTeamIcon
        end
    end
end
local function v_u_34(p_u_33)
    p_u_33.MouseEnter:Connect(function()
        v_u_3:Create(p_u_33, TweenInfo.new(0.1), {
            ["BackgroundTransparency"] = 0.85
        }):Play()
    end)
    p_u_33.MouseLeave:Connect(function()
        v_u_3:Create(p_u_33, TweenInfo.new(0.1), {
            ["BackgroundTransparency"] = 1
        }):Play()
    end)
end
function v_u_1.ToggleTeamSelection()
    if v_u_5.IsActive() then
        return
    elseif v_u_16.Visible then
        v_u_1.closeFrame()
    else
        v_u_1.openFrame()
    end
end
function v_u_1.openFrame()
    if v_u_5.IsActive() then
        return
    elseif v_u_12.IsCaseSceneActive() or v_u_12.IsInspectActive() then
        return
    elseif not v_u_16.Visible then
        local v35 = v_u_17.Menu.Visible and v_u_12.GetCurrentScreen()
        if v35 and (v35 == "Loadout" or (v35 == "Inventory" or (v35 == "Modes" or v35 == "Settings")) or v35 == "Store") then
            local v36 = v_u_17.Menu:FindFirstChild(v35)
            if v36 and v36.Visible then
                return
            end
        end
        local v37 = require(v_u_2.Controllers.MenuSceneController)
        if v37.IsActive() then
            v37.HideMenuScene(true, false)
        end
        if v_u_17.Menu.Visible then
            v_u_6.setForceLockOverride("Menu", false)
            v_u_12.SetBlurEnabled(false)
        end
        local v38 = v_u_17.Gameplay.Middle:FindFirstChild("BuyMenu")
        v_u_14 = v38 and v38.Visible or false
        if v_u_14 then
            require(v_u_2.Interface.Screens.Gameplay.Middle.BuyMenu).closeFrame()
        end
        v_u_6.setForceLockOverride("TeamSelection", true)
        if not v_u_13:GetAttribute("IsSpectating") then
            v_u_6.setPerspective(true, true)
        end
        v_u_17.Gameplay.Bottom.Visible = false
        v_u_17.Gameplay.Top.Visible = true
        v_u_17.Gameplay.Visible = true
        v_u_17.Menu.Visible = false
        for _, v39 in ipairs(v_u_17.Gameplay.Middle:GetChildren()) do
            local v40 = table.find(v_u_9(), "Mobile")
            if v39.Name == "Chat" then
                v39.Visible = not v40
            elseif v39.Name == "MobileButtons" then
                local v41 = v_u_13.Character
                if v41 and v41:IsDescendantOf(workspace) then
                    v39.Visible = v40
                else
                    v39.Visible = false
                end
            else
                v39.Visible = v39.Name == "Notification" and true or v39.Name == "TeamSelection"
            end
        end
        v_u_32()
    end
end
function v_u_1.closeFrame()
    v_u_6.setForceLockOverride("TeamSelection", false)
    if v_u_13.Character then
        v_u_6.setForceLockOverride("Menu", false)
    end
    if not v_u_13:GetAttribute("IsSpectating") then
        v_u_6.setPerspective(true, false)
    end
    v_u_16.Visible = false
    v_u_17.Gameplay.Middle.Crosshair.Visible = true
    v_u_17.Gameplay.Top.Visible = true
    v_u_17.Gameplay.Bottom.Visible = true
    local v42 = table.find(v_u_9(), "Mobile")
    local v43 = v_u_13.Character
    local v44 = v_u_13:GetAttribute("IsSpectating") == true
    for _, v45 in ipairs(v_u_17.Gameplay.Middle:GetChildren()) do
        local v46
        if v43 then
            v46 = v43:IsDescendantOf(workspace)
        else
            v46 = v43
        end
        local v47 = v45.Name
        if v47 == "Chat" then
            v45.Visible = not v42
        elseif v47 == "MobileButtons" then
            local v48
            if v42 then
                v48 = v46 or (v44 or false)
            else
                v48 = false
            end
            v45.Visible = v48
        elseif v47 == "Votekick" then
            v45.Visible = v45:GetAttribute("IsVoteKickActive") == true
        elseif v47 == "Notification" then
            v45.Visible = true
        elseif v47 == "SessionStats" then
            v45.Visible = not v42
        elseif v47 == "Radar" or v47 == "Crosshair" then
            v45.Visible = v46
        else
            v45.Visible = false
        end
    end
    if v_u_14 then
        local v49 = require(v_u_2.Interface.Screens.Gameplay.Middle.BuyMenu)
        v_u_14 = false
        v49.openFrame()
    end
end
function v_u_1.chooseTeam(p50)
    if v_u_13:GetAttribute("Team") == p50 then
        v_u_1.closeFrame()
        return
    end
    local v51 = v_u_13
    local v52 = v_u_22("Counter-Terrorists", v51)
    local v53 = v_u_22("Terrorists", v51)
    local v54
    if p50 == "Terrorists" then
        if v53 >= v52 then
            ::l6::
            v54 = p50 == "Spectators" and true or v52 == v53
            goto l8
        end
        v54 = true
    else
        if p50 ~= "Counter-Terrorists" or v52 >= v53 then
            goto l6
        end
        v54 = true
    end
    ::l8::
    if v54 and tick() - v_u_15 >= 1 then
        v_u_11.TeamSelection.SelectTeam.Send(p50)
        v_u_15 = tick()
    end
end
function v_u_1.createTeamButtonAnimation(p55, p_u_56)
    local v_u_57 = v_u_16:FindFirstChild(p_u_56)
    if v_u_57 then
        p55.MouseEnter:Connect(function()
            if not v_u_25[p_u_56] then
                local v58 = v_u_57.Icon.Outline
                local v59 = p_u_56 == "Counter-Terrorists" and Color3.fromRGB(165, 183, 212)
                if not v59 then
                    if p_u_56 == "Terrorists" then
                        v59 = Color3.fromRGB(219, 199, 126)
                    else
                        v59 = false
                    end
                end
                v58.ImageColor3 = v59
                local v60 = v_u_57.Icon.Team.Icon
                local v61 = p_u_56 == "Counter-Terrorists" and Color3.fromRGB(255, 255, 255)
                if not v61 then
                    if p_u_56 == "Terrorists" then
                        v61 = Color3.fromRGB(255, 255, 255)
                    else
                        v61 = false
                    end
                end
                v60.ImageColor3 = v61
                local v62 = v_u_57.Icon.Team
                local v63 = p_u_56 == "Counter-Terrorists" and Color3.fromRGB(36, 41, 47)
                if not v63 then
                    if p_u_56 == "Terrorists" then
                        v63 = Color3.fromRGB(89, 79, 50)
                    else
                        v63 = false
                    end
                end
                v62.ImageColor3 = v63
                v_u_57.UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.14375), NumberSequenceKeypoint.new(0.318, 1), NumberSequenceKeypoint.new(1, 1) })
                for _, v64 in ipairs(v_u_57.Container:GetChildren()) do
                    if v64:IsA("Frame") then
                        local v65 = p_u_56 == "Counter-Terrorists" and Color3.fromRGB(126, 140, 187)
                        if not v65 then
                            if p_u_56 == "Terrorists" then
                                v65 = Color3.fromRGB(219, 188, 110)
                            else
                                v65 = false
                            end
                        end
                        v64.BackgroundColor3 = v65
                        local v66 = v64.Player.UIStroke
                        local v67 = p_u_56 == "Counter-Terrorists" and Color3.fromRGB(165, 183, 212)
                        if not v67 then
                            if p_u_56 == "Terrorists" then
                                v67 = Color3.fromRGB(219, 199, 126)
                            else
                                v67 = false
                            end
                        end
                        v66.Color = v67
                        v64.Player.Avatar.ImageColor3 = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
        end)
        p55.MouseLeave:Connect(function()
            if not v_u_25[p_u_56] then
                local v68 = v_u_57.Icon.Outline
                local v69 = p_u_56 == "Counter-Terrorists" and Color3.fromRGB(107, 119, 138)
                if not v69 then
                    if p_u_56 == "Terrorists" then
                        v69 = Color3.fromRGB(127, 115, 73)
                    else
                        v69 = false
                    end
                end
                v68.ImageColor3 = v69
                local v70 = v_u_57.Icon.Team.Icon
                local v71 = p_u_56 == "Counter-Terrorists" and Color3.fromRGB(131, 131, 131)
                if not v71 then
                    if p_u_56 == "Terrorists" then
                        v71 = Color3.fromRGB(182, 182, 182)
                    else
                        v71 = false
                    end
                end
                v70.ImageColor3 = v71
                local v72 = v_u_57.Icon.Team
                local v73 = p_u_56 == "Counter-Terrorists" and Color3.fromRGB(20, 24, 27)
                if not v73 then
                    if p_u_56 == "Terrorists" then
                        v73 = Color3.fromRGB(58, 51, 33)
                    else
                        v73 = false
                    end
                end
                v72.ImageColor3 = v73
                v_u_57.UIGradient.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.14375), NumberSequenceKeypoint.new(0.183193, 1), NumberSequenceKeypoint.new(1, 1) })
                for _, v74 in ipairs(v_u_57.Container:GetChildren()) do
                    if v74:IsA("Frame") then
                        local v75 = p_u_56 == "Counter-Terrorists" and Color3.fromRGB(109, 121, 140)
                        if not v75 then
                            if p_u_56 == "Terrorists" then
                                v75 = Color3.fromRGB(131, 111, 66)
                            else
                                v75 = false
                            end
                        end
                        v74.BackgroundColor3 = v75
                        local v76 = v74.Player.UIStroke
                        local v77 = p_u_56 == "Counter-Terrorists" and Color3.fromRGB(50, 56, 65)
                        if not v77 then
                            if p_u_56 == "Terrorists" then
                                v77 = Color3.fromRGB(94, 85, 54)
                            else
                                v77 = false
                            end
                        end
                        v76.Color = v77
                        v74.Player.Avatar.ImageColor3 = Color3.fromRGB(138, 138, 138)
                    end
                end
            end
        end)
    end
end
function v_u_1.updatePlayerList(p_u_78, p79)
    local v80 = p_u_78:GetAttribute("Team")
    if v80 == "Counter-Terrorists" or v80 == "Terrorists" then
        local v81 = v_u_16
        local v82 = p_u_78.UserId
        local v83 = v81:FindFirstChild(tostring(v82), true)
        if v83 then
            v83:Destroy()
        end
        local v84 = v_u_2.Assets.UI.TeamSelection:FindFirstChild(v80)
        if v84 and not p79 then
            local v85 = v_u_16:WaitForChild(v80)
            local _, v86 = pcall(function()
                return v_u_4:GetUserThumbnailAsync(p_u_78.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
            end)
            local v87 = v84:Clone()
            v87.Parent = v85.Container
            v87.Team.Text = p_u_78.DisplayName
            v87.Player.Avatar.Image = v86
            local v88 = p_u_78.UserId
            v87.Name = tostring(v88)
            v87.Visible = true
        end
    else
        local v89 = v_u_16
        local v90 = p_u_78.UserId
        local v91 = v89:FindFirstChild(tostring(v90), true)
        if v91 then
            v91:Destroy()
        end
    end
    v_u_16["Counter-Terrorists"].Players.Text = ("%* Player(s)"):format((v_u_22("Counter-Terrorists")))
    v_u_16.Terrorists.Players.Text = ("%* Player(s)"):format((v_u_22("Terrorists")))
    v_u_32()
end
function v_u_1.Initialize(p92, p93)
    v_u_16 = p93
    v_u_17 = p92
    v_u_10.observePlayer(function(p_u_94)
        v_u_1.updatePlayerList(p_u_94)
        local v_u_98 = v_u_10.observeAttribute(p_u_94, "Team", function(_)
            v_u_1.updatePlayerList(p_u_94)
            if v_u_13 == p_u_94 then
                v_u_1.closeFrame()
            end
            return function()
                local v95 = v_u_16
                local v96 = p_u_94.UserId
                local v97 = v95:FindFirstChild(tostring(v96), true)
                if v97 then
                    v97:Destroy()
                end
            end
        end)
        return function()
            v_u_1.updatePlayerList(p_u_94, true)
            v_u_98()
        end
    end)
    v_u_10.observeAttribute(v_u_13, "Team", function(_)
        if v_u_7.GetState() == "Round In Progress" then
            v_u_1.closeFrame()
        end
    end)
    v_u_10.observeAttribute(workspace, "Timer", function(p99)
        v_u_16.ProgressBar.Timer.Text = v_u_8(p99)
    end)
    v_u_13.CharacterAdded:Connect(function()
        if v_u_16.Visible then
            v_u_1.closeFrame()
        end
    end)
end
function v_u_1.Start()
    local v100 = v_u_16["Counter-Terrorists"].Button
    local v_u_101 = "Counter-Terrorists"
    v100.MouseButton1Click:Connect(function()
        v_u_1.chooseTeam(v_u_101)
    end)
    v_u_1.createTeamButtonAnimation(v100, "Counter-Terrorists")
    local v102 = v_u_16.Bottom.Buttons.Spectate
    local v_u_103 = "Spectators"
    v102.MouseButton1Click:Connect(function()
        v_u_1.chooseTeam(v_u_103)
    end)
    v_u_34(v102)
    local v104 = v_u_16.Terrorists.Button
    local v_u_105 = "Terrorists"
    v104.MouseButton1Click:Connect(function()
        v_u_1.chooseTeam(v_u_105)
    end)
    v_u_1.createTeamButtonAnimation(v104, "Terrorists")
    v_u_34(v_u_16.Bottom.Buttons.AutoSelect)
    v_u_16.Bottom.Buttons.AutoSelect.MouseButton1Click:Connect(function()
        local v106 = v_u_1.chooseTeam
        local v107 = v_u_13
        local v108 = v_u_22("Counter-Terrorists", v107)
        local v109 = v_u_22("Terrorists", v107)
        local v110
        if v108 == v109 then
            local v111 = v107:GetAttribute("Team")
            v110 = v111 == "Counter-Terrorists" and "Terrorists" or (v111 == "Terrorists" and "Counter-Terrorists" or "Terrorists")
        else
            v110 = v108 < v109 and "Counter-Terrorists" or "Terrorists"
        end
        v106(v110)
    end)
    v_u_34(v_u_16.Bottom.Buttons.BackHome)
    v_u_16.Bottom.Buttons.BackHome.MouseButton1Click:Connect(function()
        if v_u_13:GetAttribute("IsSpectating") ~= true then
            local v112 = v_u_13.Character
            local v113
            if v112 and v112:IsDescendantOf(workspace) then
                local v114 = v112:FindFirstChild("Humanoid")
                if v114 == nil then
                    v113 = false
                else
                    v113 = v114.Health > 0
                end
            else
                v113 = false
            end
            if not v113 then
                v_u_1.closeFrame()
                local v115 = require(v_u_2.Interface.Screens.Menu.Top)
                local v116 = require(v_u_2.Controllers.MenuSceneController)
                v_u_6.setForceLockOverride("Menu", true)
                v_u_6.setPerspective(true, true)
                v_u_17.Gameplay.Visible = false
                v_u_17.Gameplay.Bottom.Visible = false
                v_u_17.Menu.Visible = true
                v115.ResetToMainMenu()
                v116.ShowMenuScene()
                return
            end
        end
        v_u_1.closeFrame()
    end)
end
return v_u_1