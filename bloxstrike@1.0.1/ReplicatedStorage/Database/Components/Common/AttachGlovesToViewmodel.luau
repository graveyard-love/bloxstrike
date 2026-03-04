return function(p1, p2)
    local v3 = {}
    for _, v4 in ipairs(p1) do
        if v4:IsA("BasePart") then
            local v5 = p2:FindFirstChild(v4.Name)
            if v5 then
                local v6 = v4:FindFirstChild("Scales")
                local v7 = v4:FindFirstChild("Offsets")
                local v8 = v4:FindFirstChild("Rotations")
                if v6 then
                    v6 = v6:FindFirstChild("Camera")
                end
                if v7 then
                    v7 = v7:FindFirstChild("Camera")
                end
                if v8 then
                    v8 = v8:FindFirstChild("Camera")
                end
                if v6 then
                    v6 = v6.Value
                end
                local v9 = v7 and v7.Value or Vector3.new(0, 0, 0)
                local v10 = v8 and v8.Value or Vector3.new(0, 0, 0)
                local v11 = v10.X
                local v12 = math.rad(v11)
                local v13 = v10.Y
                local v14 = math.rad(v13)
                local v15 = v10.Z
                local v16 = math.rad(v15)
                local v17 = Vector3.new(v12, v14, v16)
                local v18 = v4:Clone()
                v18.CastShadow = false
                v18.CanCollide = false
                v18.CanTouch = false
                v18.Anchored = true
                v18.CanQuery = false
                v18.Name = "Glove"
                local v19 = v18:FindFirstChild("Scales")
                local v20 = v18:FindFirstChild("Offsets")
                local v21 = v18:FindFirstChild("Rotations")
                if v19 then
                    v19:Destroy()
                end
                if v20 then
                    v20:Destroy()
                end
                if v21 then
                    v21:Destroy()
                end
                local v22 = v5.Size.X * (v6 and (v6.X or 1) or 1)
                local v23 = v5.Size.Y * (v6 and (v6.Y or 1) or 1)
                local v24 = v5.Size.Z * (v6 and v6.Z or 1)
                v18.Size = Vector3.new(v22, v23, v24)
                local v25 = v5.Size.Z / 2 - v18.Size.Z / 2
                local v26 = CFrame.new(v9) * CFrame.new(0, 0, -v25 * 1.035) * v18.PivotOffset * CFrame.Angles(v17.X, v17.Y, v17.Z)
                v18.Parent = v5
                local v27 = Instance.new("WeldConstraint", v18)
                v27.Part0 = v5
                v27.Part1 = v18
                v18.CFrame = v5.CFrame * v26
                v18.Anchored = false
                table.insert(v3, v18)
            end
        end
    end
    return v3
end