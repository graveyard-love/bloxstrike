local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v4 = game:GetService("Players")
require(v2.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_5 = require(v2.Controllers.HapticsController)
local v_u_6 = require(v2.Controllers.SoundController)
local v_u_7 = require(v2.Controllers.InputController)
local v_u_8 = require(v2.Components.Common.GetRayIgnore)
local v_u_9 = require(v2.Database.Components.GameState)
local v_u_10 = require(v2.Components.Common.VFXLibary.CreateMarker)
local v_u_11 = require(v2.Components.Common.VFXLibary.CreateImpact)
local v_u_12 = require(v2.Components.Common.VFXLibary.BreakGlass)
local v_u_13 = require(v2.Classes.WeaponComponent)
local v_u_14 = require(v2.Database.Security.Remotes)
local v_u_15 = require(v2.Database.Security.Router)
local v_u_16 = v4.LocalPlayer
local v_u_17 = workspace.CurrentCamera
local function v_u_24(p18, p19)
    local v20 = p18:WaitForChild("HumanoidRootPart")
    local v21 = p19:WaitForChild("HumanoidRootPart")
    if not (v20 and v21) then
        return nil
    end
    local v22 = v21.CFrame.LookVector:Dot((v20.Position - v21.Position).Unit)
    local v23 = math.acos(v22)
    return math.deg(v23) > 100
end
function v_u_1.stopAllAnimations(p25)
    if p25.CharacterAnimator then
        if p25.Viewmodel and p25.Viewmodel.Animation then
            p25.Viewmodel.Animation:cancelCrossfade()
            for v26, v27 in pairs(p25.CharacterAnimator.Animations) do
                if v27.IsPlaying and v27.Name ~= "Idle" then
                    p25.CharacterAnimator:stop(v26)
                end
            end
            for v28, v29 in pairs(p25.Viewmodel.Animation.Animations) do
                if v29.IsPlaying and v29.Name ~= "Idle" then
                    p25.Viewmodel.Animation:stop(v28)
                end
            end
        end
    else
        return
    end
end
function v_u_1.reload(p30)
    if p30.IsInspecting or p30.IsInspectFadingOut then
        p30:cancelInspect(0.25)
    end
end
function v_u_1.shoot(p_u_31, p32)
    if tick() - p_u_31.WeaponEquippedTick <= 1 or v_u_16:GetAttribute("Dead") then
        return
    elseif p_u_31.Properties.FireRate then
        if p_u_31.IsShooting then
            return
        else
            local v33 = p_u_31.Player
            if v33 then
                v33 = p_u_31.Player.Character
            end
            if v33 then
                if p_u_31.IsInspecting or p_u_31.IsInspectFadingOut then
                    p_u_31:cancelInspect(0.25)
                end
                p_u_31:stopAllAnimations()
                p_u_31.IsInspecting = false
                p_u_31.IsInspectFadingOut = false
                p_u_31.IsShooting = true
                v_u_15.broadcastRouter("UpdatePlayerNoiseCone", "Melee", v33.PrimaryPart.Position, v_u_6.GetMeleeRange(p_u_31.Name), nil)
                local v34 = RaycastParams.new()
                v34.FilterType = Enum.RaycastFilterType.Exclude
                v34.FilterDescendantsInstances = v_u_8()
                v34.IgnoreWater = true
                local v35 = v_u_17.CFrame.LookVector * p_u_31.Properties.Range
                local v36 = v_u_17.CFrame.Position
                local v37 = workspace:Raycast(v36, v35, v34) or workspace:Spherecast(v36, 1.5, v35, v34)
                local v38 = p32 and "Heavy Swing" or ("Swing%*"):format((math.random(1, 2)))
                v_u_14.Spectate.ReplicateSpectateEvent.Send(v38)
                if v37 then
                    local v39 = v37.Instance
                    local v40 = v37.Position
                    local v41 = v37.Material
                    local v42 = v37.Normal
                    local v43 = v39 and v39.Parent
                    if v43 then
                        v43 = v39.Parent:FindFirstChildOfClass("Humanoid")
                    end
                    if v43 then
                        v_u_11(v39, "Blood Splatter", v40, v42, false, true, true)
                        v38 = p32 and v_u_24(v_u_16.Character, v39.Parent) and "BackStab" or v38
                    else
                        local v44 = v39.Parent
                        v_u_11(v39, v41.Name, v40, v42, false, true, true)
                        if v44 and v44:HasTag("BreakableGlass") then
                            v_u_12(v39, v40, v35.Unit)
                        elseif not (v39:HasTag("BreakableGlass") or v44 and v44:HasTag("BreakableGlass")) then
                            v_u_10(v39, "Melee", v40, v42)
                        end
                    end
                    v_u_14.Melee.MeleeAttack.Send({
                        ["Direction"] = v_u_17.CFrame.LookVector * p_u_31.Properties.Range,
                        ["Material"] = v37.Material.Name,
                        ["Distance"] = v37.Distance,
                        ["Instance"] = v37.Instance,
                        ["Position"] = v37.Position,
                        ["Normal"] = v37.Normal,
                        ["MeleeAttack"] = v38,
                        ["Identifier"] = p_u_31.Identifier
                    })
                end
                local v45 = p_u_31.Viewmodel.Animation:play(v38)
                local v46 = (v38 == "Swing1" or v38 == "Swing") and "Swing" or v38
                local v47 = p_u_31.Properties.FireRate * (p32 and 2.05 or 1)
                v_u_5.vibrate(Enum.VibrationMotor.Small, 1.15, 0.2)
                p_u_31.CharacterAnimator:play(v46)
                local v48 = v47 or (v45 and v45.Length or 0.3)
                task.delay(v48, function()
                    if not p_u_31.IsDestroyed then
                        p_u_31.IsShooting = false
                        if p_u_31.Identifier ~= v_u_3:JSONDecode(v_u_16:GetAttribute("CurrentEquipped") or "[]").Identifier then
                            return
                        end
                        local v49 = v_u_7.isActionPressed("Fire", { Enum.UserInputType.MouseButton1, Enum.KeyCode.ButtonR2 }) or p_u_31.IsFireHeld
                        local v50 = v_u_7.isActionPressed("Secondary Fire", { Enum.UserInputType.MouseButton2, Enum.KeyCode.ButtonL2 })
                        if v49 or v50 then
                            p_u_31:shoot(v50)
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
function v_u_1.cancelInspect(p_u_51, p52, p53)
    if p_u_51.IsInspecting or p_u_51.IsInspectFadingOut then
        if p_u_51.InspectDelayThread then
            task.cancel(p_u_51.InspectDelayThread)
            p_u_51.InspectDelayThread = nil
        end
        local v54 = p53 or 0.3
        local v_u_55 = p52 or 1.2
        p_u_51.IsInspectFadingOut = true
        p_u_51.IsInspecting = false
        if p_u_51.CancelDelayThread then
            task.cancel(p_u_51.CancelDelayThread)
            p_u_51.CancelDelayThread = nil
        end
        if p_u_51.FadeCompleteThread then
            task.cancel(p_u_51.FadeCompleteThread)
            p_u_51.FadeCompleteThread = nil
        end
        p_u_51.CancelDelayThread = task.delay(v54, function()
            if p_u_51.IsDestroyed then
                return
            elseif p_u_51.IsInspectFadingOut then
                p_u_51.Viewmodel.Animation:crossfadeTo("Idle", v_u_55)
                p_u_51.FadeCompleteThread = task.delay(v_u_55, function()
                    if not p_u_51.IsDestroyed then
                        p_u_51.FadeCompleteThread = nil
                        p_u_51.IsInspectFadingOut = false
                    end
                end)
            end
        end)
    end
end
function v_u_1.inspect(p_u_56)
    if p_u_56.IsShooting then
        return
    elseif p_u_56.IsInspecting and not p_u_56.IsInspectFadingOut then
        return
    else
        local v57 = p_u_56.IsInspectFadingOut == true
        if v57 then
            p_u_56.IsInspectFadingOut = false
            if p_u_56.CancelDelayThread then
                task.cancel(p_u_56.CancelDelayThread)
                p_u_56.CancelDelayThread = nil
            end
            if p_u_56.FadeCompleteThread then
                task.cancel(p_u_56.FadeCompleteThread)
                p_u_56.FadeCompleteThread = nil
            end
            p_u_56.Viewmodel.Animation:cancelCrossfade()
        end
        p_u_56.IsInspecting = true
        p_u_56.IsShooting = false
        if p_u_56.InspectDelayThread then
            task.cancel(p_u_56.InspectDelayThread)
            p_u_56.InspectDelayThread = nil
        end
        if v57 then
            if not p_u_56.Viewmodel.Animation:crossfadeRestart("Inspect", 0.25) then
                p_u_56:stopAllAnimations()
                p_u_56.Viewmodel.Animation:play("Inspect")
            end
            v_u_14.Spectate.ReplicateSpectateEvent.Send("Inspect")
            local v58 = p_u_56.Viewmodel.Animation:getAnimation("Inspect")
            if v58 then
                p_u_56.InspectDelayThread = task.delay(v58.Length, function()
                    if not p_u_56.IsDestroyed then
                        p_u_56.InspectDelayThread = nil
                        p_u_56.IsInspecting = false
                    end
                end)
            end
        else
            p_u_56:stopAllAnimations()
            local v59 = p_u_56.Viewmodel.Animation:play("Inspect")
            v_u_14.Spectate.ReplicateSpectateEvent.Send("Inspect")
            p_u_56.InspectDelayThread = task.delay(v59.Length, function()
                if not p_u_56.IsDestroyed then
                    p_u_56.InspectDelayThread = nil
                    p_u_56.IsInspecting = false
                end
            end)
        end
    end
end
function v_u_1.drop(p60)
    if workspace:GetAttribute("Gamemode") == "Deathmatch" then
        return false
    end
    if v_u_9.GetState() == "Warmup" then
        return false
    end
    if workspace:GetAttribute("VIPKnifeDropEnabled") ~= true then
        return false
    end
    p60:unequip()
    v_u_14.Inventory.DropWeapon.Send({
        ["Direction"] = v_u_17.CFrame.LookVector,
        ["Identifier"] = p60.Identifier
    })
    return true
end
function v_u_1.equip(p61)
    p61.Viewmodel.Animation:stopAnimations()
    p61.CharacterAnimator:stopAnimations()
    p61.CharacterAnimator:play("Idle")
    p61.CharacterAnimator:play("Equip")
    p61.WeaponEquippedTick = tick()
    p61.Viewmodel:equip(false)
    p61.IsInspectFadingOut = false
    p61.IsInspecting = false
    p61.IsShooting = false
    p61.IsFireHeld = false
end
function v_u_1.unequip(p62)
    p62.CharacterAnimator:stopAnimations()
    p62.Viewmodel:unequip()
    p62.IsInspectFadingOut = false
    p62.IsInspecting = false
    p62.IsShooting = false
    p62.IsFireHeld = false
end
function v_u_1.new(p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74, _)
    local v75 = v_u_13.new(p63, p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74)
    local v76 = v_u_1
    local v77 = setmetatable(v75, v76)
    v77.IsInspectFadingOut = false
    v77.IsInspecting = false
    v77.IsShooting = false
    v77.IsFireHeld = false
    v77.InspectDelayThread = nil
    v77.CancelDelayThread = nil
    v77.FadeCompleteThread = nil
    v77.AlternativeSwitchTick = 0
    v77.WeaponEquippedTick = 0
    return v77
end
function v_u_1.destroy(p78)
    if not p78.IsDestroyed then
        p78.IsDestroyed = true
        if p78.InspectDelayThread then
            task.cancel(p78.InspectDelayThread)
            p78.InspectDelayThread = nil
        end
        if p78.CancelDelayThread then
            task.cancel(p78.CancelDelayThread)
            p78.CancelDelayThread = nil
        end
        if p78.FadeCompleteThread then
            task.cancel(p78.FadeCompleteThread)
            p78.FadeCompleteThread = nil
        end
        if p78.Janitor then
            p78.Janitor:Destroy()
            p78.Janitor = nil
        end
        p78.IsInspectFadingOut = nil
        p78.IsInspecting = nil
        p78.IsShooting = nil
        p78.IsFireHeld = nil
        p78.AlternativeSwitchTick = nil
        p78.WeaponEquippedTick = nil
        v_u_13.destroy(p78)
    end
end
return v_u_1