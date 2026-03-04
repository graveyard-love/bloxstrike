local v_u_1 = game:GetService("Players").LocalPlayer
local v_u_2 = workspace.CurrentCamera
local v_u_3 = workspace:WaitForChild("Debris")
return function()
    local v4 = {}
    local v5 = v_u_3
    table.insert(v4, v5)
    local v6 = v_u_2
    table.insert(v4, v6)
    local v7 = workspace:FindFirstChild("Map")
    if v7 then
        local v8 = v7:FindFirstChild("Cameras")
        local v9 = v7:FindFirstChild("Barriers")
        local v10 = v7:FindFirstChild("Ambience")
        if v8 then
            table.insert(v4, v8)
        end
        if v9 then
            table.insert(v4, v9)
        end
        if v10 then
            table.insert(v4, v10)
        end
        local v11 = v7:FindFirstChild("Zones")
        if v11 then
            local v12 = v11:FindFirstChild("Spawns")
            local v13 = v11:FindFirstChild("Sites")
            if v12 then
                table.insert(v4, v12)
            end
            if v13 then
                table.insert(v4, v13)
            end
        end
    end
    if v_u_1 and (v_u_1.Character and v_u_1.Character:IsDescendantOf(workspace)) then
        local v14 = v_u_1.Character
        table.insert(v4, v14)
    end
    return v4
end