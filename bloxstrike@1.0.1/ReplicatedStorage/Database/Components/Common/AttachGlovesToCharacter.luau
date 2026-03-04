local v_u_1 = game:GetService("RunService")
local v_u_2 = CFrame.Angles(-1.5707963267948966, 0, 0)
local v_u_3 = {
    ["Right Arm"] = "RightGlove",
    ["Left Arm"] = "LeftGlove"
}
local v_u_4 = {
    ["Right Arm"] = "RightHand",
    ["Left Arm"] = "LeftHand"
}
local function v_u_21(p5, p6, p7, p8, p9)
    if p7 then
        p7 = p7:FindFirstChild("Character")
    end
    if p8 then
        p8 = p8:FindFirstChild("Character")
    end
    if p9 then
        p9 = p9:FindFirstChild("Character")
    end
    local v10 = p7 and p7.Value or Vector3.new(1, 1, 1)
    local v11 = p8 and p8.Value or Vector3.new(0, 0, -0.025)
    local v12 = p9 and p9.Value or Vector3.new(0, 0, 0)
    local v13 = v12.X
    local v14 = math.rad(v13)
    local v15 = v12.Y
    local v16 = math.rad(v15)
    local v17 = v12.Z
    local v18 = math.rad(v17)
    local v19 = Vector3.new(v14, v16, v18)
    local v20 = v_u_2 * CFrame.Angles(v19.X, v19.Y, v19.Z)
    p5.Size = v10
    p6.C0 = CFrame.new(v11)
    p6.C1 = p5.PivotOffset * v20
end
return function(p22, p23, p24, p25)
    local v26 = {}
    for _, v27 in ipairs(p22) do
        if v27:IsA("BasePart") then
            local v28 = v_u_4[v27.Name]
            if v28 then
                local v29 = p23:FindFirstChild(v28)
                if v29 then
                    local v_u_30 = v27:Clone()
                    v_u_30.Name = v_u_3[v27.Name]
                    v_u_30.CastShadow = false
                    v_u_30.CanCollide = false
                    v_u_30.CanTouch = false
                    v_u_30.Anchored = false
                    v_u_30.CanQuery = false
                    if p25 and p25.collisionGroup then
                        v_u_30.CollisionGroup = p25.collisionGroup
                    end
                    local v_u_31 = v_u_30:FindFirstChild("Rotations")
                    local v_u_32 = v_u_30:FindFirstChild("Offsets")
                    local v_u_33 = v_u_30:FindFirstChild("Scales")
                    local v_u_34 = Instance.new("Motor6D")
                    v_u_34.Name = "GloveAttachment"
                    v_u_34.Part0 = v29
                    v_u_34.Part1 = v_u_30
                    v_u_34.Parent = v_u_30
                    v_u_30.Parent = p24
                    v_u_21(v_u_30, v_u_34, v_u_33, v_u_32, v_u_31)
                    if v_u_1:IsStudio() then
                        local v35 = ipairs
                        local v36 = {}
                        local v37
                        if v_u_33 then
                            v37 = v_u_33:FindFirstChild("Character")
                        else
                            v37 = v_u_33
                        end
                        local v38
                        if v_u_32 then
                            v38 = v_u_32:FindFirstChild("Character")
                        else
                            v38 = v_u_32
                        end
                        local v39
                        if v_u_31 then
                            v39 = v_u_31:FindFirstChild("Character")
                        else
                            v39 = v_u_31
                        end
                        __set_list(v36, 1, {v37, v38, v39})
                        for _, v40 in v35(v36) do
                            if v40 then
                                v40:GetPropertyChangedSignal("Value"):Connect(function()
                                    v_u_21(v_u_30, v_u_34, v_u_33, v_u_32, v_u_31)
                                end)
                            end
                        end
                    else
                        local v41 = ipairs
                        local v42 = {}
                        if v_u_33 then
                            v_u_33 = v_u_33:FindFirstChild("Character")
                        end
                        if v_u_32 then
                            v_u_32 = v_u_32:FindFirstChild("Character")
                        end
                        if v_u_31 then
                            v_u_31 = v_u_31:FindFirstChild("Character")
                        end
                        __set_list(v42, 1, {v_u_33, v_u_32, v_u_31})
                        for _, v43 in v41(v42) do
                            if v43 then
                                v43:Destroy()
                            end
                        end
                    end
                    table.insert(v26, v_u_30)
                end
            end
        end
    end
    return v26
end