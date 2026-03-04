local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("PolicyService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("RunService")
local v6 = game:GetService("Players")
require(v_u_2.Database.Custom.Types)
local v_u_7 = require(v_u_2.Controllers.DataController)
local v_u_8 = require(v_u_2.Components.Common.InterfaceAnimations.ActivateButton)
local v_u_9 = require(v_u_2.Database.Security.Remotes)
local v_u_10 = require(v_u_2.Database.Security.Router)
local v_u_11 = require(v_u_2.Database.Custom.GameStats.Missions)
local v12 = require(v_u_2.Database.Custom.Constants)
local v_u_13 = v6.LocalPlayer
local v_u_14 = { "News", "RedeemCode", "Verify" }
local v_u_15 = { "MedalEvent", "EditMobile" }
local v_u_16 = {
    ["isLinked"] = false,
    ["hasClipped"] = false
}
local v_u_17 = {}
local v_u_18 = 0
local v_u_19 = nil
local v_u_20 = false
local v_u_21 = require(script.Parent:WaitForChild("EditMobile"))
local v_u_22 = v12.EVENT_END_TIMES["MEDAL.TV"]
local v_u_23 = v12.ACTIVE_EVENTS["MEDAL.TV"]
local v_u_24 = nil
local function v_u_29(p25, p26)
    local v27 = p25:GetChildren()
    for _, v28 in ipairs(v27) do
        if v28:IsA("Frame") and not table.find(p26, v28.ClassName) then
            v28:Destroy()
        end
    end
end
local function v_u_36(p30)
    if not p30 then
        return nil
    end
    local v31 = v_u_7.Get(v_u_13, "Missions")
    if not v31 then
        return nil
    end
    local v32 = os.time() * 1000
    local v33 = nil
    for _, v34 in ipairs(v31) do
        local v35 = v_u_11.GetMissionDefinition(v34.MissionId)
        if v35 and (v35.Type == p30 and (v34.ExpiresAt > 0 and (v32 < v34.ExpiresAt and (not v33 or v34.ExpiresAt < v33)))) then
            v33 = v34.ExpiresAt
        end
    end
    return v33
end
local function v_u_45(p37, p38, p39)
    local v40 = p37:FindFirstChild("Bar")
    local v41 = v40 and v40:FindFirstChild("Frame")
    if v41 then
        local v42 = UDim2.fromScale(p38 and 1 or 0, 1)
        if p39 and p38 then
            v41.Size = UDim2.fromScale(0, 1)
            v_u_4:Create(v41, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = v42
            }):Play()
        else
            v41.Size = v42
        end
    end
    local v43 = p37:FindFirstChild("Button")
    if v43 then
        local v44 = v43:FindFirstChild("Title")
        if v44 then
            v44.Text = p38 and "COMPLETED" or "REFRESH"
        end
        v43.Active = not p38
    end
end
local function v_u_56(p46, p47, p48, p49, p50)
    local v51 = v_u_24.Holder.MedalEvent.Container.Frame.Rewards.Item.Frame.Progress.Content
    local v52 = v51:FindFirstChild("1")
    local v53 = v51:FindFirstChild("2")
    if v52 then
        local v54 = p46 and 0 or 0.75
        if p48 and p49 then
            v_u_4:Create(v52, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["BackgroundTransparency"] = v54
            }):Play()
        else
            v52.BackgroundTransparency = v54
        end
    end
    if v53 then
        local v55 = p47 and 0 or 0.75
        if p48 and p50 then
            v_u_4:Create(v53, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["BackgroundTransparency"] = v55
            }):Play()
            return
        end
        v53.BackgroundTransparency = v55
    end
end
local function v_u_76(p57)
    local v58 = v_u_24.Holder.MedalEvent.Container.Frame.ScrollingFrame
    local v59 = v_u_2.Assets.UI.MedalAssets
    local v60 = v_u_7.Get(v_u_13, "HasClaimedExclusiveMedalReward") == true
    local v_u_61 = v60 or v_u_13:GetAttribute("RobloxAccountLinkedToMedal") == true
    local v_u_62 = v60 or v_u_13:GetAttribute("HasClippedBloxStrike") == true
    local v63 = v_u_61 ~= v_u_16.isLinked
    local v64 = v_u_62 ~= v_u_16.hasClipped
    v_u_16.isLinked = v_u_61
    v_u_16.hasClipped = v_u_62
    v_u_56(v_u_61, v_u_62, p57, v63, v64)
    for _, v65 in ipairs(v58:GetChildren()) do
        if v65:IsA("Frame") then
            v65:Destroy()
        end
    end
    v_u_17 = {}
    local v66 = v59.Unlocked:Clone()
    v66.TextLabel.Text = "Link your Roblox account to your Medal account"
    v66.Name = "LinkAccount"
    v66.LayoutOrder = 1
    v66.Parent = v58
    v_u_17.LinkAccount = v66
    local v67 = v66.Button
    local function v_u_68()
        return v_u_61
    end
    v_u_8(v67)
    local v_u_69 = "link"
    v67.MouseButton1Click:Connect(function()
        if v_u_68() then
            return
        else
            local v70 = tick()
            if v70 - v_u_18 < 5 then
                v_u_10.broadcastRouter("CreateMenuNotification", "Error", "Please wait before refreshing again.")
            else
                v_u_18 = v70
                v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
                v_u_9.Collaborations.RefreshMedalStatus.Send(v_u_69)
            end
        end
    end)
    v_u_45(v66, v_u_61, p57 and v63)
    local v71
    if v_u_61 then
        v71 = v59.Unlocked:Clone()
        v71.TextLabel.Text = "Clip and upload your best BloxStrike moment"
        local v72 = v71.Button
        local function v_u_73()
            return v_u_62
        end
        v_u_8(v72)
        local v_u_74 = "clip"
        v72.MouseButton1Click:Connect(function()
            if v_u_73() then
                return
            else
                local v75 = tick()
                if v75 - v_u_18 < 5 then
                    v_u_10.broadcastRouter("CreateMenuNotification", "Error", "Please wait before refreshing again.")
                else
                    v_u_18 = v75
                    v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
                    v_u_9.Collaborations.RefreshMedalStatus.Send(v_u_74)
                end
            end
        end)
        v_u_45(v71, v_u_62, p57 and v64)
    else
        v71 = v59.Locked:Clone()
    end
    v71.Name = "ClipKill"
    v71.LayoutOrder = 2
    v71.Parent = v58
    v_u_17.ClipKill = v71
end
function v_u_1.CreateMissionTemplate(p77, p_u_78)
    local v79 = v_u_2.Assets.UI.Missions.Template:Clone()
    local v80 = v79.Bar.Progress
    local v81 = UDim2.fromScale
    local v82 = p_u_78.Progress / p_u_78.Target
    v80.Size = v81(math.min(v82, 1), 1)
    local v83 = v79.Progress
    local v84 = p_u_78.Progress
    local v85 = tostring(v84):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    local v86 = p_u_78.Target
    v83.Text = v85 .. "/" .. tostring(v86):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    v79.Parent = v_u_24.Holder.Missions.Container.Frame.Container
    v79.Button.Title.Text = p_u_78.IsClaimed and "CLAIMED" or "CLAIM"
    v79.Progress.Visible = p_u_78.Progress < p_u_78.Target
    v79.Button.Visible = p_u_78.Progress >= p_u_78.Target
    v79.Title.Text = p77.MissionId
    v79.Name = p_u_78.MissionId
    v79:SetAttribute("Progress", p_u_78.Progress)
    v79:SetAttribute("Target", p_u_78.Target)
    if p77.Rewards[1].type == "Credits" then
        local v87 = v79.ItemTemplate.Amount
        local v88 = p77.Rewards[1].amount
        v87.Text = tostring(v88):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        v79.ItemTemplate.Frame.Icon.Image = "rbxassetid://129921992230064"
    end
    v_u_8(v79.Button)
    v79.Button.MouseButton1Click:Connect(function()
        local v89 = p_u_78.MissionId
        local v90 = v_u_7.Get(v_u_13, "Missions")
        local v92
        if v90 then
            for _, v92 in ipairs(v90) do
                if v92.MissionId == v89 then
                    goto l3
                end
            end
            v92 = nil
        else
            v92 = nil
        end
        ::l3::
        v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
        if v92 and not v92.IsClaimed then
            v_u_9.Dashboard.MissionCompleted.Send(v92.MissionId)
        end
    end)
end
function v_u_1.UpdateCurrentMissions(_)
    if not v_u_7.Get(v_u_13, "Missions") then
        return
    end
    for _, v93 in ipairs(v_u_24.Holder.Missions.Container.Frame.Container:GetChildren()) do
        if v93:IsA("Frame") then
            local v94 = v93.Name
            local v95 = v_u_7.Get(v_u_13, "Missions")
            local v97
            if v95 then
                for _, v97 in ipairs(v95) do
                    if v97.MissionId == v94 then
                        goto l8
                    end
                end
                v97 = nil
            else
                v97 = nil
            end
            ::l8::
            if v97 then
                local v98 = v93:GetAttribute("Progress")
                local v99 = v93.Progress
                local v100 = v97.Progress
                local v101 = tostring(v100):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
                local v102 = v97.Target
                v99.Text = v101 .. "/" .. tostring(v102):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
                v93.Button.Title.Text = v97.IsClaimed and "CLAIMED" or "CLAIM"
                v93.Progress.Visible = v97.Progress < v97.Target
                v93.Button.Visible = v97.Progress >= v97.Target
                v93.Visible = true
                v93:SetAttribute("Progress", v97.Progress)
                v93:SetAttribute("Target", v97.Target)
                if v_u_24.Visible and v98 < v97.Progress then
                    local v103 = v_u_4
                    local v104 = v93.Bar.Progress
                    local v105 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    local v106 = {}
                    local v107 = UDim2.fromScale
                    local v108 = v97.Progress / v97.Target
                    v106.Size = v107(math.min(v108, 1), 1)
                    v103:Create(v104, v105, v106):Play()
                else
                    local v109 = v93.Bar.Progress
                    local v110 = UDim2.fromScale
                    local v111 = v97.Progress / v97.Target
                    v109.Size = v110(math.min(v111, 1), 1)
                end
            else
                v93:Destroy()
            end
        end
    end
end
function v_u_1.OpenMissionFrame(p112)
    local v113 = v_u_7.Get(v_u_13, "Missions")
    if v_u_19 ~= p112 then
        v_u_19 = p112
        if v113 then
            v_u_29(v_u_24.Holder.Missions.Container.Frame.Container, { "UIListLayout" })
            for _, v114 in ipairs(v113) do
                local v115 = v_u_11.GetMissionDefinition(v114.MissionId)
                if v115 and v115.Type == p112 then
                    v_u_1.CreateMissionTemplate(v115, v114)
                end
            end
        end
    end
end
function v_u_1.Initialize(p_u_116, p117)
    v_u_24 = p117
    v_u_21.Initialize(p_u_116, v_u_24)
    local v118 = v_u_24.Holder.MedalEvent
    local v119 = v_u_23
    if v119 then
        v119 = os.time() < v_u_22
    end
    v118.Visible = v119
    v_u_24.Holder.Advertisement.Visible = false
    local v120, v121 = pcall(function(...)
        return v_u_3:GetPolicyInfoForPlayerAsync(v_u_13)
    end)
    if v120 and (v121 and v121.AllowedExternalLinkReferences) then
        local v_u_122 = table.find(v121.AllowedExternalLinkReferences, "Discord") ~= nil
        v_u_24.Holder.Advertisement.Visible = v_u_122 or false
        v_u_24.Holder.Advertisement:GetPropertyChangedSignal("Visible"):Connect(function()
            if not v_u_24.Holder.Advertisement.Visible then
                local v123 = v_u_24.Holder.Advertisement
                local v124 = v_u_122
                if v124 then
                    v124 = p_u_116.Menu.Dashboard.Visible
                end
                v123.Visible = v124
            end
        end)
        p_u_116.Menu.Dashboard:GetPropertyChangedSignal("Visible"):Connect(function()
            local v125 = v_u_122
            if v125 then
                v125 = p_u_116.Menu.Dashboard.Visible
            end
            if v_u_24.Holder.Advertisement.Visible ~= v125 then
                v_u_24.Holder.Advertisement.Visible = v125
            end
        end)
    end
    local v_u_126 = v_u_24.Holder.MedalEvent
    local v_u_127 = v_u_126.Container.Hide
    local v_u_128 = v_u_126.Position
    local v_u_129 = UDim2.new(1.46, v_u_128.X.Offset, v_u_128.Y.Scale, v_u_128.Y.Offset)
    local v_u_130 = false
    v_u_126.Position = v_u_128
    v_u_127.Rotation = 180
    v_u_127.MouseButton1Click:Connect(function()
        v_u_130 = not v_u_130
        if v_u_130 then
            local v131 = {
                ["Position"] = v_u_129
            }
            v_u_4:Create(v_u_126, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v131):Play()
            v_u_127.Rotation = 0
        else
            local v132 = {
                ["Position"] = v_u_128
            }
            v_u_4:Create(v_u_126, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v132):Play()
            v_u_127.Rotation = 180
        end
    end)
    v_u_8(v_u_24.Container.Reward.Frame.Button)
    v_u_24.Container.Reward.Frame.Button.MouseButton1Click:Connect(function()
        v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_9.Dashboard.RedeemLikeAndFavoriteReward.Send()
    end)
    v_u_8(v_u_24.Container.RedeemCode.Frame.Button)
    v_u_24.Container.RedeemCode.Frame.Button.MouseButton1Click:Connect(function()
        local v133 = v_u_7.Get(v_u_13, "Level")
        v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
        if v133.Level >= 5 then
            local v134 = v_u_24.Container.RedeemCode.Frame.Container.Holder.TextBox.Text
            if tostring(v134) == "" then
                v_u_10.broadcastRouter("CreateMenuNotification", "Error", "Invalid code. Please try again.")
            else
                v_u_24.Container.RedeemCode.Frame.Container.Holder.TextBox.Text = ""
                v_u_9.Dashboard.RedeemCode.Send(v134)
            end
        else
            v_u_10.broadcastRouter("CreateMenuNotification", "Error", "You need to be atleast level 5 to redeem codes.")
            return
        end
    end)
    for _, v135 in ipairs(v_u_24.Container:GetChildren()) do
        if v135:IsA("Frame") then
            v135.Visible = table.find(v_u_14, v135.Name)
        end
    end
    local v_u_136 = v_u_24.Holder.Missions.Container
    local v_u_137 = v_u_136.Hide
    local v_u_138 = v_u_136.Position
    local v_u_139 = UDim2.new(1.49, v_u_138.X.Offset, v_u_138.Y.Scale, v_u_138.Y.Offset)
    local v_u_140 = false
    v_u_136.Position = v_u_138
    v_u_137.Rotation = 180
    v_u_137.MouseButton1Click:Connect(function()
        v_u_140 = not v_u_140
        if v_u_140 then
            local v141 = {
                ["Position"] = v_u_139
            }
            v_u_4:Create(v_u_136, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v141):Play()
            v_u_137.Rotation = 0
        else
            local v142 = {
                ["Position"] = v_u_138
            }
            v_u_4:Create(v_u_136, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v142):Play()
            v_u_137.Rotation = 180
        end
    end)
end
function v_u_1.Start()
    for _, v_u_143 in ipairs(v_u_24.Holder.Missions.Container.Frame.Bottom.Container:GetChildren()) do
        if v_u_143:IsA("TextButton") then
            v_u_8(v_u_143)
            v_u_143.MouseButton1Click:Connect(function()
                v_u_1.OpenMissionFrame(v_u_143.Name)
            end)
        end
    end
    for _, v144 in ipairs(v_u_24.Holder:GetChildren()) do
        if v144:IsA("Frame") then
            local v145 = table.find(v_u_15, v144.Name) ~= nil and (v144.Name == "MedalEvent" and v_u_23)
            if v145 then
                v145 = os.time() < v_u_22
            end
            v144.Visible = v145
        end
    end
    v_u_5.Heartbeat:Connect(function(_)
        if v_u_19 then
            local v146 = v_u_36(v_u_19)
            v_u_24.Holder.Missions.Container.Frame.Header.Title.Text = ("%* MISSIONS"):format((string.upper(v_u_19)))
            if v146 then
                local v147 = v146 - os.time() * 1000
                local v148 = math.max(0, v147) / 1000
                local v149 = math.floor(v148)
                v_u_24.Holder.Missions.Container.Frame.Header.Timer.TextColor3 = v149 > 600 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 85, 85)
                local v150 = v_u_24.Holder.Missions.Container.Frame.Header.Timer
                local v151 = string.format
                local v152 = v149 / 86400
                local v153 = math.floor(v152)
                local v154 = v149 % 86400 / 3600
                local v155 = math.floor(v154)
                local v156 = v149 % 3600 / 60
                v150.Text = v151("%i:%02i:%02i:%02i", v153, v155, math.floor(v156), v149 % 60)
            else
                v_u_24.Holder.Missions.Container.Frame.Header.Timer.TextColor3 = Color3.fromRGB(255, 85, 85)
                v_u_24.Holder.Missions.Container.Frame.Header.Timer.Text = string.format("%i:%02i:%02i:%02i", 0, 0, 0, 0)
            end
        else
            v_u_24.Holder.Missions.Container.Frame.Header.Timer.TextColor3 = Color3.fromRGB(255, 255, 255)
            v_u_24.Holder.Missions.Container.Frame.Header.Timer.Text = string.format("%i:%02i:%02i:%02i", 0, 0, 0, 0)
            v_u_24.Holder.Missions.Container.Frame.Header.Title.Text = "MISSIONS"
            return
        end
    end)
    v_u_7.CreateListener(v_u_13, "Missions", function(p157)
        if v_u_20 then
            v_u_1.UpdateCurrentMissions(p157)
        else
            v_u_1.OpenMissionFrame("hourly")
            v_u_20 = true
        end
    end)
    v_u_7.CreateListener(v_u_13, "LikeAndFavoriteReward", function(p158)
        v_u_24.Container.Reward.Visible = not p158
    end)
    local v159 = v_u_23
    if v159 then
        v159 = os.time() < v_u_22
    end
    if v159 then
        v_u_76(false)
        v_u_13:GetAttributeChangedSignal("RobloxAccountLinkedToMedal"):Connect(function()
            v_u_76(true)
        end)
        v_u_13:GetAttributeChangedSignal("HasClippedBloxStrike"):Connect(function()
            v_u_76(true)
        end)
        v_u_7.CreateListener(v_u_13, "HasClaimedExclusiveMedalReward", function()
            v_u_76(false)
        end)
        local v_u_160 = v_u_24.Holder.MedalEvent.Container.Frame.Header.Timer
        v_u_5.Heartbeat:Connect(function(p161)
            local v162 = v_u_22 - os.time()
            local v163 = math.max(0, v162)
            if v163 <= 0 then
                v_u_24.Holder.MedalEvent.Visible = false
                return
            else
                local v164 = v163 / 86400
                local v165 = math.floor(v164)
                local v166 = v163 % 86400 / 3600
                local v167 = math.floor(v166)
                local v168 = v163 % 3600 / 60
                local v169 = math.floor(v168)
                local v170 = v163 % 60
                local v171 = v_u_24.Holder.MedalEvent.Container.Frame.Rewards.Item.Frame.Content.Outer.Icon.Glow
                v171.Rotation = v171.Rotation + p161 * 6.7
                if v165 >= 1 then
                    v_u_160.Text = string.format("%02i:%02i:%02i:%02i", v165, v167, v169, v170)
                else
                    v_u_160.Text = string.format("%02i:%02i:%02i", v167, v169, v170)
                end
            end
        end)
    else
        v_u_24.Holder.MedalEvent.Visible = false
    end
end
return v_u_1