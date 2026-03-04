local v_u_1 = game:GetService("ReplicatedStorage")
require(v_u_1.Shared.Janitor)
local v_u_2 = require(v_u_1.Classes.Sound)
local v_u_3 = workspace:WaitForChild("Debris")
return function(p4, p5, p_u_6)
    for _, v7 in ipairs(p_u_6:GetDescendants()) do
        if v7:IsA("BasePart") then
            v7.CollisionGroup = "Debris"
            v7.Transparency = 1
            v7.CanCollide = false
            v7.CanTouch = false
            v7.CanQuery = false
        end
    end
    local v8 = p4:Add(v_u_1.Assets.GrenadeParticles["HE Grenade"]:Clone())
    v8.CFrame = CFrame.new(p5)
    v8.Parent = v_u_3
    v8.Anchored = true
    v_u_2.new("HE Grenade"):playOneTime({
        ["Parent"] = v8,
        ["Name"] = "Explode"
    })
    for _, v_u_9 in ipairs(v8:GetDescendants()) do
        if v_u_9:IsA("ParticleEmitter") then
            task.delay(v_u_9:GetAttribute("EmitDelay") or 0, function()
                v_u_9:Emit(v_u_9:GetAttribute("EmitCount") or 1)
            end)
        end
    end
    task.delay(3, function()
        if p_u_6 and p_u_6.Parent then
            p_u_6:Destroy()
        end
    end)
end