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
local function v_u_27(p18, p19, p20)
    local v21 = p18:FindFirstChild("MVP")
    local v22 = v21 and v21:FindFirstChild("Text")
    if v22 then
        v22.Text = p19
    end
    local v23 = p18:FindFirstChild("Name")
    if v23 then
        v23.Text = p20
    end
    local v24 = p18:FindFirstChild("Player")
    if v24 then
        local v25 = v24:FindFirstChild("Player")
        local v26 = v25 and v_u_3:FindFirstChild(p20)
        if v26 then
            v25.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(v26.UserId)
        end
    end
end
local function v_u_35()
    local v28 = 0
    local v29 = 0
    for _, v30 in ipairs(v_u_3:GetPlayers()) do
        local v31 = v30:GetAttribute("Team")
        if v31 == "Counter-Terrorists" or v31 == "Terrorists" then
            local v32 = v30.Character
            if v32 and (v32:IsDescendantOf(workspace) and not v32:GetAttribute("Dead")) then
                local v33 = v32:FindFirstChildOfClass("Humanoid")
                if v33 and (v33.Health > 0 and not v30:GetAttribute("IsSpectating")) then
                    if v31 == "Counter-Terrorists" then
                        v29 = v29 + 1
                    elseif v31 == "Terrorists" then
                        v28 = v28 + 1
                    end
                end
            end
        end
    end
    local v34
    if v29 > 0 then
        v34 = v28 > 0
    else
        v34 = false
    end
    return v34
end
local function v_u_41()
    if v_u_6.GetCurrentScreen() == nil then
        local v36 = v_u_9:WaitForChild("PlayerGui")
        local v37 = v36:FindFirstChild("MVP")
        if v37 and (v37:IsA("Sound") and v37.IsPlaying) then
            return
        elseif v_u_5.Get(v_u_9, "Settings.Audio.Other.Mute MVP Music when players on both teams are alive") ~= true or not v_u_35() then
            local v38 = (v_u_5.Get(v_u_9, "Settings.Audio.Music.MVP Volume") or 50) / 50
            v_u_14 = v_u_7.new("Round"):play({
                ["Parent"] = v36,
                ["Name"] = "MVP"
            }, v38)
            if v_u_14 then
                local v39 = (v_u_5.Get(v_u_9, "Settings.Audio.Audio.Master Volume") or 100) / 100
                local v40 = v_u_14.Volume
                if v38 > 0 and v39 > 0 then
                    v40 = v40 / (v38 * v39) or v40
                end
                v_u_14:SetAttribute("BaseVolume", v40)
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
function v1.Initialize(p42, p43)
    v_u_10 = p43
    v_u_11 = p42
    v_u_5.CreateListener(v_u_9, "Settings.Audio.Audio.Master Volume", v_u_17)
    v_u_5.CreateListener(v_u_9, "Settings.Audio.Music.MVP Volume", v_u_17)
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
        if p47 == "Counter-Terrorists" and v48 == p47 then
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
                        v_u_27(v_u_12, v53, v51)
                        v_u_12.Visible = true
                        if v_u_13 then
                            v_u_13.Visible = false
                        end
                        v_u_41()
                    elseif v50 == "Terrorists" and v_u_13 then
                        v_u_27(v_u_13, v53, v51)
                        v_u_13.Visible = true
                        if v_u_12 then
                            v_u_12.Visible = false
                        end
                        v_u_41()
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