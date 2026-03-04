local v1 = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.Types)
local v_u_2 = require(v1.Shared.Janitor)
require(v1.Database.Custom.GameStats.UI.Settings.Pages)
local v_u_3 = Color3.fromRGB(255, 255, 255)
Color3.fromRGB(255, 201, 14)
return function(p_u_4, p_u_5, p6, p7, p_u_8, p9, p_u_10, p_u_11, p_u_12, p_u_13, p_u_14)
    local v_u_15 = v_u_2.new()
    local v_u_16 = p9
    p_u_8:SetAttribute("IsDropdown", true)
    p_u_8.LayoutOrder = p7
    p_u_8.Title.Text = p_u_5.DisplayName or p_u_4
    p_u_8.Name = p_u_4
    local v_u_17 = p_u_8.Options.Frame
    p_u_8.Options.Button.Title.Text = v_u_16
    v_u_17.Visible = false
    local function v_u_19()
        v_u_15:Cleanup()
        for _, v18 in ipairs(v_u_17:GetChildren()) do
            if v18:IsA("TextButton") then
                v18:Destroy()
            end
        end
    end
    local v_u_20 = v_u_2.new()
    v_u_20:Add(p_u_8, "Destroy")
    v_u_20:Add(v_u_19)
    v_u_20:Add(p_u_8.Options.Button.MouseButton1Click:Connect(function()
        local v21 = p_u_13()
        local v22 = not v_u_17.Visible
        if v21 and v21 ~= v_u_17 then
            v21.Visible = false
            for _, v23 in ipairs(v21:GetChildren()) do
                if v23:IsA("TextButton") then
                    v23:Destroy()
                end
            end
        end
        for _, v24 in ipairs(p_u_8.Parent:GetChildren()) do
            if v24:GetAttribute("IsDropdown") then
                if v22 and v24.Name == p_u_8.Name then
                    v24.ZIndex = 11
                else
                    v24.ZIndex = 10
                end
            end
        end
        v_u_19()
        if v22 and p_u_5.Enums then
            for v25, v_u_26 in ipairs(p_u_5.Enums) do
                local v_u_27 = p_u_12:WaitForChild("OptionTemplate"):Clone()
                v_u_27.Size = UDim2.fromScale(1, 1 / #p_u_5.Enums)
                v_u_27.Name = ("Option_%*"):format(v_u_26)
                v_u_27.Title.Text = v_u_26
                v_u_27.LayoutOrder = v25
                v_u_27.Visible = true
                v_u_27.Parent = v_u_17
                local v_u_28 = p_u_8.Options.Button.Title.Text == v_u_26
                v_u_27.Frame.BackgroundTransparency = v_u_28 and 0.3 or 1
                v_u_27.TextColor3 = v_u_3
                v_u_15:Add(v_u_27.MouseEnter:Connect(function()
                    v_u_27.Frame.BackgroundTransparency = v_u_28 and 0.3 or 0.65
                end), "Disconnect", (("Option_%*_1"):format(v_u_26)))
                v_u_15:Add(v_u_27.MouseLeave:Connect(function()
                    v_u_27.Frame.BackgroundTransparency = v_u_28 and 0.3 or 1
                end), "Disconnect", (("Option_%*_2"):format(v_u_26)))
                v_u_15:Add(v_u_27.MouseButton1Click:Connect(function()
                    v_u_16 = v_u_26
                    p_u_8.Options.Button.Title.Text = v_u_26
                    v_u_17.Visible = false
                    p_u_14(nil)
                    p_u_10(p_u_11, p_u_4, v_u_16)
                    v_u_19()
                end), "Disconnect", (("Option_%*_3"):format(v_u_26)))
                v_u_15:Add(v_u_27, "Destroy")
            end
            local v29 = #p_u_5.Enums
            local v30 = v29 * 30 + (v29 - 1) * 5
            v_u_17.Size = UDim2.new(1, 0, 0, v30)
            v_u_17.Visible = true
            p_u_14(v_u_17)
        else
            v_u_17.Visible = false
            p_u_14(nil)
        end
    end), "Disconnect")
    p_u_8.Parent = p6
    return function()
        v_u_15:Cleanup()
        v_u_20:Cleanup()
    end
end