local v1 = game:GetService("ReplicatedStorage")
require(v1.Database.Custom.Types)
local v_u_2 = {
    ["FR"] = "ForwardRight",
    ["FL"] = "ForwardLeft",
    ["F"] = "Forward",
    ["BR"] = "BackwardRight",
    ["BL"] = "BackwardLeft",
    ["B"] = "Backward",
    ["R"] = "Right",
    ["L"] = "Left"
}
return function(p3)
    local v4 = p3.PrimaryPart
    local v5, v6, v7, v8
    if v4 then
        local v9 = v4.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
        if v9.Magnitude < 0.1 then
            v5 = false
            v6 = false
            v7 = false
            v8 = false
        else
            local v10 = v4.CFrame.RightVector:Dot(v9.Unit)
            local v11 = v4.CFrame.LookVector:Dot(v9.Unit)
            v6 = v11 < -0.3
            v5 = v11 > 0.3
            v8 = v10 > 0.3
            v7 = v10 < -0.3
        end
    else
        v5 = false
        v6 = false
        v7 = false
        v8 = false
    end
    return v_u_2[table.concat({
        v5 and "F" or "",
        v6 and "B" or "",
        v7 and "L" or "",
        v8 and "R" or ""
    })]
end