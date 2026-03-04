local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
require(script:WaitForChild("Types"))
local v_u_3 = require(v2.Shared.Janitor)
local v_u_4 = require(v2.Shared.Spring)
local v_u_5 = workspace.CurrentCamera
local v_u_6 = Vector2.new(0.02, 0.015) / 50
local function v_u_10(p7, p8)
    for _, v9 in pairs(p7:GetDescendants()) do
        if v9:IsA("MeshPart") then
            v9.Transparency = p8 == true and 0 or 1
        elseif v9:IsA("SurfaceGui") then
            v9.Enabled = p8
        end
    end
end
local function v_u_20(p11, p12)
    if p11 and p12 then
        if p11.ClassName == "Model" and p12.ClassName == "Model" then
            local function v15(p13)
                for _, v14 in pairs(p13:GetChildren()) do
                    if v14.ClassName == "SurfaceAppearance" then
                        v14:Destroy()
                    end
                end
            end
            for _, v16 in pairs(p11:GetChildren()) do
                local v17 = p12:FindFirstChild(v16.Name)
                if v17 then
                    local v18 = v17:FindFirstChildWhichIsA("SurfaceAppearance")
                    if v18 then
                        local v19 = v18:Clone()
                        v19.Name = v17.Name
                        v15(v16)
                        v19.Parent = v16
                    end
                end
            end
        end
    else
        return
    end
end
function v_u_1.addScopeKick(p21)
    if not p21.IsDestroyed and p21.ScopeSpring then
        p21.ScopeSpring:impulse(Vector2.new(5, 1))
    end
end
function v_u_1.getMovementVelocity(p22)
    local v23 = p22.Character
    if v23 then
        local v24 = v23.PrimaryPart.AssemblyLinearVelocity
        if v24.Magnitude > 0.1 then
            local v25 = v24.Unit
            local v26 = v24.Magnitude
            local v27 = v25 * math.min(v26, 50)
            return v27, v_u_5.CFrame:VectorToObjectSpace(v27)
        end
    end
    return Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)
end
function v_u_1.getNextCFrame(p28, p29)
    if p28.IsDestroyed or not (p28.MovementShiftSpring and (p28.CameraShiftSpring and (p28.BobbleSpring and p28.ScopeSpring))) then
        return CFrame.identity, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)
    end
    local v30 = (p29 <= 0 or p29 ~= p29) and 0.016666666666666666 or p29
    local v31, v32 = p28:getMovementVelocity()
    local v33 = v31 * Vector3.new(1, 0, 1)
    local v34 = v32 * Vector3.new(1, 0, 1)
    local v35 = v31.Magnitude
    local v36 = v33.Magnitude
    local v37 = v_u_5.CFrame
    local v38, v39, _ = v37:ToObjectSpace(p28.LastCameraCFrame):ToOrientation()
    local v40 = Vector2.new(v38, v39) / v30
    local v41 = v30 * v35 * 0.1
    local v42 = p28.RenderTime + v41
    local v43 = v40.Y
    local v44 = -v40.X
    local v45 = Vector3.new(0.0011111111, 0.0011111111, 0) * Vector3.new(v43, v44, 0)
    local v46 = v45 ~= v45 and Vector3.new(0, 0, 0) or v45
    local v47 = v34.X
    local v48 = -v36
    local v49 = v34.X
    local v50 = math.abs(v49)
    local v51 = v32.Z
    local v52 = math.abs(v51)
    local v53 = math.max(v50, v52)
    local v54 = Vector3.new(0.0004, 0.0007, 0.0011) * Vector3.new(v47, v48, v53)
    local v55 = Vector2.new
    local v56 = v42 * 3.141592653589793 * 2
    local v57 = math.sin(v56)
    local v58 = v42 * 3.141592653589793 * 4
    local v59 = v55(v57, (math.sin(v58))) * (v_u_6 * 0.5) * v36
    if p28.IsInAir then
        v54 = v54 + Vector3.new(0, -0.02, 0)
        v59 = v59 * 0.3
    end
    p28.MovementShiftSpring:setGoal(v54)
    p28.CameraShiftSpring:setGoal(v46)
    p28.BobbleSpring:setGoal(v59)
    local v60
    if p28.IsAiming then
        v60 = Vector2.zero
    else
        v60 = Vector2.zero
    end
    p28.ScopeSpring:setGoal(v60)
    p28.MovementShiftSpring:update(v30)
    p28.CameraShiftSpring:update(v30)
    p28.BobbleSpring:update(v30)
    p28.ScopeSpring:update(v30)
    p28.LastCameraCFrame = v37
    p28.RenderTime = v42
    local v61 = p28.MovementShiftSpring:getPosition()
    local v62 = p28.CameraShiftSpring:getPosition()
    local v63 = p28.BobbleSpring:getPosition()
    local v64 = v63.X
    local v65 = v63.Y
    local v66 = Vector3.new(v64, v65, 0)
    local v67 = p28.ScopeSpring:getPosition()
    local v68 = -v61.X * 250
    local v69 = math.rad(v68)
    local v70
    if p28.IsAiming then
        v70 = 0.08726646259971647
        v69 = 0
    else
        v70 = 0
    end
    local v71 = v61 + v62 + v66
    local v72 = v66 + v61
    local v73 = v67.X
    local v74 = v67.Y
    local v75 = Vector3.new(v73, v74, 0)
    return CFrame.new(v71) * CFrame.Angles(0, v70, v69), v72, v75
end
function v_u_1.setIsAiming(p76, p77)
    p76.IsAiming = p77
end
function v_u_1.stateChanged(p78, p79, p80)
    if p80 == Enum.HumanoidStateType.Freefall or p80 == Enum.HumanoidStateType.Jumping then
        p78.IsInAir = true
    elseif p79 == Enum.HumanoidStateType.Freefall or p79 == Enum.HumanoidStateType.Jumping then
        p78.IsInAir = false
    end
end
function v_u_1.setModel(p81, p82)
    if p82 then
        if p81.Scope then
            p81.Scope:Destroy()
            p81.Scope = nil
        end
        if p81.ScopeReticlePart then
            p81.ScopeReticlePart:Destroy()
            p81.ScopeReticlePart = nil
        end
        local v83 = p82.Name
        if v83 == "AUG" or v83 == "SG 553" then
            local v84 = p82:FindFirstChild("Weapon")
            if v84 and v84:FindFirstChild("ScopeSplit") then
                local v85 = v84.ScopeSplit
                local v86 = v85:FindFirstChild("Part")
                if v86 then
                    p81.ScopeReticlePart = p81.Janitor:Add(v86:Clone())
                    if p81.ScopeReticlePart then
                        p81.ScopeReticlePart.Parent = v_u_5
                    end
                end
                p81.Scope = p81.Janitor:Add(v85:Clone())
                if p81.Scope then
                    p81.Scope.Parent = v_u_5
                    v_u_10(p81.Scope, false)
                end
                local v87 = v83 == "AUG" and p81.Scope and p81.Scope:FindFirstChild("Part")
                if v87 then
                    local v88 = v87:FindFirstChild("SurfaceGui")
                    local v89 = v88 and v88:FindFirstChild("Frame")
                    if v89 then
                        v89.Visible = false
                    end
                end
                if p81.Scope then
                    v_u_20(p81.Scope, v84)
                end
                v85:Destroy()
            end
        end
    end
end
function v_u_1.new(p90, p91)
    local v92 = v_u_1
    local v_u_93 = setmetatable({}, v92)
    v_u_93.Janitor = v_u_3.new()
    v_u_93.IsDestroyed = false
    local v94 = not p90.Character and p90.Player
    if v94 then
        v94 = p90.Player.Character
    end
    v_u_93.Character = v94
    v_u_93.IsAiming = false
    v_u_93.CameraShiftSpring = v_u_4.new(0.7, 18, Vector3.new(0, 0, 0))
    v_u_93.MovementShiftSpring = v_u_4.new(1, 15, Vector3.new(0, 0, 0))
    v_u_93.BobbleSpring = v_u_4.new(1, 20, Vector2.zero)
    v_u_93.ScopeSpring = v_u_4.new(1, 20, Vector2.zero)
    v_u_93.AimRotationOffset = CFrame.Angles(0, 0, 0)
    v_u_93.AimPositionOffset = CFrame.new(0, 0, 0)
    v_u_93.LastCameraCFrame = v_u_5.CFrame
    v_u_93.CharacterSpeed = 0
    v_u_93.RenderTime = 0
    v_u_93.IsInAir = false
    local v95 = v_u_93.Character and v_u_93.Character:FindFirstChild("Humanoid")
    if v95 then
        local v96 = v95.StateChanged:Connect(function(...)
            if not v_u_93.IsDestroyed then
                v_u_93:stateChanged(...)
            end
        end)
        v_u_93.Janitor:Add(v96)
    end
    v_u_93.Janitor:Add(p90.Player.CharacterAdded:Connect(function(p97)
        v_u_93.Character = p97
        local v98 = p97:FindFirstChildOfClass("Humanoid")
        if not v98 then
            local v99 = tick()
            repeat
                task.wait(0.1)
                v98 = p97:FindFirstChildOfClass("Humanoid")
            until v98 or tick() - v99 > 5
        end
        if v98 then
            v_u_93.Janitor:Add(v98.StateChanged:Connect(function(...)
                if not v_u_93.IsDestroyed then
                    v_u_93:stateChanged(...)
                end
            end))
        end
    end))
    if p91 then
        v_u_93:setModel(p91)
    end
    return v_u_93
end
function v_u_1.destroy(p100)
    if not p100.IsDestroyed then
        p100.IsDestroyed = true
        p100.Janitor:Destroy()
        p100.Janitor = nil
        if p100.CameraShiftSpring then
            p100.CameraShiftSpring = nil
        end
        if p100.MovementShiftSpring then
            p100.MovementShiftSpring = nil
        end
        if p100.BobbleSpring then
            p100.BobbleSpring = nil
        end
        if p100.ScopeSpring then
            p100.ScopeSpring = nil
        end
        p100.Character = nil
        p100.Scope = nil
        p100.ScopeReticlePart = nil
        p100.AimRotationOffset = nil
        p100.AimPositionOffset = nil
    end
end
return v_u_1