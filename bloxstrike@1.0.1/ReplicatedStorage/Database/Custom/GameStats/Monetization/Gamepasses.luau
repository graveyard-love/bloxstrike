local v_u_1 = game:GetService("ServerScriptService")
local v_u_2 = game:GetService("RunService"):IsServer()
local v7 = {
    ["Quick Open"] = {
        ["GamepassId"] = 1667852725,
        ["UpdateOnJoin"] = true,
        ["OnPurchased"] = function(p3)
            local v4 = v_u_2
            assert(v4, "This function should only be called on the server.")
            local v5 = require(v_u_1.Services.DataService)
            local v6 = v5.Get(p3, "Gamepasses")
            if not v6 then
                return {
                    ["success"] = false
                }
            end
            if not table.find(v6, "Quick Open") then
                table.insert(v6, "Quick Open")
                v5.UpdatePlayerProfileField(p3, "Gamepasses", v6)
            end
            return {
                ["success"] = true
            }
        end
    }
}
return table.freeze(v7)