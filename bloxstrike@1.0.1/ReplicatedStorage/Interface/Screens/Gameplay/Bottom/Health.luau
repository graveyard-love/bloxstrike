local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("Players")
local v_u_5 = game:GetService("Debris")
local v_u_6 = v4.LocalPlayer
local v_u_7 = require(v2.Controllers.DataController)
local v_u_8 = require(v2.Controllers.SpectateController)
local v_u_9 = require(v2.Database.Components.GameState)
local v_u_10 = require(v2.Components.Common.GetPreferenceColor)
local v_u_11 = require(v2.Shared.Janitor).new()
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = nil
function v_u_1.animateFrame()
    local v15 = v_u_14.Amount:Clone()
    v15.TextColor3 = Color3.fromRGB(255, 0, 4)
    v15.ZIndex = v_u_14.ZIndex - 1
    v15.Parent = v_u_14
    v_u_3:Create(v_u_14.Amount.UIScale, TweenInfo.new(0.07), {
        ["Scale"] = 1.1
    }):Play()
    task.wait(0.07)
    v_u_3:Create(v_u_14.Amount.UIScale, TweenInfo.new(0.07, Enum.EasingStyle.Elastic), {
        ["Scale"] = 1
    }):Play()
    v_u_3:Create(v15, TweenInfo.new(0.5), {
        ["Position"] = v15.Position + UDim2.fromScale(0, 0.25)
    }):Play()
    v_u_3:Create(v15, TweenInfo.new(0.5), {
        ["TextTransparency"] = 1
    }):Play()
    v_u_5:AddItem(v15, 0.5)
end
function v_u_1.updateFrame(p16, p17)
    local v18 = p16 / p17
    local v19 = v_u_14.Amount
    local v20 = math.round(p16)
    v19.Text = tostring(v20)
    v_u_14.Frame.Bar.BackgroundColor3 = v_u_10()
    v_u_14.Amount.TextColor3 = v_u_10()
    v_u_14.Glow.ImageTransparency = 1
    v_u_3:Create(v_u_14.Frame.Bar, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Size"] = UDim2.fromScale(p16 / p17, 1)
    }):Play()
    if v18 <= 0.5 then
        local v21 = v_u_14.Glow
        local v22 = (0.5 - v18) * 2
        v21.ImageTransparency = math.max(v22, 0.3)
    end
    if p16 < v_u_12 then
        task.spawn(v_u_1.animateFrame)
    end
    v_u_12 = p16
end
local function v_u_34(p23)
    if p23 and v_u_14 then
        local v24 = p23.Health
        local v25 = math.max(v24, 0)
        local v26 = p23.MaxHealth
        local v27 = v_u_14.Amount.Text
        local v28 = tonumber(v27) or 0
        local v29 = v_u_14.Frame.Bar.Size.X.Scale * v26
        local v30 = math.round(v29)
        local v31 = v25 - v28
        local v32 = math.abs(v31) > 1
        local v33 = v25 - v30
        if v32 or math.abs(v33) > 1 then
            v_u_1.updateFrame(v25, v26)
        end
    end
end
function v_u_1.characterAdded(p35, p36)
    v_u_11:Cleanup()
    v_u_13 = nil
    local v_u_37 = p35:FindFirstChildOfClass("Humanoid")
    if not v_u_37 then
        local v38 = tick()
        repeat
            task.wait(0.1)
            v_u_37 = p35:FindFirstChildOfClass("Humanoid")
        until v_u_37 or tick() - v38 > 5
    end
    if v_u_37 then
        v_u_12 = v_u_37.MaxHealth
        v_u_13 = v_u_37
        local v39 = v_u_1.updateFrame
        local v40 = v_u_37.Health
        v39(math.max(v40, 0), v_u_37.MaxHealth)
        if p36 == v_u_6 then
            task.wait(0.1)
            v_u_34(v_u_37)
            task.delay(3, function()
                if v_u_37 and (v_u_37.Parent and v_u_37.Parent:IsDescendantOf(workspace)) then
                    v_u_34(v_u_37)
                end
            end)
        end
        v_u_11:Add(v_u_37:GetPropertyChangedSignal("Health"):Connect(function()
            local v41 = v_u_1.updateFrame
            local v42 = v_u_37.Health
            v41(math.max(v42, 0), v_u_37.MaxHealth)
        end))
    end
end
function v_u_1.Initialize(_, p43)
    v_u_14 = p43
    if v_u_14.Active then
        v_u_14.Active = false
    end
    for _, v44 in ipairs(v_u_14:GetDescendants()) do
        if v44:IsA("GuiObject") then
            v44.Active = false
        end
    end
    v_u_6.CharacterRemoving:Connect(function()
        v_u_11:Cleanup()
        v_u_13 = nil
    end)
    v_u_7.CreateListener(v_u_6, "Settings.Game.HUD.Color", function()
        if v_u_13 then
            local v45 = v_u_1.updateFrame
            local v46 = v_u_13.Health
            v45(math.max(v46, 0), v_u_13.MaxHealth)
        end
    end)
end
function v_u_1.Start()
    local v_u_47 = nil
    local function v_u_52(p_u_48)
        v_u_47 = p_u_48
        v_u_11:Cleanup()
        v_u_13 = nil
        local v49 = p_u_48.Character
        if v49 and v49:IsDescendantOf(workspace) then
            v_u_1.characterAdded(v49, p_u_48)
        elseif p_u_48 ~= v_u_6 then
            local v_u_50 = nil
            v_u_50 = p_u_48.CharacterAdded:Connect(function(p51)
                if v_u_47 == p_u_48 and p51:IsDescendantOf(workspace) then
                    v_u_1.characterAdded(p51, p_u_48)
                    v_u_50:Disconnect()
                end
            end)
            v_u_11:Add(v_u_50)
        end
    end
    v_u_6.CharacterAdded:Connect(function()
        v_u_52(v_u_6)
    end)
    v_u_8.ListenToSpectate:Connect(function(p53)
        if p53 then
            v_u_52(p53)
            return
        elseif v_u_6:GetAttribute("IsSpectating") then
            return
        else
            local v54 = v_u_6.Character
            if v54 and v54:IsDescendantOf(workspace) then
                local v55 = v54:FindFirstChildWhichIsA("Humanoid", true)
                if v55 and v55.Health > 0 then
                    v_u_52(v_u_6)
                end
            else
                return
            end
        end
    end)
    v_u_6:GetAttributeChangedSignal("IsSpectating"):Connect(function()
        if v_u_6:GetAttribute("IsSpectating") then
            local v56 = v_u_8.GetPlayer()
            if v56 then
                v_u_52(v56)
            end
        else
            v_u_52(v_u_6)
            return
        end
    end)
    if v_u_6:GetAttribute("IsSpectating") then
        local v57 = v_u_8.GetPlayer()
        if v57 then
            v_u_52(v57)
        end
    else
        v_u_52(v_u_6)
    end
    v_u_9.ListenToState(function(_, p58)
        if p58 == "Buy Period" or p58 == "Round In Progress" then
            v_u_52(v_u_6)
        end
    end)
end
return v_u_1