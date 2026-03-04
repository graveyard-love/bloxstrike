local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(v1.Database.Custom.Types)
local v_u_3 = v2.LocalPlayer
local v_u_4 = require(v1.Controllers.DataController)
local v_u_5 = require(v1.Database.Custom.GameStats.Settings.Colors)
local v_u_6 = v_u_5["Team Color"]["Counter-Terrorists"]
return function()
    local v7 = v_u_4.Get(v_u_3, "Settings.Game.HUD.Color")
    local v8 = v_u_3:GetAttribute("Team")
    return v_u_5[v7] and v_u_5[v7][v8] or v_u_6
end