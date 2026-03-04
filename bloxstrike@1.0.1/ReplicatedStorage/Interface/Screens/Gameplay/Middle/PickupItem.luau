local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("CollectionService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players").LocalPlayer
local v_u_6 = require(v2.Components.Common.GetSkinDisplayName)
local v_u_7 = require(v2.Database.Components.Libraries.Skins)
local v_u_8 = require(v2.Database.Custom.GameStats.Rarities)
local v_u_9 = nil
local function v_u_17(p10, p11)
    local v12 = v_u_5.Character
    if v12 and v12.PrimaryPart then
        local v13 = p10:GetAttribute("HoveringState")
        local v14 = p11:GetAttribute("HoveringState")
        if v13 == "Hovering" then
            return true
        elseif v14 == "Hovering" then
            return false
        else
            local v15 = p10:GetAttribute("CanPickup")
            local v16 = p11:GetAttribute("CanPickup")
            if v15 == false then
                return false
            elseif v16 == false then
                return true
            elseif p10.PrimaryPart and p11.PrimaryPart then
                return (v12.PrimaryPart.Position - p10.PrimaryPart.Position).Magnitude < (v12.PrimaryPart.Position - p11.PrimaryPart.Position).Magnitude
            else
                return false
            end
        end
    else
        return false
    end
end
function v_u_1.Render(_)
    local v18 = v_u_3:GetTagged("IsHoveringInteractable")
    table.sort(v18, v_u_17)
    local v19 = v18[1]
    if v19 then
        local v20 = v19:GetAttribute("Weapon")
        local v21 = v19:GetAttribute("Skin")
        local v22 = v_u_6(v21)
        local v23 = v_u_7.GetSkinInformation(v20, v21)
        local v24 = "Skin data not found for weapon: " .. v20 .. " and skin: " .. v21
        assert(v23, v24)
        local v25 = v_u_8[v23.rarity]
        local v26 = v25.Color.R * 255
        local v27 = math.floor(v26)
        local v28 = v25.Color.G * 255
        local v29 = math.floor(v28)
        local v30 = v25.Color.B * 255
        local v31 = math.floor(v30)
        v_u_9.TextLabel.Text = ("[E] Swap for <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v27, v29, v31, v20, v22)
        v_u_9.Visible = true
    else
        v_u_9.Visible = false
    end
end
function v_u_1.Initialize(_, p32)
    v_u_9 = p32
    v_u_4.Heartbeat:Connect(function(p33)
        if v_u_5.Character then
            v_u_1.Render(p33)
        else
            v_u_9.Visible = false
        end
    end)
end
return v_u_1