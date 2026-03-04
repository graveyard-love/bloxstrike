local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Debris")
require(script:WaitForChild("Types"))
local v_u_3 = workspace:WaitForChild("Debris")
local v_u_4 = require(v1.Packages.Observers)
local function v_u_9(p5)
    local v6 = p5:GetPivot()
    p5:SetAttribute("Broken", false)
    p5:RemoveTag("Snowman")
    p5:RemoveTag("Interactable")
    local v7 = p5:Clone()
    v7:PivotTo(v6)
    v7.Parent = v_u_3
    for _, v8 in ipairs(v7:GetChildren()) do
        if v8.Name == "Head" then
            v8.CanCollide = true
            v8.Transparency = 0
        end
    end
    return v7
end
local function v_u_13(p10)
    local v11 = p10:GetAttribute("Direction")
    for _, v12 in ipairs(p10:GetChildren()) do
        if v12.Name == "Head" then
            v12.CollisionGroup = "Debris"
            v12.Anchored = false
            v12.Massless = true
            if v11 then
                v12:ApplyImpulse(math.random(30, 40) * v11)
            end
        end
    end
    v_u_2:AddItem(p10, 10)
end
return v_u_4.observeTag("Snowman", function(p_u_14)
    if p_u_14:IsDescendantOf(workspace) then
        return v_u_4.observeAttribute(p_u_14, "Broken", function(p15)
            if p15 then
                v_u_13((v_u_9(p_u_14)))
            end
        end)
    end
end)