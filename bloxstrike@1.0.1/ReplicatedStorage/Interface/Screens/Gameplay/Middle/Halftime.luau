local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
require(script:WaitForChild("Types"))
local v_u_3 = require(v2.Database.Components.GameState)
local v_u_4 = nil
local v_u_5 = 0
local function v_u_16(p6, p7)
    local v8 = p7 == "Counter-Terrorists"
    local v9 = not v8
    local v10 = false
    local v11 = p6:FindFirstChild("CT")
    local v12
    if v11 and v11:IsA("GuiObject") then
        v11.Visible = v8
        v10 = true
        v12 = v10
    else
        v12 = v10
    end
    local v13 = p6:FindFirstChild("T")
    if v13 and v13:IsA("GuiObject") then
        v13.Visible = v9
        v10 = true
        v12 = v10
    end
    local v14 = p6:FindFirstChild("PlayingCT")
    if v14 and v14:IsA("GuiObject") then
        v14.Visible = v8
        v10 = true
        v12 = v10
    end
    local v15 = p6:FindFirstChild("PlayingT")
    if v15 and v15:IsA("GuiObject") then
        v15.Visible = v9
        v10 = true
        v12 = v10
    end
    return v12
end
local function v_u_27(p17, p18)
    local v19 = (p17 == "Counter-Terrorists" or p17 == "CT") and "Counter-Terrorists" or ((p17 == "Terrorists" or p17 == "T") and "Terrorists" or nil)
    if not v19 then
        warn(("[Halftime] Unsupported NextTeam value: %s"):format((tostring(p17))))
        v_u_5 = v_u_5 + 1
        v_u_4.Visible = false
        return false
    end
    local v20 = v19 == "Counter-Terrorists" and "Playing as Counter-Terrorists" or (v19 == "Terrorists" and "Playing as Terrorists" or nil)
    if not v20 then
        warn(("[Halftime] Unsupported NextTeam value: %s"):format((tostring(p17))))
        v_u_5 = v_u_5 + 1
        v_u_4.Visible = false
        return false
    end
    local v21
    if v_u_4 then
        local v22 = v_u_4:FindFirstChild("Title")
        if v22 then
            v21 = v22:FindFirstChild("Header") or nil
        else
            v21 = nil
        end
    else
        v21 = nil
    end
    if not v21 then
        warn("[Halftime] Missing Title.Header")
        v_u_5 = v_u_5 + 1
        v_u_4.Visible = false
        return false
    end
    local v23 = v21:FindFirstChild("Context")
    if not (v23 and v23:IsA("TextLabel")) then
        v23 = nil
    end
    if not (v_u_16(v21, v19) or v23) then
        warn("[Halftime] Missing Title.Header CT/T + PlayingCT/PlayingT visuals and Context TextLabel")
        v_u_5 = v_u_5 + 1
        v_u_4.Visible = false
        return false
    end
    if v23 then
        v23.Text = v20
    end
    v_u_5 = v_u_5 + 1
    local v_u_24 = v_u_5
    v_u_4.Visible = true
    if p18 ~= nil then
        local v25 = tonumber(p18) or 0
        local v26 = math.max(v25, 0)
        task.delay(v26, function()
            if v_u_24 == v_u_5 then
                v_u_4.Visible = false
            end
        end)
    end
    return true
end
function v1.Show(p28, p29)
    if v_u_4 then
        return v_u_27(p28, p29)
    end
    warn("[Halftime] Frame is not initialized")
    return false
end
function v1.Hide()
    if v_u_4 then
        v_u_5 = v_u_5 + 1
        v_u_4.Visible = false
    end
end
function v1.Initialize(_, p30)
    v_u_4 = p30
    v_u_4.Visible = false
    v_u_3.ListenToState(function(_, p31)
        if p31 == "Buy Period" or p31 == "Round In Progress" then
            v_u_5 = v_u_5 + 1
            v_u_4.Visible = false
        end
    end)
end
return v1