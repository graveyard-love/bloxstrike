local v1 = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.Types)
local v_u_2 = require(v1.Shared.Janitor)
require(v1.Database.Custom.GameStats.UI.Settings.Pages)
return function(p_u_3, p4, p5, p6, p_u_7, p8, p_u_9, p_u_10)
    p_u_7.Name = p_u_3
    p_u_7.Title.Text = p4.DisplayName or p_u_3
    p_u_7.LayoutOrder = p6
    local v_u_11 = p8
    local v_u_12 = v_u_2.new()
    v_u_12:Add(p_u_7, "Destroy")
    local v13 = v_u_11
    v_u_11 = math.floor(v13)
    local v14 = p_u_7.Frame.TextBox
    local v15 = v_u_11
    local v16 = math.floor(v15)
    v14.Text = tostring(v16)
    v_u_12:Add(p_u_7.Frame.TextBox.FocusLost:Connect(function()
        local v17 = p_u_7.Frame.TextBox.Text
        local v18 = tonumber(v17)
        if v18 then
            v_u_11 = math.floor(v18)
            local v19 = p_u_7.Frame.TextBox
            local v20 = v_u_11
            local v21 = math.floor(v20)
            v19.Text = tostring(v21)
            p_u_9(p_u_10, p_u_3, v_u_11)
        else
            local v22 = p_u_7.Frame.TextBox
            local v23 = v_u_11
            local v24 = math.floor(v23)
            v22.Text = tostring(v24)
        end
    end), "Disconnect")
    p_u_7.Parent = p5
    return function()
        v_u_12:Cleanup()
    end
end