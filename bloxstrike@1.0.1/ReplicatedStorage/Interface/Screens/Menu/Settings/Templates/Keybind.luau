local v1 = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.Types)
local v_u_2 = require(v1.Shared.Janitor)
require(v1.Database.Custom.GameStats.UI.Settings.Pages)
return function(p_u_3, p4, p5, p6, p_u_7, p8, p_u_9, p_u_10, p_u_11, p12)
    p_u_7.LayoutOrder = p6
    p_u_7.Title.Text = p4.DisplayName or p_u_3
    p_u_7.Name = p_u_3
    local v_u_13 = p8.Computer == nil and "" or p8.Computer
    local v_u_14 = p8.Console == nil and "" or p8.Console
    local v_u_15 = v_u_2.new()
    v_u_15:Add(p_u_7, "Destroy")
    if p8.Computer == nil and p4.Default then
        local v16 = p4.Default
        v_u_13 = typeof(v16) == "table" and (v16.Computer or "") or ""
    end
    if p8.Console == nil and p4.Default then
        local v17 = p4.Default
        v_u_14 = typeof(v17) == "table" and (v17.Console or "") or ""
    end
    local function v_u_22(p18, p19)
        local v20 = p18:FindFirstChild("TextBox")
        local v21 = p18:FindFirstChild("Reset")
        if v20 then
            if p19 == "" then
                v20.Text = ""
                v20.PlaceholderText = "None"
                v20.TextEditable = false
                v20.Active = true
                if v21 then
                    v21.Visible = false
                    return
                end
            else
                v20.Text = (p19 == "" or p19 == nil) and "" or p19:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", "")
                v20.PlaceholderText = ""
                v20.TextEditable = false
                v20.Active = true
                if v21 then
                    v21.Visible = true
                end
            end
        end
    end
    if p_u_7:FindFirstChild("Computer") then
        v_u_22(p_u_7.Computer, v_u_13)
        v_u_15:Add(p_u_7.Computer.TextBox.Focused:Connect(function()
            local v23 = v_u_13
            p_u_11(p_u_7.Computer.TextBox, (v23 == "" or v23 == nil) and "" or v23:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", ""), tick())
        end), "Disconnect")
        v_u_15:Add(p_u_7.Computer.Reset.MouseButton1Click:Connect(function()
            v_u_22(p_u_7.Computer, v_u_13)
            v_u_13 = ""
            p_u_9(p_u_10, p_u_3, {
                ["Computer"] = v_u_13,
                ["Console"] = v_u_14
            })
        end), "Disconnect")
        p12("Computer", v_u_13)
    end
    if p_u_7:FindFirstChild("Console") then
        v_u_22(p_u_7.Console, v_u_14)
        v_u_15:Add(p_u_7.Console.TextBox.Focused:Connect(function()
            local v24 = v_u_14
            p_u_11(p_u_7.Console.TextBox, (v24 == "" or v24 == nil) and "" or v24:gsub("Enum%.KeyCode%.", ""):gsub("Enum%.UserInputType%.", ""):gsub("Enum%.CustomInputType%.", ""), tick())
        end), "Disconnect")
        v_u_15:Add(p_u_7.Console.Reset.MouseButton1Click:Connect(function()
            v_u_22(p_u_7.Console, v_u_14)
            v_u_14 = ""
            p_u_9(p_u_10, p_u_3, {
                ["Computer"] = v_u_13,
                ["Console"] = v_u_14
            })
        end), "Disconnect")
        p12("Console", v_u_14)
    end
    p_u_7.Parent = p5
    return function()
        v_u_15:Cleanup()
    end
end