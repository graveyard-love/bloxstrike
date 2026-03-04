local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
return {
    ["IsEnabled"] = function(p3)
        return v_u_1:GetAttribute("Debug_" .. p3) == true
    end,
    ["SetEnabled"] = function(p4, p5)
        if v_u_2:IsServer() or v_u_2:IsClient() then
            v_u_1:SetAttribute("Debug_" .. p4, p5)
        end
    end,
    ["GetAttributeName"] = function(p6)
        return "Debug_" .. p6
    end
}