local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Debris")
require(script:WaitForChild("Types"))
local v_u_3 = workspace:WaitForChild("Debris")
local v_u_4 = require(v1.Packages.Observers)
local v_u_5 = require(v1.Classes.Sound)
local function v_u_10(p6)
    local v7 = p6:GetPivot()
    p6:SetAttribute("Broken", false)
    p6:RemoveTag("Flower Pot")
    p6:RemoveTag("Interactable")
    local v8 = p6:Clone()
    v8:PivotTo(v7)
    v8.Parent = v_u_3
    for _, v9 in ipairs(v8:GetChildren()) do
        if v9:IsA("BasePart") then
            v9.CanCollide = true
            v9.Transparency = 0
            if v9.Name == "Unbroken" then
                v9.Transparency = 1
            end
        end
    end
    return v8
end
local function v_u_15(p11)
    local v12 = p11:GetAttribute("Direction")
    for _, v13 in ipairs(p11:GetChildren()) do
        if v13:IsA("BasePart") and v13.Name ~= "Unbroken" then
            v13.CollisionGroup = "Debris"
            v13.Anchored = false
            v13.Massless = true
        end
    end
    for _, v14 in ipairs(p11:GetChildren()) do
        if v14:IsA("BasePart") then
            v14:ApplyImpulse(v12 * math.random(2, 3))
        end
    end
    v_u_2:AddItem(p11, 5)
    v_u_5.new("Bullet"):playOneTime({
        ["Name"] = "Break Flower Pot",
        ["Parent"] = p11.PrimaryPart
    })
end
return v_u_4.observeTag("Flower Pot", function(p_u_16)
    if p_u_16:IsDescendantOf(workspace) then
        return v_u_4.observeAttribute(p_u_16, "Broken", function(p17)
            if p17 then
                v_u_15((v_u_10(p_u_16)))
            end
        end)
    end
end)