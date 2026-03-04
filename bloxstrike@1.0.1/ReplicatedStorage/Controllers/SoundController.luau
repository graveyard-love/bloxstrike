local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("ContentProvider")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players")
local v6 = game:GetService("Workspace")
local v_u_7 = v_u_5.LocalPlayer
local v_u_8 = require(v_u_2.Database.Security.Remotes)
local v_u_9 = require(v_u_2.Packages.Observers)
local v_u_10 = require(v_u_2.Database.Security.Router)
local v_u_11 = require(v_u_2.Controllers.DataController)
local v_u_12 = require(v_u_2.Classes.Sound)
local v_u_13 = require(v_u_2.Interface.MenuState)
local v_u_14 = require(v_u_2.Shared.DebugFlags)
local v_u_15 = require(v_u_2.Database.Components.GameState)
local v_u_16 = require(v_u_2.Components.Common.VFXLibary.FlashEffect)
local v_u_17 = require(script.MovementSounds)
local v_u_18 = require(v_u_2.Database.Audio.Character)
local v_u_19 = require(v_u_2.Database.Audio.FloorSounds)
local v_u_20 = v6.CurrentCamera
local v_u_21 = {
    ["WeaponSuppressed"] = 50,
    ["Footstep"] = 48,
    ["Landing"] = 60,
    ["Weapon"] = 120,
    ["Melee"] = 50,
    ["Jump"] = 40
}
local v_u_22 = {}
local v_u_23 = {}
local v_u_24 = nil
local v_u_25 = {
    "Knife",
    "Bayonet",
    "Karambit",
    "Daggers"
}
local v_u_26 = {
    ["Headshot"] = 1,
    ["Humiliation"] = 2,
    ["MultiKill"] = 3,
    ["KillSpree"] = 4,
    ["Rampage"] = 5,
    ["Dominating"] = 6,
    ["Monster Kill"] = 7,
    ["LudicrusKill"] = 8,
    ["Unstoppable"] = 9,
    ["Godlike"] = 10
}
local v_u_27 = {
    [2] = "MultiKill",
    [3] = "KillSpree",
    [4] = "Rampage",
    [5] = "Dominating",
    [6] = "Monster Kill",
    [7] = "LudicrusKill",
    [8] = "Unstoppable",
    [9] = "Godlike"
}
local v_u_28 = 0
local v_u_29 = nil
local v_u_30 = 0
local function v_u_33(p31)
    for _, v32 in ipairs(v_u_25) do
        if string.find(p31, v32) then
            return true
        end
    end
    return false
end
function v_u_1.GetPlayerNoiseCone()
    if v_u_24 and tick() - v_u_24.Time >= 2 then
        v_u_24 = nil
    end
    return v_u_24
end
function v_u_1.UpdatePlayerNoiseCone(p34, p35, p36)
    local v37 = p35 * 0.5
    local v38 = tick()
    if p36 then
        v37 = v37 * 0.5
    end
    if v_u_24 and (v38 - v_u_24.Time < 2 and v37 < v_u_24.Range) then
        v_u_24.Time = v38
    else
        v_u_24 = {
            ["Position"] = p34,
            ["Range"] = v37,
            ["Time"] = v38
        }
    end
end
function v_u_1.GetFootstepRange(p39, p40)
    local v41 = v_u_19[p39] or v_u_19.Concrete
    local v42 = v_u_21.Footstep
    if v41 and v41.Properties then
        v42 = v41.Properties.RollOffMaxDistance or v42
    end
    if p40 then
        v42 = v42 * 0.5 or v42
    end
    return v42
end
function v_u_1.GetWeaponShootRange(p43, p44)
    local v45
    if v_u_23[p43] then
        v45 = v_u_23[p43]
    else
        local v46 = v_u_2.Database.Audio.Weapons:FindFirstChild(p43)
        if v46 then
            local v47
            v47, v45 = pcall(require, v46)
            if v47 and v45 then
                v_u_23[p43] = v45
            else
                v45 = nil
            end
        else
            v45 = nil
        end
    end
    if v45 then
        if p44 and v45.Silencer then
            local v48 = v45.Silencer
            local v49 = v_u_21.WeaponSuppressed
            if v48 and v48.Properties then
                v49 = v48.Properties.RollOffMaxDistance or v49
            end
            return v49
        else
            local v50 = v45.Shoot
            local v51 = v_u_21.Weapon
            if v50 and v50.Properties then
                v51 = v50.Properties.RollOffMaxDistance or v51
            end
            return v51
        end
    else
        return p44 and v_u_21.WeaponSuppressed or v_u_21.Weapon
    end
end
function v_u_1.GetMeleeRange(p52)
    local v53
    if v_u_23[p52] then
        v53 = v_u_23[p52]
    else
        local v54 = v_u_2.Database.Audio.Weapons:FindFirstChild(p52)
        if v54 then
            local v55
            v55, v53 = pcall(require, v54)
            if v55 and v53 then
                v_u_23[p52] = v53
            else
                v53 = nil
            end
        else
            v53 = nil
        end
    end
    if not v53 then
        return v_u_21.Melee
    end
    local v56 = v53.HitOne
    local v57 = v_u_21.Melee
    if v56 and v56.Properties then
        v57 = v56.Properties.RollOffMaxDistance or v57
    end
    return v57
end
function v_u_1.GetMovementRange(p58, p59)
    local v60 = v_u_21[p58] or v_u_21.Footstep
    if p58 == "Landing" then
        local v61 = v_u_18["Fall Damage"]
        if v61 and v61.Properties then
            v60 = v61.Properties.RollOffMaxDistance or v60
        end
    end
    if p59 then
        v60 = v60 * 0.5 or v60
    end
    return v60
end
function v_u_1.ClearPlayerNoiseCone()
    v_u_24 = nil
end
function v_u_1.Initialize()
    for _, v62 in ipairs(v_u_2.Database.Audio:GetDescendants()) do
        if v62:IsA("ModuleScript") then
            v_u_12.createSoundGroup(v62)
        end
    end
    task.spawn(function()
        v_u_3:PreloadAsync({ v_u_2.Sounds })
    end)
    v_u_10.observerRouter("RunRoundSound", function(p63)
        if v_u_13.GetCurrentScreen() == nil then
            local v64 = {
                ["Parent"] = v_u_20,
                ["Name"] = p63
            }
            return v_u_12.new("Round"):playOneTime(v64)
        end
    end)
    v_u_10.observerRouter("PlayCountdownTimer", function()
        local v65 = (v_u_11.Get(v_u_7, "Settings.Audio.Music.Main Menu Volume") or 100) / 100
        if v_u_13.GetCurrentScreen() == nil then
            if v65 > 0 then
                v_u_12.new("Interface"):playOneTime({
                    ["Parent"] = v_u_7.PlayerGui,
                    ["Name"] = "Countdown Timer"
                }, v65)
            end
            return nil
        end
    end)
    local v_u_66 = nil
    local v_u_67 = nil
    local v_u_68 = nil
    local function v_u_79(p69)
        if v_u_66 and v_u_66.Parent then
            local v70 = (v_u_11.Get(v_u_7, "Settings.Audio.Music.Round Start Volume") or 50) / 50
            local v71 = (v_u_11.Get(v_u_7, "Settings.Audio.Audio.Master Volume") or 100) / 100
            local v72 = v_u_66:GetAttribute("BaseVolume") or v_u_66.Volume
            local v73
            if p69 and v_u_68 then
                local v74 = tick() - v_u_68
                if v74 < 6 then
                    v73 = 1
                else
                    local v75 = 1 - (v74 - 6) * 0.2
                    v73 = math.max(0, v75)
                end
            else
                v73 = 1
            end
            v_u_66.Volume = v72 * v70 * v71 * v73
            if p69 and v_u_68 then
                local v76 = tick() - v_u_68
                local v77
                if v76 < 6 then
                    v77 = 1
                else
                    local v78 = 1 - (v76 - 6) * 0.2
                    v77 = math.max(0, v78)
                end
                if v77 <= 0 then
                    if v_u_67 then
                        v_u_67:Disconnect()
                        v_u_67 = nil
                    end
                    v_u_66:Stop()
                    v_u_66:Destroy()
                    v_u_66 = nil
                    v_u_68 = nil
                end
            end
        end
    end
    v_u_15.ListenToState(function(_, p80)
        if p80 == "Buy Period" then
            local v81 = v_u_7:GetAttribute("Team")
            if v81 ~= "Counter-Terrorists" and v81 ~= "Terrorists" then
                return
            end
            if v_u_66 then
                if v_u_67 then
                    v_u_67:Disconnect()
                    v_u_67 = nil
                end
                if v_u_66.Parent then
                    v_u_66:Stop()
                    v_u_66:Destroy()
                end
                v_u_66 = nil
                v_u_68 = nil
            end
            local v82 = (v_u_11.Get(v_u_7, "Settings.Audio.Music.Round Start Volume") or 50) / 50
            local v83 = {
                ["Parent"] = v_u_20,
                ["Name"] = "Buy Phase"
            }
            v_u_66 = v_u_12.new("Round"):play(v83, v82)
            if v_u_66 then
                local v_u_84 = v_u_66
                v_u_84.Destroying:Once(function()
                    if v_u_66 == v_u_84 then
                        v_u_66 = nil
                        v_u_68 = nil
                    end
                end)
                local v85 = (v_u_11.Get(v_u_7, "Settings.Audio.Audio.Master Volume") or 100) / 100
                local v86 = v_u_66.Volume
                if v82 > 0 and v85 > 0 then
                    v86 = v86 / (v82 * v85) or v86
                end
                v_u_66:SetAttribute("BaseVolume", v86)
                v_u_68 = tick()
                task.spawn(function()
                    v_u_67 = v_u_4.Heartbeat:Connect(function()
                        if not (v_u_66 and v_u_66.Parent) then
                            if v_u_67 then
                                v_u_67:Disconnect()
                                v_u_67 = nil
                            end
                            goto l10
                        end
                        if not v_u_68 then
                            return
                        end
                        local v87 = tick() - v_u_68
                        local v88 = v87 >= 6
                        v_u_79(v88)
                        if v88 then
                            if not (v_u_66 and v_u_66.Parent) then
                                ::l12::
                                if v_u_67 then
                                    v_u_67:Disconnect()
                                    v_u_67 = nil
                                    return
                                end
                                goto l10
                            end
                            local v89
                            if v87 < 6 then
                                v89 = 1
                            else
                                local v90 = 1 - (v87 - 6) * 0.2
                                v89 = math.max(0, v90)
                            end
                            if v89 <= 0 then
                                goto l12
                            end
                        end
                        ::l10::
                    end)
                end)
                return
            end
        elseif v_u_66 then
            if v_u_67 then
                v_u_67:Disconnect()
                v_u_67 = nil
            end
            if v_u_66.Parent then
                v_u_66:Stop()
                v_u_66:Destroy()
            end
            v_u_66 = nil
            v_u_68 = nil
        end
    end)
    v_u_11.CreateListener(v_u_7, "Settings.Audio.Music.Round Start Volume", function()
        v_u_79(v_u_67 ~= nil)
    end)
    v_u_11.CreateListener(v_u_7, "Settings.Audio.Audio.Master Volume", function()
        v_u_79(v_u_67 ~= nil)
    end)
    local v_u_91 = nil
    v_u_8.Sound.ReplicateSound.Listen(function(p92)
        local v93 = v_u_16.GetAudioFadeMultiplier()
        if v_u_14.IsEnabled("WeaponFX") then
            local v94
            if p92 and p92.Name then
                local v95 = p92.Name
                v94 = tostring(v95) or ""
            else
                v94 = ""
            end
            local v96
            if p92 and p92.Class then
                local v97 = p92.Class
                v96 = tostring(v97) or ""
            else
                v96 = ""
            end
            local v98 = string.lower(v94)
            if string.find(v98, "shoot", 1, true) or string.find(v98, "fire", 1, true) then
                local v99 = v_u_16.IsFlashed()
                local v100 = warn
                local v101 = "[WeaponFX][Client][Sound] recv class=%s name=%s flashed=%s parent=%s position=%s path=%s"
                local v102 = tostring(v99)
                local v103
                if p92 then
                    v103 = p92.Parent
                else
                    v103 = p92
                end
                local v104 = tostring(v103)
                local v105
                if p92 then
                    v105 = p92.Position
                else
                    v105 = p92
                end
                local v106 = tostring(v105)
                local v107
                if p92 then
                    v107 = p92.Path
                else
                    v107 = p92
                end
                v100(v101:format(v96, v94, v102, v104, v106, (tostring(v107))))
            end
        end
        if p92.Name == "Bomb Planted Music" and (p92.Class == "Counter-Terrorists" and v_u_91) then
            if v_u_91.Parent then
                v_u_91:Stop()
                v_u_91:Destroy()
            end
            v_u_91 = nil
        end
        if p92.Position then
            local v108 = v_u_12.new(p92.Class)
            local v109 = {
                ["Position"] = p92.Position,
                ["Class"] = p92.Class,
                ["Name"] = p92.Name
            }
            local v110 = p92.Duration
            v108:PlaySoundAtPosition(v109, tonumber(v110), v93)
        elseif p92.Parent or p92.Path then
            if p92.Parent and p92.Parent:IsA("BasePart") then
                local v111 = p92.Parent
                if v111 and v111.Name == "Head" then
                    local v112 = v111.Parent
                    if v112 and (v112:IsA("Model") and (v112:IsDescendantOf(workspace) and v_u_5:GetPlayerFromCharacter(v112) == v_u_7)) then
                        if v_u_14.IsEnabled("WeaponFX") then
                            local v113 = warn
                            local v114 = p92.Name
                            local v115 = tostring(v114)
                            local v116 = p92.Class
                            v113(("[WeaponFX][Client][Sound] skipped local duplicate head sound name=%s class=%s"):format(v115, (tostring(v116))))
                        end
                        return
                    end
                end
            end
            if (p92.Name == "Bomb Defused" or p92.Name == "Hostage Rescued") and v_u_13.GetCurrentScreen() ~= nil then
                return
            end
            if p92.Name == "Bomb Planted Music" and p92.Class == "Counter-Terrorists" then
                if v_u_15.GetState() ~= "Round In Progress" then
                    return
                end
                if v_u_13.GetCurrentScreen() ~= nil then
                    return
                end
                v93 = v93 * ((v_u_11.Get(v_u_7, "Settings.Audio.Music.Bomb/Hostage Volume") or 50) / 50)
            elseif (p92.Name == "Counter-Terrorists Win" or p92.Name == "Terrorists Win") and p92.Class == "Round" then
                if v_u_13.GetCurrentScreen() ~= nil then
                    return
                end
                v93 = v93 * ((v_u_11.Get(v_u_7, "Settings.Audio.Music.Round End Volume") or 50) / 50)
            end
            local v_u_117 = v_u_12.new(p92.Class):playOneTime({
                ["Parent"] = p92.Parent,
                ["Name"] = p92.Name,
                ["Path"] = p92.Path
            }, v93)
            if (p92.Name == "Counter-Terrorists Win" or p92.Name == "Terrorists Win") and (p92.Class == "Round" and v_u_117) then
                if v_u_117 then
                    local v118 = (v_u_11.Get(v_u_7, "Settings.Audio.Music.Round End Volume") or 50) / 50
                    local v119 = (v_u_11.Get(v_u_7, "Settings.Audio.Audio.Master Volume") or 100) / 100
                    local v_u_120 = v_u_117.Volume
                    if v118 > 0 and v119 > 0 then
                        v_u_120 = v_u_120 / (v118 * v119) or v_u_120
                    end
                    v_u_117:SetAttribute("BaseVolume", v_u_120)
                    local function v123()
                        if v_u_117 and v_u_117.Parent then
                            local v121 = (v_u_11.Get(v_u_7, "Settings.Audio.Music.Round End Volume") or 50) / 50
                            local v122 = (v_u_11.Get(v_u_7, "Settings.Audio.Audio.Master Volume") or 100) / 100
                            v_u_117.Volume = (v_u_117:GetAttribute("BaseVolume") or v_u_120) * v121 * v122
                        end
                    end
                    local v_u_124 = v_u_11.CreateListener(v_u_7, "Settings.Audio.Music.Round End Volume", v123)
                    local v_u_125 = v_u_11.CreateListener(v_u_7, "Settings.Audio.Audio.Master Volume", v123)
                    v_u_117.Destroying:Once(function()
                        v_u_11.RemoveListener(v_u_7, "Settings.Audio.Music.Round End Volume", v_u_124)
                        v_u_11.RemoveListener(v_u_7, "Settings.Audio.Audio.Master Volume", v_u_125)
                    end)
                    return
                end
            else
                v_u_91 = p92.Name == "Bomb Planted Music" and (p92.Class == "Counter-Terrorists" and v_u_117)
                if v_u_91 then
                    local v126 = (v_u_11.Get(v_u_7, "Settings.Audio.Music.Bomb/Hostage Volume") or 50) / 50
                    local v127 = (v_u_11.Get(v_u_7, "Settings.Audio.Audio.Master Volume") or 100) / 100
                    local v_u_128 = v_u_91.Volume
                    if v126 > 0 and v127 > 0 then
                        v_u_128 = v_u_128 / (v126 * v127) or v_u_128
                    end
                    v_u_91:SetAttribute("BaseVolume", v_u_128)
                    local function v131()
                        if v_u_91 and v_u_91.Parent then
                            local v129 = (v_u_11.Get(v_u_7, "Settings.Audio.Music.Bomb/Hostage Volume") or 50) / 50
                            local v130 = (v_u_11.Get(v_u_7, "Settings.Audio.Audio.Master Volume") or 100) / 100
                            v_u_91.Volume = (v_u_91:GetAttribute("BaseVolume") or v_u_128) * v129 * v130
                        end
                    end
                    local v_u_132 = v_u_11.CreateListener(v_u_7, "Settings.Audio.Music.Bomb/Hostage Volume", v131)
                    local v_u_133 = v_u_11.CreateListener(v_u_7, "Settings.Audio.Audio.Master Volume", v131)
                    v_u_91.Destroying:Once(function()
                        v_u_11.RemoveListener(v_u_7, "Settings.Audio.Music.Bomb/Hostage Volume", v_u_132)
                        v_u_11.RemoveListener(v_u_7, "Settings.Audio.Audio.Master Volume", v_u_133)
                    end)
                end
            end
        end
    end)
    local v_u_134 = game:GetService("CollectionService")
    local function v_u_137()
        local v_u_135 = v_u_134:GetTagged("Bomb")[1]
        if v_u_135 and v_u_135:IsDescendantOf(workspace) then
            local v_u_136 = nil
            v_u_136 = v_u_135:GetAttributeChangedSignal("Defused"):Connect(function()
                if v_u_135:GetAttribute("Defused") then
                    if v_u_91 then
                        if v_u_91.Parent then
                            v_u_91:Stop()
                            v_u_91:Destroy()
                        end
                        v_u_91 = nil
                    end
                    if v_u_136 then
                        v_u_136:Disconnect()
                    end
                end
            end)
        end
    end
    v_u_134:GetInstanceAddedSignal("Bomb"):Connect(function(_)
        v_u_137()
    end)
    task.defer(function()
        v_u_137()
    end)
    v_u_15.ListenToState(function(_, p138)
        if p138 ~= "Round In Progress" and v_u_91 then
            if v_u_91.Parent then
                v_u_91:Stop()
                v_u_91:Destroy()
            end
            v_u_91 = nil
        end
    end)
    v_u_8.UI.UIPlayerKilled.Listen(function(p139)
        if workspace:GetAttribute("Gamemode") == "Deathmatch" then
            local v140 = v_u_7.UserId
            local v141 = tostring(v140)
            if p139.Victim == v141 then
                v_u_28 = 0
                if v_u_29 then
                    local v142 = v_u_29
                    v_u_29 = nil
                    v_u_30 = 0
                    if v142.Parent then
                        v142:Stop()
                        v142:Destroy()
                    end
                end
                return
            elseif p139.Killer == v141 then
                v_u_28 = v_u_28 + 1
                local v143 = v_u_28
                local v_u_144 = v_u_27[math.min(v143, 9)]
                local v145
                if v_u_144 then
                    v145 = v_u_26[v_u_144] or 0
                else
                    v145 = 0
                    v_u_144 = nil
                end
                local v146
                if p139.Headshot then
                    v146 = v_u_26.Headshot or 0
                    if v145 < v146 then
                        v_u_144 = "Headshot"
                    else
                        v146 = v145
                    end
                else
                    v146 = v145
                end
                local v_u_147
                if p139.Weapon and v_u_33(p139.Weapon) then
                    v_u_147 = v_u_26.Humiliation or 0
                    if v146 < v_u_147 then
                        v_u_144 = "Humiliation"
                    else
                        v_u_147 = v146
                    end
                else
                    v_u_147 = v146
                end
                if v_u_144 then
                    if v_u_147 >= v_u_30 then
                        if v_u_29 then
                            local v148 = v_u_29
                            v_u_29 = nil
                            v_u_30 = 0
                            if v148.Parent then
                                v148:Stop()
                                v148:Destroy()
                            end
                        end
                        task.delay(0.2, function()
                            if v_u_147 >= v_u_30 then
                                if v_u_29 then
                                    local v149 = v_u_29
                                    v_u_29 = nil
                                    v_u_30 = 0
                                    if v149.Parent then
                                        v149:Stop()
                                        v149:Destroy()
                                    end
                                end
                                local v_u_150 = v_u_12.new("Deathmatch"):play({
                                    ["Parent"] = v_u_7.PlayerGui,
                                    ["Name"] = v_u_144
                                })
                                if v_u_150 then
                                    v_u_29 = v_u_150
                                    v_u_30 = v_u_147
                                    v_u_150.Ended:Once(function()
                                        if v_u_29 == v_u_150 then
                                            v_u_29 = nil
                                            v_u_30 = 0
                                        end
                                    end)
                                    v_u_150.Destroying:Once(function()
                                        if v_u_29 == v_u_150 then
                                            v_u_29 = nil
                                            v_u_30 = 0
                                        end
                                    end)
                                end
                            end
                        end)
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
    end)
    v_u_8.Sound.StopSoundAtPosition.Listen(function(p151)
        local v152 = workspace:FindFirstChild("Debris")
        if v152 then
            for _, v153 in ipairs(v152:GetChildren()) do
                if v153.Name == "Sound" and (v153:IsA("BasePart") and (v153.Position - p151.Position).Magnitude <= p151.Radius) then
                    v153:Destroy()
                end
            end
        end
    end)
    v_u_10.observerRouter("UpdatePlayerNoiseCone", function(p154, p155, p156, p157)
        if typeof(p156) ~= "number" then
            p156 = ({
                ["Footstep"] = v_u_1.GetFootstepRange(p156 or "Concrete", p157),
                ["Landing"] = v_u_1.GetMovementRange("Landing", p157),
                ["Jump"] = v_u_1.GetMovementRange("Jump", p157)
            })[p154]
        end
        if not p156 then
            return nil
        end
        v_u_1.UpdatePlayerNoiseCone(p155, p156, p157)
        return nil
    end)
end
function v_u_1.Start()
    v_u_9.observeCharacter(function(p158, p159)
        local v160 = p158 == v_u_7
        local v_u_161 = v_u_22[p158]
        if not v_u_161 then
            v_u_161 = v_u_17.new(p158)
            v_u_22[p158] = v_u_161
        end
        if v160 then
            v_u_1.ClearPlayerNoiseCone()
            v_u_28 = 0
            if v_u_29 then
                local v162 = v_u_29
                v_u_29 = nil
                v_u_30 = 0
                if v162.Parent then
                    v162:Stop()
                    v162:Destroy()
                end
            end
        end
        v_u_161:SetCharacter(p159)
        return function()
            v_u_161:SetCharacter(nil)
        end
    end)
    v_u_5.PlayerRemoving:Connect(function(p163)
        local v164 = v_u_22[p163]
        if v164 then
            v_u_22[p163] = nil
            v164:Destroy()
        end
    end)
    v_u_4.Heartbeat:Connect(function(p165)
        local v166 = v_u_7.Character
        local v167
        if v166 and v166:IsDescendantOf(workspace) then
            local v168 = v166:FindFirstChild("Humanoid")
            local v169 = v168 and (v168.Health > 0 and v166:FindFirstChild("HumanoidRootPart"))
            if v169 then
                v167 = v169.Position
            else
                v167 = nil
            end
        else
            v167 = nil
        end
        for _, v170 in pairs(v_u_22) do
            v170:Update(p165, v167)
        end
    end)
end
return v_u_1