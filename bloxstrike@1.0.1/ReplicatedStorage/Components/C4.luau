local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = v4.LocalPlayer
local v_u_6 = require(v2.Classes.WeaponComponent)
local v_u_7 = require(v2.Database.Components.GameState)
require(v2.Classes.Sound)
local v_u_8 = require(v2.Database.Security.Remotes)
local v_u_9 = require(v2.Database.Security.Router)
local v_u_10 = workspace.CurrentCamera
local v_u_11 = workspace:WaitForChild("Debris")
local v_u_12 = nil
local v_u_13 = RaycastParams.new()
v_u_13.FilterType = Enum.RaycastFilterType.Exclude
v_u_13.IgnoreWater = true
local function v_u_23()
    local v14 = v_u_5.Character
    v_u_13.FilterDescendantsInstances = { v14, v_u_10, v_u_11 }
    local v15
    if v14 and v14:IsDescendantOf(workspace) then
        local v16 = v14:FindFirstChild("Humanoid")
        v15 = v16 and v16.Health > 0 and true or false
    else
        v15 = false
    end
    if v15 then
        local v17 = v14:FindFirstChild("Humanoid")
        if v17 then
            local v18 = v17:GetState()
            if v18 == Enum.HumanoidStateType.Freefall or v18 == Enum.HumanoidStateType.Jumping then
                return false
            end
        end
        local v19 = v14.PrimaryPart
        if v19 and v19.Position then
            local v20 = v19.Position
            local v21 = workspace:Raycast(v20, Vector3.new(-0, -5, -0), v_u_13)
            if v21 then
                local v22 = v21.Instance
                if v22:HasTag("PlantArea") and v22:GetAttribute("Site") then
                    return true
                end
            end
        end
    end
    return false
end
function v_u_1.stopAllAnimations(p24)
    if p24.CharacterAnimator then
        if p24.Viewmodel and p24.Viewmodel.Animation then
            for v25, v26 in pairs(p24.CharacterAnimator.Animations) do
                if v26.IsPlaying and v26.Name ~= "Idle" then
                    p24.CharacterAnimator:stop(v25)
                end
            end
            for v27, v28 in pairs(p24.Viewmodel.Animation.Animations) do
                if v28.IsPlaying and v28.Name ~= "Idle" then
                    p24.Viewmodel.Animation:stop(v27)
                end
            end
        end
    else
        return
    end
end
function v_u_1.reload(_) end
function v_u_1.shoot(p_u_29)
    if not p_u_29.IsPlanting then
        if p_u_29.Janitor:Get("BombAnimationEnded") then
            p_u_29.Janitor:Remove("BombAnimationEnded")
        end
        if v_u_23() then
            p_u_29.IsInspecting = false
            p_u_29.IsPlanting = true
            p_u_29.PlantStartedTick = tick()
            p_u_29:stopAllAnimations()
            v_u_8.Spectate.ReplicateSpectateEvent.Send("Use")
            local v30 = p_u_29.Viewmodel.Animation:play("Use")
            v_u_8.Spectate.ReplicateSpectateEvent.Send("Use")
            p_u_29.CharacterAnimator:play("Use")
            v_u_8.C4.Start.Send(p_u_29.Identifier)
            v_u_9.broadcastRouter("Plant Bomb")
            p_u_29.Viewmodel.Sound:play({
                ["Parent"] = v_u_5.PlayerGui,
                ["Name"] = "Planting"
            })
            p_u_29.Janitor:Add(v30.Ended:Connect(function()
                if p_u_29.IsPlanting then
                    if v_u_23() then
                        v_u_8.C4.Planted.Send(p_u_29.Identifier)
                        p_u_29.IsPlanting = false
                    end
                    v_u_9.broadcastRouter("Cancel Bomb Plant")
                end
            end), "Disconnect", "BombAnimationEnded")
        end
    end
end
function v_u_1.cancel(p31)
    if p31.IsPlanting then
        p31.Viewmodel.Model.Weapon.Interactive.SurfaceGui.TextLabel.Text = "*******"
        p31.IsPlanting = false
        p31:stopAllAnimations()
        v_u_8.Spectate.ReplicateSpectateEvent.Send("Cancel Plant")
        v_u_8.C4.Cancel.Send(p31.Identifier)
        v_u_9.broadcastRouter("Cancel Bomb Plant")
        if p31.Janitor:Get("BombAnimationEnded") then
            p31.Janitor:Remove("BombAnimationEnded")
        end
    end
end
function v_u_1.inspect(p_u_32)
    if not (p_u_32.IsInspecting or p_u_32.IsPlanting) then
        p_u_32.IsInspecting = true
        p_u_32:stopAllAnimations()
        local v33 = p_u_32.Viewmodel.Animation:play("Inspect")
        v_u_8.Spectate.ReplicateSpectateEvent.Send("Inspect")
        task.delay(v33.Length, function()
            p_u_32.IsInspecting = false
        end)
    end
end
function v_u_1.drop(p34)
    if workspace:GetAttribute("Gamemode") == "Deathmatch" then
        return false
    end
    if v_u_7.GetState() == "Warmup" then
        return false
    end
    if p34.IsPlanting then
        return false
    end
    if not p34.Properties.Droppable then
        return false
    end
    p34:unequip()
    v_u_8.Inventory.DropWeapon.Send({
        ["Direction"] = v_u_10.CFrame.LookVector,
        ["Identifier"] = p34.Identifier
    })
    return true
end
function v_u_1.equip(p35)
    p35.Viewmodel.Animation:stopAnimations()
    p35.CharacterAnimator:stopAnimations()
    p35.CharacterAnimator:play("Idle")
    p35.CharacterAnimator:play("Equip")
    p35.Viewmodel:equip(false)
    v_u_12 = p35
end
function v_u_1.unequip(p36)
    if p36.IsPlanting then
        p36:cancel()
    end
    p36.CharacterAnimator:stopAnimations()
    p36.Viewmodel:unequip()
    if v_u_12 and v_u_12 == p36 then
        v_u_12 = nil
    end
end
function v_u_1.new(p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, _)
    local v49 = v_u_6.new(p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48)
    local v50 = v_u_1
    local v_u_51 = setmetatable(v49, v50)
    v_u_51.IsInspecting = false
    v_u_51.IsPlanting = false
    v_u_51.PlantStartedTick = 0
    v_u_51.Janitor:Add(v_u_3.Heartbeat:Connect(function(_)
        if v_u_51.IsPlanting and not v_u_23() then
            v_u_51:cancel()
        end
    end))
    return v_u_51
end
function v_u_1.destroy(p52)
    if not p52.IsDestroyed then
        p52.IsDestroyed = true
        if p52.IsPlanting then
            p52:cancel()
        end
        if v_u_12 and v_u_12 == p52 then
            v_u_12 = nil
        end
        if p52.Janitor then
            p52.Janitor:Destroy()
            p52.Janitor = nil
        end
        p52.PlantStartedTick = nil
        p52.IsInspecting = nil
        p52.IsPlanting = nil
        v_u_6.destroy(p52)
    end
end
v_u_8.C4.ForceCancel.Listen(function()
    if v_u_12 and v_u_12.IsPlanting then
        v_u_12:cancel()
    end
end)
return v_u_1