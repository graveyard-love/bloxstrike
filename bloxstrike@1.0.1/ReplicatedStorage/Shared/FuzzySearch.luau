return {
    ["GetNames"] = function(p1)
        local v2 = {}
        for v3 = 1, #p1 do
            local v4 = p1[v3].Name
            if not v4 then
                local v5 = p1[v3]
                v4 = tostring(v5)
            end
            v2[v3] = v4
        end
        return v2
    end,
    ["MakeFuzzyFinder"] = function(p6)
        local v_u_7 = nil
        local v_u_8 = {}
        if typeof(p6) == "Enum" then
            p6 = p6:GetEnumItems()
        end
        if typeof(p6) == "Instance" then
            v_u_8 = p6:GetChildren()
            v_u_7 = {}
            for v9 = 1, #v_u_8 do
                v_u_7[v9] = v_u_8[v9].Name
            end
            ::l8::
            return function(p10, p11)
                local v12 = {}
                for v13, v14 in pairs(v_u_7) do
                    local v15
                    if v_u_8 then
                        v15 = v_u_8[v13] or v14
                    else
                        v15 = v14
                    end
                    if v14:lower() == p10:lower() then
                        if p11 then
                            return v15
                        end
                        table.insert(v12, 1, v15)
                    elseif v14:lower():find(p10:lower(), 1, true) then
                        v12[#v12 + 1] = v15
                    end
                end
                if p11 then
                    return v12[1]
                else
                    return v12
                end
            end
        end
        if typeof(p6) ~= "table" then
            error("MakeFuzzyFinder only accepts a table, Enum, or Instance.")
            goto l8
        end
        local v16 = p6[1]
        if typeof(v16) ~= "Instance" then
            local v17 = p6[1]
            if typeof(v17) ~= "EnumItem" then
                local v18 = p6[1]
                if typeof(v18) ~= "table" then
                    ::l15::
                    local v19 = p6[1]
                    if type(v19) == "string" then
                        v_u_7 = p6
                    elseif p6[1] == nil then
                        v_u_7 = {}
                    else
                        error("MakeFuzzyFinder only accepts tables of instances or strings.")
                    end
                    goto l8
                end
                local v20 = p6[1].Name
                if typeof(v20) ~= "string" then
                    goto l15
                end
            end
        end
        v_u_7 = {}
        v_u_8 = p6
        for v21 = 1, #p6 do
            v_u_7[v21] = v_u_8[v21].Name
            p6 = v_u_8
            v_u_8 = p6
        end
        goto l8
    end
}