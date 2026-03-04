local v_u_1 = game:GetService("ReplicatedStorage")
require(v_u_1.Database.Custom.Types)
return function(p2)
    local v3 = v_u_1.Database.Custom.Weapons:FindFirstChild(p2)
    if v3 then
        return require(v3)
    else
        return nil
    end
end