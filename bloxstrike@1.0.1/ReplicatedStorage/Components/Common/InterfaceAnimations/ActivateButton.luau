local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v_u_4 = require(v1.Database.Security.Router)
return function(p_u_5)
    local v_u_6 = p_u_5.Size
    p_u_5.MouseEnter:Connect(function()
        v_u_4.broadcastRouter("RunInterfaceSound", "UI Highlight")
        local v7 = v_u_2
        local v8 = p_u_5
        local v9 = v_u_3
        local v10 = {}
        local v11 = v_u_6
        v10.Size = UDim2.new(v11.X.Scale * 0.95, v11.X.Offset, v11.Y.Scale * 0.95, v11.Y.Offset)
        v7:Create(v8, v9, v10):Play()
    end)
    p_u_5.MouseLeave:Connect(function()
        v_u_4.broadcastRouter("RunInterfaceSound", "UI Highlight")
        local v12 = v_u_2
        local v13 = p_u_5
        local v14 = v_u_3
        local v15 = {}
        local v16 = v_u_6
        v15.Size = UDim2.new(v16.X.Scale * 1, v16.X.Offset, v16.Y.Scale * 1, v16.Y.Offset)
        v12:Create(v13, v14, v15):Play()
    end)
    p_u_5.MouseButton1Down:Connect(function()
        v_u_4.broadcastRouter("RunInterfaceSound", "UI Click")
        local v17 = v_u_2
        local v18 = p_u_5
        local v19 = v_u_3
        local v20 = {}
        local v21 = v_u_6
        v20.Size = UDim2.new(v21.X.Scale * 0.9, v21.X.Offset, v21.Y.Scale * 0.9, v21.Y.Offset)
        v17:Create(v18, v19, v20):Play()
    end)
    p_u_5.MouseButton1Up:Connect(function()
        local v22 = v_u_2
        local v23 = p_u_5
        local v24 = v_u_3
        local v25 = {}
        local v26 = v_u_6
        v25.Size = UDim2.new(v26.X.Scale * 0.95, v26.X.Offset, v26.Y.Scale * 0.95, v26.Y.Offset)
        v22:Create(v23, v24, v25):Play()
    end)
end