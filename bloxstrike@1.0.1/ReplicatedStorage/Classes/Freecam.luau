local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v5 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_6 = v5.LocalPlayer
local v_u_7 = require(v2.Controllers.CameraController)
local v_u_8 = require(v2.Controllers.InputController)
local v_u_9 = require(v2.Shared.Janitor)
local v_u_10 = workspace.CurrentCamera
local v_u_11 = Vector2.new(9.42477796076938, 5.497787143782138)
function v_u_1.UpdateMovement(p12, p13)
    local v14 = Vector3.new(0, 0, 0)
    if v_u_8.isActionActive("Move Forward") then
        v14 = v14 + Vector3.new(0, 0, -1)
    end
    if v_u_8.isActionActive("Move Backward") then
        v14 = v14 + Vector3.new(0, 0, 1)
    end
    if v_u_8.isActionActive("Move Left (Strafe)") then
        v14 = v14 + Vector3.new(-1, 0, 0)
    end
    if v_u_8.isActionActive("Move Right (Strafe)") then
        v14 = v14 + Vector3.new(1, 0, 0)
    end
    local v15 = 40 * (v_u_8.isActionActive("Walk") and 0.2 or 1)
    if v14 ~= Vector3.new(0, 0, 0) then
        v14 = v14.Unit
    end
    local v16 = p12.CameraCFrame
    local v17 = v16.RightVector
    local v18 = v16.UpVector
    local v19 = v16.LookVector
    local v20 = (v17 * v14.X + v18 * v14.Y + v19 * -v14.Z) * (v15 * p13)
    local v21 = p12.CameraCFrame.Position + v20
    p12.CameraCFrame = CFrame.new(v21, v21 + v19)
    p12:UpdateMouseWheel(p13)
end
function v_u_1.UpdateMouseWheel(p22, _)
    if p22.MouseWheelDelta ~= 0 then
        local v23 = v_u_8.isActionActive("Walk")
        local v24 = p22.MouseWheelDelta
        local v25 = p22.CameraCFrame
        local v26 = v25.LookVector
        local v27 = 15 * (v23 and 0.5 or 1)
        local v28 = v26 * (v24 > 0 and v27 and v27 or -v27)
        local v29 = v25.Position + v28
        p22.CameraCFrame = CFrame.new(v29, v29 + v26)
        p22.MouseWheelDelta = 0
    end
end
function v_u_1.UpdateRotation(p30, _)
    local v31 = v_u_3:GetMouseDelta()
    local v32 = v_u_8.isActionActive("Walk") and 0.5 or 1
    local v33 = v_u_10.ViewportSize
    local v34 = v31.X / v33.X * (v_u_11.X * v32)
    local v35 = v31.Y / v33.Y * (v_u_11.Y * v32)
    local v36 = p30.CameraCFrame
    local v37 = v36.Position
    local v38 = v36.LookVector
    local v39 = v38.Y
    local v40 = math.asin(v39) - v35
    local v41 = math.clamp(v40, -1.3962634015954636, 1.3962634015954636)
    local v42 = v38.X
    local v43 = v38.Z
    local v44 = Vector3.new(v42, 0, v43)
    local v45 = v44.Magnitude
    local v46 = v45 < 0.001 and Vector3.new(0, 0, -1) or v44 / v45
    local v47 = -v46.X
    local v48 = -v46.Z
    local v49 = math.atan2(v47, v48) - v34
    local v50 = math.cos(v41)
    local v51 = -math.sin(v49) * v50
    local v52 = math.sin(v41)
    local v53 = -math.cos(v49) * v50
    local v54 = Vector3.new(v51, v52, v53)
    p30.CameraCFrame = CFrame.new(v37, v37 + v54)
end
function v_u_1.UpdateCamera(p55)
    v_u_10.CFrame = p55.CameraCFrame
end
function v_u_1.Render(p56, p57)
    p56:UpdateMovement(p57)
    p56:UpdateRotation(p57)
    p56:UpdateCamera()
end
function v_u_1.Start(p_u_58)
    if not p_u_58.IsActive then
        p_u_58.IsActive = true
        p_u_58.CameraCFrame = v_u_10.CFrame
        p_u_58.MouseWheelDelta = 0
        v_u_10.CameraType = Enum.CameraType.Scriptable
        v_u_7.setMouseEnabled(false)
        p_u_58.Janitor:Add(v_u_3:GetPropertyChangedSignal("MouseBehavior"):Connect(function()
            if p_u_58.IsActive and v_u_3.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
                v_u_3.MouseBehavior = Enum.MouseBehavior.LockCenter
            end
        end), "Disconnect", "EnforceMouseBehavior")
        p_u_58.RenderStepName = "Freecam"
        v_u_4:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value + 10, function(p59)
            if p_u_58.IsActive then
                p_u_58:Render(p59)
            end
        end)
        local v60 = workspace:FindFirstChild("Map")
        local v61
        if v60 then
            local v62 = v60:FindFirstChild("ReplicationFocus")
            if v62 then
                v61 = v62:FindFirstChild("Focus")
            else
                v61 = nil
            end
        else
            v61 = nil
        end
        if v61 then
            v_u_6.ReplicationFocus = v61
            p_u_58.Janitor:Add(function()
                v_u_6.ReplicationFocus = nil
            end, true, "ReplicationFocus")
        end
        p_u_58.Janitor:Add(function()
            v_u_4:UnbindFromRenderStep("Freecam")
        end, true)
    end
end
function v_u_1.Stop(p63)
    if p63.IsActive then
        p63.IsActive = false
        v_u_4:UnbindFromRenderStep("Freecam")
        p63.RenderStepName = nil
        v_u_10.CameraType = Enum.CameraType.Custom
        if p63.Janitor:Get("EnforceMouseBehavior") then
            p63.Janitor:Remove("EnforceMouseBehavior")
        end
        if p63.Janitor:Get("ReplicationFocus") then
            p63.Janitor:Remove("ReplicationFocus")
        end
    end
end
function v_u_1.new()
    local v64 = v_u_1
    local v_u_65 = setmetatable({}, v64)
    v_u_65.Janitor = v_u_9.new()
    v_u_65.CameraCFrame = CFrame.identity
    v_u_65.MouseWheelDelta = 0
    v_u_65.RenderStepName = nil
    v_u_65.IsActive = false
    v_u_65.Janitor:Add(v_u_3.InputChanged:Connect(function(p66, p67)
        if v_u_65.IsActive and (not p67 and p66.UserInputType == Enum.UserInputType.MouseWheel) then
            v_u_65.MouseWheelDelta = p66.Position.Z
        end
    end), "Disconnect")
    v_u_65.Janitor:Add(function()
        if v_u_65.IsActive then
            v_u_65:Stop()
        end
    end)
    return v_u_65
end
function v_u_1.Destroy(p68)
    p68.Janitor:Destroy()
end
return v_u_1