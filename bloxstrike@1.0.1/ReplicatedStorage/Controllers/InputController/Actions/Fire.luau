local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local v_u_4 = game:GetService("UserInputService")
require(script.Parent.Parent.Types)
local v_u_5 = v3.LocalPlayer
local v_u_6 = require(v1.Controllers.InventoryController)
local v_u_7 = require(v1.Controllers.SpectateController)
local v_u_8 = require(v1.Controllers.CaseSceneController)
local v_u_9 = require(v1.Controllers.InspectController)
local v_u_10 = require(v1.Controllers.HintController)
local v_u_11 = require(v1.Database.Security.Router)
local v_u_12 = require(v1.Database.Components.GameState)
local v13 = require(v1.Components.Common.GetUserPlatform)
local v_u_14 = table.find(v13(), "Mobile")
if v_u_14 then
    v_u_14 = #v13() <= 1
end
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = false
local function v_u_19(p18)
    if p18.KeyCode and p18.KeyCode ~= Enum.KeyCode.Unknown then
        return p18.KeyCode
    elseif p18.UserInputType == Enum.UserInputType.MouseButton1 or (p18.UserInputType == Enum.UserInputType.MouseButton2 or p18.UserInputType == Enum.UserInputType.MouseButton3) then
        return p18.UserInputType
    else
        return nil
    end
end
local function v_u_21(p20)
    return (p20 == Enum.UserInputType.Gamepad1 or (p20 == Enum.UserInputType.Gamepad2 or (p20 == Enum.UserInputType.Gamepad3 or (p20 == Enum.UserInputType.Gamepad4 or (p20 == Enum.UserInputType.Gamepad5 or (p20 == Enum.UserInputType.Gamepad6 or p20 == Enum.UserInputType.Gamepad7)))))) and true or p20 == Enum.UserInputType.Gamepad8
end
local function v_u_27(p22)
    local v23 = p22.KeyCode
    if v23 ~= Enum.KeyCode.ButtonR2 and v23 ~= Enum.KeyCode.ButtonL2 then
        return false
    end
    local v24 = p22.UserInputType
    if not v_u_21(v24) then
        return false
    end
    local v25 = v_u_4:GetGamepadState(v24)
    for _, v26 in ipairs(v25) do
        if v26.KeyCode == v23 then
            return v26.Position.Z > 0.3
        end
    end
    return false
end
local v39 = {
    ["Name"] = "Fire",
    ["Group"] = "Default",
    ["Category"] = "Weapon Keys",
    ["Callback"] = function(p28, p29)
        if v_u_14 and p29.UserInputType == Enum.UserInputType.MouseButton1 then
            return
        elseif v_u_5:GetAttribute("IsPlayerChatting") then
            return
        elseif v_u_5:GetAttribute("IsSpectating") and p28 == Enum.UserInputState.Begin then
            v_u_7.Previous()
            return
        elseif v_u_7.IsLocalPlayerDead() then
            if p28 == Enum.UserInputState.End then
                v_u_17 = false
            end
            return
        elseif v_u_8.IsActive() or v_u_9.IsActive() then
            if p28 == Enum.UserInputState.End then
                v_u_17 = false
            end
            return
        else
            local v_u_30 = v_u_6.getCurrentEquipped()
            if v_u_30 and v_u_5.Character then
                if v_u_12.GetState() == "Buy Period" then
                    if p28 == Enum.UserInputState.End then
                        v_u_17 = false
                    end
                else
                    v_u_11.broadcastRouter("Cancel Defuse Bomb")
                    if p28 == Enum.UserInputState.Begin then
                        local v31 = v_u_21(p29.UserInputType)
                        if v31 then
                            v31 = p29.KeyCode == Enum.KeyCode.ButtonR2 and true or p29.KeyCode == Enum.KeyCode.ButtonL2
                        end
                        if v31 and (v_u_17 and (v_u_30.Properties.Class == "Weapon" and not v_u_30.Properties.Automatic)) then
                            return
                        end
                        if v31 then
                            v_u_17 = true
                        end
                        local v32 = v_u_30.Properties.Class
                        local v33 = v_u_30.Properties.Slot
                        if v32 == "C4" then
                            v_u_30:shoot()
                            return
                        end
                        if v33 == "Grenade" then
                            v_u_30:StartThrow()
                            return
                        end
                        if v32 == "Weapon" then
                            v_u_30.IsFireHeld = true
                            v_u_30.FireInputBinding = v_u_19(p29)
                        end
                        local v34 = not v_u_30.IsBurstShooting and (not v_u_30.IsShooting and v_u_30.Properties.FireRate)
                        if v34 then
                            v34 = tick() - v_u_30.AlternativeSwitchTick > v_u_30.Properties.FireRate
                        end
                        if v34 then
                            if v_u_15 then
                                task.cancel(v_u_15)
                                v_u_15 = nil
                                v_u_16 = nil
                            end
                            local v35 = v_u_30.AlternativeShootingOption == "Burst" and 3 or 1
                            v_u_30.IsBurstShooting = v35 == 3
                            for _ = 1, v35 do
                                v_u_30:shoot()
                                if v_u_30.Rounds and v_u_30.Rounds <= 0 then
                                    v_u_10:createHint("Reload")
                                end
                                task.wait(0.075)
                            end
                            task.wait(0.15)
                            if v_u_30 and v_u_30.IsBurstShooting then
                                v_u_30.IsBurstShooting = false
                                return
                            end
                        elseif not v_u_30.Properties.Automatic and (v_u_30.AlternativeShootingOption == "Default" and (v_u_30.IsShooting and v_u_16 ~= v_u_30.Identifier)) then
                            if v_u_15 then
                                task.cancel(v_u_15)
                            end
                            local v36 = (v_u_30.Properties.FireRate or 0.15) - (tick() - v_u_30.ShootRequestTick)
                            local v37 = math.max(0, v36)
                            if v37 <= 0.15 then
                                v_u_16 = v_u_30.Identifier
                                v_u_15 = task.delay(v37, function()
                                    v_u_2.Heartbeat:Wait()
                                    v_u_2.Heartbeat:Wait()
                                    v_u_15 = nil
                                    v_u_16 = nil
                                    local v38 = v_u_6.getCurrentEquipped()
                                    if v38 then
                                        if v38.Identifier == v_u_30.Identifier then
                                            if v38.Properties.Automatic then
                                                return
                                            elseif v38.AlternativeShootingOption == "Burst" then
                                                return
                                            elseif v38.Rounds <= 0 then
                                                v_u_10:createHint("Reload")
                                            else
                                                v38:shoot()
                                            end
                                        else
                                            return
                                        end
                                    else
                                        return
                                    end
                                end)
                                return
                            end
                        end
                    else
                        if p28 == Enum.UserInputState.End and v_u_30.Properties.Class == "Weapon" then
                            v_u_17 = false
                            v_u_30.IsFireHeld = false
                            v_u_30.FireInputBinding = nil
                            return
                        end
                        if p28 == Enum.UserInputState.End and v_u_30.Properties.Class == "C4" then
                            if not v_u_27(p29) then
                                v_u_17 = false
                                v_u_30:cancel()
                            end
                        end
                        if v_u_30.Properties.Slot == "Grenade" and p28 == Enum.UserInputState.End then
                            v_u_17 = false
                            if v_u_30.ThrowStarted and not v_u_30.ThrowFinished then
                                v_u_30:Throw("Far")
                            end
                            return
                        end
                        if p28 == Enum.UserInputState.End then
                            v_u_17 = false
                        end
                    end
                end
            else
                if p28 == Enum.UserInputState.End then
                    v_u_17 = false
                end
                return
            end
        end
    end
}
return table.freeze(v39)