local v1 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_2 = v1.LocalPlayer
return table.freeze({
    ["Name"] = "Toggle Inventory Display",
    ["Group"] = "Gameplay",
    ["Category"] = "Movement Keys",
    ["Callback"] = function(_, _)
        if not v_u_2:GetAttribute("IsPlayerChatting") then
        end
    end
})