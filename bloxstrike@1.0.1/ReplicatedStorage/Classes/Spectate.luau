local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
game:GetService("RunService")
local v4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = v4.LocalPlayer
local v_u_6 = require(v2.Controllers.CameraController)
local v_u_7 = require(v2.Controllers.DataController)
local v_u_8 = require(v2.Database.Custom.Constants)
local v_u_9 = require(v2.Database.Components.Common.RemoveFromArray)
local v_u_10 = require(v2.Components.Common.VFXLibary.CreateMuzzleFlash.Camera)
local v_u_11 = require(v2.Components.Common.VFXLibary.CreateTracer)
local v_u_12 = require(v2.Classes.WeaponComponent)
local v_u_13 = require(v2.Classes.Freecam)
local v_u_14 = require(v2.Components.Weapon.Classes.Bullet)
local v_u_15 = require(v2.Shared.Janitor)
local v_u_16 = require(v2.Packages.Signal)
local v_u_17 = require(v2.Shared.Spring)
local v_u_18 = require(v2.Packages.Sift)
local v_u_19 = require(v2.Database.Security.Remotes)
local v_u_20 = workspace:WaitForChild("Characters")
local v_u_21 = workspace:WaitForChild("Debris")
local v_u_22 = workspace.CurrentCamera
local v_u_23 = RaycastParams.new()
v_u_23.FilterType = Enum.RaycastFilterType.Exclude
v_u_23.IgnoreWater = true
local v_u_24 = {
    ["Heavy Swing"] = true,
    ["BackStab"] = true,
    ["Swing1"] = true,
    ["Swing2"] = true,
    ["Inspect"] = true,
    ["Reload"] = true,
    ["Throw"] = true,
    ["Use"] = true
}
local v_u_25 = {
    ["NoSuppressorShoot"] = true,
    ["ShootRight"] = true,
    ["ShootLeft"] = true,
    ["Shoot"] = true
}
local function v_u_34(p26, p27)
    if p27:IsA("BasePart") then
        local v28 = p26.Transparencies[p27] or {
            ["Transparency"] = p27.Transparency,
            ["Textures"] = {}
        }
        for _, v29 in ipairs(p27:GetChildren()) do
            if v29:IsA("Texture") and not table.find(v28.Textures, v29) then
                local v30 = v28.Textures
                table.insert(v30, v29)
                v29.Parent = nil
            end
        end
        if p27.Transparency < 1 then
            p27.Transparency = 1
        end
        p26.Transparencies[p27] = v28
    elseif p27:IsA("Texture") then
        local v31 = p27.Parent
        if v31 and v31:IsA("BasePart") then
            local v32 = p26.Transparencies[v31] or {
                ["Transparency"] = v31.Transparency,
                ["Textures"] = {}
            }
            if not table.find(v32.Textures, p27) then
                local v33 = v32.Textures
                table.insert(v33, p27)
            end
            p27.Parent = nil
            p26.Transparencies[v31] = v32
            return
        end
    elseif p27:IsA("BillboardGui") then
        p27.Enabled = false
    end
end
function v_u_1.UpdateCameraCFrame(p35, p36)
    if not (p35.CameraPositionSpring and p35.CameraRotationSpring) then
        p35.CameraRotationSpring = v_u_17.new(1, 35, p36.LookVector)
        p35.CameraPositionSpring = v_u_17.new(1, 35, p36.Position)
    end
    p35.CameraRotationSpring:setGoal(p36.LookVector)
    p35.CameraPositionSpring:setGoal(p36.Position)
end
function v_u_1.UpdateSuppressorState(p37, p38)
    local v39 = p38.Viewmodel.Model:FindFirstChild("Silencer", true)
    if v39 and p38.Properties.HasSuppressor then
        v39.Transparency = p37.CurrentEquipped.IsSuppressed and 0 or 1
    end
end
function v_u_1.UpdateSuppressor(p40)
    if p40.WeaponComponent and p40.WeaponComponent.Viewmodel then
        local v_u_41 = p40.WeaponComponent.Viewmodel.Model:FindFirstChild("Silencer", true)
        if v_u_41 then
            local v44 = table.freeze({
                {
                    ["AnimationTrack"] = p40.WeaponComponent.Viewmodel.Animation:getAnimation("RemoveSuppressor"),
                    ["State"] = false,
                    ["Event"] = function(p42)
                        return p42:GetMarkerReachedSignal("ScrewOnEnd"):Connect(function()
                            v_u_41.Transparency = 1
                        end)
                    end
                },
                {
                    ["AnimationTrack"] = p40.WeaponComponent.Viewmodel.Animation:getAnimation("AddSuppressor"),
                    ["State"] = true,
                    ["Event"] = function(p_u_43)
                        return p_u_43:GetPropertyChangedSignal("IsPlaying"):Connect(function()
                            if p_u_43.IsPlaying then
                                task.delay(0.016666666666666666, function()
                                    v_u_41.Transparency = 0
                                end)
                            end
                        end)
                    end
                }
            })
            for _, v_u_45 in ipairs(v44) do
                if p40.WeaponComponent and p40.WeaponComponent.Janitor then
                    p40.WeaponComponent.Janitor:Add(v_u_45.Event(v_u_45.AnimationTrack))
                    p40.WeaponComponent.Janitor:Add(v_u_45.AnimationTrack.Ended:Connect(function()
                        if v_u_41.Transparency < 1 == v_u_45.State then
                            v_u_41.Transparency = v_u_45.State and 0 or 1
                        end
                    end))
                end
            end
            p40:UpdateSuppressorState(p40.WeaponComponent)
        end
    else
        return
    end
end
function v_u_1.Switch(p46, p47)
    if p46.Humanoid and p46.Humanoid.Health > 0 then
        p46.PerspectiveState = p47
        if p46.FreecamInstance then
            p46.FreecamInstance:Stop()
            p46.FreecamInstance:Destroy()
            p46.FreecamInstance = nil
        end
        if p46.PerspectiveState == "First-Person" then
            p46.TransparencyState = true
            p46:SetCharacterTransparency(p46.TransparencyState)
            v_u_22.CameraType = Enum.CameraType.Scriptable
            v_u_22.CameraSubject = p46.Humanoid
            if p46.CurrentEquipped then
                p46:SetEquipped(p46.CurrentEquipped, false)
            end
            p46:UpdateScopeState()
            v_u_6.setPerspective(true, false)
        elseif p46.PerspectiveState == "Third-Person" then
            p46.TransparencyState = false
            p46:SetCharacterTransparency(p46.TransparencyState)
            v_u_22.CameraType = Enum.CameraType.Follow
            v_u_22.CameraSubject = p46.Humanoid
            if p46.WeaponComponent then
                p46.WeaponComponent.Janitor:Destroy()
                p46.WeaponComponent = nil
            end
            v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
            v_u_6.setPerspective(false, false)
        elseif p46.PerspectiveState == "Free-Cam" then
            p46.TransparencyState = false
            p46:SetCharacterTransparency(p46.TransparencyState)
            if p46.WeaponComponent then
                p46.WeaponComponent.Janitor:Destroy()
                p46.WeaponComponent = nil
            end
            v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
            if not p46.FreecamInstance then
                p46.FreecamInstance = p46.Janitor:Add(v_u_13.new())
            end
            if p46.FreecamInstance then
                p46.FreecamInstance:Start()
            end
        end
        v_u_19.Spectate.SetSpectatePerspective.Send(p46.PerspectiveState)
    end
end
function v_u_1.SetEquipped(p_u_48, p49, p50)
    local v51 = p_u_48.WeaponComponent
    if v51 then
        v51 = p_u_48.WeaponComponent.Identifier
    end
    p_u_48.CurrentEquipped = p49
    if v51 == p49.Identifier then
        p_u_48:UpdateSuppressorState(p_u_48.WeaponComponent)
    else
        if p_u_48.WeaponComponent then
            p_u_48:SetWeaponViewmodelTransparency(false)
            p_u_48.WeaponComponent.Janitor:Destroy()
            p_u_48.WeaponComponent = nil
        end
        if p_u_48.CurrentEquipped and p_u_48.PerspectiveState == "First-Person" then
            local v52, v53 = pcall(function()
                return v_u_12.new(p_u_48.Player, p_u_48.CurrentEquipped.Identifier, p_u_48.CurrentEquipped._id, 1, p_u_48.CurrentEquipped.Name, p_u_48.CurrentEquipped.Skin, p_u_48.CurrentEquipped.Float, p_u_48.CurrentEquipped.StatTrack, p_u_48.CurrentEquipped.NameTag, p_u_48.CurrentEquipped.Charm, p_u_48.CurrentEquipped.Stickers)
            end)
            if not (v52 and v53) then
                warn((("[Spectate] Failed to create viewmodel for %* (%* | %*): %*"):format(p_u_48.Player.Name, p_u_48.CurrentEquipped.Name, p_u_48.CurrentEquipped.Skin, (tostring(v53)))))
                p_u_48.TransparencyState = false
                if not pcall(function()
                    p_u_48:SetCharacterTransparency(false)
                end) then
                    warn("[Spectate] Failed to restore character transparency after viewmodel creation failure")
                end
                p_u_48:Switch("Third-Person")
                p_u_48.CurrentEquippedChanged:Fire(p_u_48.CurrentEquipped)
                return
            end
            if v53.Properties and v53.Properties.Spread then
                v53.Bullet = v_u_14.new(v53, v53.Properties)
            end
            p_u_48.WeaponComponent = v53
            p_u_48.TransparencyState = true
            p_u_48:SetCharacterTransparency(p_u_48.TransparencyState)
            if p_u_48.WeaponComponent and p_u_48.WeaponComponent.Viewmodel then
                p_u_48.WeaponComponent.Viewmodel:equip(not p50)
                if p_u_48.WeaponComponent.Properties.HasSuppressor then
                    p_u_48:UpdateSuppressor()
                end
            end
            p_u_48:UpdateScopeState()
        end
        p_u_48.CurrentEquippedChanged:Fire(p_u_48.CurrentEquipped)
    end
end
function v_u_1.UpdateScopeState(p54)
    if p54.PerspectiveState == "First-Person" then
        if p54.CurrentEquipped then
            local v55 = p54.CurrentEquipped.Name
            local v56 = v55 == "AWP" and true or v55 == "SSG 08"
            local v57 = v55 == "AUG" and true or v55 == "SG 553"
            local v58 = p54.Player:GetAttribute("ScopeIncrement") or 0
            local v59 = v58 > 0
            if v56 then
                if p54.WeaponComponent and (p54.WeaponComponent.Viewmodel and p54.WeaponComponent.Viewmodel.Bobble) then
                    local v60 = p54.WeaponComponent.Viewmodel.Bobble.ScopeReticlePart
                    local v61 = v60 and v60:FindFirstChildOfClass("SurfaceGui")
                    if v61 then
                        v61.Enabled = false
                    end
                end
                if v59 and v58 <= 2 then
                    v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV - ({ 37, 60 })[v58])
                    if p54.WeaponComponent and p54.WeaponComponent.Viewmodel then
                        p54:SetWeaponViewmodelTransparency(true)
                        return
                    end
                else
                    v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
                    if p54.WeaponComponent and p54.WeaponComponent.Viewmodel then
                        p54:SetWeaponViewmodelTransparency(false)
                        return
                    end
                end
            elseif v57 then
                local v62 = p54.WeaponComponent
                if v62 then
                    v62 = p54.WeaponComponent.Viewmodel
                end
                if v62 then
                    if v59 then
                        if not v62.Hidden then
                            v62:hide()
                        end
                        if v62.Bobble and (v62.Bobble.Scope and v62.Bobble.ScopeReticlePart) then
                            v62:aim()
                        end
                        v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV - 15)
                    else
                        if v62.Hidden then
                            v62:unhide()
                        end
                        if v62.Bobble and (v62.Bobble.Scope and v62.Bobble.ScopeReticlePart) then
                            v62:unaim()
                        end
                        v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
                    end
                end
            else
                v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
                if p54.WeaponComponent and p54.WeaponComponent.Viewmodel then
                    p54:SetWeaponViewmodelTransparency(false)
                end
            end
        end
    else
        return
    end
end
function v_u_1.SetWeaponViewmodelTransparency(p63, p64)
    if p63.WeaponComponent and (p63.WeaponComponent.Viewmodel and p63.WeaponComponent.Viewmodel.Model) then
        local v65 = p63.WeaponComponent.Viewmodel.Model
        if not p63.WeaponTransparencyCache then
            p63.WeaponTransparencyCache = {}
        end
        for _, v66 in ipairs(v65:GetDescendants()) do
            if v66:IsA("BasePart") and (v66.Name ~= "Right Arm" and (v66.Name ~= "Left Arm" and (v66.Name ~= "HumanoidRootPart" and v66.Name ~= "ViewmodelLight"))) then
                if p64 then
                    if not p63.WeaponTransparencyCache[v66] then
                        p63.WeaponTransparencyCache[v66] = v66.Transparency
                    end
                    v66.Transparency = 1
                else
                    local v67 = p63.WeaponTransparencyCache[v66]
                    if v67 ~= nil then
                        v66.Transparency = v67
                        p63.WeaponTransparencyCache[v66] = nil
                    end
                end
            end
        end
    end
end
function v_u_1.HideDebrisWeapons(p68)
    if p68.TransparencyState then
        local v69 = p68.Player.Name
        local v70 = v_u_21:FindFirstChild(v69 .. "_Weapon")
        if v70 then
            for _, v71 in ipairs(v70:GetDescendants()) do
                v_u_34(p68, v71)
            end
        end
        local v72 = v_u_21:FindFirstChild(v69 .. "_WeaponAttachments")
        if v72 then
            for _, v73 in ipairs(v72:GetDescendants()) do
                v_u_34(p68, v73)
            end
        end
    end
end
function v_u_1.SetCharacterTransparency(p_u_74, p75)
    local v76 = p_u_74.Character:GetDescendants()
    local function v_u_80(p77)
        for _, v78 in ipairs(p77:GetDescendants()) do
            v_u_34(p_u_74, v78)
        end
        if p_u_74.TransparencyJanitor then
            p_u_74.TransparencyJanitor:Add(p77.DescendantAdded:Connect(function(p79)
                if p_u_74.TransparencyState then
                    v_u_34(p_u_74, p79)
                end
            end))
        end
    end
    if p75 then
        if not p_u_74.TransparencyJanitor then
            local v81 = p_u_74.Janitor:Add(v_u_15.new())
            p_u_74.TransparencyJanitor = v81
            v81:Add(p_u_74.Character.DescendantAdded:Connect(function(p82)
                if p_u_74.TransparencyState then
                    v_u_34(p_u_74, p82)
                end
            end))
            v81:Add(v_u_21.ChildAdded:Connect(function(p83)
                if p_u_74.TransparencyState then
                    local v84 = p_u_74.Player.Name
                    if p83.Name == v84 .. "_Weapon" or p83.Name == v84 .. "_WeaponAttachments" then
                        v_u_80(p83)
                    end
                end
            end))
        end
        for _, v85 in ipairs(v76) do
            v_u_34(p_u_74, v85)
        end
        local v86 = p_u_74.Player.Name
        local v87 = v_u_21:FindFirstChild(v86 .. "_Weapon")
        if v87 then
            v_u_80(v87)
        end
        local v88 = v_u_21:FindFirstChild(v86 .. "_WeaponAttachments")
        if v88 then
            v_u_80(v88)
            return
        end
    else
        if p_u_74.TransparencyJanitor then
            p_u_74.TransparencyJanitor:Destroy()
            p_u_74.TransparencyJanitor = nil
        end
        for v_u_89, v90 in pairs(p_u_74.Transparencies) do
            if v_u_89 and v_u_89.Parent then
                v_u_89.Transparency = v90.Transparency
                v_u_9(v90.Textures, function(_, p91)
                    p91.Parent = v_u_89
                    return true
                end)
            end
        end
        for _, v92 in ipairs(v76) do
            if v92:IsA("BillboardGui") then
                v92.Enabled = true
            end
        end
    end
end
function v_u_1.AddSpectateEvent(p93, p94)
    if p93.WeaponComponent and p93.WeaponComponent.Viewmodel then
        local v95 = p93.WeaponComponent.Viewmodel
        if v95 then
            v95 = p93.WeaponComponent.Viewmodel.Animation
        end
        if v_u_25[p94] then
            v_u_23.FilterDescendantsInstances = { p93.Player.Character, v_u_22, v_u_21 }
            local v96 = p93.WeaponComponent
            if v96 and v96.Bullet then
                local v97 = v96.Properties.AimingOptions
                local v98 = v96.IsAiming
                if v96.Bullet._updateShotSpread then
                    v96.Bullet:_updateShotSpread(v97, v98)
                end
            end
            v95:stopAnimations()
            v95:play(p94)
            v95:play("Idle")
            local v99 = workspace:Raycast(v_u_22.CFrame.Position, v_u_22.CFrame.LookVector * p93.WeaponComponent.Properties.Range, v_u_23)
            local v100 = v99 and v99.Distance or p93.WeaponComponent.Properties.Range
            if p93.WeaponComponent.Viewmodel.Model.Interactables:FindFirstChild("MuzzlePart") then
                v_u_11(v100, p93.WeaponComponent.Viewmodel.Model.Interactables.MuzzlePart.Position, v_u_22.CFrame.LookVector)
                if v_u_7.Get(v_u_5, "Settings.Video.Presets.Muzzle Flash") ~= false then
                    v_u_10(p93.WeaponComponent.Viewmodel.Model.Interactables.MuzzlePart, p93.WeaponComponent.Name, p93.WeaponComponent.Properties.HasSuppressor and p93.CurrentEquipped.IsSuppressed and "Suppressor" or nil)
                    return
                end
            end
        else
            if p94 == "Remove Suppressor" or p94 == "Add Suppressor" then
                v95:stopAnimations()
                v95:play(string.gsub(p94, " ", ""))
                v95:play("Idle")
                return
            end
            if p94 == "Cancel Plant" then
                v95:stopAnimations()
                v95:play("Idle")
                return
            end
            if p94 == "Switch Fire Mode" then
                v95:stopAnimations()
                v95:play("Switch")
                v95:play("Idle")
                return
            end
            if v_u_24[p94] then
                v95:stopAnimations()
                v95:play(p94)
                v95:play("Idle")
            end
        end
    end
end
local function v_u_118(p101, p102)
    if p101.PerspectiveState == "First-Person" then
        if p101.CurrentEquipped then
            local v103 = p101.CurrentEquipped.Name
            if v103 == "AUG" and true or v103 == "SG 553" then
                if (p101.Player:GetAttribute("ScopeIncrement") or 0) > 0 then
                    if p101.WeaponComponent and p101.WeaponComponent.Viewmodel then
                        local v104 = p101.WeaponComponent.Viewmodel
                        if v104.Bobble and v104.Bobble.IsAiming then
                            local v105 = p101.WeaponComponent
                            if v105 and v105.Bullet then
                                local v106 = v105.Bullet:getBaseSpread() or 0
                                local v107 = v106 - (p101.LastSpreadValue or 0)
                                local v108 = math.abs(v107)
                                local v109 = (p101.LastScopeUpdateTime or 0) + p102
                                if v108 < 0.01 and v109 < 0.03333333333333333 then
                                    p101.LastScopeUpdateTime = v109
                                    return
                                else
                                    p101.LastScopeUpdateTime = 0
                                    p101.LastSpreadValue = v106
                                    local v110 = v104.Bobble.ScopeReticlePart
                                    if v110 then
                                        local v111 = p101.ScopeUICache
                                        if v111 and v111.SurfaceGui == v110 then
                                            local v112 = v111.Crosshair
                                            if v112 and v112.Parent then
                                                local v113 = math.clamp(v106, 0, 2) * 2
                                                v112.Size = UDim2.fromScale(v113 + 2.5, v113 + 2.5)
                                                v112.Position = UDim2.fromScale(0.5, 0.5)
                                                return
                                            end
                                            p101.ScopeUICache = nil
                                        end
                                        local v114 = v110:FindFirstChildOfClass("SurfaceGui")
                                        if v114 then
                                            local v115 = v114:FindFirstChild("Frame")
                                            if v115 then
                                                local v116 = v115:FindFirstChild("Frame")
                                                if v116 then
                                                    p101.ScopeUICache = {
                                                        ["Crosshair"] = v116,
                                                        ["SurfaceGui"] = v114,
                                                        ["Frame"] = v115
                                                    }
                                                    local v117 = math.clamp(v106, 0, 2) * 2
                                                    v116.Size = UDim2.fromScale(v117 + 2.5, v117 + 2.5)
                                                    v116.Position = UDim2.fromScale(0.5, 0.5)
                                                end
                                            else
                                                return
                                            end
                                        else
                                            return
                                        end
                                    else
                                        return
                                    end
                                end
                            else
                                return
                            end
                        else
                            return
                        end
                    else
                        return
                    end
                else
                    return
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.Render(p119, p120)
    if p119.PerspectiveState ~= "Free-Cam" then
        if p119.CameraPositionSpring and p119.CameraRotationSpring then
            p119.CameraPositionSpring:update(p120)
            p119.CameraRotationSpring:update(p120)
            if p119.PerspectiveState == "First-Person" then
                v_u_22.CFrame = CFrame.lookAt(p119.CameraPositionSpring:getPosition(), p119.CameraPositionSpring:getPosition() + p119.CameraRotationSpring:getPosition())
                if p119.WeaponComponent and p119.WeaponComponent.Viewmodel then
                    p119.WeaponComponent.Viewmodel:render(p120)
                end
                local v121 = p119.WeaponComponent
                if v121 and (v121.Bullet and v121.Bullet.updateSpread) then
                    v121.Bullet:updateSpread(p120)
                end
                v_u_118(p119, p120)
            end
        end
    end
end
function v_u_1.new(p122, p123, p124)
    local v125 = v_u_1
    local v_u_126 = setmetatable({}, v125)
    v_u_126.Janitor = v_u_15.new()
    v_u_126.CurrentEquippedChanged = v_u_126.Janitor:Add(v_u_16.new())
    v_u_126.StopSpectating = v_u_126.Janitor:Add(v_u_16.new())
    v_u_126.Humanoid = p124
    v_u_126.Character = p123
    v_u_126.Player = p122
    v_u_126.CurrentPlayerTeam = p122:GetAttribute("Team")
    v_u_126.PerspectiveState = "First-Person"
    v_u_126.TransparencyState = true
    v_u_126.FreecamInstance = nil
    v_u_126.Transparencies = {}
    v_u_126.TransparencyJanitor = nil
    v_u_126.WeaponTransparencyCache = {}
    v_u_126.ScopeUICache = nil
    v_u_126.LastScopeUpdateTime = 0
    v_u_126.LastSpreadValue = 0
    v_u_126:SetCharacterTransparency(v_u_126.TransparencyState)
    v_u_126:Switch(v_u_126.PerspectiveState)
    v_u_5.ReplicationFocus = v_u_126.Humanoid
    v_u_126.Janitor:Add(function()
        v_u_5.ReplicationFocus = nil
    end)
    if v_u_126.Player:GetAttribute("CurrentEquipped") then
        v_u_126:SetEquipped(v_u_3:JSONDecode((v_u_126.Player:GetAttribute("CurrentEquipped"))), false)
    end
    v_u_126.Janitor:Add(v_u_126.Player:GetAttributeChangedSignal("CurrentEquipped"):Connect(function()
        local v127 = v_u_126.Player:GetAttribute("CurrentEquipped")
        if v127 then
            v_u_126:SetEquipped(v_u_3:JSONDecode(v127), true)
            task.defer(function()
                if v_u_126.TransparencyState and v_u_126.PerspectiveState == "First-Person" then
                    v_u_126:HideDebrisWeapons()
                end
            end)
        end
    end))
    if v_u_126.Character:GetAttribute("CameraCFrame") then
        v_u_126:UpdateCameraCFrame((v_u_126.Character:GetAttribute("CameraCFrame")))
    end
    v_u_126.Janitor:Add(v_u_126.Character:GetAttributeChangedSignal("CameraCFrame"):Connect(function()
        v_u_126:UpdateCameraCFrame((v_u_126.Character:GetAttribute("CameraCFrame")))
    end))
    if v_u_126.Player:GetAttribute("ScopeIncrement") then
        v_u_126:UpdateScopeState()
    end
    v_u_126.Janitor:Add(v_u_126.Player:GetAttributeChangedSignal("ScopeIncrement"):Connect(function()
        v_u_126:UpdateScopeState()
    end))
    if v_u_126.Humanoid.Health <= 0 then
        task.defer(function()
            v_u_126.StopSpectating:Fire()
        end)
    end
    v_u_126.Janitor:Add(v_u_126.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
        if v_u_126.Humanoid and v_u_126.Humanoid.Health <= 0 then
            v_u_126.StopSpectating:Fire()
        end
    end))
    if v_u_126.Character:GetAttribute("Dead") then
        task.defer(function()
            v_u_126.StopSpectating:Fire()
        end)
    end
    v_u_126.Janitor:Add(v_u_126.Character:GetAttributeChangedSignal("Dead"):Connect(function()
        if v_u_126.Character:GetAttribute("Dead") then
            v_u_126.StopSpectating:Fire()
        end
    end))
    v_u_126.Janitor:Add(v_u_19.UI.UIPlayerKilled.Listen(function(p128)
        local v129 = p128.Victim
        if v129 then
            local v130 = v_u_126.Player.UserId
            if tostring(v130) == v129 then
                v_u_126.StopSpectating:Fire()
            end
        end
    end))
    v_u_126.Janitor:Add(v_u_126.Character.AncestryChanged:Connect(function(_, p131)
        if not (p131 and p131:IsDescendantOf(v_u_20)) then
            v_u_126.StopSpectating:Fire()
        end
    end))
    v_u_126.Janitor:Add(function()
        v_u_126.TransparencyState = false
        if v_u_18.Dictionary.count(v_u_126.Transparencies) > 0 then
            v_u_126:SetCharacterTransparency(v_u_126.TransparencyState)
        end
        v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
    end)
    v_u_126.Janitor:Add(function()
        if v_u_126.WeaponComponent then
            v_u_126.WeaponComponent.Janitor:Destroy()
            v_u_126.WeaponComponent = nil
        end
        v_u_126.WeaponTransparencyCache = {}
        v_u_126.LastScopeUpdateTime = 0
        v_u_126.LastSpreadValue = 0
        v_u_126.ScopeUICache = nil
    end)
    v_u_126.Janitor:Add(function()
        if v_u_126.FreecamInstance then
            v_u_126.FreecamInstance:Stop()
            v_u_126.FreecamInstance:Destroy()
            v_u_126.FreecamInstance = nil
        end
    end)
    return v_u_126
end
function v_u_1.Destroy(p132)
    p132.Janitor:Destroy()
end
return v_u_1