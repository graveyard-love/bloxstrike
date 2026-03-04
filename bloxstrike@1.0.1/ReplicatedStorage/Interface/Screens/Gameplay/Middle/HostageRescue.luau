local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v_u_5 = require(v_u_2.Database.Components.GameState)
local v_u_6 = v4.LocalPlayer
local v_u_7 = require(v_u_2.Controllers.DataController)
local v_u_8 = require(v_u_2.Packages.Observers)
local v_u_9 = require(v_u_2.Shared.Janitor)
local v_u_10 = {}
local v_u_11 = nil
local function v_u_14(p12)
    for _, v13 in ipairs(p12:GetChildren()) do
        if v_u_10[v13] then
            v_u_10[v13]:Destroy()
            v_u_10[v13] = nil
        end
    end
end
local function v_u_18()
    local v15 = {}
    for _, v16 in ipairs(v_u_11:GetChildren()) do
        if v16:IsA("Frame") then
            table.insert(v15, v16)
        end
    end
    for _, v17 in ipairs(v15) do
        v17.Size = UDim2.fromScale(1 / #v15, 1)
    end
end
function v_u_1.CreateTemplate(_)
    local v19 = v_u_2.Assets.UI.HostageRescue.Template:Clone()
    v19.Parent = v_u_11
    v_u_18()
    return v19
end
function v_u_1.Initialize(_, p20)
    v_u_11 = p20
    v_u_7.CreateListener(v_u_6, "Settings.Game.Radar/Tablet.Radar Hud Size", function(p21)
        if v_u_11 then
            local v22 = 240 - (200 - p21 * 200) + 50
            v_u_11.Position = UDim2.new(0.029, 0, 0, v22)
        end
    end)
    local v23 = v_u_7.Get(v_u_6, "Settings.Game.Radar/Tablet.Radar Hud Size") or 1
    if v_u_11 then
        local v24 = 240 - (200 - v23 * 200) + 50
        v_u_11.Position = UDim2.new(0.029, 0, 0, v24)
    end
    v_u_3.Heartbeat:Connect(function()
        v_u_11.Visible = workspace:GetAttribute("Gamemode") == "Hostage Rescue"
    end)
    v_u_5.ListenToState(function(_, p25)
        if p25 == "Buy Period" or p25 == "Warmup" then
            v_u_14(v_u_11)
        end
    end)
    v_u_8.observeTag("Hostage", function(p_u_26)
        local v27 = v_u_9.new()
        v27:Add(v_u_18)
        local v_u_28 = v27:Add(v_u_1.CreateTemplate(p_u_26))
        v_u_10[v_u_28] = v27
        local v29 = p_u_26:GetAttribute("State") or "Idle"
        v_u_28.Idle.Visible = v29 ~= "Carrying"
        v_u_28.Action.Visible = v29 == "Carrying"
        v27:Add(p_u_26:GetAttributeChangedSignal("State"):Connect(function()
            local v30 = v_u_28
            local v31 = p_u_26:GetAttribute("State") or "Idle"
            v30.Idle.Visible = v31 ~= "Carrying"
            v30.Action.Visible = v31 == "Carrying"
        end))
        return function()
            if v_u_10[v_u_28] then
                v_u_10[v_u_28]:Destroy()
                v_u_10[v_u_28] = nil
            end
        end
    end)
end
return v_u_1