local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
game:GetService("Workspace")
local v2 = v1:WaitForChild("Assets"):WaitForChild("GrenadeParticles")
local v_u_3 = v2:WaitForChild("InnerFire")
local v_u_4 = v2:WaitForChild("OuterFire")
local v_u_5 = {}
local function v_u_26(p6, p7)
    local v8 = p7.Unit
    local v9 = v8.Y
    if math.abs(v9) > 0.99 then
        return CFrame.new(p6)
    end
    local v10 = v8.X
    local v11 = math.abs(v10)
    local v12 = v8.Z
    local v13
    if math.abs(v12) <= v11 then
        local v14 = v8.X
        local v15 = v8.Y
        v13 = Vector3.new(v14, v15, 0).Unit
    else
        local v16 = v8.Y
        local v17 = v8.Z
        v13 = Vector3.new(0, v16, v17).Unit
    end
    local v18 = v13.X
    local v19 = v13.Z
    local v20 = Vector3.new(v18, 0, v19)
    if v20.Magnitude < 0.01 then
        return CFrame.new(p6)
    end
    local v21 = v20.Unit
    local v22 = v21.Z
    local v23 = -v21.X
    local v24 = Vector3.new(v22, 0, v23)
    local v25 = v24:Cross(v13).Unit
    return CFrame.fromMatrix(p6, v24, v13, -v25)
end
local function v_u_35(p27, p28, p29, p30, p31, p32)
    local v33 = (p31 and v_u_3 or v_u_4):Clone()
    v33.Name = p31 and "InnerFireVoxel" or "OuterFireVoxel"
    v33.Size = Vector3.new(p28, 0.2, p29)
    v33.CFrame = v_u_26(p27, p30)
    v33.Anchored = true
    v33.CanCollide = false
    v33.CanQuery = false
    v33.CanTouch = false
    v33.CastShadow = false
    v33.Parent = p32
    for _, v34 in ipairs(v33:GetDescendants()) do
        if v34:IsA("ParticleEmitter") then
            v34.Enabled = true
        end
    end
    return v33
end
local v_u_68 = {
    ["Create"] = function(p_u_36)
        local v37 = Instance.new("Folder")
        v37.Name = "VoxelFire_" .. p_u_36.FireId
        v37.Parent = workspace:WaitForChild("Debris")
        v_u_5[p_u_36.FireId] = v37
        local v38 = Vector3.new(0, 0, 0)
        for _, v39 in ipairs(p_u_36.Voxels) do
            v38 = v38 + v39.Position
        end
        if #p_u_36.Voxels > 0 then
            v38 = v38 / #p_u_36.Voxels
        end
        for _, v40 in ipairs(p_u_36.Voxels) do
            local v41 = v40.Position.X
            local v42 = v40.Position.Z
            local v43 = Vector3.new(v41, 0, v42)
            local v44 = v38.X
            local v45 = v38.Z
            local v46 = (v43 - Vector3.new(v44, 0, v45)).Magnitude <= 4
            v_u_35(v40.Position, v40.SizeX, v40.SizeZ, v40.Normal, v46, v37)
        end
        task.delay(p_u_36.Duration, function()
            if v_u_5[p_u_36.FireId] then
                v_u_68.Destroy(p_u_36.FireId)
            end
        end)
    end,
    ["Destroy"] = function(p47)
        local v_u_48 = v_u_5[p47]
        if v_u_48 then
            for _, v49 in ipairs(v_u_48:GetChildren()) do
                if v49:IsA("BasePart") then
                    for _, v50 in ipairs(v49:GetDescendants()) do
                        if v50:IsA("ParticleEmitter") then
                            v50.Enabled = false
                        end
                    end
                end
            end
            task.delay(2, function()
                if v_u_48 and v_u_48.Parent then
                    v_u_48:Destroy()
                end
            end)
            v_u_5[p47] = nil
        end
    end,
    ["Update"] = function(p_u_51)
        local v_u_52 = v_u_5[p_u_51.FireId]
        if v_u_52 then
            for _, v53 in ipairs(v_u_52:GetChildren()) do
                if v53:IsA("BasePart") then
                    for _, v54 in ipairs(v53:GetDescendants()) do
                        if v54:IsA("ParticleEmitter") then
                            v54.Enabled = false
                        end
                    end
                end
            end
            task.delay(0.3, function()
                if v_u_52 and v_u_52.Parent then
                    for _, v55 in ipairs(v_u_52:GetChildren()) do
                        if v55:IsA("BasePart") then
                            v55:Destroy()
                        end
                    end
                    if #p_u_51.Voxels ~= 0 then
                        local v56 = Vector3.new(0, 0, 0)
                        for _, v57 in ipairs(p_u_51.Voxels) do
                            v56 = v56 + v57.Position
                        end
                        local v58 = v56 / #p_u_51.Voxels
                        for _, v59 in ipairs(p_u_51.Voxels) do
                            local v60 = v59.Position.X
                            local v61 = v59.Position.Z
                            local v62 = Vector3.new(v60, 0, v61)
                            local v63 = v58.X
                            local v64 = v58.Z
                            local v65 = (v62 - Vector3.new(v63, 0, v64)).Magnitude <= 4
                            v_u_35(v59.Position, v59.SizeX, v59.SizeZ, v59.Normal, v65, v_u_52)
                        end
                    end
                else
                    return
                end
            end)
        end
    end,
    ["DestroyAll"] = function()
        for v66, v67 in pairs(v_u_5) do
            if v67 and v67.Parent then
                v67:Destroy()
            end
            v_u_5[v66] = nil
        end
    end
}
return v_u_68