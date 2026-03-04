local v_u_1 = {}
local v2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
local v4 = game:GetService("RunService")
local v_u_5 = require(v3.Controllers.CameraController)
local v_u_6 = require(v3.Controllers.EndScreenController)
local v7 = require(v3.Shared.Janitor)
local v_u_8 = require(v3.Database.Security.Remotes)
local v_u_9 = require(v3.Database.Security.Router)
local v_u_10 = require(v3.Shared.CloseButtonRegistry)
local v_u_11 = require(v3.Interface.MenuState)
local v_u_12 = v2.LocalPlayer
local v_u_13 = v4:IsStudio()
local v_u_14 = v3.Database.Custom.GameStats.Maps
local v_u_15 = {
    {
        ["Name"] = "DropKnife",
        ["Label"] = "Drop Knife",
        ["Key"] = "KnifeDropEnabled"
    },
    {
        ["Name"] = "FreezeTimer",
        ["Label"] = "Freeze Timer",
        ["Key"] = "TimerFrozen"
    },
    {
        ["Name"] = "KillTrading",
        ["Label"] = "Kill Trading",
        ["Key"] = "KillTradingEnabled"
    }
}
local v_u_16 = {
    {
        ["Name"] = "Competitive",
        ["Mode"] = "COMPETITIVE",
        ["Description"] = "Classic round-based rules with economy and no respawns.",
        ["ServerGamemode"] = "Competitive"
    },
    {
        ["Name"] = "Casual",
        ["Mode"] = "CASUAL",
        ["Description"] = "Relaxed round-based rules with lighter penalties.",
        ["ServerGamemode"] = "Casual"
    },
    {
        ["Name"] = "Deathmatch",
        ["Mode"] = "DEATHMATCH",
        ["Description"] = "Fast respawn combat focused on eliminations.",
        ["ServerGamemode"] = "Deathmatch"
    }
}
local v_u_17 = {}
local v_u_18 = {}
local v_u_19 = {}
local v_u_20 = false
local v_u_21 = nil
local v_u_22 = {}
local v_u_23 = "KickPlayer"
local v_u_24 = v7.new()
local v_u_25 = v7.new()
local v_u_26 = v7.new()
local v_u_27 = v7.new()
local v_u_28 = v7.new()
local v_u_29 = nil
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = nil
local v_u_33 = nil
local v_u_34 = nil
local v_u_35 = nil
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = "Close"
local v_u_39 = nil
local v_u_40 = nil
local v_u_41 = nil
local v_u_42 = nil
local v_u_43 = nil
local v_u_44 = nil
local function v_u_50()
    local v45 = v_u_29
    if v45 then
        v45 = v_u_29.Parent
    end
    if v45 then
        v45 = v45.Parent
    end
    if v45 then
        v45 = v45.Parent
    end
    if not (v45 and v45:IsA("ScreenGui")) then
        v45 = nil
    end
    if not v45 then
        return false
    end
    local v46 = v45:FindFirstChild("Gameplay")
    if not (v46 and v46:IsA("GuiObject")) then
        return false
    end
    local v47 = v46:FindFirstChild("Middle")
    if not (v47 and v47:IsA("GuiObject")) then
        return false
    end
    local v48 = v47:FindFirstChild("TeamSelection")
    local v49 = v48 ~= nil and v48:IsA("GuiObject")
    if v49 then
        v49 = v48.Visible
    end
    return v49
end
local function v_u_56(p51, p52, p_u_53)
    if p52:IsA("GuiButton") then
        p51:Add(p52.MouseButton1Click:Connect(p_u_53))
    else
        p52.Active = true
        p51:Add(p52.InputBegan:Connect(function(p54)
            local v55 = p54.UserInputType
            if v55 == Enum.UserInputType.MouseButton1 or v55 == Enum.UserInputType.Touch then
                p_u_53()
            end
        end))
    end
end
local function v_u_61(p57, p58, p59)
    for _, v60 in ipairs(p57:GetChildren()) do
        if v60 ~= p58 and not (p59 and p59[v60.Name]) and v60:IsA("GuiObject") then
            v60:Destroy()
        end
    end
    p58.Visible = false
end
local function v_u_67(p62)
    if p62 == "VoteKick" then
        if v_u_36 then
            v_u_36.Text = v_u_23 == "GodMode" and "God Mode" or "Players"
        end
        v_u_34.Visible = true
    else
        v_u_30.Visible = p62 == "Home"
        v_u_31.Visible = p62 == "Settings"
        v_u_32.Visible = p62 == "MapSelect"
        v_u_33.Visible = p62 == "ModeSelect"
        v_u_34.Visible = false
    end
    local v63 = v_u_29.Position
    v_u_29.Position = UDim2.new(p62 == "VoteKick" and 0.4 or 0.5, v63.X.Offset, v63.Y.Scale, v63.Y.Offset)
    if v_u_37 then
        local v64 = (v_u_31.Visible or (v_u_32.Visible or v_u_33.Visible)) and "Back" or v_u_38
        local v65 = v_u_37:FindFirstChild("Frame")
        if v65 then
            v65 = v65:FindFirstChildWhichIsA("TextLabel")
        end
        if v65 then
            v65.Text = v64
            return
        end
        local v66 = v_u_37:FindFirstChildWhichIsA("TextLabel")
        if v66 then
            v66.Text = v64
            return
        end
        if v_u_37:IsA("TextButton") then
            v_u_37.Text = v64
        end
    end
end
local function v_u_72(p68)
    if v_u_22[p68] ~= nil then
        return v_u_22[p68]
    end
    local v69 = v_u_14:FindFirstChild(p68)
    if not v69 then
        v_u_22[p68] = nil
        return nil
    end
    if not v69:IsA("ModuleScript") then
        v69 = v69:FindFirstChild("init")
    end
    if not (v69 and v69:IsA("ModuleScript")) then
        v_u_22[p68] = nil
        return nil
    end
    local v70, v71 = pcall(require, v69)
    if not v70 or typeof(v71) ~= "table" then
        v71 = nil
    end
    v_u_22[p68] = v71
    return v71
end
local function v_u_83()
    v_u_19 = {}
    for _, v75 in ipairs(v_u_14:GetChildren()) do
        local v74 = v75.Name
        if not v75:IsA("ModuleScript") then
            local v75 = v75:FindFirstChild("init")
        end
        if v75 and v75:IsA("ModuleScript") then
            local v76, v77 = pcall(require, v75)
            if v76 and typeof(v77) == "table" then
                v_u_22[v74] = v77
                local v78 = v_u_19
                local v79 = {
                    ["Name"] = v74
                }
                local v80 = v77.Icon
                v79.Icon = typeof(v80) == "string" and (v77.Icon or "") or ""
                table.insert(v78, v79)
            end
        end
    end
    table.sort(v_u_19, function(p81, p82)
        return p81.Name < p82.Name
    end)
    v_u_20 = true
end
local function v_u_90(p84)
    for _, v85 in ipairs(v_u_19) do
        local v86 = v85.Name
        local v87
        if p84 then
            local v88 = v_u_72(v86)
            if v88 then
                v88 = v88.Gamemode
            end
            if typeof(v88) == "table" then
                local v89 = v88[p84]
                if v89 == nil then
                    v87 = false
                else
                    v87 = v89 ~= false
                end
            else
                v87 = false
            end
        else
            v87 = true
        end
        if v87 and v85.Icon ~= "" then
            return v85.Icon
        end
    end
    return nil
end
local function v_u_97(p91, p92)
    local v93 = p91:WaitForChild("Button")
    local v94 = v93:WaitForChild("ImageLabel")
    local v95 = v93:WaitForChild("Border"):WaitForChild("UIStroke")
    v94.Visible = p92
    local v96
    if p92 then
        v96 = Color3.fromRGB(255, 255, 255)
    else
        v96 = Color3.fromRGB(100, 100, 100)
    end
    v95.Color = v96
end
local function v_u_100()
    for _, v98 in ipairs(v_u_15) do
        local v99 = v_u_31:FindFirstChild(v98.Name)
        if v99 and v99:IsA("GuiObject") then
            v_u_97(v99, v_u_17[v98.Key] == true)
        end
    end
end
local function v_u_109(p101, p102)
    local v103 = p101:WaitForChild("Accept")
    local v104 = v103:WaitForChild("ActiveBorder")
    local v105 = v103:WaitForChild("TextLabel")
    if v103:IsA("TextButton") or v103:IsA("ImageButton") then
        v103.BackgroundTransparency = 0
        v103.BackgroundColor3 = Color3.fromRGB(20, 75, 17)
    end
    v104.Enabled = true
    v105.Text = p102 and "SELECTED" or "SELECT"
    local v106 = v103:FindFirstChild("ActivateGradient")
    for _, v107 in ipairs(v103:GetDescendants()) do
        if v107:IsA("UIGradient") then
            if v107 == v106 then
                v107.Enabled = true
            else
                local v108 = v107.Name
                if v108 == "ActivateGradient" then
                    v107.Enabled = true
                elseif v108 == "InactiveGradient" then
                    v107.Enabled = false
                end
            end
        end
    end
end
local function v_u_121()
    if v_u_20 then
        v_u_26:Cleanup()
        v_u_61(v_u_32, v_u_42, {
            ["Back"] = true,
            ["Close"] = true
        })
        local v110 = 1
        for _, v_u_111 in ipairs(v_u_19) do
            local v112 = v_u_111.Name
            local v113 = v_u_21
            local v114
            if v113 then
                local v115 = v_u_72(v112)
                if v115 then
                    v115 = v115.Gamemode
                end
                if typeof(v115) == "table" then
                    local v116 = v115[v113]
                    if v116 == nil then
                        v114 = false
                    else
                        v114 = v116 ~= false
                    end
                else
                    v114 = false
                end
            else
                v114 = true
            end
            if v114 then
                local v_u_117 = v_u_42:Clone()
                v_u_117.Name = v_u_111.Name
                v_u_117.LayoutOrder = v110
                v_u_117.Visible = true
                v110 = v110 + 1
                v_u_117:WaitForChild("Header"):WaitForChild("Info").Text = v_u_111.Name
                local v118 = v_u_117:WaitForChild("Main")
                local v119 = v118:FindFirstChild("Map") or v118:FindFirstChild("ImageButton")
                if v119 and not (v119:IsA("ImageLabel") or v119:IsA("ImageButton")) then
                    v119 = nil
                end
                if v119 then
                    v119.Image = v_u_111.Icon
                end
                local v120 = v118:FindFirstChild("Selection")
                if v120 and not v120:IsA("TextLabel") then
                    v120 = nil
                end
                if v120 then
                    v120.Text = v_u_111.Name
                end
                v_u_109(v_u_117, v_u_17.NextMap == v_u_111.Name)
                v_u_56(v_u_26, v_u_117:WaitForChild("Accept"), function()
                    v_u_17.NextMap = v_u_111.Name
                    v_u_8.VIP.SetSetting.Send({
                        ["Key"] = "NextMap",
                        ["Value"] = v_u_111.Name
                    })
                    v_u_109(v_u_117, true)
                    v_u_121()
                    v_u_67("Home")
                end)
                v_u_117.Parent = v_u_32
            end
        end
    end
end
local function v_u_134()
    v_u_27:Cleanup()
    v_u_61(v_u_33, v_u_43, {
        ["Back"] = true,
        ["Close"] = true
    })
    local v122 = v_u_17.NextGamemode
    local v123
    if typeof(v122) == "string" then
        v123 = v_u_17.NextGamemode
    else
        v123 = v_u_21
    end
    for v124, v_u_125 in ipairs(v_u_16) do
        local v126 = v_u_43:Clone()
        v126.Name = v_u_125.Name
        v126.LayoutOrder = v124
        v126.Visible = true
        local v127 = v126:WaitForChild("Main")
        local v128 = v127:WaitForChild("Info")
        local v129 = v128:WaitForChild("Mode")
        local v130 = v128:WaitForChild("Description")
        local v131 = v127:WaitForChild("Select")
        local v132 = v127:WaitForChild("ImageButton")
        v129.Text = v_u_125.Mode
        v130.Text = v_u_125.Description
        v131.Visible = v123 == v_u_125.ServerGamemode
        local v133 = v_u_90(v_u_125.ServerGamemode)
        if v133 then
            v132.Image = v133
        end
        v_u_56(v_u_27, v126:FindFirstChild("Button") or v126, function()
            v_u_21 = v_u_125.ServerGamemode
            v_u_8.VIP.SetSetting.Send({
                ["Key"] = "NextGamemode",
                ["Value"] = v_u_125.ServerGamemode
            })
            v_u_134()
            v_u_67("MapSelect")
            v_u_121()
        end)
        v126.Parent = v_u_33
    end
end
local function v_u_158()
    v_u_28:Cleanup()
    v_u_61(v_u_35, v_u_44, nil)
    local v135 = 1
    for _, v_u_136 in ipairs(v_u_18) do
        if v_u_23 ~= "KickPlayer" or v_u_136.UserId ~= v_u_12.UserId then
            local v137 = v_u_44:Clone()
            local v138 = v_u_136.UserId
            v137.Name = tostring(v138)
            v137.LayoutOrder = v135
            v137.Visible = true
            v135 = v135 + 1
            local v139 = v137:WaitForChild("Player")
            local v140 = v139:WaitForChild("Player")
            local v_u_141 = v139:WaitForChild("Name")
            local v142 = v139:WaitForChild("Bomb")
            local v_u_143 = v137:WaitForChild("Selected")
            v140.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(v_u_136.UserId)
            local v_u_144 = "@" .. v_u_136.DisplayName
            v142.Visible = v_u_136.Team == "Terrorists"
            v_u_143.Visible = false
            if v_u_23 == "GodMode" then
                local v145 = v_u_136.UserId
                local v146 = v_u_17.GodModeEnabledPlayers
                local v147
                if typeof(v146) == "table" then
                    v147 = v146[tostring(v145)] == true and true or v146[v145] == true
                else
                    v147 = false
                end
                v_u_143.Visible = v147
                v_u_141.Text = ("%* [%*]"):format(v_u_144, v147 and "ON" or "OFF")
                local v148
                if v147 then
                    v148 = Color3.fromRGB(150, 255, 167)
                else
                    v148 = Color3.fromRGB(170, 170, 170)
                end
                v_u_141.TextColor3 = v148
            else
                v_u_141.Text = v_u_144
                v_u_141.TextColor3 = Color3.fromRGB(190, 190, 190)
                v_u_143.Visible = false
            end
            v_u_56(v_u_28, v137, function()
                v_u_9.broadcastRouter("RunInterfaceSound", "UI Click")
                if v_u_23 == "GodMode" then
                    local v149 = v_u_17.GodModeEnabledPlayers
                    if typeof(v149) ~= "table" then
                        v149 = {}
                        v_u_17.GodModeEnabledPlayers = v149
                    end
                    local v150 = v_u_136.UserId
                    local v151 = tostring(v150)
                    local v152 = v_u_136.UserId
                    local v153 = v_u_17.GodModeEnabledPlayers
                    local v154
                    if typeof(v153) == "table" then
                        v154 = v153[tostring(v152)] == true and true or v153[v152] == true
                    else
                        v154 = false
                    end
                    local v155 = not v154
                    v149[v_u_136.UserId] = nil
                    if v155 then
                        v149[v151] = true
                    else
                        v149[v151] = nil
                    end
                    v_u_17.GodModeEnabledPlayers = v149
                    v_u_143.Visible = v155
                    v_u_141.Text = ("%* [%*]"):format(v_u_144, v155 and "ON" or "OFF")
                    local v156 = v_u_141
                    local v157
                    if v155 then
                        v157 = Color3.fromRGB(150, 255, 167)
                    else
                        v157 = Color3.fromRGB(170, 170, 170)
                    end
                    v156.TextColor3 = v157
                    v_u_8.VIP.SetSetting.Send({
                        ["Key"] = "GodModeEnabledPlayers",
                        ["Value"] = v149
                    })
                else
                    v_u_143.Visible = true
                    v_u_8.VIP.ExecuteAction.Send({
                        ["Action"] = "KickPlayer",
                        ["Params"] = v_u_136.UserId
                    })
                    v_u_67("Home")
                end
            end)
            v137.Parent = v_u_35
        end
    end
end
local function v_u_179()
    v_u_25:Cleanup()
    v_u_61(v_u_31, v_u_39, {
        ["InputTemplate"] = true,
        ["ClickTemplate"] = true
    })
    v_u_40.Visible = false
    v_u_39.Visible = false
    v_u_41.Visible = false
    local v159 = 1
    for _, v_u_160 in ipairs(v_u_15) do
        local v_u_161 = v_u_39:Clone()
        v_u_161.Name = v_u_160.Name
        v_u_161.LayoutOrder = v159
        v_u_161.Visible = true
        v159 = v159 + 1
        local v162 = v_u_161:WaitForChild("TextLabel")
        local v163 = v_u_161:WaitForChild("Button")
        v162.Text = v_u_160.Label
        v162.AnchorPoint = Vector2.new(0.5, 0.5)
        v162.Position = UDim2.fromScale(0.5, 0.5)
        v162.Size = UDim2.new(1, 0, v162.Size.Y.Scale, v162.Size.Y.Offset)
        v162.TextXAlignment = Enum.TextXAlignment.Center
        v162.TextYAlignment = Enum.TextYAlignment.Center
        local v_u_164 = false
        local function v166()
            if not v_u_164 then
                v_u_164 = true
                local v165 = v_u_17[v_u_160.Key] ~= true
                v_u_17[v_u_160.Key] = v165
                v_u_97(v_u_161, v165)
                v_u_8.VIP.SetSetting.Send({
                    ["Key"] = v_u_160.Key,
                    ["Value"] = v165
                })
                task.defer(function()
                    v_u_164 = false
                end)
            end
        end
        v_u_56(v_u_25, v_u_161, v166)
        v_u_56(v_u_25, v163, v166)
        v_u_161.Parent = v_u_31
        v_u_97(v_u_161, v_u_17[v_u_160.Key] == true)
    end
    local v167 = v_u_40:Clone()
    v167.Name = "SetTimer"
    v167.LayoutOrder = v159
    v167.Visible = true
    local v168 = v159 + 1
    local v169 = v167:WaitForChild("TextLabel")
    local v_u_170 = v167:FindFirstChildWhichIsA("TextBox", true)
    v169.Text = "Set Timer"
    v169.AnchorPoint = Vector2.new(0.5, 0.5)
    v169.Position = UDim2.fromScale(0.5, 0.5)
    v169.Size = UDim2.new(1, 0, v169.Size.Y.Scale, v169.Size.Y.Offset)
    v169.TextXAlignment = Enum.TextXAlignment.Center
    v169.TextYAlignment = Enum.TextYAlignment.Center
    v_u_170.TextXAlignment = Enum.TextXAlignment.Center
    v_u_170.TextYAlignment = Enum.TextYAlignment.Center
    v_u_170.Text = ""
    v_u_170.PlaceholderText = "Seconds"
    v_u_25:Add(v_u_170.FocusLost:Connect(function()
        local v171 = v_u_170.Text
        local v172 = tonumber(v171)
        if v172 then
            local v173 = v_u_8.VIP.ExecuteAction.Send
            local v174 = {
                ["Action"] = "SetTimer"
            }
            local v175 = math.floor(v172)
            v174.Params = math.clamp(v175, 0, 9999)
            v173(v174)
            v_u_170.Text = ""
        else
            v_u_170.Text = ""
        end
    end))
    v167.Parent = v_u_31
    local v176 = {
        {
            ["Name"] = "GodMode",
            ["Label"] = "God Mode",
            ["Callback"] = function()
                v_u_23 = "GodMode"
                v_u_8.VIP.RequestData.Send("State")
                v_u_8.VIP.RequestData.Send("PlayerList")
                v_u_158()
                v_u_67("VoteKick")
            end
        },
        {
            ["Name"] = "KickPlayer",
            ["Label"] = "Kick Player",
            ["Callback"] = function()
                v_u_23 = "KickPlayer"
                v_u_8.VIP.RequestData.Send("PlayerList")
                v_u_158()
                v_u_67("VoteKick")
            end
        },
        {
            ["Name"] = "EndGame",
            ["Label"] = "End Current Game",
            ["Callback"] = function()
                v_u_8.VIP.ExecuteAction.Send({
                    ["Action"] = "EndGame",
                    ["Params"] = nil
                })
                v_u_67("Home")
            end
        },
        {
            ["Name"] = "ResetScore",
            ["Label"] = "Reset Score",
            ["Callback"] = function()
                v_u_8.VIP.ExecuteAction.Send({
                    ["Action"] = "ResetScore",
                    ["Params"] = nil
                })
            end
        }
    }
    for _, v177 in ipairs(v176) do
        local v178 = v_u_41:Clone()
        v178.Name = v177.Name
        v178.LayoutOrder = v168
        v178.Visible = true
        v168 = v168 + 1
        v178:WaitForChild("TextLabel").Text = v177.Label
        v_u_56(v_u_25, v178, v177.Callback)
        v178.Parent = v_u_31
    end
end
local function v_u_184()
    for _, v180 in ipairs(v_u_30:GetChildren()) do
        if v180:IsA("GuiButton") then
            local v181 = v180:FindFirstChild("Frame")
            if v181 then
                v181 = v181:FindFirstChildWhichIsA("TextLabel")
            end
            local v_u_182
            if v181 then
                v_u_182 = v181.Text
            else
                local v183 = v180:FindFirstChildWhichIsA("TextLabel")
                if v183 then
                    v_u_182 = v183.Text
                else
                    v_u_182 = not v180:IsA("TextButton") and "" or v180.Text
                end
            end
            v_u_56(v_u_24, v180, function()
                if v_u_182 == "Select Map" then
                    v_u_21 = nil
                    v_u_67("MapSelect")
                    v_u_121()
                    return
                elseif v_u_182 == "Select Mode" then
                    v_u_134()
                    v_u_67("ModeSelect")
                elseif v_u_182 == "Settings" then
                    v_u_179()
                    v_u_67("Settings")
                end
            end)
        end
    end
end
local function v_u_191()
    local v185 = { v_u_32, v_u_33, v_u_34 }
    for _, v186 in ipairs(v185) do
        local v187 = v186:FindFirstChild("Back")
        if v187 then
            v_u_56(v_u_24, v187, function()
                v_u_67("Home")
            end)
        end
        local v188 = v186:FindFirstChild("Close")
        if v188 and (v186 == v_u_32 or v186 == v_u_33) then
            local v189 = v188:FindFirstChild("Frame")
            if v189 then
                v189 = v189:FindFirstChildWhichIsA("TextLabel")
            end
            if v189 then
                v189.Text = "Back"
            else
                local v190 = v188:FindFirstChildWhichIsA("TextLabel")
                if v190 then
                    v190.Text = "Back"
                elseif v188:IsA("TextButton") then
                    v188.Text = "Back"
                end
            end
        end
        if v188 and (v188 ~= v187 and v188:IsA("GuiButton")) then
            v_u_10.Add(v186, v188, function()
                v_u_67("Home")
            end)
        end
    end
end
local function v_u_196()
    local v192 = v_u_29:WaitForChild("Close")
    if v192 and v192:IsA("GuiButton") then
        v_u_37 = v192
        local v193 = v192:FindFirstChild("Frame")
        if v193 then
            v193 = v193:FindFirstChildWhichIsA("TextLabel")
        end
        local v194
        if v193 then
            v194 = v193.Text
        else
            local v195 = v192:FindFirstChildWhichIsA("TextLabel")
            if v195 then
                v194 = v195.Text
            else
                v194 = not v192:IsA("TextButton") and "" or v192.Text
            end
        end
        if v194 ~= "" then
            v_u_38 = v194
        end
        v_u_10.Add(v_u_29, v192, function()
            if v_u_31.Visible or (v_u_32.Visible or v_u_33.Visible) then
                v_u_67("Home")
            else
                v_u_1.closeFrame()
            end
        end)
    end
end
function v_u_1.openFrame()
    local v197 = v_u_6.IsActive()
    local v198 = v_u_11.IsInspectActive()
    local v199 = v_u_11.IsCaseSceneActive()
    local v200 = v_u_12:GetAttribute("Team")
    local v201 = v200 == "Counter-Terrorists" and true or v200 == "Terrorists" or v_u_12:GetAttribute("IsSpectating") == true
    local v202 = v_u_29
    if v202 then
        v202 = v_u_29.Parent
    end
    if v202 then
        v202 = v202.Parent
    end
    if v202 then
        v202 = v202.Parent
    end
    if not (v202 and v202:IsA("ScreenGui")) then
        v202 = nil
    end
    local v203
    if v202 then
        local v204 = v202:FindFirstChild("Menu")
        v203 = v204 ~= nil and v204:IsA("GuiObject")
        if v203 then
            v203 = v204.Visible
        end
    else
        v203 = false
    end
    local v205 = v_u_50()
    if v_u_13 and true or v_u_12:GetAttribute("CanUseVIPMenu") == true then
        if v_u_29 then
            if v197 then
                return
            elseif v198 or v199 then
                return
            elseif v201 then
                if v203 then
                    return
                elseif v205 then
                    return
                elseif not v_u_29.Visible then
                    v_u_5.setForceLockOverride("VIPMenu", true)
                    if v_u_12:GetAttribute("IsSpectating") ~= true then
                        local v206 = v_u_12.Character
                        local v207
                        if v206 == nil then
                            v207 = false
                        else
                            v207 = v206:IsDescendantOf(workspace)
                        end
                        if v207 then
                            v_u_5.setPerspective(true, true)
                        end
                    end
                    v_u_29.Visible = true
                    v_u_67("Home")
                    v_u_8.VIP.RequestData.Send("State")
                    v_u_8.VIP.RequestData.Send("PlayerList")
                    v_u_121()
                    v_u_134()
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
function v_u_1.closeFrame()
    if v_u_29 then
        v_u_5.setForceLockOverride("VIPMenu", false)
        if v_u_12:GetAttribute("IsSpectating") ~= true then
            local v208 = v_u_12.Character
            local v209
            if v208 == nil then
                v209 = false
            else
                v209 = v208:IsDescendantOf(workspace)
            end
            if v209 then
                v_u_5.setPerspective(true, false)
            end
        end
        v_u_29.Visible = false
    end
end
function v_u_1.toggleFrame()
    if v_u_29 then
        if v_u_29.Visible then
            v_u_1.closeFrame()
        else
            v_u_1.openFrame()
        end
    else
        return
    end
end
function v_u_1.Initialize(_, p210)
    v_u_29 = p210
    v_u_30 = p210:WaitForChild("Frame")
    v_u_31 = p210:WaitForChild("ScrollingFrame")
    v_u_32 = p210:WaitForChild("SelectMap")
    v_u_33 = p210:WaitForChild("SelectMode")
    v_u_34 = p210:WaitForChild("VoteKick")
    v_u_35 = v_u_34:WaitForChild("Container")
    v_u_36 = v_u_34:WaitForChild("Header"):WaitForChild("Title")
    v_u_39 = v_u_31:WaitForChild("ToggleTemplate")
    v_u_40 = v_u_31:WaitForChild("InputTemplate")
    v_u_41 = v_u_31:WaitForChild("ClickTemplate")
    v_u_42 = v_u_32:WaitForChild("Template")
    v_u_43 = v_u_33:WaitForChild("Template")
    v_u_44 = v_u_35:WaitForChild("Template")
    v_u_17 = {}
    v_u_18 = {}
    v_u_19 = {}
    v_u_20 = false
    v_u_21 = nil
    v_u_22 = {}
    v_u_23 = "KickPlayer"
    v_u_37 = nil
    v_u_38 = "Close"
    v_u_83()
    v_u_29.Visible = false
    v_u_67("Home")
    v_u_179()
    v_u_134()
    v_u_24:Add(v_u_29:GetPropertyChangedSignal("Visible"):Connect(function()
        if not v_u_29.Visible then
            v_u_5.setForceLockOverride("VIPMenu", false)
        end
    end))
    v_u_24:Add(v_u_8.VIP.SyncState.Listen(function(p211)
        v_u_17 = p211
        v_u_100()
        v_u_121()
        if v_u_34.Visible then
            v_u_158()
        end
    end))
    v_u_24:Add(v_u_8.VIP.DataResponse.Listen(function(p212)
        if p212.Type == "State" then
            v_u_17 = p212.Data
            v_u_100()
            v_u_121()
            if v_u_34.Visible then
                v_u_158()
                return
            end
        elseif p212.Type == "PlayerList" then
            v_u_18 = p212.Data
            v_u_158()
        end
    end))
end
function v_u_1.Start()
    v_u_184()
    v_u_191()
    v_u_196()
    v_u_100()
end
return v_u_1