local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(v1.Classes.Ragdoll.Types)
local v_u_3 = v2.LocalPlayer
local v4 = require(v1.Classes.Sound)
local v_u_5 = require(v1.Classes.Ragdoll)
local v_u_6 = v4.new("Finishers")
local function v_u_10(p_u_7, _)
    local v8 = p_u_7.Janitor:Add(script.FinisherGui:Clone(), "Destroy", "FinisherGui")
    v8.Parent = v_u_3.PlayerGui
    local v9 = v_u_6:play({
        ["Parent"] = v8,
        ["Name"] = "LeSunshine"
    })
    if v9 then
        p_u_7.Janitor:Add(v9.Ended:Once(function()
            p_u_7.Janitor:Remove("FinisherGui")
        end))
    end
end
return {
    ["Replication"] = "All",
    ["Finisher"] = function(p11, p12)
        local v_u_13 = v_u_5.new(p11, p12)
        local v14 = p12.Victim
        local v15 = v_u_3.UserId
        if v14 == tostring(v15) then
            v_u_10(v_u_13, p12)
        end
        return {
            ["OnDestroy"] = v_u_13.OnDestroy,
            ["Destroy"] = function()
                v_u_13:Destroy()
            end
        }
    end
}