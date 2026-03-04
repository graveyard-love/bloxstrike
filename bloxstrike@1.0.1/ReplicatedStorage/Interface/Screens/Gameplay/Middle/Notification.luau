local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("Players")
local v_u_5 = game:GetService("Debris")
require(script:WaitForChild("Types"))
local v_u_6 = require(v2.Database.Components.GameState)
local v_u_7 = require(v2.Components.Common.GetPreferenceColor)
local v_u_8 = require(v2.Controllers.InputController)
local v_u_9 = require(v2.Controllers.DataController)
local v_u_10 = require(v2.Database.Security.Remotes)
local v_u_11 = require(v2.Database.Security.Router)
local v_u_12 = v4.LocalPlayer
local v_u_13 = UDim2.fromScale(0.9, 0.2)
local v_u_14 = UDim2.fromScale(0.9, 0.12)
local v_u_15 = {
    ["Invulnerable"] = v2.Assets.UI.Notification.Invulnerable,
    ["Default"] = v2.Assets.UI.Notification.Default
}
local v_u_16 = nil
local function v_u_18(p17)
    v_u_3:Create(p17, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        ["Size"] = UDim2.fromScale(0, 0.12)
    }):Play()
    v_u_5:AddItem(p17, 0.35)
end
function v_u_1.createNotification(p19, p20, p21, p22)
    local v23 = v_u_16:FindFirstChild(p20)
    if v_u_12:GetAttribute("Team") then
        if not v23 then
            local v24 = p19 == "Invulnerable" and v_u_13 or v_u_14
            v23 = v_u_15[p19]:Clone()
            v23.Size = UDim2.fromScale(0, v24.Y.Scale)
            v23.LayoutOrder = -(p22 or 1)
            v23.Parent = v_u_16
            v23.Name = p20
            v_u_3:Create(v23, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["Size"] = v24
            }):Play()
        end
        v23:SetAttribute("Timestamp", tick())
        v23.Right.BackgroundColor3 = v_u_7()
        v23.Left.BackgroundColor3 = v_u_7()
        if v23:FindFirstChild("TextLabel") then
            v23.TextLabel.Text = p21
        end
        if p19 == "Invulnerable" then
            local v25 = v_u_8.GetActionKeybind("Buy Menu") or "B"
            v23.Container.Context.Text = ("[%*] Open the Buy Menu"):format(v25)
            v23.Container.Header.TextColor3 = v_u_7()
        end
        return v23
    end
end
function v_u_1.Initialize(_, p26)
    v_u_16 = p26
    v_u_12:GetAttributeChangedSignal("BuyMenu"):Connect(function()
        local v27 = workspace:GetAttribute("Gamemode")
        if not v_u_12:GetAttribute("BuyMenu") and v27 == "Deathmatch" then
            local v_u_28 = v_u_1.createNotification("Default", "Your buy period has expired", "Your buy period has expired", 2)
            task.delay(2, function()
                if v_u_28 and v_u_28.Parent then
                    v_u_18(v_u_28)
                end
            end)
        end
    end)
    v_u_12.CharacterAdded:Connect(function(p_u_29)
        local v30 = workspace:GetAttribute("GameState")
        if workspace:GetAttribute("Gamemode") == "Deathmatch" then
            if p_u_29:GetAttribute("Invincible") then
                local v31 = v_u_16:FindFirstChild("GameState")
                v_u_1.createNotification("Invulnerable", "Deathmatch Invincibility", "", 0)
                if v31 then
                    v31:Destroy()
                end
            end
            p_u_29:GetAttributeChangedSignal("Invincible"):Connect(function()
                if p_u_29:GetAttribute("Invincible") then
                    local v32 = v_u_16:FindFirstChild("GameState")
                    v_u_1.createNotification("Invulnerable", "Deathmatch Invincibility", "", 0)
                    if v32 then
                        v32:Destroy()
                        return
                    end
                else
                    local v33 = v_u_16:FindFirstChild("Deathmatch Invincibility")
                    local v34 = workspace:GetAttribute("GameState")
                    if v33 then
                        v33:Destroy()
                    end
                    if v34 == "Warmup" then
                        v_u_1.createNotification("Default", "GameState", "Warmup", 1)
                    end
                end
            end)
            return
        else
            local v35 = v_u_16:FindFirstChild("Deathmatch Invincibility")
            if v35 then
                v35:Destroy()
            end
            if v30 == "Warmup" then
                v_u_1.createNotification("Default", "GameState", "Warmup", 1)
            else
                local v36 = v_u_16:FindFirstChild("GameState")
                if v36 then
                    v36:Destroy()
                end
            end
        end
    end)
    v_u_6.ListenToState(function(p37, _)
        local v38 = p37 == "Warmup" and v_u_16:FindFirstChild("GameState")
        if v38 then
            v38:Destroy()
        end
    end)
    workspace:GetAttributeChangedSignal("Gamemode"):Connect(function()
        local v39 = workspace:GetAttribute("Gamemode") ~= "Deathmatch" and v_u_16:FindFirstChild("Deathmatch Invincibility")
        if v39 then
            v39:Destroy()
        end
    end)
    v_u_9.CreateListener(v_u_12, "Settings.Game.HUD.Color", function()
        for _, v40 in ipairs(v_u_16:GetChildren()) do
            if v40:IsA("Frame") then
                v40.Right.BackgroundColor3 = v_u_7()
                v40.Left.BackgroundColor3 = v_u_7()
            end
        end
    end)
end
function v_u_1.Start()
    v_u_10.UI.ShowNotification.Listen(function(p_u_41, _)
        local v_u_42 = v_u_1.createNotification("Default", p_u_41.header, p_u_41.message, 2)
        task.delay(p_u_41.timeLength, function()
            if v_u_42 and v_u_42.Parent then
                local v43 = v_u_42
                if p_u_41.timeLength <= tick() - v43:GetAttribute("Timestamp") then
                    v_u_18(v43)
                    return
                end
            end
        end)
    end)
    v_u_11.observerRouter("CreateNotification", function(p44, p45, p_u_46)
        local v_u_47 = v_u_1.createNotification("Default", p44, p45, 2)
        task.delay(p_u_46, function()
            if v_u_47 and v_u_47.Parent then
                local v48 = v_u_47
                if p_u_46 <= tick() - v48:GetAttribute("Timestamp") then
                    v_u_18(v48)
                    return
                end
            end
        end)
    end)
end
return v_u_1