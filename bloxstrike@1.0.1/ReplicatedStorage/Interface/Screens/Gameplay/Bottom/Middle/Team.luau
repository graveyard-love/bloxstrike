local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = v4.LocalPlayer
local v_u_6 = require(v_u_2.Components.Common.GetPreferenceColor)
local v_u_7 = require(v_u_2.Controllers.DataController)
local v_u_8 = require(v_u_2.Database.Security.Remotes)
local v_u_9 = nil
local v_u_10 = nil
local function v_u_14(p11, p12)
    p11.Amount.TextColor3 = p12
    p11.ImageColor3 = p12
    for _, v13 in ipairs(p11:GetDescendants()) do
        if v13:IsA("UIStroke") then
            v13.Color = p12
        elseif v13:IsA("ImageLabel") then
            v13.ImageColor3 = p12
        end
    end
end
function v_u_1.createAnimationFrame(_)
    local v15 = v_u_5:GetAttribute("Team")
    if v15 and v15 ~= "Spectators" then
        local v16 = #v_u_9.Cards:GetChildren() + 1
        if v16 <= 5 then
            local v17 = v15 == "Counter-Terrorists" and v_u_2.Assets.UI.Team.CTCard
            if not v17 then
                if v15 == "Terrorists" then
                    v17 = v_u_2.Assets.UI.Team.TCard
                else
                    v17 = false
                end
            end
            local v_u_18 = v17:Clone()
            v_u_18.Amount.Text = tostring(v16)
            v_u_18.Position = UDim2.fromScale(0.5, 1)
            v_u_18.Name = tostring(v16)
            v_u_18.Animation.ImageTransparency = 1
            v_u_18.Animation.Visible = false
            v_u_18.Parent = v_u_9.Cards
            v_u_18.Rotation = -10
            v_u_18.Visible = true
            v_u_14(v_u_18, v_u_6())
            for _, v19 in ipairs(v_u_9.Cards:GetChildren()) do
                local v20 = v19.Name
                local v21 = tonumber(v20)
                local v22 = (v16 + 1) / 2
                local v23 = v21 - math.floor(v22)
                local v24 = v16 == 1 and 0 or (v23 * 0.2617993877991494 or 0)
                local v25 = v16 >= 3 and (v19.Name == "1" and 0.75 or (v19.Name == "2" and 0.75 or 0.85)) or 0.85
                local v26 = v16 >= 3 and (v19.Name == "1" and 0.25 or (v19.Name == "2" and 0.125 or 0.05)) or 0.05
                v_u_3:Create(v19, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Position"] = UDim2.fromScale(math.sin(v24) * v25 + 0.5, math.cos(v24) * v26 + 0.45),
                    ["Rotation"] = math.deg(v24)
                }):Play()
            end
            v_u_3:Create(v_u_18.Animation, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["ImageTransparency"] = 0.2
            }):Play()
            v_u_3:Create(v_u_9.Team.Team, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["ImageColor3"] = Color3.fromRGB(135, 155, 177)
            }):Play()
            task.delay(0.5, function()
                if v_u_18 and v_u_18:FindFirstChild("Animation") then
                    v_u_3:Create(v_u_18.Animation, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["ImageTransparency"] = 1
                    }):Play()
                    v_u_3:Create(v_u_9.Team.Team, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["ImageColor3"] = Color3.fromRGB(36, 41, 47)
                    }):Play()
                end
            end)
        end
    else
        return
    end
end
function v_u_1.OpenFrame()
    local v27 = v_u_6()
    v_u_10.Gameplay.Bottom.Middle.Spectate.Visible = false
    v_u_9.Team.Outline.ImageColor3 = v27
    v_u_9.Line1.ImageColor3 = v27
    v_u_9.Line2.ImageColor3 = v27
    v_u_9.Cards.Visible = true
    v_u_9.Visible = true
    local v28 = v_u_5:GetAttribute("Team")
    v_u_9.Team.Team.CT.Visible = v28 == "Counter-Terrorists"
    v_u_9.Team.Team.T.Visible = v28 == "Terrorists"
    v_u_9.Team.Team.ImageColor3 = v28 == "Terrorists" and Color3.fromRGB(89, 79, 50) or Color3.fromRGB(36, 41, 47)
end
function v_u_1.CloseFrame()
    v_u_9.Cards:ClearAllChildren()
    v_u_9.Cards.Visible = false
    v_u_9.Visible = false
end
function v_u_1.Initialize(p29, p30)
    v_u_10 = p29
    v_u_9 = p30
    v_u_7.CreateListener(v_u_5, "Settings.Game.HUD.Color", function()
        if v_u_9.Visible then
            local v31 = v_u_6()
            v_u_9.Team.Outline.ImageColor3 = v31
            v_u_9.Line1.ImageColor3 = v31
            v_u_9.Line2.ImageColor3 = v31
            for _, v32 in ipairs(v_u_9.Cards:GetChildren()) do
                if v32:IsA("ImageLabel") and (v32:FindFirstChild("Amount") and (v32:FindFirstChild("Skull1") and (v32:FindFirstChild("Skull2") and v32:FindFirstChild("Animation")))) then
                    v_u_14(v32, v31)
                end
            end
        end
    end)
end
function v_u_1.Start()
    v_u_5.CharacterAdded:Connect(function(_)
        v_u_1.OpenFrame()
    end)
    v_u_5.CharacterRemoving:Connect(function(_)
        v_u_1.CloseFrame()
    end)
    v_u_8.UI.UIPlayerKilled.Listen(function(p33)
        if v_u_9.Visible then
            local v34 = v_u_5.UserId
            local v35 = p33.Killer
            if v34 == tonumber(v35) then
                v_u_1.createAnimationFrame(p33)
                return
            end
        end
    end)
end
return v_u_1