local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Debris")
require(v1.Database.Custom.Types)
local v_u_3 = require(v1.Components.Common.GetWeaponProperties)
local v_u_4 = v1:WaitForChild("Assets"):WaitForChild("MuzzleFlashes")
local v_u_5 = workspace:WaitForChild("Debris")
return function(p6, p7, p8)
    local v9 = v_u_3(p7)
    if v9 then
        local v10 = p8 or v9.MuzzleType
        local v11 = v_u_4.Camera:FindFirstChild(v10)
        local v12
        if v11 then
            v12 = v11:Clone()
            v12.CollisionGroup = "Debris"
            v12.CanCollide = false
            v12.CanQuery = false
            v12.CanTouch = false
            v12.Anchored = false
        else
            v12 = nil
        end
        if v12 then
            v12.Parent = v_u_5
            local v13 = Instance.new("Motor6D")
            v13.Part0 = p6
            v13.Part1 = v12
            v13.Parent = v12
            for _, v_u_14 in ipairs(v12:GetDescendants()) do
                if v_u_14:IsA("ParticleEmitter") then
                    task.delay(v_u_14:GetAttribute("EmitDelay") or 0, function()
                        v_u_14:Emit(v_u_14:GetAttribute("EmitCount") or 1)
                    end)
                end
            end
            v_u_2:AddItem(v12, 5)
            return p6.Position
        end
    end
    return nil
end