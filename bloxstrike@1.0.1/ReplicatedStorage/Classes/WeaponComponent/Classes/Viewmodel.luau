local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("ReplicatedFirst")
local v_u_4 = game:GetService("HttpService")
local v_u_5 = game:GetService("RunService")
require(script:WaitForChild("Types"))
local v_u_6 = require(v_u_2.Controllers.DataController)
local v_u_7 = require(v_u_2.Database.Components.Common.AttachGlovesToViewmodel)
local v_u_8 = require(v_u_2.Database.Components.Libraries.Skins)
local v_u_9 = require(v_u_2.Classes.Sound)
local v_u_10 = require(v_u_2.Shared.Janitor)
local v_u_11 = require(v_u_2.Database.Security.Router)
local v_u_12 = require(script.Classes.Animation)
local v_u_13 = require(script.Classes.Bobble)
local v_u_14 = workspace.CurrentCamera
local function v_u_22(p15, p16)
    local v17 = p15:GetDescendants()
    for _, v18 in ipairs(v17) do
        if v18:IsA("BasePart") then
            local v19 = v18:GetAttribute("HiddenTransparency")
            if p16 then
                local v20 = v18.Transparency
                v18.Transparency = 1
                if not v19 then
                    v18:SetAttribute("HiddenTransparency", v20)
                end
            elseif v19 then
                v18.Transparency = v19
            end
        elseif v18:IsA("Texture") then
            if p16 then
                if v18.Transparency < 1 then
                    v18:SetAttribute("HiddenTransparency", v18.Transparency)
                    v18.Transparency = 1
                end
            else
                local v21 = v18:GetAttribute("HiddenTransparency")
                if v21 ~= nil then
                    v18.Transparency = v21
                    v18:SetAttribute("HiddenTransparency", nil)
                end
            end
        end
    end
end
local function v_u_26(p23, p24)
    for _, v25 in pairs(p23:GetDescendants()) do
        if v25:IsA("MeshPart") then
            v25.Transparency = p24 == true and 0 or 1
        elseif v25:IsA("SurfaceGui") then
            v25.Enabled = p24
        end
    end
end
local function v_u_30(p27)
    for _, v28 in ipairs({
        "Weapon",
        "WeaponL",
        "WeaponR",
        "CharmBase"
    }) do
        local v29 = p27:FindFirstChild(v28)
        if v29 then
            v29:Destroy()
        end
    end
end
function v_u_1.aim(p31)
    if p31.Bobble then
        p31.Bobble:setIsAiming(true)
    end
    v_u_26(p31.Bobble.Scope, true)
    v_u_26(p31.Bobble.ScopeReticlePart, true)
    if p31.MuzzlePartWeld then
        local v32 = v_u_14.CFrame
        local v33 = p31.Model.WorldPivot
        local v34 = v32 + v32.UpVector * -0.5 + v33.LookVector * 1 + v33.RightVector * 0.1
        local v35 = p31.MuzzlePartWeld
        p31.MuzzlePartWeld.C0 = v35.Part0.CFrame:Inverse() * v34
    end
end
function v_u_1.unaim(p36)
    if p36.Bobble then
        p36.Bobble:setIsAiming(false)
    end
    v_u_26(p36.Bobble.Scope, false)
    v_u_26(p36.Bobble.ScopeReticlePart, false)
    if p36.OriginalC0 and p36.MuzzlePartWeld then
        p36.MuzzlePartWeld.C0 = p36.OriginalC0
    end
end
function v_u_1.unhide(p37)
    if p37.Hidden then
        v_u_22(p37.Model, false)
        p37.Hidden = false
    end
end
function v_u_1.hide(p38)
    if not p38.Hidden then
        v_u_22(p38.Model, true)
        p38.Hidden = true
    end
end
function v_u_1.equip(p39, p40)
    p39.IsEquipped = true
    if p39.Model then
        p39.Model.Parent = v_u_14
        if p39.LargeWeaponModel then
            p39.LargeWeaponModel.Parent = v_u_14
        end
        p39.Animation:stopAnimations()
        p39.Animation:play("Idle")
        if p39.Hidden then
            p39:unhide()
        end
        if not p40 then
            p39.Animation:play("Equip")
        end
    end
end
function v_u_1.unequip(p41)
    p41.IsEquipped = false
    p41.Animation:stopAnimations()
    if p41.Model then
        p41.Model.Parent = nil
    end
    if p41.LargeWeaponModel then
        p41.LargeWeaponModel.Parent = nil
    end
end
function v_u_1.applyCharmImpulse(p42, p43)
    if p42.LargeCharmModel and p42.LargeCharmModel.PrimaryPart then
        local v44 = 0
        for _, v45 in ipairs(p42.LargeCharmModel:GetDescendants()) do
            if v45:IsA("BasePart") then
                v44 = v44 + v45:GetMass()
            end
        end
        p42.LargeCharmModel.PrimaryPart:ApplyImpulse(p43 * 10 * v44)
    end
end
function v_u_1.render(p46, p47)
    if p46.Model and p46.Model:FindFirstChild("Stats") then
        local v48 = v_u_6.Get(p46.Player, "Settings.Game.Viewmodel") or {}
        if p46.Bobble and (p46.Bobble.Character and p46.Bobble.Character.PrimaryPart) then
            local v49, v50, v51 = p46.Bobble:getNextCFrame(p47)
            local v52 = (v48["X Offset"] or 0) / 100
            local v53 = (v48["Y Offset"] or 0) / 100
            local v54 = (v48["Z Offset"] or 0) / 100
            local v55 = v_u_14.CFrame * v49 * CFrame.Angles(p46.Model.Stats.Rotation.Value.X, p46.Model.Stats.Rotation.Value.Y, p46.Model.Stats.Rotation.Value.Z) * CFrame.new(p46.Model.Stats.Default.Value) * CFrame.new(v52, v53, v54)
            p46.Model:PivotTo(v55)
            if p46.LargeWeaponModel and p46.SmallWeaponModel then
                p46.LargeWeaponModel:PivotTo(p46.SmallWeaponModel:GetPivot())
                local v56 = p46.Model.WorldPivot.Position
                if p46.LastViewmodelPosition then
                    local v57 = v56 - p46.LastViewmodelPosition
                    if p46.LargeCharmModel and p46.LargeCharmModel.PrimaryPart then
                        p46:applyCharmImpulse(-v57 * 0.2)
                    end
                end
                p46.LastViewmodelPosition = v56
            end
            if p46.Bobble.Scope and p46.Bobble.IsAiming then
                local v58 = v_u_14.CFrame
                local v59 = v51.X * -v58.LookVector + v51.Y * -v58.UpVector
                p46.Bobble.Scope:PivotTo(v58 + v58.LookVector * 0.15 + v50 + v59)
                if p46.Bobble.ScopeReticlePart then
                    p46.Bobble.ScopeReticlePart.CFrame = v58 * CFrame.Angles(1.5707963267948966, 1.5707963267948966, -1.5707963267948966) + v58.LookVector * 0.15
                end
            end
        end
    end
end
function v_u_1.attachSleeves(p60, p61)
    local v62 = v_u_2.Assets.Sleeves:FindFirstChild(p61)
    if v62 then
        for _, v63 in ipairs(v62:GetChildren()) do
            local v64 = p60.Model:FindFirstChild(v63.Name)
            if v64 then
                local v65 = v63:Clone()
                v65.CastShadow = false
                v65.CanCollide = false
                v65.CanTouch = false
                v65.Anchored = false
                v65.CanQuery = false
                v65.Name = "Sleeve"
                local v66 = v64.Size.X * 1.3
                local v67 = v64.Size.Y * 1.4
                local v68 = v64.Size.Z * 0.79
                v65.Size = Vector3.new(v66, v67, v68)
                local v69 = v64.Size.Z / 2 - v65.Size.Z / 2
                local v70 = CFrame.new(0, -0.02, -v69)
                v65.Parent = v64
                local v71 = Instance.new("Motor6D", v65)
                v71.Part0 = v64
                v71.Part1 = v65
                v71.C0 = CFrame.identity
                v71.C1 = v70
            end
        end
    end
end
function v_u_1.addAttachments(p72, p73)
    local v74 = nil
    local v75 = nil
    local v76 = nil
    if type(p73) == "string" then
        local v77 = v_u_11.broadcastRouter("GetInventoryItemFromIdentifier", p72.Player, p73)
        if v77 then
            v74 = v77.Name
            v75 = v77.Skin
            v76 = v77.Float
        end
    elseif type(p73) == "table" then
        local v78 = p73.SkinIdentifier
        if type(v78) == "string" and v78 ~= "" then
            local v79 = v_u_11.broadcastRouter("GetInventoryItemFromIdentifier", p72.Player, v78)
            if v79 then
                v74 = v79.Name
                v75 = v79.Skin
                v76 = v79.Float
            end
        end
        if not v74 then
            local v80 = p73.Name
            if type(v80) == "string" then
                local v81 = p73.Skin
                if type(v81) == "string" then
                    v74 = p73.Name
                    v75 = p73.Skin
                    local v82 = p73.Float
                    if typeof(v82) == "number" then
                        v76 = p73.Float
                    else
                        v76 = nil
                    end
                end
            end
        end
    end
    if v74 and v75 then
        local v83 = v_u_8.GetGloves(v74, v75, v76)
        if v83 then
            v_u_7(v83:GetChildren(), p72.Model)
            if p72.Team == "Counter-Terrorists" then
                p72:attachSleeves((workspace:GetAttribute("CTCharacter")))
            end
        end
    else
        return
    end
end
function v_u_1.construct(p84, p85, _)
    if p84.ModelJanitor then
        p84.ModelJanitor:Destroy()
    end
    p84.ModelJanitor = v_u_10.new()
    p84.CharmModel = nil
    p84.LargeWeaponModel = nil
    p84.SmallWeaponModel = nil
    p84.LargeCharmModel = nil
    p84.LastViewmodelPosition = nil
    if p84.Animation then
        p84.Animation:stopAnimations()
    end
    if p84.Model then
        p84.Model:Destroy()
        p84.Model = nil
    end
    local v86 = p84.CameraModelWeapon or p84.Weapon
    local v87 = nil
    local v88
    if v86 == "Smoke Grenade" then
        v88 = p84.Team
        if v88 ~= "Counter-Terrorists" and v88 ~= "Terrorists" then
            v88 = v87
        end
    else
        v88 = v87
    end
    p84.Model = v_u_8.GetCameraModel(v86, p84.Skin, p84.Float, p84.StatTrack, p84.NameTag, p84.Charm, p84.Stickers, v88)
    if not p84.Model and p84.HideWeaponGeometry then
        p84.Model = v_u_8.GetBaseWeaponModel(v86, "Camera")
    end
    if not p84.Model then
        error((("Viewmodel.construct: Failed to get camera model for weapon \"%*\" with skin \"%*\""):format(v86, p84.Skin)))
    end
    p84.Model.Parent = v_u_3
    p84.Model.Name = v86
    if p84.HideWeaponGeometry then
        v_u_30(p84.Model)
    end
    local v_u_89 = p85:GetAttribute("EquippedGloves")
    if type(v_u_89) == "string" and v_u_89 ~= "" then
        local v90, v91 = pcall(function()
            return v_u_4:JSONDecode(v_u_89)
        end)
        if v90 and v91 then
            p84:addAttachments(v91)
        else
            p84:addAttachments(v_u_89)
        end
    end
    for _, v92 in ipairs(p84.Model:GetDescendants()) do
        if v92:IsA("BasePart") then
            v92.CollisionGroup = "Viewmodel"
            v92.CanCollide = false
            v92.CastShadow = false
            v92.CanQuery = true
            v92.CanTouch = false
            if v92.Name == "HumanoidRootPart" or v92.Name == "ViewmodelLight" then
                v92.Transparency = 1
            end
        end
    end
    local v93 = p85:FindFirstChild("Body Colors")
    local v94 = nil
    if v93 then
        v94 = v93.TorsoColor3
    else
        local v95 = p85:FindFirstChild("Torso") or p85:FindFirstChild("UpperTorso")
        if v95 and v95:IsA("BasePart") then
            v94 = v95.Color
        end
    end
    if v94 then
        for _, v96 in ipairs({ "Right Arm", "Left Arm" }) do
            local v97 = p84.Model:FindFirstChild(v96)
            if v97 and v97:IsA("BasePart") then
                v97.Color = v94
            end
        end
    end
    local v98 = p84.Model:FindFirstChild("Interactables")
    local v99 = not v98 or v98:FindFirstChild("MuzzlePart", true) or (v98:FindFirstChild("MuzzlePartL", true) or v98:FindFirstChild("MuzzlePartR", true))
    p84.MuzzlePart = v99
    if v98 then
        p84.MuzzlePartL = v98:FindFirstChild("MuzzlePartL", true)
        p84.MuzzlePartR = v98:FindFirstChild("MuzzlePartR", true)
        if p84.MuzzlePartL and p84.MuzzlePartL:IsA("BasePart") then
            p84.MuzzlePartL.Transparency = 1
        end
        if p84.MuzzlePartR and p84.MuzzlePartR:IsA("BasePart") then
            p84.MuzzlePartR.Transparency = 1
        end
    end
    if p84.MuzzlePart and p84.MuzzlePart:IsA("BasePart") then
        p84.MuzzlePart.Transparency = 1
    end
    if p84.MuzzlePart and not p84.MuzzlePart:FindFirstChild("WeldConstraint", true) then
        local v100 = p84.Model:GetDescendants()
        for _, v101 in ipairs(v100) do
            if v101:IsA("Weld") and (v101.Part1 == v99 or v101.Part0 == v99) then
                p84.MuzzlePartWeld = v101
                p84.OriginalC0 = v101.C0
                break
            end
        end
    end
    p84.Model:ScaleTo(0.1)
    local v102 = p84.Model:FindFirstChild("CharmBase", true)
    if v102 and v102:IsA("Model") then
        local v103 = v102:FindFirstChildOfClass("Model")
        if v103 and v103.PrimaryPart then
            p84.CharmModel = v103
        end
    end
    if p84.CharmModel then
        p84:setupCharmPhysics()
    end
    if p84.Animation then
        p84.Animation:setModel(p84.Model)
    end
    if p84.Bobble then
        p84.Bobble:setModel(p84.Model)
    end
    if p84.IsEquipped then
        p84:equip(false)
    else
        p84:unequip()
    end
end
function v_u_1.setupCharmPhysics(p_u_104)
    if p_u_104.CharmModel then
        local v105 = p_u_104.CharmModel.Parent
        p_u_104.CharmModel:PivotTo(v105.PrimaryPart.CFrame * CFrame.new(0, 0, -1))
        local v_u_106 = p_u_104.CharmModel
        local v_u_107 = p_u_104.Model:FindFirstChild("Weapon") or (p_u_104.Model:FindFirstChild("WeaponL") or p_u_104.Model:FindFirstChild("WeaponR"))
        if v_u_107 then
            local v_u_108 = v_u_107.Parent:Clone()
            v_u_108.Parent = v_u_14
            local v_u_109 = v_u_108:FindFirstChild("Weapon") or (p_u_104.Model:FindFirstChild("WeaponL") or p_u_104.Model:FindFirstChild("WeaponR"))
            for _, v110 in v_u_108:GetChildren() do
                if v110.Name ~= "Weapon" and (v110.Name ~= "WeaponL" and (v110.Name ~= "WeaponR" and v110.Name ~= "CharmBase")) then
                    v110:Destroy()
                end
            end
            for _, v111 in ipairs(v_u_108:GetDescendants()) do
                if v111.Name == "ViewmodelLight" then
                    v111:Destroy()
                end
            end
            v_u_108:ScaleTo(1)
            v_u_108:PivotTo(v_u_107.Parent:GetPivot())
            v_u_109.PrimaryPart.Anchored = true
            local v112 = v_u_108:GetBoundingBox()
            if v_u_108.PrimaryPart then
                v_u_108.PrimaryPart.PivotOffset = v_u_108.PrimaryPart.CFrame:ToObjectSpace(v112)
            else
                v_u_108.WorldPivot = v112
            end
            v_u_108.PrimaryPart = v_u_109.PrimaryPart
            for _, v113 in ipairs(v_u_108:GetDescendants()) do
                if v113:IsA("BasePart") then
                    v113.Transparency = 1
                    v113.CanCollide = true
                elseif v113:IsA("Decal") or (v113:IsA("Texture") or v113:IsA("Beam")) then
                    v113.Transparency = 1
                elseif v113:IsA("SurfaceGui") then
                    v113.Enabled = false
                elseif v113:IsA("ParticleEmitter") then
                    v113.Enabled = false
                end
            end
            local v114 = v_u_108:FindFirstChild("CharmBase", true)
            local v115
            if v114 and v114:IsA("Model") then
                v115 = v114:FindFirstChildOfClass("Model")
                if v115 then
                    for _, v116 in ipairs(v115:GetDescendants()) do
                        if v116:IsA("BasePart") then
                            v116.CanCollide = true
                            v116.CollisionGroup = "Charm"
                        end
                    end
                end
            else
                v115 = nil
            end
            p_u_104.LargeWeaponModel = v_u_109.Parent
            p_u_104.SmallWeaponModel = v_u_107
            p_u_104.LargeCharmModel = v115
            if v115 and (v_u_106 and p_u_104.ModelJanitor) then
                p_u_104.ModelJanitor:Add(v_u_5.PostSimulation:Connect(function()
                    local v117 = p_u_104.LargeCharmModel
                    local v118 = v_u_106
                    if v117 and v118 then
                        if v117.PrimaryPart and v118.PrimaryPart then
                            local v119 = v_u_109:GetPivot():ToObjectSpace((v117:GetPivot()))
                            local v120 = CFrame.new(v119.Position / 10) * CFrame.fromOrientation(v119:ToOrientation())
                            v118:PivotTo(v_u_107:GetPivot() * v120)
                        end
                    else
                        return
                    end
                end))
            end
            if p_u_104.CharmModel.PrimaryPart then
                p_u_104.CharmModel.PrimaryPart.Anchored = true
            end
            if p_u_104.ModelJanitor then
                p_u_104.ModelJanitor:Add(function()
                    if v_u_108 then
                        v_u_108:Destroy()
                    end
                    p_u_104.LargeWeaponModel = nil
                    p_u_104.SmallWeaponModel = nil
                    p_u_104.LargeCharmModel = nil
                end)
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.new(p_u_121, p122, p123)
    local v124 = v_u_1
    local v_u_125 = setmetatable({}, v124)
    v_u_125.Janitor = v_u_10.new()
    v_u_125.ModelJanitor = v_u_10.new()
    v_u_125.IsDestroyed = false
    v_u_125.Player = p_u_121.Player
    v_u_125.Team = v_u_125.Player:GetAttribute("Team")
    v_u_125.Weapon = p122
    v_u_125.CameraModelWeapon = p_u_121.ViewmodelCameraWeapon or p122
    v_u_125.HideWeaponGeometry = p_u_121.ViewmodelHideWeaponGeometry == true
    v_u_125.Skin = p123
    v_u_125.StatTrack = p_u_121.StatTrack
    v_u_125.Stickers = p_u_121.Stickers
    v_u_125.NameTag = p_u_121.NameTag
    v_u_125.Float = p_u_121.Float
    v_u_125.Charm = p_u_121.Charm
    v_u_125.Hidden = false
    v_u_125.IsEquipped = false
    v_u_125.Sound = v_u_9.new(v_u_125.CameraModelWeapon)
    v_u_125.Animation = v_u_12.new(v_u_125, v_u_125.Player, nil, v_u_125.Sound)
    v_u_125.Bobble = v_u_13.new(p_u_121, nil)
    local v126 = not p_u_121.Character and v_u_125.Player
    if v126 then
        v126 = v_u_125.Player.Character
    end
    if v126 then
        v_u_125:construct(v126, p_u_121)
    end
    v_u_125.Janitor:Add(v_u_125.Player.CharacterAdded:Connect(function(p127)
        v_u_125:construct(p127, p_u_121)
    end))
    v_u_125.Janitor:Add(function()
        if v_u_125.Animation then
            v_u_125.Animation:destroy()
            v_u_125.Animation = nil
        end
    end)
    v_u_125.Janitor:Add(function()
        if v_u_125.Bobble then
            v_u_125.Bobble:destroy()
            v_u_125.Bobble = nil
        end
    end)
    v_u_125.Janitor:Add(function()
        if v_u_125.Sound then
            v_u_125.Sound:destroy()
            v_u_125.Sound = nil
        end
    end)
    v_u_125.Janitor:Add(function()
        if v_u_125.ModelJanitor then
            v_u_125.ModelJanitor:Destroy()
            v_u_125.ModelJanitor = nil
        end
    end)
    return v_u_125
end
function v_u_1.destroy(p128)
    if not p128.IsDestroyed then
        p128.IsDestroyed = true
        if p128.Animation then
            p128.Animation:stopAnimations()
        end
        if p128.Animation then
            p128.Animation:destroy()
            p128.Animation = nil
        end
        if p128.Bobble then
            p128.Bobble:destroy()
            p128.Bobble = nil
        end
        if p128.Sound then
            p128.Sound:destroy()
            p128.Sound = nil
        end
        if p128.Model then
            p128.Model.Parent = nil
            p128.Model:Destroy()
            p128.Model = nil
        end
        if p128.Janitor then
            p128.Janitor:Destroy()
            p128.Janitor = nil
        end
        p128.StatTrack = nil
        p128.Stickers = nil
        p128.NameTag = nil
        p128.Player = nil
        p128.Weapon = nil
        p128.Float = nil
        p128.Charm = nil
        p128.Skin = nil
        p128.Team = nil
        p128.MuzzlePartWeld = nil
        p128.MuzzlePartL = nil
        p128.MuzzlePartR = nil
        p128.MuzzlePart = nil
        p128.OriginalC0 = nil
        p128.CharmModel = nil
        p128.ScaledCollisionModel = nil
        p128.LargeCharmModel = nil
        p128.LargeWeaponModel = nil
    end
end
return v_u_1