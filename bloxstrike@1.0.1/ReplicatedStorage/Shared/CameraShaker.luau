local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = debug.profilebegin
local v_u_3 = debug.profileend
local v4 = Vector3.new
local v_u_5 = CFrame.new
local v_u_6 = CFrame.Angles
local v_u_7 = math.rad
local v_u_8 = v4()
local v_u_9 = require(script.CameraShakeInstance)
local v_u_10 = v_u_9.CameraShakeState
v_u_1.CameraShakeInstance = v_u_9
v_u_1.Presets = require(script.CameraShakePresets)
function v_u_1.new(p11, p12)
    local v13 = type(p11) == "number"
    assert(v13, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)")
    local v14 = type(p12) == "function"
    assert(v14, "Callback must be a function")
    local v15 = {
        ["_running"] = false,
        ["_renderName"] = "CameraShaker",
        ["_renderPriority"] = p11,
        ["_posAddShake"] = v_u_8,
        ["_rotAddShake"] = v_u_8,
        ["_camShakeInstances"] = {},
        ["_removeInstances"] = {},
        ["_callback"] = p12
    }
    local v16 = v_u_1
    return setmetatable(v15, v16)
end
function v_u_1.Start(p_u_17)
    if not p_u_17._running then
        p_u_17._running = true
        local v_u_18 = p_u_17._callback
        game:GetService("RunService"):BindToRenderStep(p_u_17._renderName, p_u_17._renderPriority, function(p19)
            v_u_2("CameraShakerUpdate")
            local v20 = p_u_17:Update(p19)
            v_u_3()
            v_u_18(v20)
        end)
    end
end
function v_u_1.Stop(p21)
    if p21._running then
        game:GetService("RunService"):UnbindFromRenderStep(p21._renderName)
        p21._running = false
    end
end
function v_u_1.StopSustained(p22, p23)
    for _, v24 in pairs(p22._camShakeInstances) do
        if v24.fadeOutDuration == 0 then
            v24:StartFadeOut(p23 or v24.fadeInDuration)
        end
    end
end
function v_u_1.Update(p25, p26)
    local v27 = v_u_8
    local v28 = v_u_8
    local v29 = p25._camShakeInstances
    for v30 = 1, #v29 do
        local v31 = v29[v30]
        local v32 = v31:GetState()
        if v32 == v_u_10.Inactive and v31.DeleteOnInactive then
            p25._removeInstances[#p25._removeInstances + 1] = v30
        elseif v32 ~= v_u_10.Inactive then
            local v33 = v31:UpdateShake(p26)
            v27 = v27 + v33 * v31.PositionInfluence
            v28 = v28 + v33 * v31.RotationInfluence
        end
    end
    for v34 = #p25._removeInstances, 1, -1 do
        local v35 = p25._removeInstances[v34]
        table.remove(v29, v35)
        p25._removeInstances[v34] = nil
    end
    return v_u_5(v27) * v_u_6(0, v_u_7(v28.Y), 0) * v_u_6(v_u_7(v28.X), 0, (v_u_7(v28.Z)))
end
function v_u_1.Shake(p36, p37)
    local v38
    if type(p37) == "table" then
        v38 = p37._camShakeInstance
    else
        v38 = false
    end
    assert(v38, "ShakeInstance must be of type CameraShakeInstance")
    p36._camShakeInstances[#p36._camShakeInstances + 1] = p37
    return p37
end
function v_u_1.ShakeSustain(p39, p40)
    local v41
    if type(p40) == "table" then
        v41 = p40._camShakeInstance
    else
        v41 = false
    end
    assert(v41, "ShakeInstance must be of type CameraShakeInstance")
    p39._camShakeInstances[#p39._camShakeInstances + 1] = p40
    p40:StartFadeIn(p40.fadeInDuration)
    return p40
end
function v_u_1.ShakeOnce(p42, p43, p44, p45, p46, p47, p48)
    local v49 = v_u_9.new(p43, p44, p45, p46)
    v49.PositionInfluence = typeof(p47) == "Vector3" and p47 and p47 or Vector3.new(0.15, 0.15, 0.15)
    v49.RotationInfluence = typeof(p48) == "Vector3" and p48 and p48 or Vector3.new(1, 1, 1)
    p42._camShakeInstances[#p42._camShakeInstances + 1] = v49
    return v49
end
function v_u_1.StartShake(p50, p51, p52, p53, p54, p55)
    local v56 = v_u_9.new(p51, p52, p53)
    v56.PositionInfluence = typeof(p54) == "Vector3" and p54 and p54 or Vector3.new(0.15, 0.15, 0.15)
    v56.RotationInfluence = typeof(p55) == "Vector3" and p55 and p55 or Vector3.new(1, 1, 1)
    v56:StartFadeIn(p53)
    p50._camShakeInstances[#p50._camShakeInstances + 1] = v56
    return v56
end
return v_u_1