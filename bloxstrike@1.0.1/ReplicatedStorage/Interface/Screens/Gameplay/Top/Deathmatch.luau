local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local _ = v_u_4.LocalPlayer
local v_u_5 = require(v_u_2.Components.Common.GetTimerFormat)
local v_u_6 = require(v_u_2.Database.Security.Router)
local v_u_7 = require(v_u_2.Packages.Observers)
local v_u_8 = require(v_u_2.Shared.Janitor)
local v_u_9 = require(v_u_2.Database.Custom.GameStats.Settings.Colors)
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = {}
local function v_u_16(p13)
    local v14 = p13:GetChildren()
    for _, v15 in ipairs(v14) do
        if v15.ClassName == "Frame" then
            v15:Destroy()
        end
    end
end
function v_u_1.createTemplate(p_u_17, _)
    local v18 = workspace:GetAttribute("Gamemode")
    local v19 = p_u_17:GetAttribute("Team")
    v_u_1.cleanupPlayerTemplate(p_u_17)
    if v18 == "Deathmatch" and (v19 == "Terrorists" or v19 == "Counter-Terrorists") then
        local v20 = v_u_8.new()
        v_u_12[p_u_17] = v20
        local v_u_21 = v_u_2.Assets.UI.Deathmatch.PlayerTemplate:Clone()
        v_u_21.Player.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(p_u_17.UserId)
        v_u_21.Info.UIStroke.Color = v_u_9["Team Color"][v19]
        v_u_21.UIStroke.Color = v_u_9["Team Color"][v19]
        v_u_21.Parent = v_u_10.Players
        v_u_21.Info.Amount.Text = "0"
        v20:Add(function()
            v_u_21:Destroy()
        end)
        v20:Add(v_u_7.observeAttribute(p_u_17, "Score", function(p22)
            v_u_21.Info.Amount.Text = tostring(p22)
            v_u_21.LayoutOrder = -p22
        end))
        v20:Add(v_u_7.observeAttribute(p_u_17, "Team", function(p23)
            if p23 ~= "Counter-Terrorists" and p23 ~= "Terrorists" then
                v_u_1.cleanupPlayerTemplate(p_u_17)
            end
            return function()
                v_u_1.cleanupPlayerTemplate(p_u_17)
            end
        end))
    end
end
function v_u_1.cleanupPlayerTemplate(p24)
    local v25 = v_u_12[p24]
    v_u_12[p24] = nil
    if v25 then
        v25:Destroy()
    end
end
function v_u_1.playerAdded(p_u_26)
    if p_u_26.Character then
        v_u_1.createTemplate(p_u_26, p_u_26.Character)
    end
    p_u_26.CharacterAdded:Connect(function(p27)
        v_u_1.createTemplate(p_u_26, p27)
    end)
end
function v_u_1.Initialize(p28, p29)
    v_u_11 = p28
    v_u_10 = p29
    v_u_7.observeAttribute(workspace, "Timer", function(p30)
        local v31 = workspace:GetAttribute("Gamemode")
        local v32 = workspace:GetAttribute("GameState")
        v_u_10.Time.Timer.TextColor3 = Color3.fromRGB(255, 255, 255)
        v_u_10.Time.Timer.Text = v_u_5(p30)
        if v31 == "Deathmatch" and (v32 ~= "Warmup" and p30 <= 10) then
            v_u_10.Time.Timer.TextColor3 = Color3.fromRGB(165, 20, 20)
            v_u_6.broadcastRouter("PlayCountdownTimer")
        end
    end)
    v_u_3.Heartbeat:Connect(function()
        local v33 = v_u_10
        local v34
        if workspace:GetAttribute("Gamemode") == "Deathmatch" then
            v34 = not v_u_11.Gameplay.Middle.TeamSelection.Visible
        else
            v34 = false
        end
        v33.Visible = v34
    end)
end
function v_u_1.Start()
    v_u_16(v_u_10.Players)
    for _, v35 in ipairs(v_u_4:GetPlayers()) do
        v_u_1.playerAdded(v35)
    end
    v_u_4.PlayerAdded:Connect(function(p36)
        v_u_1.playerAdded(p36)
    end)
    v_u_4.PlayerRemoving:Connect(function(p37)
        v_u_1.cleanupPlayerTemplate(p37)
    end)
end
return v_u_1