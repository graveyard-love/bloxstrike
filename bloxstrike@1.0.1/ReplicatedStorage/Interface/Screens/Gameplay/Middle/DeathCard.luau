local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = require(v2.Controllers.CameraController)
local v_u_6 = require(v2.Components.Common.GetSkinDisplayName)
local v_u_7 = require(v2.Components.Common.GetBadgeIcon)
local v_u_8 = require(v2.Components.Common.GetBadgeName)
local v_u_9 = require(v2.Database.Components.Libraries.Skins)
local v_u_10 = require(v2.Database.Security.Remotes)
local v_u_11 = workspace:WaitForChild("Debris")
local v_u_12 = workspace.CurrentCamera
local v_u_13 = v_u_4.LocalPlayer
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
local function v_u_19()
    for _, v17 in ipairs(v_u_11:GetChildren()) do
        if v17:HasTag("Ragdoll") and v17.Name == v_u_13.Name then
            local v18 = v17:FindFirstChildOfClass("Humanoid")
            if v18 then
                return v18
            end
        end
    end
    return nil
end
function v_u_1.updateFrame(p20)
    local v21 = v_u_4
    local v22 = p20.Killer
    local v23 = v21:GetPlayerByUserId((tonumber(v22)))
    if v23 and v23:IsDescendantOf(v_u_4) then
        local v24 = v_u_9.GetSkinInformation(p20.Weapon, p20.Skin)
        local v25 = v_u_6(p20.Skin)
        v_u_16.Killed.Text = ("<font color=\"rgb(255,34,16)\">Killed you with their</font> <b>%* | %*</b>"):format(p20.Weapon, v25)
        v_u_16.BadgeFrame.TextLabel.Text = v_u_8(v23, (v23:GetAttribute("Team")))
        v_u_16.BadgeIcon.Image = v_u_7(v23, (v23:GetAttribute("Team")))
        v_u_16.Profile.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(v23.UserId)
        v_u_16.Username.Text = v23.DisplayName
        if v24 then
            local v26 = v_u_16.ViewportFrame.Icon
            local v27 = p20.Float or 0.9999
            v26.Image = v_u_9.GetWearImageForFloat(v24, v27) or (v24.imageAssetId or "")
        else
            v_u_16.ViewportFrame.Icon.Image = ""
        end
    else
        return
    end
end
function v_u_1.openFrame()
    v_u_12.CameraSubject = v_u_19()
    v_u_12.CameraType = Enum.CameraType.Follow
    v_u_5.setPerspective(false, false)
    task.wait(0.15)
    v_u_14.ImageLabel.ImageTransparency = 1
    v_u_14.BackgroundTransparency = 1
    v_u_14.Visible = true
    v_u_16.Position = UDim2.fromScale(0.5, -v_u_16.Size.Y.Scale)
    v_u_16.Visible = true
    v_u_15.BackgroundTransparency = 1
    v_u_15.Visible = true
    v_u_3:Create(v_u_14, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["BackgroundTransparency"] = 0.75
    }):Play()
    v_u_3:Create(v_u_14.ImageLabel, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0
    }):Play()
    task.wait(0.25)
    v_u_3:Create(v_u_16, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.fromScale(0.5, 0.7)
    }):Play()
    task.wait(0.35)
    v_u_3:Create(v_u_15, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["BackgroundTransparency"] = 0
    }):Play()
    v_u_3:Create(v_u_14, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["BackgroundTransparency"] = 1
    }):Play()
    v_u_3:Create(v_u_14.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 1
    }):Play()
    if workspace:GetAttribute("Gamemode") ~= "Deathmatch" then
        task.delay(2, function()
            v_u_1.closeFrame()
        end)
    end
end
function v_u_1.closeFrame()
    v_u_14.ImageLabel.ImageTransparency = 1
    v_u_14.BackgroundTransparency = 1
    v_u_14.Visible = false
    v_u_16.Position = UDim2.fromScale(0.5, -v_u_16.Size.Y.Scale)
    v_u_16.Visible = false
    local v28 = v_u_3:Create(v_u_15, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["BackgroundTransparency"] = 1
    })
    v28:Play()
    v28.Completed:Connect(function()
        v_u_15.BackgroundTransparency = 1
        v_u_15.Visible = false
    end)
end
function v_u_1.Initialize(p29, p30)
    v_u_14 = p29.Gameplay.Middle.BloodScreen
    v_u_15 = p29.Gameplay.Middle.Transition
    v_u_16 = p30
    v_u_13.CharacterAdded:Connect(function()
        if v_u_16.Visible then
            v_u_1.closeFrame()
        end
    end)
end
function v_u_1.Start()
    v_u_10.UI.UIPlayerKilled.Listen(function(p31)
        local v32 = v_u_13.UserId
        local v33 = p31.Victim
        if v32 == tonumber(v33) then
            v_u_1.updateFrame(p31)
            v_u_1.openFrame()
        end
    end)
    v_u_10.UI.ShowDeathCard.Listen(function(p34)
        local v35 = v_u_13.UserId
        local v36 = p34.Victim
        if v35 == tonumber(v36) then
            v_u_1.updateFrame(p34)
        end
    end)
end
return v_u_1