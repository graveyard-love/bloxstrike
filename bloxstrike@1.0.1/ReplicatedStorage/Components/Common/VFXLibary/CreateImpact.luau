local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("HttpService")
local v_u_3 = game:GetService("Players")
local v_u_4 = game:GetService("Debris")
require(v1.Database.Custom.Types)
local v_u_5 = require(v1.Classes.Sound)
local v_u_6 = require(v1.Shared.DebugFlags)
local v_u_7 = require(v1.Components.Common.VFXLibary.FlashEffect)
local v_u_8 = require(script.Components.Materials)
local v_u_9 = v1:WaitForChild("Assets"):WaitForChild("Impacts")
local v_u_10 = workspace:WaitForChild("Debris")
local function v_u_14(p11, p12)
    if p12 ~= "Blood Splatter" or not (p11 and p11:IsA("BasePart")) then
        return false
    end
    local v13 = string.lower(p11.Name)
    return (v13 == "head" or (v13 == "headhitbox" or (v13 == "hitboxhead" or v13 == "headhb"))) and true or string.find(v13, "head", 1, true) ~= nil
end
return function(p15, p16, p17, p18, p19, p20, p21, _, p22, p23)
    local v24 = v_u_9:FindFirstChild(v_u_8[p16] or p16)
    if v24 then
        if p15 then
            local v25 = v24.Name
            if v_u_14(p15, p16) or p23 ~= nil then
                v25 = "Headshot"
                local v26 = false
                if not p20 then
                    if p23 == nil then
                        local v27 = p15:FindFirstAncestorOfClass("Model")
                        if v27 and (v27:FindFirstChildOfClass("Humanoid") and v27:IsDescendantOf(workspace)) then
                            local v28 = v_u_3:GetPlayerFromCharacter(v27)
                            if v28 and v28:IsDescendantOf(v_u_3) then
                                local v29 = nil
                                local v_u_30 = v28:GetAttribute("Armor")
                                local v31
                                if typeof(v_u_30) == "string" and v_u_30 ~= "" then
                                    local v32
                                    v32, v31 = pcall(function()
                                        return v_u_2:JSONDecode(v_u_30)
                                    end)
                                    if v32 then
                                        if typeof(v31) ~= "table" then
                                            v31 = v29
                                        end
                                    else
                                        v31 = v29
                                    end
                                else
                                    v31 = v29
                                end
                                if v31 == nil then
                                    v26 = false
                                else
                                    v26 = v31.Type == "Kevlar + Helmet"
                                end
                            end
                        end
                    else
                        v26 = p23 == true
                    end
                end
                if v26 then
                    v24 = v_u_9:FindFirstChild("Helmet Headshot") or v24
                    v25 = "Helmet Headshot"
                end
            end
            if p19 then
                if v_u_6.IsEnabled("WeaponFX") then
                    warn(("[WeaponFX][Client][ImpactSound] skipped (exit shot) material=%s pos=%s"):format(tostring(p16), (tostring(p17))))
                end
            else
                local v33 = v_u_7.IsFlashed()
                local v34 = v33 and 0 or 1
                if v_u_6.IsEnabled("WeaponFX") then
                    warn(("[WeaponFX][Client][ImpactSound] play material=%s sound=%s pos=%s flashed=%s exit=%s melee=%s volumeMult=%s"):format(tostring(p16), tostring(v25), tostring(p17), tostring(v33), tostring(p19), tostring(p20), (tostring(v34))))
                end
                v_u_5.new("Bullet"):PlaySoundAtPosition({
                    ["Position"] = p17,
                    ["Class"] = "Bullet",
                    ["Name"] = v25
                }, nil, v34, p21 == true, p22 == true)
            end
        end
        if p16 == "Blood Splatter" or not p20 then
            local v35 = v24:GetChildren()
            local v36 = v35[math.random(1, #v35)]:Clone()
            v36.CollisionGroup = "Debris"
            v36.CanCollide = false
            v36.CanQuery = false
            v36.CanTouch = false
            v36.Anchored = true
            v36.CFrame = CFrame.new(p17, p17 + p18) + p18 * 0.1
            v36.Parent = v_u_10
            v36.Transparency = 1
            for _, v_u_37 in ipairs(v36:GetDescendants()) do
                if v_u_37:IsA("ParticleEmitter") then
                    task.delay(v_u_37:GetAttribute("EmitDelay") or 0, function()
                        v_u_37:Emit(v_u_37:GetAttribute("EmitCount") or 1)
                    end)
                end
            end
            v_u_4:AddItem(v36, 5)
        end
    end
end