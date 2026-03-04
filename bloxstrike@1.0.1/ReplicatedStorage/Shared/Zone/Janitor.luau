local v_u_1 = game:GetService("RunService").Heartbeat
local v_u_2 = newproxy(true)
getmetatable(v_u_2).__tostring = function()
    return "IndicesReference"
end
local v_u_3 = newproxy(true)
getmetatable(v_u_3).__tostring = function()
    return "LinkToInstanceIndex"
end
local v_u_4 = {
    ["ClassName"] = "Janitor",
    ["__index"] = {
        ["CurrentlyCleaning"] = true,
        [v_u_2] = nil
    }
}
local v_u_5 = {
    ["function"] = true,
    ["RBXScriptConnection"] = "Disconnect"
}
function v_u_4.new()
    local v6 = {
        ["CurrentlyCleaning"] = false,
        [v_u_2] = nil
    }
    local v7 = v_u_4
    return setmetatable(v6, v7)
end
function v_u_4.Is(p8)
    local v9
    if type(p8) == "table" then
        v9 = getmetatable(p8) == v_u_4
    else
        v9 = false
    end
    return v9
end
v_u_4.is = v_u_4.Is
function v_u_4.__index.Add(p10, p11, p12, p13)
    if p13 == nil then
        p13 = newproxy(false)
    end
    if p13 then
        p10:Remove(p13)
        local v14 = p10[v_u_2]
        if not v14 then
            v14 = {}
            p10[v_u_2] = v14
        end
        v14[p13] = p11
    end
    local v15 = p12 or (v_u_5[typeof(p11)] or "Destroy")
    if type(p11) ~= "function" and not p11[v15] then
        warn(string.format("Object %s doesn\'t have method %s, are you sure you want to add it? Traceback: %s", tostring(p11), tostring(v15), debug.traceback(nil, 2)))
    end
    p10[p11] = v15
    return p11, p13
end
v_u_4.__index.Give = v_u_4.__index.Add
function v_u_4.__index.AddObject(p16, p17)
    local v18 = newproxy(false)
    return p16:Add(p17, false, v18), v18
end
v_u_4.__index.GiveObject = v_u_4.__index.AddObject
function v_u_4.__index.Remove(p19, p20)
    local v21 = p19[v_u_2]
    local v22 = v21 and v21[p20]
    if v22 then
        local v23 = p19[v22]
        if v23 then
            if v23 == true then
                v22()
            else
                local v24 = v22[v23]
                if v24 then
                    v24(v22)
                end
            end
            p19[v22] = nil
        end
        v21[p20] = nil
    end
    return p19
end
function v_u_4.__index.Get(p25, p26)
    local v27 = p25[v_u_2]
    if v27 then
        return v27[p26]
    end
end
function v_u_4.__index.Cleanup(p28)
    if not p28.CurrentlyCleaning then
        p28.CurrentlyCleaning = nil
        for v29, v30 in next, p28 do
            if v29 ~= v_u_2 then
                local v31 = type(v29)
                if v31 == "string" or v31 == "number" then
                    p28[v29] = nil
                else
                    if v30 == true then
                        v29()
                    else
                        local v32 = v29[v30]
                        if v32 then
                            v32(v29)
                        end
                    end
                    p28[v29] = nil
                end
            end
        end
        local v33 = p28[v_u_2]
        if v33 then
            for v34 in next, v33 do
                v33[v34] = nil
            end
            p28[v_u_2] = {}
        end
        p28.CurrentlyCleaning = false
    end
end
v_u_4.__index.Clean = v_u_4.__index.Cleanup
function v_u_4.__index.Destroy(p35)
    p35:Cleanup()
end
v_u_4.__call = v_u_4.__index.Cleanup
local v_u_36 = {
    ["Connected"] = true
}
v_u_36.__index = v_u_36
function v_u_36.Disconnect(p37)
    if p37.Connected then
        p37.Connected = false
        p37.Connection:Disconnect()
    end
end
function v_u_36.__tostring(p38)
    local v39 = p38.Connected
    return "Disconnect<" .. tostring(v39) .. ">"
end
function v_u_4.__index.LinkToInstance(p_u_40, p41, p42)
    local v_u_43 = nil
    local v44 = p42 and newproxy(false) or v_u_3
    local v_u_45 = p41.Parent == nil
    local v46 = v_u_36
    local v_u_47 = setmetatable({}, v46)
    local function v49(_, p48)
        v_u_45 = v_u_47.Connected and p48 == nil
        if v_u_45 then
            coroutine.wrap(function()
                v_u_1:Wait()
                if v_u_47.Connected then
                    if v_u_43.Connected then
                        while v_u_45 and (v_u_43.Connected and v_u_47.Connected) do
                            v_u_1:Wait()
                        end
                        if v_u_47.Connected and v_u_45 then
                            p_u_40:Cleanup()
                        end
                    else
                        p_u_40:Cleanup()
                    end
                else
                    return
                end
            end)()
        end
    end
    local v_u_50 = p41.AncestryChanged:Connect(v49)
    v_u_47.Connection = v_u_50
    if v_u_45 then
        local v51 = p41.Parent
        if v_u_47.Connected then
            if v51 == nil then
                v_u_45 = true
            else
                v_u_45 = false
            end
            if v_u_45 then
                coroutine.wrap(function()
                    v_u_1:Wait()
                    if v_u_47.Connected then
                        if v_u_50.Connected then
                            while v_u_45 and (v_u_50.Connected and v_u_47.Connected) do
                                v_u_1:Wait()
                            end
                            if v_u_47.Connected and v_u_45 then
                                p_u_40:Cleanup()
                            end
                        else
                            p_u_40:Cleanup()
                        end
                    else
                        return
                    end
                end)()
            end
        end
    end
    return p_u_40:Add(v_u_47, "Disconnect", v44)
end
function v_u_4.__index.LinkToInstances(p52, ...)
    local v53 = v_u_4.new()
    for _, v54 in ipairs({ ... }) do
        v53:Add(p52:LinkToInstance(v54, true), "Disconnect")
    end
    return v53
end
for v55, v56 in next, v_u_4.__index do
    local v57 = string.lower(v55)
    local v58 = string.sub(v57, 1, 1) .. string.sub(v55, 2)
    v_u_4.__index[v58] = v56
end
return v_u_4