local v_u_1 = game:GetService("ReplicatedStorage")
return {
    ["addToReplicatedStorage"] = function()
        if v_u_1:FindFirstChild(script.Name) then
            return false
        end
        local v2 = Instance.new("ObjectValue")
        v2.Name = script.Name
        v2.Value = script.Parent
        v2.Parent = v_u_1
        local v3 = Instance.new("BoolValue")
        v3.Name = game:GetService("RunService"):IsClient() and "Client" or "Server"
        v3.Value = true
        v3.Parent = v2
        return v2
    end,
    ["getObject"] = function()
        return v_u_1:FindFirstChild(script.Name) or false
    end
}