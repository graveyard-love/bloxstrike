local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = v2.LocalPlayer
local v_u_4 = require(v1.Controllers.InventoryController)
local v_u_5 = require(v1.Controllers.SpectateController)
local v_u_6 = require(v1.Database.Components.Libraries.Skins)
local v_u_7 = require(v1.Database.Custom.GameStats.Rarities)
local v_u_8 = require(v1.Database.Security.Router)
return table.freeze({
    ["Name"] = "Drop Weapon",
    ["Group"] = "Gameplay",
    ["Category"] = "Weapon Keys",
    ["Callback"] = function(p9, _)
        if v_u_3:GetAttribute("IsPlayerChatting") then
            return
        elseif p9 == Enum.UserInputState.Begin then
            if v_u_5.IsLocalPlayerDead() then
                return
            else
                local v10 = v_u_4.getCurrentEquipped()
                if v10 then
                    local v11 = v_u_6.GetSkinInformation(v10.Name, v10.Skin)
                    if v11 then
                        local v12 = v_u_7[v11.rarity]
                        local v13 = v12.Color.R * 255
                        local v14 = math.floor(v13)
                        local v15 = v12.Color.G * 255
                        local v16 = math.floor(v15)
                        local v17 = v12.Color.B * 255
                        local v18 = math.floor(v17)
                        if v10:drop() then
                            v_u_8.broadcastRouter("CreateNotification", "Item Dropped", ("You dropped your <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v14, v16, v18, v10.Name, v10.Skin), 2)
                            return
                        end
                    end
                end
            end
        else
            return
        end
    end
})