local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Debris")
require(script:WaitForChild("Types"))
local v_u_3 = workspace:WaitForChild("Debris")
local v_u_4 = require(v1.Packages.Observers)
local v_u_5 = require(v1.Classes.Sound).new("Bullet")
local function v_u_10(p6)
    local v7 = p6:GetPivot()
    p6:SetAttribute("Broken", false)
    p6:RemoveTag("Interactable")
    p6:RemoveTag("Vent")
    local v8 = p6:Clone()
    v8:PivotTo(v7)
    v8.Parent = v_u_3
    for _, v9 in ipairs(v8:GetChildren()) do
        if v9:IsA("BasePart") then
            v9.CanCollide = true
            v9.Transparency = 0
        end
    end
    return v8
end
local function v_u_17(p11)
    local v12 = p11:GetAttribute("Direction")
    for _, v13 in ipairs(p11:GetChildren()) do
        if v13:IsA("BasePart") then
            v13.CollisionGroup = "Debris"
            v13.Anchored = false
            local v14 = v12.X * math.random(15, 20)
            local v15 = v12.Y * math.random(15, 20)
            local v16 = v12.Z * math.random(15, 20)
            v13:ApplyImpulse((Vector3.new(v14, v15, v16)))
        end
    end
    v_u_2:AddItem(p11, 5)
    v_u_5:play({
        ["Name"] = "Break Metal Vent",
        ["Parent"] = p11.PrimaryPart
    })
end
return v_u_4.observeTag("Vent", function(p_u_18)
    if p_u_18:IsDescendantOf(workspace) then
        return v_u_4.observeAttribute(p_u_18, "Broken", function(p19)
            if p19 then
                v_u_17((v_u_10(p_u_18)))
            end
        end)
    end
end)