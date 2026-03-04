local v1 = {}
game:GetService("ReplicatedStorage")
require(script.Types)
local v2 = require(script.AttachCharm)
local v_u_3 = {}
function v1.Register(p4)
    if v_u_3[p4.ActionType] then
        warn((("[Actions] Action \"%*\" is already registered"):format(p4.ActionType)))
    else
        v_u_3[p4.ActionType] = p4
    end
end
function v1.Get(p5)
    return v_u_3[p5]
end
function v1.Has(p6)
    return v_u_3[p6] ~= nil
end
function v1.GetAllTypes()
    local v7 = {}
    for v8, _ in pairs(v_u_3) do
        table.insert(v7, v8)
    end
    return v7
end
function v1.InitializeAll()
    for _, v9 in pairs(v_u_3) do
        if v9.Initialize then
            v9.Initialize()
        end
    end
end
function v1.DestroyAll()
    for _, v10 in pairs(v_u_3) do
        if v10.Destroy then
            v10.Destroy()
        end
    end
end
v1.Register(v2)
return v1