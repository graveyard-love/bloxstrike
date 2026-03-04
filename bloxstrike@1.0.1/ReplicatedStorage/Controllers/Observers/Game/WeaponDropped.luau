local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Observers)
local v_u_3 = require(script.Weapon)
return v2.observeTag("WeaponDropped", function(p4)
    local v_u_5 = v_u_3.new(p4)
    return function()
        if v_u_5 then
            v_u_5:destroy()
        end
    end
end)