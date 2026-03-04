local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v_u_4 = game:GetService("Players").LocalPlayer
local v_u_5 = require(v2:WaitForChild("Controllers"):WaitForChild("DataController"))
require(script:WaitForChild("Types"))
local v_u_6 = require(v2.Shared.Janitor)
local v_u_7 = v2:FindFirstChild("Sounds") or Instance.new("Folder", v2)
v_u_7.Name = "Sounds"
local v_u_8 = workspace:WaitForChild("Debris")
local function v_u_14(p9)
    local v10 = string.split(p9, ".")
    local v11 = game
    for v12, v13 in ipairs(v10) do
        if v11 and v12 > 1 then
            v11 = v11:FindFirstChild(v13)
            if not v11 then
                error((("Path: \"%*\" does not exist"):format(p9)))
            end
        end
    end
    return v11
end
local function v_u_19(p15, p16, p17)
    local v18 = Instance.new("Sound")
    v18.RollOffMaxDistance = p17.RollOffMaxDistance or 10000
    v18.RollOffMinDistance = p17.RollOffMinDistance or 10
    v18.TimePosition = p17.TimePosition or 0
    v18.RollOffMode = Enum.RollOffMode.Inverse
    v18.Looped = p17.Looped or false
    v18.SoundId = ("rbxassetid://%*"):format(p16)
    v18.Volume = p17.Volume or 0.5
    v18.Name = p15
    return v18
end
function v_u_1.play(p20, p21, p_u_22)
    local v23 = p21.Parent or p21.Path
    local v24 = ("Sound couldn\'t locate sound parent for %*"):format(p21.Name)
    assert(v23, v24)
    if not p20.Sounds then
        return nil
    end
    local v25 = p20.Sounds:FindFirstChild(p21.Name)
    if v25 then
        local v26 = v_u_3:GenerateGUID(false)
        local v27 = p21.Parent
        if p21.Path and not v27 then
            v27 = v_u_14(p21.Path)
        end
        if not v27 then
            return nil
        end
        local v28 = (v_u_5.Get(v_u_4, "Settings.Audio.Audio.Master Volume") or 100) / 100
        local v29 = v25:GetChildren()
        local v_u_30 = v25:WaitForChild((math.random(1, #v29))):Clone()
        v_u_30.Volume = v_u_30.Volume * v28 * (p_u_22 or 1)
        v_u_30.Parent = v27
        v_u_30.Name = v26
        v_u_30:Play()
        local v_u_31 = v_u_30.Volume / (v28 * (p_u_22 or 1))
        v_u_30:SetAttribute("BaseVolume", v_u_31)
        v_u_30:SetAttribute("MasterVolumeMultiplier", v28)
        if p_u_22 then
            v_u_30:SetAttribute("OtherVolumeMultiplier", p_u_22)
        end
        local v_u_36 = v_u_5.CreateListener(v_u_4, "Settings.Audio.Audio.Master Volume", function(p32)
            if v_u_30 and v_u_30.Parent then
                local v33 = (p32 or 100) / 100
                local v34 = v_u_30:GetAttribute("BaseVolume") or v_u_31
                local v35 = v_u_30:GetAttribute("OtherVolumeMultiplier") or (p_u_22 or 1)
                v_u_30.Volume = v34 * v33 * v35
                v_u_30:SetAttribute("MasterVolumeMultiplier", v33)
            end
        end)
        v_u_30.Destroying:Once(function()
            if v_u_36 then
                v_u_5.RemoveListener(v_u_4, "Settings.Audio.Audio.Master Volume", v_u_36)
                v_u_36 = nil
            end
        end)
        v_u_30.Ended:Once(function()
            v_u_30:Destroy()
        end)
        return v_u_30
    end
end
function v_u_1.playOneTime(p37, p38, p39)
    return p37:play(p38, p39 or 1)
end
function v_u_1.PlaySoundAtPosition(p_u_40, p41, p42, p_u_43, p44, p45)
    if p_u_40.IsDestroyed then
        return
    elseif p_u_40.Sounds then
        local v46 = p_u_40.Sounds:FindFirstChild(p41.Name)
        if v46 then
            local v47 = p_u_40.Janitor:Add(Instance.new("Part"))
            v47.Size = Vector3.new(1, 1, 1)
            v47.Position = p41.Position
            v47.CollisionGroup = "Debris"
            v47.CanCollide = false
            v47.CanTouch = false
            v47.CanQuery = false
            v47.Anchored = true
            v47.Transparency = 1
            v47.Parent = v_u_8
            v47.Name = "Sound"
            local v48 = (v_u_5.Get(v_u_4, "Settings.Audio.Audio.Master Volume") or 100) / 100
            local v49 = p_u_40.Janitor
            local v50 = v46:GetChildren()
            local v_u_51 = v49:Add((v46:WaitForChild((math.random(1, #v50))):Clone()))
            v_u_51.Volume = v_u_51.Volume * v48 * (p_u_43 or 1)
            v_u_51.Name = v_u_3:GenerateGUID(false)
            v_u_51.Parent = v47
            if (p41.Name == "Headshot" and true or p41.Name == "Helmet Headshot") and p44 then
                v_u_51.RollOffMode = Enum.RollOffMode.InverseTapered
                v_u_51.RollOffMaxDistance = 10000
                v_u_51.RollOffMinDistance = 10000
                if p45 then
                    v_u_51.Volume = v_u_51.Volume * 0
                end
            end
            v_u_51:Play()
            local v_u_52 = v_u_51.Volume / (v48 * (p_u_43 or 1))
            v_u_51:SetAttribute("MasterVolumeMultiplier", v48)
            v_u_51:SetAttribute("BaseVolume", v_u_52)
            if p_u_43 then
                v_u_51:SetAttribute("OtherVolumeMultiplier", p_u_43)
            end
            local v_u_57 = v_u_5.CreateListener(v_u_4, "Settings.Audio.Audio.Master Volume", function(p53)
                if v_u_51 and (v_u_51.Parent and not p_u_40.IsDestroyed) then
                    local v54 = (p53 or 100) / 100
                    local v55 = v_u_51:GetAttribute("BaseVolume") or v_u_52
                    local v56 = v_u_51:GetAttribute("OtherVolumeMultiplier") or (p_u_43 or 1)
                    v_u_51.Volume = v55 * v54 * v56
                    v_u_51:SetAttribute("MasterVolumeMultiplier", v54)
                end
            end)
            p_u_40.Janitor:Add(function()
                if v_u_57 then
                    v_u_5.RemoveListener(v_u_4, "Settings.Audio.Audio.Master Volume", v_u_57)
                    v_u_57 = nil
                end
            end, true)
            if v_u_51.Looped and p42 then
                p_u_40.Janitor:Add(task.delay(p42, function()
                    p_u_40:destroy()
                end), true)
            else
                p_u_40.Janitor:Add(v_u_51.Ended:Once(function()
                    p_u_40:destroy()
                end))
            end
            p_u_40.Janitor:Add(v_u_51.AncestryChanged:Connect(function()
                if not v_u_51.Parent then
                    p_u_40:destroy()
                end
            end))
        else
            p_u_40:destroy()
        end
    else
        p_u_40:destroy()
        return
    end
end
function v_u_1.createSoundGroup(p58)
    local v59 = require(p58)
    local v60 = Instance.new("Folder", v_u_7)
    v60.Name = p58.Name
    for v61, v62 in pairs(v59) do
        local v63 = Instance.new("Folder", v60)
        v63.Name = v61
        for v64, v65 in ipairs(v62.Identifiers) do
            v_u_19(v64, v65, v62.Properties).Parent = v63
        end
    end
end
function v_u_1.new(p66)
    local v67 = v_u_1
    local v68 = setmetatable({}, v67)
    v68.Janitor = v_u_6.new()
    v68.IsDestroyed = false
    v68.SoundGroupName = p66
    v68.Sounds = v_u_7:WaitForChild(p66, 10)
    return v68
end
function v_u_1.destroy(p69)
    if not p69.IsDestroyed then
        p69.IsDestroyed = true
        p69.Janitor:Destroy()
        p69.SoundGroupName = nil
        p69.Janitor = nil
        p69.Sounds = nil
    end
end
return v_u_1