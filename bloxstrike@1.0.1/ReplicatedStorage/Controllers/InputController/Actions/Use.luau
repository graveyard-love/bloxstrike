local v_u_1 = game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("CollectionService")
local v_u_4 = game:GetService("Players")
local v_u_5 = game:GetService("Workspace")
require(v2.Database.Custom.Types)
require(script.Parent.Parent.Types)
local v_u_6 = v_u_4.LocalPlayer
local v_u_7 = require(v2.Controllers.InventoryController)
local v8 = require(v2.Controllers.DataController)
local v_u_9 = require(v2.Components.Common.VFXLibary.FlashEffect)
local v_u_10 = require(v2.Components.Common.GetWeaponProperties)
local v11 = require(v2.Components.Common.GetUserPlatform)
local v_u_12 = require(v2.Database.Components.Libraries.Skins)
local v_u_13 = require(v2.Database.Custom.GameStats.NumberSlots)
local v_u_14 = require(v2.Database.Custom.GameStats.Rarities)
local v_u_15 = require(v2.Database.Custom.GameStats.Grenades)
local v_u_16 = require(v2.Database.Security.Remotes)
local v_u_17 = require(v2.Database.Security.Router)
local v_u_18 = workspace.CurrentCamera
local v_u_19 = RaycastParams.new()
v_u_19.FilterType = Enum.RaycastFilterType.Exclude
v_u_19.IgnoreWater = true
local v_u_20 = RaycastParams.new()
v_u_20.FilterType = Enum.RaycastFilterType.Exclude
v_u_20.IgnoreWater = true
local v_u_21
if table.find(v11(), "Mobile") == nil then
    v_u_21 = false
else
    v_u_21 = #v11() <= 1
end
local v_u_22 = nil
local v_u_23 = nil
local v_u_24 = false
local v_u_25 = true
local v_u_26 = nil
local v_u_27 = {
    ["UserInputType"] = Enum.UserInputType.Touch
}
local v_u_28 = nil
local function v_u_35(p29)
    if p29 and p29.Parent then
        local v30 = p29.Parent
        local v31 = v30:FindFirstChildOfClass("Humanoid")
        if v31 and v31.Health > 0 then
            local v32 = v_u_4:GetPlayerFromCharacter(v30)
            if v32 then
                local v33 = v_u_6:GetAttribute("Team")
                local v34 = v32:GetAttribute("Team")
                if v34 then
                    return workspace:GetAttribute("Gamemode") == "Deathmatch" and true or v34 ~= v33
                else
                    return false
                end
            else
                return false
            end
        else
            return false
        end
    else
        return false
    end
end
local function v_u_43(p36, p37)
    local v38 = v_u_6.Character
    if v38 and v38.PrimaryPart then
        local v39 = p36:GetAttribute("HoveringState")
        local v40 = p37:GetAttribute("HoveringState")
        if v39 == "Hovering" then
            return true
        elseif v40 == "Hovering" then
            return false
        else
            local v41 = p36:GetAttribute("CanPickup")
            local v42 = p37:GetAttribute("CanPickup")
            if v41 == false then
                return false
            elseif v42 == false then
                return true
            elseif p36.PrimaryPart and p37.PrimaryPart then
                return (v38.PrimaryPart.Position - p36.PrimaryPart.Position).Magnitude < (v38.PrimaryPart.Position - p37.PrimaryPart.Position).Magnitude
            else
                return false
            end
        end
    else
        return false
    end
end
local function v_u_48()
    if not (v_u_18 and v_u_6.Character) then
        return nil
    end
    if v_u_6:GetAttribute("Team") ~= "Counter-Terrorists" then
        return nil
    end
    v_u_19.FilterDescendantsInstances = { v_u_6.Character, v_u_18 }
    local v44 = workspace:Raycast(v_u_18.CFrame.Position, v_u_18.CFrame.LookVector * 5, v_u_19)
    if v44 then
        local v45 = v44.Instance
        if v45 and (v45.Parent and v45.Parent:HasTag("Hostage")) or false then
            local v46 = v44.Instance.Parent
            if v46 and v46:GetAttribute("CanRescue") == true then
                local v47 = v46:GetAttribute("RescuingPlayer")
                if v47 and v47 ~= v_u_6.Name then
                    return nil
                elseif v46:GetAttribute("CarryingPlayer") then
                    return nil
                else
                    return v46
                end
            end
        end
    end
    return nil
end
local function v_u_80(p49, p50, p51)
    local function v74(p52, p53, p54, p55, p56)
        local v57 = 0
        local v58 = p53.X
        local v59, v60
        if math.abs(v58) < 0.0001 then
            if p52.X < p54.X or p52.X > p55.X then
                return false
            end
            v59 = p56
            v60 = v57
        else
            local v61 = 1 / p53.X
            v59 = (p54.X - p52.X) * v61
            v60 = (p55.X - p52.X) * v61
            if v60 >= v59 then
                local v62 = v59
                v59 = v60
                v60 = v62
            end
            if v57 >= v60 then
                v60 = v57
            end
            if v59 >= p56 then
                v59 = p56
            end
            if v59 < v60 then
                return false
            end
        end
        local v63 = p53.Y
        if math.abs(v63) < 0.0001 then
            if p52.Y < p54.Y or p52.Y > p55.Y then
                return false
            end
        else
            local v64 = 1 / p53.Y
            local v65 = (p54.Y - p52.Y) * v64
            local v66 = (p55.Y - p52.Y) * v64
            if v66 >= v65 then
                local v67 = v65
                v65 = v66
                v66 = v67
            end
            if v60 >= v66 then
                v66 = v60
            end
            if v65 >= v59 then
                v65 = v59
            end
            if v65 < v66 then
                return false
            end
            v59 = v65
            v60 = v66
        end
        local v68 = p53.Z
        if math.abs(v68) < 0.0001 then
            if p52.Z < p54.Z or p52.Z > p55.Z then
                return false
            end
        else
            local v69 = 1 / p53.Z
            local v70 = (p54.Z - p52.Z) * v69
            local v71 = (p55.Z - p52.Z) * v69
            if v71 >= v70 then
                local v72 = v70
                v70 = v71
                v71 = v72
            end
            if v60 >= v71 then
                v71 = v60
            end
            if v70 >= v59 then
                v70 = v59
            end
            if v70 < v71 then
                return false
            end
            v60 = v71
        end
        local v73
        if v60 >= 0 then
            v73 = v60 <= p56
        else
            v73 = false
        end
        return v73
    end
    local v75 = v_u_5:FindFirstChild("Debris")
    if not v75 then
        return false
    end
    for _, v76 in ipairs(v75:GetChildren()) do
        if v76.Name:match("^VoxelSmoke_") and v76:IsA("Folder") then
            for _, v77 in ipairs(v76:GetChildren()) do
                if v77:IsA("BasePart") and v77.Name == "SmokeVoxel" then
                    local v78 = v77.Size
                    local v79 = v77.Position
                    if v74(p49, p50, v79 - v78 / 2, v79 + v78 / 2, p51) then
                        return true
                    end
                end
            end
        end
    end
    return false
end
local function v_u_87(p81)
    if not (workspace.CurrentCamera and v_u_6.Character) then
        return nil
    end
    v_u_20.FilterDescendantsInstances = { v_u_6.Character, workspace.CurrentCamera }
    local v82 = workspace.CurrentCamera
    local v83 = v82.CFrame.Position
    local v84 = {
        v82.CFrame.LookVector,
        (v82.CFrame * CFrame.Angles(0.017453292519943295, 0, 0)).LookVector,
        (v82.CFrame * CFrame.Angles(-0.017453292519943295, 0, 0)).LookVector,
        (v82.CFrame * CFrame.Angles(0, 0.017453292519943295, 0)).LookVector,
        (v82.CFrame * CFrame.Angles(0, -0.017453292519943295, 0)).LookVector,
        (v82.CFrame * CFrame.Angles(0.012217304763960306, 0.012217304763960306, 0)).LookVector,
        (v82.CFrame * CFrame.Angles(0.012217304763960306, -0.012217304763960306, 0)).LookVector,
        (v82.CFrame * CFrame.Angles(-0.012217304763960306, 0.012217304763960306, 0)).LookVector,
        (v82.CFrame * CFrame.Angles(-0.012217304763960306, -0.012217304763960306, 0)).LookVector
    }
    for _, v85 in ipairs(v84) do
        local v86 = workspace:Raycast(v83, v85 * p81, v_u_20)
        if v86 and (v_u_35(v86.Instance) and not v_u_80(v83, v85, v86.Distance)) then
            return v86.Instance.Parent
        end
    end
    return nil
end
task.defer(function()
    v_u_28 = require(script.Parent.Fire).Callback
    if v_u_21 then
        if v_u_25 and v_u_28 then
            if v_u_25 then
                if not v_u_26 then
                    v_u_26 = v_u_1.RenderStepped:Connect(function()
                        local v88 = v_u_7.getCurrentEquipped()
                        local v89
                        if v88 then
                            v89 = v88.Properties.Class == "Weapon"
                        else
                            v89 = v88
                        end
                        local v90 = v_u_87(v89 and v88.IsAiming and (v88.Properties.Range or 180) or 180) ~= nil
                        if not v89 then
                            v90 = false
                        end
                        local v91 = tick()
                        if v90 then
                            if not v_u_22 then
                                v_u_22 = v91
                            end
                            if v91 - v_u_22 >= 0.05 and ((not v_u_23 or (v88.Properties.FireRate or 0.15) <= v91 - v_u_23) and (v_u_28 and not v_u_9.IsFlashed())) then
                                v_u_28(Enum.UserInputState.Begin, v_u_27)
                                v_u_23 = v91
                            end
                        else
                            v_u_22 = nil
                            v_u_23 = nil
                            if v_u_24 and v_u_28 then
                                v_u_28(Enum.UserInputState.End, v_u_27)
                            end
                        end
                        v_u_24 = v90
                    end)
                end
            else
                return
            end
        else
            if v_u_26 then
                v_u_26:Disconnect()
                v_u_26 = nil
            end
            if v_u_24 then
                if v_u_28 then
                    v_u_28(Enum.UserInputState.End, v_u_27)
                end
                v_u_24 = false
            end
            v_u_22 = nil
            v_u_23 = nil
            return
        end
    else
        return
    end
end)
v_u_6.CharacterRemoving:Connect(function()
    if v_u_21 then
        if v_u_26 then
            v_u_26:Disconnect()
            v_u_26 = nil
        end
        if v_u_24 then
            if v_u_28 then
                v_u_28(Enum.UserInputState.End, v_u_27)
            end
            v_u_24 = false
        end
        v_u_22 = nil
        v_u_23 = nil
    end
end)
v_u_6.CharacterAdded:Connect(function()
    if v_u_21 then
        if v_u_21 then
            if v_u_25 and v_u_28 then
                if v_u_25 then
                    if not v_u_26 then
                        v_u_26 = v_u_1.RenderStepped:Connect(function()
                            local v92 = v_u_7.getCurrentEquipped()
                            local v93
                            if v92 then
                                v93 = v92.Properties.Class == "Weapon"
                            else
                                v93 = v92
                            end
                            local v94 = v_u_87(v93 and v92.IsAiming and (v92.Properties.Range or 180) or 180) ~= nil
                            if not v93 then
                                v94 = false
                            end
                            local v95 = tick()
                            if v94 then
                                if not v_u_22 then
                                    v_u_22 = v95
                                end
                                if v95 - v_u_22 >= 0.05 and ((not v_u_23 or (v92.Properties.FireRate or 0.15) <= v95 - v_u_23) and (v_u_28 and not v_u_9.IsFlashed())) then
                                    v_u_28(Enum.UserInputState.Begin, v_u_27)
                                    v_u_23 = v95
                                end
                            else
                                v_u_22 = nil
                                v_u_23 = nil
                                if v_u_24 and v_u_28 then
                                    v_u_28(Enum.UserInputState.End, v_u_27)
                                end
                            end
                            v_u_24 = v94
                        end)
                    end
                else
                    return
                end
            else
                if v_u_26 then
                    v_u_26:Disconnect()
                    v_u_26 = nil
                end
                if v_u_24 then
                    if v_u_28 then
                        v_u_28(Enum.UserInputState.End, v_u_27)
                    end
                    v_u_24 = false
                end
                v_u_22 = nil
                v_u_23 = nil
                return
            end
        else
            return
        end
    else
        return
    end
end)
v8.CreateListener(v_u_6, "Settings.Game.Other.Mobile Auto Shoot", function(p96)
    v_u_25 = p96 ~= false
    if v_u_21 then
        if v_u_25 and v_u_28 then
            if v_u_25 then
                if not v_u_26 then
                    v_u_26 = v_u_1.RenderStepped:Connect(function()
                        local v97 = v_u_7.getCurrentEquipped()
                        local v98
                        if v97 then
                            v98 = v97.Properties.Class == "Weapon"
                        else
                            v98 = v97
                        end
                        local v99 = v_u_87(v98 and v97.IsAiming and (v97.Properties.Range or 180) or 180) ~= nil
                        if not v98 then
                            v99 = false
                        end
                        local v100 = tick()
                        if v99 then
                            if not v_u_22 then
                                v_u_22 = v100
                            end
                            if v100 - v_u_22 >= 0.05 and ((not v_u_23 or (v97.Properties.FireRate or 0.15) <= v100 - v_u_23) and (v_u_28 and not v_u_9.IsFlashed())) then
                                v_u_28(Enum.UserInputState.Begin, v_u_27)
                                v_u_23 = v100
                            end
                        else
                            v_u_22 = nil
                            v_u_23 = nil
                            if v_u_24 and v_u_28 then
                                v_u_28(Enum.UserInputState.End, v_u_27)
                            end
                        end
                        v_u_24 = v99
                    end)
                end
            else
                return
            end
        else
            if v_u_26 then
                v_u_26:Disconnect()
                v_u_26 = nil
            end
            if v_u_24 then
                if v_u_28 then
                    v_u_28(Enum.UserInputState.End, v_u_27)
                end
                v_u_24 = false
            end
            v_u_22 = nil
            v_u_23 = nil
            return
        end
    else
        return
    end
end)
return table.freeze({
    ["Category"] = "Weapon Keys",
    ["Callback"] = function(p101, _)
        if v_u_6:GetAttribute("IsPlayerChatting") then
            return
        elseif v_u_6.Character then
            if p101 == Enum.UserInputState.Begin then
                local v102 = v_u_3:GetTagged("Bomb")[1]
                if v102 and (v102:GetAttribute("CanDefuse") and not v102:GetAttribute("Defused")) then
                    v_u_17.broadcastRouter("Start Defuse Bomb")
                    return
                end
                local v103 = v_u_48()
                if v103 then
                    local v104 = v_u_6:GetAttribute("Team")
                    if not v_u_6:GetAttribute("IsCarryingHostage") and (not v_u_6:GetAttribute("IsRescuingHostage") and v104 == "Counter-Terrorists") then
                        local v105 = v103:GetAttribute("RescuingPlayer")
                        local v106 = v103:GetAttribute("CarryingPlayer")
                        if (not v105 or v105 == v_u_6.Name) and not v106 then
                            v_u_17.broadcastRouter("Start Rescue Hostage")
                            return
                        end
                    end
                end
                local v107 = v_u_3:GetTagged("IsHoveringInteractable")
                if #v107 == 0 then
                    return
                end
                table.sort(v107, v_u_43)
                local v108 = v107[1]
                local v109 = v108:GetAttribute("Weapon")
                local v110 = v108:GetAttribute("Skin")
                if v109 == "C4" and v_u_6:GetAttribute("Team") ~= "Terrorists" then
                    return
                end
                if v_u_15[v109] ~= nil then
                    local v111 = v_u_10(v109)
                    if v111 then
                        local v112 = v_u_13[v111.Slot]
                        local v113 = v_u_7.getInventorySlot(v112)
                        if v113 then
                            local v114 = v113._items
                            local v115 = 0
                            for _, v116 in ipairs(v114) do
                                if v116.Name == v109 then
                                    v115 = v115 + 1
                                end
                            end
                            local v117 = #v113._items >= v113._settings._strict_slot_space
                            if v_u_15[v109] <= v115 or v117 then
                                return
                            end
                        end
                    end
                end
                if v108:GetAttribute("CanPickup") then
                    local v118 = v_u_12.GetSkinInformation(v109, v110)
                    if v118 then
                        local v119 = v_u_14[v118.rarity]
                        local v120 = v119.Color.R * 255
                        local v121 = math.floor(v120)
                        local v122 = v119.Color.G * 255
                        local v123 = math.floor(v122)
                        local v124 = v119.Color.B * 255
                        local v125 = math.floor(v124)
                        v_u_17.broadcastRouter("CreateNotification", "Item Picked Up", ("You picked up a <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v121, v123, v125, v109, v110), 2)
                    end
                    v_u_16.Inventory.PickupWeapon.Send({
                        ["Identity"] = v108.Name
                    })
                    return
                end
            elseif p101 == Enum.UserInputState.End then
                if v_u_3:GetTagged("Bomb")[1] and v_u_6:GetAttribute("IsDefusingBomb") then
                    v_u_17.broadcastRouter("Cancel Defuse Bomb")
                    return
                end
                if v_u_6:GetAttribute("IsRescuingHostage") then
                    v_u_17.broadcastRouter("Cancel Rescue Hostage")
                    return
                end
            end
        end
    end,
    ["Group"] = "Gameplay",
    ["Name"] = "Use"
})