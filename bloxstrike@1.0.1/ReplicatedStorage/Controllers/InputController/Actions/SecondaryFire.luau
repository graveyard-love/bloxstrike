local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = v2.LocalPlayer
local v_u_4 = require(v1.Controllers.InventoryController)
local v_u_5 = require(v1.Controllers.SpectateController)
local v_u_6 = require(v1.Controllers.CaseSceneController)
local v_u_7 = require(v1.Controllers.InspectController)
local v_u_8 = require(v1.Database.Components.GameState)
local v_u_9 = {
    ["ToggleScope"] = true
}
return table.freeze({
    ["Name"] = "Secondary Fire",
    ["Group"] = "Default",
    ["Category"] = "Weapon Keys",
    ["Callback"] = function(p10, _)
        if v_u_3:GetAttribute("IsSpectating") and p10 == Enum.UserInputState.Begin then
            v_u_5.Next()
            return
        elseif v_u_5.IsLocalPlayerDead() then
            return
        elseif v_u_6.IsActive() or v_u_7.IsActive() then
            return
        else
            local v11 = v_u_4.getCurrentEquipped()
            if v_u_3.Character and v11 then
                if not v11 or (v11.Properties.Slot ~= "Grenade" or v_u_8.GetState() ~= "Buy Period") then
                    if p10 == Enum.UserInputState.Begin then
                        if v11.Properties.Class == "Grenade" then
                            if v_u_8.GetState() ~= "Buy Period" then
                                v11:StartThrow()
                                return
                            end
                        else
                            if v11.Properties.HasScope then
                                v11:scope(v_u_9.ToggleScope)
                                return
                            end
                            if v11.Properties.HasSuppressor then
                                if v11.IsSuppressed then
                                    v11:removeSuppressor()
                                else
                                    v11:addSuppressor()
                                end
                            end
                            if v11.Properties.ShootingOptions == "Burst" then
                                v11:updateFireMode()
                                return
                            end
                            if v11.Properties.Type == "Equipment" and v_u_8.GetState() ~= "Buy Period" then
                                v11:shoot(true)
                                return
                            end
                        end
                    else
                        if v11.Properties.HasScope and (not v_u_9.ToggleScope and p10 == Enum.UserInputState.End) then
                            v11:unscope()
                            return
                        end
                        if v11.Properties.Slot == "Grenade" and p10 == Enum.UserInputState.End then
                            if v_u_8.GetState() == "Buy Period" then
                                return
                            end
                            if v11.ThrowStarted and not v11.ThrowFinished then
                                v11:Throw("Near")
                            end
                        end
                    end
                end
            else
                return
            end
        end
    end
})