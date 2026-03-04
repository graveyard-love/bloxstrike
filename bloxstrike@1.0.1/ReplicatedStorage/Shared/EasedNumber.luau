local v_u_1 = game:GetService("TweenService")
local v_u_2 = {}
v_u_2.__index = v_u_2
function v_u_2.new(p3)
    local v4 = v_u_2
    local v5 = setmetatable({}, v4)
    v5.value = p3
    v5.lastValue = p3
    v5.goal = p3
    v5.timestamp = 0
    v5.rate = nil
    v5.tweenInfo = nil
    return v5
end
function v_u_2.setGoal(p6, p7)
    p6.lastValue = p6.value
    p6.goal = p7
    p6.timestamp = os.clock()
end
function v_u_2.useFixedRate(p8, p9)
    p8.rate = p9
    p8.tweenInfo = nil
end
function v_u_2.useTween(p10, p11)
    p10.rate = nil
    p10.tweenInfo = p11
end
function v_u_2.get(p12)
    return p12.value
end
function v_u_2.update(p13, p14)
    if p13.value == p13.goal then
        return
    elseif p13.tweenInfo then
        local v15 = (os.clock() - p13.timestamp) / p13.tweenInfo.Time
        local v16 = v_u_1:GetValue(math.clamp(v15, 0, 1), p13.tweenInfo.EasingStyle, p13.tweenInfo.EasingDirection)
        local v17 = p13.lastValue
        local v18 = p13.goal
        p13.value = (1 - v16) * v17 + v18 * v16
    elseif p13.rate then
        local v19 = p13.rate
        local v20 = p13.goal - p13.value
        local v21 = v19 * math.sign(v20) * p14
        local v22 = p13.value + v21
        if v21 < 0 then
            local v23 = p13.goal
            p13.value = math.max(v22, v23)
            return
        end
        local v24 = p13.goal
        p13.value = math.min(v22, v24)
    end
end
return v_u_2