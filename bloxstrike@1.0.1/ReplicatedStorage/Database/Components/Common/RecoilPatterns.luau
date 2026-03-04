local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
require(v1.Database.Custom.Types)
local v_u_3 = v1.Database.Custom.Weapons.SprayPatterns
local function v_u_20(p4, p5)
    local v6 = p5.FireRate
    local v7 = p5.Rounds
    local v8 = {}
    local v9 = v_u_3:FindFirstChild(p4)
    if not v9 then
        warn(string.format("%s has no spray pattern part", p4))
        return nil
    end
    if #v9:GetChildren() ~= v7 then
        warn(string.format("%s spray pattern points not equal to magazine size", p4), v7, #v9:GetChildren())
    end
    local v10 = v9[tostring(1)]
    for v11 = 1, v7 do
        local v12 = v9[tostring(v11)]
        local v13 = Vector2.zero
        local v14 = Vector2.zero
        if v11 > 1 then
            local v15 = v10.WorldCFrame:Inverse()
            local v16 = v11 - 1
            local v17 = (v15 * v9[tostring(v16)].WorldCFrame).Position
            v13 = Vector2.new(v17.X, v17.Y)
            local v18 = (v10.WorldCFrame:Inverse() * v12.WorldCFrame).Position
            v14 = Vector2.new(v18.X, v18.Y)
        end
        local v19 = {
            ["Duration"] = 1 * v6,
            ["EasingStyle"] = Enum.EasingStyle.Linear,
            ["EasingDirection"] = Enum.EasingDirection.In,
            ["Path"] = { v13 * 0.5, v14 * 0.5 }
        }
        table.insert(v8, v19)
    end
    return v8
end
local function v_u_28(p21, p22)
    local v23 = 0
    for _, v24 in ipairs(p21) do
        local v25 = v24.Duration
        local v26 = v23 + v25
        if p22 <= v26 then
            local v27 = (p22 - v23) / v25
            return v24, math.clamp(v27, 0, 1)
        end
        v23 = v26
    end
    return nil, nil
end
local function v_u_44(p29, p30)
    if #p29 == 2 then
        return p29[1]:Lerp(p29[2], p30)
    end
    if #p29 == 3 then
        local v31 = p29[1]
        local v32 = p29[2]
        local v33 = p29[3]
        local v34 = 1 - p30
        return v34 * v34 * v31 + v34 * 2 * p30 * v32 + p30 * p30 * v33
    end
    if #p29 ~= 4 then
        return Vector2.zero
    end
    local v35 = p29[1]
    local v36 = p29[2]
    local v37 = p29[3]
    local v38 = p29[4]
    local v39 = 1 - p30
    local v40 = p30 * p30
    local v41 = v39 * v39
    local v42 = v41 * v39
    local v43 = v40 * p30
    return v42 * v35 + v41 * 3 * p30 * v36 + v39 * 3 * v40 * v37 + v43 * v38
end
local v45 = {}
for _, v46 in ipairs(v_u_3:GetChildren()) do
    local v_u_47 = v46.Name
    v45[v_u_47] = function(p48)
        local _ = p48.FireRate * p48.Rounds
        local v_u_49 = v_u_20(v_u_47, p48)
        local v_u_50 = 0
        for _, v51 in ipairs(v_u_49) do
            v_u_50 = v_u_50 + v51.Duration
        end
        return function(p52)
            local v53 = v_u_50
            local v54, v55 = v_u_28(v_u_49, (math.clamp(p52, 0, v53)))
            local v56 = v_u_2:GetValue(v55, v54.EasingStyle, v54.EasingDirection)
            return v_u_44(v54.Path, v56)
        end
    end
end
return v45