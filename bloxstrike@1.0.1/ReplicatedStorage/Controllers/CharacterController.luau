local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
local v_u_4 = require(v2.Classes.Character)
local v_u_5 = require(v2.Classes.Sound)
local v_u_6 = require(v2.Controllers.CameraController)
local v_u_7 = require(v2.Controllers.CaseSceneController)
local v_u_8 = require(v2.Controllers.Observers.Character.Components.CharacterKinematics)
local v_u_9 = require(v2.Database.Security.Remotes)
local v_u_10 = require(v2.Database.Security.Router)
local v_u_11 = require(v2.Controllers.InventoryController)
local v_u_12 = v3.LocalPlayer
local v_u_13 = require(v_u_12:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
local v_u_14 = workspace.CurrentCamera
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = false
function v_u_1.getCurrentCharacter()
    return v_u_15
end
function v_u_1.GetWalkState()
    local v21 = v_u_15
    if v21 then
        v21 = v_u_15.IsWalking
    end
    return v21
end
function v_u_1.GetCrouchState()
    local v22 = v_u_15
    if v22 then
        v22 = v_u_15.IsCrouching
    end
    return v22
end
function v_u_1.walk(p23)
    if v_u_15 then
        v_u_15:ToggleWalkState(p23)
    end
end
function v_u_1.crouch(p24)
    if v_u_15 then
        v_u_15:ToggleCrouchInput(p24)
    end
end
function v_u_1.PlantBomb()
    if v_u_15 then
        v_u_15:PlantBomb()
    end
end
function v_u_1.CancelBombPlant()
    if v_u_15 then
        v_u_15:CancelBombPlant()
    end
end
function v_u_1.jump()
    if v_u_15 then
        v_u_15.IsJumpRequested = true
        v_u_15:Jump()
    else
        local v25 = v_u_12.Character
        if v25 then
            local v26 = v25:FindFirstChildOfClass("Humanoid")
            if v26 and v26.Health > 0 then
                v26.Jump = true
            end
        end
    end
end
function v_u_1.characterAdded(p_u_27)
    if v_u_15 then
        v_u_15:Destroy()
        v_u_15 = nil
    end
    local v28 = v_u_7.IsActive()
    local v29 = p_u_27:WaitForChild("HumanoidRootPart", 20)
    local v30 = p_u_27:FindFirstChildOfClass("Humanoid")
    if not v30 then
        local v31 = tick()
        repeat
            task.wait(0.1)
            v30 = p_u_27:FindFirstChildOfClass("Humanoid")
        until v30 or tick() - v31 > 20
    end
    if p_u_27:IsDescendantOf(workspace) and v30 then
        v29.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        v29.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        local v32 = v_u_13:GetControls().activeController
        if v32 then
            v32.moveVector = Vector3.new(0, 0, 0)
            v32.backwardValue = 0
            v32.forwardValue = 0
            v32.rightValue = 0
            v32.leftValue = 0
        end
        if not v28 then
            v_u_14.CameraType = Enum.CameraType.Custom
            v_u_14.CameraSubject = p_u_27.Humanoid
        end
        v_u_12.ReplicationFocus = p_u_27.Humanoid
        if v_u_18 then
            v_u_18()
            v_u_18 = nil
        end
        if v_u_16 then
            v_u_16:Disconnect()
            v_u_16 = nil
        end
        if v_u_19 then
            v_u_19()
            v_u_19 = nil
        end
        if v_u_17 then
            v_u_17:Disconnect()
            v_u_17 = nil
        end
        v_u_20 = false
        v_u_15 = v_u_4.new(p_u_27, v29, v30)
        local function v_u_33()
            if not v_u_20 then
                v_u_20 = true
                if v_u_15 then
                    v_u_15:Destroy()
                    v_u_15 = nil
                end
                v_u_11.CleanupCurrentLoadout()
                if v_u_18 then
                    v_u_18()
                    v_u_18 = nil
                end
                if v_u_16 then
                    v_u_16:Disconnect()
                    v_u_16 = nil
                end
                if v_u_19 then
                    v_u_19()
                    v_u_19 = nil
                end
                if v_u_17 then
                    v_u_17:Disconnect()
                    v_u_17 = nil
                end
            end
        end
        v_u_18 = v_u_9.Character.CharacterDied.Listen(function()
            v_u_33()
        end)
        v_u_16 = p_u_27:GetAttributeChangedSignal("Dead"):Connect(function()
            if p_u_27:GetAttribute("Dead") then
                v_u_33()
            end
        end)
        v_u_19 = v_u_9.UI.UIPlayerKilled.Listen(function(p34)
            if p34 then
                local v35 = p34.Victim
                local v36 = v_u_12.UserId
                if v35 == tostring(v36) and v_u_12.Character == p_u_27 then
                    v_u_33()
                    return
                end
            end
        end)
        v_u_17 = v30.HealthChanged:Connect(function(p37)
            if p37 <= 0 then
                v_u_33()
            end
        end)
        if p_u_27:GetAttribute("Dead") or v30.Health <= 0 then
            v_u_33()
        end
    else
        return
    end
end
function v_u_1.Initialize()
    v_u_12.CharacterAdded:Connect(function(p38)
        v_u_1.characterAdded(p38)
    end)
    v_u_12.CharacterRemoving:Connect(function()
        if v_u_15 then
            v_u_15:Destroy()
            v_u_15 = nil
        end
        if v_u_18 then
            v_u_18()
            v_u_18 = nil
        end
        if v_u_16 then
            v_u_16:Disconnect()
            v_u_16 = nil
        end
        if v_u_19 then
            v_u_19()
            v_u_19 = nil
        end
        if v_u_17 then
            v_u_17:Disconnect()
            v_u_17 = nil
        end
        v_u_20 = false
    end)
    v_u_9.Character.CharacterDamaged.Listen(function()
        if v_u_15 then
            v_u_15.CharacterAnimator:play("Damaged")
            v_u_5.new("Character"):playOneTime({
                ["Parent"] = v_u_12.PlayerGui,
                ["Name"] = "Character Damaged"
            })
        end
    end)
    v_u_9.Character.CharacterFlinch.Listen(function(p39)
        v_u_6.flinch(p39.Damage, p39.Headshot)
    end)
    v_u_9.Character.ShotSlow.Listen(function(p40)
        if v_u_15 then
            v_u_15.ShotSlowUntil = tick() + p40.Duration
            v_u_15.ShotSlowMultiplier = p40.Multiplier
        end
    end)
    v_u_9.Character.ReplicateLookAngle.Listen(function(p41)
        local v42 = p41.Player
        local v43 = p41.HorizontalAngle
        local v44 = p41.VerticalLook
        if v42 and (v43 == v43 and v44 == v44) then
            v_u_8.setTargetRotation(v42, v43)
            v_u_8.setVerticalLook(v42, v44)
        end
    end)
end
function v_u_1.Start()
    v_u_10.observerRouter("Plant Bomb", function()
        v_u_1.PlantBomb()
    end)
    v_u_10.observerRouter("Cancel Bomb Plant", function()
        v_u_1.CancelBombPlant()
    end)
    v_u_10.observerRouter("GetCurrentCharacter", function()
        return v_u_1.getCurrentCharacter()
    end)
end
return v_u_1