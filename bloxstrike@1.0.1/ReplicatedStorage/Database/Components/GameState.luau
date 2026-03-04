local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
require(script:WaitForChild("Types"))
local v_u_3 = require(v1.Packages.Observers)
local v_u_4 = {
    "Map Voting",
    "Game Ending",
    "Warmup",
    "Round In Progress",
    "Buy Period",
    "Intermission"
}
return {
    ["GetState"] = function()
        return workspace:GetAttribute("GameState")
    end,
    ["SetState"] = function(p5)
        local v6 = v_u_2:IsServer()
        assert(v6, "This method is only available to the server.")
        local v7 = table.find(v_u_4, p5)
        local v8 = ("\"%*\" is not a valid state!"):format(p5)
        assert(v7, v8)
        if true then
            workspace:SetAttribute("GameState", p5)
        end
    end,
    ["ListenToState"] = function(p_u_9)
        local v_u_10 = nil
        return v_u_3.observeAttribute(workspace, "GameState", function(p11)
            p_u_9(v_u_10, p11)
            v_u_10 = p11
        end)
    end
}