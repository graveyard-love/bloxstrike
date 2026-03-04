local v1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
require(script:WaitForChild("Types"))
local v_u_4 = require(v_u_2.Packages.Signal).new()
v1.OnActiveBundleUpdated = v_u_4
local v_u_5 = nil
function v1.GetActiveBundle()
    return v_u_5
end
function v1.ObserveActiveBundle(p6)
    local v_u_7 = v_u_4:Connect(p6)
    if v_u_5 then
        p6(v_u_5)
    end
    return function()
        v_u_7:Disconnect()
    end
end
if v_u_2:GetAttribute("ActiveBundle") then
    v_u_5 = v_u_3:JSONDecode((v_u_2:GetAttribute("ActiveBundle")))
    if #v_u_4:GetConnections() > 0 then
        v_u_4:Fire(v_u_5)
    end
end
v_u_2:GetAttributeChangedSignal("ActiveBundle"):Connect(function()
    local v8 = v_u_2:GetAttribute("ActiveBundle")
    if v8 then
        v_u_5 = v_u_3:JSONDecode(v8)
        if #v_u_4:GetConnections() > 0 then
            v_u_4:Fire(v_u_5)
        end
    else
        return
    end
end)
return v1