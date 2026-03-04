local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
require(v2.Database.Custom.Types)
require(v2.Shared.Promise)
local v_u_3 = {}
local function v_u_7(p4, p5)
    local v6 = 0
    while v_u_3[p4] == nil do
        v6 = v6 + task.wait()
        if p5 < v6 then
            break
        end
    end
    return v_u_3[p4]
end
function v1.broadcastRouter(p8, ...)
    local v9 = v_u_7(p8, 1)
    if v9 then
        return v9(...)
    end
    warn((("%* is not cached in local copy."):format(p8)))
end
function v1.observerRouter(p10, p11)
    if v_u_3[p10] then
        warn((("%* already has a router cached in local copy."):format(p10)))
    else
        v_u_3[p10] = p11
    end
end
return v1