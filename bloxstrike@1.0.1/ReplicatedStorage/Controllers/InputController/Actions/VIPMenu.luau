local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = v2.LocalPlayer
local v_u_4 = nil
local v_u_5 = 0
local v11 = {
    ["Name"] = "VIP Menu",
    ["Group"] = "Default",
    ["Category"] = "UI Keys",
    ["BindPriority"] = Enum.ContextActionPriority.High.Value + 1,
    ["Callback"] = function(p6, _)
        if p6 == Enum.UserInputState.Begin then
            local v7 = os.clock()
            if v7 - v_u_5 < 0.15 then
                return
            else
                v_u_5 = v7
                if not v_u_3:GetAttribute("IsPlayerChatting") then
                    local v8
                    if v_u_4 then
                        v8 = v_u_4
                    else
                        local v9, v10 = pcall(function()
                            return require(v_u_1.Interface.Screens.Gameplay.Middle.VIPMenu)
                        end)
                        if v9 then
                            v_u_4 = v10
                            v8 = v_u_4
                        else
                            warn((("Failed to load VIPMenu module: %*"):format((tostring(v10)))))
                            v8 = nil
                        end
                    end
                    if v8 then
                        v8.toggleFrame()
                    end
                end
            end
        else
            return
        end
    end
}
return table.freeze(v11)