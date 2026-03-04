local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = math.exp
local v_u_3 = math.sin
local v_u_4 = math.cos
local v_u_5 = math.sqrt
function v_u_1.new(p6, p7, p8)
    local v9 = type(p6) == "number"
    assert(v9, "damping ratio must be a number")
    local v10 = type(p7) == "number"
    assert(v10, "frequency must be a number")
    local v11 = p6 * p7 >= 0
    assert(v11, "Spring does not converge")
    local v12 = {
        ["d"] = p6,
        ["f"] = p7 * 0.2,
        ["g"] = p8,
        ["p"] = p8,
        ["v"] = p8 * 0
    }
    local v13 = v_u_1
    return setmetatable(v12, v13)
end
function v_u_1.setDampingRatio(p14, p15)
    p14.d = p15
end
function v_u_1.setFrequency(p16, p17)
    p16.f = p17 * 0.2
end
function v_u_1.setGoal(p18, p19)
    p18.g = p19
end
function v_u_1.getGoal(p20)
    return p20.g
end
function v_u_1.setPosition(p21, p22)
    p21.p = p22
end
function v_u_1.getPosition(p23)
    return p23.p
end
function v_u_1.getVelocity(p24)
    return p24.v / 0.2
end
function v_u_1.impulse(p25, p26)
    p25.v = p25.v + p26 * 0.2
end
function v_u_1.reset(p27, p28)
    p27.g = p28
    p27.p = p27.g
    p27.v = p27.g * 0
end
function v_u_1.update(p29, p30)
    local v31 = p29.d
    local v32 = p29.f * 2 * 3.141592653589793
    local v33 = p29.g
    local v34 = p29.p
    local v35 = p29.v
    local v36 = v34 - v33
    local v37 = v_u_2(-v31 * v32 * p30)
    local v38, v39
    if v31 == 1 then
        v38 = (v36 * (1 + v32 * p30) + v35 * p30) * v37 + v33
        v39 = (v35 * (1 - v32 * p30) - v36 * (v32 * v32 * p30)) * v37
    elseif v31 < 1 then
        local v40 = v_u_5(1 - v31 * v31)
        local v41 = v_u_4(v32 * v40 * p30)
        local v42 = v_u_3(v32 * v40 * p30)
        local v43
        if v40 > 0.0001 then
            v43 = v42 / v40
        else
            local v44 = p30 * v32
            v43 = v44 + (v44 * v44 * (v40 * v40) * (v40 * v40) / 20 - v40 * v40) * (v44 * v44 * v44) / 6
        end
        local v45
        if v32 * v40 > 0.0001 then
            v45 = v42 / (v32 * v40)
        else
            local v46 = v32 * v40
            v45 = p30 + (p30 * p30 * (v46 * v46) * (v46 * v46) / 20 - v46 * v46) * (p30 * p30 * p30) / 6
        end
        v38 = (v36 * (v41 + v31 * v43) + v35 * v45) * v37 + v33
        v39 = (v35 * (v41 - v43 * v31) - v36 * (v43 * v32)) * v37
    else
        local v47 = v_u_5(v31 * v31 - 1)
        local v48 = -v32 * (v31 - v47)
        local v49 = -v32 * (v31 + v47)
        local v50 = (v35 - v36 * v48) / (2 * v32 * v47)
        local v51 = (v36 - v50) * v_u_2(v48 * p30)
        local v52 = v50 * v_u_2(v49 * p30)
        v38 = v51 + v52 + v33
        v39 = v51 * v48 + v52 * v49
    end
    p29.p = v38
    p29.v = v39
    return v38
end
return v_u_1