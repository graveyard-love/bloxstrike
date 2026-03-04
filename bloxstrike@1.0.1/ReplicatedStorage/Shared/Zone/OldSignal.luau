local v_u_1 = game:GetService("HttpService")
local v_u_2 = game:GetService("RunService").Heartbeat
local v_u_3 = {}
v_u_3.__index = v_u_3
v_u_3.ClassName = "Signal"
v_u_3.totalConnections = 0
function v_u_3.new(p4)
    local v5 = v_u_3
    local v6 = setmetatable({}, v5)
    if p4 then
        v6.connectionsChanged = v_u_3.new()
    end
    v6.connections = {}
    v6.totalConnections = 0
    v6.waiting = {}
    v6.totalWaiting = 0
    return v6
end
function v_u_3.Fire(p7, ...)
    for _, v8 in pairs(p7.connections) do
        task.spawn(v8.Handler, ...)
    end
    if p7.totalWaiting > 0 then
        local v9 = table.pack(...)
        for v10, _ in pairs(p7.waiting) do
            p7.waiting[v10] = v9
        end
    end
end
v_u_3.fire = v_u_3.Fire
function v_u_3.Connect(p_u_11, p12)
    if type(p12) ~= "function" then
        error(("connect(%s)"):format((typeof(p12))), 2)
    end
    local v_u_13 = v_u_1:GenerateGUID(false)
    local v_u_14 = {
        ["Connected"] = true,
        ["ConnectionId"] = v_u_13,
        ["Handler"] = p12
    }
    p_u_11.connections[v_u_13] = v_u_14
    function v_u_14.Disconnect(_)
        p_u_11.connections[v_u_13] = nil
        v_u_14.Connected = false
        local v15 = p_u_11
        v15.totalConnections = v15.totalConnections - 1
        if p_u_11.connectionsChanged then
            p_u_11.connectionsChanged:Fire(-1)
        end
    end
    v_u_14.Destroy = v_u_14.Disconnect
    v_u_14.destroy = v_u_14.Disconnect
    v_u_14.disconnect = v_u_14.Disconnect
    p_u_11.totalConnections = p_u_11.totalConnections + 1
    if p_u_11.connectionsChanged then
        p_u_11.connectionsChanged:Fire(1)
    end
    return v_u_14
end
v_u_3.connect = v_u_3.Connect
function v_u_3.Wait(p16)
    local v17 = v_u_1:GenerateGUID(false)
    p16.waiting[v17] = true
    p16.totalWaiting = p16.totalWaiting + 1
    repeat
        v_u_2:Wait()
    until p16.waiting[v17] ~= true
    p16.totalWaiting = p16.totalWaiting - 1
    local v18 = p16.waiting[v17]
    p16.waiting[v17] = nil
    return unpack(v18)
end
v_u_3.wait = v_u_3.Wait
function v_u_3.Destroy(p19)
    if p19.bindableEvent then
        p19.bindableEvent:Destroy()
        p19.bindableEvent = nil
    end
    if p19.connectionsChanged then
        p19.connectionsChanged:Fire(-p19.totalConnections)
        p19.connectionsChanged:Destroy()
        p19.connectionsChanged = nil
    end
    p19.totalConnections = 0
    for v20, _ in pairs(p19.connections) do
        p19.connections[v20] = nil
    end
end
v_u_3.destroy = v_u_3.Destroy
v_u_3.Disconnect = v_u_3.Destroy
v_u_3.disconnect = v_u_3.Destroy
return v_u_3