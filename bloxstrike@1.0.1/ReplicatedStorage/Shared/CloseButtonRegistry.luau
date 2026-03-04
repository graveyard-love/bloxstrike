local v_u_1 = {}
local v2 = game:GetService("UserInputService")
local v_u_3 = {}
local v_u_4 = 0
function v_u_1.IsDoublePressed()
    return tick() - v_u_4 < 0.1
end
function v_u_1.Add(p_u_5, p_u_6, p_u_7)
    local v8 = v_u_3
    table.insert(v8, {
        ["closeButton"] = p_u_6,
        ["onClose"] = p_u_7,
        ["frame"] = p_u_5
    })
    if p_u_6 then
        p_u_6.MouseButton1Click:Connect(function()
            p_u_7(p_u_5, p_u_6)
        end)
        p_u_6.Activated:Connect(function(p9)
            if p9 and p9.UserInputType == Enum.UserInputType.Gamepad1 then
                p_u_7(p_u_5, p_u_6)
            end
        end)
    end
end
function v_u_1.CloseFrame()
    for v10 = #v_u_3, 1, -1 do
        local v11 = v_u_3[v10]
        if v11.frame.Parent and v11.frame.Visible then
            v11.onClose(v11.frame, v11.closeButton)
            v_u_4 = tick()
            return true
        end
    end
    return false
end
v2.InputBegan:Connect(function(p12)
    if p12.UserInputType == Enum.UserInputType.Gamepad1 and p12.KeyCode == Enum.KeyCode.ButtonB then
        v_u_1.CloseFrame()
    end
end)
return v_u_1