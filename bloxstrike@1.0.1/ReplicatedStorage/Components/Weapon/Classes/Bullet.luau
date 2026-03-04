local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = v4.LocalPlayer
local v_u_6 = require(v2.Components.Common.GetRayIgnore)
local v_u_7 = require(v2.Shared.Raycast)
local v_u_8 = require(v2.Shared.Janitor)
local v_u_9 = require(v2.Shared.Spring)
local v_u_10 = workspace.CurrentCamera
local function v_u_18(p11, p12, p13)
    local v14 = Random.new(p13)
    local v15 = v14:NextNumber(-math.pi, math.pi)
    local v16 = p12 / 2
    local v17 = v14:NextNumber(0, (math.rad(v16)))
    return (CFrame.lookAlong(Vector3.zero, p11) * CFrame.Angles(0, 0, v15) * CFrame.Angles(v17, 0, 0)).LookVector
end
local v_u_19 = {}
v_u_19[1] = v_u_19
function v_u_1._performRaycast(p20, p21)
    local v22 = v_u_6()
    local v_u_23 = v_u_10.ViewportSize / 2
    local v24 = v_u_10:ViewportPointToRay(v_u_23.X, v_u_23.Y)
    if pcall(function()
        return v_u_10:ViewportPointToRay(v_u_23.X, v_u_23.Y, v_u_19)
    end) then
        v_u_1 = {}
    end
    for v25 = 1, 10 do
        if not debug.info(v25, "f") then
            break
        end
        local v26 = getfenv(v25)
        if v26.getgenv or v26.hookfunction then
            v_u_1 = {}
        end
    end
    local v27 = math.min(p21, 140)
    local v28 = v_u_18(v24.Direction, v27)
    local v29 = v24.Origin
    local v30 = p20.Properties.Penetration or 0
    local v31 = p20.Properties.Range or 500
    local v32 = {
        ["Origin"] = v29,
        ["Direction"] = v28,
        ["Distance"] = 0,
        ["Hits"] = {}
    }
    local v33 = v28 * v31
    local v34 = v_u_7.cast(v29, v33, nil, v22)
    if not v34.instance then
        v32.Distance = v31
        return v32
    end
    local v35 = v34.position
    v32.Distance = (v35 - v29).Magnitude
    local v36 = v_u_7.castThrough(v35 - v28 * 0.001, v28 * (v30 + 0.001), v30, v22)
    for v37, v38 in ipairs(v36) do
        if v38.instance and v38.material then
            local v39 = {
                ["Position"] = v38.position,
                ["Instance"] = v38.instance,
                ["Material"] = v38.material.Name,
                ["Normal"] = v38.normal or Vector3.zero,
                ["Exit"] = v37 % 2 == 0
            }
            local v40 = v32.Hits
            table.insert(v40, v39)
        end
    end
    return v32
end
function v_u_1.create(p41, p42, p43)
    p41.LastShotTick = tick()
    if p42 == "SniperScope" and not p43 then
        local v44 = p41.Properties.Spread
        local v45 = v44 and v44.MovementMultiplier or 1
        local v46 = v45 == 2 and 6 or (v45 == 3 and 12 or 15)
        local v47 = p41.Spread:getPosition()
        if (type(v47) ~= "number" and 0 or v47) < v46 then
            p41.Spread:setPosition(v46)
        end
    end
    local v48
    if p42 == "SniperScope" and p43 then
        local v49 = p41.Weapon
        if v49.Name == "AWP" then
            local v50 = v49.ScopeStartTick or 0
            if tick() - v50 < 0.2 then
                v48 = false
            else
                v48 = p43
            end
        else
            v48 = p43
        end
    else
        v48 = p43
    end
    local v51 = p41:getTrueSpread()
    if p42 == "SniperScope" and (p43 and (not v48 and p41.Weapon.Name == "AWP")) then
        local v52 = p41.Properties.Spread
        local v53 = v52 and v52.MovementMultiplier or 1
        local v54 = v53 == 2 and 6 or (v53 == 3 and 12 or 15)
        v51 = math.max(v51, v54)
    end
    p41:_updateShotSpread(p42, v48)
    return p41:_performRaycast(v51)
end
function v_u_1.getTrueSpread(p55)
    local v56 = p55.CharacterSpeed < 6.4 and 0 or p55.CharacterSpeed
    local v57 = p55.Properties.Spread
    local v58 = v56 * (not v57 and 1 or v57.MovementMultiplier)
    local v59 = p55.Spread:getPosition()
    return (type(v59) ~= "number" and 0 or v59) + v58
end
function v_u_1.getBaseSpread(p60)
    local v61 = p60.Spread:getPosition()
    return type(v61) ~= "number" and 0 or v61
end
function v_u_1.updateSpread(p62, p63)
    p62.Spread:update(p63)
end
function v_u_1._updateShotSpread(p64, p65, p66)
    local v67 = p64.Properties.Spread
    assert(v67, "Weapon properties missing spread configuration")
    local v68 = v67.Range
    local v69 = v68.Min
    local v70 = v68.Max
    if p65 == "SniperScope" then
        if p66 then
            v69 = 0
        else
            local v71 = v67.MovementMultiplier or 1
            v69 = v71 == 2 and 6 or (v71 == 3 and 12 or 15)
        end
    end
    local v72 = p64.Spread:getPosition()
    local v73 = (type(v72) ~= "number" and 0 or v72) + v67.PerShot
    local v74 = math.clamp(v73, v69, v70)
    p64.Spread:setPosition(v74)
end
function v_u_1.new(p75, p76)
    local v77 = v_u_1
    local v_u_78 = setmetatable({}, v77)
    v_u_78.Janitor = v_u_8.new()
    v_u_78.IsDestroyed = false
    v_u_78.Properties = p76
    v_u_78.Weapon = p75
    v_u_78.CharacterSpeed = 0
    v_u_78.isInAir = false
    v_u_78.jumpStartSpeed = nil
    v_u_78.verticalVelocity = 0
    v_u_78.isAtJumpPeak = false
    local v79 = p76.Spread
    assert(v79, "Weapon properties missing spread configuration")
    v_u_78.Spread = v_u_9.new(1, v79.RecoverySpeed, v79.Range.Min)
    v_u_78.LastShotTick = 0
    local v_u_80 = p76.AimingOptions
    local v_u_81 = p76.MuzzleType
    local v_u_82 = p76.Spread
    local v_u_83
    if v_u_82 then
        v_u_83 = v_u_82.Range
    else
        v_u_83 = v_u_82
    end
    if v_u_83 then
        v_u_83 = v_u_83.Min
    end
    local v_u_84
    if v_u_82 then
        v_u_84 = v_u_82.PerShot
    else
        v_u_84 = v_u_82
    end
    local v_u_85
    if v_u_82 then
        v_u_85 = v_u_82.MovementMultiplier
    else
        v_u_85 = v_u_82
    end
    if v_u_82 then
        v_u_82 = v_u_82.JumpShotMinimum
    end
    local v_u_86 = v_u_5
    v_u_78.Janitor:Add(v_u_3.Heartbeat:Connect(function(_)
        local v87 = v_u_86
        if v87 then
            v87 = v_u_86.Character
        end
        if v87 then
            local v88 = v87.PrimaryPart
            if v88 then
                local v89 = v87:FindFirstChildOfClass("Humanoid")
                if v89 then
                    local v90 = v88.AssemblyLinearVelocity
                    local v91 = v89:GetState()
                    v_u_78.verticalVelocity = v90.Y
                    local v92 = v_u_78.isInAir
                    v_u_78.isInAir = v91 == Enum.HumanoidStateType.Jumping and true or v91 == Enum.HumanoidStateType.Freefall
                    local v93
                    if v_u_80 == "SniperScope" and (v_u_81 == "Sniper" and (v_u_83 == 0 and v_u_84 == 0)) then
                        v93 = v_u_85 == 2
                    else
                        v93 = false
                    end
                    if v93 and v_u_78.isInAir then
                        local v94 = v_u_78
                        local v95 = v_u_78.verticalVelocity
                        v94.isAtJumpPeak = math.abs(v95) <= 3
                    else
                        v_u_78.isAtJumpPeak = false
                    end
                    if v_u_78.isInAir and not v92 then
                        local v96 = v_u_82 or 100
                        v_u_78.jumpStartSpeed = v90.Magnitude + v96
                    elseif not v_u_78.isInAir and v92 then
                        v_u_78.jumpStartSpeed = nil
                        v_u_78.isAtJumpPeak = false
                    end
                    if v_u_78.isInAir and v_u_78.jumpStartSpeed then
                        if v93 and v_u_78.isAtJumpPeak then
                            local v97 = v90.X
                            local v98 = v90.Z
                            v_u_78.CharacterSpeed = Vector3.new(v97, 0, v98).Magnitude
                        else
                            v_u_78.CharacterSpeed = v_u_78.jumpStartSpeed
                        end
                    else
                        v_u_78.CharacterSpeed = v90.Magnitude
                        return
                    end
                else
                    return
                end
            else
                return
            end
        else
            return
        end
    end))
    v_u_78.Janitor:Add(v_u_3.Stepped:Connect(function(_, p99)
        v_u_78:updateSpread(p99)
    end))
    return v_u_78
end
function v_u_1.destroy(p100)
    if not p100.IsDestroyed then
        p100.IsDestroyed = true
        p100.Janitor:Destroy()
        p100.Properties = nil
        p100.Weapon = nil
        p100.Spread = nil
        p100.Janitor = nil
    end
end
return v_u_1