local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v5 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_6 = v5.LocalPlayer
local v_u_7 = require(v2.Controllers.InventoryController)
local v_u_8 = require(v2.Controllers.SpectateController)
local v_u_9 = require(v2.Components.Common.GetPreferenceColor)
local v_u_10 = require(v2.Components.Common.GetWeaponProperties)
local v_u_11 = require(v2.Controllers.DataController)
local v_u_12 = require(v2.Database.Components.GameState)
local v_u_13 = require(v2.Packages.Observers)
local v14 = require(v2.Shared.Janitor)
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = game:GetService("HttpService")
local v_u_20 = v14.new()
function v_u_1.tweenAnimation(p21)
    if v_u_15 ~= p21.Identifier then
        v_u_15 = p21.Identifier
        v_u_17.Size = UDim2.new(v_u_17.Size.X.Scale, -25, v_u_17.Size.Y.Scale, -25)
        if v_u_16 then
            v_u_16:Play()
        end
    end
end
function v_u_1.updateFrame(p22)
    local v23 = p22.Properties
    v_u_17.Visible = v23.Class == "Weapon"
    if v_u_17.Visible then
        v_u_1.tweenAnimation(p22)
        local v24 = p22.Rounds
        local v25 = p22.Capacity
        v_u_17.Capacity.Amount.Text = tostring(v25)
        v_u_17.Rounds.Amount.Text = tostring(v24)
        local v26 = v_u_9()
        v_u_17.Capacity.Amount.TextColor3 = v26
        v_u_17.Rounds.Amount.TextColor3 = v26
        v_u_17.Divider.BackgroundColor3 = v26
        v_u_17.SemiAuto.ImageColor3 = v26
        v_u_17.Auto.ImageColor3 = v26
        local v27 = v24 / v23.Rounds
        v_u_17.Rounds.Glow.ImageTransparency = 1
        if v27 <= 0.2 then
            v_u_17.Rounds.Glow.ImageTransparency = math.max(v27, 0.3)
        end
        if v23.ShootingOptions == "Default" then
            v_u_17.SemiAuto.Visible = not v23.Automatic
            v_u_17.Auto.Visible = v23.Automatic
        elseif v23.ShootingOptions == "Burst" then
            v_u_17.SemiAuto.Visible = p22.AlternativeShootingOption == "Default"
            v_u_17.Auto.Visible = p22.AlternativeShootingOption == "Burst"
        end
    elseif v_u_16 then
        v_u_16:Cancel()
    end
    local v28 = v_u_17
    local v29 = v_u_17.Visible
    if v29 then
        v29 = not v_u_18.Gameplay.Middle.BuyMenu.Visible
    end
    v28.Visible = v29
end
local function v_u_37()
    local v30 = v_u_7.getCurrentEquipped()
    if v30 then
        local v31 = v30.Rounds
        local v32 = v30.Capacity
        local v33 = v_u_17.Rounds.Amount.Text
        local v34 = tonumber(v33) or 0
        local v35 = v_u_17.Capacity.Amount.Text
        local v36 = tonumber(v35) or 0
        if v31 ~= v34 or v32 ~= v36 then
            v_u_1.updateFrame(v30)
        end
    end
end
function v_u_1.characterAdded(_, p38)
    v_u_20:Cleanup()
    if p38 == v_u_6 then
        v_u_20:Add(v_u_4.Stepped:Connect(function(_, _)
            local v39 = v_u_7.getCurrentEquipped()
            if v39 then
                v_u_1.updateFrame(v39)
            end
        end))
        task.wait(0.1)
        v_u_37()
        task.delay(3, function()
            if v_u_6.Character and v_u_6.Character:IsDescendantOf(workspace) then
                v_u_37()
            end
        end)
        return
    else
        v_u_20:Add(v_u_13.observeAttribute(p38, "CurrentEquipped", function(p40)
            if p40 then
                local v41 = v_u_19:JSONDecode(p40)
                if v41 and v41.Name then
                    local v42 = {
                        ["Properties"] = v_u_10(v41.Name),
                        ["Identifier"] = v41.Identifier or "",
                        ["Rounds"] = v41.Rounds or 0,
                        ["Capacity"] = v41.Capacity or 0,
                        ["AlternativeShootingOption"] = "Default"
                    }
                    if v42.Properties and v42.Properties.Class == "Weapon" then
                        v_u_1.updateFrame(v42)
                    else
                        v_u_17.Visible = false
                    end
                else
                    v_u_17.Visible = false
                    return
                end
            else
                v_u_17.Visible = false
                return
            end
        end))
        local v43 = p38:GetAttribute("CurrentEquipped")
        if v43 then
            local v44 = v_u_19:JSONDecode(v43)
            if v44 and v44.Name then
                local v45 = {
                    ["Properties"] = v_u_10(v44.Name),
                    ["Identifier"] = v44.Identifier or "",
                    ["Rounds"] = v44.Rounds or 0,
                    ["Capacity"] = v44.Capacity or 0,
                    ["AlternativeShootingOption"] = "Default"
                }
                if v45.Properties and v45.Properties.Class == "Weapon" then
                    v_u_1.updateFrame(v45)
                else
                    v_u_17.Visible = false
                end
            else
                v_u_17.Visible = false
                return
            end
        else
            v_u_17.Visible = false
            return
        end
    end
end
function v_u_1.Initialize(p46, p47)
    v_u_18 = p46
    v_u_17 = p47
    if v_u_17.Active then
        v_u_17.Active = false
    end
    for _, v48 in ipairs(v_u_17:GetDescendants()) do
        if v48:IsA("GuiObject") then
            v48.Active = false
        end
    end
    v_u_16 = v_u_3:Create(v_u_17, TweenInfo.new(0.25), {
        ["Size"] = UDim2.fromScale(v_u_17.Size.X.Scale, v_u_17.Size.Y.Scale)
    })
    v_u_6.CharacterRemoving:Connect(function()
        v_u_20:Cleanup()
    end)
    v_u_13.observeProperty(v_u_17.Rounds.Amount, "Text", function(_)
        local v49 = v_u_3:Create(v_u_17.Rounds.Amount.UIScale, TweenInfo.new(0.05), {
            ["Scale"] = 1.2
        })
        v49:Play()
        v49.Completed:Once(function()
            v_u_3:Create(v_u_17.Rounds.Amount.UIScale, TweenInfo.new(0.05, Enum.EasingStyle.Elastic), {
                ["Scale"] = 1
            }):Play()
        end)
    end)
    v_u_11.CreateListener(v_u_6, "Settings.Game.HUD.Color", function()
        local v50 = v_u_7.getCurrentEquipped()
        if v50 then
            v_u_1.updateFrame(v50)
        end
    end)
end
function v_u_1.Start()
    local v_u_51 = nil
    local function v_u_56(p_u_52)
        v_u_20:Cleanup()
        v_u_51 = p_u_52
        local v53 = p_u_52.Character
        if v53 and v53:IsDescendantOf(workspace) then
            v_u_1.characterAdded(v53, p_u_52)
        elseif p_u_52 ~= v_u_6 then
            local v_u_54 = nil
            v_u_54 = p_u_52.CharacterAdded:Connect(function(p55)
                if v_u_51 == p_u_52 and p55:IsDescendantOf(workspace) then
                    v_u_1.characterAdded(p55, p_u_52)
                    v_u_54:Disconnect()
                end
            end)
            v_u_20:Add(v_u_54)
        end
    end
    v_u_6.CharacterAdded:Connect(function()
        v_u_56(v_u_6)
    end)
    v_u_8.ListenToSpectate:Connect(function(p57)
        if p57 then
            v_u_56(p57)
        elseif not v_u_6:GetAttribute("IsSpectating") then
            v_u_56(v_u_6)
        end
    end)
    v_u_6:GetAttributeChangedSignal("IsSpectating"):Connect(function()
        if v_u_6:GetAttribute("IsSpectating") then
            local v58 = v_u_8.GetPlayer()
            if v58 then
                v_u_56(v58)
            end
        else
            v_u_56(v_u_6)
        end
    end)
    if v_u_6:GetAttribute("IsSpectating") then
        local v59 = v_u_8.GetPlayer()
        if v59 then
            v_u_56(v59)
        end
    else
        v_u_56(v_u_6)
    end
    v_u_12.ListenToState(function(_, p60)
        if p60 == "Buy Period" or p60 == "Round In Progress" then
            v_u_56(v_u_6)
        end
    end)
end
return v_u_1