local v_u_1 = game:GetService("ReplicatedStorage")
require(v_u_1.Shared.Janitor)
local v_u_2 = workspace:WaitForChild("Debris")
return function(p3, p4, p_u_5)
    for _, v6 in ipairs(p_u_5:GetDescendants()) do
        if v6:IsA("BasePart") then
            v6.CollisionGroup = "Debris"
            v6.Transparency = 1
            v6.CanCollide = false
            v6.CanTouch = false
            v6.CanQuery = false
        end
    end
    local v7 = v_u_1.Assets.GrenadeParticles:FindFirstChild("Flashbang")
    if v7 then
        local v8 = p3:Add(v7:Clone())
        v8.CFrame = CFrame.new(p4)
        v8.Parent = v_u_2
        v8.Anchored = true
        for _, v_u_9 in ipairs(v8:GetDescendants()) do
            if v_u_9:IsA("ParticleEmitter") then
                task.delay(v_u_9:GetAttribute("EmitDelay") or 0, function()
                    v_u_9:Emit(v_u_9:GetAttribute("EmitCount") or 1)
                end)
            end
        end
    end
    task.delay(3, function()
        if p_u_5 and p_u_5.Parent then
            p_u_5:Destroy()
        end
    end)
end