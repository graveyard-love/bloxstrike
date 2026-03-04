local v1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
require(script:WaitForChild("Types"))
local v_u_4 = require(v_u_2.Packages.Signal).new()
v1.OnAvailableCollectionsUpdated = v_u_4
local v_u_5 = nil
function v1.GetCollectionByName(p6)
    for _, v7 in ipairs(v_u_5) do
        if v7.name == p6 then
            return v7
        end
    end
    return nil
end
function v1.ObserveAvailableCollections(p8)
    local v_u_9 = v_u_4:Connect(p8)
    if v_u_5 then
        p8(v_u_5)
    end
    return function()
        v_u_9:Disconnect()
    end
end
if v_u_2:GetAttribute("AvailableCollections") then
    v_u_5 = v_u_3:JSONDecode((v_u_2:GetAttribute("AvailableCollections")))
    if #v_u_4:GetConnections() > 0 then
        v_u_4:Fire(v_u_5)
    end
end
v_u_2:GetAttributeChangedSignal("AvailableCollections"):Connect(function()
    local v10 = v_u_2:GetAttribute("AvailableCollections")
    if v10 then
        v_u_5 = v_u_3:JSONDecode(v10)
        if #v_u_4:GetConnections() > 0 then
            v_u_4:Fire(v_u_5)
        end
    else
        return
    end
end)
return v1