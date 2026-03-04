local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = require(v1.Packages.Observers)
local v_u_4 = require(v1.Shared.Janitor)
local function v_u_25(p5, p6, p7, p8)
    p7[1] = p7[1] + p6
    local v9 = p5.Handle
    if v9 and v9:IsDescendantOf(workspace) then
        if not p8[1] then
            p8[1] = v9.CFrame
        end
        local v10 = p8[1]
        local v11 = p7[1]
        local v12 = v11 * 0.8
        local v13 = math.sin(v12) * 0.05235987755982989
        local v14 = v11 * 0.8 * 0.7
        local v15 = math.cos(v14) * 0.05235987755982989 * 0.8
        local v16 = v11 * 0.5
        local v17 = math.sin(v16) * 0.15
        local v18 = v11 * 1.2
        local v19 = math.sin(v18) * 0.1
        local v20 = v10.LookVector * v17 + Vector3.new(0, v19, 0)
        local v21 = v10.Position + v20
        local v22 = CFrame.Angles(v13, 0, 0)
        local v23 = CFrame.Angles(0, 0, v15)
        local v24 = v10 * v22 * v23
        v9.CFrame = v24 + (v21 - v24.Position)
    end
end
return v3.observeTag("TugBoat", function(p_u_26)
    if p_u_26:IsDescendantOf(workspace) then
        local v_u_27 = v_u_4.new()
        local v_u_28 = { nil }
        local v_u_29 = { 0 }
        v_u_27:Add(v_u_2.Heartbeat:Connect(function(p30)
            v_u_25(p_u_26, p30, v_u_29, v_u_28)
        end))
        return function()
            v_u_27:Destroy()
        end
    end
end)