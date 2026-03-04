local v_u_79 = {
    ["Constants"] = {
        ["SOURCE_TO_STUDS"] = 0.0763888888888889,
        ["SV_GRAVITY"] = 800,
        ["GRENADE_GRAVITY_SCALE"] = 0.39,
        ["GRENADE_ELASTICITY"] = 0.4,
        ["JUMP_THROW_ELASTICITY"] = 0.32,
        ["PLAYER_ELASTICITY"] = 0.3,
        ["MIN_ELASTICITY"] = 0,
        ["MAX_ELASTICITY"] = 0.9,
        ["MAX_THROW_VELOCITY_SOURCE"] = 750,
        ["PLAYER_VELOCITY_SCALE"] = 1.5,
        ["SLEEP_VELOCITY_SOURCE"] = 20,
        ["STOP_EPSILON_SOURCE"] = 0.1,
        ["FLOOR_NORMAL_THRESHOLD"] = 0.7,
        ["OVERBOUNCE"] = 2,
        ["FIXED_TIMESTEP"] = 0.0078125,
        ["MAX_BOUNCES"] = 20,
        ["THROW_POWER_SCALE"] = 0.7,
        ["THROW_POWER_BASE"] = 0.3,
        ["VELOCITY_SCALE"] = 0.58,
        ["GRAVITY"] = Vector3.new(0, -23.833334, 0),
        ["MAX_THROW_VELOCITY"] = 57.29166666666667,
        ["SLEEP_VELOCITY"] = 1.527777777777778,
        ["STOP_EPSILON"] = 0.0076388888888888895,
        ["THROW_UPWARD_BIAS_FAR"] = 0.06,
        ["THROW_UPWARD_BIAS_NEAR"] = 0.04,
        ["THROW_FORWARD_OFFSET"] = 1.35,
        ["THROW_HEIGHT_OFFSET"] = 2.4,
        ["PLAYER_VELOCITY_INHERITANCE"] = 1.5,
        ["PLAYER_VERTICAL_VELOCITY_SCALE"] = 2,
        ["GROUND_CHECK_DISTANCE"] = 0.2,
        ["MAX_SIMULATION_TIME"] = 10,
        ["JUMP_THROW_DETECTION_THRESHOLD"] = 5,
        ["JUMP_THROW_HORIZONTAL_DAMPENING"] = 1,
        ["JUMP_THROW_FIXED_VERTICAL"] = 20,
        ["JUMP_THROW_HEIGHT_BONUS"] = 0,
        ["MAX_THROW_SPEED"] = 50,
        ["MAX_JUMP_THROW_SPEED"] = 62,
        ["MAX_ACCUMULATED_TIME"] = 0.1,
        ["MAX_ITERATIONS_PER_FRAME"] = 16
    },
    ["createInitialState"] = function(p1, p2, p3, p4, p5, p6)
        local v7 = ((p3 == "Far" and 1 or 0) * 0.7 + 0.3) * 57.29166666666667 * p5 * 0.58
        local v8 = p4.Y > 5
        local v9 = 1
        if v8 then
            p1 = p1 + Vector3.new(0, 0, 0)
        end
        local v10
        if v8 then
            v10 = Vector3.new(0, 20, 0)
        else
            local v11 = p4.Y * 2 * 0.58
            v10 = Vector3.new(0, v11, 0)
        end
        local v12
        if v8 then
            local v13 = p2.X * v9
            local v14 = p2.Y
            local v15 = p2.Z * v9
            v12 = Vector3.new(v13, v14, v15).Unit
        else
            v12 = p2
        end
        local v16 = v12 * v7 + v10
        local v17 = not v8 and 1 or v9
        local v18 = p2.X * v17
        local v19 = p2.Y
        local v20 = p2.Z * v17
        local v21 = Vector3.new(v18, v19, v20).Unit * v7 * 0.15
        local v22 = p5 * 6.5 * 0.58
        local v23 = v16 + (v21 + Vector3.new(0, v22, 0))
        local v24 = not v8 and 50 or (p2.Y - 0.4) * 20 + 62
        local v25 = v23.Magnitude
        if v24 < v23.Magnitude then
            v23 = v23.Unit * v24
        end
        local v26 = p4.X
        local v27 = p4.Z
        local v28 = v23 + Vector3.new(v26, 0, v27) * 1.5 * v9
        print(string.format("[SIMULATOR] throwSpeed=%.2f | uncapped=%.2f | capped=%.2f | throwDir.Y=%.3f | isJump=%s", v7, v25, v28.Magnitude, p2.Y, (tostring(v8))))
        local v29 = p6 * 1000
        local v30 = math.floor(v29) % 1000
        local v31 = v30 % 11 - 5
        local v32 = v30 / 11
        local v33 = math.floor(v32) % 13 - 6
        local v34 = v30 / 143
        local v35 = math.floor(v34) % 11 - 5
        return {
            ["position"] = p1,
            ["velocity"] = v28,
            ["angularVelocity"] = Vector3.new(v31, v33, v35),
            ["timestamp"] = p6,
            ["simulationTime"] = 0,
            ["bounceCount"] = 0,
            ["isGrounded"] = false,
            ["isAtRest"] = false,
            ["hasTouched"] = false,
            ["accumulatedTime"] = 0,
            ["isJumpThrow"] = v8
        }
    end,
    ["createConfig"] = function(p36, p37, p38, p39, p40, p41)
        return {
            ["radius"] = p36,
            ["restitution"] = 0.4,
            ["maxBounces"] = 20,
            ["fuseTime"] = p39,
            ["minimumFuseTime"] = p40,
            ["explodeOnFloorImpact"] = p41,
            ["rangeScale"] = p37,
            ["isNearThrow"] = p38
        }
    end,
    ["detectCollision"] = function(p42, p43, p44, p45)
        local v46 = p43 - p42
        local v47 = v46.Magnitude
        if v47 < 0.001 then
            return nil
        end
        local v48 = p44 * 0.01
        local v49 = {}
        local v50 = Vector3.new(v48, 0, 0)
        local v51 = -v48
        local v52 = Vector3.new(v51, 0, 0)
        local v53 = Vector3.new(0, v48, 0)
        local v54 = -v48
        local v55 = Vector3.new(0, v54, 0)
        local v56 = Vector3.new(0, 0, v48)
        local v57 = -v48
        __set_list(v49, 1, {v50, v52, v53, v55, v56, (Vector3.new(0, 0, v57))})
        local v58 = (1 / 0)
        local v59 = workspace:Raycast(p42, v46, p45)
        local v60
        if v59 and v59.Distance < v58 then
            v58 = v59.Distance
            v60 = Vector3.new(0, 0, 0)
        else
            v59 = nil
            v60 = Vector3.new(0, 0, 0)
        end
        for _, v61 in v49 do
            local v62 = p42 + v61
            local v63 = workspace:Raycast(v62, v46, p45)
            if v63 and v63.Distance < v58 then
                v58 = v63.Distance
                v60 = v61
                v59 = v63
            end
        end
        if not v59 then
            return nil
        end
        local v64 = v59.Position - v60
        local v65 = (v64 - p42).Magnitude
        if v47 + v48 + 0.1 < v65 then
            return nil
        end
        local v66 = v59.Instance
        local v67 = v66.Parent
        local v68
        if v67 then
            v68 = v67:FindFirstChildOfClass("Humanoid") ~= nil
        else
            v68 = v67
        end
        local v69 = v67 and v67:HasTag("BreakableGlass") or v66:HasTag("BreakableGlass")
        print("[GrenadeSimulator] Collision hit:", v66, v66:GetFullName())
        return {
            ["hit"] = true,
            ["position"] = v64,
            ["normal"] = v59.Normal,
            ["distance"] = v65,
            ["instance"] = v66,
            ["isPlayer"] = v68,
            ["isGlass"] = v69
        }
    end,
    ["checkGrounded"] = function(p70, p71)
        local v72 = workspace:Raycast(p70, Vector3.new(0, -0.2, 0), p71)
        if v72 then
            return true, v72.Normal
        else
            return false, nil
        end
    end,
    ["checkSurfaceContact"] = function(p73, p74, p75)
        local v76 = p74 + 0.1
        for _, v77 in {
            Vector3.new(0, -1, 0),
            Vector3.new(0, 1, 0),
            Vector3.new(1, 0, 0),
            Vector3.new(-1, 0, 0),
            Vector3.new(0, 0, 1),
            Vector3.new(0, 0, -1)
        } do
            local v78 = workspace:Raycast(p73, v77 * v76, p75)
            if v78 and v78.Distance < v76 then
                return true, v78.Normal
            end
        end
        return false, nil
    end
}
local function v_u_90(p80, p81, p82)
    local v83 = p80:Dot(p81) * p82
    local v84 = p80.X - p81.X * v83
    local v85 = p80.Y - p81.Y * v83
    local v86 = p80.Z - p81.Z * v83
    local v87 = math.abs(v84) < 0.0076388888888888895 and 0 or v84
    local v88 = math.abs(v85) < 0.0076388888888888895 and 0 or v85
    local v89 = math.abs(v86) < 0.0076388888888888895 and 0 or v86
    return Vector3.new(v87, v88, v89)
end
function v_u_79.integrate(p91, p92, p93, p94)
    if p94 then
        return p91 + p92 * p93, p92
    end
    local v95 = p92.Y - p93 * 23.83333396911621
    local v96 = (p92.Y + v95) / 2
    local v97 = p92.X * p93
    local v98 = v96 * p93
    local v99 = p92.Z * p93
    local v100 = Vector3.new(v97, v98, v99)
    local v101 = p92.X
    local v102 = p92.Z
    local v103 = Vector3.new(v101, v95, v102)
    return p91 + v100, v103
end
function v_u_79.calculateBounce(p104, p105, p106, p107)
    local v108 = table.clone(p106)
    local v109 = (p106.isJumpThrow and 0.32 or 0.4) * (p107 and 0.3 or 1)
    local v110 = math.clamp(v109, 0, 0.9)
    local v111 = v_u_90(p104, p105, 2) * v110
    if p105.Y > 0.7 and v111:Dot(v111) < 2.3341049382716053 then
        v108.bounceCount = p106.bounceCount + 1
        v108.hasTouched = true
        return Vector3.new(0, 0, 0), v108
    else
        v108.bounceCount = p106.bounceCount + 1
        v108.hasTouched = true
        return v111, v108
    end
end
function v_u_79.shouldStop(p112, p113, p114)
    if p113 and p114 then
        return p112:Dot(p112) < 2.3341049382716053
    else
        return false
    end
end
function v_u_79.step(p115, p116, p117, p118)
    local v119 = table.clone(p115)
    v119.simulationTime = p115.simulationTime + p118
    local v120 = nil
    if v119.simulationTime >= 10 then
        v119.isAtRest = true
        return v119, {
            ["type"] = "timeout",
            ["timestamp"] = p115.timestamp + v119.simulationTime,
            ["position"] = v119.position,
            ["normal"] = Vector3.new(0, 1, 0),
            ["velocity"] = v119.velocity,
            ["bounceCount"] = v119.bounceCount
        }
    end
    if p116.fuseTime and v119.simulationTime >= p116.fuseTime then
        v119.isAtRest = true
        return v119, {
            ["type"] = "fuse",
            ["timestamp"] = p115.timestamp + v119.simulationTime,
            ["position"] = v119.position,
            ["normal"] = Vector3.new(0, 1, 0),
            ["velocity"] = v119.velocity,
            ["bounceCount"] = v119.bounceCount
        }
    end
    if p115.bounceCount >= p116.maxBounces then
        v119.isAtRest = true
        v119.velocity = Vector3.new(0, 0, 0)
        return v119, {
            ["type"] = "rest",
            ["timestamp"] = p115.timestamp + v119.simulationTime,
            ["position"] = v119.position,
            ["normal"] = Vector3.new(0, 1, 0),
            ["velocity"] = Vector3.new(0, 0, 0),
            ["bounceCount"] = v119.bounceCount
        }
    end
    local v121 = v119.position
    local v122, v123 = v_u_79.integrate(v119.position, v119.velocity, p118, v119.isGrounded)
    local v124 = v_u_79.detectCollision(v121, v122, p116.radius, p117)
    if v124 then
        local v125
        v125, v119 = v_u_79.calculateBounce(v123, v124.normal, v119, v124.isPlayer)
        v119.position = v124.position + v124.normal * 0.05
        v119.velocity = v125
        local v126 = v124.normal.Y > 0.7
        if p116.explodeOnFloorImpact and v126 and (not p116.minimumFuseTime or v119.simulationTime >= p116.minimumFuseTime) then
            v119.isAtRest = true
            return v119, {
                ["type"] = "floor_impact",
                ["timestamp"] = p115.timestamp + v119.simulationTime,
                ["position"] = v119.position,
                ["normal"] = v124.normal,
                ["velocity"] = v119.velocity,
                ["bounceCount"] = v119.bounceCount
            }
        end
        v120 = {
            ["type"] = "bounce",
            ["timestamp"] = p115.timestamp + v119.simulationTime,
            ["position"] = v119.position,
            ["normal"] = v124.normal,
            ["velocity"] = v119.velocity,
            ["bounceCount"] = v119.bounceCount
        }
    else
        v119.position = v122
        v119.velocity = v123
    end
    local v127, v128 = v_u_79.checkGrounded(v119.position, p117)
    v119.isGrounded = v127
    if not v_u_79.shouldStop(v119.velocity, v127, v119.hasTouched) or (p116.minimumFuseTime and v119.simulationTime < p116.minimumFuseTime or p116.fuseTime) then
        return v119, v120
    end
    v119.isAtRest = true
    v119.velocity = Vector3.new(0, 0, 0)
    v119.angularVelocity = Vector3.new(0, 0, 0)
    return v119, {
        ["type"] = "rest",
        ["timestamp"] = p115.timestamp + v119.simulationTime,
        ["position"] = v119.position,
        ["normal"] = v128 or Vector3.new(0, 1, 0),
        ["velocity"] = Vector3.new(0, 0, 0),
        ["bounceCount"] = v119.bounceCount
    }
end
function v_u_79.simulate(p129, p130, p131, p132)
    if p129.isAtRest then
        if not p130.fuseTime then
            return {
                ["state"] = p129,
                ["events"] = {}
            }
        end
        local v133 = table.clone(p129)
        v133.simulationTime = p129.simulationTime + p132
        return v133.simulationTime >= p130.fuseTime and {
            ["state"] = v133,
            ["events"] = {
                {
                    ["type"] = "fuse",
                    ["timestamp"] = p129.timestamp + v133.simulationTime,
                    ["position"] = v133.position,
                    ["normal"] = Vector3.new(0, 1, 0),
                    ["velocity"] = v133.velocity,
                    ["bounceCount"] = v133.bounceCount
                }
            }
        } or {
            ["state"] = v133,
            ["events"] = {}
        }
    end
    local v134 = table.clone(p129)
    v134.accumulatedTime = p129.accumulatedTime + p132
    local v135, v136
    if v134.accumulatedTime > 0.1 then
        v134.accumulatedTime = 0.1
        v135 = 0
        v136 = {}
    else
        v135 = 0
        v136 = {}
    end
    while v134.accumulatedTime >= 0.0078125 and v135 < 16 do
        v135 = v135 + 1
        v134.accumulatedTime = v134.accumulatedTime - 0.0078125
        local v137
        v134, v137 = v_u_79.step(v134, p130, p131, 0.0078125)
        if v137 then
            table.insert(v136, v137)
        end
        if v134.isAtRest then
            break
        end
    end
    return {
        ["state"] = v134,
        ["events"] = v136
    }
end
function v_u_79.calculateThrowParameters(p138, p139, p140, p141)
    local v142 = p140 == "Near"
    local v143 = (v142 and 0.04 or 0.06) * math.clamp(p141, 0.8, 1.2)
    local v144 = 1.35
    local v145 = 2.4
    local v146
    if v142 then
        v144 = v144 * 0.55
        v146 = v145 * 0.8
        v143 = v143 + 0.08
    else
        v146 = v145 + 0.1
    end
    local v147 = (p139 + Vector3.new(0, v143, 0)).Unit
    local v148 = p139.X
    local v149 = p139.Z
    local v150 = Vector3.new(v148, 0, v149)
    return p138 + (v150.Magnitude < 0.01 and Vector3.new(0, 0, -1) or v150).Unit * v144 + Vector3.new(0, v146, 0), v147
end
function v_u_79.interpolateState(p151, p152, p153)
    local v154 = table.clone(p152)
    v154.position = p151.position:Lerp(p152.position, p153)
    v154.velocity = p151.velocity:Lerp(p152.velocity, p153)
    v154.angularVelocity = p151.angularVelocity:Lerp(p152.angularVelocity, p153)
    return v154
end
return v_u_79