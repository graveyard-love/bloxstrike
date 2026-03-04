local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = tick()
local v_u_6 = require(v2.Components.Common.GetUserPlatform)
local v_u_7 = require(v2.Database.Security.Remotes)
local function v_u_9(_)
    debug.profilebegin("PlayerController.HandleNextFrame")
    local v8 = tick()
    v_u_7.Player.BlankRequest.Send(v8)
    if v8 - v_u_5 >= 900 then
        v_u_7.Player.AFKTeleport.Send()
        v_u_5 = v8
        debug.profileend()
    else
        debug.profileend()
    end
end
function v1.Initialize()
    v_u_3.InputBegan:Connect(function()
        v_u_5 = tick()
    end)
    v_u_3.InputChanged:Connect(function()
        v_u_5 = tick()
    end)
    v_u_7.Player.BlankRequest.Listen(function(p10)
        local v11 = v_u_7.Player.ReportPlayerConnect.Send
        local v12 = (tick() - p10) * 1000
        local v13 = math.floor(v12)
        v11((tostring(v13)))
    end)
end
function v1.Start()
    local v_u_14 = 0
    task.delay(5, function()
        local v15 = v_u_6()
        if v15 and #v15 > 0 then
            local v16 = v15[1]
            v_u_7.Player.SubmitUserPlatformAnalytics.Send(v16)
        end
    end)
    v_u_4.Heartbeat:Connect(function(p17)
        v_u_14 = v_u_14 + p17
        if v_u_14 >= 5 then
            v_u_14 = v_u_14 - 5
            v_u_9(p17)
        end
    end)
end
return v1