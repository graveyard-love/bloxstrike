local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Players")
require(v_u_2.Database.Custom.Types)
local v_u_4 = require(v_u_2.Database.Custom.GameStats.Settings.Votekick)
local v_u_5 = v_u_3.LocalPlayer
local v_u_6 = require(v_u_2.Components.Common.InterfaceAnimations.ActivateButton)
local v_u_7 = require(v_u_2.Controllers.DataController)
local v_u_8 = require(v_u_2.Shared.CloseButtonRegistry)
local v_u_9 = require(v_u_2.Database.Security.Remotes)
local v_u_10 = require(v_u_2.Database.Security.Router)
local v_u_11 = require(v_u_2.Interface.Screens.Gameplay.Middle.TeamSelection)
local v_u_12 = nil
local v_u_13 = nil
local function v_u_17(p14)
    local v15 = p14:GetChildren()
    for _, v16 in ipairs(v15) do
        if v16:IsA("Frame") then
            v16:Destroy()
        end
    end
end
local function v_u_21(p18)
    if v_u_5 == p18 then
        return false
    else
        local v19 = v_u_4.GetActiveTeam(v_u_5:GetAttribute("Team"))
        local v20 = v_u_4.GetActiveTeam(p18:GetAttribute("Team"))
        if v19 and v20 then
            return v_u_4.IsFreeForAllGamemode(workspace:GetAttribute("ServerGamemode")) and true or v20 == v19
        else
            return false
        end
    end
end
function v_u_1.PlayerAdded(p_u_22)
    if v_u_21(p_u_22) then
        local v23 = v_u_13.Menu.VoteKick.Container
        local v24 = p_u_22.UserId
        if not v23:FindFirstChild((tostring(v24))) then
            local v25 = v_u_2.Assets.UI.VoteKick.PlayerTemplate:Clone()
            v25.Player.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(p_u_22.UserId)
            v25.Player.Username.Text = p_u_22.DisplayName .. " (@" .. p_u_22.Name .. ")"
            v25.Parent = v_u_13.Menu.VoteKick.Container
            local v26 = p_u_22.UserId
            v25.Name = tostring(v26)
            v25.Button.MouseButton1Click:Connect(function()
                v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
                local v27 = v_u_9.VoteKick.CallVote.Send
                local v28 = p_u_22.UserId
                v27((tostring(v28)))
                v_u_13.Menu.VoteKick.Visible = false
            end)
        end
    end
end
function v_u_1.RefreshVoteKickEntries()
    v_u_17(v_u_13.Menu.VoteKick.Container)
    for _, v29 in ipairs(v_u_3:GetPlayers()) do
        v_u_1.PlayerAdded(v29)
    end
end
function v_u_1.OpenChooseTeam()
    local v30 = v_u_5:GetAttribute("IsSpectating")
    local v31 = v_u_5:GetAttribute("Team")
    if (v31 == "Counter-Terrorists" or v31 == "Terrorists") and true or v30 == true then
        if v30 then
            v_u_11.openFrame()
            return
        elseif v_u_5.Character then
            v_u_11.ToggleTeamSelection()
        end
    else
        return
    end
end
function v_u_1.Initialize(p32, p33)
    v_u_13 = p32
    v_u_12 = p33
    v_u_1.RefreshVoteKickEntries()
    v_u_3.PlayerAdded:Connect(function(p34)
        v_u_1.PlayerAdded(p34)
    end)
    v_u_3.PlayerRemoving:Connect(function(p35)
        local v36 = v_u_13.Menu.VoteKick.Container
        local v37 = p35.UserId
        local v38 = v36:FindFirstChild((tostring(v37)))
        if v38 then
            v38:Destroy()
        end
    end)
end
function v_u_1.Start()
    v_u_6(v_u_13.Menu.VoteKick.Close)
    v_u_8.Add(v_u_13.Menu.VoteKick, v_u_13.Menu.VoteKick.Close, function()
        v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_13.Menu.VoteKick.Visible = false
    end)
    v_u_12.Container.ChooseTeam.MouseButton1Click:Connect(function()
        v_u_1.OpenChooseTeam()
    end)
    v_u_12.Container.VoteKick.MouseButton1Click:Connect(function()
        local v39 = v_u_7.Get(v_u_5, "Level")
        local v40 = v_u_5:GetAttribute("IsSpectating") == true
        local v41 = v_u_5:GetAttribute("Team")
        v_u_10.broadcastRouter("RunInterfaceSound", "UI Click")
        if v40 and (not v41 or v41 == "Spectators") then
            v_u_10.broadcastRouter("CreateMenuNotification", "Error", "You cannot vote kick while spectating as a spectator.")
            return
        elseif v39.Level >= 3 then
            v_u_1.RefreshVoteKickEntries()
            v_u_13.Menu.VoteKick.Visible = true
        else
            v_u_10.broadcastRouter("CreateMenuNotification", "Error", "You need to be level 3 to vote kick players.")
        end
    end)
end
return v_u_1