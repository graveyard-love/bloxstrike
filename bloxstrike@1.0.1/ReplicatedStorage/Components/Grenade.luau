local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
require(v2.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_5 = require(v2.Classes.WeaponComponent)
local v_u_6 = require(v2.Database.Components.GameState)
local v_u_7 = require(v2.Database.Security.Remotes)
local v_u_8 = workspace.CurrentCamera
local v_u_9 = game:GetService("Players").LocalPlayer
function v_u_1.stopAllAnimations(p10)
    if p10.CharacterAnimator then
        if p10.Viewmodel and p10.Viewmodel.Animation then
            for v11, v12 in pairs(p10.CharacterAnimator.Animations) do
                if v12.IsPlaying and v12.Name ~= "Idle" then
                    p10.CharacterAnimator:stop(v11)
                end
            end
            for v13, v14 in pairs(p10.Viewmodel.Animation.Animations) do
                if v14.IsPlaying and v14.Name ~= "Idle" then
                    p10.Viewmodel.Animation:stop(v13)
                end
            end
        end
    else
        return
    end
end
function v_u_1.StartThrow(p15)
    if p15.IsDestroyed then
        return
    else
        local v16
        if workspace:GetAttribute("ServerGamemode") == "Competitive" then
            v16 = v_u_6.GetState() == "Buy Period"
        else
            v16 = false
        end
        if v16 then
            return
        elseif p15.EquipTime > 0 and tick() - p15.EquipTime < 0.7 then
            return
        else
            local v17 = tick()
            if p15.LastThrowTime > 0 and v17 - p15.LastThrowTime < 0.7 then
                return
            elseif p15.ThrowStarted and not p15.ThrowFinished then
                return
            else
                if p15.ThrowFinished then
                    p15.ThrowFinished = false
                    p15.ThrowStarted = false
                    if p15.Janitor:Get("ThrowGrenadeFinished") then
                        p15.Janitor:Remove("ThrowGrenadeFinished")
                    end
                    if p15.Janitor:Get("ThrowGrenadeStoppedFallback") then
                        p15.Janitor:Remove("ThrowGrenadeStoppedFallback")
                    end
                end
                local v18 = tick()
                if p15.LastThrowTime > 0 and v18 - p15.LastThrowTime < 0.7 then
                    return
                elseif v_u_9 and (v_u_9.Character and v_u_9.Character:GetAttribute("Dead")) then
                    return
                else
                    p15.ThrowStarted = true
                    if p15.Viewmodel then
                        if p15.Viewmodel.IsDestroyed then
                            return
                        elseif p15.Viewmodel.Model then
                            if p15.Viewmodel.Model.Parent ~= v_u_8 then
                                if p15.Viewmodel.IsDestroyed or not p15.Viewmodel.equip then
                                    return
                                end
                                p15.Viewmodel:equip(false)
                            end
                            if p15.Viewmodel.Hidden then
                                p15.Viewmodel:unhide()
                            end
                            local v19 = tick()
                            if p15.LastThrowTime > 0 and v19 - p15.LastThrowTime < 0.7 then
                                p15.ThrowStarted = false
                                return
                            elseif not p15.Viewmodel.IsDestroyed then
                                local v20 = p15.Viewmodel.Animation.Animations.Equip
                                if v20 then
                                    v20 = v20.IsPlaying
                                end
                                if v20 then
                                    for v21, v22 in pairs(p15.Viewmodel.Animation.Animations) do
                                        if v22.IsPlaying and (v22.Name ~= "Idle" and v22.Name ~= "Equip") then
                                            p15.Viewmodel.Animation:stop(v21)
                                        end
                                    end
                                    for v23, v24 in pairs(p15.CharacterAnimator.Animations) do
                                        if v24.IsPlaying and (v24.Name ~= "Idle" and v24.Name ~= "Equip") then
                                            p15.CharacterAnimator:stop(v23)
                                        end
                                    end
                                else
                                    p15:stopAllAnimations()
                                end
                                p15.CharacterAnimator:play("StartThrow")
                                p15.CharacterAnimator:play("ThrowIdle")
                                if p15.Viewmodel and (not p15.Viewmodel.IsDestroyed and (p15.Viewmodel.Model and p15.Viewmodel.Model.Parent == v_u_8)) then
                                    local v25 = p15.Viewmodel.Animation:play("ThrowIdle")
                                    p15.Viewmodel.Animation:play("StartThrow")
                                    if v25 then
                                        v25.Looped = true
                                        return
                                    end
                                end
                            end
                        else
                            return
                        end
                    else
                        return
                    end
                end
            end
        end
    end
end
function v_u_1.Throw(p_u_26, p_u_27)
    if p_u_26.ThrowFinished then
        return
    else
        local v28
        if workspace:GetAttribute("ServerGamemode") == "Competitive" then
            v28 = v_u_6.GetState() == "Buy Period"
        else
            v28 = false
        end
        if v28 then
            if p_u_26.ThrowStarted and not p_u_26.ThrowFinished then
                p_u_26:Cancel()
            end
            return
        elseif v_u_9 and (v_u_9.Character and v_u_9.Character:GetAttribute("Dead")) then
            return
        elseif p_u_26.Viewmodel and (not p_u_26.Viewmodel.IsDestroyed and p_u_26.Viewmodel.Model) then
            if p_u_26.Viewmodel.Model.Parent ~= v_u_8 then
                if p_u_26.Viewmodel.IsDestroyed or not p_u_26.Viewmodel.equip then
                    p_u_26.ThrowStarted = false
                    return
                end
                p_u_26.Viewmodel:equip(false)
                v_u_4.Heartbeat:Wait()
                if p_u_26.Viewmodel.Model.Parent ~= v_u_8 then
                    p_u_26.ThrowStarted = false
                    return
                end
            end
            if p_u_26.Viewmodel.Hidden then
                p_u_26.Viewmodel:unhide()
            end
            if p_u_26.Viewmodel.Animation then
                if p_u_26.Janitor:Get("ThrowGrenadeFinished") then
                    p_u_26.Janitor:Remove("ThrowGrenadeFinished")
                end
                if p_u_26.Janitor:Get("ThrowGrenadeStoppedFallback") then
                    p_u_26.Janitor:Remove("ThrowGrenadeStoppedFallback")
                end
                local v29 = p_u_26.Viewmodel.Animation.Animations.Equip
                if v29 then
                    v29 = v29.IsPlaying
                end
                if v29 then
                    p_u_26.Viewmodel.Animation:stop("Equip")
                    p_u_26.CharacterAnimator:stop("Equip")
                    for v30, v31 in pairs(p_u_26.Viewmodel.Animation.Animations) do
                        if v31.IsPlaying and v31.Name ~= "Idle" then
                            p_u_26.Viewmodel.Animation:stop(v30)
                        end
                    end
                    for v32, v33 in pairs(p_u_26.CharacterAnimator.Animations) do
                        if v33.IsPlaying and v33.Name ~= "Idle" then
                            p_u_26.CharacterAnimator:stop(v32)
                        end
                    end
                    v_u_4.Heartbeat:Wait()
                else
                    if p_u_26.Viewmodel.Animation.Animations.StartThrow then
                        p_u_26.Viewmodel.Animation:stop("StartThrow")
                    end
                    if p_u_26.Viewmodel.Animation.Animations.ThrowIdle then
                        p_u_26.Viewmodel.Animation:stop("ThrowIdle")
                    end
                    if p_u_26.CharacterAnimator.Animations.StartThrow then
                        p_u_26.CharacterAnimator:stop("StartThrow")
                    end
                    if p_u_26.CharacterAnimator.Animations.ThrowIdle then
                        p_u_26.CharacterAnimator:stop("ThrowIdle")
                    end
                end
                if p_u_26.Viewmodel and (not p_u_26.Viewmodel.IsDestroyed and p_u_26.Viewmodel.Animation) then
                    local v34 = p_u_26.Viewmodel.Animation:play(p_u_27)
                    if v34 then
                        local v35 = tick()
                        while v34.Length == 0 and tick() - v35 < 0.5 do
                            v_u_4.Heartbeat:Wait()
                        end
                        if p_u_26.IsDestroyed or (not p_u_26.Viewmodel or p_u_26.Viewmodel.IsDestroyed) then
                            p_u_26.ThrowStarted = false
                            return
                        else
                            p_u_26.CharacterAnimator:play("Throw")
                            p_u_26.ThrowCompleted = false
                            local function v_u_40()
                                if p_u_26.ThrowCompleted then
                                    return
                                else
                                    p_u_26.ThrowCompleted = true
                                    if not p_u_26.IsDestroyed and p_u_26.Identifier then
                                        p_u_26.ThrowFinished = true
                                        p_u_26.ThrowStarted = false
                                        p_u_26.LastThrowTime = tick()
                                        local v36 = Vector3.new(0, 0, 0)
                                        local v37 = false
                                        if v_u_9 and v_u_9.Character then
                                            local v38 = v_u_9.Character:FindFirstChild("HumanoidRootPart")
                                            if v38 and v38:IsA("BasePart") then
                                                v36 = v38.AssemblyLinearVelocity
                                            end
                                            local v39 = v_u_9.Character:FindFirstChild("Humanoid")
                                            if v39 then
                                                if v39:GetAttribute("Crouching") == true then
                                                    v37 = true
                                                else
                                                    v37 = false
                                                end
                                            end
                                        end
                                        v_u_7.Inventory.ThrowGrenade.Send({
                                            ["Direction"] = v_u_8.CFrame.LookVector,
                                            ["Position"] = v_u_8.CFrame.Position,
                                            ["Identifier"] = p_u_26.Identifier,
                                            ["Animation"] = p_u_27,
                                            ["CharacterVelocity"] = v36,
                                            ["IsCrouching"] = v37
                                        })
                                    end
                                end
                            end
                            if v34 and v34.IsPlaying then
                                p_u_26.Janitor:Add(v34:GetMarkerReachedSignal("Throw"):Once(function()
                                    v_u_40()
                                end), "Disconnect", "ThrowGrenadeFinished")
                                p_u_26.Janitor:Add(v34.Stopped:Once(function()
                                    task.delay(0.05, function()
                                        if not (p_u_26.ThrowCompleted or p_u_26.IsDestroyed) then
                                            v_u_40()
                                        end
                                    end)
                                end), "Disconnect", "ThrowGrenadeStoppedFallback")
                                if v34.Length > 0 then
                                    local v41 = v34.Length * 0.7
                                    local v_u_42 = task.delay(v41, function()
                                        if not p_u_26.ThrowCompleted and (not p_u_26.IsDestroyed and (p_u_26.ThrowStarted and not p_u_26.ThrowFinished)) then
                                            v_u_40()
                                        end
                                    end)
                                    p_u_26.Janitor:Add(function()
                                        task.cancel(v_u_42)
                                    end, false, "ThrowGrenadeDelayFallback2")
                                end
                                local v_u_43 = task.delay(2, function()
                                    if not p_u_26.ThrowCompleted and (not p_u_26.IsDestroyed and (p_u_26.ThrowStarted and not p_u_26.ThrowFinished)) then
                                        v_u_40()
                                    end
                                end)
                                p_u_26.Janitor:Add(function()
                                    task.cancel(v_u_43)
                                end, false, "ThrowGrenadeDelayFallback3")
                            else
                                p_u_26.ThrowStarted = false
                            end
                        end
                    else
                        p_u_26.ThrowStarted = false
                        return
                    end
                else
                    p_u_26.ThrowStarted = false
                    return
                end
            else
                p_u_26.ThrowStarted = false
                return
            end
        else
            p_u_26.ThrowStarted = false
            return
        end
    end
end
function v_u_1.Cancel(p44)
    if not p44.ThrowFinished then
        if p44.Janitor:Get("ThrowGrenadeFinished") then
            p44.Janitor:Remove("ThrowGrenadeFinished")
        end
        if p44.Janitor:Get("ThrowGrenadeStoppedFallback") then
            p44.Janitor:Remove("ThrowGrenadeStoppedFallback")
        end
        if p44.Janitor:Get("ThrowGrenadeDelayFallback2") then
            p44.Janitor:Remove("ThrowGrenadeDelayFallback2")
        end
        if p44.Janitor:Get("ThrowGrenadeDelayFallback3") then
            p44.Janitor:Remove("ThrowGrenadeDelayFallback3")
        end
        p44.ThrowFinished = false
        p44.ThrowStarted = false
        p44.ThrowCompleted = false
        p44:stopAllAnimations()
    end
end
function v_u_1.inspect(p_u_45)
    if not p_u_45.IsInspecting then
        if p_u_45.ThrowStarted and not p_u_45.ThrowFinished then
            p_u_45:Cancel()
        end
        p_u_45.IsInspecting = true
        p_u_45:stopAllAnimations()
        local v46 = p_u_45.Viewmodel.Animation:play("Inspect")
        v_u_7.Spectate.ReplicateSpectateEvent.Send("Inspect")
        task.delay(v46.Length, function()
            p_u_45.IsInspecting = false
        end)
    end
end
function v_u_1.reload(_) end
function v_u_1.drop(p47)
    if workspace:GetAttribute("Gamemode") == "Deathmatch" then
        return false
    end
    if v_u_6.GetState() == "Warmup" then
        return false
    end
    if not p47.Properties.Droppable then
        return false
    end
    p47:unequip()
    v_u_7.Inventory.DropWeapon.Send({
        ["Direction"] = v_u_8.CFrame.LookVector,
        ["Identifier"] = p47.Identifier
    })
    return true
end
function v_u_1.equip(p_u_48)
    p_u_48.EquipTime = tick()
    if p_u_48.Janitor:Get("EquipDelayThrow") then
        p_u_48.Janitor:Remove("EquipDelayThrow")
    end
    p_u_48.Viewmodel.Animation:stopAnimations()
    p_u_48.CharacterAnimator:stopAnimations()
    p_u_48.ThrowStarted = false
    p_u_48.ThrowFinished = false
    p_u_48.ThrowCompleted = false
    p_u_48.CharacterAnimator:play("Idle")
    p_u_48.CharacterAnimator:play("Equip")
    p_u_48.Viewmodel:equip(false)
    local v_u_49 = task.delay(0.7, function()
        if not p_u_48.IsDestroyed then
            if v_u_3:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or v_u_3:IsKeyDown(Enum.KeyCode.ButtonR2) then
                p_u_48:StartThrow()
            end
        end
    end)
    p_u_48.Janitor:Add(function()
        task.cancel(v_u_49)
    end, false, "EquipDelayThrow")
end
function v_u_1.unequip(p50)
    if p50.Janitor:Get("EquipDelayThrow") then
        p50.Janitor:Remove("EquipDelayThrow")
    end
    p50.CharacterAnimator:stopAnimations()
    p50.Viewmodel:unequip()
    p50.IsInspecting = false
    if p50.ThrowStarted and not p50.ThrowFinished then
        p50:Cancel()
    end
end
function v_u_1.new(p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62, _)
    local v63 = v_u_5.new(p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61, p62)
    local v64 = v_u_1
    local v65 = setmetatable(v63, v64)
    v65.IsInspecting = false
    v65.ThrowStarted = false
    v65.ThrowFinished = false
    v65.ThrowCompleted = false
    v65.LastThrowTime = 0
    v65.EquipTime = 0
    return v65
end
function v_u_1.destroy(p66)
    if not p66.IsDestroyed then
        p66.IsDestroyed = true
        if p66.Janitor then
            p66.Janitor:Destroy()
            p66.Janitor = nil
        end
        p66.ThrowFinished = nil
        p66.ThrowStarted = nil
        p66.ThrowCompleted = nil
        p66.IsInspecting = nil
        v_u_5.destroy(p66)
    end
end
return v_u_1