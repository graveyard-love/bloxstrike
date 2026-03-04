local v_u_1 = {
    ["nil"] = 0,
    ["EnumItem"] = 4,
    ["boolean"] = 1,
    ["number"] = 8,
    ["UDim"] = 8,
    ["UDim2"] = 16,
    ["Ray"] = 24,
    ["Faces"] = 6,
    ["Axes"] = 6,
    ["BrickColor"] = 4,
    ["Color3"] = 12,
    ["Vector2"] = 8,
    ["Vector3"] = 12,
    ["Instance"] = 4,
    ["Vector2int16"] = 4,
    ["Vector3int16"] = 6,
    ["NumberSequenceKeypoint"] = 12,
    ["ColorSequenceKeypoint"] = 16,
    ["NumberRange"] = 8,
    ["Rect"] = 16,
    ["PhysicalProperties"] = 20,
    ["Color3uint8"] = 3
}
local v_u_2 = {
    [CFrame.Angles(0, 0, 0)] = true,
    [CFrame.Angles(0, 3.141592653589793, 0)] = true,
    [CFrame.Angles(1.5707963267948966, 0, 0)] = true,
    [CFrame.Angles(-1.5707963267948966, -3.141592653589793, 0)] = true,
    [CFrame.Angles(0, 3.141592653589793, 3.141592653589793)] = true,
    [CFrame.Angles(0, 0, 3.141592653589793)] = true,
    [CFrame.Angles(-1.5707963267948966, 0, 0)] = true,
    [CFrame.Angles(1.5707963267948966, 3.141592653589793, 0)] = true,
    [CFrame.Angles(0, 3.141592653589793, 1.5707963267948966)] = true,
    [CFrame.Angles(0, 0, -1.5707963267948966)] = true,
    [CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966)] = true,
    [CFrame.Angles(0, -1.5707963267948966, -1.5707963267948966)] = true,
    [CFrame.Angles(0, 0, 1.5707963267948966)] = true,
    [CFrame.Angles(0, -3.141592653589793, -1.5707963267948966)] = true,
    [CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966)] = true,
    [CFrame.Angles(0, 1.5707963267948966, -1.5707963267948966)] = true,
    [CFrame.Angles(-1.5707963267948966, -1.5707963267948966, 0)] = true,
    [CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0)] = true,
    [CFrame.Angles(0, -1.5707963267948966, 0)] = true,
    [CFrame.Angles(0, 1.5707963267948966, 0)] = true,
    [CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0)] = true,
    [CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 0)] = true,
    [CFrame.Angles(0, 1.5707963267948966, 3.141592653589793)] = true,
    [CFrame.Angles(0, -1.5707963267948966, 3.141592653589793)] = true
}
local function v_u_16(p3, p4)
    local v5 = typeof(p3)
    if v_u_1[v5] then
        return v_u_1[v5]
    end
    if v5 == "string" then
        return #p3 + 2
    end
    if v5 == "table" then
        if p4[p3] then
            return 0
        end
        p4[p3] = true
        local v6 = 1
        local v7 = 0
        local v8 = 0
        local v9 = true
        for v10, v11 in next, p3 do
            if v10 == v6 then
                v6 = v6 + 1
            else
                v9 = false
            end
            v7 = v7 + (v_u_16(v10, p4) + 1)
            v8 = v8 + (v_u_16(v11, p4) + 1)
        end
        return 1 + (v9 and #p3 + v8 or v7 + v8)
    end
    if v5 ~= "CFrame" then
        if v5 ~= "NumberSequence" and v5 ~= "ColorSequence" then
            warn("Unsupported data type: " .. v5)
            return 0
        end
        local v12 = 4
        for _, v13 in next, p3.Keypoints do
            v12 = v12 + v_u_16(v13, p4)
        end
        return v12
    end
    local v14 = false
    for v15 in next, v_u_2 do
        if v15 == p3.Rotation then
            v14 = true
            break
        end
    end
    return v14 and 13 or 21
end
local v22 = {
    ["RemoteOverhead"] = 9,
    ["TypeOverhead"] = 1,
    ["GetPacketSize"] = function(p17)
        local v18 = p17.IgnoreRemoteOffset and 0 or 9
        local v19 = {}
        for _, v20 in ipairs(p17.PacketData) do
            v18 = v18 + (v_u_16(v20, v19) + 1)
        end
        return v18
    end,
    ["GetDataByteSize"] = function(p21)
        return v_u_16(p21, {})
    end
}
table.freeze(v22)
return v22