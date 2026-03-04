local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
require(script:WaitForChild("Types"))
local v_u_3 = require(v2.Shared.Janitor)
local v_u_4 = v2:WaitForChild("Assets"):WaitForChild("CharacterAnimations")
local function v_u_8(p5)
    local v6 = p5:FindFirstChildOfClass("Humanoid")
    local v7 = tick()
    while not v6 do
        v6 = p5:FindFirstChildOfClass("Humanoid")
        task.wait(0.1)
        if tick() - v7 > 5 then
            break
        end
    end
    return v6
end
function v_u_1.getAnimation(p9, p10)
    return p9.Animations[p10]
end
function v_u_1.adjustAnimationSpeed(p11, p12, p13)
    local v14 = p11:getAnimation(p12)
    if v14 then
        v14:AdjustSpeed(v14.Length / p13)
    end
end
function v_u_1.play(p15, p16, ...)
    local v17 = p15:getAnimation(p16)
    p15.CurrentAnimation = p16
    if v17 then
        v17:Play(...)
        return v17
    end
    local v18 = {}
    for v19 in pairs(p15.Animations) do
        table.insert(v18, v19)
    end
    return nil
end
function v_u_1.stop(p20, p21, ...)
    local v22 = p20:getAnimation(p21)
    if v22 and v22.IsPlaying then
        v22:Stop(...)
    end
end
function v_u_1.stopAnimations(p23)
    for _, v24 in pairs(p23.Animations) do
        if v24.IsPlaying then
            v24:Stop()
        end
    end
end
function v_u_1.unregister(p25, p26)
    if p25.Animations[p26] then
        local v27 = p25.Animations[p26]
        if v27.IsPlaying then
            v27:Stop()
        end
        if p25.Janitor then
            p25.Janitor:Remove(p26)
        end
        p25.Animations[p26] = nil
        v27:Destroy()
    end
end
function v_u_1.unregisterGroup(p28, ...)
    for _, v29 in ipairs({ ... }) do
        p28:unregister(v29)
    end
end
function v_u_1.register(p_u_30, p31, p_u_32)
    p_u_30:unregister(p31)
    local v33, v34 = pcall(function()
        return p_u_30.Animator:LoadAnimation(p_u_32)
    end)
    if v33 then
        p_u_30.Animations[p31] = v34
        p_u_30.Janitor:Add(v34, "Destroy", p31)
    end
end
function v_u_1.construct(p35, p36)
    local v37 = v_u_8(p36)
    if v37 then
        p35.Animator = v37:WaitForChild("Animator")
        for _, v38 in ipairs(v_u_4:GetDescendants()) do
            if v38:IsA("Animation") then
                p35:register(v38.Name, v38)
            end
        end
    end
end
function v_u_1.new(p39)
    local v40 = v_u_1
    local v41 = setmetatable({}, v40)
    v41.Janitor = v_u_3.new()
    v41.Animator = nil
    v41.CurrentAnimation = nil
    v41.IsDestroyed = false
    v41.Animations = {}
    v41:construct(p39)
    return v41
end
function v_u_1.destroy(p42)
    if not p42.IsDestroyed then
        p42.IsDestroyed = true
        p42:stopAnimations()
        local v43 = {}
        for v44 in pairs(p42.Animations) do
            table.insert(v43, v44)
        end
        for _, v45 in ipairs(v43) do
            p42:unregister(v45)
        end
        for v46, v_u_47 in pairs(p42.Animations) do
            if v_u_47 then
                if v_u_47.IsPlaying then
                    v_u_47:Stop()
                end
                pcall(function()
                    v_u_47:Destroy()
                end)
            end
            p42.Animations[v46] = nil
        end
        table.clear(p42.Animations)
        if p42.Janitor then
            p42.Janitor:Destroy()
            p42.Janitor = nil
        end
        p42.CurrentAnimation = nil
        p42.Animator = nil
    end
end
return v_u_1