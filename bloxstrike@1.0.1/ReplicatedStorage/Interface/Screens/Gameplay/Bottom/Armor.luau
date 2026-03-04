local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v4 = game:GetService("Players")
require(v2.Database.Custom.Types)
local v_u_5 = v4.LocalPlayer
local v_u_6 = require(v2.Components.Common.GetPreferenceColor)
local v_u_7 = require(v2.Controllers.DataController)
local v_u_8 = require(v2.Controllers.SpectateController)
local v_u_9 = require(v2.Database.Components.GameState)
local v_u_10 = require(v2.Packages.Observers)
local v11 = require(v2.Shared.Janitor)
local v_u_12 = nil
local v_u_13 = v11.new()
local function v_u_20(p_u_14)
    if typeof(p_u_14) ~= "string" or p_u_14 == "" then
        return nil
    end
    local v15, v16 = pcall(function()
        return v_u_3:JSONDecode(p_u_14)
    end)
    if not v15 or typeof(v16) ~= "table" then
        return nil
    end
    local v17 = {}
    local v18 = v16.Type or ""
    v17.Type = tostring(v18)
    local v19 = v16.Health
    v17.Health = tonumber(v19) or 0
    return v17
end
function v_u_1.updateFrame(p21)
    local v22 = v_u_6()
    v_u_12.Helmet.Visible = p21.Type == "Kevlar + Helmet"
    local v23 = v_u_12.Amount
    local v24 = p21.Health
    local v25 = math.round(v24)
    v23.Text = tostring(v25)
    v_u_12.Helmet.ImageColor3 = v22
    v_u_12.Amount.TextColor3 = v22
    v_u_12.Armor.ImageColor3 = v22
end
local function v_u_32(p26)
    v_u_13:Cleanup()
    v_u_13:Add(v_u_10.observeAttribute(p26, "Armor", function(p27)
        local v28 = v_u_20(p27)
        local v29
        if v28 == nil then
            v29 = false
        else
            v29 = v28.Health > 0
        end
        v_u_12.Visible = v29
        if v29 and v28 then
            v_u_1.updateFrame(v28)
        end
    end))
    local v30 = v_u_20((p26:GetAttribute("Armor")))
    local v31
    if v30 == nil then
        v31 = false
    else
        v31 = v30.Health > 0
    end
    v_u_12.Visible = v31
    if v31 and v30 then
        v_u_1.updateFrame(v30)
    end
end
function v_u_1.Initialize(_, p33)
    v_u_12 = p33
    if v_u_12.Active then
        v_u_12.Active = false
    end
    for _, v34 in ipairs(v_u_12:GetDescendants()) do
        if v34:IsA("GuiObject") then
            v34.Active = false
        end
    end
    v_u_5.CharacterAdded:Connect(function()
        v_u_32(v_u_5)
    end)
    v_u_7.CreateListener(v_u_5, "Settings.Game.HUD.Color", function()
        local v35 = v_u_20((v_u_5:GetAttribute("Armor")))
        if v35 and v35.Health > 0 then
            v_u_1.updateFrame(v35)
        end
    end)
end
function v_u_1.Start()
    v_u_5.CharacterAdded:Connect(function()
        local v36 = v_u_5
        v_u_13:Cleanup()
        v_u_32(v36)
    end)
    v_u_8.ListenToSpectate:Connect(function(p37)
        if p37 then
            v_u_13:Cleanup()
            v_u_32(p37)
        elseif not v_u_5:GetAttribute("IsSpectating") then
            local v38 = v_u_5
            v_u_13:Cleanup()
            v_u_32(v38)
        end
    end)
    v_u_5:GetAttributeChangedSignal("IsSpectating"):Connect(function()
        if v_u_5:GetAttribute("IsSpectating") then
            local v39 = v_u_8.GetPlayer()
            if v39 then
                v_u_13:Cleanup()
                v_u_32(v39)
            end
        else
            local v40 = v_u_5
            v_u_13:Cleanup()
            v_u_32(v40)
        end
    end)
    if v_u_5:GetAttribute("IsSpectating") then
        local v41 = v_u_8.GetPlayer()
        if v41 then
            v_u_13:Cleanup()
            v_u_32(v41)
        end
    else
        local v42 = v_u_5
        v_u_13:Cleanup()
        v_u_32(v42)
    end
    v_u_9.ListenToState(function(_, p43)
        if p43 == "Buy Period" or p43 == "Round In Progress" then
            local v44 = v_u_5
            v_u_13:Cleanup()
            v_u_32(v44)
        end
    end)
end
return v_u_1