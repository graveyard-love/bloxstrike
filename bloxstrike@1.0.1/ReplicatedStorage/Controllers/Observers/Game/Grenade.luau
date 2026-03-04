local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
game:GetService("UserInputService")
require(script:WaitForChild("Types"))
local v_u_4 = v3.LocalPlayer
local v5 = require(v_u_1.Packages.Observers)
local v_u_6 = require(v_u_1.Shared.Janitor)
local v7 = require(v_u_1.Database.Security.Remotes)
local v_u_8 = require(v_u_1.Shared.GrenadeSimulator)
local v_u_9 = workspace:WaitForChild("Debris")
local v_u_10 = {}
for _, v11 in ipairs(script.Executions:GetChildren()) do
    v_u_10[v11.Name] = require(v11)
end
local v_u_12 = {}
local function v_u_18(p13, p14)
    local v15 = RaycastParams.new()
    v15.FilterType = Enum.RaycastFilterType.Exclude
    local v16 = { p13, v_u_9 }
    if v_u_4 and v_u_4.Character then
        local v17 = v_u_4.Character
        table.insert(v16, v17)
    end
    v15.FilterDescendantsInstances = v16
    v15.RespectCanCollide = false
    v15.IgnoreWater = true
    if p14 then
        v15.CollisionGroup = p14
    end
    return v15
end
local function v_u_23(p19, p20, p21)
    local v22 = (p19.state.position - p20).Magnitude
    if v22 > 8 then
        p19.state.position = p20
        p19.state.velocity = p21
        p19.visualPosition = p20
    elseif v22 > 2 then
        p19.state.position = p19.state.position:Lerp(p20, 0.08)
        p19.state.velocity = p19.state.velocity:Lerp(p21, 0.08)
    end
end
v7.Projectile.Spawn.Listen(function(p_u_24)
    local v_u_25 = p_u_24.Id
    local v_u_26 = p_u_24.State
    local v_u_27 = p_u_24.Physics
    task.defer(function()
        local v28 = v_u_1.Assets.Weapons:FindFirstChild(p_u_24.Weapon)
        if v28 then
            v28 = v28:FindFirstChild("Character")
        end
        if v28 then
            local v29 = v28:Clone()
            v29.Name = v_u_25
            v29:PivotTo(CFrame.new(v_u_26.Position))
            v29:SetAttribute("GrenadeName", p_u_24.Weapon)
            v29:AddTag("Grenade")
            v29.Parent = v_u_9
            for _, v30 in v29:GetDescendants() do
                if v30:IsA("BasePart") then
                    v30.Anchored = true
                    v30.CanCollide = false
                end
            end
            local v31 = v_u_6.new()
            v31:Add(v29, "Destroy")
            print("[CLIENT] Received grenade spawn - IsJumpThrow raw:", v_u_26.IsJumpThrow, "parsed as:", v_u_26.IsJumpThrow == 1)
            local v32 = {
                ["position"] = v_u_26.Position,
                ["velocity"] = v_u_26.Velocity,
                ["angularVelocity"] = Vector3.new(0, 0, 0),
                ["timestamp"] = v_u_26.StartTime or workspace:GetServerTimeNow(),
                ["simulationTime"] = 0,
                ["bounceCount"] = 0,
                ["isGrounded"] = false,
                ["isAtRest"] = false,
                ["hasTouched"] = false,
                ["accumulatedTime"] = 0,
                ["isJumpThrow"] = v_u_26.IsJumpThrow or false
            }
            local v33 = {
                ["radius"] = v_u_27.Radius,
                ["restitution"] = v_u_27.Restitution,
                ["maxBounces"] = v_u_27.MaxBounces
            }
            local v34
            if v_u_27.FuseTime > 0 then
                v34 = v_u_27.FuseTime
            else
                v34 = nil
            end
            v33.fuseTime = v34
            v33.minimumFuseTime = nil
            v33.explodeOnFloorImpact = nil
            v33.rangeScale = 1
            v33.isNearThrow = false
            local v35 = v_u_26.Velocity
            local v36
            if v35.Magnitude > 1 then
                local v37 = v35:Cross(Vector3.new(0, 1, 0))
                v36 = (v37.Magnitude <= 0.1 and Vector3.new(1, 0, 0) or v37.Unit) * v35.Magnitude * 0.5
            else
                v36 = Vector3.new(0, 0, 0)
            end
            local v_u_38 = {
                ["id"] = v_u_25,
                ["model"] = v29,
                ["state"] = v32,
                ["config"] = v33,
                ["raycastParams"] = v_u_18(v29, v_u_27.CollisionGroup),
                ["visualPosition"] = v_u_26.Position,
                ["visualRotation"] = CFrame.identity,
                ["angularVelocity"] = v36,
                ["isResolved"] = false,
                ["janitor"] = v31
            }
            v_u_12[v_u_25] = v_u_38
            local v_u_39 = nil
            v_u_39 = v_u_2.RenderStepped:Connect(function(p40)
                if v_u_38.isResolved then
                    v_u_39:Disconnect()
                    return
                elseif v_u_38.model.Parent then
                    v_u_38.state = v_u_8.simulate(v_u_38.state, v_u_38.config, v_u_38.raycastParams, p40).state
                    local v41 = p40 * 20
                    local v42 = math.min(1, v41)
                    v_u_38.visualPosition = v_u_38.visualPosition:Lerp(v_u_38.state.position, v42)
                    local v43 = v_u_38.state.velocity.Magnitude
                    if v43 < 2 then
                        local v44 = v_u_38
                        local v45 = v_u_38.angularVelocity
                        local v46 = 1 - p40 * 8
                        v44.angularVelocity = v45 * math.max(0, v46)
                    elseif v43 < 5 then
                        local v47 = v_u_38
                        local v48 = v_u_38.angularVelocity
                        local v49 = 1 - p40 * 3
                        v47.angularVelocity = v48 * math.max(0, v49)
                    end
                    if v_u_38.angularVelocity.Magnitude > 0.01 then
                        local v50 = v_u_38.angularVelocity
                        local v51 = v50.Magnitude * p40
                        local v52 = v50.Unit
                        local v53 = CFrame.fromAxisAngle(v52, v51)
                        v_u_38.visualRotation = v_u_38.visualRotation * v53
                    end
                    if v_u_38.model.PrimaryPart then
                        v_u_38.model:PivotTo(CFrame.new(v_u_38.visualPosition) * v_u_38.visualRotation)
                    end
                else
                    v_u_39:Disconnect()
                    v_u_38.isResolved = true
                end
            end)
            v_u_38.janitor:Add(v_u_39, "Disconnect")
        else
            warn("[Client Grenade] Base model not found for:", p_u_24.Weapon)
        end
    end)
end)
v7.Projectile.Bounce.Listen(function(p54)
    local v55 = v_u_12[p54.Id]
    if v55 then
        v_u_23(v55, p54.Position, p54.Velocity)
        v55.state.bounceCount = p54.BounceIndex
        v55.state.hasTouched = true
        local v56 = v55.state.velocity
        local v57 = p54.Velocity
        local v58 = v57 - v56
        if v58.Magnitude > 1 then
            local v59 = v58:Cross(v57)
            local v60
            if v59.Magnitude > 0.1 then
                v60 = v59.Unit
            else
                local v61 = v57:Cross(Vector3.new(0, 1, 0))
                v60 = v61.Magnitude <= 0.1 and Vector3.new(1, 0, 0) or v61.Unit
            end
            local v62 = v60 * v58.Magnitude * 0.5
            v55.angularVelocity = v55.angularVelocity + v62
        end
    end
end)
v7.Projectile.Resolve.Listen(function(p63)
    local v64 = v_u_12[p63.Id]
    if v64 then
        v64.state.position = p63.Position
        v64.state.isAtRest = true
        v64.isResolved = true
        v64.angularVelocity = Vector3.new(0, 0, 0)
        if v64.model.PrimaryPart then
            v64.model:PivotTo(CFrame.new(p63.Position) * v64.visualRotation)
        end
        v64.model:SetAttribute("SimulationFinished", true)
        v_u_12[p63.Id] = nil
    end
end)
return v5.observeTag("Grenade", function(p_u_65)
    local v66 = p_u_65:GetAttribute("GrenadeName")
    if v66 then
        local v_u_67 = v_u_10[v66]
        local v_u_68 = v_u_6.new()
        v_u_68:Add(p_u_65:GetAttributeChangedSignal("SimulationFinished"):Connect(function()
            local v69 = p_u_65.PrimaryPart
            if v69 and p_u_65:GetAttribute("SimulationFinished") then
                if v_u_67 then
                    v_u_67(v_u_68, v69.Position, p_u_65)
                    return
                end
                for _, v70 in p_u_65:GetDescendants() do
                    if v70:IsA("BasePart") then
                        v70.Transparency = 1
                        v70.CanCollide = false
                    end
                end
                task.delay(0.5, function()
                    if p_u_65 and p_u_65.Parent then
                        p_u_65:Destroy()
                    end
                end)
            end
        end))
        return function()
            local v71 = p_u_65.Name
            if v_u_12[v71] then
                v_u_12[v71].isResolved = true
                v_u_12[v71] = nil
            end
            v_u_68:Destroy()
        end
    end
end)