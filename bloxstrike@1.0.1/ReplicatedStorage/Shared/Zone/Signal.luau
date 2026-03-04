local v_u_1 = nil
local function v_u_4(p2, ...)
    local v3 = v_u_1
    v_u_1 = nil
    p2(...)
    v_u_1 = v3
end
local function v_u_5(...)
    v_u_4(...)
    while true do
        v_u_4(coroutine.yield())
    end
end
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6.new(p7, p8)
    local v9 = v_u_6
    return setmetatable({
        ["_connected"] = true,
        ["_signal"] = p7,
        ["_fn"] = p8,
        ["_next"] = false
    }, v9)
end
function v_u_6.Disconnect(p10)
    local v11 = p10._connected
    assert(v11, "Can\'t disconnect a connection twice.", 2)
    p10._connected = false
    local v12 = p10._signal
    if v12._handlerListHead == p10 then
        v12._handlerListHead = p10._next
    else
        local v13 = v12._handlerListHead
        while v13 and v13._next ~= p10 do
            v13 = v13._next
        end
        if v13 then
            v13._next = p10._next
        end
    end
    if v12.connectionsChanged then
        v12.totalConnections = v12.totalConnections - 1
        v12.connectionsChanged:Fire(-1)
    end
end
setmetatable(v_u_6, {
    ["__index"] = function(_, p14)
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p14))), 2)
    end,
    ["__newindex"] = function(_, p15, _)
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p15))), 2)
    end
})
local v_u_16 = {}
v_u_16.__index = v_u_16
function v_u_16.new(p17)
    local v18 = v_u_16
    local v19 = setmetatable({
        ["_handlerListHead"] = false
    }, v18)
    if p17 then
        v19.totalConnections = 0
        v19.connectionsChanged = v_u_16.new()
    end
    return v19
end
function v_u_16.Connect(p20, p21)
    local v22 = v_u_6.new(p20, p21)
    if p20._handlerListHead then
        v22._next = p20._handlerListHead
        p20._handlerListHead = v22
    else
        p20._handlerListHead = v22
    end
    if p20.connectionsChanged then
        p20.totalConnections = p20.totalConnections + 1
        p20.connectionsChanged:Fire(1)
    end
    return v22
end
function v_u_16.DisconnectAll(p23)
    p23._handlerListHead = false
    if p23.connectionsChanged then
        p23.connectionsChanged:Fire(-p23.totalConnections)
        p23.connectionsChanged:Destroy()
        p23.connectionsChanged = nil
        p23.totalConnections = 0
    end
end
v_u_16.Destroy = v_u_16.DisconnectAll
v_u_16.destroy = v_u_16.DisconnectAll
function v_u_16.Fire(p24, ...)
    local v25 = p24._handlerListHead
    while v25 do
        if v25._connected then
            if not v_u_1 then
                v_u_1 = coroutine.create(v_u_5)
            end
            task.spawn(v_u_1, v25._fn, ...)
        end
        v25 = v25._next
    end
end
function v_u_16.Wait(p26)
    local v_u_27 = coroutine.running()
    local v_u_28 = nil
    v_u_28 = p26:Connect(function(...)
        v_u_28:Disconnect()
        task.spawn(v_u_27, ...)
    end)
    return coroutine.yield()
end
return v_u_16