local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players")
require(v_u_2.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_6 = require(v_u_2.Classes.WeaponComponent)
local v7 = require(v_u_2.Classes.Sound)
local v_u_8 = require(v_u_2.Components.Common.VFXLibary.CreateMuzzleFlash.Camera)
local v_u_9 = require(v_u_2.Components.Common.VFXLibary.CreateMarker)
local v_u_10 = require(v_u_2.Components.Common.VFXLibary.CreateImpact)
local v_u_11 = require(v_u_2.Components.Common.VFXLibary.CreateTracer)
local v_u_12 = require(v_u_2.Components.Common.VFXLibary.BreakGlass)
local v_u_13 = require(v_u_2.Controllers.HapticsController)
local v_u_14 = require(v_u_2.Controllers.CameraController)
local v_u_15 = require(v_u_2.Controllers.SoundController)
local v_u_16 = require(v_u_2.Controllers.InputController)
local v_u_17 = require(v_u_2.Controllers.HintController)
local v_u_18 = require(v_u_2.Controllers.DataController)
local v_u_19 = require(v_u_2.Database.Components.GameState)
local v_u_20 = require(v_u_2.Database.Security.Remotes)
local v_u_21 = require(v_u_2.Database.Security.Router)
local v_u_22 = require(v_u_2.Database.Custom.Constants)
local v_u_23 = require(script.Classes.Bullet)
local v_u_24 = workspace.CurrentCamera
local v_u_25 = v_u_5.LocalPlayer
local v_u_26 = v7.new("Other")
local v_u_27 = { Enum.UserInputType.MouseButton1, Enum.KeyCode.ButtonR2 }
local v_u_28 = {}
local v_u_29 = { 37, 60 }
for _, v30 in ipairs(v_u_2.Database.Custom.Weapons:GetChildren()) do
    if v30:IsA("ModuleScript") then
        v_u_28[v30.Name] = require(v30)
    end
end
local function v_u_34()
    local v31 = v_u_16.getActionKeybinds("Fire")
    for _, v32 in ipairs(v31) do
        if v_u_16.isBindingPressed(v32) then
            return v32
        end
    end
    if #v31 == 0 then
        for _, v33 in ipairs(v_u_27) do
            if v_u_16.isBindingPressed(v33) then
                return v33
            end
        end
    end
    return nil
end
local function v_u_53(p35)
    local v36 = p35.Rotation
    local v37 = p35.Position
    local v38 = v36.RotationDampen.Value
    local v39 = v36.RotationSpeed.Value
    local v40 = v39 >= 30 and 25 or v39
    local v41 = v36.RotationX.Value
    local v42 = v36.RotationY.Value
    local v43 = v36.RotationZ.Value
    local v44 = v38 >= 5 and 1 or v38
    local v45 = v41 < 0.1 and 1 or v41
    local v46 = v42 < 0.1 and 25 or v42
    local v47 = v43 < 0.1 and 1 or v43
    local v48 = {
        ["Value"] = Vector3.new(v45, v46, v47),
        ["Damper"] = v44,
        ["Speed"] = v40
    }
    local v49 = {}
    local v50 = v37.PositionX.Value
    local v51 = v37.PositionY.Value
    local v52 = v37.PositionZ.Value
    v49.Value = Vector3.new(v50, v51, v52)
    v49.Damper = v37.PositionDampen.Value
    v49.Speed = v37.PositionSpeed.Value
    v_u_14.weaponKick(v48, v49)
end
function v_u_1.isJumping(_)
    return false
end
function v_u_1.getSpread(p54)
    local v55 = p54.Bullet:getTrueSpread()
    if p54:isJumping() then
        return v55 + 0
    else
        return v55
    end
end
function v_u_1.getBaseSpread(p56)
    local v57 = p56.Bullet:getBaseSpread()
    if p56:isJumping() then
        return v57 + 0
    else
        return v57
    end
end
function v_u_1.stopAllAnimations(p58)
    if p58.CharacterAnimator then
        if p58.Viewmodel and p58.Viewmodel.Animation then
            p58.Viewmodel.Animation:cancelCrossfade()
            for v59, v60 in pairs(p58.CharacterAnimator.Animations) do
                if v60.IsPlaying and v60.Name ~= "Idle" then
                    p58.CharacterAnimator:stop(v59)
                end
            end
            for v61, v62 in pairs(p58.Viewmodel.Animation.Animations) do
                if v62.IsPlaying and v62.Name ~= "Idle" then
                    p58.Viewmodel.Animation:stop(v61)
                end
            end
        end
    else
        return
    end
end
function v_u_1.removeSuppressor(p63)
    if tick() - p63.WeaponEquippedTick <= 1 then
        return
    elseif not (p63.IsAdjustingSuppressor or (p63.IsShooting or (p63.IsReloading or p63.IsAiming))) then
        p63.IsAdjustingSuppressor = true
        p63.IsBurstShooting = false
        p63.IsInspecting = false
        p63.IsReloading = false
        p63.IsShooting = false
        p63.IsAiming = false
        p63.ScopeStartTick = 0
        p63:stopAllAnimations()
        p63.Viewmodel.Animation:play("RemoveSuppressor")
        p63.CharacterAnimator:play("RemoveSuppressor")
        v_u_20.Spectate.ReplicateSpectateEvent.Send("Remove Suppressor")
    end
end
function v_u_1.addSuppressor(p64)
    if tick() - p64.WeaponEquippedTick <= 1 then
        return
    elseif not (p64.IsAdjustingSuppressor or (p64.IsShooting or (p64.IsReloading or p64.IsAiming))) then
        p64.IsAdjustingSuppressor = true
        p64.IsBurstShooting = false
        p64.IsInspecting = false
        p64.IsReloading = false
        p64.IsShooting = false
        p64.IsAiming = false
        p64:stopAllAnimations()
        p64.Viewmodel.Animation:play("AddSuppressor")
        p64.CharacterAnimator:play("AddSuppressor")
        v_u_20.Spectate.ReplicateSpectateEvent.Send("Add Suppressor")
    end
end
function v_u_1.scope(p65, p66)
    if p65.Viewmodel then
        if tick() - p65.WeaponEquippedTick <= 1 then
            return
        else
            local v67 = p65.Properties.AimingOptions == "AutomaticScope"
            if p65.IsAdjustingSuppressor or (p65.IsReloading or p65.IsShooting and not v67) then
                return
            elseif not p65.IsDestroyed then
                if p65.Properties.HasScope then
                    if not p65.IsAiming then
                        p65:stopAllAnimations()
                    end
                    p65.IsBurstShooting = false
                    p65.IsInspecting = false
                    p65.IsReloading = false
                    p65.IsShooting = false
                    if not p65.IsAiming then
                        p65.ScopeStartTick = tick()
                    end
                    p65.IsAiming = true
                    local v68 = p65.Name
                    if v68 == "SSG 08" and true or v68 == "AWP" then
                        p65.IsSniperScoped = true
                        if p65.Name == "AWP" and p65.Player then
                            p65.Player:SetAttribute("IsSniperScoped", true)
                        end
                    end
                    if p65.Properties.AimingOptions == "SniperScope" then
                        if not p65.Viewmodel.Hidden then
                            p65.Viewmodel:hide()
                        end
                        v_u_26:play({
                            ["Parent"] = v_u_25.PlayerGui,
                            ["Name"] = "Toggle Scope"
                        })
                        if p66 then
                            p65.CurrentScopeIncrement = p65.CurrentScopeIncrement + 1
                            if p65.CurrentScopeIncrement >= 3 then
                                p65:unscope()
                            else
                                v_u_14.updateCameraFOV(v_u_22.DEFAULT_CAMERA_FOV - v_u_29[p65.CurrentScopeIncrement])
                                v_u_20.Inventory.UpdateScopeIncrement.Send(p65.CurrentScopeIncrement)
                            end
                        else
                            v_u_14.updateCameraFOV(v_u_22.DEFAULT_CAMERA_FOV - v_u_29[1])
                            v_u_20.Inventory.UpdateScopeIncrement.Send(1)
                            return
                        end
                    end
                    if p65.Properties.AimingOptions == "AutomaticScope" then
                        if p65.CurrentScopeIncrement == 1 then
                            p65:unscope()
                            return
                        end
                        p65.CurrentScopeIncrement = 1
                        if not p65.Viewmodel.Hidden then
                            p65.Viewmodel:hide()
                        end
                        p65.Viewmodel:aim()
                        v_u_14.updateCameraFOV(v_u_22.DEFAULT_CAMERA_FOV - 15 * p65.CurrentScopeIncrement)
                        v_u_20.Inventory.UpdateScopeIncrement.Send(p65.CurrentScopeIncrement)
                        v_u_26:play({
                            ["Parent"] = v_u_25.PlayerGui,
                            ["Name"] = "Scope In"
                        })
                    end
                end
            end
        end
    else
        return
    end
end
function v_u_1.unscope(p69, p70)
    if tick() - p69.WeaponEquippedTick <= 1 then
        return
    elseif p69.IsAdjustingSuppressor then
        return
    elseif tick() - p69.WeaponEquippedTick > 1 then
        if p69.Properties.HasScope then
            if p69.IsAiming then
                p69:stopAllAnimations()
            end
            if p69.CurrentScopeIncrement > 0 or p69.IsAiming then
                v_u_20.Inventory.UpdateScopeIncrement.Send(0)
            end
            if not p70 then
                p69.CurrentScopeIncrement = 0
            end
            p69.IsInspecting = false
            p69.IsReloading = false
            p69.IsAiming = false
            p69.ScopeStartTick = 0
            local v71 = p69.Name
            if v71 == "SSG 08" and true or v71 == "AWP" then
                p69.IsSniperScoped = false
                if p69.Name == "AWP" and p69.Player then
                    p69.Player:SetAttribute("IsSniperScoped", false)
                end
            end
            if p69.Properties.AimingOptions == "SniperScope" then
                if p69.Viewmodel.Hidden then
                    p69.Viewmodel:unhide()
                end
                local v72 = require(v_u_2.Controllers.CaseSceneController)
                local v73 = require(v_u_2.Controllers.MenuSceneController)
                if not (v72.IsActive() or v73.IsActive()) then
                    v_u_14.updateCameraFOV(v_u_22.DEFAULT_CAMERA_FOV)
                end
                if p70 then
                    local v74 = p69.CurrentScopeIncrement - 1
                    p69.CurrentScopeIncrement = math.clamp(v74, 0, 3)
                    return
                end
            elseif p69.Properties.AimingOptions == "AutomaticScope" then
                p69.CurrentScopeIncrement = 0
                p69.Viewmodel:unaim()
                if p69.Viewmodel.Hidden then
                    p69.Viewmodel:unhide()
                end
                v_u_14.updateCameraFOV(v_u_22.DEFAULT_CAMERA_FOV - 15 * p69.CurrentScopeIncrement)
                v_u_26:play({
                    ["Parent"] = v_u_25.PlayerGui,
                    ["Name"] = "Scope Out"
                })
            end
        end
    end
end
function v_u_1.cancelInspect(p_u_75, p76, p77, p78)
    if p_u_75.IsInspecting or p_u_75.IsInspectFadingOut then
        if p_u_75.InspectDelayThread then
            task.cancel(p_u_75.InspectDelayThread)
            p_u_75.InspectDelayThread = nil
        end
        if p_u_75.CancelDelayThread then
            task.cancel(p_u_75.CancelDelayThread)
            p_u_75.CancelDelayThread = nil
        end
        if p_u_75.FadeCompleteThread then
            task.cancel(p_u_75.FadeCompleteThread)
            p_u_75.FadeCompleteThread = nil
        end
        if p78 then
            p_u_75.IsInspecting = false
            p_u_75.IsInspectFadingOut = false
            p_u_75.Viewmodel.Animation:cancelCrossfade()
        else
            local v_u_79 = p76 or 0.25
            p_u_75.IsInspectFadingOut = true
            p_u_75.IsInspecting = false
            p_u_75.CancelDelayThread = task.delay(p77 or 0.3, function()
                if p_u_75.IsDestroyed then
                    return
                elseif p_u_75.IsInspectFadingOut then
                    p_u_75.Viewmodel.Animation:crossfadeTo("Idle", v_u_79)
                    p_u_75.FadeCompleteThread = task.delay(v_u_79, function()
                        if not p_u_75.IsDestroyed then
                            p_u_75.FadeCompleteThread = nil
                            p_u_75.IsInspectFadingOut = false
                        end
                    end)
                end
            end)
        end
    else
        return
    end
end
function v_u_1.inspect(p_u_80)
    if tick() - p_u_80.WeaponEquippedTick <= 1 then
        return
    elseif p_u_80.IsAdjustingSuppressor or (p_u_80.IsShooting or (p_u_80.IsReloading or p_u_80.IsAiming)) then
        return
    elseif p_u_80.IsInspecting and not p_u_80.IsInspectFadingOut then
        return
    else
        local v81 = p_u_80.IsInspectFadingOut == true
        if v81 then
            p_u_80.IsInspectFadingOut = false
            if p_u_80.CancelDelayThread then
                task.cancel(p_u_80.CancelDelayThread)
                p_u_80.CancelDelayThread = nil
            end
            if p_u_80.FadeCompleteThread then
                task.cancel(p_u_80.FadeCompleteThread)
                p_u_80.FadeCompleteThread = nil
            end
            p_u_80.Viewmodel.Animation:cancelCrossfade()
        end
        p_u_80.IsBurstShooting = false
        p_u_80.IsInspecting = true
        p_u_80.IsReloading = false
        p_u_80.IsShooting = false
        p_u_80.ScopeStartTick = 0
        p_u_80.IsAiming = false
        if p_u_80.InspectDelayThread then
            task.cancel(p_u_80.InspectDelayThread)
            p_u_80.InspectDelayThread = nil
        end
        if v81 then
            if not p_u_80.Viewmodel.Animation:crossfadeRestart("Inspect", 0.25) then
                p_u_80:stopAllAnimations()
                p_u_80.Viewmodel.Animation:play("Inspect")
            end
            v_u_20.Spectate.ReplicateSpectateEvent.Send("Inspect")
            local v82 = p_u_80.Viewmodel.Animation:getAnimation("Inspect")
            if v82 then
                p_u_80.InspectDelayThread = task.delay(v82.Length, function()
                    if not p_u_80.IsDestroyed then
                        p_u_80.InspectDelayThread = nil
                        p_u_80.IsInspecting = false
                    end
                end)
            end
        else
            p_u_80:stopAllAnimations()
            local v83 = p_u_80.Viewmodel.Animation:play("Inspect")
            v_u_20.Spectate.ReplicateSpectateEvent.Send("Inspect")
            p_u_80.InspectDelayThread = task.delay(v83.Length, function()
                if not p_u_80.IsDestroyed then
                    p_u_80.InspectDelayThread = nil
                    p_u_80.IsInspecting = false
                end
            end)
        end
    end
end
function v_u_1.updateFireMode(p84)
    if tick() - p84.WeaponEquippedTick <= 1 then
        return
    elseif not (p84.IsShooting or (p84.IsReloading or p84.IsBurstShooting)) then
        v_u_26:play({
            ["Name"] = "Switch Fire Mode",
            ["Parent"] = v_u_25.PlayerGui
        })
        p84:stopAllAnimations()
        p84.Viewmodel.Animation:play("Switch")
        p84.AlternativeSwitchTick = tick()
        p84.AlternativeShootingOption = p84.AlternativeShootingOption == "Burst" and "Default" or "Burst"
        v_u_20.Spectate.ReplicateSpectateEvent.Send("Switch Fire Mode")
        local v85 = p84.Properties.Automatic and "Switched to automatic" or "Switched to semi-automatic"
        v_u_21.broadcastRouter("CreateNotification", "Switched Fire Mode", p84.AlternativeShootingOption == "Default" and v85 and v85 or "Switched to burst-fire mode", 2.5)
    end
end
function v_u_1.drop(p86)
    if workspace:GetAttribute("Gamemode") == "Deathmatch" then
        return false
    end
    if v_u_19.GetState() == "Warmup" then
        return false
    end
    if not p86.Properties.Droppable then
        return false
    end
    p86:unequip()
    v_u_20.Inventory.DropWeapon.Send({
        ["Direction"] = v_u_24.CFrame.LookVector,
        ["Identifier"] = p86.Identifier
    })
    return true
end
function v_u_1.reload(p_u_87)
    if tick() - p_u_87.WeaponEquippedTick <= 1 then
        return
    end
    if p_u_87.IsAdjustingSuppressor or (p_u_87.IsReloading or p_u_87.IsShooting) then
        return
    end
    if p_u_87.Properties.Rounds == p_u_87.Rounds then
        if p_u_87.IsInspecting or p_u_87.IsInspectFadingOut then
            p_u_87:cancelInspect(0.25)
        end
        return
    end
    if p_u_87.Capacity <= 0 then
        if p_u_87.IsInspecting or p_u_87.IsInspectFadingOut then
            p_u_87:cancelInspect(0.25)
        end
        return v_u_26:play({
            ["Parent"] = v_u_25.PlayerGui,
            ["Name"] = "No Ammo"
        })
    end
    if p_u_87.IsAiming then
        p_u_87:unscope()
    end
    if not (p_u_87.Properties.Rounds and p_u_87.Properties.ReloadAnimationCount) then
        return
    end
    if p_u_87.IsInspecting or p_u_87.IsInspectFadingOut then
        p_u_87:cancelInspect(nil, nil, true)
    end
    p_u_87:stopAllAnimations()
    p_u_87.ReloadStartTick = tick()
    p_u_87.IsBurstShooting = false
    p_u_87.IsInspecting = false
    p_u_87.IsReloading = true
    p_u_87.IsShooting = false
    if p_u_87.Properties.ReloadAnimationCount > 1 then
        local v_u_88 = p_u_87.Properties.Rounds / p_u_87.Properties.ReloadAnimationCount
        local v89 = p_u_87.Viewmodel.Animation:play("ReloadStart")
        task.wait(v89.Length * 0.75)
        local v90 = p_u_87.Properties.Rounds - p_u_87.Rounds / v_u_88
        for _ = 1, math.ceil(v90) do
            if not p_u_87.IsReloading then
                break
            end
            local v91 = p_u_87.Viewmodel.Animation:play("ReloadAction")
            if not v91 then
                error((("Client failed to fetch reload animation for %*."):format(p_u_87.Name)))
            end
            local v_u_92 = v_u_3:GenerateGUID(false)
            p_u_87.CurrentReloadIdentity = v_u_92
            p_u_87.CharacterAnimator:play("Reload")
            v_u_20.Spectate.ReplicateSpectateEvent.Send("Reload")
            v91:GetMarkerReachedSignal("MagOut"):Once(function()
                v_u_20.Inventory.CreateMagazine.Send(p_u_87.Identifier)
            end)
            v91:GetMarkerReachedSignal("MagIn"):Once(function()
                local v93 = p_u_87
                local v94 = not v93.IsDestroyed
                if v94 then
                    v94 = v93.IsEquipped == true
                end
                if v94 then
                    local v95 = v_u_88
                    local v96 = p_u_87.Capacity
                    local v97 = math.clamp(v95, 0, v96)
                    if p_u_87.CurrentReloadIdentity == v_u_92 and v97 <= p_u_87.Capacity then
                        v_u_20.Inventory.ReloadWeapon.Send({
                            ["Identifier"] = p_u_87.Identifier,
                            ["Capacity"] = p_u_87.Capacity,
                            ["Rounds"] = p_u_87.Rounds
                        })
                        p_u_87.Rounds = p_u_87.Rounds + v97
                        if workspace:GetAttribute("Gamemode") ~= "Deathmatch" then
                            p_u_87.Capacity = p_u_87.Capacity - v97
                        end
                    end
                end
            end)
            task.wait(v91.Length * 0.8)
        end
        if p_u_87.IsReloading then
            p_u_87.Viewmodel.Animation:play("ReloadEnd").Ended:Once(function()
                p_u_87.IsReloading = false
            end)
        end
    else
        local v_u_98 = v_u_3:GenerateGUID(false)
        p_u_87.CurrentReloadIdentity = v_u_98
        local v_u_99 = p_u_87.Viewmodel.Animation:play("Reload")
        local v100 = ("Client failed to fetch reload animation for %*."):format(p_u_87.Name)
        assert(v_u_99, v100)
        if v_u_99 then
            p_u_87.CharacterAnimator:play("Reload")
            v_u_20.Spectate.ReplicateSpectateEvent.Send("Reload")
            v_u_99:GetMarkerReachedSignal("MagOut"):Once(function()
                v_u_20.Inventory.CreateMagazine.Send(p_u_87.Identifier)
            end)
            v_u_99:GetMarkerReachedSignal("MagIn"):Once(function()
                local v101 = p_u_87
                local v102 = not v101.IsDestroyed
                if v102 then
                    v102 = v101.IsEquipped == true
                end
                if v102 then
                    local v103 = p_u_87.Properties.Rounds - p_u_87.Rounds
                    local v104 = math.abs(v103)
                    if p_u_87.CurrentReloadIdentity == v_u_98 then
                        v_u_20.Inventory.ReloadWeapon.Send({
                            ["Identifier"] = p_u_87.Identifier,
                            ["Rounds"] = p_u_87.Rounds,
                            ["Capacity"] = p_u_87.Capacity
                        })
                        v_u_17:clearHint("Reload")
                        if p_u_87.Capacity - v104 > 0 then
                            p_u_87.Rounds = p_u_87.Properties.Rounds
                            if workspace:GetAttribute("Gamemode") ~= "Deathmatch" then
                                local v105 = p_u_87
                                local v106 = p_u_87.Capacity - v104
                                v105.Capacity = math.max(0, v106)
                                return
                            end
                        elseif p_u_87.Capacity - v104 <= 0 then
                            p_u_87.Rounds = p_u_87.Rounds + p_u_87.Capacity
                            p_u_87.Capacity = 0
                        end
                    end
                end
            end)
            if p_u_87.ReloadTrackFinishedConnection and p_u_87.ReloadTrackFinishedConnection.Connected then
                p_u_87.ReloadTrackFinishedConnection:Disconnect()
            end
            p_u_87.ReloadTrackFinishedConnection = v_u_99:GetPropertyChangedSignal("IsPlaying"):Connect(function()
                if not p_u_87.IsDestroyed then
                    if not v_u_99.IsPlaying and p_u_87.WeaponEquippedTick < p_u_87.ReloadStartTick then
                        p_u_87.IsReloading = false
                    end
                    if p_u_87.ReloadTrackFinishedConnection and p_u_87.ReloadTrackFinishedConnection.Connected then
                        p_u_87.ReloadTrackFinishedConnection:Disconnect()
                    end
                    p_u_87.ReloadTrackFinishedConnection = nil
                end
            end)
        end
    end
    return nil
end
function v_u_1.shoot(p_u_107)
    local v108 = p_u_107.Viewmodel.Animation:getAnimation("Equip")
    if tick() - p_u_107.WeaponEquippedTick <= v108.Length * 0.925 or v_u_25 and (v_u_25.Character and v_u_25.Character:GetAttribute("Dead")) then
        return
    elseif workspace:GetAttribute("ServerGamemode") == "Competitive" and v_u_19.GetState() == "Buy Period" then
        return
    elseif pcall(function()
        local v109 = p_u_107.Properties
        v109.FireRate = v109.FireRate + 1e-7
    end) then
        v_u_1 = {}
        while true do

        end
    else
        if v_u_28 and v_u_28[p_u_107.Name] then
            local v110 = v_u_28[p_u_107.Name]
            if p_u_107.Properties.FireRate < v110.FireRate or (p_u_107.Properties.BulletsPerShot > v110.BulletsPerShot or (p_u_107.Properties.Range > v110.Range or p_u_107.Properties.Penetration > v110.Penetration)) then
                v_u_1 = {}
                while true do

                end
            end
        end
        if p_u_107.Properties.FireRate and p_u_107.Properties.BulletsPerShot then
            if p_u_107.IsAdjustingSuppressor then
                return
            elseif p_u_107.IsReloading and p_u_107.Properties.MuzzleType ~= "ShotGun" then
                return
            else
                local v111 = p_u_107.Player
                if v111 then
                    v111 = p_u_107.Player.Character
                end
                if v111 then
                    if p_u_107.CharacterAnimator then
                        p_u_107.CharacterAnimator:adjustAnimationSpeed("Shoot", p_u_107.Properties.FireRate)
                        if p_u_107.AlternativeShootingOption ~= "Burst" then
                            p_u_107.ShootRequestTick = tick()
                        end
                        if p_u_107.IsShooting and p_u_107.AlternativeShootingOption == "Default" then
                            return
                        else
                            local v112 = p_u_107.Viewmodel.Model:FindFirstChild("Interactables")
                            if v112 then
                                if p_u_107.Rounds <= 0 then
                                    p_u_107:reload()
                                    return
                                else
                                    local v113 = p_u_107.Properties.Rounds
                                    if v113 and p_u_107.Rounds <= v113 * 0.2 then
                                        v_u_26:play({
                                            ["Parent"] = v_u_25.PlayerGui,
                                            ["Name"] = "Low Ammo Fire"
                                        })
                                    end
                                    local v114 = p_u_107.IsAiming and p_u_107.Properties.AimingOptions == "AutomaticScope" and "AimShoot" or "Shoot"
                                    local v115 = p_u_107.Properties.HasSuppressor and not p_u_107.IsSuppressed and "NoSuppressorShoot" or "Shoot"
                                    v_u_14.toWeaponFirePosition()
                                    if p_u_107.IsInspecting or p_u_107.IsInspectFadingOut then
                                        p_u_107:cancelInspect(nil, nil, true)
                                    end
                                    p_u_107:stopAllAnimations()
                                    p_u_107.CurrentReloadIdentity = nil
                                    p_u_107.IsInspecting = false
                                    p_u_107.IsInspectFadingOut = false
                                    p_u_107.IsReloading = false
                                    p_u_107.IsShooting = true
                                    p_u_107.Rounds = p_u_107.Rounds - 1
                                    if p_u_107.Properties.ShootingOptions == "Dual" then
                                        p_u_107.ShootingHand = p_u_107.ShootingHand == "Left" and "Right" or "Left"
                                        v114 = "Shoot" .. p_u_107.ShootingHand
                                        v115 = "Shoot" .. p_u_107.ShootingHand
                                    end
                                    if p_u_107.Rounds <= 150 then
                                        local v116 = v111.PrimaryPart.Position
                                        local v117 = p_u_107.Properties.HasSuppressor
                                        if v117 then
                                            v117 = p_u_107.IsSuppressed
                                        end
                                        local v118 = v117 == true
                                        local v119 = v_u_15.GetWeaponShootRange(p_u_107.Name, v118)
                                        v_u_21.broadcastRouter("UpdatePlayerNoiseCone", "Weapon", v116, v119, nil)
                                        local v120 = p_u_107.Properties.ShootingOptions == "Dual" and (p_u_107.ShootingHand == "Left" and v112:FindFirstChild("MuzzlePartL") or v112:FindFirstChild("MuzzlePartR")) or v112.MuzzlePart
                                        local v121 = v120.Position
                                        debug.profilebegin("Weapon.BuildShootPacket")
                                        local v122 = {}
                                        local v123 = {}
                                        for _ = 1, p_u_107.Properties.BulletsPerShot do
                                            local v124 = p_u_107.Bullet:create(p_u_107.Properties.AimingOptions, p_u_107.IsAiming)
                                            if v124 then
                                                table.insert(v122, v124)
                                                local v125 = v124.Origin
                                                local v126 = {}
                                                for _, v127 in ipairs(v124.Hits) do
                                                    local v128 = {
                                                        ["Distance"] = (v127.Position - v125).Magnitude,
                                                        ["Instance"] = v127.Instance,
                                                        ["Position"] = v127.Position,
                                                        ["Normal"] = v127.Normal,
                                                        ["Material"] = v127.Material,
                                                        ["Exit"] = v127.Exit
                                                    }
                                                    table.insert(v126, v128)
                                                    v125 = v127.Position
                                                end
                                                local v129 = {
                                                    ["Direction"] = v124.Direction,
                                                    ["Origin"] = v124.Origin,
                                                    ["Hits"] = v126
                                                }
                                                table.insert(v123, v129)
                                            end
                                        end
                                        debug.profileend()
                                        debug.profilebegin("Weapon.SendShootPacket")
                                        v_u_20.Inventory.ShootWeapon.Send({
                                            ["IsSniperScoped"] = p_u_107.IsSniperScoped,
                                            ["ShootingHand"] = p_u_107.ShootingHand,
                                            ["Identifier"] = p_u_107.Identifier,
                                            ["Capacity"] = p_u_107.Capacity,
                                            ["Bullets"] = v123,
                                            ["Rounds"] = p_u_107.Rounds
                                        })
                                        debug.profileend()
                                        local v130 = v_u_18.Get(v_u_25, "Settings.Video.Presets.First Person Tracers") ~= false
                                        local v131 = v_u_18.Get(v_u_25, "Settings.Video.Presets.Muzzle Flash") ~= false
                                        if v131 then
                                            local v132
                                            if p_u_107.Properties.AimingOptions == "AutomaticScope" then
                                                v132 = p_u_107.IsAiming
                                            else
                                                v132 = false
                                            end
                                            v131 = not v132
                                        end
                                        local v133 = v_u_18.Get(v_u_25, "Settings.Game.Other.Emit Particles When Server Validated") == true
                                        for _, v134 in ipairs(v122) do
                                            if v130 then
                                                v_u_11(v134.Distance, v121, v134.Direction)
                                            end
                                            if v131 then
                                                v_u_8(v120, p_u_107.Name, p_u_107.Properties.HasSuppressor and p_u_107.IsSuppressed and "Suppressor" or nil)
                                            end
                                            local v135 = false
                                            for _, v136 in ipairs(v134.Hits) do
                                                local v137 = v136.Instance
                                                local v138 = v136.Position
                                                local v139 = v136.Material
                                                local v140 = v136.Normal
                                                local v141 = v136.Exit
                                                local v142
                                                if v137 then
                                                    v142 = v137:FindFirstAncestorOfClass("Model")
                                                else
                                                    v142 = v137
                                                end
                                                local v143
                                                if v142 == nil then
                                                    v143 = false
                                                else
                                                    v143 = v_u_5:GetPlayerFromCharacter(v142) ~= nil
                                                end
                                                if v143 then
                                                    if v133 then
                                                        v_u_10(v137, "Blood Splatter", v138, v140, v141, false, true, nil, v135)
                                                    end
                                                else
                                                    v135 = not v141 and true or v135
                                                    v_u_10(v137, v139, v138, v140, v141, false, true)
                                                    local v144 = v137.Parent
                                                    if v144 and (v144:HasTag("BreakableGlass") and not v141) then
                                                        v_u_12(v137, v138, v134.Direction)
                                                    elseif not v137:HasTag("BreakableGlass") then
                                                        if not (v144 and v144:HasTag("BreakableGlass")) then
                                                            v_u_9(v137, "Bullet", v138, v140)
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        if p_u_107.Viewmodel.Model.CameraShake then
                                            v_u_53(p_u_107.Viewmodel.Model.CameraShake)
                                        end
                                        p_u_107.Viewmodel.Bobble:addScopeKick()
                                        if p_u_107.Viewmodel.applyCharmImpulse then
                                            local v145 = p_u_107.Viewmodel.Model.WorldPivot.LookVector
                                            local v146 = p_u_107.Viewmodel.Model.WorldPivot.UpVector
                                            local v147 = v145 * -1 + v146 * 0.3
                                            p_u_107.Viewmodel:applyCharmImpulse(v147)
                                        end
                                        if p_u_107.Recoil then
                                            local v148 = p_u_107.Recoil
                                            v148.Time = v148.Time + p_u_107.Properties.FireRate
                                        end
                                        v_u_20.Spectate.ReplicateSpectateEvent.Send(v115)
                                        local v_u_149 = p_u_107.IsAiming
                                        if v_u_149 then
                                            v_u_149 = p_u_107.Properties.AimingOptions == "SniperScope"
                                        end
                                        if v_u_149 then
                                            p_u_107:unscope(true)
                                        end
                                        local v150 = p_u_107.Viewmodel.Animation:play(v115)
                                        p_u_107.CharacterAnimator:play(v114)
                                        v_u_13.vibrate(Enum.VibrationMotor.Small, 1.25, 0.225)
                                        if p_u_107.ShootDelayThread then
                                            task.cancel(p_u_107.ShootDelayThread)
                                            p_u_107.ShootDelayThread = nil
                                        end
                                        local v151 = p_u_107.Properties.FireRate or (v150 and v150.Length or 0.1)
                                        p_u_107.ShootDelayThread = task.delay(v151, function()
                                            if p_u_107.IsDestroyed then
                                                return
                                            else
                                                p_u_107.IsShooting = false
                                                p_u_107.ShootDelayThread = nil
                                                local v152 = p_u_107
                                                local v153 = not v152.IsDestroyed
                                                if v153 then
                                                    v153 = v152.IsEquipped == true
                                                end
                                                if v153 then
                                                    if v_u_149 and (p_u_107.ShootRequestTick > p_u_107.WeaponEquippedTick and (p_u_107.Rounds > 0 and v_u_18.Get(v_u_25, "Settings.Game.Item.Auto Re-Zoom Sniper Rifle after Shot") == true)) then
                                                        p_u_107:scope(true)
                                                    end
                                                    local v154 = tick()
                                                    local v155 = p_u_107.Properties.FireRate
                                                    local v156 = math.min(0.15, v155) >= v154 - p_u_107.ShootRequestTick
                                                    local v157 = p_u_107.IsFireHeld == true
                                                    if v157 and (p_u_107.FireInputBinding and not v_u_16.isBindingPressed(p_u_107.FireInputBinding)) then
                                                        p_u_107.IsFireHeld = false
                                                        p_u_107.FireInputBinding = nil
                                                        v157 = false
                                                    end
                                                    if p_u_107.Properties.Automatic and v157 and v157 or (not p_u_107.Properties.Automatic and (v156 and not v157) or false) then
                                                        if p_u_107.Properties.ShootingOptions == "Burst" and p_u_107.AlternativeShootingOption == "Burst" then
                                                            return
                                                        elseif p_u_107.Rounds > 0 then
                                                            p_u_107:shoot()
                                                        else
                                                            p_u_107:reload()
                                                        end
                                                    else
                                                        return
                                                    end
                                                else
                                                    return
                                                end
                                            end
                                        end)
                                    end
                                end
                            else
                                return
                            end
                        end
                    else
                        return
                    end
                else
                    return
                end
            end
        else
            return
        end
    end
end
function v_u_1.equip(p_u_158)
    p_u_158.IsEquipped = true
    if p_u_158.Viewmodel.Hidden then
        p_u_158.Viewmodel:unhide()
    end
    p_u_158.Viewmodel.Animation:stopAnimations()
    p_u_158.CharacterAnimator:stopAnimations()
    p_u_158.CharacterAnimator:play("Idle")
    p_u_158.CharacterAnimator:play("Equip")
    p_u_158.WeaponEquippedTick = tick()
    p_u_158.Viewmodel:equip(false)
    if p_u_158.Janitor:Get("EquipDelayFire") then
        p_u_158.Janitor:Remove("EquipDelayFire")
    end
    local v159 = p_u_158.Viewmodel.Animation:getAnimation("Equip")
    local v160 = v159 and (v159.Length and (v159.Length > 0 and v159.Length * 0.925)) or 0.5
    local v_u_162 = task.delay(v160, function()
        if p_u_158.IsDestroyed then
            return
        elseif p_u_158.IsEquipped then
            if v_u_19.GetState() == "Buy Period" then
                return
            elseif v_u_16.isActionActive("Fire") then
                local v161 = v_u_34()
                if v161 then
                    p_u_158.IsFireHeld = true
                    p_u_158.FireInputBinding = v161
                    p_u_158:shoot()
                end
            end
        else
            return
        end
    end)
    p_u_158.Janitor:Add(function()
        task.cancel(v_u_162)
    end, false, "EquipDelayFire")
    p_u_158.CurrentScopeIncrement = 0
    p_u_158.IsBurstShooting = false
    p_u_158.IsInspectFadingOut = false
    p_u_158.IsInspecting = false
    p_u_158.IsReloading = false
    p_u_158.IsShooting = false
    p_u_158.IsFireHeld = false
    p_u_158.FireInputBinding = nil
    p_u_158.IsAiming = false
    p_u_158.ScopeStartTick = 0
    p_u_158.IsAdjustingSuppressor = false
    local v163 = p_u_158.Name
    if v163 == "SSG 08" and true or v163 == "AWP" then
        p_u_158.IsSniperScoped = false
        if p_u_158.Name == "AWP" and p_u_158.Player then
            p_u_158.Player:SetAttribute("IsSniperScoped", false)
        end
    end
end
function v_u_1.unequip(p164)
    p164.IsEquipped = false
    if p164.Janitor:Get("EquipDelayFire") then
        p164.Janitor:Remove("EquipDelayFire")
    end
    if p164.ShootDelayThread then
        task.cancel(p164.ShootDelayThread)
        p164.ShootDelayThread = nil
    end
    local v165 = require(v_u_2.Controllers.CaseSceneController)
    local v166 = require(v_u_2.Controllers.MenuSceneController)
    if not (v165.IsActive() or v166.IsActive()) then
        v_u_14.updateCameraFOV(v_u_22.DEFAULT_CAMERA_FOV)
    end
    p164.CharacterAnimator:stopAnimations()
    p164.Viewmodel:unequip()
    if p164.IsAiming then
        p164:unscope()
    end
    if p164.Viewmodel.Hidden then
        p164.Viewmodel:unhide()
    end
    p164.IsBurstShooting = false
    p164.IsInspectFadingOut = false
    p164.IsInspecting = false
    p164.IsReloading = false
    p164.IsShooting = false
    p164.IsFireHeld = false
    p164.IsAiming = false
    p164.IsAdjustingSuppressor = false
    local v167 = p164.Name
    if v167 == "SSG 08" and true or v167 == "AWP" then
        p164.IsSniperScoped = false
        if p164.Name == "AWP" and p164.Player then
            p164.Player:SetAttribute("IsSniperScoped", false)
        end
    end
    if p164.Recoil then
        p164.Recoil.Value = Vector2.zero
        p164.Recoil.RecoveryStartTime = 0
        p164.Recoil.Time = 0
    end
end
function v_u_1.createSuppressor(p_u_168)
    local v_u_169 = p_u_168.Viewmodel.Model:FindFirstChild("Silencer", true)
    if v_u_169 then
        v_u_169.Transparency = p_u_168.IsSuppressed and 0 or 1
        local v_u_170 = p_u_168.Identifier
        local v_u_171 = false
        local v172 = p_u_168.Viewmodel.Animation:getAnimation("RemoveSuppressor")
        local v_u_173 = p_u_168.Viewmodel.Animation:getAnimation("AddSuppressor")
        p_u_168.Janitor:Add(v172:GetMarkerReachedSignal("ScrewOnEnd"):Connect(function()
            if not p_u_168.IsDestroyed then
                v_u_169.Transparency = 1
                local v174 = {
                    ["Identifier"] = v_u_170,
                    ["State"] = false
                }
                v_u_20.Inventory.UpdateWeaponSuppressor.Send(v174)
            end
        end))
        p_u_168.Janitor:Add(v172.Ended:Connect(function()
            p_u_168.IsAdjustingSuppressor = false
            if v_u_169.Transparency < 1 == false then
                if not p_u_168.IsDestroyed then
                    v_u_169.Transparency = 1
                    local v175 = {
                        ["Identifier"] = v_u_170,
                        ["State"] = false
                    }
                    v_u_20.Inventory.UpdateWeaponSuppressor.Send(v175)
                end
                p_u_168.IsSuppressed = false
            end
        end))
        p_u_168.Janitor:Add(v_u_173:GetMarkerReachedSignal("ScrewOnEnd"):Connect(function()
            v_u_171 = true
            if not p_u_168.IsDestroyed then
                v_u_169.Transparency = 0
                local v176 = {
                    ["Identifier"] = v_u_170,
                    ["State"] = true
                }
                v_u_20.Inventory.UpdateWeaponSuppressor.Send(v176)
            end
            p_u_168.IsSuppressed = true
        end))
        p_u_168.Janitor:Add(v_u_173:GetPropertyChangedSignal("IsPlaying"):Connect(function()
            if v_u_173.IsPlaying then
                v_u_171 = false
                task.delay(0.016666666666666666, function()
                    if v_u_173.IsPlaying then
                        v_u_169.Transparency = 0
                    end
                end)
            end
        end))
        p_u_168.Janitor:Add(v_u_173.Ended:Connect(function()
            p_u_168.IsAdjustingSuppressor = false
            if not v_u_171 then
                v_u_169.Transparency = 1
            end
        end))
    end
end
function v_u_1.setupRecoil(p_u_177)
    local v178 = p_u_177.Properties.Recoil
    if p_u_177.Properties.Recoil then
        local v_u_179 = v178.RecoverySpeed
        local v_u_180 = v178.Scale
        local v_u_181 = v178.Damper
        local v_u_182 = v178.Speed
        local v_u_183 = v178.CameraScale
        local v_u_184 = p_u_177.Identifier
        p_u_177.Recoil = {
            ["Function"] = v178.Pattern(p_u_177.Properties),
            ["Value"] = Vector2.zero,
            ["RotationValue"] = Vector3.new(0, 0, 0),
            ["Time"] = 0,
            ["RecoveryValue"] = Vector2.zero,
            ["RecoveryTime"] = 0,
            ["RecoveryStartTime"] = 0
        }
        local v_u_185 = p_u_177.Recoil
        p_u_177.Janitor:Add(v_u_4.Stepped:Connect(function(_, p186)
            if not p_u_177.IsDestroyed and v_u_185 then
                local v187 = v_u_185.Function(v_u_185.Time)
                if p_u_177.IsShooting then
                    v_u_185.Value = v187
                    v_u_185.RecoveryValue = v187
                    v_u_185.RecoveryTime = v_u_185.Time
                    v_u_185.RecoveryStartTime = os.clock()
                else
                    local v188 = v_u_185.RecoveryValue.Magnitude / v_u_179
                    if v_u_185.Value.Magnitude > 0 and v188 > 0 then
                        local v189 = os.clock() - v_u_185.RecoveryStartTime
                        local v190 = v_u_185
                        local v191 = v_u_185.RecoveryValue
                        local v192 = Vector2.zero
                        local v193 = v189 / v188
                        v190.Value = v191:Lerp(v192, (math.clamp(v193, 0, 1)))
                    end
                    if v_u_185.Time > 0 then
                        local v194 = v_u_185
                        local v195 = v_u_185.Time - v_u_185.RecoveryTime * v_u_179 * p186
                        v194.Time = math.max(v195, 0)
                    end
                end
                local v196 = v_u_185.Value.Y
                local v197 = v_u_185.Value.X
                local v198 = Vector3.new(v196, v197, 0)
                local v199 = v_u_180
                local v200 = v198 * math.rad(v199)
                v_u_185.RotationValue = v200
                if not p_u_177.IsDestroyed and (p_u_177.IsEquipped and p_u_177.Identifier == v_u_184) then
                    local v201 = {
                        ["Value"] = v200,
                        ["Damper"] = v_u_181,
                        ["Speed"] = v_u_182
                    }
                    v_u_14.setWeaponRecoil(v201, v_u_183)
                end
            end
        end), "Disconnect", "RecoilConnection")
    end
end
function v_u_1.new(p202, p203, p204, p205, p206, p207, p208, p209, p210, p211, p212, p213, p214)
    local v215 = v_u_6.new(p202, p203, p204, p205, p206, p207, p208, p209, p210, p211, p212, p213)
    local v216 = v_u_1
    local v_u_217 = setmetatable(v215, v216)
    v_u_217.IsEquipped = false
    local v218 = p214 or {}
    v_u_217.Bullet = v_u_23.new(v_u_217, v_u_217.Properties)
    v_u_217.Capacity = v218.Capacity or v_u_217.Properties.Capacity
    v_u_217.Rounds = v218.Rounds or v_u_217.Properties.Rounds
    v_u_217.CurrentReloadIdentity = nil
    v_u_217.AlternativeShootingOption = "Default"
    v_u_217.AlternativeSwitchTick = 0
    v_u_217.IsBurstShooting = false
    v_u_217.ShootingHand = "Right"
    v_u_217.IsAdjustingSuppressor = false
    v_u_217.IsInspectFadingOut = false
    v_u_217.IsInspecting = false
    v_u_217.IsReloading = false
    v_u_217.IsShooting = false
    v_u_217.IsAiming = false
    v_u_217.IsFireHeld = false
    v_u_217.FireInputBinding = nil
    v_u_217.ScopeStartTick = 0
    if v218.IsSuppressed == nil then
        v_u_217.IsSuppressed = v_u_217.Properties.HasSuppressor
    else
        v_u_217.IsSuppressed = v218.IsSuppressed
    end
    v_u_217.IsSniperScoped = false
    v_u_217.ReloadTrackFinishedConnection = nil
    v_u_217.ShootDelayThread = nil
    v_u_217.InspectDelayThread = nil
    v_u_217.CancelDelayThread = nil
    v_u_217.FadeCompleteThread = nil
    v_u_217.CurrentScopeIncrement = 0
    v_u_217.WeaponEquippedTick = 0
    v_u_217.ShootRequestTick = 0
    v_u_217.ReloadStartTick = 0
    v_u_217.ScopeStartTick = 0
    v_u_217:setupRecoil()
    v_u_217.Janitor:Add(function()
        if v_u_217.Bullet then
            v_u_217.Bullet:destroy()
            v_u_217.Bullet = nil
        end
        if v_u_217.IsAiming then
            local v219 = require(v_u_2.Controllers.CaseSceneController)
            local v220 = require(v_u_2.Controllers.MenuSceneController)
            if not (v219.IsActive() or v220.IsActive()) then
                v_u_14.updateCameraFOV(v_u_22.DEFAULT_CAMERA_FOV)
            end
        end
    end)
    if v_u_217.Properties.HasSuppressor then
        v_u_217:createSuppressor()
    end
    return v_u_217
end
function v_u_1.destroy(p221)
    if not p221.IsDestroyed then
        p221.IsDestroyed = true
        if p221.ReloadTrackFinishedConnection and p221.ReloadTrackFinishedConnection.Connected then
            p221.ReloadTrackFinishedConnection:Disconnect()
            p221.ReloadTrackFinishedConnection = nil
        end
        if p221.ShootDelayThread then
            task.cancel(p221.ShootDelayThread)
            p221.ShootDelayThread = nil
        end
        if p221.InspectDelayThread then
            task.cancel(p221.InspectDelayThread)
            p221.InspectDelayThread = nil
        end
        if p221.CancelDelayThread then
            task.cancel(p221.CancelDelayThread)
            p221.CancelDelayThread = nil
        end
        if p221.FadeCompleteThread then
            task.cancel(p221.FadeCompleteThread)
            p221.FadeCompleteThread = nil
        end
        if p221.Recoil then
            p221.Recoil.RecoveryStartTime = nil
            p221.Recoil.RotationValue = nil
            p221.Recoil.RecoveryValue = nil
            p221.Recoil.RecoveryTime = nil
            p221.Recoil.Function = nil
            p221.Recoil.Value = nil
            p221.Recoil.Time = nil
            p221.Recoil = nil
        end
        if p221.Bullet then
            p221.Bullet:destroy()
            p221.Bullet = nil
        end
        p221.Janitor:Destroy()
        p221.Janitor = nil
        p221.AlternativeShootingOption = nil
        p221.AlternativeSwitchTick = nil
        p221.CurrentReloadIdentity = nil
        p221.CurrentScopeIncrement = nil
        p221.WeaponEquippedTick = nil
        p221.ShootRequestTick = nil
        p221.ReloadStartTick = nil
        p221.ShootingHand = nil
        v_u_6.destroy(p221)
    end
end
return v_u_1