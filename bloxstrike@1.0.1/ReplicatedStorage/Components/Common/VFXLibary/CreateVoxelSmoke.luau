game:GetService("Lighting")
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("Workspace")
local v_u_4 = v1:WaitForChild("Assets"):WaitForChild("GrenadeParticles"):WaitForChild("Smoke")
local v_u_5 = {
    ["Terrorists"] = Color3.fromRGB(185, 170, 145),
    ["Counter-Terrorists"] = Color3.fromRGB(155, 170, 190)
}
local _ = {
    ["Color"] = Color3.new(1, 1, 1),
    ["Decay"] = Color3.new(1, 1, 1),
    ["Density"] = 1,
    ["Glare"] = 1,
    ["Haze"] = 2.5
}
local v_u_6 = {}
local v_u_7 = {}
local v_u_8 = nil
local function v_u_25(p9, p10, p11, p12)
    local v13 = v_u_4:Clone()
    v13.Name = "SmokeVoxel"
    v13.Size = Vector3.new(p10, p10, p10)
    v13.Position = p9
    v13.Anchored = true
    v13.CanCollide = false
    v13.CanQuery = false
    v13.CanTouch = false
    v13.CastShadow = false
    v13.Parent = p11
    local v14 = p10 / 4
    local v15 = {}
    for _, v16 in ipairs(v13:GetDescendants()) do
        if v16:IsA("ParticleEmitter") then
            local v17 = v16.Size.Keypoints
            local v18 = {}
            for _, v19 in ipairs(v17) do
                local v20 = NumberSequenceKeypoint.new
                local v21 = v19.Time
                local v22 = v19.Value * v14
                local v23 = v19.Envelope * v14
                table.insert(v18, v20(v21, v22, v23))
            end
            v16.Size = NumberSequence.new(v18)
            if p12 then
                v16.Color = ColorSequence.new(p12)
            end
            v16.Enabled = false
            table.insert(v15, v16)
        end
    end
    for _, v24 in ipairs(v13:GetChildren()) do
        if v24:IsA("BillboardGui") then
            v24:Destroy()
        end
    end
    v_u_7[v13] = {
        ["voxel"] = v13,
        ["emitters"] = v15,
        ["emitConnection"] = nil,
        ["isActive"] = false,
        ["lastEmitTime"] = 0,
        ["scaleFactor"] = v14,
        ["teamColor"] = p12,
        ["lifetimeExtended"] = false,
        ["activatedTime"] = 0,
        ["emissionStopped"] = false,
        ["totalParticlesEmitted"] = 0
    }
    return v13
end
local function v_u_46(p26, p27)
    local v28 = p26:GetChildren()
    if #v28 == 0 then
        return
    else
        local v29 = Vector3.new(0, 0, 0)
        local v30 = {}
        for _, v31 in ipairs(v28) do
            if v31:IsA("BasePart") then
                v29 = v29 + v31.Position
                table.insert(v30, v31)
            end
        end
        if #v30 ~= 0 then
            local v32 = v29 / #v30
            local v33 = 0
            for _, v34 in ipairs(v30) do
                local v35 = (v34.Position - v32).Magnitude
                if v33 < v35 then
                    v33 = v35
                end
            end
            local v36 = v33 == 0 and 1 or v33
            if not v_u_8 then
                v_u_8 = v_u_2.Heartbeat:Connect(function()
                    local v37 = tick()
                    for _, v38 in pairs(v_u_7) do
                        if v38.voxel and (v38.voxel.Parent and (v38.isActive and not v38.emissionStopped)) then
                            if not v38.lifetimeExtended then
                                v38.lifetimeExtended = true
                                v38.activatedTime = v37
                                for _, v39 in ipairs(v38.emitters) do
                                    if v39 and v39.Parent then
                                        v39.Lifetime = NumberRange.new((1 / 0))
                                    end
                                end
                            end
                            local v40 = v37 - v38.activatedTime
                            if v40 >= 0.8 then
                                v38.emissionStopped = true
                            elseif 0.1 + 0.30000000000000004 * (v40 / 0.8) <= v37 - v38.lastEmitTime then
                                v38.lastEmitTime = v37
                                local v41 = #v38.emitters * 1
                                v38.totalParticlesEmitted = v38.totalParticlesEmitted + v41
                                for _, v42 in ipairs(v38.emitters) do
                                    if v42 and v42.Parent then
                                        v42:Emit(1)
                                    end
                                end
                            end
                        end
                    end
                end)
            end
            for _, v_u_43 in ipairs(v30) do
                local v44 = (v_u_43.Position - v32).Magnitude / v36 * p27
                task.delay(v44, function()
                    if v_u_43.Parent then
                        local v45 = v_u_7[v_u_43]
                        if v45 then
                            v45.isActive = true
                        end
                    end
                end)
            end
        end
    end
end
local function v_u_56(p_u_47)
    local v_u_48 = p_u_47:GetChildren()
    local v49 = 0
    local v50 = 0
    for _, v51 in ipairs(v_u_48) do
        if v51:IsA("BasePart") then
            local v52 = v_u_7[v51]
            if v52 then
                v49 = v49 + v52.totalParticlesEmitted
                v50 = v50 + 1
                v52.isActive = false
                for _, v53 in ipairs(v52.emitters) do
                    if v53 and v53.Parent then
                        v53.Enabled = false
                    end
                end
            end
        end
    end
    print("[VoxelSmoke] Smoke fading out. Total particles emitted:", v49, "across", v50, "voxels")
    task.delay(6, function()
        for _, v54 in ipairs(v_u_48) do
            if v54:IsA("BasePart") then
                v_u_7[v54] = nil
                v54:Destroy()
            end
        end
        local v55 = false
        for _, _ in pairs(v_u_7) do
            v55 = true
            break
        end
        if not v55 and v_u_8 then
            v_u_8:Disconnect()
            v_u_8 = nil
        end
        if p_u_47 and p_u_47.Parent then
            p_u_47:Destroy()
        end
    end)
end
return {
    ["Create"] = function(p_u_57)
        local v_u_58 = Instance.new("Folder")
        v_u_58.Name = "VoxelSmoke_" .. p_u_57.SmokeId
        v_u_58.Parent = v_u_3:WaitForChild("Debris")
        v_u_6[p_u_57.SmokeId] = v_u_58
        local v59 = p_u_57.Team
        if v59 then
            v59 = v_u_5[p_u_57.Team]
        end
        for _, v60 in ipairs(p_u_57.Voxels) do
            v_u_25(v60.Position, v60.Size, v_u_58, v59)
        end
        v_u_46(v_u_58, p_u_57.DeployTime)
        task.delay(p_u_57.Duration, function()
            if v_u_6[p_u_57.SmokeId] then
                v_u_56(v_u_58)
                v_u_6[p_u_57.SmokeId] = nil
            end
        end)
    end,
    ["Destroy"] = function(p61)
        local v62 = v_u_6[p61]
        if v62 then
            v_u_56(v62)
            v_u_6[p61] = nil
        end
    end,
    ["DestroyAll"] = function()
        for v63, v64 in pairs(v_u_6) do
            for _, v65 in ipairs(v64:GetChildren()) do
                if v65:IsA("BasePart") then
                    v_u_7[v65] = nil
                    v65:Destroy()
                end
            end
            v64:Destroy()
            v_u_6[v63] = nil
        end
        local v66 = false
        for _, _ in pairs(v_u_7) do
            v66 = true
            break
        end
        if not v66 and v_u_8 then
            v_u_8:Disconnect()
            v_u_8 = nil
        end
    end,
    ["Disrupt"] = function(p67, p68, p69)
        print("[VoxelSmoke] Disrupt called at", p67, "radius:", p68, "duration:", p69)
        local v70 = 0
        for _, v71 in pairs(v_u_6) do
            for _, v_u_72 in ipairs(v71:GetChildren()) do
                if v_u_72:IsA("BasePart") and p68 >= (v_u_72.Position - p67).Magnitude then
                    local v_u_73 = v_u_7[v_u_72]
                    if v_u_73 and v_u_73.isActive then
                        v_u_73.isActive = false
                        local v_u_74 = v_u_73.scaleFactor
                        for _, v75 in ipairs(v_u_73.emitters) do
                            if v75 and v75.Parent then
                                v75:Destroy()
                            end
                        end
                        v_u_73.emitters = {}
                        v70 = v70 + 1
                        local v_u_76 = v_u_73.teamColor
                        task.delay(p69, function()
                            if v_u_73 and v_u_7[v_u_72] then
                                if v_u_72 and v_u_72.Parent then
                                    local v77 = {}
                                    for _, v78 in ipairs(v_u_4:GetDescendants()) do
                                        if v78:IsA("ParticleEmitter") then
                                            local v79 = v78:Clone()
                                            local v80 = v79.Size.Keypoints
                                            local v81 = {}
                                            for _, v82 in ipairs(v80) do
                                                local v83 = NumberSequenceKeypoint.new
                                                local v84 = v82.Time
                                                local v85 = v82.Value * v_u_74
                                                local v86 = v82.Envelope * v_u_74
                                                table.insert(v81, v83(v84, v85, v86))
                                            end
                                            v79.Size = NumberSequence.new(v81)
                                            if v_u_76 then
                                                v79.Color = ColorSequence.new(v_u_76)
                                            end
                                            v79.Enabled = false
                                            v79.Parent = v_u_72
                                            table.insert(v77, v79)
                                        end
                                    end
                                    v_u_73.emitters = v77
                                    v_u_73.lastEmitTime = 0
                                    v_u_73.isActive = true
                                    v_u_73.lifetimeExtended = false
                                    v_u_73.activatedTime = 0
                                    v_u_73.emissionStopped = false
                                    v_u_73.totalParticlesEmitted = 0
                                    print("[VoxelSmoke] Voxel re-enabled after disruption")
                                end
                            else
                                return
                            end
                        end)
                    end
                end
            end
        end
        print("[VoxelSmoke] Disrupted", v70, "voxels")
    end,
    ["GetActiveVoxelCount"] = function()
        local v87 = 0
        for _, _ in pairs(v_u_7) do
            v87 = v87 + 1
        end
        return v87
    end
}