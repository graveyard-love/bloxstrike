local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
require(v2.Database.Custom.Types)
local v_u_3 = {}
function v1.GetMissionDefinition(p4)
    return v_u_3[p4]
end
for _, v5 in ipairs(script:GetChildren()) do
    if v5:IsA("ModuleScript") then
        local v6 = require(v5)
        v_u_3[v6.MissionId] = v6
    end
end
return v1