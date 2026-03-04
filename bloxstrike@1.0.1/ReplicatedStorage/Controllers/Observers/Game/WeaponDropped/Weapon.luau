local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = require(v2.Controllers.InventoryController)
local v_u_6 = require(v2.Controllers.DataController)
local v_u_7 = require(v2.Components.Common.GetWeaponProperties)
local v_u_8 = require(v2.Database.Components.Libraries.Skins)
local v_u_9 = require(v2.Shared.Janitor)
local v_u_10 = require(v2.Database.Security.Remotes)
local v_u_11 = require(v2.Database.Security.Router)
local v_u_12 = require(v2.Database.Custom.GameStats.NumberSlots)
local v_u_13 = require(v2.Database.Custom.GameStats.Rarities)
local v_u_14 = require(v2.Database.Custom.GameStats.Grenades)
local v_u_15 = workspace.CurrentCamera
local v_u_16 = v4.LocalPlayer
local v_u_17 = RaycastParams.new()
v_u_17.FilterType = Enum.RaycastFilterType.Exclude
v_u_17.IgnoreWater = true
local v_u_18 = {
    ["ProximityRange"] = 6
}
function v_u_1.autoPickup(p19)
    local v20 = p19.Model:GetAttribute("Weapon")
    if v20 then
        local v21 = v_u_7(v20)
        if v21 then
            local v22 = v_u_12[v21.Slot]
            if v22 then
                local v23 = v_u_5.getInventorySlot(v22)
                local v24 = v_u_14[v20]
                local v25
                if v24 then
                    local v26 = 0
                    if v23 then
                        for _, v27 in ipairs(v23._items) do
                            if v27.Name == v20 then
                                v26 = v26 + 1
                            end
                        end
                    else
                        v26 = 0
                    end
                    if v24 <= v26 then
                        v25 = true
                    else
                        v25 = false
                    end
                else
                    v25 = false
                end
                if v25 then
                    return
                else
                    if v23 then
                        v23 = #v23._items < v23._settings._strict_slot_space
                    end
                    if v23 then
                        if p19.Model:GetAttribute("CanPickup") then
                            local v28 = p19.Model.Name
                            if not p19.SentPickupRequest then
                                p19.SentPickupRequest = true
                                local v29 = v_u_8.GetSkinInformation(p19.Weapon, p19.Skin)
                                local v30 = "Skin data not found for weapon: " .. p19.Weapon .. " and skin: " .. p19.Skin
                                assert(v29, v30)
                                local v31 = v_u_13[v29.rarity]
                                local v32 = v31.Color.R * 255
                                local v33 = math.floor(v32)
                                local v34 = v31.Color.G * 255
                                local v35 = math.floor(v34)
                                local v36 = v31.Color.B * 255
                                local v37 = math.floor(v36)
                                if p19.Weapon == "C4" and v_u_16:GetAttribute("Team") ~= "Terrorists" then
                                    return
                                end
                                v_u_11.broadcastRouter("CreateNotification", "Item Picked Up", ("You picked up a <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v33, v35, v37, p19.Weapon, p19.Skin), 2)
                                v_u_10.Inventory.PickupWeapon.Send({
                                    ["Identity"] = v28
                                })
                            end
                        end
                    end
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.updateState(p38, p39)
    p38.AlphaTime = p38.AlphaTime + p39
    if p38.Model.PrimaryPart then
        v_u_17.FilterDescendantsInstances = { v_u_16.Character, v_u_15 }
        local v40 = workspace:Raycast(v_u_15.CFrame.Position, v_u_15.CFrame.LookVector * 10, v_u_17)
        if v40 then
            v40 = v40.Instance:IsDescendantOf(p38.Model)
        end
        local v41 = v40 and "Hovering"
        local v42 = v_u_16.Character
        if v42 then
            v42 = v_u_16.Character.PrimaryPart
        end
        local v43 = v42 and (v42.Position - p38.Model.PrimaryPart.Position).Magnitude <= v_u_18.ProximityRange and (v41 or "Proximity") or v41
        if p38.Weapon == "C4" then
            local v44 = v_u_16:GetAttribute("Team")
            if p38.AlphaTime >= 1 then
                local v45 = p38.Model.Weapon:FindFirstChild("FlashingLight")
                p38.AlphaTime = 0
                if v45 then
                    v45.Attachment.PointLight.Enabled = not v45.Attachment.PointLight.Enabled
                    v45.Attachment.PointLight.Color = Color3.fromRGB(255, 255, 15)
                    v45.Attachment.PointLight.Brightness = 5
                end
            end
            if v44 ~= "Terrorists" then
                v43 = false
            end
        end
        if v43 == "Hovering" or v43 == "Proximity" then
            p38.Model:SetAttribute("HoveringState", v43)
            p38.Model:AddTag("IsHoveringInteractable")
            if v43 == "Proximity" then
                local v46 = v_u_6.Get(v_u_16, "Settings.Game.Item.Auto Pickup Dropped Weapons")
                local v47 = v_u_7(p38.Weapon)
                if v47 then
                    v47 = v47.Slot
                end
                local v48 = v47 == "Grenade" and true or v47 == "C4"
                if v46 ~= false or v48 then
                    p38:autoPickup()
                    return
                end
            end
        else
            p38.Model:RemoveTag("IsHoveringInteractable")
            p38.Model:SetAttribute("HoveringState", nil)
        end
    end
end
function v_u_1.new(p49)
    local v50 = v_u_1
    local v_u_51 = setmetatable({}, v50)
    v_u_51.Janitor = v_u_9.new()
    v_u_51.Model = p49
    v_u_51.AlphaTime = 0
    v_u_51.Weapon = v_u_51.Model:GetAttribute("Weapon")
    v_u_51.Skin = v_u_51.Model:GetAttribute("Skin")
    v_u_51.SentPickupRequest = false
    v_u_51.Janitor:Add(v_u_3.Heartbeat:Connect(function(p52)
        if v_u_51.Model and v_u_51.Model.PrimaryPart then
            v_u_51:updateState(p52)
        end
    end))
    return v_u_51
end
function v_u_1.destroy(p53)
    p53.Janitor:Destroy()
end
return v_u_1