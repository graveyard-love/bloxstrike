local v1 = {}
game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = require(v2.Database.Security.Remotes)
local v_u_6 = require(v2.Database.Security.Router)
local v_u_7 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v_u_8 = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v_u_9 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v_u_10 = UDim2.fromScale(0.5, 0.14)
local v_u_11 = UDim2.fromScale(0.5, 0.5)
local v_u_12 = UDim2.fromScale(0.5, 0.78)
local v_u_13 = table.freeze({
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true
})
local v_u_14 = table.freeze({
    ["Defusal"] = "Defusal",
    ["Deathmatch"] = "Deathmatch",
    ["UnrankedComp"] = "UnrankedComp"
})
local v_u_15 = 0
local v_u_16 = nil
local function v_u_24(p17, p18)
    local v19 = p17.SelectButton
    local v20 = p17.SelectButtonFrame
    local v21 = p17.SelectButtonTitle
    v_u_3:Create(v19, v_u_9, {
        ["BackgroundTransparency"] = 1,
        ["TextTransparency"] = p18
    }):Play()
    if v20 then
        v_u_3:Create(v20, v_u_9, {
            ["BackgroundTransparency"] = p18
        }):Play()
        local v22 = v20:FindFirstChildOfClass("UIStroke")
        if v22 then
            v_u_3:Create(v22, v_u_9, {
                ["Transparency"] = p18
            }):Play()
        end
        for _, v23 in ipairs(v20:GetDescendants()) do
            if v23:IsA("ImageLabel") then
                v_u_3:Create(v23, v_u_9, {
                    ["ImageTransparency"] = p18
                }):Play()
            elseif v23:IsA("TextLabel") then
                v_u_3:Create(v23, v_u_9, {
                    ["TextTransparency"] = p18
                }):Play()
            end
        end
    end
    if v21 then
        v_u_3:Create(v21, v_u_9, {
            ["TextTransparency"] = p18
        }):Play()
    end
end
local function v_u_27(p25)
    p25.HideToken = p25.HideToken + 1
    p25.SelectOverlay.Visible = true
    p25.SelectButton.Visible = true
    local v26 = p25.SelectOverlayStroke
    if v26 then
        v26.Transparency = 1
        v_u_3:Create(v26, v_u_7, {
            ["Transparency"] = 0
        }):Play()
    end
    v_u_24(p25, 0)
    v_u_3:Create(p25.ModeLabel, v_u_8, {
        ["Position"] = p25.ModeLabelHoverPosition
    }):Play()
    if p25.DescriptionLabel and p25.DescriptionLabelHoverPosition then
        v_u_3:Create(p25.DescriptionLabel, v_u_8, {
            ["Position"] = p25.DescriptionLabelHoverPosition
        }):Play()
    end
end
local function v_u_34(p_u_28)
    p_u_28.HideToken = p_u_28.HideToken + 1
    local v_u_29 = p_u_28.HideToken
    local v_u_30 = p_u_28.SelectOverlayStroke
    local v_u_31 = p_u_28.SelectOverlay
    local v_u_32 = p_u_28.SelectButton
    v_u_24(p_u_28, 1)
    v_u_3:Create(p_u_28.ModeLabel, v_u_8, {
        ["Position"] = p_u_28.ModeLabelDefaultPosition
    }):Play()
    if p_u_28.DescriptionLabel and p_u_28.DescriptionLabelDefaultPosition then
        v_u_3:Create(p_u_28.DescriptionLabel, v_u_8, {
            ["Position"] = p_u_28.DescriptionLabelDefaultPosition
        }):Play()
    end
    task.delay(0.18, function()
        if not p_u_28.IsHoveringCard and (not p_u_28.IsHoveringSelect and p_u_28.HideToken == v_u_29) then
            v_u_32.Visible = false
        end
    end)
    if v_u_30 then
        local v33 = v_u_3:Create(v_u_30, v_u_7, {
            ["Transparency"] = 1
        })
        v33:Play()
        v33.Completed:Once(function()
            if not p_u_28.IsHoveringCard and (not p_u_28.IsHoveringSelect and p_u_28.HideToken == v_u_29) then
                v_u_31.Visible = false
                v_u_30.Transparency = 0
            end
        end)
    else
        v_u_31.Visible = false
    end
end
local function v_u_63(p_u_35)
    local v36 = v_u_16:WaitForChild("SelectMode"):FindFirstChild(p_u_35)
    if v36 and v36:IsA("ImageButton") then
        local v37 = v36:WaitForChild("Main")
        local v38 = v37:WaitForChild("Select")
        local v39 = v38:FindFirstChildOfClass("UIStroke")
        local v40 = v37:WaitForChild("Info")
        local v41 = v40:FindFirstChild("Description")
        local v_u_42 = v40:WaitForChild("Select")
        local v43 = v_u_42:FindFirstChild("Frame")
        local v_u_44 = v_u_42:FindFirstChild("Title")
        local v45 = v40:WaitForChild("Mode")
        local v_u_46 = v36:FindFirstChild("Button")
        if v_u_46 and v_u_46:IsA("GuiButton") then
            v_u_46.Active = false
            pcall(function()
                v_u_46.Interactable = false
            end)
        end
        local v_u_47 = v37:FindFirstChild("ImageButton")
        if v_u_47 and v_u_47:IsA("GuiButton") then
            v_u_47.Active = false
            pcall(function()
                v_u_47.Interactable = false
            end)
        end
        v38.Visible = false
        v_u_42.Visible = false
        v45.Position = v_u_10
        if v41 and v41:IsA("TextLabel") then
            v41.Position = v_u_11
        end
        v_u_42.AnchorPoint = Vector2.new(0.5, 0.5)
        v_u_42.Position = v_u_12
        v_u_42.Size = UDim2.fromScale(0.86, 0.39)
        v_u_42.ZIndex = 10
        local v48 = v45.Position
        local v49 = UDim2.new(v48.X.Scale, v48.X.Offset, v48.Y.Scale + -0.18, v48.Y.Offset)
        local v50
        if v41 and v41:IsA("TextLabel") then
            v50 = v41.Position
        else
            v50 = nil
        end
        local v51
        if v50 then
            v51 = UDim2.new(v50.X.Scale, v50.X.Offset, v50.Y.Scale + -0.18, v50.Y.Offset)
        else
            v51 = nil
        end
        if v43 and v43:IsA("Frame") then
            v43.ZIndex = 10
            v43.BackgroundTransparency = 1
            local v52 = v43:FindFirstChildOfClass("UIStroke")
            if v52 then
                v52.Transparency = 1
            end
            for _, v53 in ipairs(v43:GetDescendants()) do
                if v53:IsA("GuiObject") then
                    v53.ZIndex = 11
                end
                if v53:IsA("ImageLabel") then
                    v53.ImageTransparency = 1
                elseif v53:IsA("TextLabel") then
                    v53.TextTransparency = 1
                end
            end
        end
        if v_u_44 and v_u_44:IsA("TextLabel") then
            v_u_44.ZIndex = 11
            v_u_44.TextTransparency = 1
        end
        local v_u_54 = {
            ["IsHoveringCard"] = false,
            ["IsHoveringSelect"] = false,
            ["HideToken"] = 0,
            ["SelectOverlay"] = v38,
            ["SelectOverlayStroke"] = v39,
            ["SelectButton"] = v_u_42
        }
        if not (v43 and v43:IsA("Frame")) then
            v43 = nil
        end
        v_u_54.SelectButtonFrame = v43
        local v55
        if v_u_44 and v_u_44:IsA("TextLabel") then
            v55 = v_u_44
        else
            v55 = nil
        end
        v_u_54.SelectButtonTitle = v55
        v_u_54.ModeLabel = v45
        if not (v41 and v41:IsA("TextLabel")) then
            v41 = nil
        end
        v_u_54.DescriptionLabel = v41
        v_u_54.ModeLabelDefaultPosition = v48
        v_u_54.ModeLabelHoverPosition = v49
        v_u_54.DescriptionLabelDefaultPosition = v50
        v_u_54.DescriptionLabelHoverPosition = v51
        local function v57(p56)
            if p56 == Enum.UserInputType.Touch and true or v_u_13[p56] == true then
                v_u_27(v_u_54)
                return
            elseif v_u_54.IsHoveringCard or v_u_54.IsHoveringSelect then
                v_u_27(v_u_54)
            else
                v_u_34(v_u_54)
            end
        end
        v_u_4.LastInputTypeChanged:Connect(v57)
        local v58 = v_u_4:GetLastInputType()
        if v58 == Enum.UserInputType.Touch and true or v_u_13[v58] == true then
            v_u_27(v_u_54)
        elseif v_u_54.IsHoveringCard or v_u_54.IsHoveringSelect then
            v_u_27(v_u_54)
        else
            v_u_34(v_u_54)
        end
        v36.MouseEnter:Connect(function()
            v_u_6.broadcastRouter("RunInterfaceSound", "UI Highlight")
            v_u_54.IsHoveringCard = true
            v_u_27(v_u_54)
        end)
        v36.MouseLeave:Connect(function()
            v_u_54.IsHoveringCard = false
            task.defer(function()
                if not (v_u_54.IsHoveringCard or v_u_54.IsHoveringSelect) then
                    v_u_34(v_u_54)
                end
            end)
        end)
        v_u_42.MouseEnter:Connect(function()
            v_u_54.IsHoveringSelect = true
            v_u_27(v_u_54)
        end)
        v_u_42.MouseLeave:Connect(function()
            v_u_54.IsHoveringSelect = false
            if not v_u_54.IsHoveringCard then
                v_u_34(v_u_54)
            end
        end)
        local function v62()
            local v59 = v_u_14[p_u_35]
            v_u_6.broadcastRouter("RunInterfaceSound", "UI Click")
            if v59 then
                local v60 = tick()
                local v61
                if v60 - v_u_15 < 0.75 then
                    print((("[Modes] Ignored mode request (%*) due to cooldown"):format(v59)))
                    v61 = false
                else
                    v_u_15 = v60
                    v_u_5.Modes.SelectGamemode.Send(v59)
                    v61 = true
                end
                if v61 then
                    v_u_42.Text = "TELEPORTING"
                    if v_u_44 and v_u_44:IsA("TextLabel") then
                        v_u_44.Text = "TELEPORTING"
                    end
                end
            end
        end
        v_u_42.Activated:Connect(v62)
    else
        warn((("[Modes] Missing mode card \"%*\""):format(p_u_35)))
    end
end
function v1.Initialize(_, p64)
    v_u_16 = p64
end
function v1.Start()
    v_u_63("Defusal")
    v_u_63("Deathmatch")
    v_u_63("UnrankedComp")
end
return v1