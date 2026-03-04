local v1 = game:GetService("ReplicatedStorage")
require(v1.Classes.Ragdoll.Types)
local v_u_2 = require(v1.Classes.Ragdoll)
return {
    ["Replication"] = "All",
    ["Finisher"] = function(p3, p4)
        local v_u_5 = v_u_2.new(p3, p4)
        return {
            ["OnDestroy"] = v_u_5.OnDestroy,
            ["Destroy"] = function()
                v_u_5:Destroy()
            end
        }
    end
}