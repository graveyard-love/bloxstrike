local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v5 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_6 = require(v_u_2.Controllers.DataController)
local v_u_7 = require(v_u_2.Database.Custom.Constants)
local v8 = require(v_u_2.Shared.Spring)
local v_u_9 = v5.LocalPlayer
local v_u_10 = v_u_9:WaitForChild("PlayerGui"):WaitForChild("MainGui")
local v_u_11 = workspace.CurrentCamera
local v_u_12 = true
local v_u_13 = 1
local v_u_14 = 0
Vector2.new(4, 3)
local v_u_15 = {}
local v_u_16 = {}
local v_u_17 = false
local v_u_18 = 1
local v_u_19 = 0.5
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = nil
local v_u_23 = v8.new(1, 100, v_u_7.DEFAULT_CAMERA_FOV)
local v_u_24 = v8.new(0.5, 25, Vector3.new(0, 0, 0))
local v_u_25 = v8.new(0.4, 25, Vector3.new(0, 0, 0))
local v_u_26 = v8.new(0.3, 35, Vector3.new(0, 0, 0))
local v_u_27 = v8.new(0.6, 30, Vector3.new(0, 0, 0))
local v_u_28 = v8.new(1, 1, Vector3.new(0, 0, 0))
local v_u_29 = v8.new(1, 1, Vector3.new(0, 0, 0))
local v_u_30 = v8.new(1, 1, Vector3.new(0, 0, 0))
local function v_u_39(p31)
    local v32 = v_u_24:getPosition()
    local v33 = v_u_29:getPosition() + v_u_25:getPosition()
    local v34 = v32 + v_u_28:getPosition()
    local v35 = v_u_30:getPosition() * (p31 or v_u_13)
    if not v_u_21 then
        local v36, v37 = pcall(function()
            return require(v_u_2.Controllers.AimAssistController)
        end)
        if v36 and v37 then
            v_u_21 = v37
        end
    end
    local v38 = v34 + v35 * (1 - (not (v_u_21 and v_u_21.GetRecoilAssistMultiplier) and 0 or v_u_21.GetRecoilAssistMultiplier())) + v_u_27:getPosition() + v_u_26:getPosition()
    return v_u_22 * CFrame.new(v33) * CFrame.Angles(v38.X, v38.Y, v38.Z)
end
function v_u_1.getWeaponKickRotation()
    return v_u_28:getPosition()
end
function v_u_1.updateCameraFOV()
    -- failed to decompile
end
function v_u_1.setFOVLock(p40, p41, p42)
    -- block 12
    if p41 then
        v_u_16[p40] = p42 or v_u_23:getGoal()
    else
        v_u_16[p40] = nil
    end
    local v43, v44, v45
    -- GenericForInit
v43, v44, v45 = pairs(v_u_16)
[internal control] = v45
-- end GenericForInit
    local v46, v47
    -- GenericForNext
v46, v47 = v43(v44, [internal control])
if v46 ~= nil
[internal control] = v46
-- end GenericForNext
    -- block 2
    goto l8
    ::l4::
    v47 = nil
    goto l8
    -- block 7
    goto l4
    ::l8::
    if v47 ~= nil then
        v_u_23:reset(v47)
    end
    return
end
function v_u_1.isFOVLocked()
    return next(v_u_16) ~= nil
end
function v_u_1.setMouseEnabled(p48)
    v_u_17 = p48
    if next(v_u_15) == nil then
        v_u_3.MouseBehavior = p48 and Enum.MouseBehavior.Default or Enum.MouseBehavior.LockCenter
        v_u_3.MouseIconEnabled = p48
        v_u_10.CameraPerspective.Visible = p48
    end
end
function v_u_1.setForceLockOverride(p49, p50)
    if p50 then
        v_u_15[p49] = true
    else
        v_u_15[p49] = nil
    end
    if next(v_u_15) ~= nil then
        v_u_3.MouseBehavior = Enum.MouseBehavior.Default
        v_u_3.MouseIconEnabled = true
        v_u_10.CameraPerspective.Visible = true
    else
        v_u_3.MouseBehavior = Enum.MouseBehavior.LockCenter
        v_u_3.MouseIconEnabled = false
        v_u_10.CameraPerspective.Visible = false
    end
end
function v_u_1.resetForceLockOverride()
    table.clear(v_u_15)
    v_u_17 = false
    v_u_3.MouseBehavior = Enum.MouseBehavior.LockCenter
    v_u_3.MouseIconEnabled = false
    v_u_10.CameraPerspective.Visible = false
end
function v_u_1.isForceLockOverrideActive()
    return next(v_u_15) ~= nil
end
function v_u_1.SetEnabled(p51)
    v_u_12 = p51
    if not p51 then
        v_u_22 = nil
    end
end
function v_u_1.IsEnabled()
    return v_u_12
end
function v_u_1.setPerspective(p52, p53)
    local v54 = p52 and 0 or 5
    v_u_1.setMouseEnabled(p53)
    v_u_9.CameraMaxZoomDistance = v54
    v_u_9.CameraMinZoomDistance = v54
    v_u_9.CameraMode = p52 and Enum.CameraMode.LockFirstPerson or Enum.CameraMode.Classic
end
function v_u_1.toWeaponFirePosition()
    if v_u_22 then
        v_u_28:reset(Vector3.new(0, 0, 0))
        v_u_29:reset(Vector3.new(0, 0, 0))
        v_u_11.CFrame = v_u_22
        v_u_1.updateCamera((v_u_39(1)))
    end
end
function v_u_1.weaponKick(p55, p56)
    v_u_28:setDampingRatio(p55.Damper)
    v_u_28:setFrequency(p55.Speed)
    v_u_28:setPosition(p55.Value * 0.017453292519943295 * 1)
    v_u_29:setDampingRatio(p56.Damper)
    v_u_29:setFrequency(p56.Speed)
    v_u_29:setPosition(p56.Value * 1)
    v_u_1.updateCamera()
end
function v_u_1.setWeaponRecoil(p57, p58)
    v_u_30:setDampingRatio(p57.Damper)
    v_u_30:setFrequency(p57.Speed)
    v_u_30:setGoal(p57.Value)
    v_u_13 = p58
end
function v_u_1.getWeaponRecoil()
    return v_u_30:getPosition()
end
require(v_u_2.Database.Security.Router).observerRouter("CameraControllerGetWeaponRecoil", function()
    return v_u_1.getWeaponRecoil()
end)
function v_u_1.flinch(_, p59)
    v_u_27:impulse(Vector3.new(30, 0, 0) * (p59 and 2 or 1))
end
function v_u_1.BombExploded()
    -- failed to decompile
end
function v_u_1.updateCamera()
    -- failed to decompile
end
function v_u_1.StateChanged(p60, p61)
    if tick() - v_u_14 >= 0.3 then
        if p60 == Enum.HumanoidStateType.Freefall and p61 == Enum.HumanoidStateType.Landed then
            v_u_14 = tick()
            v_u_24:setFrequency(25)
            v_u_24:impulse(Vector3.new(-0.2, 0, 0))
            task.delay(0.2, function()
                v_u_24:setFrequency(15)
                v_u_24:impulse(Vector3.new(0.05, 0, 0))
            end)
        end
    end
end
function v_u_1.Initialize()
    local v62, v63 = pcall(function()
        return require(v_u_2.Controllers.AimAssistController)
    end)
    if v62 and (v63 and v63.Initialize) then
        v_u_21 = v63
        v63.Initialize()
    end
    v_u_4.Stepped:Connect(function(_, p64)
        v_u_25:update(p64)
        v_u_26:update(p64)
        v_u_28:update(p64)
        v_u_29:update(p64)
        v_u_27:update(p64)
        v_u_30:update(p64)
        v_u_23:update(p64)
        v_u_24:update(p64)
    end)
    v_u_4:BindToRenderStep("CameraController", Enum.RenderPriority.Camera.Value + 1, function(p65)
        if v_u_12 then
            local v66 = v_u_11.CFrame
            if v_u_21 and v_u_21.GetMagnetismRotation then
                local v67 = v_u_21.GetMagnetismRotation(p65)
                if v67.Magnitude > 0.001 and (v67.X == v67.X and v67.Y == v67.Y) then
                    local v68 = v67.X
                    if math.abs(v68) < 3.141592653589793 then
                        local v69 = v67.Y
                        if math.abs(v69) < 3.141592653589793 then
                            local v70 = v_u_9.Character
                            local v71
                            if v70 and v70:FindFirstChild("HumanoidRootPart") then
                                v71 = v70.HumanoidRootPart.Position
                            else
                                v71 = v66.Position
                            end
                            local v72 = v66.Position - v71
                            local v73 = v67.Y
                            local v74 = math.clamp(v73, -0.08726646259971647, 0.08726646259971647)
                            local v75 = v67.X
                            local v76 = math.clamp(v75, -0.08726646259971647, 0.08726646259971647)
                            local v77 = CFrame.Angles(0, v76, 0)
                            local v78 = CFrame.fromAxisAngle(v66.RightVector, v74) * v77
                            local v79 = v71 + v78:VectorToWorldSpace(v72)
                            local v80 = v78 * v66.Rotation
                            v66 = CFrame.new(v79) * v80
                        end
                    end
                end
            end
            v_u_22 = v66
            local v81 = v_u_39()
            v_u_1.updateCamera(v81)
            local v82 = next(v_u_15) ~= nil and true or v_u_17
            local v83
            if v82 then
                v83 = Enum.MouseBehavior.Default
            else
                v83 = Enum.MouseBehavior.LockCenter
            end
            if v_u_3.MouseBehavior ~= v83 then
                v_u_3.MouseBehavior = v83
            end
            if v_u_3.MouseIconEnabled ~= v82 then
                v_u_3.MouseIconEnabled = v82
            end
            if v_u_10.CameraPerspective.Visible ~= v82 then
                v_u_10.CameraPerspective.Visible = v82
            end
        end
    end)
    v_u_4:BindToRenderStep("ResetCameraShake", Enum.RenderPriority.Camera.Value - 1, function()
        if v_u_12 then
            if v_u_22 then
                v_u_11.CFrame = v_u_22
            end
        else
            return
        end
    end)
    v_u_3.TextBoxFocused:Connect(function()
        v_u_1.setForceLockOverride("TextBox", true)
    end)
    v_u_3.TextBoxFocusReleased:Connect(function()
        task.defer(function()
            local v84 = v_u_3:GetFocusedTextBox() ~= nil
            v_u_1.setForceLockOverride("TextBox", v84)
        end)
    end)
    local v85 = v_u_3:GetFocusedTextBox() ~= nil
    v_u_1.setForceLockOverride("TextBox", v85)
    v_u_4:BindToRenderStep("AspectRatioStretch", Enum.RenderPriority.Camera.Value + 2, function()
        if not v_u_12 then
        end
    end)
    local v86 = v_u_9:GetAttribute("Team")
    local v87 = v86 == "Counter-Terrorists" and true or v86 == "Terrorists"
    if v_u_9.Character == nil and not v87 then
        v_u_1.setForceLockOverride("InitialMenu", true)
    end
end
function v_u_1.Start()
    local v_u_88 = require(v_u_2.Controllers.CaseSceneController)
    v_u_9.CharacterAdded:Connect(function(p89)
        if not v_u_88.IsActive() then
            v_u_1.updateCameraFOV(v_u_7.DEFAULT_CAMERA_FOV)
        end
        p89:GetAttributeChangedSignal("Dead"):Once(function()
            if not v_u_88.IsActive() then
                v_u_1.updateCameraFOV(v_u_7.DEFAULT_CAMERA_FOV)
            end
        end)
    end)
    v_u_6.CreateListener(v_u_9, "Settings.Keyboard/Mouse.Keyboard & Mouse Settings.Mouse Sensitivity", function(p90)
        v_u_18 = math.clamp(p90 or 1, 0.1, 10)
        local v91 = v_u_18
        local v92, v93 = pcall(function()
            return require(v_u_9:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("CameraInput"))
        end)
        if v92 and (v93 and v93.setTouchSensitivity) then
            v93.setTouchSensitivity(v91)
        end
    end)
    local v94 = v_u_18
    local v95, v96 = pcall(function()
        return require(v_u_9:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("CameraInput"))
    end)
    if v95 and (v96 and v96.setTouchSensitivity) then
        v96.setTouchSensitivity(v94)
    end
    v_u_6.CreateListener(v_u_9, "Settings.Keyboard/Mouse.Keyboard & Mouse Settings.Zoom Sensitivity Multiplier", function(p97)
        v_u_19 = math.clamp(p97 or 0.5, 0.1, 5)
    end)
end
return v_u_1