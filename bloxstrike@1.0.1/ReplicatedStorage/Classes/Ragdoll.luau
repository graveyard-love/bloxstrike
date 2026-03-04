local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
require(script:WaitForChild("Types"))
local v_u_4 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_5 = require(v_u_2.Database.Components.GameState)
local v_u_6 = require(v_u_2.Shared.Janitor)
local v_u_7 = require(v_u_2.Packages.Signal)
local v_u_8 = require(script.Configuration.CustomPhysicalProperties)
local v_u_9 = require(script.Configuration.MaxFrictionTorque)
local v_u_10 = require(script.Configuration.PartMultipliers)
local v_u_11 = require(script.Configuration.Constraints)
local v_u_12 = workspace:WaitForChild("Debris")
local v_u_13 = {
    ["ParticleEmitter"] = true,
    ["RigidConstraint"] = true,
    ["WeldConstraint"] = true,
    ["BillboardGui"] = true,
    ["LocalScript"] = true,
    ["Humanoid"] = true,
    ["Script"] = true,
    ["Sound"] = true
}
local v_u_14 = {
    ["WeaponAttachments"] = true,
    ["CollisionCapsule"] = true,
    ["WeaponModel"] = true,
    ["Hitbox"] = true,
    ["Insert"] = true
}
local function v_u_16(p15)
    if v_u_12:FindFirstChild(p15.Name .. "_Weapon") then
        v_u_12[p15.Name .. "_Weapon"]:Destroy()
    end
    if v_u_12:FindFirstChild(p15.Name .. "_WeaponAttachments") then
        v_u_12[p15.Name .. "_WeaponAttachments"]:Destroy()
    end
    if p15:FindFirstChild("CharacterModel") then
        p15.CharacterModel:Destroy()
    end
end
function v_u_1.CreateJoint(_, p17)
    local v18 = p17.Part0
    local v19 = p17.Part1
    if v18 and (v19 and not (v18:HasTag("CharacterAccessory") or v19:HasTag("CharacterAccessory"))) then
        local v20 = v19.Name
        local v21 = v_u_11[v20] or v_u_11.Default
        local v22 = v21.ConstraintType == "Hinge"
        local v23 = Instance.new("Attachment")
        v23.CFrame = p17.C0
        v23.Parent = v18
        local v24 = Instance.new("Attachment")
        v24.CFrame = p17.C1
        v24.Parent = v19
        if v22 then
            local v25 = Instance.new("HingeConstraint")
            v25.Attachment0 = v23
            v25.Attachment1 = v24
            v25.LimitsEnabled = v21.LimitsEnabled
            v25.LowerAngle = v21.LowerAngle
            v25.UpperAngle = v21.UpperAngle
            v25.Restitution = v21.Restitution
            v25.Parent = v18
        else
            local v26 = Instance.new("BallSocketConstraint")
            v26.Attachment0 = v23
            v26.Attachment1 = v24
            v26.MaxFrictionTorque = v_u_9[v20] or 50
            v26.TwistLimitsEnabled = v21.TwistLimitsEnabled
            v26.TwistLowerAngle = v21.TwistLowerAngle
            v26.TwistUpperAngle = v21.TwistUpperAngle
            v26.LimitsEnabled = v21.LimitsEnabled
            v26.Restitution = v21.Restitution
            v26.UpperAngle = v21.UpperAngle
            v26.Parent = v18
        end
        local v27 = Instance.new("NoCollisionConstraint")
        v27.Part0 = v18
        v27.Part1 = v19
        v27.Parent = v18
        p17:Destroy()
    end
end
function v_u_1.Impulse(p_u_28, p29)
    local v30 = p_u_28.CharacterModel:FindFirstChild(p29.Part)
    if v30 then
        local v31 = v_u_4(p29.Weapon)
        if v31 then
            local v32 = v31.RagdollMultiplier * p29.DirectionMultiplier
            if v_u_10[p29.Part] then
                local v33 = v_u_10[p29.Part]
                v32 = v32 * (math.random(v33.Minimum, v33.Maximum) / 100)
            end
            local v34 = p29.Direction.Unit
            local v35 = 2.5 + (p29.Part == "Head" and 1 or 0)
            v30.AssemblyLinearVelocity = (v34 * v32 + Vector3.new(0, -5, 0)) * v35
            p_u_28.Janitor:Add(task.delay(5, function()
                if p_u_28.CharacterModel and (p_u_28.CharacterModel.PrimaryPart and p_u_28.CharacterModel.Parent) then
                    p_u_28.Janitor:Add(v_u_3.Heartbeat:Connect(function(_)
                        local v36 = p_u_28.CharacterModel
                        if v36 and (v36.PrimaryPart and v36.Parent) then
                            local v37 = 0
                            local v38 = 0
                            for _, v39 in ipairs(v36:GetDescendants()) do
                                if v39:IsA("BasePart") then
                                    local v40 = v39.AssemblyAngularVelocity
                                    local v41 = v39.AssemblyLinearVelocity
                                    v37 = v37 + 1
                                    if v41.Magnitude < 0.1 and v40.Magnitude < 0.1 then
                                        v38 = v38 + 1
                                        v39.Anchored = true
                                    end
                                end
                            end
                            if v37 == v38 then
                                p_u_28.Janitor:Remove("WaitForSettle")
                            end
                        else
                            p_u_28.Janitor:Remove("WaitForSettle")
                            return
                        end
                    end), "Disconnect", "WaitForSettle")
                end
            end))
        end
    else
        return
    end
end
function v_u_1.CloneCharacterModel(_, p42)
    local v43 = p42:Clone()
    v43.UpperTorso.AssemblyLinearVelocity = p42.UpperTorso.AssemblyLinearVelocity
    v43.Name = p42.Name
    v_u_16(v43)
    if v43.PrimaryPart and p42.PrimaryPart then
        v43:PivotTo(p42.PrimaryPart.CFrame)
    end
    v43.Parent = v_u_12
    v43:AddTag("Ragdoll")
    if p42.Parent then
        p42:Destroy()
    end
    return v43
end
function v_u_1.SetupCharacterAppearance(p_u_44)
    local v45 = v_u_2.Assets.Other.Ragdoll.Humanoid:Clone()
    v45.Parent = p_u_44.CharacterModel
    v45.Sit = true
    for _, v_u_46 in ipairs(p_u_44.CharacterModel:GetChildren()) do
        if v_u_46:IsA("Clothing") or v_u_46:IsA("ShirtGraphic") then
            v_u_46.Parent = nil
            task.defer(function()
                v_u_46.Parent = p_u_44.CharacterModel
            end)
        end
    end
end
function v_u_1.SetupCharacterParts(p47)
    for _, v48 in ipairs(p47.CharacterModel:GetDescendants()) do
        if v_u_13[v48.ClassName] or v_u_14[v48.Name] then
            v48:Destroy()
        elseif v48:IsA("BasePart") then
            if v48.Name == "HumanoidRootPart" then
                v48.Transparency = 1
                v48.CanCollide = false
                v48.Massless = true
            else
                v48.CustomPhysicalProperties = v_u_8[v48.Name] or v_u_8.Default
                v48.CollisionGroup = "Debris"
                v48.CastShadow = false
                v48.CanCollide = true
                v48.Transparency = 0
                v48.Anchored = false
                v48.Massless = false
                if v48.Name ~= "UpperTorso" then
                    v48.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    v48.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                end
            end
        elseif v48:IsA("Motor6D") then
            local v49 = p47.Motor6Ds
            table.insert(v49, v48)
        elseif v48:IsA("Decal") then
            v48.Transparency = 0
        end
    end
    for _, v50 in ipairs(p47.Motor6Ds) do
        p47:CreateJoint(v50)
    end
end
function v_u_1.new(p51, p_u_52)
    local v53 = v_u_1
    local v_u_54 = setmetatable({}, v53)
    v_u_54.Janitor = v_u_6.new()
    v_u_54.Motor6Ds = {}
    v_u_54.CharacterModel = v_u_54.Janitor:Add(v_u_54:CloneCharacterModel(p51))
    v_u_54.OnDestroy = v_u_54.Janitor:Add(v_u_7.new())
    v_u_54.IsDestroyed = false
    v_u_54:SetupCharacterParts()
    task.defer(function()
        local v55
        if v_u_5.GetState() == "Warmup" then
            v55 = workspace:GetAttribute("Gamemode") == "Deathmatch"
        else
            v55 = false
        end
        v_u_54:SetupCharacterAppearance()
        v_u_54:Impulse(p_u_52)
        task.delay(v55 and 10 or 15, function()
            v_u_54:Destroy()
        end)
    end)
    return v_u_54
end
function v_u_1.Destroy(p_u_56)
    if not p_u_56.IsDestroyed then
        p_u_56.IsDestroyed = true
        p_u_56.OnDestroy:Fire()
        task.delay(0.1, function()
            p_u_56.Janitor:Destroy()
        end)
    end
end
return v_u_1