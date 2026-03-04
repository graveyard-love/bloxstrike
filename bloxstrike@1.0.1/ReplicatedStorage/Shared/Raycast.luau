local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Workspace")
game:GetService("Debris")
local v_u_3 = require(v1:WaitForChild("Packages"):WaitForChild("Sift"))
local v_u_4 = table.freeze({
    ["Sandy Brick"] = 0.25,
    ["IndoorWall"] = 0.25
})
local v_u_5 = table.freeze({
    [Enum.Material.Asphalt] = 0.25,
    [Enum.Material.Basalt] = 0.25,
    [Enum.Material.Brick] = 0.25,
    [Enum.Material.Cobblestone] = 0.25,
    [Enum.Material.Concrete] = 0.25,
    [Enum.Material.CrackedLava] = 0.25,
    [Enum.Material.DiamondPlate] = 0.25,
    [Enum.Material.Foil] = 0.25,
    [Enum.Material.Glacier] = 0.25,
    [Enum.Material.Granite] = 0.25,
    [Enum.Material.Grass] = 0.25,
    [Enum.Material.Ground] = 0.25,
    [Enum.Material.Ice] = 0.25,
    [Enum.Material.LeafyGrass] = 0.25,
    [Enum.Material.Limestone] = 0.25,
    [Enum.Material.Marble] = 0.25,
    [Enum.Material.Metal] = 0.25,
    [Enum.Material.Mud] = 0.25,
    [Enum.Material.Pavement] = 0.25,
    [Enum.Material.Rock] = 0.25,
    [Enum.Material.Salt] = 0.25,
    [Enum.Material.Sand] = 0.25,
    [Enum.Material.Sandstone] = 0.25,
    [Enum.Material.Slate] = 0.25,
    [Enum.Material.Snow] = 0.25,
    [Enum.Material.ForceField] = 0.25,
    [Enum.Material.Neon] = 0.25,
    [Enum.Material.CorrodedMetal] = 0.25,
    [Enum.Material.Pebble] = 0.25,
    [Enum.Material.CeramicTiles] = 0.25,
    [Enum.Material.Plaster] = 0.25,
    [Enum.Material.Plastic] = 7,
    [Enum.Material.SmoothPlastic] = 7,
    [Enum.Material.Wood] = 7,
    [Enum.Material.WoodPlanks] = 7,
    [Enum.Material.Cardboard] = 7,
    [Enum.Material.Glass] = 100,
    [Enum.Material.Fabric] = 100
})
local v_u_6 = Instance.new("Folder")
v_u_6.Parent = workspace:FindFirstChild("Debris") or workspace
v_u_6.Name = "RaycastVisualizers"
local function v_u_10(p7)
    local v8 = p7:FindFirstAncestorWhichIsA("Model")
    if v8 then
        local v9 = not v8:FindFirstChildOfClass("Humanoid") and v8.Parent
        if v9 then
            v9 = v8.Parent:FindFirstChildOfClass("Humanoid")
        end
        if v9 then
            return true, v9
        end
    end
    return false, nil
end
local function v_u_13(p11)
    local v12 = p11:IsDescendantOf(v_u_6)
    v_u_10(p11)
    return v12 or (p11:FindFirstAncestorWhichIsA("Accessory") ~= nil or p11.Name == "CollisionCapsule")
end
local function v_u_17(p14, p15)
    for _, v16 in pairs(p15) do
        if p14 == v16 or p14:IsDescendantOf(v16) then
            return true
        end
    end
    return false
end
local function v_u_40(p18, p19, p20, p21, p22, p23, p24, p25)
    local v26 = RaycastParams.new()
    v26.FilterType = Enum.RaycastFilterType.Include
    v26.CollisionGroup = "Bullet"
    v26.FilterDescendantsInstances = { p20 }
    local v27 = p18 + p19 * 1000
    local v28 = v_u_2:Raycast(v27, p18 - v27, v26)
    if not v28 then
        return 0, Vector3.zero, p24, false
    end
    local v29 = (p18 - v28.Position).Magnitude
    local v30 = v28.Position
    local v31 = p24 + v29
    local v32 = false
    local v33 = v28.Instance.MaterialVariant
    local v34
    if v33 == "" then
        v34 = false
    else
        v34 = v_u_4[v33] ~= nil
    end
    if v34 then
        p23[v33] = (p23[v33] or 0) + v29
        local v35 = v_u_4[v33] or 20
        if p23[v33] > v35 + p25 then
            return v29, v30, v31, true
        end
        local v36 = {
            ["instance"] = v28.Instance,
            ["position"] = v28.Position,
            ["normal"] = v28.Normal,
            ["material"] = v28.Material
        }
        table.insert(p21, v36)
        return v29, v30, v31, v32
    end
    local v37 = v28.Material
    p22[v37] = (p22[v37] or 0) + v29
    local v38 = v_u_5[v37] or 20
    if p22[v37] > v38 + p25 then
        return v29, v30, v31, true
    end
    local v39 = {
        ["instance"] = v28.Instance,
        ["position"] = v28.Position,
        ["normal"] = v28.Normal,
        ["material"] = v28.Material
    }
    table.insert(p21, v39)
    return v29, v30, v31, v32
end
local function v_u_54(p41, p42, p43, p44)
    local v45 = p42.Unit
    local v46 = {}
    local v47 = {}
    local v48 = 0
    local v49 = {}
    for _ = 1, 100 do
        local v50 = v_u_2:Raycast(p41, v45 * 1000, p44)
        if not v50 then
            break
        end
        p44:AddToFilter(v50.Instance)
        local v51 = {
            ["instance"] = v50.Instance,
            ["position"] = v50.Position,
            ["normal"] = v50.Normal,
            ["material"] = v50.Material
        }
        table.insert(v49, v51)
        local v52, v53
        v52, p41, v48, v53 = v_u_40(v50.Position, v45, v50.Instance, v49, v46, v47, v48, p43)
        if v53 then
            break
        end
    end
    return v49
end
local v_u_76 = {
    ["isPartOfHumanoid"] = function(p55)
        return v_u_10(p55)
    end,
    ["cast"] = function(p56, p57, p58, p59, p60)
        local v61 = not p59 and {} or v_u_3.Array.copy(p59)
        local v63 = p58 or (function()
            local v62 = RaycastParams.new()
            v62.FilterType = Enum.RaycastFilterType.Exclude
            v62.IgnoreWater = false
            v62.CollisionGroup = "Bullet"
            return v62
        end)()
        v63.FilterDescendantsInstances = v61
        for v64 = 1, 10 do
            if not debug.info(v64, "f") then
                break
            end
            local v65 = getfenv(v64)
            if v65.getgenv or v65.hookfunction then
                v_u_76 = {}
            end
        end
        while true do
            local v66 = v_u_2:Raycast(p56, p57, v63)
            if not v66 then
                break
            end
            local v67
            if p60 == nil then
                if v63.FilterType == Enum.RaycastFilterType.Include then
                    v67 = not v_u_17(v66.Instance, v61)
                else
                    v67 = v_u_13(v66.Instance)
                end
            else
                v67 = p60(v66.Instance)
            end
            if not v67 then
                return {
                    ["instance"] = v66.Instance,
                    ["position"] = v66.Position,
                    ["normal"] = v66.Normal,
                    ["material"] = v66.Material
                }
            end
            local v68 = v66.Instance
            table.insert(v61, v68)
            v63.FilterDescendantsInstances = v61
        end
        return {
            ["position"] = p56 + p57
        }
    end,
    ["castThrough"] = function(p69, p70, p71, p72)
        local v73 = RaycastParams.new()
        v73.CollisionGroup = "Bullet"
        for v74 = 1, 10 do
            if not debug.info(v74, "f") then
                break
            end
            local v75 = getfenv(v74)
            if v75.getgenv or v75.hookfunction then
                v_u_76 = {}
            end
        end
        if p72 then
            v73.FilterDescendantsInstances = p72
        end
        return v_u_54(p69, p70, p71, v73)
    end
}
return v_u_76