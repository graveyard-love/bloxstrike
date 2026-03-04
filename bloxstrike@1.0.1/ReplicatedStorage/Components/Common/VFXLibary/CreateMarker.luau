local v1 = game:GetService("ReplicatedStorage")
local v2 = v1:WaitForChild("Assets")
local v_u_3 = require(v1.Shared.Janitor)
local v_u_4 = v2:WaitForChild("Other")
local v_u_5 = workspace:WaitForChild("Debris")
local v_u_6 = {
    ["Bullet"] = require(script.Components.Bullet),
    ["Melee"] = require(script.Components.Melee)
}
local v_u_7 = {}
local function v_u_22(p8, p9, p10, p11)
    local v12 = v_u_4:FindFirstChild(p8)
    local v13 = ("%* is not apart of Assets.Miscellaneous"):format(p8)
    assert(v12, v13)
    local v14 = v_u_6[p9]
    local v15 = v_u_6
    local v16 = ("%* is not apart of library \"MarkerInfo\""):format(p9)
    assert(v15, v16)
    local v17 = v12:Clone()
    local v18 = v14.Properties.SizeRange()
    local v19 = v14.Properties.SizeRange()
    v17.Size = Vector3.new(v18, v19, 0.001)
    v17.CollisionGroup = "Debris"
    v17.CanCollide = false
    v17.CanQuery = false
    v17.CanTouch = false
    v17.Anchored = true
    v17.CFrame = CFrame.new(p10, p10 + p11) * CFrame.Angles(0, 0, v14.Properties.Rotation() * 3.141592653589793 / 180)
    v17.Parent = v_u_5
    v17.Anchored = false
    for _, v20 in ipairs(v17:GetDescendants()) do
        local v21 = math.random(1, #v14.Images)
        if v20:IsA("Decal") then
            v20.Transparency = v14.Properties.Transparency()
            v20.Texture = v14.Images[v21]
            v20.Color3 = v14.Properties.Color3
        end
    end
    return v17
end
return function(p_u_23, p24, p25, p26)
    if p_u_23.ClassName ~= "Terrain" then
        local v27 = #v_u_7 >= 20 and table.remove(v_u_7, 1)
        if v27 then
            v27:Destroy()
        end
        local v_u_28 = v_u_3.new()
        local v29 = v_u_7
        table.insert(v29, v_u_28)
        local v30 = v_u_22("HitMarker", p24, p25, p26)
        v_u_28:Add(v30)
        local v31 = Instance.new("WeldConstraint", v30)
        v31.Part0 = v30
        v31.Part1 = p_u_23
        if p_u_23 and p_u_23:IsDescendantOf(workspace) then
            v_u_28:Add(p_u_23.Destroying:Once(function()
                v_u_28:Cleanup()
            end))
            v_u_28:Add(p_u_23:GetPropertyChangedSignal("Transparency"):Connect(function()
                if p_u_23.Transparency == 1 then
                    v_u_28:Cleanup()
                end
            end))
        end
        v_u_28:Add(task.delay(15, function()
            v_u_28:Destroy()
            for v32, v33 in v_u_7 do
                if v33 == v_u_28 then
                    table.remove(v_u_7, v32)
                    return
                end
            end
        end))
    end
end