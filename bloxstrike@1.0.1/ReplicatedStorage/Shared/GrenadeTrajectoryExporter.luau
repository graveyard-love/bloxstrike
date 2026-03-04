local v_u_1 = game:GetService("HttpService")
local v_u_66 = {
    ["startRecording"] = function(p2, p3, p4, p5, p6, p7)
        local v8 = {
            ["grenade_type"] = p2,
            ["throw_type"] = p3,
            ["start_position"] = { p4.X, p4.Y, p4.Z }
        }
        local v9 = p5.Unit
        v8.throw_direction = { v9.X, v9.Y, v9.Z }
        v8.player_velocity = { p6.X, p6.Y, p6.Z }
        v8.player_state = p7 or "standing"
        v8.map_name = ""
        v8.start_time = tick()
        v8.points = {}
        v8.bounces = {}
        v8.end_position = nil
        v8.end_reason = nil
        return v8
    end,
    ["recordPoint"] = function(p10, p11, p12)
        local v13 = p11.simulationTime * 1000
        local v14 = math.floor(v13)
        if p12 or v14 - (#p10.points <= 0 and -16 or p10.points[#p10.points].time_ms) >= 16 then
            local v15 = {
                ["time_ms"] = v14
            }
            local v16 = p11.position
            v15.position = { v16.X, v16.Y, v16.Z }
            local v17 = p11.velocity
            v15.velocity = { v17.X, v17.Y, v17.Z }
            v15.speed = p11.velocity.Magnitude
            local v18 = p10.points
            table.insert(v18, v15)
        end
    end,
    ["recordBounce"] = function(p19, p20, p21, p22)
        local v23 = p20.normal or Vector3.new(0, 1, 0)
        local v24 = p20.velocity
        local v25 = {}
        local v26 = (p20.timestamp - (p19.start_time or p20.timestamp)) * 1000
        v25.time_ms = math.floor(v26)
        local v27 = p20.position
        v25.position = { v27.X, v27.Y, v27.Z }
        v25.velocity_before = { p21.X, p21.Y, p21.Z }
        v25.velocity_after = { v24.X, v24.Y, v24.Z }
        v25.surface_normal = { v23.X, v23.Y, v23.Z }
        v25.surface_type = p22 or "world"
        local v28 = p21.Magnitude
        local v29
        if v28 < 0.001 then
            v29 = 0
        else
            local v30 = (p21 / v28):Dot(v23)
            local v31 = math.abs(v30)
            local v32 = math.clamp(v31, -1, 1)
            local v33 = math.acos(v32)
            v29 = math.deg(v33)
        end
        v25.incident_angle = v29
        local v34 = v24.Magnitude
        local v35
        if v34 < 0.001 then
            v35 = 0
        else
            local v36 = (v24 / v34):Dot(v23)
            local v37 = math.abs(v36)
            local v38 = math.clamp(v37, -1, 1)
            local v39 = math.acos(v38)
            v35 = math.deg(v39)
        end
        v25.reflection_angle = v35
        local v40 = p19.bounces
        table.insert(v40, v25)
    end,
    ["finishRecording"] = function(p41, p42, p43)
        p41.end_position = { p42.X, p42.Y, p42.Z }
        p41.end_reason = p43
    end,
    ["exportJSON"] = function(p44, p45)
        local v46 = #p44.points <= 0 and 0 or p44.points[#p44.points].time_ms
        local v47 = {
            ["metadata"] = {
                ["source"] = "roblox",
                ["grenade_type"] = p44.grenade_type,
                ["throw_type"] = p44.throw_type,
                ["map"] = p45 or (p44.map_name or ""),
                ["coordinate_system"] = {
                    ["up_axis"] = "y",
                    ["unit"] = "studs"
                }
            },
            ["throw_params"] = {
                ["start_position"] = p44.start_position,
                ["throw_direction"] = p44.throw_direction,
                ["player_velocity"] = p44.player_velocity,
                ["player_state"] = p44.player_state
            },
            ["trajectory"] = p44.points,
            ["bounces"] = p44.bounces,
            ["summary"] = {
                ["duration_ms"] = v46,
                ["bounce_count"] = #p44.bounces,
                ["end_position"] = p44.end_position,
                ["end_reason"] = p44.end_reason
            }
        }
        return v_u_1:JSONEncode(v47)
    end,
    ["simulateAndExport"] = function(p48, p49, p50, p51, p52, p53, p54, p55, p56)
        local v57, v58 = p48.calculateThrowParameters(p51, p52, p50, p54.rangeScale)
        local v59 = p48.createInitialState(v57, v58, p50, p53, p54.rangeScale, tick())
        local v60 = p50 == "Far" and "left" or "right"
        local v61 = v_u_66.startRecording(p49, v60, v57, v58, p53, p53.Magnitude > 1 and "walking" or "standing")
        v_u_66.recordPoint(v61, v59, true)
        local v62 = 0
        while not v59.isAtRest and v62 < 10000 do
            v62 = v62 + 1
            local v63 = v59.velocity
            local v64 = p48.simulate(v59, p54, p55, 0.016666666666666666)
            v59 = v64.state
            v_u_66.recordPoint(v61, v59)
            for _, v65 in v64.events do
                if v65.type == "bounce" then
                    v_u_66.recordBounce(v61, v65, v63)
                elseif v65.type == "rest" or (v65.type == "fuse" or v65.type == "floor_impact") then
                    v_u_66.finishRecording(v61, v65.position, v65.type)
                end
            end
        end
        if not v61.end_reason then
            v_u_66.finishRecording(v61, v59.position, "timeout")
        end
        v_u_66.recordPoint(v61, v59, true)
        return v_u_66.exportJSON(v61, p56)
    end
}
return v_u_66