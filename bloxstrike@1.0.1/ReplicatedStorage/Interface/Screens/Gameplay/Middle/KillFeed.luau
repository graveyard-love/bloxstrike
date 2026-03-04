local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Players")
local v_u_5 = game:GetService("Debris")
require(script:WaitForChild("Types"))
local v_u_6 = require(v_u_2.Database.Security.Remotes)
local v_u_7 = v_u_4.LocalPlayer
local v_u_8 = nil
local function v_u_14(p9, p10, p11)
    if p11 then
        local v12 = v_u_4:GetPlayerByUserId(p11)
        if not (v12 and v12:IsDescendantOf(v_u_4)) then
            p10.Visible = false
            return
        end
        local v13 = v12:GetAttribute("Team")
        p10.Text = v12.DisplayName
        p10.Visible = true
        if v_u_7.UserId == p11 then
            p9.UIStroke.Color = Color3.fromRGB(255, 0, 0)
        end
        if v13 == "Counter-Terrorists" then
            p10.TextColor3 = Color3.fromRGB(165, 183, 212)
            return
        end
        if v13 == "Terrorists" then
            p10.TextColor3 = Color3.fromRGB(219, 199, 126)
            return
        end
    end
end
function v_u_1.createTemplate(p15)
    local v16 = require(v_u_2.Database.Custom.Weapons[p15.Weapon])
    v_u_8.Visible = true
    local v_u_17 = v_u_2.Assets.UI.KillFeed.Kill:Clone()
    v_u_17.Parent = v_u_8
    local v18 = v_u_17.Contents:FindFirstChild("UIPadding")
    if not v18 then
        v18 = Instance.new("UIPadding")
        v18.Parent = v_u_17.Contents
    end
    v18.PaddingLeft = UDim.new(0, 5)
    v18.PaddingRight = UDim.new(0, 5)
    local v19 = v_u_14
    local v20 = v_u_17.Contents.Player
    local v21 = p15.Killer
    v19(v_u_17, v20, (tonumber(v21)))
    local v22 = v_u_14
    local v23 = v_u_17.Contents.Enemy
    local v24 = p15.Victim
    v22(v_u_17, v23, (tonumber(v24)))
    if p15.Assistor then
        local v25 = v_u_14
        local v26 = v_u_17.Contents.Assistor
        local v27 = p15.Assistor
        v25(v_u_17, v26, (tonumber(v27)))
        v_u_17.Contents.Addition.Visible = true
        v_u_17.Contents.FlashAssist.Visible = p15.FlashAssist == true
    else
        v_u_17.Contents.Assistor.Visible = false
        v_u_17.Contents.Addition.Visible = false
        v_u_17.Contents.FlashAssist.Visible = false
    end
    v_u_17.Contents.Weapon.Image = v16.ReverseIcon
    v_u_17.Contents.Headshot.Visible = p15.Headshot
    v_u_17.Contents.NoScope.Visible = p15.NoScope == true
    v_u_17.Contents.Smoke.Visible = p15.Smoke == true
    v_u_17.Contents.Blind.Visible = p15.Blind == true
    v_u_17.Contents.Wallbang.Visible = p15.Wallbang == true
    v_u_17.Contents.Jump.Visible = p15.Jump == true
    local function v30()
        local v28 = v_u_17.Contents.Player
        if v28 and v28.AbsoluteSize.Y > 0 then
            local v29 = v28.AbsoluteSize.Y * 0.84 * 1.67
            v_u_17.Contents.Headshot.Size = UDim2.new(0, v29, 0, v29)
            v_u_17.Contents.NoScope.Size = UDim2.new(0, v29 * 0.8333333333333334, 0, v29 * 0.8333333333333334)
            v_u_17.Contents.Smoke.Size = UDim2.new(0, v29 * 1.1111111111111112, 0, v29 * 0.7777777777777778)
            v_u_17.Contents.Wallbang.Size = UDim2.new(0, v29 * 1.1111111111111112, 0, v29 * 1.1111111111111112)
            v_u_17.Contents.Blind.Size = UDim2.new(0, v29 * 0.8333333333333334, 0, v29 * 0.8333333333333334)
            v_u_17.Contents.Jump.Size = UDim2.new(0, v29, 0, v29)
            v_u_17.Contents.FlashAssist.Size = UDim2.new(0, v29, 0, v29)
        end
    end
    v30()
    v_u_17.Contents:GetPropertyChangedSignal("AbsoluteSize"):Connect(v30)
    local v31 = 0
    if p15.Blind == true then
        v_u_17.Contents.Blind.LayoutOrder = v31
        v31 = v31 + 1
    end
    v_u_17.Contents.Player.LayoutOrder = v31
    local v32 = v31 + 1
    if p15.Assistor then
        v_u_17.Contents.Addition.LayoutOrder = v32
        local v33 = v32 + 1
        if p15.FlashAssist == true then
            v_u_17.Contents.FlashAssist.LayoutOrder = v33
            v33 = v33 + 1
        end
        v_u_17.Contents.Assistor.LayoutOrder = v33
        v32 = v33 + 1
    end
    if p15.Jump == true then
        v_u_17.Contents.Jump.LayoutOrder = v32
        v32 = v32 + 1
    end
    v_u_17.Contents.Weapon.LayoutOrder = v32
    local v34 = v32 + 1
    if p15.NoScope == true then
        v_u_17.Contents.NoScope.LayoutOrder = v34
        v34 = v34 + 1
    end
    if p15.Smoke == true then
        v_u_17.Contents.Smoke.LayoutOrder = v34
        v34 = v34 + 1
    end
    if p15.Wallbang == true then
        v_u_17.Contents.Wallbang.LayoutOrder = v34
        v34 = v34 + 1
    end
    if p15.Headshot == true then
        v_u_17.Contents.Headshot.LayoutOrder = v34
        v34 = v34 + 1
    end
    v_u_17.Contents.Enemy.LayoutOrder = v34
    v_u_17.Visible = true
    task.delay(5, function()
        v_u_3:Create(v_u_17, TweenInfo.new(1), {
            ["GroupTransparency"] = 1
        }):Play()
        v_u_3:Create(v_u_17.UIStroke, TweenInfo.new(1), {
            ["Transparency"] = 1
        }):Play()
        v_u_5:AddItem(v_u_17, 1)
    end)
end
function v_u_1.Initialize(_, p35)
    v_u_8 = p35
    v_u_6.UI.UIPlayerKilled.Listen(function(p36)
        v_u_1.createTemplate(p36)
    end)
end
return v_u_1