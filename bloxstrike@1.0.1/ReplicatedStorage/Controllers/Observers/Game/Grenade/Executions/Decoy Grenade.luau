local v1 = game:GetService("ReplicatedStorage")
require(v1.Database.Custom.Types)
return function(_, _, p_u_2)
    for _, v3 in ipairs(p_u_2:GetDescendants()) do
        if v3:IsA("BasePart") then
            v3.CollisionGroup = "Debris"
            v3.Transparency = 1
            v3.CanCollide = false
            v3.CanTouch = false
            v3.CanQuery = false
        end
    end
    task.delay(0.5, function()
        if p_u_2 and p_u_2.Parent then
            p_u_2:Destroy()
        end
    end)
end