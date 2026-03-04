local v1 = game:GetService("RunService")
local v_u_2 = 60
local v_u_3 = {}
local v4 = v1:IsClient() and "RenderStepped" or "Heartbeat"
local v_u_5 = tick()
local v_u_6 = 0
v1[v4]:Connect(function()
    v_u_6 = v_u_6 + 1
    local v7 = tick()
    local v8 = v7 - v_u_5
    if v8 >= 1 then
        local v9 = v_u_6 / v8
        v_u_2 = math.floor(v9)
        v_u_5 = v7
        v_u_6 = 0
    end
    for v10, v11 in v_u_3 do
        if v10 and v10.Parent then
            v11._nextFrame(v7)
        else
            v11.stop()
        end
    end
end)
local v_u_29 = {
    ["new"] = function(p_u_12, p_u_13)
        local v_u_18 = {
            ["looping"] = false,
            ["cells"] = p_u_13,
            ["framerate"] = v_u_2,
            ["play"] = function(p14, p15)
                local v16 = p14 or v_u_2
                v_u_18.looping = p15 or false
                v_u_18.framerate = v16
                local v17 = v_u_3[p_u_12.instance]
                if v17 then
                    if v17 == v_u_18 then
                        return
                    end
                    v17.stop()
                end
                v_u_3[p_u_12.instance] = v_u_18
            end,
            ["isPlaying"] = function()
                return v_u_3[p_u_12.instance] == v_u_18
            end
        }
        local v_u_19 = 0
        local v_u_20 = tick()
        function v_u_18._nextFrame(p21)
            if p21 - v_u_20 >= 1 / v_u_18.framerate then
                v_u_20 = p21
                v_u_19 = v_u_19 + 1
                p_u_12.display(p_u_13[v_u_19])
                if v_u_19 >= #p_u_13 then
                    if v_u_18.looping then
                        v_u_19 = 0
                        return
                    end
                    v_u_18.stop()
                end
            end
        end
        function v_u_18.stop()
            v_u_19 = 0
            local v22 = v_u_3[p_u_12.instance]
            if v22 then
                if v22 == v_u_18 then
                    v_u_3[p_u_12.instance] = nil
                end
            else
                return
            end
        end
        return v_u_18
    end,
    ["fromRange"] = function(p23, p24, p25)
        local v26 = p25 - p24 > 0
        assert(v26, ".fromRange only accepts positive ranges")
        local v27 = {}
        for v28 = p24, p25 do
            v27[#v27 + 1] = v28
        end
        return v_u_29.new(p23, v27)
    end
}
return v_u_29