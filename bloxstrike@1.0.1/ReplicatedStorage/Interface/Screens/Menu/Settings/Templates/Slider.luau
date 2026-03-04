local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("GuiService")
require(script.Parent.Parent.Types)
local v_u_4 = require(v1.Shared.Janitor)
require(v1.Database.Custom.GameStats.UI.Settings.Pages)
return function(p_u_5, p6, p7, p8, p_u_9, p10, p11, p_u_12, p_u_13)
    p_u_9.Name = p_u_5
    p_u_9.Title.Text = p6.DisplayName or p_u_5
    p_u_9.LayoutOrder = p8
    local v_u_14 = p6.HasEnabledToggle or false
    local v_u_15 = p6.Step or 1
    local v_u_16 = p6.Max or 100
    local v_u_17 = p6.Min or 0
    local v_u_18 = p10
    local v_u_19 = false
    local v_u_20 = p11 == nil and true or (p11 or true)
    local v_u_21 = v_u_4.new()
    v_u_21:Add(p_u_9, "Destroy")
    local v_u_22 = p_u_9.Slider
    local v_u_23 = p_u_9.Slider.Button
    v_u_22.AutoButtonColor = false
    v_u_22.Active = false
    v_u_23.AutoButtonColor = false
    v_u_23.Active = false
    if p_u_9.Check and not v_u_14 then
        p_u_9.Check.Visible = false
    end
    local function v_u_36(p24, p25)
        local v26 = v_u_17
        local v27 = v_u_16
        local v28 = math.clamp(p24, v26, v27) / v_u_15
        local v29 = math.round(v28) * v_u_15
        v_u_18 = v29
        local v30 = (v29 - v_u_17) / (v_u_16 - v_u_17)
        p_u_9.Slider.Bar.Size = UDim2.new(v30, 0, 1, 0)
        p_u_9.Slider.Button.Position = UDim2.new(v30, 0, 0.5, 0)
        local v31 = p_u_9.Frame.TextBox
        local v32 = v29 * 100
        local v33 = math.round(v32) / 100
        local v34
        if v33 == math.floor(v33) then
            local v35 = math.floor(v33)
            v34 = tostring(v35)
        else
            v34 = string.format("%.2f", v33):gsub("%.?0+$", "")
        end
        v31.Text = v34
        if p25 then
            p_u_12(p_u_13, p_u_5, v_u_18, true)
        end
    end
    v_u_36(v_u_18)
    v_u_21:Add(v_u_22.InputBegan:Connect(function(p37)
        if (p37.UserInputType == Enum.UserInputType.MouseButton1 or p37.UserInputType == Enum.UserInputType.Touch) and v_u_20 then
            v_u_19 = true
            local v38 = v_u_3:GetGuiInset()
            local v39 = p37.Position.X - v38.X
            local v40 = v_u_22.AbsolutePosition.X
            local v41 = v_u_22.AbsoluteSize.X
            local v42 = (v39 - v40) / v41
            v_u_36(v_u_17 + math.clamp(v42, 0, 1) * (v_u_16 - v_u_17), nil)
        end
    end), "Disconnect")
    v_u_21:Add(v_u_22.InputEnded:Connect(function(p43)
        if (p43.UserInputType == Enum.UserInputType.MouseButton1 or p43.UserInputType == Enum.UserInputType.Touch) and v_u_19 then
            v_u_19 = false
            if v_u_14 then
                p_u_12(p_u_13, p_u_5, {
                    ["Enabled"] = v_u_20,
                    ["Value"] = v_u_18
                }, false)
            else
                p_u_12(p_u_13, p_u_5, v_u_18, false)
            end
        else
            return
        end
    end), "Disconnect")
    v_u_21:Add(v_u_23.InputBegan:Connect(function(p44)
        if (p44.UserInputType == Enum.UserInputType.MouseButton1 or p44.UserInputType == Enum.UserInputType.Touch) and v_u_20 then
            v_u_19 = true
            local v45 = v_u_3:GetGuiInset()
            local v46 = p44.Position.X - v45.X
            local v47 = v_u_22.AbsolutePosition.X
            local v48 = v_u_22.AbsoluteSize.X
            local v49 = (v46 - v47) / v48
            v_u_36(v_u_17 + math.clamp(v49, 0, 1) * (v_u_16 - v_u_17), nil)
        end
    end), "Disconnect")
    v_u_21:Add(v_u_23.InputEnded:Connect(function(p50)
        if (p50.UserInputType == Enum.UserInputType.MouseButton1 or p50.UserInputType == Enum.UserInputType.Touch) and v_u_19 then
            v_u_19 = false
            if v_u_14 then
                p_u_12(p_u_13, p_u_5, {
                    ["Enabled"] = v_u_20,
                    ["Value"] = v_u_18
                }, false)
            else
                p_u_12(p_u_13, p_u_5, v_u_18, false)
            end
        else
            return
        end
    end), "Disconnect")
    v_u_21:Add(v_u_22.MouseLeave:Connect(function()
        if v_u_19 then
            v_u_21:Remove("MouseLeaveRelease")
            v_u_21:Add(v_u_2.InputEnded:Connect(function(p51)
                if p51.UserInputType == Enum.UserInputType.MouseButton1 or p51.UserInputType == Enum.UserInputType.Touch then
                    v_u_19 = false
                    if v_u_14 then
                        p_u_12(p_u_13, p_u_5, {
                            ["Enabled"] = v_u_20,
                            ["Value"] = v_u_18
                        }, false)
                    else
                        p_u_12(p_u_13, p_u_5, v_u_18, false)
                    end
                    v_u_21:Remove("MouseLeaveRelease")
                end
            end), "Disconnect", "MouseLeaveRelease")
        end
    end), "Disconnect")
    v_u_21:Add(v_u_2.InputChanged:Connect(function(p52)
        if v_u_19 and (p52.UserInputType == Enum.UserInputType.MouseMovement or p52.UserInputType == Enum.UserInputType.Touch) then
            local v53 = p52.Position.X
            local v54 = v_u_22.AbsolutePosition.X
            local v55 = v_u_22.AbsoluteSize.X
            local v56 = (v53 - v54) / v55
            v_u_36(v_u_17 + math.clamp(v56, 0, 1) * (v_u_16 - v_u_17), true)
        end
    end), "Disconnect")
    v_u_21:Add(p_u_9.Frame.TextBox.FocusLost:Connect(function()
        if v_u_20 then
            local v57 = p_u_9.Frame.TextBox.Text
            local v58 = tonumber(v57)
            if v58 then
                v_u_36(v58)
                if v_u_14 then
                    p_u_12(p_u_13, p_u_5, {
                        ["Enabled"] = v_u_20,
                        ["Value"] = v_u_18
                    }, false)
                else
                    p_u_12(p_u_13, p_u_5, v_u_18, false)
                end
            else
                local v59 = p_u_9.Frame.TextBox
                local v60 = v_u_18 * 100
                local v61 = math.round(v60) / 100
                local v62
                if v61 == math.floor(v61) then
                    local v63 = math.floor(v61)
                    v62 = tostring(v63)
                else
                    v62 = string.format("%.2f", v61):gsub("%.?0+$", "")
                end
                v59.Text = v62
                return
            end
        else
            return
        end
    end), "Disconnect")
    if p_u_9.Check and v_u_14 then
        p_u_9.Check.ImageLabel.Visible = v_u_20
        p_u_9.Frame.TextBox.TextEditable = v_u_20
        v_u_23.Active = v_u_20
        v_u_22.Active = v_u_20
        p_u_9.Slider.Bar.BackgroundTransparency = v_u_20 and 0 or 0.5
        p_u_9.Slider.Button.ImageTransparency = v_u_20 and 0 or 0.5
        p_u_9.Frame.TextBox.TextTransparency = v_u_20 and 0 or 0.5
        p_u_9.Slider.ImageTransparency = v_u_20 and 0 or 0.5
        v_u_21:Add(p_u_9.Check.MouseButton1Click:Connect(function()
            v_u_20 = not v_u_20
            p_u_9.Check.ImageLabel.Visible = v_u_20
            v_u_22.Active = v_u_20
            v_u_23.Active = v_u_20
            p_u_9.Frame.TextBox.TextEditable = v_u_20
            p_u_9.Slider.ImageTransparency = v_u_20 and 0 or 0.5
            p_u_9.Slider.Bar.BackgroundTransparency = v_u_20 and 0 or 0.5
            p_u_9.Slider.Button.ImageTransparency = v_u_20 and 0 or 0.5
            p_u_9.Frame.TextBox.TextTransparency = v_u_20 and 0 or 0.5
            p_u_12(p_u_13, p_u_5, {
                ["Enabled"] = v_u_20,
                ["Value"] = v_u_18
            }, false)
        end), "Disconnect")
    end
    p_u_9.Parent = p7
    return function()
        v_u_19 = false
        v_u_21:Cleanup()
    end
end