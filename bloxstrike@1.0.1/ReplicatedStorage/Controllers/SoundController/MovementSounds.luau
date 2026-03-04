local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_4 = v3.LocalPlayer
local v_u_5 = require(v2.Classes.Sound)
local v_u_6 = require(v2.Shared.Janitor)
local v_u_7 = require(v2.Database.Security.Router)
local v_u_8 = require(v2.Components.Common.VFXLibary.CreateImpact.Components.Materials)
local v_u_9 = require(v2.Components.Common.GetRayIgnore)
local v_u_10 = require(v2.Components.Common.VFXLibary.FlashEffect)
local v_u_11 = {
    ["Concrete"] = "LandingConcrete",
    ["Brick"] = "LandingConcrete",
    ["Cobblestone"] = "LandingConcrete",
    ["Basalt"] = "LandingConcrete",
    ["Limestone"] = "LandingConcrete",
    ["Pavement"] = "LandingConcrete",
    ["Asphalt"] = "LandingConcrete",
    ["Rock"] = "LandingConcrete",
    ["Slate"] = "LandingConcrete",
    ["Granite"] = "LandingConcrete",
    ["Marble"] = "LandingConcrete",
    ["Pebble"] = "LandingConcrete",
    ["CeramicTiles"] = "LandingConcrete",
    ["Ground"] = "LandingDirt",
    ["Mud"] = "LandingDirt",
    ["Glass"] = "LandingGlass",
    ["Gravel"] = "LandingGravel",
    ["Rubber"] = "LandingRubber",
    ["Plastic"] = "LandingRubber",
    ["Sand"] = "LandingSand",
    ["Snow"] = "LandingSand",
    ["Grass"] = "LandingGrass",
    ["LeafyGrass"] = "LandingGrass",
    ["Metal"] = "LandingMetal",
    ["DiamondPlate"] = "LandingMetal",
    ["CorrodedMetal"] = "LandingMetal",
    ["Corroded Metal"] = "LandingMetal",
    ["Wood"] = "LandingConcrete",
    ["WoodPlanks"] = "LandingConcrete",
    ["Fabric"] = "LandingDirt",
    ["Carpet"] = "LandingDirt",
    ["Cardboard"] = "LandingDirt"
}
local v_u_12 = nil
local v_u_13 = RaycastParams.new()
v_u_13.FilterType = Enum.RaycastFilterType.Exclude
v_u_13.IgnoreWater = true
local function v_u_21(p14, p15, _)
    local v16 = v_u_9()
    if not table.find(v16, p14) then
        table.insert(v16, p14)
    end
    v_u_13.FilterDescendantsInstances = v16
    local v17 = p15.Position
    for _, v18 in ipairs({
        Vector3.new(0, 0, 0),
        Vector3.new(0.8, 0, 0),
        Vector3.new(-0.8, 0, 0),
        Vector3.new(0, 0, 0.8),
        Vector3.new(0, 0, -0.8)
    }) do
        local v19 = v17 + v18
        local v20 = workspace:Raycast(v19, Vector3.new(0, -3.1, 0), v_u_13)
        if v20 and v20.Normal.Y > 0.7 then
            return v20.Material.Name
        end
    end
    return "Air"
end
local function v_u_26(p22, p23, p24)
    if not v_u_12 or (p23 == "" or p23 == "Air") then
        return nil
    end
    local v25 = v_u_8[p23] or "Ground"
    if not v_u_12.Sounds or v_u_12.Sounds:FindFirstChild(v25) then
        return v_u_12:play({
            ["Parent"] = p22,
            ["Name"] = v25
        }, p24)
    end
    warn(string.format("[FloorSound] Missing sound for category: \'%s\' (material: %s)", v25, p23))
    return nil
end
function v_u_1.SetCharacter(p_u_27, p28)
    p_u_27.Janitor:Cleanup()
    if p28 then
        local v29 = p28:WaitForChild("HumanoidRootPart", 5)
        local v30 = p28:FindFirstChildOfClass("Humanoid")
        if not v30 then
            local v31 = tick()
            repeat
                task.wait(0.1)
                v30 = p28:FindFirstChildOfClass("Humanoid")
            until v30 or tick() - v31 > 5
        end
        if v30 and (v29 and p28.Parent) then
            p_u_27.PrimaryPart = v29
            p_u_27.Humanoid = v30
            p_u_27.Character = p28
            p_u_27.TimePassed = 0.25
            p_u_27.Janitor:Add(v30.StateChanged:Connect(function(p32, p33)
                p_u_27:OnStateChanged(p32, p33)
            end))
        end
    else
        local v34 = p_u_27.CurrentFootstepSound
        if v34 and v34.Playing then
            v34:Stop()
        end
        p_u_27.CurrentFootstepSound = nil
        p_u_27.PrimaryPart = nil
        p_u_27.TimePassed = 0.25
        p_u_27.Character = nil
        p_u_27.Humanoid = nil
        return
    end
end
function v_u_1.OnStateChanged(p35, p36, p37)
    local v38 = p35.PrimaryPart
    local v39 = p35.Character
    local v40 = p35.Humanoid
    if v40 and (v38 and v39) then
        if p37 == Enum.HumanoidStateType.Jumping or p37 == Enum.HumanoidStateType.Freefall then
            local v41 = p35.CurrentFootstepSound
            if v41 and v41.Playing then
                v41:Stop()
            end
            p35.CurrentFootstepSound = nil
        end
        local v42 = tick()
        if v42 - p35.LastFloorSoundTime < 0.1 then
            return
        elseif p36 == Enum.HumanoidStateType.Freefall or p37 == Enum.HumanoidStateType.Landed then
            p35.LastFloorSoundTime = v42
            local v43 = p35.Player:GetAttribute("IsCrouching")
            local v44 = v_u_21(v39, v38, v40)
            local v45 = (v43 and 0.4 or 1) * (p35.IsLocalPlayer and v_u_10.GetAudioFadeMultiplier() or 1)
            v_u_26(v38, v_u_11[v44] or "LandingConcrete", v45)
            if p35.IsLocalPlayer then
                v_u_7.broadcastRouter("UpdatePlayerNoiseCone", "Landing", v38.Position, v44, v43)
            end
        elseif p37 == Enum.HumanoidStateType.Jumping then
            p35.LastFloorSoundTime = v42
            local v46 = p35.Player:GetAttribute("IsCrouching")
            local v47 = v_u_21(v39, v38, v40)
            local v48 = (v46 and 0.4 or 1) * (p35.IsLocalPlayer and v_u_10.GetAudioFadeMultiplier() or 1)
            v_u_26(v38, "Jump", v48)
            v_u_26(v38, v47, v48)
            if p35.IsLocalPlayer then
                v_u_7.broadcastRouter("UpdatePlayerNoiseCone", "Jump", v38.Position, v47, v46)
            end
        end
    else
        warn("[FloorSound] Character validation failed in OnStateChanged")
        return
    end
end
function v_u_1.Update(p49, p50, p51)
    local v52 = p49.PrimaryPart
    local v53 = p49.Character
    local v54 = p49.Humanoid
    local v55 = p49.Player
    if v52 and (v53 and (v53.Parent and (v54 and v54.Health > 0))) then
        if p51 and not p49.IsLocalPlayer then
            local v56 = v52.Position.X - p51.X
            local v57 = v52.Position.Y - p51.Y
            local v58 = v52.Position.Z - p51.Z
            if v56 * v56 + v57 * v57 + v58 * v58 > 5625 then
                return
            end
        end
        local v59 = v55:GetAttribute("IsCrouching")
        if v55:GetAttribute("IsWalking") or v59 then
            return
        elseif not p49.IsLocalPlayer or v55:GetAttribute("IsSniperScoped") ~= true then
            local v60 = v59 and 3.5 or 7.5
            local v61 = v59 and 0.55 or 0.3
            p49.TimePassed = p49.TimePassed + p50
            if v61 <= p49.TimePassed then
                p49.TimePassed = p49.TimePassed - v61
                local v62 = tick()
                if v62 - p49.LastFloorSoundTime < 0.1 then
                    return
                end
                local v63 = v52.AssemblyLinearVelocity
                if v60 <= (v63.X * v63.X + v63.Z * v63.Z) ^ 0.5 then
                    p49.LastFloorSoundTime = v62
                    local v64 = v_u_21(v53, v52, v54)
                    p49.CurrentFootstepSound = v_u_26(v52, v64, (v59 and 0.4 or 1) * (p49.IsLocalPlayer and v_u_10.GetAudioFadeMultiplier() or 1))
                    if p49.IsLocalPlayer then
                        v_u_7.broadcastRouter("UpdatePlayerNoiseCone", "Footstep", v52.Position, v64, v59)
                    end
                end
            end
        end
    else
        return
    end
end
function v_u_1.new(p65)
    local v66 = v_u_1
    local v67 = setmetatable({}, v66)
    v67.Janitor = v_u_6.new()
    v67.IsLocalPlayer = p65 == v_u_4
    v67.Player = p65
    v67.PrimaryPart = nil
    v67.Character = nil
    v67.Humanoid = nil
    v67.TimePassed = 0.25
    v67.CurrentFootstepSound = nil
    v67.LastFloorSoundTime = 0
    if not v_u_12 then
        v_u_12 = v_u_5.new("FloorSounds")
    end
    return v67
end
function v_u_1.Destroy(p68)
    p68.Janitor:Destroy()
end
return v_u_1