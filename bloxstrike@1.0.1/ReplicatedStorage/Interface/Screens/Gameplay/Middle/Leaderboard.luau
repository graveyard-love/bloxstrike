local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
local v_u_5 = game:GetService("HttpService")
local v_u_6 = game:GetService("UserInputService")
require(script:WaitForChild("Types"))
local v_u_7 = v_u_4.LocalPlayer
local v_u_8 = require(v_u_2.Database.Components.Common.RemoveFromArray)
local v_u_9 = require(v_u_2.Components.Common.GetBadgeIcon)
local v_u_10 = require(v_u_2.Controllers.EndScreenController)
local v_u_11 = require(v_u_2.Controllers.DataController)
local v_u_12 = require(v_u_2.Controllers.CameraController)
local v_u_13 = require(v_u_2.Packages.Observers)
local v_u_14 = require(v_u_2.Shared.Janitor)
local v_u_15 = require(v_u_2.Components.Common.GetTimerFormat)
local v_u_16 = UDim2.fromScale(0.582, 0.782)
local v_u_17 = UDim2.fromScale(0.582, 0.355)
local v_u_18 = UDim2.fromScale(0.282, 0.85)
local v_u_19 = UDim2.fromScale(0.82, 0.9)
local v_u_20 = UDim2.fromScale(0.758, 0.9)
local v_u_21 = UDim2.fromScale(0.638, 0.9)
local v_u_22 = UDim2.fromScale(0.937, 0.9)
local v_u_23 = UDim2.fromScale(0.702, 0.9)
local v_u_24 = UDim2.fromScale(0.882, 0.9)
local v_u_25 = UDim2.fromScale(0.762, 0.365)
local v_u_26 = UDim2.fromScale(0.503, 0.785)
local v_u_27 = UDim2.fromScale(0.503, 0.364)
local v_u_28 = UDim2.fromScale(0.135, 0.85)
local v_u_29 = UDim2.fromScale(0.79, 0.9)
local v_u_30 = UDim2.fromScale(0.715, 0.9)
local v_u_31 = UDim2.fromScale(0.57, 0.9)
local v_u_32 = UDim2.fromScale(0.932, 0.9)
local v_u_33 = UDim2.fromScale(0.648, 0.9)
local v_u_34 = UDim2.fromScale(0.866, 0.9)
local v_u_35 = UDim2.fromScale(0.921, 0.365)
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = {}
local function v_u_42(p39)
    local v40 = p39:GetChildren()
    for _, v41 in ipairs(v40) do
        if v41.ClassName == "Frame" then
            v41:Destroy()
        end
    end
end
local function v_u_46(p43)
    local v44 = {}
    for _, v45 in ipairs(v_u_4:GetPlayers()) do
        if v45:GetAttribute("Team") == p43 then
            table.insert(v44, v45)
        end
    end
    return v44
end
local function v_u_49()
    local v47 = workspace:GetAttribute("Gamemode")
    v_u_36.Team.CT.Score.Visible = v47 ~= "Deathmatch"
    v_u_36.Team.T.Score.Visible = v47 ~= "Deathmatch"
    local v48 = workspace:GetAttribute("Map")
    v_u_36.TopInfo.Gamemode.Text = ("%* | %*"):format(v47, v48)
    if v47 == "Deathmatch" then
        v_u_36["Counter-Terrorists"].Position = v_u_26
        v_u_36.Terrorists.Position = v_u_27
        v_u_36.TopInfo.Assists.Position = v_u_29
        v_u_36.TopInfo.Deaths.Position = v_u_30
        v_u_36.TopInfo.Money.Position = v_u_31
        v_u_36.TopInfo.Score.Position = v_u_32
        v_u_36.TopInfo.Kills.Position = v_u_33
        v_u_36.TopInfo.MVPs.Position = v_u_34
        v_u_36.TopInfo.Ping.Position = v_u_28
        v_u_36["Counter-Terrorists"].Size = v_u_35
        v_u_36.Terrorists.Size = v_u_35
        v_u_36.DeathmatchDivider.Visible = true
        v_u_36.Team.Visible = false
    elseif v47 == "Bomb Defusal" or v47 == "Hostage Rescue" then
        v_u_36["Counter-Terrorists"].Position = v_u_16
        v_u_36.Terrorists.Position = v_u_17
        v_u_36.TopInfo.Assists.Position = v_u_19
        v_u_36.TopInfo.Deaths.Position = v_u_20
        v_u_36.TopInfo.Score.Position = v_u_22
        v_u_36.TopInfo.Kills.Position = v_u_23
        v_u_36.TopInfo.Money.Position = v_u_21
        v_u_36.TopInfo.MVPs.Position = v_u_24
        v_u_36.TopInfo.Ping.Position = v_u_18
        v_u_36["Counter-Terrorists"].Size = v_u_25
        v_u_36.Terrorists.Size = v_u_25
        v_u_36.DeathmatchDivider.Visible = false
        v_u_36.Team.Visible = true
    end
end
function v_u_1.createTemplate(p_u_50, p_u_51, p_u_52)
    local v_u_53 = v_u_2.Assets.UI.Leaderboard[p_u_51]:Clone()
    v_u_53.Player.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(p_u_50.UserId)
    v_u_53.PlayerName.Text = ("%* (@%*)"):format(p_u_50.DisplayName, p_u_50.Name)
    local v54 = v_u_9(p_u_50, p_u_51)
    v_u_53.Badge.Visible = v54 ~= ""
    v_u_53.Badge.Image = v54
    v_u_53.LayoutOrder = 0
    v_u_53.Assists.Amount.Text = "0"
    v_u_53.Deaths.Amount.Text = "0"
    v_u_53.Score.Amount.Text = "0"
    v_u_53.Kills.Amount.Text = "0"
    v_u_53.MVPs.Amount.Text = "0"
    v_u_53.Money.Amount.Text = ""
    v_u_53.LayoutOrder = 1
    v_u_53.Ping.Text = "0"
    local v_u_55 = {}
    local function v_u_58(p56)
        if p56:IsA("Frame") then
            v_u_55[p56] = {
                ["BackgroundTransparency"] = p56.BackgroundTransparency
            }
        elseif p56:IsA("TextLabel") then
            v_u_55[p56] = {
                ["BackgroundTransparency"] = p56.BackgroundTransparency,
                ["TextTransparency"] = p56.TextTransparency
            }
        elseif p56:IsA("TextButton") then
            v_u_55[p56] = {
                ["BackgroundTransparency"] = p56.BackgroundTransparency,
                ["TextTransparency"] = p56.TextTransparency
            }
        elseif p56:IsA("ImageLabel") then
            v_u_55[p56] = {
                ["BackgroundTransparency"] = p56.BackgroundTransparency,
                ["ImageTransparency"] = p56.ImageTransparency
            }
        elseif p56:IsA("ImageButton") then
            v_u_55[p56] = {
                ["BackgroundTransparency"] = p56.BackgroundTransparency,
                ["ImageTransparency"] = p56.ImageTransparency
            }
        end
        for _, v57 in ipairs(p56:GetChildren()) do
            v_u_58(v57)
        end
    end
    v_u_55[v_u_53] = {
        ["BackgroundTransparency"] = v_u_53.BackgroundTransparency
    }
    for _, v59 in ipairs(v_u_53:GetChildren()) do
        v_u_58(v59)
    end
    if p_u_50 == v_u_7 then
        v_u_53.BackgroundColor3 = Color3.fromRGB(139, 128, 98)
    end
    local function v_u_62()
        local v60 = workspace:GetAttribute("Gamemode")
        if p_u_50:GetAttribute("Team") == v_u_7:GetAttribute("Team") or v60 == "Deathmatch" then
            local v61 = p_u_50:GetAttribute("Money")
            v_u_53.Money.Amount.Text = v61 == nil and "" or (("$%*"):format((tostring(v61):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))) or "")
        else
            v_u_53.Money.Amount.Text = ""
        end
    end
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "Money", function(_)
        v_u_62()
    end))
    p_u_52:Add(v_u_13.observeAttribute(v_u_7, "Team", v_u_62))
    v_u_62()
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "Kills", function(p63)
        v_u_53.Kills.Amount.Text = tostring(p63):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        v_u_53.LayoutOrder = -p63
    end))
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "Deaths", function(p64)
        v_u_53.Deaths.Amount.Text = tostring(p64):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end))
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "Assists", function(p65)
        v_u_53.Assists.Amount.Text = tostring(p65):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end))
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "Score", function(p66)
        v_u_53.Score.Amount.Text = tostring(p66):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end))
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "MVPs", function(p67)
        v_u_53.MVPs.Amount.Text = tostring(p67):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end))
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "Ping", function(p68)
        v_u_53.Ping.Text = p68
    end))
    local function v_u_82()
        local v69 = p_u_50.Character
        if v69 then
            v69 = v69:GetAttribute("Dead") == true
        end
        local v70 = p_u_50:GetAttribute("IsSpectating") == true
        local v71 = v69 == true and true or v70 == true
        if v_u_53 and v_u_53:FindFirstChild("Dead") then
            v_u_53.Dead.Visible = v71
        end
        if v71 then
            if v_u_53:FindFirstChild("Bomb") then
                v_u_53.Bomb.Visible = false
            end
            if v_u_53:FindFirstChild("DefuseKit") then
                v_u_53.DefuseKit.Visible = false
            end
        end
        if v71 then
            v_u_53.BackgroundTransparency = 1
            local function v_u_74(p72)
                if p72:IsA("Frame") then
                    p72.BackgroundTransparency = 1
                elseif p72:IsA("TextLabel") then
                    p72.TextTransparency = 0.5
                    p72.BackgroundTransparency = 1
                elseif p72:IsA("TextButton") then
                    p72.TextTransparency = 0.5
                    p72.BackgroundTransparency = 1
                elseif p72:IsA("ImageLabel") then
                    p72.ImageTransparency = 0.5
                    p72.BackgroundTransparency = 1
                elseif p72:IsA("ImageButton") then
                    p72.ImageTransparency = 0.5
                    p72.BackgroundTransparency = 1
                end
                for _, v73 in ipairs(p72:GetChildren()) do
                    v_u_74(v73)
                end
            end
            for _, v75 in ipairs(v_u_53:GetChildren()) do
                v_u_74(v75)
            end
        else
            local function v_u_79(p76)
                local v77 = v_u_55[p76]
                if v77 then
                    if p76:IsA("Frame") then
                        p76.BackgroundTransparency = v77.BackgroundTransparency
                    elseif p76:IsA("TextLabel") then
                        p76.TextTransparency = v77.TextTransparency
                        p76.BackgroundTransparency = v77.BackgroundTransparency
                    elseif p76:IsA("TextButton") then
                        p76.TextTransparency = v77.TextTransparency
                        p76.BackgroundTransparency = v77.BackgroundTransparency
                    elseif p76:IsA("ImageLabel") then
                        p76.ImageTransparency = v77.ImageTransparency
                        p76.BackgroundTransparency = v77.BackgroundTransparency
                    elseif p76:IsA("ImageButton") then
                        p76.ImageTransparency = v77.ImageTransparency
                        p76.BackgroundTransparency = v77.BackgroundTransparency
                    end
                end
                for _, v78 in ipairs(p76:GetChildren()) do
                    v_u_79(v78)
                end
            end
            local v80 = v_u_55[v_u_53]
            if v80 then
                v_u_53.BackgroundTransparency = v80.BackgroundTransparency
            end
            for _, v81 in ipairs(v_u_53:GetChildren()) do
                v_u_79(v81)
            end
        end
    end
    local v_u_83 = nil
    local function v_u_85()
        local v84 = p_u_50.Character
        if v84 then
            v_u_82()
            return v84:GetAttributeChangedSignal("Dead"):Connect(function()
                v_u_82()
                if v_u_83 then
                    v_u_83()
                end
            end)
        else
            v_u_82()
            return nil
        end
    end
    p_u_52:Add(v_u_13.observeAttribute(p_u_50, "IsSpectating", function(_)
        v_u_82()
    end))
    local v87 = p_u_50.CharacterAdded:Connect(function(_)
        task.wait(0.1)
        local v86 = v_u_85()
        if v86 then
            p_u_52:Add(v86)
        end
        if v_u_83 then
            v_u_83()
        end
    end)
    local v88 = p_u_50.CharacterRemoving:Connect(function(_)
        v_u_82()
    end)
    p_u_52:Add(v87)
    p_u_52:Add(v88)
    if p_u_50.Character then
        local v89 = v_u_85()
        if v89 then
            p_u_52:Add(v89)
        end
    else
        v_u_82()
    end
    local v_u_91 = v_u_11.CreateListener(p_u_50, ("Loadout.%*.Equipped.Equipped Badge"):format(p_u_51), function()
        local v90 = v_u_9(p_u_50, p_u_51)
        v_u_53.Badge.Image = v90
        v_u_53.Badge.Visible = v90 ~= ""
    end)
    p_u_52:Add(function()
        v_u_11.RemoveListener(p_u_50, ("Loadout.%*.Equipped.Equipped Badge"):format(p_u_51), v_u_91)
    end)
    v_u_83 = function()
        local v92 = p_u_50:GetAttribute("Team") == v_u_7:GetAttribute("Team")
        local v93 = p_u_50.Character
        if v93 then
            v93 = v93:GetAttribute("Dead") == true
        end
        local v94 = p_u_50:GetAttribute("IsSpectating") == true
        local v95 = not v93
        if v95 then
            v95 = not v94
        end
        if p_u_51 == "Terrorists" then
            local v96 = v_u_53:FindFirstChild("Bomb")
            if v96 then
                local v97 = p_u_50:GetAttribute("Slot5")
                if v97 then
                    local v98 = v_u_5:JSONDecode(v97 or "[]")
                    if v92 then
                        if v95 then
                            if v98 then
                                v98 = v98.Weapon == "C4"
                            end
                        else
                            v98 = v95
                        end
                    else
                        v98 = v92
                    end
                    v96.Visible = v98
                else
                    v96.Visible = false
                end
            end
        else
            local v99 = p_u_51 == "Counter-Terrorists" and v_u_53:FindFirstChild("DefuseKit")
            if v99 then
                local v100 = p_u_50:GetAttribute("HasDefuseKit")
                if v92 then
                    if v95 then
                        v95 = v100 == true
                    end
                else
                    v95 = v92
                end
                v99.Visible = v95
            end
        end
    end
    if p_u_51 == "Terrorists" then
        p_u_52:Add(v_u_13.observeAttribute(p_u_50, "Slot5", function(_)
            v_u_83()
            return function()
                if v_u_53 and v_u_53:FindFirstChild("Bomb") then
                    v_u_53.Bomb.Visible = false
                end
            end
        end))
    elseif p_u_51 == "Counter-Terrorists" then
        p_u_52:Add(v_u_13.observeAttribute(p_u_50, "HasDefuseKit", function(_)
            v_u_83()
            return function()
                if v_u_53 and v_u_53:FindFirstChild("DefuseKit") then
                    v_u_53.DefuseKit.Visible = false
                end
            end
        end))
    end
    p_u_52:Add(v_u_13.observeAttribute(v_u_7, "Team", function()
        v_u_83()
    end))
    v_u_83()
    return v_u_53
end
function v_u_1.openFrame()
    if not v_u_10.IsActive() then
        v_u_36.Visible = true
    end
end
function v_u_1.closeFrame()
    v_u_36.Visible = false
    v_u_12.setForceLockOverride("Leaderboard", false)
end
function v_u_1.characterAdded(p101, p102)
    local v103 = v_u_14.new()
    v_u_1.cleanup(p101)
    local v_u_104 = v_u_1.createTemplate(p101, p102, v103)
    v_u_104.Parent = v_u_36:FindFirstChild(p102)
    v103:Add(function()
        v_u_104:Destroy()
    end)
    v_u_38[p101] = v103
end
function v_u_1.observePlayer(p_u_105)
    v_u_13.observeAttribute(p_u_105, "Team", function(p106)
        if p106 == "Terrorists" or p106 == "Counter-Terrorists" then
            v_u_1.characterAdded(p_u_105, p106)
        end
        return function()
            v_u_1.cleanup(p_u_105)
        end
    end)
end
function v_u_1.cleanup(p107)
    local v108 = v_u_38[p107]
    v_u_38[p107] = nil
    if v108 then
        v108:Destroy()
    end
end
function v_u_1.Initialize(_, p109)
    v_u_36 = p109
    if v_u_37 then
        v_u_37:Disconnect()
        v_u_37 = nil
    end
    v_u_37 = v_u_6.InputBegan:Connect(function(p110)
        if p110.UserInputType == Enum.UserInputType.MouseButton2 and (v_u_36 and v_u_36.Visible) then
            v_u_12.setForceLockOverride("Leaderboard", true)
        end
    end)
    v_u_13.observeAttribute(workspace, "Gamemode", v_u_49)
    v_u_13.observeAttribute(workspace, "Map", v_u_49)
    v_u_13.observeAttribute(workspace, "CTScore", function(p111)
        v_u_36.Team.CT.Score.Text = tostring(p111)
        return function()
            v_u_36.Team.CT.Score.Text = ""
        end
    end)
    v_u_13.observeAttribute(workspace, "TScore", function(p112)
        v_u_36.Team.T.Score.Text = tostring(p112)
        return function()
            v_u_36.Team.T.Score.Text = ""
        end
    end)
    v_u_13.observeAttribute(workspace, "Timer", function(p113)
        v_u_36.TopInfo.Timer.Text = v_u_15(p113)
    end)
    v_u_13.observePlayer(function(p_u_114)
        v_u_1.observePlayer(p_u_114)
        return function()
            v_u_1.cleanup(p_u_114)
        end
    end)
end
function v_u_1.Start()
    v_u_42((v_u_36:WaitForChild("Counter-Terrorists")))
    v_u_42((v_u_36:WaitForChild("Terrorists")))
    v_u_3.Heartbeat:Connect(function()
        local v115 = workspace:GetAttribute("Gamemode")
        if v115 == "Bomb Defusal" or v115 == "Hostage Rescue" then
            local v116 = v_u_46("Counter-Terrorists")
            local v117 = v_u_46("Terrorists")
            local v118 = #v116
            local v119 = #v117
            local v123 = v_u_8(v116, function(_, p120)
                local v121 = p120.Character
                if v121 and v121:IsDescendantOf(workspace) then
                    local v122 = v121:FindFirstChildOfClass("Humanoid")
                    if v122 and v122.Health > 0 then
                        return false
                    end
                end
                return true
            end)
            local v127 = v_u_8(v117, function(_, p124)
                local v125 = p124.Character
                if v125 and v125:IsDescendantOf(workspace) then
                    local v126 = v125:FindFirstChildOfClass("Humanoid")
                    if v126 and v126.Health > 0 then
                        return false
                    end
                end
                return true
            end)
            local v128 = v_u_36.Team.CT.Alive
            local v129 = #v123
            v128.Text = ("ALIVE %*/%*"):format(tostring(v129), (tostring(v118)))
            local v130 = v_u_36.Team.T.Alive
            local v131 = #v127
            v130.Text = ("ALIVE %*/%*"):format(tostring(v131), (tostring(v119)))
        end
    end)
end
return v_u_1