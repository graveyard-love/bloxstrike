local v1 = require(script.GetPromiseLibrary)
local v_u_2 = require(script.RbxScriptConnection)
local v3 = require(script.Symbol)
local v_u_4, v_u_5 = v1()
local v_u_6 = v3("IndicesReference")
local v_u_7 = v3("LinkToInstanceIndex")
local v_u_8 = {
    ["ClassName"] = "Janitor",
    ["CurrentlyCleaning"] = true,
    ["SuppressInstanceReDestroy"] = false,
    [v_u_6] = nil
}
v_u_8.__index = v_u_8
local v_u_9 = {
    ["function"] = true,
    ["thread"] = true,
    ["RBXScriptConnection"] = "Disconnect"
}
function v_u_8.new()
    local v10 = {
        ["CurrentlyCleaning"] = false,
        [v_u_6] = nil
    }
    local v11 = v_u_8
    return setmetatable(v10, v11)
end
function v_u_8.Is(p12)
    local v13
    if type(p12) == "table" then
        v13 = getmetatable(p12) == v_u_8
    else
        v13 = false
    end
    return v13
end
function v_u_8.Add(p14, p15, p16, p17)
    if p17 then
        p14:Remove(p17)
        local v18 = p14[v_u_6]
        if not v18 then
            v18 = {}
            p14[v_u_6] = v18
        end
        v18[p17] = p15
    end
    local v19 = typeof(p15)
    local v20 = p16 or (v_u_9[v19] or "Destroy")
    if v19 == "function" or v19 == "thread" then
        if v20 ~= true then
            warn(string.format("Object is a %s and as such expected `true?` for the method name and instead got %s. Traceback: %s", v19, tostring(v20), debug.traceback(nil, 2)))
        end
    elseif not p15[v20] then
        warn(string.format("Object %s doesn\'t have method %s, are you sure you want to add it? Traceback: %s", tostring(p15), tostring(v20), debug.traceback(nil, 2)))
    end
    p14[p15] = v20
    return p15
end
function v_u_8.AddPromise(p21, p_u_22)
    if not v_u_4 then
        return p_u_22
    end
    if not v_u_5.is(p_u_22) then
        error(string.format("Invalid argument #1 to \'Janitor:AddPromise\' (Promise expected, got %s (%s)) Traceback: %s", typeof(p_u_22), tostring(p_u_22), debug.traceback(nil, 2)))
    end
    if p_u_22:getStatus() ~= v_u_5.Status.Started then
        return p_u_22
    end
    local v23 = newproxy(false)
    local v26 = p21:Add(v_u_5.new(function(p24, _, p25)
        if not p25(function()
            p_u_22:cancel()
        end) then
            p24(p_u_22)
        end
    end), "cancel", v23)
    v26:finallyCall(p21.Remove, p21, v23)
    return v26
end
function v_u_8.Remove(p27, p28)
    local v29 = p27[v_u_6]
    local v_u_30 = v29 and v29[p28]
    if v_u_30 then
        local v31 = p27[v_u_30]
        if v31 then
            if v31 == true then
                if type(v_u_30) == "function" then
                    v_u_30()
                else
                    local v32
                    if coroutine.running() == v_u_30 then
                        v32 = nil
                    else
                        v32 = pcall(function()
                            task.cancel(v_u_30)
                        end)
                    end
                    if not v32 then
                        task.defer(function()
                            if v_u_30 then
                                task.cancel(v_u_30)
                            end
                        end)
                    end
                end
            else
                local v33 = v_u_30[v31]
                if v33 then
                    if p27.SuppressInstanceReDestroy and (v31 == "Destroy" and typeof(v_u_30) == "Instance") then
                        pcall(v33, v_u_30)
                    else
                        v33(v_u_30)
                    end
                end
            end
            p27[v_u_30] = nil
        end
        v29[p28] = nil
    end
    return p27
end
function v_u_8.RemoveNoClean(p34, p35)
    local v36 = p34[v_u_6]
    if v36 then
        local v37 = v36[p35]
        if v37 then
            p34[v37] = nil
        end
        v36[p35] = nil
    end
    return p34
end
function v_u_8.RemoveList(p38, ...)
    if p38[v_u_6] then
        local v39 = select("#", ...)
        if v39 == 1 then
            return p38:Remove(...)
        end
        for v40 = 1, v39 do
            p38:Remove(select(v40, ...))
        end
    end
    return p38
end
function v_u_8.RemoveListNoClean(p41, ...)
    local v42 = p41[v_u_6]
    if v42 then
        local v43 = select("#", ...)
        if v43 == 1 then
            return p41:RemoveNoClean(...)
        end
        for v44 = 1, v43 do
            local v45 = select(v44, ...)
            local v46 = v42[v45]
            if v46 then
                p41[v46] = nil
            end
            v42[v45] = nil
        end
    end
    return p41
end
function v_u_8.Get(p47, p48)
    local v49 = p47[v_u_6]
    if v49 then
        return v49[p48]
    else
        return nil
    end
end
function v_u_8.GetAll(p50)
    local v51 = p50[v_u_6]
    return not v51 and {} or table.freeze(table.clone(v51))
end
function v_u_8.Cleanup(p_u_52)
    if not p_u_52.CurrentlyCleaning then
        p_u_52.CurrentlyCleaning = nil
        local function v55()
            for v53, v54 in next, p_u_52 do
                if v53 ~= v_u_6 then
                    return v53, v54
                end
            end
        end
        local v_u_56, v57 = v55()
        while v_u_56 and v57 do
            if v57 == true then
                if type(v_u_56) == "function" then
                    v_u_56()
                else
                    local v58
                    if coroutine.running() == v_u_56 then
                        v58 = nil
                    else
                        v58 = pcall(function()
                            task.cancel(v_u_56)
                        end)
                    end
                    if not v58 then
                        task.defer(function()
                            if v_u_56 then
                                task.cancel(v_u_56)
                            end
                        end)
                    end
                end
            else
                local v59 = v_u_56[v57]
                if v59 then
                    if p_u_52.SuppressInstanceReDestroy and (v57 == "Destroy" and typeof(v_u_56) == "Instance") then
                        pcall(v59, v_u_56)
                    else
                        v59(v_u_56)
                    end
                end
            end
            p_u_52[v_u_56] = nil
            v_u_56, v57 = v55()
        end
        local v60 = p_u_52[v_u_6]
        if v60 then
            table.clear(v60)
            p_u_52[v_u_6] = {}
        end
        p_u_52.CurrentlyCleaning = false
    end
end
function v_u_8.Destroy(p61)
    p61:Cleanup()
end
v_u_8.__call = v_u_8.Cleanup
function v_u_8.LinkToInstance(p_u_62, p63, p64)
    local v65 = p64 and newproxy(false) or v_u_7
    return p_u_62:Add(p63.Destroying:Connect(function()
        p_u_62:Cleanup()
    end), "Disconnect", v65)
end
function v_u_8.LegacyLinkToInstance(p_u_66, p67, p68)
    local v_u_69 = nil
    local v70 = p68 and newproxy(false) or v_u_7
    local v_u_71 = p67.Parent == nil
    local v72 = v_u_2
    local v_u_73 = setmetatable({}, v72)
    local function v75(_, p74)
        v_u_71 = v_u_73.Connected and p74 == nil
        if v_u_71 then
            task.defer(function()
                if v_u_73.Connected then
                    if v_u_69.Connected then
                        while v_u_71 and (v_u_69.Connected and v_u_73.Connected) do
                            task.wait()
                        end
                        if v_u_73.Connected and v_u_71 then
                            p_u_66:Cleanup()
                        end
                    else
                        p_u_66:Cleanup()
                    end
                else
                    return
                end
            end)
        end
    end
    local v_u_76 = p67.AncestryChanged:Connect(v75)
    v_u_73.Connection = v_u_76
    if v_u_71 then
        local v77 = p67.Parent
        if v_u_73.Connected then
            if v77 == nil then
                v_u_71 = true
            else
                v_u_71 = false
            end
            if v_u_71 then
                task.defer(function()
                    if v_u_73.Connected then
                        if v_u_76.Connected then
                            while v_u_71 and (v_u_76.Connected and v_u_73.Connected) do
                                task.wait()
                            end
                            if v_u_73.Connected and v_u_71 then
                                p_u_66:Cleanup()
                            end
                        else
                            p_u_66:Cleanup()
                        end
                    else
                        return
                    end
                end)
            end
        end
    end
    return p_u_66:Add(v_u_73, "Disconnect", v70)
end
function v_u_8.LinkToInstances(p78, ...)
    local v79 = v_u_8.new()
    for _, v80 in { ... } do
        v79:Add(p78:LinkToInstance(v80, true), "Disconnect")
    end
    return v79
end
function v_u_8.__tostring(_)
    return "Janitor"
end
table.freeze(v_u_8)
return v_u_8