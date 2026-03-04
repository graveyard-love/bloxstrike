local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("Debris")
require(v1.Database.Custom.Types)
local v_u_4 = require(v1.Shared.DebugFlags)
local v_u_5 = require(v1.Components.Common.GetWeaponProperties)
local v_u_6 = v1:WaitForChild("Assets"):WaitForChild("MuzzleFlashes")
local v_u_7 = workspace:WaitForChild("Debris")
function executeMuzzleFlash(p8, p9, p10)
    local v11 = v_u_5(p9)
    if v11 then
        local v12 = p10 or v11.MuzzleType
        if not v12 then
            return nil
        end
        local v13 = v_u_6.Character:FindFirstChild(v12)
        local v14
        if v13 then
            v14 = v13:Clone()
            v14.CollisionGroup = "Debris"
            v14.CanCollide = false
            v14.CanQuery = false
            v14.CanTouch = false
            v14.Anchored = false
        else
            v14 = nil
        end
        if v14 then
            v14.CFrame = p8.CFrame
            v14.Parent = v_u_7
            local v15 = Instance.new("WeldConstraint")
            v15.Part0 = p8
            v15.Part1 = v14
            v15.Parent = v14
            for _, v_u_16 in ipairs(v14:GetDescendants()) do
                if v_u_16:IsA("ParticleEmitter") then
                    task.delay(v_u_16:GetAttribute("EmitDelay") or 0, function()
                        v_u_16:Emit(v_u_16:GetAttribute("EmitCount") or 1)
                    end)
                end
            end
            v_u_3:AddItem(v14, 5)
            return p8.Position
        end
    end
    return nil
end
local function v_u_18(p17, ...)
    if v_u_4.IsEnabled("WeaponFX") then
        warn(("[WeaponFX][MuzzleFlash.Character] " .. p17):format(...))
    end
end
local function v_u_35(p_u_19, p_u_20, p_u_21, p_u_22, p_u_23)
    local v24 = v_u_2:FindFirstChild(p_u_19)
    if v24 then
        local v25 = v_u_5(p_u_20)
        if v25 then
            if v24.Character then
                local v26 = v_u_7:FindFirstChild(v24.Name .. "_Weapon")
                if v26 then
                    local v27 = v26:FindFirstChild("Interactables")
                    if v27 then
                        local v28 = v27:FindFirstChild("MuzzlePart")
                        if v25.ShootingOptions == "Dual" then
                            v28 = v27:FindFirstChild("MuzzlePart" .. (p_u_21 == "Left" and "L" or "R"))
                        end
                        if v28 then
                            if not executeMuzzleFlash(v28, p_u_20, p_u_22) then
                                v_u_18("executeMuzzleFlash failed player=%s weapon=%s override=%s attempt=%d", v24.Name, tostring(p_u_20), tostring(p_u_22), p_u_23)
                            end
                        else
                            v_u_18("missing muzzle part player=%s weapon=%s shootingHand=%s attempt=%d", v24.Name, tostring(p_u_20), tostring(p_u_21), p_u_23)
                        end
                    else
                        if p_u_23 < 3 then
                            task.delay(0.05, function()
                                v_u_35(p_u_19, p_u_20, p_u_21, p_u_22, p_u_23 + 1)
                            end)
                        end
                        local v29 = v_u_18
                        local v30 = v24.Name
                        local v31 = p_u_23 < 3
                        v29("missing Interactables on %s_Weapon (retry=%s) player=%s weapon=%s attempt=%d", v30, tostring(v31), v24.Name, tostring(p_u_20), p_u_23)
                        return
                    end
                else
                    if p_u_23 < 3 then
                        task.delay(0.05, function()
                            v_u_35(p_u_19, p_u_20, p_u_21, p_u_22, p_u_23 + 1)
                        end)
                    end
                    local v32 = v_u_18
                    local v33 = v24.Name
                    local v34 = p_u_23 < 3
                    v32("missing %s_Weapon in Debris (retry=%s) player=%s weapon=%s attempt=%d", v33, tostring(v34), v24.Name, tostring(p_u_20), p_u_23)
                    return
                end
            else
                v_u_18("character missing player=%s weapon=%s attempt=%d", v24.Name, tostring(p_u_20), p_u_23)
                return
            end
        else
            v_u_18("weapon properties missing player=%s weapon=%s attempt=%d", v24.Name, tostring(p_u_20), p_u_23)
            return
        end
    else
        v_u_18("player not found username=%s weapon=%s attempt=%d", tostring(p_u_19), tostring(p_u_20), p_u_23)
        return
    end
end
return function(p36, p37, p38, p39)
    v_u_35(p36, p37, p38, p39, 0)
end