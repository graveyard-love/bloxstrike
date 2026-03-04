local v_u_1 = game:GetService("HttpService")
return function(p_u_2)
    local v3, v_u_4 = pcall(function()
        return v_u_1:JSONEncode(p_u_2)
    end)
    if not (v3 and v_u_4) then
        return p_u_2
    end
    local v5, v6 = pcall(function()
        return v_u_1:JSONDecode(v_u_4)
    end)
    if not (v5 and v6) then
        return p_u_2
    end
    for _, v7 in ipairs({
        "_id",
        "Type",
        "Name",
        "Skin",
        "Rarity",
        "OriginalOwner"
    }) do
        if v6[v7] ~= nil then
            local v8 = v6[v7]
            if typeof(v8) == "number" then
                local v9 = v6[v7]
                v6[v7] = tostring(v9)
            end
        end
    end
    if v6.MetaData then
        local v10 = v6.MetaData
        if typeof(v10) == "table" then
            for _, v11 in ipairs({
                "LastTradeAt",
                "CreatedAt",
                "OriginalOwner",
                "Owner",
                "Origin"
            }) do
                if v6.MetaData[v11] ~= nil then
                    local v12 = v6.MetaData[v11]
                    if typeof(v12) == "number" then
                        local v13 = v6.MetaData
                        local v14 = v6.MetaData[v11]
                        v13[v11] = tostring(v14)
                    end
                end
            end
        end
    end
    return v6
end