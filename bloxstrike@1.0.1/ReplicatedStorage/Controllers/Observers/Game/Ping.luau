local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("HttpService")
local v3 = game:GetService("Players")
require(script.Types)
local v_u_4 = v3.LocalPlayer
local v_u_5 = require(v1.Controllers.SpectateController)
local v_u_6 = require(v1.Controllers.DataController)
local v7 = require(v1.Packages.Observers)
local v_u_8 = require(script.Class)
local v_u_9 = {}
v_u_4.CharacterAdded:Connect(function(_)
    for _, v10 in pairs(v_u_9) do
        v10:UpdateVisibility(nil)
    end
end)
v_u_5.ListenToSpectate:Connect(function(p11)
    if p11 then
        p11 = p11:GetAttribute("Team")
    end
    for _, v12 in pairs(v_u_9) do
        v12:UpdateVisibility(p11)
    end
end)
return v7.observeTag("PlayerPositionMarker", function(p13)
    if v_u_6.Get(v_u_4, "Settings.Game.HUD.Player Pings") == "Disabled" then
        return nil
    end
    if not p13:IsDescendantOf(workspace) then
        return nil
    end
    local v_u_14 = v_u_2:GenerateGUID(false)
    local v15 = v_u_8.new
    local v16 = v_u_5.GetPlayer()
    local v17
    if v16 and v16 ~= v_u_4 then
        v17 = v16:GetAttribute("Team")
    else
        v17 = nil
    end
    local v_u_18 = v15(p13, v_u_14, v17)
    v_u_9[v_u_14] = v_u_18
    return function()
        v_u_9[v_u_14] = nil
        v_u_18:Destroy()
    end
end)