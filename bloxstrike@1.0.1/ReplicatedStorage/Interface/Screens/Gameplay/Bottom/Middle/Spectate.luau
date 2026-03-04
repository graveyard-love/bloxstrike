local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
local v_u_4 = game:GetService("Workspace")
require(script:WaitForChild("Types"))
local v_u_5 = v3.LocalPlayer
local v_u_6 = require(v_u_2.Controllers.SpectateController)
local v_u_7 = require(v_u_2.Components.Common.GetSkinDisplayName)
local v_u_8 = require(v_u_2.Components.Common.GetBadgeIcon)
local v_u_9 = require(v_u_2.Packages.Observers)
local v10 = require(v_u_2.Shared.Janitor)
local v_u_11 = require(v_u_2.Database.Custom.GameStats.Settings.Colors)
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = v10.new()
local function v_u_27(p15, p16)
    local v17 = p15:GetAttribute("Team")
    if v17 then
        local v18 = v_u_11["Team Color"][v17]
        local v19 = (p16 or (p15:GetAttribute("ADR") or 0)) * 10
        local v20 = math.floor(v19) / 10
        local v21 = v18.R * 255
        local v22 = math.floor(v21)
        local v23 = v18.G * 255
        local v24 = math.floor(v23)
        local v25 = v18.B * 255
        local v26 = math.floor(v25)
        v_u_12.ADR.Text = ("<font color=\"rgb(%*, %*, %*)\">ADR:</font> %*"):format(v22, v24, v26, v20)
    end
end
function v_u_1.UpdateFrame(p_u_28)
    local v29 = v_u_6.GetCurrentSpectateInstance()
    v_u_12.Player.Player.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(p_u_28.UserId)
    v_u_12.Username.Text = p_u_28.Name
    local v30 = p_u_28:GetAttribute("Team")
    if v30 then
        local v31 = v_u_11["Team Color"][v30]
        v_u_12.Username.TextColor3 = v31
        v_u_12.Badge.Image = v_u_8(p_u_28, v30)
        v_u_12.Frame1.BackgroundColor3 = v31
        v_u_12.Frame2.BackgroundColor3 = v31
        v_u_12.Player.Outline.ImageColor3 = v31
    end
    v_u_14:Cleanup()
    v_u_14:Add(v_u_9.observeAttribute(p_u_28, "ADR", function(p32)
        if typeof(p32) == "number" then
            v_u_27(p_u_28, p32)
        end
    end))
    v_u_27(p_u_28)
    if v29 and v29.CurrentEquipped then
        local v33 = v29.CurrentEquipped
        v_u_12.Skin.Text = v_u_7(v33.Skin)
        v_u_12.Weapon.Text = v33.Name
    end
    if v29 then
        v_u_14:Add(v29.CurrentEquippedChanged:Connect(function(p34)
            if p34 then
                v_u_12.Skin.Text = v_u_7(p34.Skin or "")
                v_u_12.Weapon.Text = p34.Name
            end
        end))
    end
end
function v_u_1.OpenFrame()
    v_u_13.Gameplay.Bottom.Middle.Team.Visible = false
    v_u_12.Visible = true
end
function v_u_1.CloseFrame()
    v_u_12.Visible = false
    v_u_14:Cleanup()
    local v35 = v_u_5.Character
    local v36 = v_u_5:GetAttribute("Team")
    if v35 and (v35:IsDescendantOf(v_u_4) and (v36 and v36 ~= "Spectators")) then
        require(v_u_2.Interface.Screens.Gameplay.Bottom.Middle.Team).OpenFrame()
    end
end
function v_u_1.Initialize(p37, p38)
    v_u_13 = p37
    v_u_12 = p38
end
function v_u_1.Start()
    v_u_6.ListenToSpectate:Connect(function(p39)
        if p39 then
            v_u_1.UpdateFrame(p39)
            v_u_1.OpenFrame()
        else
            v_u_1.CloseFrame()
        end
    end)
end
return v_u_1