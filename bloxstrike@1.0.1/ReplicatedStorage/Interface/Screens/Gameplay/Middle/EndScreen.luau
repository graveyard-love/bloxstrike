local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = require(v_u_2.Components.Common.GetTimerFormat)
local v_u_6 = require(v_u_2.Database.Components.GameState)
local v_u_7 = require(v_u_2.Controllers.CameraController)
local v_u_8 = require(v_u_2.Database.Security.Remotes)
local v_u_9 = require(v_u_2.Packages.Observers)
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = nil
local v_u_13 = nil
local function v_u_18(p14, p15)
    local v16 = p14:GetChildren()
    for _, v17 in ipairs(v16) do
        if v17.ClassName == p15 then
            v17:Destroy()
        end
    end
end
local function v_u_23(p19)
    local v20 = v_u_11.MapVote:GetChildren()
    for _, v21 in ipairs(v20) do
        if v21:IsA("ImageButton") then
            local v22 = p19 and p19[v21.Name] or v21:GetAttribute("Amount")
            if v22 then
                v21.Main.Amount.Text = ("<font color=\"rgb(219,199,126)\">%*</font>/%*"):format(v22, #v_u_4:GetPlayers())
                v21:SetAttribute("Amount", v22)
            end
        end
    end
end
local function v_u_30(p24, p_u_25)
    local v26 = v_u_2.Database.Custom.GameStats.Maps:WaitForChild(p_u_25, 10)
    if v26 then
        local v27 = require(v26)
        if v27 and v27.Icon then
            local v_u_28 = v_u_2.Assets.UI.EndScreen.VoteTemplate:Clone()
            v_u_28.Main.Amount.Text = ("<font color=\"rgb(219,199,126)\">0</font>/%*"):format(#v_u_4:GetPlayers())
            v_u_28.Main.Icon.Image = v27.Icon
            v_u_28.Parent = v_u_11.MapVote
            v_u_28.Main.Selection.Text = p_u_25
            v_u_28:SetAttribute("Amount", 0)
            v_u_28.Title.Visible = p24 == 1
            v_u_28.Voted.Visible = false
            v_u_28.Name = p_u_25
            v_u_28.Button.MouseButton1Click:Connect(function()
                if v_u_10 ~= p_u_25 then
                    v_u_8.Map.SubmitMapVote.Send(p_u_25)
                    v_u_3:Create(v_u_28.Main.UIStroke, TweenInfo.new(0.5), {
                        ["Transparency"] = 0
                    }):Play()
                    v_u_3:Create(v_u_28.Main.UIStroke, TweenInfo.new(0.5), {
                        ["Thickness"] = 5.5
                    }):Play()
                    if v_u_10 then
                        local v29 = v_u_11.MapVote:FindFirstChild(v_u_10)
                        v_u_3:Create(v29.Main.UIStroke, TweenInfo.new(0.5), {
                            ["Transparency"] = 0.75
                        }):Play()
                        v_u_3:Create(v29.Main.UIStroke, TweenInfo.new(0.5), {
                            ["Thickness"] = 1.5
                        }):Play()
                    end
                    v_u_10 = p_u_25
                end
            end)
            v_u_28.Button.MouseEnter:Connect(function()
                v_u_3:Create(v_u_28.Main.Icon.UIScale, TweenInfo.new(0.5), {
                    ["Scale"] = 1.1
                }):Play()
            end)
            v_u_28.Button.MouseLeave:Connect(function()
                v_u_3:Create(v_u_28.Main.Icon.UIScale, TweenInfo.new(0.5), {
                    ["Scale"] = 1
                }):Play()
            end)
        else
            warn((("Map %* is missing Icon property"):format(p_u_25)))
        end
    else
        warn((("Failed to load map module for %* - map may not exist or hasn\'t replicated yet"):format(p_u_25)))
        return
    end
end
function v_u_1.CloseFrame()
    local v31 = v_u_11.Visible
    v_u_11.Visible = false
    v_u_7.setForceLockOverride("EndScreen", false)
    if require(v_u_2.Controllers.MenuSceneController).IsActive() or v_u_12.Menu.Visible then
        require(v_u_2.Interface.Screens.Menu.Top).ResetToMainMenu()
        if not v_u_12.Menu.Visible then
            v_u_7.setForceLockOverride("Menu", true)
            v_u_12.Menu.Visible = true
        end
        v_u_12.Gameplay.Visible = false
    elseif v31 then
        require(v_u_2.Interface.Screens.Gameplay.Middle.TeamSelection).openFrame()
    end
end
function v_u_1.Initialize(p32, p33)
    v_u_11 = p33
    v_u_12 = p32
    v_u_18(v_u_11.MapVote, "ImageButton")
    v_u_8.Map.StartMapVote.Listen(function(p34)
        if v_u_13 then
            v_u_13:Cancel()
            v_u_13 = nil
        end
        v_u_18(v_u_11.MapVote, "ImageButton")
        v_u_10 = nil
        for v35, v36 in ipairs(p34) do
            v_u_30(v35, v36)
        end
    end)
    v_u_8.Map.UpdateMapVote.Listen(function(p37)
        v_u_23(p37)
    end)
    v_u_8.Map.EndMapVote.Listen(function(_)
        if v_u_13 then
            v_u_13:Cancel()
            v_u_13 = nil
        end
        v_u_1.CloseFrame()
    end)
    v_u_9.observePlayer(function()
        v_u_23()
        return function()
            v_u_23()
        end
    end)
    v_u_9.observeAttribute(workspace, "Timer", function(p38)
        v_u_11.Top.Timer.Text = v_u_5(p38)
        if v_u_6.GetState() == "Map Voting" and not v_u_13 then
            local v39 = v_u_11.Top:FindFirstChild("Extra")
            if v39 and p38 > 0 then
                v39.Size = UDim2.new(0, 0, v39.Size.Y.Scale, v39.Size.Y.Offset)
                local v40 = v_u_3:Create(v39, TweenInfo.new(p38 * 1.15, Enum.EasingStyle.Linear), {
                    ["Size"] = UDim2.new(1, 0, v39.Size.Y.Scale, v39.Size.Y.Offset)
                })
                v_u_13 = v40
                v40:Play()
            end
        end
    end)
    if v_u_6.GetState() == "Map Voting" then
        local v41 = false
        for _, v42 in ipairs(v_u_11.MapVote:GetChildren()) do
            if v42:IsA("ImageButton") then
                v41 = true
                break
            end
        end
        if not v41 then
            v_u_8.Map.RequestMapVote.Send()
            return
        end
    end
end
return v_u_1