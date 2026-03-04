local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_4 = require(v2.Database.Components.GameState)
local v_u_5 = require(v2.Controllers.DataController)
local v_u_6 = require(v2.Interface.MenuState)
local v_u_7 = require(v2.Classes.Sound)
local v_u_8 = require(v2.Database.Security.Remotes)
local v_u_9 = v_u_3.LocalPlayer
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = nil
local function v_u_17()
    if v_u_14 and v_u_14.Parent then
        local v15 = (v_u_5.Get(v_u_9, "Settings.Audio.Music.MVP Volume") or 50) / 50
        local v16 = (v_u_5.Get(v_u_9, "Settings.Audio.Audio.Master Volume") or 100) / 100
        v_u_14.Volume = (v_u_14:GetAttribute("BaseVolume") or v_u_14.Volume) * v15 * v16
    end
end
local function v_u_25()
    local v18 = 0
    local v19 = 0
    for _, v20 in ipairs(v_u_3:GetPlayers()) do
        local v21 = v20:GetAttribute("Team")
        if v21 == "Counter-Terrorists" or v21 == "Terrorists" then
            local v22 = v20.Character
            if v22 and (v22:IsDescendantOf(workspace) and not v22:GetAttribute("Dead")) then
                local v23 = v22:FindFirstChildOfClass("Humanoid")
                if v23 and (v23.Health > 0 and not v20:GetAttribute("IsSpectating")) then
                    if v21 == "Counter-Terrorists" then
                        v19 = v19 + 1
                    elseif v21 == "Terrorists" then
                        v18 = v18 + 1
                    end
                end
            end
        end
    end
    local v24
    if v19 > 0 then
        v24 = v18 > 0
    else
        v24 = false
    end
    return v24
end
local function v_u_31()
    if v_u_6.GetCurrentScreen() == nil then
        local v26 = v_u_9:WaitForChild("PlayerGui")
        local v27 = v26:FindFirstChild("MVP")
        if v27 and (v27:IsA("Sound") and v27.IsPlaying) then
            return
        elseif v_u_5.Get(v_u_9, "Settings.Audio.Other.Mute MVP Music when players on both teams are alive") ~= true or not v_u_25() then
            local v28 = (v_u_5.Get(v_u_9, "Settings.Audio.Music.MVP Volume") or 50) / 50
            v_u_14 = v_u_7.new("Round"):play({
                ["Parent"] = v26,
                ["Name"] = "MVP"
            }, v28)
            if v_u_14 then
                local v29 = (v_u_5.Get(v_u_9, "Settings.Audio.Audio.Master Volume") or 100) / 100
                local v30 = v_u_14.Volume
                if v28 > 0 and v29 > 0 then
                    v30 = v30 / (v28 * v29) or v30
                end
                v_u_14:SetAttribute("BaseVolume", v30)
                v_u_14.Destroying:Once(function()
                    if v_u_14 then
                        v_u_14 = nil
                    end
                end)
            end
        end
    else
        return
    end
end
local function v_u_41(p32, p33, p34)
    local v35 = p32:FindFirstChild("MVP")
    local v36 = v35 and v35:FindFirstChild("Text")
    if v36 then
        v36.Text = p33
    end
    local v37 = p32:FindFirstChild("Name")
    if v37 then
        v37.Text = p34
    end
    local v38 = p32:FindFirstChild("Player")
    if v38 then
        local v39 = v38:FindFirstChild("Player")
        local v40 = v39 and v_u_3:FindFirstChild(p34)
        if v40 then
            v39.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(v40.UserId)
        end
    end
end
function v1.Initialize(p42, p43)
    v_u_10 = p43
    v_u_11 = p42
    v_u_5.CreateListener(v_u_9, "Settings.Audio.Music.MVP Volume", v_u_17)
    v_u_5.CreateListener(v_u_9, "Settings.Audio.Audio.Master Volume", v_u_17)
    v_u_12 = v_u_11.Gameplay.Middle:FindFirstChild("PlayerMVPCT")
    v_u_13 = v_u_11.Gameplay.Middle:FindFirstChild("PlayerMVPT")
    v_u_4.ListenToState(function(p44, p45)
        if p44 == "Intermission" and p45 == "Buy Period" or p45 == "Round In Progress" then
            v_u_10.Visible = false
            if v_u_12 then
                v_u_12.Visible = false
            end
            if v_u_13 then
                v_u_13.Visible = false
            end
            local v46 = v_u_9:WaitForChild("PlayerGui"):FindFirstChild("MVP")
            if v46 and v46:IsA("Sound") then
                v46:Stop()
                v46:Destroy()
            end
            v_u_14 = nil
        end
    end)
    v_u_8.UI.RoundWinner.Listen(function(p47)
        local v48 = v_u_9:GetAttribute("Team")
        if p47 == "Terrorists" and v48 == p47 then
            v_u_10.Visible = true
        end
    end)
    v_u_8.UI.RoundMVP.Listen(function(p49)
        if p49 and (p49.Team and (p49.PlayerName and p49.Reason)) then
            local v50 = p49.Team
            local v51 = p49.PlayerName
            local v52 = p49.Reason
            if v50 == "Counter-Terrorists" or v50 == "Terrorists" then
                if v_u_3:FindFirstChild(v51) then
                    local v53 = v52 == "Rescued a hostage" and "MVP | Rescued a hostage" or (v52 == "Defused the bomb" and "MVP | Defused the bomb" or (v52 == "Planted the bomb" and "MVP | Planted the bomb" or (v52 == "Most eliminations" and "MVP | Most eliminations" or "MVP")))
                    if v50 == "Counter-Terrorists" and v_u_12 then
                        v_u_41(v_u_12, v53, v51)
                        v_u_12.Visible = true
                        if v_u_13 then
                            v_u_13.Visible = false
                        end
                        v_u_31()
                    elseif v50 == "Terrorists" and v_u_13 then
                        v_u_41(v_u_13, v53, v51)
                        v_u_13.Visible = true
                        if v_u_12 then
                            v_u_12.Visible = false
                        end
                        v_u_31()
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
end
return v1