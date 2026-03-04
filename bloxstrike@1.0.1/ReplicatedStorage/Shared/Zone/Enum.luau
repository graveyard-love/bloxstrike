local v1 = {}
local v_u_2 = {}
v1.enums = v_u_2
function v1.createEnum(p3, p_u_4)
    local v5 = typeof(p3) == "string"
    assert(v5, "bad argument #1 - enums must be created using a string name!")
    local v6 = typeof(p_u_4) == "table"
    assert(v6, "bad argument #2 - enums must be created using a table!")
    local v7 = not v_u_2[p3]
    assert(v7, ("enum \'%s\' already exists!"):format(p3))
    local v_u_8 = {}
    local v_u_9 = {}
    local v_u_10 = {}
    local v11 = {}
    local v_u_21 = {
        ["getName"] = function(p12)
            local v13 = tostring(p12)
            local v14 = v_u_9[v13] or v_u_10[v13]
            if v14 then
                return p_u_4[v14][1]
            end
        end,
        ["getValue"] = function(p15)
            local v16 = tostring(p15)
            local v17 = v_u_8[v16] or v_u_10[v16]
            if v17 then
                return p_u_4[v17][2]
            end
        end,
        ["getProperty"] = function(p18)
            local v19 = tostring(p18)
            local v20 = v_u_8[v19] or v_u_9[v19]
            if v20 then
                return p_u_4[v20][3]
            end
        end
    }
    for v22, v23 in pairs(p_u_4) do
        local v24 = typeof(v23) == "table"
        assert(v24, ("bad argument #2.%s - details must only be comprised of tables!"):format(v22))
        local v25 = v23[1]
        local v26 = typeof(v25) == "string"
        assert(v26, ("bad argument #2.%s.1 - detail name must be a string!"):format(v22))
        local v27 = not v_u_8[v25]
        local v28 = typeof(v27)
        assert(v28, ("bad argument #2.%s.1 - the detail name \'%s\' already exists!"):format(v22, v25))
        local v29 = not v_u_21[v25]
        local v30 = typeof(v29)
        assert(v30, ("bad argument #2.%s.1 - that name is reserved."):format(v22, v25))
        v_u_8[tostring(v25)] = v22
        local v31 = v23[2]
        local v32 = tostring(v31)
        local v33 = not v_u_9[v32]
        local v34 = typeof(v33)
        assert(v34, ("bad argument #2.%s.2 - the detail value \'%s\' already exists!"):format(v22, v32))
        v_u_9[v32] = v22
        local v35 = v23[3]
        if v35 then
            local v36 = not v_u_10[v35]
            local v37 = typeof(v36)
            local v38 = tostring(v35)
            assert(v37, ("bad argument #2.%s.3 - the detail property \'%s\' already exists!"):format(v22, v38))
            v_u_10[tostring(v35)] = v22
        end
        v11[v25] = v31
        setmetatable(v11, {
            ["__index"] = function(_, p39)
                return v_u_21[p39]
            end
        })
    end
    v_u_2[p3] = v11
    return v11
end
function v1.getEnums()
    return v_u_2
end
local v40 = v1.createEnum
for _, v41 in pairs(script:GetChildren()) do
    if v41:IsA("ModuleScript") then
        local v42 = require(v41)
        v40(v41.Name, v42)
    end
end
return v1