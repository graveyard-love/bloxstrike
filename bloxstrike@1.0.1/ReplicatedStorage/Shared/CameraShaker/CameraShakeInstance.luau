local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = Vector3.new
local v_u_3 = math.noise
v_u_1.CameraShakeState = {
    ["FadingIn"] = 0,
    ["FadingOut"] = 1,
    ["Sustained"] = 2,
    ["Inactive"] = 3
}
function v_u_1.new(p4, p5, p6, p7)
    local v8 = p6 == nil and 0 or p6
    local v9 = p7 == nil and 0 or p7
    local v10 = type(p4) == "number"
    assert(v10, "Magnitude must be a number")
    local v11 = type(p5) == "number"
    assert(v11, "Roughness must be a number")
    local v12 = type(v8) == "number"
    assert(v12, "FadeInTime must be a number")
    local v13 = type(v9) == "number"
    assert(v13, "FadeOutTime must be a number")
    local v14 = {
        ["Magnitude"] = p4,
        ["Roughness"] = p5,
        ["PositionInfluence"] = v_u_2(),
        ["RotationInfluence"] = v_u_2(),
        ["DeleteOnInactive"] = true,
        ["roughMod"] = 1,
        ["magnMod"] = 1,
        ["fadeOutDuration"] = v9,
        ["fadeInDuration"] = v8,
        ["sustain"] = v8 > 0,
        ["currentFadeTime"] = v8 > 0 and 0 or 1,
        ["tick"] = Random.new():NextNumber(-100, 100),
        ["_camShakeInstance"] = true
    }
    local v15 = v_u_1
    return setmetatable(v14, v15)
end
function v_u_1.UpdateShake(p16, p17)
    local v18 = p16.tick
    local v19 = p16.currentFadeTime
    local v20 = v_u_2(v_u_3(v18, 0) * 0.5, v_u_3(0, v18) * 0.5, v_u_3(v18, v18) * 0.5)
    if p16.fadeInDuration > 0 and p16.sustain then
        if v19 < 1 then
            v19 = v19 + p17 / p16.fadeInDuration
        elseif p16.fadeOutDuration > 0 then
            p16.sustain = false
        end
    end
    if not p16.sustain then
        v19 = v19 - p17 / p16.fadeOutDuration
    end
    if p16.sustain then
        p16.tick = v18 + p17 * p16.Roughness * p16.roughMod
    else
        p16.tick = v18 + p17 * p16.Roughness * p16.roughMod * v19
    end
    p16.currentFadeTime = v19
    return v20 * p16.Magnitude * p16.magnMod * v19
end
function v_u_1.StartFadeOut(p21, p22)
    if p22 == 0 then
        p21.currentFadeTime = 0
    end
    p21.fadeOutDuration = p22
    p21.fadeInDuration = 0
    p21.sustain = false
end
function v_u_1.StartFadeIn(p23, p24)
    if p24 == 0 then
        p23.currentFadeTime = 1
    end
    p23.fadeInDuration = p24 or p23.fadeInDuration
    p23.fadeOutDuration = 0
    p23.sustain = true
end
function v_u_1.GetScaleRoughness(p25)
    return p25.roughMod
end
function v_u_1.SetScaleRoughness(p26, p27)
    p26.roughMod = p27
end
function v_u_1.GetScaleMagnitude(p28)
    return p28.magnMod
end
function v_u_1.SetScaleMagnitude(p29, p30)
    p29.magnMod = p30
end
function v_u_1.GetNormalizedFadeTime(p31)
    return p31.currentFadeTime
end
function v_u_1.IsShaking(p32)
    return p32.currentFadeTime > 0 and true or p32.sustain
end
function v_u_1.IsFadingOut(p33)
    local v34 = not p33.sustain
    if v34 then
        v34 = p33.currentFadeTime > 0
    end
    return v34
end
function v_u_1.IsFadingIn(p35)
    local v36 = p35.currentFadeTime < 1 and p35.sustain
    if v36 then
        v36 = p35.fadeInDuration > 0
    end
    return v36
end
function v_u_1.GetState(p37)
    if p37:IsFadingIn() then
        return v_u_1.CameraShakeState.FadingIn
    elseif p37:IsFadingOut() then
        return v_u_1.CameraShakeState.FadingOut
    elseif p37:IsShaking() then
        return v_u_1.CameraShakeState.Sustained
    else
        return v_u_1.CameraShakeState.Inactive
    end
end
return v_u_1