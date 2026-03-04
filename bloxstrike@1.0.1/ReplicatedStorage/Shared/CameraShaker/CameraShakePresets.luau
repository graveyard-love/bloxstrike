local v_u_1 = require(script.Parent.CameraShakeInstance)
local v_u_11 = {
    ["Bump"] = function()
        local v2 = v_u_1.new(2.5, 4, 0.1, 0.75)
        v2.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
        v2.RotationInfluence = Vector3.new(1, 1, 1)
        return v2
    end,
    ["Landed"] = function()
        local v3 = v_u_1.new(2, 3, 0.1, 0.5)
        v3.PositionInfluence = Vector3.new(0, 0, 0)
        v3.RotationInfluence = Vector3.new(1, 0, 0.15)
        return v3
    end,
    ["Shoot"] = function()
        local v4 = v_u_1.new(0.3, 5, 0.1, 0.2)
        v4.PositionInfluence = Vector3.new(0, 0, 0.5)
        v4.RotationInfluence = Vector3.new(0.5, 0.5, 0.5)
        return v4
    end,
    ["Explosion"] = function()
        local v5 = v_u_1.new(5, 10, 0, 1.5)
        v5.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
        v5.RotationInfluence = Vector3.new(4, 1, 1)
        return v5
    end,
    ["Earthquake"] = function()
        local v6 = v_u_1.new(0.6, 3.5, 2, 10)
        v6.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
        v6.RotationInfluence = Vector3.new(1, 1, 4)
        return v6
    end,
    ["BadTrip"] = function()
        local v7 = v_u_1.new(10, 0.15, 5, 10)
        v7.PositionInfluence = Vector3.new(0, 0, 0.15)
        v7.RotationInfluence = Vector3.new(2, 1, 4)
        return v7
    end,
    ["HandheldCamera"] = function()
        local v8 = v_u_1.new(1, 0.25, 5, 10)
        v8.PositionInfluence = Vector3.new(0, 0, 0)
        v8.RotationInfluence = Vector3.new(1, 0.5, 0.5)
        return v8
    end,
    ["Vibration"] = function()
        local v9 = v_u_1.new(0.4, 20, 2, 2)
        v9.PositionInfluence = Vector3.new(0, 0.15, 0)
        v9.RotationInfluence = Vector3.new(1.25, 0, 4)
        return v9
    end,
    ["RoughDriving"] = function()
        local v10 = v_u_1.new(1, 2, 1, 1)
        v10.PositionInfluence = Vector3.new(0, 0, 0)
        v10.RotationInfluence = Vector3.new(1, 1, 1)
        return v10
    end
}
return setmetatable({}, {
    ["__index"] = function(_, p12)
        local v13 = v_u_11[p12]
        if type(v13) == "function" then
            return v13()
        end
        error("No preset found with index \"" .. p12 .. "\"")
    end
})