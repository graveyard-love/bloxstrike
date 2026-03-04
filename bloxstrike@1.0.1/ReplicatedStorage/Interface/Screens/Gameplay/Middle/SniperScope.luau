local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = v4.LocalPlayer
local v_u_6 = require(v2.Controllers.CharacterController)
local v_u_7 = require(v2.Controllers.InventoryController)
local v_u_8 = require(v2.Controllers.SpectateController)
local v9 = require(v2.Shared.Spring)
local v_u_10 = v9.new(1, 2.5, 1)
local v_u_11 = v9.new(0.85, 0.5, Vector2.zero)
local v_u_12 = Enum.HumanoidStateType.None
local v_u_13 = 0
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
function v_u_1.toggle(p17)
    v_u_14.Visible = p17
    v_u_14.Blur.Visible = true
    local v18 = p17 and 3 or 1
    local v19 = p17 and 4 or 2
    if v_u_15 and v_u_15.Parent then
        v_u_15.ZIndex = v18
    end
    if v_u_16 and v_u_16.Parent then
        v_u_16.ZIndex = v19
    end
    if p17 then
        v_u_10:setPosition(1)
        v_u_10:setGoal(0)
        v_u_13 = tick()
    else
        v_u_13 = 0
    end
end
function v_u_1.updateMovementSharpness(p20, p21)
    local v22
    if p20.PrimaryPart then
        local v23 = p20.PrimaryPart.AssemblyLinearVelocity.X
        local v24 = p20.PrimaryPart.AssemblyLinearVelocity.Z
        v22 = Vector3.new(v23, 0, v24).Magnitude or 0
    else
        v22 = 0
    end
    local v25 = math.min(v22, 3) / 3
    local v26 = v_u_7.getCurrentEquipped()
    local v27 = v26 and v26.Properties
    if v27 then
        if v26.Properties.AimingOptions == "SniperScope" and (v26.Properties.MuzzleType == "Sniper" and (v26.Properties.Spread.Range.Min == 0 and v26.Properties.Spread.PerShot == 0)) then
            v27 = v26.Properties.Spread.MovementMultiplier == 2
        else
            v27 = false
        end
    end
    local v28 = false
    if v27 then
        local v29 = p20:FindFirstChildOfClass("Humanoid")
        local v30
        if v29 then
            local v31 = v29:GetState()
            v30 = v31 == Enum.HumanoidStateType.Jumping or v31 == Enum.HumanoidStateType.Freefall
        else
            v30 = false
        end
        if v30 and p20.PrimaryPart then
            local v32 = p20.PrimaryPart.AssemblyLinearVelocity.Y
            v28 = math.abs(v32) <= 3
        end
    end
    if p21 then
        v_u_10:setPosition(1)
        v_u_10:setGoal(0)
        v_u_13 = tick()
        return
    else
        local v33 = p20:FindFirstChildOfClass("Humanoid")
        local v34
        if v33 then
            local v35 = v33:GetState()
            v34 = v35 == Enum.HumanoidStateType.Jumping or v35 == Enum.HumanoidStateType.Freefall
        else
            v34 = false
        end
        if v34 then
            if v27 and v28 then
                v_u_10:setPosition(0)
                v_u_10:setGoal(0)
            else
                v_u_10:setPosition(1)
            end
        elseif v25 > 0.1 then
            v_u_10:setPosition(v25)
        elseif tick() - v_u_13 > 1.2 then
            v_u_10:reset(0)
        end
    end
end
function v_u_1.updateScope(p36, _)
    local v37 = p36:FindFirstChildOfClass("Humanoid")
    if v37 then
        if v37 and v37.Health > 0 then
            local v38 = v37:GetState()
            local v39
            if v_u_12 == Enum.HumanoidStateType.Freefall or v_u_12 == Enum.HumanoidStateType.Jumping then
                v39 = v38 == Enum.HumanoidStateType.Running and true or v38 == Enum.HumanoidStateType.Landed
            else
                v39 = false
            end
            v_u_1.updateMovementSharpness(p36, v39)
            v_u_12 = v38
            local v40
            if p36.PrimaryPart then
                local v41 = p36.PrimaryPart.AssemblyLinearVelocity.X
                local v42 = p36.PrimaryPart.AssemblyLinearVelocity.Z
                v40 = Vector3.new(v41, 0, v42).Magnitude or 0
            else
                v40 = 0
            end
            if v40 > 0.1 then
                local v43
                if p36.PrimaryPart then
                    local v44 = p36.PrimaryPart.AssemblyLinearVelocity.X
                    local v45 = p36.PrimaryPart.AssemblyLinearVelocity.Z
                    v43 = Vector3.new(v44, 0, v45).Magnitude or 0
                else
                    v43 = 0
                end
                local v46 = math.min(v43, 3)
                local v47 = v_u_6.GetCrouchState() and 0.5 or (v_u_6.GetWalkState() and 0.75 or 1)
                local v48 = Vector2.new
                local v49 = tick() * 3.141592653589793 * 1.75 * v47
                local v50 = math.sin(v49)
                local v51 = tick() * 3.141592653589793 * 2.75 * v47
                v_u_11:setPosition(v48(v50, (math.sin(v51))) * v46 * 1.5)
                local v52 = v_u_11:getPosition()
                v_u_14.Position = UDim2.new(0.5, v52.X, 0.5, v52.Y)
            else
                v_u_11:reset(Vector2.zero)
                v_u_14.Position = UDim2.fromScale(0.5, 0.5)
            end
            v_u_14.Blur.ImageTransparency = 1 - v_u_10:getPosition()
            v_u_14.Sharp.ImageTransparency = v_u_10:getPosition()
        end
    end
end
function v_u_1.Initialize(_, p53)
    v_u_14 = p53
    local v54 = p53.Parent
    if v54 then
        v54 = p53.Parent.Parent
    end
    if v54 then
        v_u_15 = v54:FindFirstChild("Bottom")
        v_u_16 = v54:FindFirstChild("Top")
        if v_u_15 then
            v_u_15.ZIndex = 1
        end
        if v_u_16 then
            v_u_16.ZIndex = 2
        end
    end
    v_u_3.RenderStepped:Connect(function(p55)
        local v56 = v_u_5:GetAttribute("IsSpectating") == true
        local v57 = v_u_5.Character
        local v58
        if v57 then
            v58 = v57:FindFirstChild("Humanoid")
        else
            v58 = v57
        end
        if v56 then
            v58 = v56
        elseif v57 then
            if v58 then
                v58 = v58.Health > 0
            end
        else
            v58 = v57
        end
        if v58 then
            local v59 = v_u_7.getCurrentEquipped()
            local v60 = v_u_8.GetCurrentSpectateInstance()
            local v61 = false
            if v56 and v60 then
                if v60.CurrentEquipped then
                    local v62 = v60.CurrentEquipped.Name
                    if (v62 == "AWP" and true or v62 == "SSG 08") and v60.PerspectiveState == "First-Person" then
                        v61 = (v60.Player:GetAttribute("ScopeIncrement") or 0) > 0
                        v57 = v60.Character
                    end
                end
            else
                v61 = v59 and v59.IsAiming
                if v61 then
                    v61 = v59.Properties.AimingOptions == "SniperScope"
                end
            end
            v_u_10:update(p55)
            v_u_11:update(p55)
            if v61 and v57 then
                v_u_1.updateScope(v57, p55)
                if not v_u_14.Visible then
                    v_u_1.toggle(true)
                end
            elseif v_u_14.Visible then
                v_u_1.toggle(false)
            end
        elseif v_u_14.Visible then
            v_u_1.toggle(false)
        end
        if not v_u_14.Visible then
            if v_u_15 and v_u_15.Parent then
                v_u_15.ZIndex = 1
            end
            if v_u_16 and v_u_16.Parent then
                v_u_16.ZIndex = 2
            end
        end
    end)
end
return v_u_1