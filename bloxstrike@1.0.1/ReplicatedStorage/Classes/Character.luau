local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("CollectionService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("RunService")
local v_u_6 = game:GetService("Workspace")
local v7 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_8 = v7.LocalPlayer
local v_u_9 = workspace:WaitForChild("Debris")
local v_u_10 = v_u_6.CurrentCamera
local v_u_11 = v3:WaitForChild("Assets"):WaitForChild("CharacterAnimations")
local v_u_12 = require(script.Components.GetMovementAnimation)
local v_u_13 = require(script.Classes.CharacterAnimator)
local v_u_14 = require(v3.Controllers.InventoryController)
local v_u_15 = require(v3.Database.Components.GameState)
local v_u_16 = require(v3.Database.Security.Remotes)
local v_u_17 = require(v3.Shared.Janitor)
local v_u_18 = require(v3.Packages.Signal)
local v_u_19 = require(v_u_8:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")):GetControls()
local v_u_20 = RaycastParams.new()
v_u_20.FilterType = Enum.RaycastFilterType.Exclude
v_u_20.RespectCanCollide = true
local v_u_21 = RaycastParams.new()
v_u_21.FilterType = Enum.RaycastFilterType.Exclude
v_u_21.RespectCanCollide = true
local v_u_22 = {
    Vector3.new(0, 0, 0),
    Vector3.new(0.8, 0, 0),
    Vector3.new(-0.8, 0, 0),
    Vector3.new(0, 0, 0.8),
    Vector3.new(0, 0, -0.8)
}
local v_u_23 = { v_u_9, v_u_9, v_u_9 }
local v_u_24 = { v_u_9, v_u_9, v_u_9 }
if not v_u_8:GetAttribute("DefaultCameraOffset") then
    v_u_8:SetAttribute("DefaultCameraOffset", Vector3.new(0, -0.15, 0))
end
if not v_u_8:GetAttribute("CrouchCameraOffset") then
    v_u_8:SetAttribute("CrouchCameraOffset", Vector3.new(0, -1.4, 0))
end
local v_u_25 = {
    ["SSG 08"] = 13.6,
    ["SG 553"] = 12,
    ["AWP"] = 8,
    ["AUG"] = 12,
    ["SCAR-20"] = 8,
    ["G3SG1"] = 8
}
local function v_u_31()
    local v26 = v_u_11:FindFirstChild("Crouch")
    local v27 = v_u_11:FindFirstChild("Movement")
    if v27 then
        v27 = v27:FindFirstChild("Walking")
    end
    if not (v26 and v27) then
        return nil
    end
    local v28 = {
        ["CharacterIdle"] = true
    }
    for _, v29 in ipairs(v26:GetDescendants()) do
        if v29:IsA("Animation") then
            v28[v29.Name] = true
        end
    end
    for _, v30 in ipairs(v27:GetDescendants()) do
        if v30:IsA("Animation") then
            v28[v30.Name] = true
        end
    end
    return v28
end
local v_u_32 = nil
local v_u_33 = {
    ["CharacterIdle"] = true
}
local function v_u_48(p34, p35, p36)
    local v37 = p34:Dot(p35) * p36
    if v37 >= 0 then
        return p34
    end
    local v38 = p34 - p35 * v37
    local v39 = v38.X
    if math.abs(v39) < 0.1 then
        local v40 = v38.Y
        local v41 = v38.Z
        v38 = Vector3.new(0, v40, v41)
    end
    local v42 = v38.Y
    if math.abs(v42) < 0.1 then
        local v43 = v38.X
        local v44 = v38.Z
        v38 = Vector3.new(v43, 0, v44)
    end
    local v45 = v38.Z
    if math.abs(v45) < 0.1 then
        local v46 = v38.X
        local v47 = v38.Y
        v38 = Vector3.new(v46, v47, 0)
    end
    return v38
end
function v_u_1.GetMaxSpeed(p49)
    if v_u_15.GetState() == "Buy Period" then
        return 0
    elseif v_u_8:GetAttribute("IsDefusingBomb") then
        return 0
    elseif v_u_8:GetAttribute("IsRescuingHostage") then
        return 0
    else
        local v50 = v_u_8:GetAttribute("IsCarryingHostage") and 0.75 or 1
        local v51 = v_u_14.getCurrentEquipped()
        if v51 and (v51.Properties.Class == "C4" and v51.IsPlanting) then
            return 0
        else
            local v52 = not (v51 and (v51.Properties and v51.Properties.WalkSpeed)) and 20 or v51.Properties.WalkSpeed
            local v53 = v51 and (v51.IsAiming and v_u_25[v51.Name])
            if v53 then
                local v54 = p49.IsClimbing and 0.5 or 1
                local v55 = p49.IsWalking and 0.52 or 1
                local v56 = p49.IsCrouching and not p49.IsJumping and 0.34 or 1
                return v53 * v55 * v54 * v56
            else
                local v57 = p49.IsCrouching and not p49.IsJumping and 0.34 or (p49.IsWalking and 0.52 or 1)
                local v58 = p49.IsClimbing and 0.5 or 1
                if p49.CanceledInertia then
                    v52 = 2.424
                elseif p49.IsJumping and not (p49.IsAirStrafing or p49.CanceledInertia) then
                    local v59 = p49.LocalVelocityOnJump.Magnitude
                    v52 = math.max(v59, 2.424)
                end
                return v52 * v57 * v58 * v50 * (tick() < p49.ShotSlowUntil and p49.ShotSlowMultiplier or 1)
            end
        end
    end
end
function v_u_1.ValidateHumanoidRootPart(p60)
    local v61 = p60.HumanoidRootPart
    if v61 and (v61.Parent and v61:IsDescendantOf(workspace)) then
        return v61
    else
        return nil
    end
end
function v_u_1.TakeStamina(p62, p63)
    local v64 = p62.Stamina - p63
    p62.Stamina = math.clamp(v64, 0, 100)
end
function v_u_1.ApplyFriction(p65, p66)
    if p65.IsJumping then
        return
    else
        local v67 = p65.GlobalVelocity.Magnitude
        if v67 >= 0.001 then
            local v68
            if p65.GlobalDirection.Magnitude < 0.1 then
                v68 = math.max(v67, 5)
            else
                v68 = v67
            end
            local v69 = v67 - v68 * 6 * p66
            local v70 = math.max(v69, 0)
            if v70 ~= v67 then
                if v70 == 0 then
                    p65.GlobalVelocity = Vector3.new(0, 0, 0)
                    return
                end
                p65.GlobalVelocity = p65.GlobalVelocity.Unit * v70
            end
        end
    end
end
function v_u_1.Accelerate(p71, p72, p73, p74, p75)
    local v76 = p73 - p71.GlobalVelocity:Dot(p72)
    if v76 > 0 then
        local v77 = p74 * p75 * p73
        local v78 = math.min(v77, v76)
        p71.GlobalVelocity = p71.GlobalVelocity + p72 * v78
    end
end
function v_u_1.AirAccelerate(p79, p80, p81, p82)
    local v83 = math.min(p81, 2.5)
    local v84 = v83 - p79.GlobalVelocity:Dot(p80)
    if v84 > 0 then
        local v85 = v83 * 100 * p82
        if v84 >= v85 then
            v84 = v85
        end
        p79.GlobalVelocity = p79.GlobalVelocity + p80 * v84
    end
end
function v_u_1.CheckGroundContact(p86)
    if not p86.HumanoidRootPart then
        return false, nil, nil
    end
    local v87 = v_u_6.CurrentCamera
    v_u_24[1] = p86.Character
    v_u_24[2] = v87 or v_u_9
    v_u_21.FilterDescendantsInstances = v_u_24
    local v88 = p86.Player:GetAttribute("Team")
    if v88 and workspace:GetAttribute("ServerGamemode") ~= "Competitive" then
        v_u_21.CollisionGroup = v88
    else
        v_u_21.CollisionGroup = "Default"
    end
    local v89 = p86.HumanoidRootPart.Position
    for _, v90 in ipairs(v_u_22) do
        local v91 = v89 + v90
        local v92 = workspace:Raycast(v91, Vector3.new(0, -3.1, 0), v_u_21)
        if v92 and (v92.Normal.Y > 0.7 and v92.Instance.CanCollide) then
            return true, v92.Instance, v92.Normal
        end
    end
    return false, nil, nil
end
function v_u_1.SetTargetMoveDirection(p93, p94)
    if not p94:FuzzyEq(p93.TargetMoveDirection, 0.001) then
        p93.TargetMoveDirection = p94
        p93.MoveDirectionChanged:Fire(p94)
    end
end
function v_u_1.Jump(p95)
    if v_u_15.GetState() == "Buy Period" then
        return
    elseif v_u_8:GetAttribute("IsDefusingBomb") then
        return
    else
        local v96 = v_u_14.getCurrentEquipped()
        if v96 and (v96.Properties.Class == "C4" and v96.IsPlanting) then
            return
        elseif p95.Character and (p95.Humanoid and p95.HumanoidRootPart) then
            local v97 = tick() - p95.LastJumpTick
            local v98 = tick() - p95.LastLandTick <= 0.5
            if v97 < 0.15 and (p95.LastJumpTick > 0 and (not v98 or (p95.LastAirTime or 0) < 0.15)) then
                p95.IsJumpRequested = false
                return
            else
                if not p95.IsClimbing then
                    local v99 = p95.Humanoid:GetState()
                    if v99 == Enum.HumanoidStateType.Freefall or v99 == Enum.HumanoidStateType.Jumping then
                        p95.IsJumpRequested = false
                        return
                    end
                end
                local v100 = p95.HumanoidRootPart
                if p95.IsClimbing and (p95.IsJumpRequested and not p95.JumpedOffLadder) then
                    local v101 = tick()
                    p95.LastJumpTick = v101
                    p95.LastFreefallTick = v101
                    p95.PeakFallVelocity = 0
                    p95.LandingVelocityY = nil
                    p95.LastLadderJumpTick = tick()
                    p95.JumpedOffLadder = true
                    local v102 = Vector3.new(0, 0, 1)
                    local v103 = p95.LadderZone
                    if v103 then
                        local v104 = p95:GetLadderCFrame(v103)
                        if v104 then
                            local v105 = v100.Position
                            local v106 = v104.Position
                            local v107 = v106.X - v105.X
                            local v108 = v106.Z - v105.Z
                            local v109 = Vector3.new(v107, 0, v108)
                            if v109.Magnitude > 0.1 then
                                v102 = -v109.Unit
                            end
                        end
                    end
                    local v110 = p95.LadderClimbPercentage or 0.5
                    local v111 = -1 - v110 * 2
                    local v112 = v102.X * 12
                    local v113 = v102.Z * 12
                    local v114 = Vector3.new(v112, v111, v113)
                    print("[Ladder Debug] Jumping off ladder", "climb%:", string.format("%.2f", v110), "jumpVel:", v114)
                    p95.ClimbEnded:Fire(p95.LadderZone, true)
                    local v115
                    if v114 == v114 then
                        v115 = v114.Magnitude < 10000
                    else
                        v115 = false
                    end
                    if v115 then
                        v100.AssemblyLinearVelocity = v114
                        local v116 = v114.X
                        local v117 = v114.Z
                        p95.GlobalVelocity = Vector3.new(v116, 0, v117)
                    end
                    p95.ReadyToJump = false
                    p95.Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
                elseif not p95.IsClimbing and (not p95.IsJumping and (p95.IsJumpRequested and p95.Stamina >= 20)) then
                    p95.Humanoid.JumpPower = 19.5
                    if p95.AgainstWall then
                        p95.GlobalVelocity = Vector3.new(0, 0, 0)
                    end
                    local v118 = p95.HumanoidRootPart.AssemblyLinearVelocity.X
                    local v119 = p95.HumanoidRootPart.AssemblyLinearVelocity.Z
                    local v120 = Vector3.new(v118, 0, v119)
                    local v121 = p95.Humanoid.MoveDirection
                    if v120.Magnitude < 1 and v121.Magnitude > 0.1 then
                        local v122 = RaycastParams.new()
                        v122.FilterType = Enum.RaycastFilterType.Exclude
                        v122.FilterDescendantsInstances = { p95.Character }
                        local v123 = workspace:Raycast(p95.HumanoidRootPart.Position, v121 * 2, v122)
                        if v123 then
                            local v124 = v123.Normal.Y
                            if math.abs(v124) < 0.5 then
                                local v125 = v123.Normal.X
                                local v126 = v123.Normal.Z
                                local v127 = Vector3.new(v125, 0, v126).Unit * 400
                                local v128 = p95.HumanoidRootPart
                                local v129 = v127.X
                                local v130 = p95.HumanoidRootPart.AssemblyLinearVelocity.Y
                                local v131 = v127.Z
                                v128:ApplyImpulse((Vector3.new(v129, v130, v131)))
                            end
                        end
                    end
                    if p95.HumanoidRootPart.AssemblyLinearVelocity.Y > 5 then
                        local v132 = p95.HumanoidRootPart.AssemblyLinearVelocity
                        local v133 = p95.HumanoidRootPart
                        local v134 = v132.X
                        local v135 = v132.Z
                        v133.AssemblyLinearVelocity = Vector3.new(v134, 0, v135)
                    end
                    p95.Humanoid.Jump = true
                    p95.IsJumping = true
                    p95.LastJumpTick = tick()
                    p95.ReadyToJump = false
                    p95.IsJumpRequested = false
                    p95.Jumping:Fire()
                    p95.CharacterAnimator:play("Jump", 0.2)
                end
            end
        else
            return
        end
    end
end
function v_u_1.AddLadder(p136, p137)
    if not p136.LadderZones[p137] then
        p137.Anchored = true
        p137.CollisionGroup = "Debris"
        p137.CastShadow = false
        p137.CanCollide = false
        p137.CanTouch = false
        p137.Transparency = 1
        p136.LadderZones[p137] = {
            ["CFrame"] = p137.CFrame,
            ["Extents"] = p137.Size / 2,
            ["Part"] = p137
        }
    end
end
function v_u_1.RemoveLadder(p138, p139)
    p138.LadderZones[p139] = nil
end
function v_u_1.GetLadderCFrame(_, p140)
    if p140.Part and p140.Part.Parent then
        return p140.Part.CFrame
    else
        return nil
    end
end
function v_u_1.ForceExitLadder(p141, p142)
    if p141.IsClimbing then
        print("[Ladder Debug] ForceExitLadder reason:", p142 or "unknown")
        p141.VectorForce.Enabled = false
        p141.IsClimbing = false
        p141.LadderZone = nil
        p141.LadderClimbPercentage = 0
        p141.LastLadderJumpTick = tick()
        if p141.Humanoid then
            p141.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
        end
        p141.Climbing:Fire()
    end
end
function v_u_1.GetLadderClimbPercentage(p143, p144)
    local v145 = p143:ValidateHumanoidRootPart()
    if not v145 then
        return 0
    end
    local v146 = p143:GetLadderCFrame(p144)
    if not v146 then
        return 0
    end
    local v147 = p144.Extents.Y * 2
    if v147 <= 0 then
        warn("[Character] Invalid ladder height:", v147)
        return 0.5
    end
    local v148 = v146.Position
    local v149 = p144.Extents.Y
    local v150 = v148 - Vector3.new(0, v149, 0)
    local v151 = v145.Position
    if v151 ~= v151 or v150 ~= v150 then
        warn("[Character] Invalid positions in climb calculation")
        return 0.5
    end
    local v152 = (v151.Y - v150.Y) / v147
    local v153 = math.clamp(v152, 0, 1)
    return v153 ~= v153 and 0.5 or v153
end
function v_u_1.CheckLadderOverlap(p154, p155)
    local v156 = p154:ValidateHumanoidRootPart()
    if v156 then
        local v157 = p154:GetLadderCFrame(p155)
        if v157 then
            local v158 = v156.Position
            local v159 = p155.Extents
            local v160 = v157:Inverse() * v158
            local v161 = v160.X
            local v162 = math.abs(v161)
            local v163 = v160.Z
            local v164 = math.abs(v163)
            local v165 = v160.Y >= v159.Y - 1
            local v166 = p154.Character:FindFirstChildOfClass("Humanoid")
            if v166 then
                v166 = v166.FloorMaterial ~= Enum.Material.Air
            end
            if v165 and v166 then
                return false
            else
                local v167
                if v159.X > v159.Z then
                    if v159.Z * 0.5 <= v164 then
                        v167 = v164 <= v159.Z + 2
                    else
                        v167 = false
                    end
                elseif v159.X * 0.5 <= v162 then
                    v167 = v162 <= v159.X + 2
                else
                    v167 = false
                end
                if v160.Y <= v159.Y + 0.8 + (v167 and 3 or 0.5) and v160.Y >= -(v159.Y + 0.8 + 3) then
                    if v159.X > v159.Z then
                        if v159.X + 0.8 < v162 then
                            return false
                        elseif v159.X < v162 and v164 < v159.Z * 2 then
                            return false
                        else
                            return v164 <= v159.Z + 2
                        end
                    elseif v159.Z + 0.8 < v164 then
                        return false
                    elseif v159.Z < v164 and v162 < v159.X * 2 then
                        return false
                    else
                        return v162 <= v159.X + 2
                    end
                else
                    return false
                end
            end
        else
            return false
        end
    else
        return false
    end
end
function v_u_1.FindNearestLadder(p168)
    local v169 = p168:ValidateHumanoidRootPart()
    if not v169 then
        return nil
    end
    local v170 = v169.Position
    local v171 = 0
    local v172 = (1 / 0)
    local v173 = nil
    for _, v174 in pairs(p168.LadderZones) do
        v171 = v171 + 1
        local v175 = p168:GetLadderCFrame(v174)
        if v175 then
            local v176 = v170.X - v175.Position.X
            local v177 = v170.Z - v175.Position.Z
            local v178 = Vector3.new(v176, 0, v177).Magnitude
            if v178 <= 2 and (p168:CheckLadderOverlap(v174) and v178 < v172) then
                v173 = v174
                v172 = v178
            end
        end
    end
    local _ = v171 == 0
    return v173
end
function v_u_1.MoveFunction(p179, p180, p181)
    if p179.MaxSpeed == 0 then
        return
    end
    local v182 = p179:ValidateHumanoidRootPart()
    if not v182 then
        if p179.IsClimbing then
            p179:ForceExitLadder("Invalid HumanoidRootPart at MoveFunction start")
        end
        return
    end
    local v183 = tick()
    local v184 = v183 - p179.LastMoveUpdate
    local v185 = p179:GetMaxSpeed()
    p179.GlobalDirection = Vector3.new(0, 0, 0)
    local v186 = Vector3.new(0, 0, 0)
    local v187, _, _ = p179:CheckGroundContact()
    if v187 and (p179.Humanoid:GetState() == Enum.HumanoidStateType.Freefall and v182.AssemblyLinearVelocity.Y <= 1) then
        local v188 = v182.AssemblyLinearVelocity
        local v189 = v188.X
        local v190 = v188.Z
        local v191 = Vector3.new(v189, 0, v190)
        local v192
        if v191 == v191 then
            v192 = v191.Magnitude < 10000
        else
            v192 = false
        end
        if v192 then
            v182.AssemblyLinearVelocity = v191
        end
        p179.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
        p179.IsJumping = false
        p179.IsLanded = true
        p179.ReadyToJump = true
        p179.LockedAirDirection = nil
    end
    local v193 = tick() - p179.LastJumpTick
    if p179.IsJumping and (v187 and v193 >= 0.15) then
        local v194 = v182.AssemblyLinearVelocity.Y
        if v194 <= 1 then
            p179.LastAirTime = tick() - (p179.LastFreefallTick or p179.LastJumpTick)
            p179.LandingVelocityY = p179.PeakFallVelocity or v194
            p179.IsJumping = false
            p179.IsLanded = true
            p179.LandAtPosition = v182.CFrame.Position
            p179.LastLandTick = tick()
            p179.ReadyToJump = true
            p179.LockedAirDirection = nil
            p179.CharacterAnimator:stop("Jump", 0.2)
            p179.Landed:Fire()
        end
    end
    local v195 = p179.Humanoid:GetState()
    if v195 == Enum.HumanoidStateType.Freefall and true or v195 == Enum.HumanoidStateType.Jumping then
        if not p179.LastFreefallTick then
            p179.LastFreefallTick = tick()
            p179.PeakFallVelocity = 0
        end
        local v196 = v182.AssemblyLinearVelocity.Y
        if v196 < (p179.PeakFallVelocity or 0) then
            p179.PeakFallVelocity = v196
        end
    end
    local v197 = v_u_10.CFrame
    local v198 = v197.Position
    local v199, v200, v201 = v197:ToEulerAnglesXYZ()
    local v202 = CFrame.new(v198) * CFrame.fromEulerAnglesXYZ(v199, v200, v201)
    if p180.Magnitude > 0 then
        if p181 then
            p179.GlobalDirection = v202:VectorToWorldSpace(p180)
        else
            p179.GlobalDirection = p180
            p180 = v202:VectorToObjectSpace(p180)
        end
    else
        p180 = v186
    end
    local v203 = v202.LookVector.X
    local v204 = v202.LookVector.Z
    local v205 = Vector3.new(v203, 0, v204)
    local v206 = p179.LastCameraCFrame.LookVector.X
    local v207 = p179.LastCameraCFrame.LookVector.Z
    local v208 = Vector3.new(v206, 0, v207):Cross(v205).Y
    p179.LocalVelocity = v202:VectorToObjectSpace(p179.GlobalVelocity)
    local v209 = p179.LocalVelocity:Angle(p180, Vector3.new(0, 1, 0))
    local _ = v209 == v209
    v205.Unit:Angle(p179.GlobalDirection, Vector3.new(0, 1, 0))
    local v210 = p179.GlobalDirection:Angle(p179.GlobalVelocity, Vector3.new(0, 1, 0))
    math.abs(v210)
    local v211 = p180.X
    local v212 = math.abs(v211) > 0.1
    local v213 = p180.Z <= 0
    local v214 = math.abs(v208) > 0.02
    local v215 = p180.X
    local v216 = math.sign(v215)
    local v217 = math.sign(v208)
    local v218 = p179.IsJumping
    if v218 then
        if v212 then
            if v213 then
                if v214 then
                    v214 = v216 == -v217
                end
            else
                v214 = v213
            end
        else
            v214 = v212
        end
    else
        v214 = v218
    end
    p179.IsAirStrafing = v214
    local v219
    if p179.GlobalDirection.Magnitude > 0 then
        v219 = p179.GlobalDirection.Unit
    else
        v185 = 0
        v219 = Vector3.new(0, 0, 0)
    end
    if p179.IsJumping then
        local v220 = v182.AssemblyLinearVelocity
        local v221 = v220.X
        local v222 = v220.Z
        p179.GlobalVelocity = Vector3.new(v221, 0, v222)
        if v185 > 0 then
            p179:AirAccelerate(v219, v185, v184)
        end
        if p179.IsAirStrafing then
            local v223 = p179.GlobalVelocity.Magnitude
            if v223 > 0.1 then
                local v224 = v205.X
                local v225 = v205.Z
                local v226 = Vector3.new(v224, 0, v225)
                if v226.Magnitude > 0 then
                    local v227 = v226.Unit
                    local v228 = p179.GlobalVelocity.Unit
                    local v229 = 5 * v184 * 10
                    local v230 = math.min(1, v229)
                    local v231 = v228 + (v227 - v228) * v230
                    if v231.Magnitude > 0 then
                        p179.GlobalVelocity = v231.Unit * v223
                    end
                end
            end
        end
        local v232 = p179.GlobalVelocity.Magnitude
        if v232 > 24.5 then
            local v233 = 24.5 / v232
            p179.GlobalVelocity = p179.GlobalVelocity * v233
        end
        local v234 = p179.GlobalVelocity.X
        local v235 = v220.Y
        local v236 = p179.GlobalVelocity.Z
        local v237 = Vector3.new(v234, v235, v236)
        local v238
        if v237 == v237 then
            v238 = v237.Magnitude < 10000
        else
            v238 = false
        end
        if v238 then
            v182.AssemblyLinearVelocity = v237
        end
    else
        local v239
        if tick() - p179.LastLandTick < 0.5 then
            v239 = p179.IsJumpRequested
        else
            v239 = false
        end
        if not v239 then
            p179:ApplyFriction(v184)
        end
        if v185 > 0 then
            p179:Accelerate(v219, math.min(v185, 24.5), 6, v184)
        end
    end
    local v240 = p179.GlobalVelocity.X
    local v241 = p179.GlobalVelocity.Z
    local v242 = Vector3.new(v240, 0, v241).Magnitude
    local _ = p179.IsJumping or p179.IsBhopAttempt
    local v243 = 24.5
    if v243 < v242 then
        local v244 = v243 / v242
        local v245 = p179.GlobalVelocity.X * v244
        local v246 = p179.GlobalVelocity.Y
        local v247 = p179.GlobalVelocity.Z * v244
        p179.GlobalVelocity = Vector3.new(v245, v246, v247)
    end
    p179.Humanoid.WalkSpeed = p179.LocalVelocity.Magnitude
    local v248 = v_u_6.CurrentCamera
    v_u_23[1] = p179.Character
    v_u_23[2] = v248 or v_u_9
    v_u_20.FilterDescendantsInstances = v_u_23
    local v249 = p179.Player:GetAttribute("Team")
    if v249 and workspace:GetAttribute("ServerGamemode") ~= "Competitive" then
        v_u_20.CollisionGroup = v249
    else
        v_u_20.CollisionGroup = "Default"
    end
    p179.AgainstWall = false
    p179.WallNormal = nil
    if p179.IsJumping then
        local v250 = v182.AssemblyLinearVelocity
        local v251 = v250.X
        local v252 = v250.Z
        local v253 = Vector3.new(v251, 0, v252)
        local v254 = v253.Magnitude
        local v255 = v182.Position
        local v256 = tick()
        if p179.LastWallNormal and v256 - p179.LastWallHitTime < 0.15 then
            local v257 = p179.LastWallNormal
            local v258 = v257.X
            local v259 = v257.Z
            local v260 = v253:Dot((Vector3.new(v258, 0, v259)))
            if v260 > 0.5 then
                local v261 = v257.X
                local v262 = v257.Z
                v250 = v250 - Vector3.new(v261, 0, v262) * v260
                local v263
                if v250 == v250 then
                    v263 = v250.Magnitude < 10000
                else
                    v263 = false
                end
                if v263 then
                    v182.AssemblyLinearVelocity = v250
                end
                local v264 = v250.X
                local v265 = v250.Z
                v253 = Vector3.new(v264, 0, v265)
                v254 = v253.Magnitude
            end
        end
        local v266 = { Vector3.new(0, 0, 0), v182.CFrame.RightVector * 1 * 0.8, -v182.CFrame.RightVector * 1 * 0.8 }
        local v267 = {}
        if v254 > 0.5 then
            local v268 = v253.Unit
            table.insert(v267, v268)
        end
        local v269 = p179.GlobalDirection.X
        local v270 = p179.GlobalDirection.Z
        local v271 = Vector3.new(v269, 0, v270)
        if v271.Magnitude > 0.1 then
            local v272 = v271.Unit
            table.insert(v267, v272)
        end
        for _, v273 in ipairs(v267) do
            for _, v274 in ipairs(v266) do
                local v275 = v255 + v274
                local v276 = v273 * (0.5 + (v254 > 0.5 and (v254 * 0.02 or 0.3) or 0.3))
                local v277 = workspace:Raycast(v275, v276, v_u_20)
                if v277 then
                    local v278 = v277.Normal
                    local v279 = v278.Y
                    if math.abs(v279) < 0.7 then
                        p179.AgainstWall = true
                        p179.WallNormal = v278
                        p179.LastWallNormal = v278
                        p179.LastWallHitTime = v256
                        local v280 = v_u_48(v250, v278, 1)
                        local v281 = v280.X
                        local v282 = v280.Z
                        local v283 = Vector3.new(v281, 0, v282)
                        if v283.Magnitude < v254 * 0.3 then
                            local v284 = v250.Y
                            v280 = Vector3.new(0, v284, 0)
                            p179.GlobalVelocity = Vector3.new(0, 0, 0)
                        else
                            p179.GlobalVelocity = v283
                        end
                        local v285
                        if v280 == v280 then
                            v285 = v280.Magnitude < 10000
                        else
                            v285 = false
                        end
                        if v285 then
                            v182.AssemblyLinearVelocity = v280
                        end
                        break
                    end
                end
            end
            if p179.AgainstWall then
                break
            end
        end
    end
    if v182 and (p179.IsCrouching and not p179.CrouchInputDown) then
        p179.CrouchHeadBlocked = workspace:Spherecast(v182.CFrame.Position, 1.5, Vector3.new(0, 1, 0), v_u_20) ~= nil
    end
    if v182 then
        if p179.IsClimbing then
            local v286 = p179.LadderZone
            if v286 then
                local v287 = p179:GetLadderCFrame(v286)
                if not v287 then
                    p179:ForceExitLadder("Ladder part removed")
                    return
                end
                local v288 = v182.Position
                local v289 = v288.Y - 2.5
                local v290 = v287.Position
                local v291 = v290.Y - v286.Extents.Y
                local v292 = v290.Y + v286.Extents.Y
                local v293 = v292 - v291
                local v294 = (v289 - v291) / v293
                local v295 = math.clamp(v294, 0, 1)
                p179.LadderClimbPercentage = v295
                local v296 = v288.X - v290.X
                local v297 = v288.Z - v290.Z
                local v298 = Vector3.new(v296, 0, v297).Magnitude
                if v298 > 50 then
                    print("[Ladder Debug] Sanity check failed - distance:", string.format("%.2f", v298))
                    p179:ForceExitLadder("Distance sanity check failed")
                    return
                end
                local v299 = v295 <= 0.15
                local v300 = v295 >= 0.98
                local v301 = v298 > 2.5
                local v302 = p179.GlobalDirection
                local v303 = v302.X
                local v304 = v302.Z
                local v305 = Vector3.new(v303, 0, v304)
                if v305.Magnitude > 0.1 then
                    v305 = v305.Unit
                end
                local v306 = v202.LookVector.X
                local v307 = v202.LookVector.Z
                local v308 = Vector3.new(v306, 0, v307)
                if v308.Magnitude > 0 then
                    v308 = v308.Unit
                end
                local v309 = v305:Dot(v308)
                local v310 = v290.X - v288.X
                local v311 = v290.Z - v288.Z
                local v312 = Vector3.new(v310, 0, v311)
                if v312.Magnitude > 0.1 and v308:Dot(v312.Unit) <= 0 then
                    v309 = -v309
                end
                local v313 = v309 > 0.1
                local v314 = v309 < -0.1
                local v315 = tick() - (p179.LastLadderAttachTick or 0) >= 0.1
                if v301 then
                    v315 = v301
                elseif not (v299 and (v314 and v315)) then
                    if v300 then
                        if not v313 then
                            v315 = v313
                        end
                    else
                        v315 = v300
                    end
                end
                if v292 + 0.5 <= v289 and true or v315 then
                    print("[Ladder Debug] Detaching", "reason:", v301 and "TooFar" or (v299 and v314 and "BottomExit" or (v300 and v313 and "TopExit" or "FeetAboveTop")), "climb%:", string.format("%.2f", v295), "dist:", string.format("%.2f", v298), "verticalInput:", string.format("%.2f", v309))
                    if v300 and v313 then
                        local v316 = v308 * 8
                        local v317 = v316.X
                        local v318 = v316.Z
                        local v319 = Vector3.new(v317, 2, v318)
                        local v320
                        if v319 == v319 then
                            v320 = v319.Magnitude < 10000
                        else
                            v320 = false
                        end
                        if v320 then
                            v182.AssemblyLinearVelocity = v319
                            p179.GlobalVelocity = v316
                        end
                    end
                    p179.ClimbEnded:Fire(v286, false)
                end
            end
        else
            local v321 = tick() - (p179.LastLadderJumpTick or 0) > (p179.JumpedOffLadder and 0.5 or 0.25) and p179:FindNearestLadder()
            if v321 then
                p179.ClimbBegan:Fire(v321)
            end
        end
    end
    local v322 = Vector3.new(0, 0, 0)
    if p179.IsClimbing and not p179.JumpedOffLadder then
        local v323 = p179.LadderZone
        p179.GlobalVelocity = Vector3.new(0, 0, 0)
        if v323 and v182 then
            local v324 = p179.GlobalDirection
            local v325 = v324.X
            local v326 = v324.Z
            local v327 = Vector3.new(v325, 0, v326)
            local v328 = v202.LookVector.X
            local v329 = v202.LookVector.Z
            local v330 = Vector3.new(v328, 0, v329)
            local v331 = v202.RightVector.X
            local v332 = v202.RightVector.Z
            local v333 = Vector3.new(v331, 0, v332)
            if v327.Magnitude > 0.1 then
                v327 = v327.Unit
            end
            local v334 = v330.Magnitude <= 0 and Vector3.new(0, 0, -1) or v330.Unit
            if v333.Magnitude > 0 then
                v333 = v333.Unit
            end
            local v335 = p179.LadderClimbPercentage or 0
            local v336 = v335 >= 0.98
            local v337 = v335 <= 0.15
            local v338 = v327:Dot(v334)
            local v339 = v327:Dot(v333)
            local v340 = v324.Magnitude > 0.1
            local v341 = p179:GetLadderCFrame(v323)
            if not v341 then
                p179:ForceExitLadder("Ladder part removed during climb")
                return
            end
            local v342 = v182.Position
            local v343 = v341.Position
            local v344 = v343.X - v342.X
            local v345 = v343.Z - v342.Z
            local v346 = Vector3.new(v344, 0, v345)
            if v346.Magnitude > 0.1 and v334:Dot(v346.Unit) <= 0 then
                v338 = -v338
            end
            local v347 = tick() - (p179.LastLadderAttachTick or 0) >= 0.1
            if v336 and (v338 > 0.1 and v347) then
                print("[Ladder Debug] Auto-detach at top", "climb%:", string.format("%.2f", v335), "verticalInput:", string.format("%.2f", v338))
                local v348 = v334 * 8
                local v349 = v348.X
                local v350 = v348.Z
                local v351 = Vector3.new(v349, 2, v350)
                local v352
                if v351 == v351 then
                    v352 = v351.Magnitude < 10000
                else
                    v352 = false
                end
                if v352 then
                    v182.AssemblyLinearVelocity = v351
                    p179.GlobalVelocity = v348
                end
                p179.ClimbEnded:Fire(v323, false)
                return
            end
            if v337 and (v338 < -0.1 and v347) then
                print("[Ladder Debug] Auto-detach at bottom", "climb%:", string.format("%.2f", v335), "verticalInput:", string.format("%.2f", v338))
                p179.ClimbEnded:Fire(v323, false)
                return
            end
            if v340 then
                if math.abs(v338) > 0.1 then
                    local v353 = 14 * v338
                    if math.abs(v339) > 0.1 then
                        v353 = v353 * 1.15
                    end
                    v322 = Vector3.new(0, v353, 0)
                end
                if math.abs(v339) > 0.1 then
                    local v354 = p179:GetLadderCFrame(v323)
                    if not v354 then
                        p179:ForceExitLadder("Ladder part removed during strafe")
                        return
                    end
                    local v355 = v354.RightVector
                    local v356 = v354:VectorToObjectSpace(v342 - v343).X
                    local v357 = v323.Extents.X * 0.8
                    local v358 = v356 + v339 * 0.5
                    if math.abs(v358) < v357 then
                        v322 = v322 + v355 * (5.6000000000000005 * v339)
                    end
                end
            end
        end
        local v359 = v182 and p179.Character.PrimaryPart
        if v359 then
            local v360
            if v322 == v322 then
                v360 = v322.Magnitude < 10000
            else
                v360 = false
            end
            if v360 then
                v359.AssemblyLinearVelocity = v322
            end
        end
    end
    local v361 = not v_u_19.activeController:GetIsJumping() and v_u_19.touchJumpController
    if v361 then
        v361 = v_u_19.touchJumpController:GetIsJumping()
    end
    if v361 and not (p179.IsJumping or p179.IsJumpRequested) then
        p179.IsJumpRequested = true
    elseif not v361 then
        p179.IsJumpRequested = false
    end
    p179:Jump()
    p179.LastCameraCFrame = v202
    p179.Humanoid:MoveTo(p179.HumanoidRootPart.Position + p179.GlobalVelocity)
    p179.LastMoveUpdate = v183
end
function v_u_1.StopMovementAnimations(p362)
    local v363
    if v_u_32 then
        v363 = v_u_32
    else
        v363 = v_u_31()
        if v363 then
            v_u_32 = v363
        else
            v363 = v_u_33
        end
    end
    for v364, v365 in pairs(p362.CharacterAnimator.Animations) do
        if v364 ~= "Jump" and (v363[v364] and v365.IsPlaying) then
            p362.CharacterAnimator:stop(v364, 0.2)
        end
    end
end
function v_u_1.ToggleWalkState(p366, p367)
    if p367 ~= p366.IsWalking then
        p366.IsWalking = p367
        v_u_16.Character.UpdateWalkState.Send(p366.IsWalking)
        p366.Walking:Fire(p366.IsWalking)
    end
end
function v_u_1.ToggleCrouchInput(p368, p369)
    p368.CrouchInputDown = p369
end
function v_u_1.PlantBomb(p370)
    if not p370.IsPlantingBomb then
        p370.IsPlantingBomb = true
        if p370.BombPlantTween then
            p370.BombPlantTween:Cancel()
            p370.BombPlantTween = nil
        end
        p370.BombPlantTween = p370.Janitor:Add(v_u_4:Create(p370.Humanoid, TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ["CameraOffset"] = Vector3.new(0, -0.9, 0) + p370.DefaultCameraOffset
        }))
        p370.BombPlantTween:Play()
    end
end
function v_u_1.CancelBombPlant(p371)
    if p371.IsPlantingBomb then
        p371.IsPlantingBomb = false
        if p371.BombPlantTween then
            p371.BombPlantTween:Cancel()
            p371.BombPlantTween = nil
        end
        p371.Janitor:Add(v_u_4:Create(p371.Humanoid, TweenInfo.new(0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ["CameraOffset"] = p371.DefaultCameraOffset
        })):Play()
    end
end
function v_u_1.ToggleCrouchState(p372, p373)
    local v374 = v_u_14.getCurrentEquipped()
    if v374 and (v374.Properties.Class == "C4" and v374.IsPlanting) then
        return
    elseif p373 ~= p372.IsCrouching then
        local v375 = tick()
        p372.IsCrouching = p373
        v_u_16.Character.UpdateCrouchState.Send(p372.IsCrouching)
        if p372.CrouchTween then
            p372.CrouchTween:Cancel()
            p372.CrouchTween = nil
        end
        if p372.IsCrouching then
            p372.CrouchCount = p372.CrouchCount + 1
            if v375 - p372.LastCrouchTick > 0.5 then
                p372.CrouchCount = 0
            end
            local v376 = p372.CrouchCount * 0.05 + 0.15
            local v377 = math.min(v376, 0.4)
            p372.LastCrouchTick = v375
            p372.CrouchTween = p372.Janitor:Add(v_u_4:Create(p372.Humanoid, TweenInfo.new(v377, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["CameraOffset"] = p372.CrouchCameraOffset + p372.DefaultCameraOffset
            }))
            p372.CrouchTween:Play()
        else
            local v378 = p372.CrouchCount * 0.05 + 0.15
            local v379 = math.min(v378, 0.4)
            p372.CrouchTween = p372.Janitor:Add(v_u_4:Create(p372.Humanoid, TweenInfo.new(v379, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["CameraOffset"] = p372.DefaultCameraOffset
            }))
            p372.CrouchTween:Play()
        end
        p372.LastCrouchTick = v375
        p372.Crouching:Fire(p372.IsCrouching)
    end
end
function v_u_1.UpdateCharacterAnimations(p380, _)
    if p380.IsJumping then
        p380.CurrentMovementAnimation = nil
        p380:StopMovementAnimations()
    else
        local v381 = p380.CharacterAnimator:getAnimation("CrouchIdle")
        local v382 = v_u_12(p380.Character)
        local v383
        if p380.IsCrouching then
            if p380.GlobalDirection.Magnitude <= 0.1 then
                if not v381.IsPlaying then
                    p380.CurrentMovementAnimation = nil
                    p380:StopMovementAnimations()
                    local v384 = p380.CharacterAnimator
                    local v385 = p380.CrouchCount * 0.05 + 0.15
                    v384:play("CrouchIdle", (math.min(v385, 0.4)))
                end
                return
            end
            v383 = ("Crouch%*"):format(v382)
            if v381.IsPlaying then
                local v386 = p380.CharacterAnimator
                local v387 = p380.CrouchCount * 0.05 + 0.15
                v386:stop("CrouchIdle", (math.min(v387, 0.4)))
            end
        else
            if v381.IsPlaying then
                local v388 = p380.CharacterAnimator
                local v389 = p380.CrouchCount * 0.05 + 0.15
                v388:stop("CrouchIdle", (math.min(v389, 0.4)))
            end
            v383 = v382 or "CharacterIdle"
        end
        local v390 = p380.CharacterAnimator:getAnimation(v383)
        if v390 and v383 ~= "CharacterIdle" then
            v390:AdjustSpeed((p380.HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude / (p380.IsCrouching and 12 or 16))
        end
        if p380.CurrentMovementAnimation ~= v383 then
            p380.CurrentMovementAnimation = v383
            p380:StopMovementAnimations()
            if v390 then
                v390:Play(0.15)
                return
            end
        end
    end
end
function v_u_1.new(p_u_391, p392, p393)
    local v394 = v_u_1
    local v_u_395 = setmetatable({}, v394)
    v_u_395.Janitor = v_u_17.new()
    v_u_395.DefaultCameraOffset = v_u_8:GetAttribute("DefaultCameraOffset") or Vector3.new(0, -0.15, 0)
    v_u_395.CrouchCameraOffset = v_u_8:GetAttribute("CrouchCameraOffset") or Vector3.new(0, -1.4, 0)
    v_u_395.Janitor:Add(v_u_8:GetAttributeChangedSignal("DefaultCameraOffset"):Connect(function()
        v_u_395.DefaultCameraOffset = v_u_8:GetAttribute("DefaultCameraOffset") or Vector3.new(0, -0.15, 0)
    end))
    v_u_395.Janitor:Add(v_u_8:GetAttributeChangedSignal("CrouchCameraOffset"):Connect(function()
        v_u_395.CrouchCameraOffset = v_u_8:GetAttribute("CrouchCameraOffset") or Vector3.new(0, -1.4, 0)
    end))
    v_u_395.CharacterAnimator = v_u_13.new(p_u_391)
    v_u_395.HumanoidRootPart = p392
    v_u_395.Character = p_u_391
    v_u_395.Humanoid = p393
    v_u_395.Player = v_u_8
    v_u_395.Janitor:Add(p392.AncestryChanged:Connect(function(_, p396)
        if not p396 then
            if v_u_395.IsClimbing then
                v_u_395:ForceExitLadder("HumanoidRootPart removed")
            end
            v_u_395.HumanoidRootPart = nil
        end
    end))
    v_u_395.Humanoid.WalkSpeed = 20
    v_u_395.Humanoid.AutoRotate = false
    v_u_395.Humanoid.MaxSlopeAngle = 90
    if v_u_8:GetAttribute("SV_ACCELERATE") == nil then
        v_u_8:SetAttribute("SV_ACCELERATE", 6)
    end
    if v_u_8:GetAttribute("SV_STOPSPEED") == nil then
        v_u_8:SetAttribute("SV_STOPSPEED", 5)
    end
    if v_u_8:GetAttribute("SV_FRICTION") == nil then
        v_u_8:SetAttribute("SV_FRICTION", 6)
    end
    local function v_u_398(p397)
        if p397.Name == "CollisionCapsule" then
            p397.CanCollide = false
            return
        elseif p397.Name == "HumanoidRootPart" and p397:IsA("Part") then
            p397.CanCollide = true
            p397.Size = Vector3.new(2, 2, 2)
            p397.Shape = Enum.PartType.Ball
            p397.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0, 1, 1)
            return
        elseif p397.Name == "Head" then
            p397.CanCollide = true
            return
        elseif p397.Name == "UpperTorso" or p397.Name == "LowerTorso" then
            p397.CanCollide = false
        else
            p397.CanCollide = false
        end
    end
    for _, v399 in ipairs(p_u_391:GetDescendants()) do
        if v399:IsA("BasePart") then
            v_u_398(v399)
        end
    end
    v_u_395.Janitor:Add(p_u_391.DescendantAdded:Connect(function(p400)
        if p400:IsA("BasePart") then
            v_u_398(p400)
        end
    end))
    v_u_395.Humanoid.UseJumpPower = true
    v_u_395.Humanoid.JumpPower = 19.5
    v_u_395.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
    v_u_395.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
    v_u_395.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    v_u_395.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
    v_u_395.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    v_u_395.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
    v_u_395.GlobalVelocity = Vector3.new(0, 0, 0)
    v_u_395.LocalVelocity = Vector3.new(0, 0, 0)
    v_u_395.LocalVelocityOnJump = Vector3.new(0, 0, 0)
    v_u_395.GlobalDirection = Vector3.new(0, 0, 0)
    v_u_395.LastCameraCFrame = CFrame.new()
    v_u_395.LastMoveUpdate = 0
    v_u_395.JumpCooldownActive = false
    v_u_395.ReadyToJump = false
    v_u_395.LastJumpTick = 0
    v_u_395.JumpCount = 0
    v_u_395.LastWallHitTick = 0
    v_u_395.WallJumpCooldown = false
    v_u_395.LockedAirDirection = nil
    v_u_395.LastAirDirectionChangeTick = 0
    v_u_395.LastLandTick = 0
    v_u_395.LastFreefallTick = nil
    v_u_395.LastAirTime = 0
    v_u_395.PeakFallVelocity = 0
    v_u_395.LandingVelocityY = nil
    v_u_395.LastCrouchTick = 0
    v_u_395.CrouchCount = 0
    v_u_395.CrouchHeadBlocked = false
    v_u_395.CrouchInputDown = false
    v_u_395.CurrentMovementAnimation = nil
    v_u_395.LadderZones = {}
    v_u_395.LadderPart = nil
    v_u_395.LadderZone = nil
    v_u_395.LadderClimbPercentage = 0
    v_u_395.LastLadderJumpTick = 0
    v_u_395.LastLadderAttachTick = 0
    local _, v401, _ = v_u_10.CFrame:ToEulerAnglesYXZ()
    v_u_395.CurrentYRotation = v401
    v_u_395.TargetYRotation = v401
    local v402 = p392:FindFirstChild("RootAttachment")
    if not v402 then
        warn("[Character] RootAttachment not found - creating one")
        v402 = Instance.new("Attachment")
        v402.Name = "RootAttachment"
        v402.Parent = p392
    end
    local v403 = p392.AssemblyMass
    if v403 ~= v403 or v403 <= 0 then
        warn("[Character] Invalid initial AssemblyMass:", v403, "- using fallback")
        v403 = 10
    end
    v_u_395.VectorForce = v_u_395.Janitor:Add(Instance.new("VectorForce"))
    local v404 = v_u_395.VectorForce
    local v405 = v403 * workspace.Gravity
    v404.Force = Vector3.new(0, v405, 0)
    v_u_395.VectorForce.RelativeTo = Enum.ActuatorRelativeTo.World
    v_u_395.VectorForce.Enabled = false
    v_u_395.VectorForce.ApplyAtCenterOfMass = false
    v_u_395.VectorForce.Attachment0 = v402
    v_u_395.VectorForce.Parent = p392
    v_u_395.AlignOrientation = v_u_395.Janitor:Add(Instance.new("AlignOrientation"))
    v_u_395.AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
    v_u_395.AlignOrientation.Attachment0 = p392:FindFirstChild("RootAttachment")
    v_u_395.AlignOrientation.RigidityEnabled = true
    v_u_395.AlignOrientation.MaxTorque = (1 / 0)
    v_u_395.AlignOrientation.Responsiveness = 200
    v_u_395.AlignOrientation.CFrame = CFrame.Angles(0, v_u_395.CurrentYRotation, 0)
    v_u_395.AlignOrientation.Parent = p392
    v_u_395.JumpedOffLadder = false
    v_u_395.IsPlantingBomb = false
    v_u_395.IsCrouching = false
    v_u_395.IsClimbing = false
    v_u_395.IsJumping = false
    v_u_395.IsWalking = false
    v_u_395.IsLanded = false
    v_u_395.IsBhopAttempt = false
    v_u_395.AgainstWall = false
    v_u_395.WallNormal = nil
    v_u_395.LastWallHitTime = 0
    v_u_395.LastWallNormal = nil
    v_u_395.Stamina = 100
    v_u_395.CurrentMoveDirection = Vector3.new(0, 0, 0)
    v_u_395.TargetMoveDirection = Vector3.new(0, 0, 0)
    v_u_395.MaxSpeed = 20
    v_u_395.ShotSlowUntil = 0
    v_u_395.ShotSlowMultiplier = 1
    v_u_395.LastLookAngle = 0
    v_u_395.LastVerticalLook = 0
    v_u_395.LastLookAngleUpdate = 0
    v_u_395.MoveDirectionChanged = v_u_395.Janitor:Add(v_u_18.new())
    v_u_395.Crouching = v_u_395.Janitor:Add(v_u_18.new())
    v_u_395.ClimbBegan = v_u_395.Janitor:Add(v_u_18.new())
    v_u_395.ClimbEnded = v_u_395.Janitor:Add(v_u_18.new())
    v_u_395.Climbing = v_u_395.Janitor:Add(v_u_18.new())
    v_u_395.Jumping = v_u_395.Janitor:Add(v_u_18.new())
    v_u_395.Walking = v_u_395.Janitor:Add(v_u_18.new())
    v_u_395.Landed = v_u_395.Janitor:Add(v_u_18.new())
    v_u_395.Janitor:Add(function()
        if v_u_395.CharacterAnimator then
            v_u_395.CharacterAnimator:destroy()
        end
    end)
    v_u_395.Janitor:Add(v_u_395.Humanoid.StateChanged:Connect(function(p406, p407)
        local v408 = p407 == Enum.HumanoidStateType.Jumping and true or p407 == Enum.HumanoidStateType.Freefall
        local v409
        if p406 == Enum.HumanoidStateType.Freefall then
            v409 = not v408
        else
            v409 = false
        end
        if p407 == Enum.HumanoidStateType.Freefall then
            v_u_395.LastFreefallTick = tick()
            v_u_395.PeakFallVelocity = 0
        end
        if v409 then
            v_u_395.LastAirTime = tick() - (v_u_395.LastFreefallTick or 0)
            local v410 = v_u_395.HumanoidRootPart and v_u_395.HumanoidRootPart.AssemblyLinearVelocity.Y or 0
            local v411 = v_u_395
            local v412 = v_u_395.PeakFallVelocity or 0
            v411.LandingVelocityY = math.min(v410, v412)
            v_u_395.IsJumping = false
            v_u_395.IsLanded = true
            v_u_395.LandAtPosition = v_u_395.HumanoidRootPart.CFrame.Position
            v_u_395.LastLandTick = tick()
            v_u_395.ReadyToJump = true
            v_u_395.LockedAirDirection = nil
            v_u_395.CharacterAnimator:stop("Jump", 0.2)
            v_u_395.Landed:Fire()
        end
    end))
    v_u_395.OriginalMoveFunction = v_u_19.moveFunction
    v_u_395.IsDestroyed = false
    local v_u_413 = setmetatable({
        ["instance"] = v_u_395
    }, {
        ["__mode"] = "v"
    })
    v_u_395._characterRef = v_u_413
    function v_u_19.moveFunction(_, ...)
        local v414 = v_u_413.instance
        if v414 and not v414.IsDestroyed then
            v414:MoveFunction(...)
        elseif v414 and v414.OriginalMoveFunction then
            v_u_19.moveFunction = v414.OriginalMoveFunction
        end
    end
    v_u_395.Janitor:Add(function()
        if v_u_413 then
            v_u_413.instance = nil
        end
        if not v_u_395.IsDestroyed then
            v_u_395.IsDestroyed = true
            if v_u_395.OriginalMoveFunction then
                v_u_19.moveFunction = v_u_395.OriginalMoveFunction
                v_u_395.OriginalMoveFunction = nil
            end
        end
    end, true, "MoveFunctionCleanup")
    v_u_395.Janitor:Add(v_u_395.Landed:Connect(function()
        local v415 = v_u_395.LandingVelocityY or v_u_395.HumanoidRootPart.AssemblyLinearVelocity.Y
        v_u_395.CanceledInertia = false
        v_u_395.IsCrouchJumping = false
        v_u_395.JumpedOffLadder = false
        if v_u_395.HumanoidRootPart then
            local v416 = v_u_395.HumanoidRootPart.AssemblyLinearVelocity
            local v417 = v416.X
            local v418 = v416.Z
            local v419 = Vector3.new(v417, 0, v418)
            local v420 = v419.Magnitude
            if v420 > 19 then
                local v421 = 1 - (0.1 + (v420 - 19) * 0.03)
                local v422 = v419 * math.max(0.4, v421)
                v_u_395.GlobalVelocity = v422
                local v423 = v_u_395.HumanoidRootPart
                local v424 = v422.X
                local v425 = v416.Y
                local v426 = v422.Z
                v423.AssemblyLinearVelocity = Vector3.new(v424, v425, v426)
            end
        end
        if v415 <= -42 then
            local v427 = v_u_395.LastFreefallTick or v_u_395.LastJumpTick
            if v_u_395.LastLandTick - v427 >= 0.3 then
                local v428 = v_u_16.Character.FallDamage.Send
                local v429 = (v415 - -42) / -35 * 100
                v428((math.abs(v429)))
                v_u_395:TakeStamina(100)
            end
        end
        v_u_395.LandingVelocityY = nil
        v_u_395.LastFreefallTick = nil
    end), "Disconnect")
    v_u_395.Janitor:Add(v_u_395.Jumping:Connect(function()
        v_u_395.LocalVelocityOnJump = v_u_10.CFrame:VectorToObjectSpace(v_u_395.GlobalVelocity)
        v_u_395.GlobalDirectionOnJump = v_u_395.GlobalDirection
        v_u_395.ReadyToJump = false
    end), "Disconnect")
    v_u_395.Janitor:Add(v_u_395.ClimbBegan:Connect(function(p430)
        if p430 and (p430.Part and p430.Part.Parent) then
            local v431 = v_u_395:GetLadderCFrame(p430)
            if v431 then
                local v432 = v431.Position
                if v432 == v432 then
                    local v433 = v432.X
                    if math.abs(v433) <= 50000 then
                        local v434 = v432.Y
                        if math.abs(v434) <= 50000 then
                            local v435 = v432.Z
                            if math.abs(v435) <= 50000 then
                                local v436 = v_u_395:ValidateHumanoidRootPart()
                                if v436 then
                                    local v437 = v436.Position
                                    if v437 == v437 then
                                        local v438 = v437.X
                                        if math.abs(v438) <= 50000 then
                                            local v439 = v437.Y
                                            if math.abs(v439) <= 50000 then
                                                local v440 = v437.Z
                                                if math.abs(v440) <= 50000 then
                                                    v_u_395.GlobalVelocity = Vector3.new(0, 0, 0)
                                                    local v441 = v436.AssemblyLinearVelocity
                                                    if v441 == v441 then
                                                        v436.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                                                        v436.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                                                    else
                                                        warn("[Ladder Debug] HRP velocity was already NaN before climbing! Attempting recovery...")
                                                        v436.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                                                        v436.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                                                    end
                                                    if v_u_395.VectorForce.Attachment0 and v_u_395.VectorForce.Attachment0.Parent then
                                                        local v442 = v436.AssemblyMass
                                                        if v442 ~= v442 or (v442 <= 0 or v442 > 10000) then
                                                            warn("[Ladder Debug] Invalid AssemblyMass:", v442, "- using fallback")
                                                            v442 = 10
                                                        end
                                                        local v443 = v442 * workspace.Gravity
                                                        local v444 = Vector3.new(0, v443, 0)
                                                        if v444 == v444 and v444.Magnitude <= 100000 then
                                                            v_u_395.VectorForce.Force = v444
                                                            task.defer(function()
                                                                if v_u_395.IsDestroyed or not v_u_395.IsClimbing then
                                                                    return
                                                                else
                                                                    local v445 = v_u_395:ValidateHumanoidRootPart()
                                                                    if v445 then
                                                                        local v446 = v445.Position
                                                                        if v446 == v446 then
                                                                            v_u_395.VectorForce.Enabled = true
                                                                        else
                                                                            warn("[Ladder Debug] Position became NaN during defer - aborting")
                                                                            v_u_395:ForceExitLadder("Position NaN during defer")
                                                                        end
                                                                    else
                                                                        v_u_395:ForceExitLadder("HRP invalid after defer")
                                                                        return
                                                                    end
                                                                end
                                                            end)
                                                            v_u_395.LadderZone = p430
                                                            v_u_395.IsClimbing = true
                                                            v_u_395.LastLadderAttachTick = tick()
                                                            v_u_395.LadderClimbPercentage = v_u_395:GetLadderClimbPercentage(p430)
                                                            v_u_395.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
                                                            local v447 = v_u_395:GetLadderClimbPercentage(p430)
                                                            local v448 = p430.Part
                                                            print("[Ladder Debug] ClimbBegan", "part:", v448 and v448.Name or "nil", "pos:", v431 and v431.Position or "nil", "climb%:", string.format("%.2f", v447), "mass:", v442, "force:", v444)
                                                            v_u_395.IsJumping = false
                                                            v_u_395.IsJumpRequested = false
                                                            v_u_395.JumpedOffLadder = false
                                                            v_u_395.LastFreefallTick = nil
                                                            v_u_395.PeakFallVelocity = 0
                                                            v_u_395.LandingVelocityY = nil
                                                            v_u_395.Climbing:Fire()
                                                        else
                                                            warn("[Ladder Debug] Invalid counter-gravity force:", v444, "- aborting climb")
                                                        end
                                                    else
                                                        warn("[Ladder Debug] VectorForce has no valid Attachment0 - aborting climb")
                                                        return
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    warn("[Ladder Debug] ClimbBegan rejected - invalid player position:", v437)
                                else
                                    warn("[Ladder Debug] ClimbBegan rejected - no valid HumanoidRootPart")
                                end
                            end
                        end
                    end
                end
                warn("[Ladder Debug] ClimbBegan rejected - invalid ladder position:", v432)
            else
                warn("[Ladder Debug] ClimbBegan rejected - could not get ladder CFrame")
            end
        else
            warn("[Ladder Debug] ClimbBegan rejected - invalid ladder zone")
            return
        end
    end), "Disconnect")
    v_u_395.Janitor:Add(v_u_395.ClimbEnded:Connect(function(p449, p450)
        local v451 = v_u_395.LadderClimbPercentage or 0
        local v452
        if v_u_395.HumanoidRootPart then
            v452 = v_u_395.HumanoidRootPart.AssemblyLinearVelocity
        else
            v452 = nil
        end
        print("[Ladder Debug] ClimbEnded", p450 and "jumpedOff" or "walkedOff", "climb%:", string.format("%.2f", v451), "velocity:", v452, "ladder:", p449 and (p449.Part and p449.Part.Name) or "nil")
        v_u_395.VectorForce.Enabled = false
        v_u_395.IsClimbing = false
        v_u_395.LadderZone = nil
        v_u_395.LadderClimbPercentage = 0
        v_u_395.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
        v_u_395.LastLadderJumpTick = tick()
        if p450 then
            v_u_395.JumpedOffLadder = true
        end
        v_u_395.Climbing:Fire()
    end), "Disconnect")
    v_u_395.Janitor:Add(v_u_5.Stepped:Connect(function(_, p453)
        if v_u_395.IsDestroyed then
            return
        end
        if v_u_395.HumanoidRootPart and v_u_395.HumanoidRootPart.Parent then
            local v454 = v_u_395.HumanoidRootPart.Position
            if v454 == v454 then
                local v455 = v454.X
                if math.abs(v455) <= 50000 then
                    local v456 = v454.Y
                    if math.abs(v456) <= 50000 then
                        local v457 = v454.Z
                        if math.abs(v457) > 50000 then
                            goto l7
                        end
                        goto l4
                    end
                end
            end
            ::l7::
            warn("[Character] Detected invalid HumanoidRootPart position:", v454, "- forcing ladder exit and resetting velocity")
            if v_u_395.IsClimbing then
                v_u_395:ForceExitLadder("Invalid position detected")
            end
            if (Vector3.new(0, 0, 0)).Magnitude < 10000 then
                v_u_395.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                v_u_395.GlobalVelocity = Vector3.new(0, 0, 0)
            end
        else
            ::l4::
            v_u_395:UpdateCharacterAnimations(p453)
            if v_u_395.CrouchInputDown then
                v_u_395:ToggleCrouchState(true)
            elseif not v_u_395.CrouchHeadBlocked then
                v_u_395:ToggleCrouchState(false)
            end
            if not v_u_395.IsClimbing and v_u_395.Humanoid:GetState() == Enum.HumanoidStateType.Climbing then
                v_u_395.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
                v_u_395.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
            end
            if v_u_395.IsClimbing and v_u_395.LadderZone then
                v_u_395.LadderClimbPercentage = v_u_395:GetLadderClimbPercentage(v_u_395.LadderZone)
            end
            if v_u_395.Stamina < 100 then
                local v458 = v_u_395
                local v459 = v_u_395.Stamina + p453 * 100
                v458.Stamina = math.min(v459, 100)
            end
            local _, v460, _ = v_u_10.CFrame:ToEulerAnglesYXZ()
            v_u_395.TargetYRotation = v460
            local v461 = v_u_395.GlobalVelocity.X
            local v462 = v_u_395.GlobalVelocity.Z
            if (Vector3.new(v461, 0, v462).Magnitude > 0.1 or v_u_395.Humanoid.MoveDirection.Magnitude > 0.1) and true or v_u_395.IsClimbing then
                local v463 = v_u_395.TargetYRotation - v_u_395.CurrentYRotation
                if v463 == v463 and math.abs(v463) ~= (1 / 0) then
                    local v464 = 0
                    while v463 > 3.141592653589793 and v464 < 10 do
                        v463 = v463 - 6.283185307179586
                        v464 = v464 + 1
                    end
                    local v465 = 0
                    while v463 < -3.141592653589793 and v465 < 10 do
                        v463 = v463 + 6.283185307179586
                        v465 = v465 + 1
                    end
                else
                    warn("[Character] Detected invalid rotation values - resetting. TargetY:", v_u_395.TargetYRotation, "CurrentY:", v_u_395.CurrentYRotation)
                    v_u_395.CurrentYRotation = v460
                    v_u_395.TargetYRotation = v460
                    v463 = 0
                end
                local v466 = p453 * 20
                local v467 = math.min(1, v466)
                v_u_395.CurrentYRotation = v_u_395.CurrentYRotation + v463 * v467
                v_u_395.AlignOrientation.RigidityEnabled = true
                v_u_395.AlignOrientation.MaxTorque = (1 / 0)
                v_u_395.AlignOrientation.Enabled = true
            else
                if v460 ~= v460 or math.abs(v460) == (1 / 0) then
                    warn("[Character] Detected invalid camera rotation - skipping stationary rotation update")
                    return
                end
                v_u_395.CurrentYRotation = v_u_395.TargetYRotation
                v_u_395.AlignOrientation.Enabled = false
                if v_u_395.HumanoidRootPart and v_u_395.HumanoidRootPart.Parent then
                    local v468 = v_u_395.HumanoidRootPart.Position
                    if v468 == v468 then
                        local v469 = v468.X
                        if math.abs(v469) < 50000 then
                            local v470 = v468.Y
                            if math.abs(v470) < 50000 then
                                local v471 = v468.Z
                                if math.abs(v471) < 50000 then
                                    v_u_395.HumanoidRootPart.CFrame = CFrame.new(v468) * CFrame.Angles(0, v_u_395.CurrentYRotation, 0)
                                end
                            end
                        end
                    end
                end
            end
            if v_u_395.CurrentYRotation == v_u_395.CurrentYRotation then
                local v472 = v_u_395.CurrentYRotation
                if math.abs(v472) < 100 then
                    v_u_395.AlignOrientation.CFrame = CFrame.Angles(0, v_u_395.CurrentYRotation, 0)
                end
            end
            local v473 = tick()
            if v473 - v_u_395.LastLookAngleUpdate >= 0.05 then
                local v474 = v_u_10.CFrame.LookVector.Y
                local v475 = v460 - v_u_395.LastLookAngle
                local v476 = math.abs(v475)
                local v477 = v474 - v_u_395.LastVerticalLook
                local v478 = math.abs(v477)
                if v476 > 0.1 or v478 > 0.1 then
                    v_u_395.LastLookAngle = v460
                    v_u_395.LastVerticalLook = v474
                    v_u_395.LastLookAngleUpdate = v473
                    v_u_16.Character.UpdateLookAngle.Send({
                        ["HorizontalAngle"] = v460,
                        ["VerticalLook"] = v474
                    })
                end
            end
        end
    end))
    local v479 = v_u_2:GetTagged("Ladder")
    for _, v480 in pairs(v479) do
        v_u_395:AddLadder(v480)
    end
    local v481 = 0
    for _ in pairs(v_u_395.LadderZones) do
        v481 = v481 + 1
    end
    v_u_395.Janitor:Add(v_u_2:GetInstanceAddedSignal("Ladder"):Connect(function(p482)
        if p482:IsA("BasePart") then
            v_u_395:AddLadder(p482)
        end
    end))
    v_u_395.Janitor:Add(v_u_2:GetInstanceRemovedSignal("Ladder"):Connect(function(p483)
        if p483:IsA("BasePart") then
            v_u_395:RemoveLadder(p483)
        end
    end))
    v_u_395._deadAttributeConnection = p_u_391:GetAttributeChangedSignal("Dead"):Connect(function()
        if p_u_391:GetAttribute("Dead") and not v_u_395.IsDestroyed then
            v_u_395:Destroy()
        end
    end)
    return v_u_395
end
function v_u_1.Destroy(p484)
    if not p484.IsDestroyed then
        p484.IsDestroyed = true
        if p484.CharacterAnimator then
            p484.CharacterAnimator:destroy()
            p484.CharacterAnimator = nil
        end
        if p484._characterRef then
            p484._characterRef.instance = nil
            p484._characterRef = nil
        end
        if p484.OriginalMoveFunction then
            v_u_19.moveFunction = p484.OriginalMoveFunction
            p484.OriginalMoveFunction = nil
        end
        if p484._deadAttributeConnection then
            p484._deadAttributeConnection:Disconnect()
            p484._deadAttributeConnection = nil
        end
        if p484.MoveDirectionChanged then
            p484.MoveDirectionChanged:Destroy()
            p484.MoveDirectionChanged = nil
        end
        if p484.Crouching then
            p484.Crouching:Destroy()
            p484.Crouching = nil
        end
        if p484.ClimbBegan then
            p484.ClimbBegan:Destroy()
            p484.ClimbBegan = nil
        end
        if p484.ClimbEnded then
            p484.ClimbEnded:Destroy()
            p484.ClimbEnded = nil
        end
        if p484.Climbing then
            p484.Climbing:Destroy()
            p484.Climbing = nil
        end
        if p484.Jumping then
            p484.Jumping:Destroy()
            p484.Jumping = nil
        end
        if p484.Walking then
            p484.Walking:Destroy()
            p484.Walking = nil
        end
        if p484.Landed then
            p484.Landed:Destroy()
            p484.Landed = nil
        end
        if p484.LadderZones then
            table.clear(p484.LadderZones)
            p484.LadderZones = nil
        end
        p484.Character = nil
        p484.HumanoidRootPart = nil
        p484.Humanoid = nil
        p484.LadderZone = nil
        p484.LadderPart = nil
        if p484.VectorForce then
            p484.VectorForce = nil
        end
        if p484.AlignOrientation then
            p484.AlignOrientation = nil
        end
        if p484.BombPlantTween then
            p484.BombPlantTween = nil
        end
        if p484.CrouchTween then
            p484.CrouchTween = nil
        end
        p484.DefaultCameraOffset = nil
        p484.CrouchCameraOffset = nil
        p484.GlobalVelocity = nil
        p484.LocalVelocity = nil
        p484.LocalVelocityOnJump = nil
        p484.GlobalDirection = nil
        p484.TargetMoveDirection = nil
        p484.CurrentMoveDirection = nil
        p484.WallNormal = nil
        p484.LastWallNormal = nil
        p484.LandingVelocityY = nil
        p484.LockedAirDirection = nil
        p484.Janitor:Destroy()
        p484.Janitor = nil
    end
end
return v_u_1