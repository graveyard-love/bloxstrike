local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_4 = require(v2.Database.Components.GameState)
local v_u_5 = require(v2.Database.Security.Remotes)
local v_u_6 = v3.LocalPlayer
local v_u_7 = nil
function v1.Initialize(_, p8)
    v_u_7 = p8
    v_u_4.ListenToState(function(p9, p10)
        if p9 == "Intermission" and p10 == "Buy Period" then
            v_u_7.Visible = false
            return
        elseif p10 == "Round In Progress" then
            v_u_7.Visible = false
        end
    end)
    v_u_5.UI.RoundWinner.Listen(function(p11)
        if v_u_6:GetAttribute("Team") ~= p11 then
            v_u_7.Visible = true
        end
    end)
end
return v1