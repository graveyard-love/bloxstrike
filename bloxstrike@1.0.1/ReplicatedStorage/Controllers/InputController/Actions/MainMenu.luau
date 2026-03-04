local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = require(v1.Shared.CloseButtonRegistry)
local v_u_4 = v2.LocalPlayer
local v_u_5 = require(v1.Interface.Screens.Menu.Top)
return table.freeze({
    ["Name"] = "Main Menu",
    ["Group"] = "Default",
    ["Category"] = "UI Keys",
    ["Callback"] = function(p6, p7)
        if v_u_4:GetAttribute("IsPlayerChatting") then
            return
        elseif p7.KeyCode == Enum.KeyCode.ButtonB and (v_u_3.CloseFrame() or v_u_3.IsDoublePressed()) then
            return
        else
            local v8 = v_u_4:GetAttribute("IsSpectating")
            local v9 = v_u_4:GetAttribute("Team")
            if (v9 == "Counter-Terrorists" or v9 == "Terrorists") and true or v8 == true then
                if p6 == Enum.UserInputState.Begin then
                    v_u_5.ToggleMenu()
                end
            else
                return
            end
        end
    end
})