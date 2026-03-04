local v1 = {}
local function v_u_5(p2)
    local v3 = {}
    local v4
    if p2:IsA("GuiObject") then
        v3.BackgroundTransparency = p2.BackgroundTransparency
        v4 = true
    else
        v4 = false
    end
    if p2:IsA("ImageLabel") or p2:IsA("ImageButton") then
        v3.ImageTransparency = p2.ImageTransparency
        v4 = true
    end
    if p2:IsA("TextLabel") or (p2:IsA("TextButton") or p2:IsA("TextBox")) then
        v3.TextTransparency = p2.TextTransparency
        v4 = true
    end
    if v4 then
        return v3
    else
        return nil
    end
end
function v1.BuildCache(p6)
    local v7 = {}
    local v8 = v_u_5(p6)
    if v8 then
        v7[p6] = v8
    end
    for _, v9 in ipairs(p6:GetDescendants()) do
        local v10 = v_u_5(v9)
        if v10 then
            v7[v9] = v10
        end
    end
    return v7
end
function v1.Apply(p11, p12, p13)
    local v14 = math.clamp(p13, 0, 1)
    for v15, v16 in pairs(p12) do
        if v15:IsDescendantOf(p11) then
            if v16.BackgroundTransparency ~= nil and v15:IsA("GuiObject") then
                local v17 = v16.BackgroundTransparency + v14
                v15.BackgroundTransparency = math.clamp(v17, 0, 1)
            end
            if v16.ImageTransparency ~= nil and (v15:IsA("ImageLabel") or v15:IsA("ImageButton")) then
                local v18 = v16.ImageTransparency + v14
                v15.ImageTransparency = math.clamp(v18, 0, 1)
            end
            if v16.TextTransparency ~= nil and (v15:IsA("TextLabel") or (v15:IsA("TextButton") or v15:IsA("TextBox"))) then
                local v19 = v16.TextTransparency + v14
                v15.TextTransparency = math.clamp(v19, 0, 1)
            end
        else
            p12[v15] = nil
        end
    end
end
return v1