local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players").LocalPlayer
local v_u_5 = require(v2.Controllers.DataController)
local v6 = require(v2.Components.Common.GetUserPlatform)
local v_u_7 = require(v2.Database.Custom.Constants)
local v_u_8 = require(v2.Packages.Observers)
local v_u_9 = table.find(v6(), "Mobile") ~= nil
local v_u_10 = os.clock()
local v_u_11 = 0
local v_u_12 = 0
local v_u_13 = false
local v_u_14 = false
local v_u_15 = {}
local v_u_16 = nil
local function v_u_25(_, p17)
    local v18 = {}
    if v_u_14 then
        local v19
        if #v_u_15 > 0 then
            local v20 = 0
            for _, v21 in ipairs(v_u_15) do
                v20 = v20 + v21
            end
            local v22 = v20 / #v_u_15
            v19 = math.round(v22)
        else
            v19 = v_u_12
        end
        local v23 = ("Fps: %*"):format((tostring(v19)))
        table.insert(v18, v23)
    end
    if v_u_13 then
        local v24 = ("Ping: %*ms"):format(p17)
        table.insert(v18, v24)
    end
    v_u_16.Player.Text = table.concat(v18, ", ")
    v_u_16.Player.Visible = #v18 > 0
end
function v1.Initialize(_, p26)
    v_u_16 = p26
    if v_u_9 then
        v_u_16.Visible = false
        v_u_16:GetPropertyChangedSignal("Visible"):Connect(function()
            if v_u_16.Visible then
                v_u_16.Visible = false
            end
        end)
    else
        v_u_13 = v_u_5.Get(v_u_4, "Settings.Game.Other.Show Ping") == true
        v_u_14 = v_u_5.Get(v_u_4, "Settings.Game.Other.Show FPS") == true
        v_u_16.Server.Text = ("Location: Unknown, Version: %*"):format(v_u_7.VERSION)
        v_u_5.CreateListener(v_u_4, "Settings.Game.Other.Show FPS", function(p27)
            v_u_14 = p27 == true
            if v_u_16.Visible then
                v_u_25(v_u_12, v_u_11)
            end
        end)
        v_u_5.CreateListener(v_u_4, "Settings.Game.Other.Show Ping", function(p28)
            v_u_13 = p28 == true
            if v_u_16.Visible then
                v_u_25(v_u_12, v_u_11)
            end
        end)
        v_u_3.Heartbeat:Connect(function(p29)
            if v_u_16.Visible then
                local v30 = v_u_4:GetAttribute("Ping")
                local v31 = tonumber(v30) or 999
                local v32 = 1 / p29
                local v33 = math.round(v32)
                local v34 = os.clock()
                local v35 = v_u_15
                table.insert(v35, v33)
                v_u_11 = v31
                v_u_12 = v33
                if v34 - v_u_10 >= 1 then
                    v_u_10 = v34
                    v_u_25(v33, v31)
                    table.clear(v_u_15)
                end
            end
        end)
        v_u_8.observeAttribute(workspace, "Timezone", function(p36)
            v_u_16.Server.Text = ("Location: %*, Version: %*"):format(p36, v_u_7.VERSION)
            return function()
                v_u_16.Server.Text = ("Location: Unknown, Version: %*"):format(v_u_7.VERSION)
            end
        end)
    end
end
return v1