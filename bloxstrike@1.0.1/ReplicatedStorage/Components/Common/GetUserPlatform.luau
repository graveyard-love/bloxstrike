local v_u_1 = game:GetService("UserInputService")
return function()
    local v2 = {}
    if v_u_1.GamepadEnabled then
        table.insert(v2, "Console")
    end
    if v_u_1.VREnabled then
        table.insert(v2, "VR")
    end
    if v_u_1.MouseEnabled or v_u_1.KeyboardEnabled then
        table.insert(v2, "PC")
    end
    if v_u_1.TouchEnabled and not table.find(v2, "PC") then
        table.insert(v2, "Mobile")
    end
    return v2
end