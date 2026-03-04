local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players")
local v_u_6 = game:GetService("CollectionService")
require(script:WaitForChild("Types"))
local v_u_7 = v_u_5.LocalPlayer
local v_u_8 = require(v_u_2.Controllers.InventoryController)
local v_u_9 = require(v_u_2.Controllers.CameraController)
local v_u_10 = require(v_u_2.Interface.MenuState)
local v_u_11 = require(v_u_2.Classes.Spectate)
local v_u_12 = require(v_u_2.Classes.Freecam)
local v_u_13 = require(v_u_2.Packages.Observers)
local v_u_14 = require(v_u_2.Shared.Promise)
local v15 = require(v_u_2.Packages.Signal)
local v_u_16 = require(v_u_2.Database.Security.Remotes)
local v_u_17 = require(v_u_2.Database.Security.Router)
local v_u_18 = workspace.CurrentCamera
local v_u_19 = v15.new()
v_u_1.ListenToSpectate = v_u_19
local v_u_20 = require(v_u_2.Database.Custom.Constants)
local v_u_21 = "First-Person"
local v_u_22 = {}
local v_u_23 = 0
local v_u_24 = false
local v_u_25 = 1
local v_u_26 = 1
local v_u_27 = 0
local v_u_28 = nil
local v_u_29 = nil
local v_u_30 = { "First-Person", "Third-Person", "Free-Cam" }
local v_u_31 = nil
local v_u_32 = nil
local function v_u_34()
    for _, v33 in ipairs(v_u_6:GetTagged("Bomb")) do
        if v33:IsA("Model") and (v33.PrimaryPart and v33:IsDescendantOf(workspace)) then
            return v33
        end
    end
    return nil
end
local function v_u_42()
    if v_u_10.IsCaseSceneActive() then
        return false
    end
    if require(v_u_2.Controllers.EndScreenController).IsActive() then
        return false
    end
    local v35 = v_u_7
    local v36 = v35:GetAttribute("Team")
    local v37
    if (v36 == "Counter-Terrorists" and true or v36 == "Terrorists") and (v35 ~= v_u_7 or not v_u_24) then
        local v38 = v35.Character
        if v38 and v38:IsDescendantOf(workspace) and not v38:GetAttribute("Dead") then
            local v39 = v38:FindFirstChildWhichIsA("Humanoid", true)
            if v39 == nil then
                v37 = false
            else
                v37 = v39.Health > 0
            end
        else
            v37 = false
        end
    else
        v37 = false
    end
    if v37 then
        return false
    end
    local v40 = v_u_7:GetAttribute("Team")
    if v40 ~= "Counter-Terrorists" and v40 ~= "Terrorists" then
        return false
    end
    local v41 = require(v_u_2.Database.Components.GameState).GetState()
    return v41 ~= "Game Ending" and v41 ~= "Map Voting"
end
local function v_u_58()
    if v_u_42() then
        if v_u_31 or v_u_32 then
            return
        else
            v_u_9.updateCameraFOV(v_u_20.DEFAULT_CAMERA_FOV)
            v_u_9.setPerspective(true, false)
            local v43 = v_u_7:GetAttribute("LastKiller")
            local v44
            if v43 then
                v_u_7:SetAttribute("LastKiller", nil)
                v44 = v_u_5:FindFirstChild(v43)
                if v44 then
                    local v45
                    if v44 == v_u_7 then
                        v45 = false
                    else
                        local v46 = v44:GetAttribute("Team")
                        local v47
                        if (v46 == "Counter-Terrorists" and true or v46 == "Terrorists") and (v44 ~= v_u_7 or not v_u_24) then
                            local v48 = v44.Character
                            if v48 and v48:IsDescendantOf(workspace) and not v48:GetAttribute("Dead") then
                                local v49 = v48:FindFirstChildWhichIsA("Humanoid", true)
                                if v49 == nil then
                                    v47 = false
                                else
                                    v47 = v49.Health > 0
                                end
                            else
                                v47 = false
                            end
                        else
                            v47 = false
                        end
                        if v47 then
                            local v50 = workspace:GetAttribute("ServerGamemode")
                            local v51
                            if ((typeof(v50) ~= "string" or v50 ~= "Casual" and (v50 ~= "Competitive" and v50 ~= "Deathmatch")) and "Casual" or v50) == "Competitive" then
                                local v52 = v_u_7:GetAttribute("Team")
                                if v52 == "Counter-Terrorists" and true or v52 == "Terrorists" then
                                    local v53 = v_u_7
                                    local v54 = v53:GetAttribute("Team")
                                    local v55
                                    if (v54 == "Counter-Terrorists" and true or v54 == "Terrorists") and (v53 ~= v_u_7 or not v_u_24) then
                                        local v56 = v53.Character
                                        if v56 and v56:IsDescendantOf(workspace) and not v56:GetAttribute("Dead") then
                                            local v57 = v56:FindFirstChildWhichIsA("Humanoid", true)
                                            if v57 == nil then
                                                v55 = false
                                            else
                                                v55 = v57.Health > 0
                                            end
                                        else
                                            v55 = false
                                        end
                                    else
                                        v55 = false
                                    end
                                    v51 = not v55
                                else
                                    v51 = false
                                end
                            else
                                v51 = false
                            end
                            v45 = (not v51 or v_u_7:GetAttribute("Team") == v44:GetAttribute("Team")) and true or false
                        else
                            v45 = false
                        end
                    end
                    if not v45 then
                        v44 = nil
                    end
                else
                    v44 = nil
                end
            else
                v44 = nil
            end
            if v44 then
                v_u_1.SetNextPlayer(v44)
            else
                v_u_1.Next()
            end
        end
    else
        return
    end
end
local function v_u_70()
    local v59 = workspace:GetAttribute("ServerGamemode")
    local v60 = (typeof(v59) ~= "string" or v59 ~= "Casual" and (v59 ~= "Competitive" and v59 ~= "Deathmatch")) and "Casual" or v59
    table.clear(v_u_22)
    for _, v61 in ipairs(v_u_5:GetPlayers()) do
        local v62 = v_u_7:GetAttribute("Team")
        local v63 = v61:GetAttribute("Team")
        local v64
        if v61 == v_u_7 then
            v64 = false
        else
            local v65 = v61:GetAttribute("Team")
            if (v65 == "Counter-Terrorists" and true or v65 == "Terrorists") and (v61 ~= v_u_7 or not v_u_24) then
                local v66 = v61.Character
                if v66 and v66:IsDescendantOf(workspace) and not v66:GetAttribute("Dead") then
                    local v67 = v66:FindFirstChildWhichIsA("Humanoid", true)
                    if v67 == nil then
                        v64 = false
                    else
                        v64 = v67.Health > 0
                    end
                else
                    v64 = false
                end
            else
                v64 = false
            end
        end
        if v60 == "Competitive" then
            if (v62 == "Spectators" and true or v63 == v62) and v64 then
                local v68 = v_u_22
                table.insert(v68, v61)
            end
        elseif v64 then
            local v69 = v_u_22
            table.insert(v69, v61)
        end
    end
end
function v_u_1.GetCurrentSpectateInstance()
    return v_u_31
end
function v_u_1.IsLocalPlayerDead()
    return v_u_24
end
function v_u_1.GetPlayer()
    local v71 = v_u_7
    local v72 = v71:GetAttribute("Team")
    local v73
    if (v72 == "Counter-Terrorists" and true or v72 == "Terrorists") and (v71 ~= v_u_7 or not v_u_24) then
        local v74 = v71.Character
        if v74 and v74:IsDescendantOf(workspace) and not v74:GetAttribute("Dead") then
            local v75 = v74:FindFirstChildWhichIsA("Humanoid", true)
            if v75 == nil then
                v73 = false
            else
                v73 = v75.Health > 0
            end
        else
            v73 = false
        end
    else
        v73 = false
    end
    if v73 then
        return v_u_7
    else
        local v76 = v_u_1.GetCurrentSpectateInstance()
        if v76 then
            return v76.Player
        else
            return nil
        end
    end
end
function v_u_1.SetNextPlayer(p77)
    local v78 = v_u_31
    if v78 then
        v78 = v_u_31.Player
    end
    if p77 == v_u_7 then
        v_u_1.Next()
        return
    else
        local v79
        if p77 == v_u_7 then
            v79 = false
        else
            local v80 = p77:GetAttribute("Team")
            local v81
            if (v80 == "Counter-Terrorists" and true or v80 == "Terrorists") and (p77 ~= v_u_7 or not v_u_24) then
                local v82 = p77.Character
                if v82 and v82:IsDescendantOf(workspace) and not v82:GetAttribute("Dead") then
                    local v83 = v82:FindFirstChildWhichIsA("Humanoid", true)
                    if v83 == nil then
                        v81 = false
                    else
                        v81 = v83.Health > 0
                    end
                else
                    v81 = false
                end
            else
                v81 = false
            end
            if v81 then
                local v84 = workspace:GetAttribute("ServerGamemode")
                local v85
                if ((typeof(v84) ~= "string" or v84 ~= "Casual" and (v84 ~= "Competitive" and v84 ~= "Deathmatch")) and "Casual" or v84) == "Competitive" then
                    local v86 = v_u_7:GetAttribute("Team")
                    if v86 == "Counter-Terrorists" and true or v86 == "Terrorists" then
                        local v87 = v_u_7
                        local v88 = v87:GetAttribute("Team")
                        local v89
                        if (v88 == "Counter-Terrorists" and true or v88 == "Terrorists") and (v87 ~= v_u_7 or not v_u_24) then
                            local v90 = v87.Character
                            if v90 and v90:IsDescendantOf(workspace) and not v90:GetAttribute("Dead") then
                                local v91 = v90:FindFirstChildWhichIsA("Humanoid", true)
                                if v91 == nil then
                                    v89 = false
                                else
                                    v89 = v91.Health > 0
                                end
                            else
                                v89 = false
                            end
                        else
                            v89 = false
                        end
                        v85 = not v89
                    else
                        v85 = false
                    end
                else
                    v85 = false
                end
                v79 = (not v85 or v_u_7:GetAttribute("Team") == p77:GetAttribute("Team")) and true or false
            else
                v79 = false
            end
        end
        if v79 then
            local v92 = p77.Character
            local v93 = v78 == p77
            local v94 = v_u_31
            if v94 then
                v94 = v_u_31.Character == v92
            end
            local v95 = p77:GetAttribute("Team")
            local v96
            if (v95 == "Counter-Terrorists" and true or v95 == "Terrorists") and (p77 ~= v_u_7 or not v_u_24) then
                local v97 = p77.Character
                if v97 and v97:IsDescendantOf(workspace) and not v97:GetAttribute("Dead") then
                    local v98 = v97:FindFirstChildWhichIsA("Humanoid", true)
                    if v98 == nil then
                        v96 = false
                    else
                        v96 = v98.Health > 0
                    end
                else
                    v96 = false
                end
            else
                v96 = false
            end
            if not (v93 and (v94 and v96)) then
                v_u_1.Stop(false, true)
                local v99 = v92 and (v96 and v92:FindFirstChildWhichIsA("Humanoid", true))
                if v99 then
                    local v100 = v_u_11.new(p77, v92, v99)
                    v_u_31 = v100
                    v_u_1.ListenToSpectate:Fire(p77)
                    v100.StopSpectating:Once(function()
                        v_u_1.Stop(false, true)
                        v_u_1.Next()
                    end)
                    v_u_16.Spectate.SpectatePlayer.Send(p77.Name)
                    return
                end
                v_u_1.Next()
            end
        else
            v_u_1.Next()
        end
    end
end
function v_u_1.Switch()
    local v101 = workspace:GetAttribute("ServerGamemode")
    local v102
    if ((typeof(v101) ~= "string" or v101 ~= "Casual" and (v101 ~= "Competitive" and v101 ~= "Deathmatch")) and "Casual" or v101) == "Competitive" then
        local v103 = v_u_7:GetAttribute("Team")
        if v103 == "Counter-Terrorists" and true or v103 == "Terrorists" then
            local v104 = v_u_7
            local v105 = v104:GetAttribute("Team")
            local v106
            if (v105 == "Counter-Terrorists" and true or v105 == "Terrorists") and (v104 ~= v_u_7 or not v_u_24) then
                local v107 = v104.Character
                if v107 and v107:IsDescendantOf(workspace) and not v107:GetAttribute("Dead") then
                    local v108 = v107:FindFirstChildWhichIsA("Humanoid", true)
                    if v108 == nil then
                        v106 = false
                    else
                        v106 = v108.Health > 0
                    end
                else
                    v106 = false
                end
            else
                v106 = false
            end
            v102 = not v106
        else
            v102 = false
        end
    else
        v102 = false
    end
    if v102 then
        v_u_21 = "First-Person"
        v_u_25 = 1
        if v_u_31 then
            v_u_31:Switch("First-Person")
        end
        if v_u_32 then
            v_u_32:Destroy()
            v_u_32 = nil
        end
    else
        local v109 = v_u_25 + 1
        if #v_u_30 < v109 then
            v_u_21 = v_u_30[1]
            v_u_25 = 1
        elseif v109 <= #v_u_30 then
            v_u_21 = v_u_30[v109]
            v_u_25 = v109
        end
        if v_u_31 then
            v_u_31:Switch(v_u_21)
        end
    end
end
function v_u_1.UpdateIndex(p110)
    v_u_70()
    if #v_u_22 > 0 then
        v_u_26 = v_u_26 + p110
        if v_u_26 <= 0 then
            v_u_26 = #v_u_22
        elseif v_u_26 > #v_u_22 then
            v_u_26 = 1
        end
    end
    return v_u_14.new(function(p111, p112)
        local v113 = v_u_22[v_u_26]
        if v113 then
            local v114 = v113:GetAttribute("Team")
            local v115
            if (v114 == "Counter-Terrorists" and true or v114 == "Terrorists") and (v113 ~= v_u_7 or not v_u_24) then
                local v116 = v113.Character
                if v116 and v116:IsDescendantOf(workspace) and not v116:GetAttribute("Dead") then
                    local v117 = v116:FindFirstChildWhichIsA("Humanoid", true)
                    if v117 == nil then
                        v115 = false
                    else
                        v115 = v117.Health > 0
                    end
                else
                    v115 = false
                end
            else
                v115 = false
            end
            if v115 then
                p111(v113)
                return
            end
        end
        v_u_70()
        if #v_u_22 > 0 then
            v_u_26 = 1
            p111(v_u_22[1])
        else
            v_u_1.Stop(false, false)
            p112("No players alive to spectate")
        end
    end)
end
function v_u_1.Next()
    return v_u_1.UpdateIndex(1):andThen(function(p118)
        v_u_1.SetNextPlayer(p118)
    end):catch(function() end)
end
function v_u_1.Previous()
    return v_u_1.UpdateIndex(-1):andThen(function(p119)
        v_u_1.SetNextPlayer(p119)
    end):catch(function() end)
end
function v_u_1.Stop(p120, p121)
    if v_u_29 and v_u_7.ReplicationFocus == v_u_29 then
        v_u_7.ReplicationFocus = nil
    end
    v_u_28 = nil
    v_u_29 = nil
    if v_u_31 then
        v_u_31:Destroy()
        v_u_31 = nil
        if p120 then
            v_u_16.Spectate.StopSpectating.Send()
        end
    end
    if p121 and v_u_32 then
        v_u_32:Destroy()
        v_u_32 = nil
    end
    v_u_19:Fire()
end
function v_u_1.Broadcast()
    local v122 = v_u_7:GetAttribute("Spectators")
    local v123 = v122 and v122 > 0 and 0.016666666666666666 or 0.2
    if v123 <= v_u_27 then
        local v124 = v_u_8.getCurrentEquipped()
        v_u_27 = v_u_27 - v123
        if v124 then
            local v125 = v_u_7.PlayerGui:FindFirstChild("MainGui")
            if v125 then
                v125 = v_u_7.PlayerGui.MainGui:FindFirstChild("Menu")
            end
            if v125 then
                v125 = v125:FindFirstChild("Inspect")
            end
            if v125 and v125.Visible then
                return
            elseif not v_u_10.IsCaseSceneActive() then
                v_u_16.Spectate.UpdateCameraCFrame.Send(v_u_18.CFrame)
            end
        end
    end
end
function v_u_1.Render(p126)
    v_u_23 = v_u_23 + p126
    v_u_27 = v_u_27 + p126
    local v127 = workspace:GetAttribute("ServerGamemode")
    local v128
    if ((typeof(v127) ~= "string" or v127 ~= "Casual" and (v127 ~= "Competitive" and v127 ~= "Deathmatch")) and "Casual" or v127) == "Competitive" then
        local v129 = v_u_7:GetAttribute("Team")
        if v129 == "Counter-Terrorists" and true or v129 == "Terrorists" then
            local v130 = v_u_7
            local v131 = v130:GetAttribute("Team")
            local v132
            if (v131 == "Counter-Terrorists" and true or v131 == "Terrorists") and (v130 ~= v_u_7 or not v_u_24) then
                local v133 = v130.Character
                if v133 and v133:IsDescendantOf(workspace) and not v133:GetAttribute("Dead") then
                    local v134 = v133:FindFirstChildWhichIsA("Humanoid", true)
                    if v134 == nil then
                        v132 = false
                    else
                        v132 = v134.Health > 0
                    end
                else
                    v132 = false
                end
            else
                v132 = false
            end
            v128 = not v132
        else
            v128 = false
        end
    else
        v128 = false
    end
    if v128 then
        local v135 = workspace:GetAttribute("ServerGamemode")
        local v136
        if ((typeof(v135) ~= "string" or v135 ~= "Casual" and (v135 ~= "Competitive" and v135 ~= "Deathmatch")) and "Casual" or v135) == "Competitive" then
            local v137 = v_u_7:GetAttribute("Team")
            if v137 == "Counter-Terrorists" and true or v137 == "Terrorists" then
                local v138 = v_u_7
                local v139 = v138:GetAttribute("Team")
                local v140
                if (v139 == "Counter-Terrorists" and true or v139 == "Terrorists") and (v138 ~= v_u_7 or not v_u_24) then
                    local v141 = v138.Character
                    if v141 and v141:IsDescendantOf(workspace) and not v141:GetAttribute("Dead") then
                        local v142 = v141:FindFirstChildWhichIsA("Humanoid", true)
                        if v142 == nil then
                            v140 = false
                        else
                            v140 = v142.Health > 0
                        end
                    else
                        v140 = false
                    end
                else
                    v140 = false
                end
                v136 = not v140
            else
                v136 = false
            end
        else
            v136 = false
        end
        if v136 then
            v_u_21 = "First-Person"
            v_u_25 = 1
            if v_u_31 and v_u_31.PerspectiveState ~= "First-Person" then
                v_u_31:Switch("First-Person")
            end
            if v_u_32 then
                v_u_32:Destroy()
                v_u_32 = nil
            end
        end
    end
    if v_u_24 then
        local v143 = v_u_7.Character
        local v144
        if v143 and v143:IsDescendantOf(workspace) and not v143:GetAttribute("Dead") then
            local v145 = v143:FindFirstChildWhichIsA("Humanoid", true)
            if v145 == nil then
                v144 = false
            else
                v144 = v145.Health > 0
            end
        else
            v144 = false
        end
        if v144 then
            v_u_24 = false
        end
    end
    local v146 = v_u_7
    local v147 = v146:GetAttribute("Team")
    local v148
    if (v147 == "Counter-Terrorists" and true or v147 == "Terrorists") and (v146 ~= v_u_7 or not v_u_24) then
        local v149 = v146.Character
        if v149 and v149:IsDescendantOf(workspace) and not v149:GetAttribute("Dead") then
            local v150 = v149:FindFirstChildWhichIsA("Humanoid", true)
            if v150 == nil then
                v148 = false
            else
                v148 = v150.Health > 0
            end
        else
            v148 = false
        end
    else
        v148 = false
    end
    if v148 then
        v_u_1.Broadcast()
        if v_u_29 and v_u_7.ReplicationFocus == v_u_29 then
            v_u_7.ReplicationFocus = nil
        end
        v_u_28 = nil
        v_u_29 = nil
        if v_u_31 then
            v_u_1.Stop(true, true)
        end
        if v_u_32 then
            v_u_32:Destroy()
            v_u_32 = nil
        end
        local v151 = v_u_7
        local v152 = v151:GetAttribute("Team")
        local v153
        if (v152 == "Counter-Terrorists" and true or v152 == "Terrorists") and (v151 ~= v_u_7 or not v_u_24) then
            local v154 = v151.Character
            if v154 and v154:IsDescendantOf(workspace) and not v154:GetAttribute("Dead") then
                local v155 = v154:FindFirstChildWhichIsA("Humanoid", true)
                if v155 == nil then
                    v153 = false
                else
                    v153 = v155.Health > 0
                end
            else
                v153 = false
            end
        else
            v153 = false
        end
        if v153 then
            local v156 = v_u_7.Character:FindFirstChild("Humanoid")
            if v156 then
                v_u_18.CameraType = Enum.CameraType.Custom
                v_u_18.CameraSubject = v156
            end
            v_u_9.setPerspective(true, false)
            return
        end
    elseif v_u_42() or v_u_7:GetAttribute("IsSpectating") then
        if v_u_10.IsCaseSceneActive() then
            return
        end
        if v_u_31 then
            if v_u_29 and v_u_7.ReplicationFocus == v_u_29 then
                v_u_7.ReplicationFocus = nil
            end
            v_u_28 = nil
            v_u_29 = nil
            if v_u_17.broadcastRouter("IsInspectActive") then
                return
            end
            v_u_31:Render(p126)
            if v_u_32 then
                v_u_32:Destroy()
                v_u_32 = nil
                return
            end
        else
            if v_u_23 >= 0.2 then
                v_u_23 = 0
                v_u_70()
                if #v_u_22 > 0 then
                    v_u_26 = v_u_26 + 1
                    if v_u_26 <= 0 then
                        v_u_26 = #v_u_22
                    elseif v_u_26 > #v_u_22 then
                        v_u_26 = 1
                    end
                end
            end
            if v_u_22[v_u_26] then
                if v_u_29 and v_u_7.ReplicationFocus == v_u_29 then
                    v_u_7.ReplicationFocus = nil
                end
                v_u_28 = nil
                v_u_29 = nil
                v_u_1.Next()
                return
            end
            if v128 then
                v_u_28 = not (v_u_28 and v_u_28.Parent) and v_u_34()
                if v_u_28 then
                    v_u_9.setPerspective(false, false)
                    v_u_9.updateCameraFOV(v_u_20.DEFAULT_CAMERA_FOV)
                end
                if v_u_28 then
                    local v157 = v_u_28
                    local v158
                    if v157 and v157.Parent then
                        local v159 = v157.PrimaryPart
                        if v159 then
                            if v_u_29 ~= v159 then
                                v_u_29 = v159
                                v_u_7.ReplicationFocus = v159
                            end
                            v_u_18.CameraType = Enum.CameraType.Follow
                            v_u_18.CameraSubject = v159
                            v158 = true
                        else
                            v158 = false
                        end
                    else
                        v158 = false
                    end
                    if v158 then
                        if v_u_32 then
                            v_u_32:Destroy()
                            v_u_32 = nil
                        end
                        return
                    end
                end
                if v_u_29 and v_u_7.ReplicationFocus == v_u_29 then
                    v_u_7.ReplicationFocus = nil
                end
                v_u_28 = nil
                v_u_29 = nil
                if v_u_32 then
                    v_u_32:Destroy()
                    v_u_32 = nil
                end
                return
            end
            if v_u_29 and v_u_7.ReplicationFocus == v_u_29 then
                v_u_7.ReplicationFocus = nil
            end
            v_u_28 = nil
            v_u_29 = nil
            v_u_32 = not v_u_32 and v_u_12.new()
            if v_u_32 then
                v_u_32:Start()
                return
            end
        end
    else
        if v_u_31 then
            v_u_1.Stop(false, true)
            return
        end
        if v_u_29 and v_u_7.ReplicationFocus == v_u_29 then
            v_u_7.ReplicationFocus = nil
        end
        v_u_28 = nil
        v_u_29 = nil
    end
end
function v_u_1.Initialize()
    v_u_13.observeAttribute(v_u_7, "IsSpectating", function(p160)
        if p160 then
            if v_u_10.IsCaseSceneActive() then
                return function()
                    v_u_1.Stop(false, true)
                end
            end
            v_u_9.updateCameraFOV(v_u_20.DEFAULT_CAMERA_FOV)
            v_u_9.setPerspective(true, false)
            if not v_u_31 then
                local v161 = v_u_7:GetAttribute("LastKiller")
                local v162
                if v161 then
                    v_u_7:SetAttribute("LastKiller", nil)
                    v162 = v_u_5:FindFirstChild(v161)
                    if v162 then
                        local v163
                        if v162 == v_u_7 then
                            v163 = false
                        else
                            local v164 = v162:GetAttribute("Team")
                            local v165
                            if (v164 == "Counter-Terrorists" and true or v164 == "Terrorists") and (v162 ~= v_u_7 or not v_u_24) then
                                local v166 = v162.Character
                                if v166 and v166:IsDescendantOf(workspace) and not v166:GetAttribute("Dead") then
                                    local v167 = v166:FindFirstChildWhichIsA("Humanoid", true)
                                    if v167 == nil then
                                        v165 = false
                                    else
                                        v165 = v167.Health > 0
                                    end
                                else
                                    v165 = false
                                end
                            else
                                v165 = false
                            end
                            if v165 then
                                local v168 = workspace:GetAttribute("ServerGamemode")
                                local v169
                                if ((typeof(v168) ~= "string" or v168 ~= "Casual" and (v168 ~= "Competitive" and v168 ~= "Deathmatch")) and "Casual" or v168) == "Competitive" then
                                    local v170 = v_u_7:GetAttribute("Team")
                                    if v170 == "Counter-Terrorists" and true or v170 == "Terrorists" then
                                        local v171 = v_u_7
                                        local v172 = v171:GetAttribute("Team")
                                        local v173
                                        if (v172 == "Counter-Terrorists" and true or v172 == "Terrorists") and (v171 ~= v_u_7 or not v_u_24) then
                                            local v174 = v171.Character
                                            if v174 and v174:IsDescendantOf(workspace) and not v174:GetAttribute("Dead") then
                                                local v175 = v174:FindFirstChildWhichIsA("Humanoid", true)
                                                if v175 == nil then
                                                    v173 = false
                                                else
                                                    v173 = v175.Health > 0
                                                end
                                            else
                                                v173 = false
                                            end
                                        else
                                            v173 = false
                                        end
                                        v169 = not v173
                                    else
                                        v169 = false
                                    end
                                else
                                    v169 = false
                                end
                                v163 = (not v169 or v_u_7:GetAttribute("Team") == v162:GetAttribute("Team")) and true or false
                            else
                                v163 = false
                            end
                        end
                        if not v163 then
                            v162 = nil
                        end
                    else
                        v162 = nil
                    end
                else
                    v162 = nil
                end
                if v162 then
                    v_u_1.SetNextPlayer(v162)
                else
                    v_u_1.Next()
                end
            end
        end
        return function()
            v_u_1.Stop(false, true)
        end
    end)
    v_u_16.Character.CharacterDied.Listen(function()
        local v176 = v_u_7.Character
        local v177
        if v176 and v176:IsDescendantOf(workspace) and not v176:GetAttribute("Dead") then
            local v178 = v176:FindFirstChildWhichIsA("Humanoid", true)
            if v178 == nil then
                v177 = false
            else
                v177 = v178.Health > 0
            end
        else
            v177 = false
        end
        if v177 then
            v_u_24 = false
        else
            v_u_24 = true
            v_u_58()
        end
    end)
    v_u_7.CharacterAdded:Connect(function(p_u_179)
        v_u_24 = false
        local v180 = v_u_7:GetAttribute("Team")
        local v181 = v180 == "Counter-Terrorists" and true or v180 == "Terrorists"
        local v182 = p_u_179:FindFirstChildWhichIsA("Humanoid", true)
        if v182 then
            if v182.Health > 0 then
                v182 = not p_u_179:GetAttribute("Dead")
            else
                v182 = false
            end
        end
        if v181 and v182 then
            v_u_1.Stop(true, true)
            if v_u_7:GetAttribute("IsSpectating") then
                v_u_16.Spectate.StopSpectating.Send()
            end
        elseif v_u_31 and v_u_31.Player then
            v_u_16.Spectate.SpectatePlayer.Send(v_u_31.Player.Name)
        end
        local v_u_183 = p_u_179:GetAttributeChangedSignal("Dead"):Connect(function()
            if p_u_179:GetAttribute("Dead") then
                v_u_58()
            end
        end)
        local v_u_184 = nil
        v_u_184 = p_u_179.AncestryChanged:Connect(function(_, p185)
            if not p185 then
                if v_u_183 then
                    v_u_183:Disconnect()
                    v_u_183 = nil
                end
                if v_u_184 then
                    v_u_184:Disconnect()
                    v_u_184 = nil
                end
            end
        end)
    end)
    require(v_u_2.Database.Components.GameState).ListenToState(function(_, p186)
        if p186 == "Game Ending" or p186 == "Map Voting" then
            v_u_1.Stop(false, true)
        end
    end)
    v_u_4.RenderStepped:Connect(function(p187)
        v_u_1.Render(p187)
    end)
end
function v_u_1.Start()
    v_u_16.Spectate.ReplicateSpectateEvent.Listen(function(...)
        if v_u_31 then
            v_u_31:AddSpectateEvent(...)
        end
    end)
    v_u_3.InputBegan:Connect(function(p188)
        if v_u_7:GetAttribute("IsSpectating") and (p188.KeyCode == Enum.KeyCode.Space and not v_u_7:GetAttribute("IsPlayerChatting")) then
            v_u_1.Switch()
        end
    end)
    if v_u_3.TouchEnabled then
        v_u_3.TouchStarted:Connect(function(p189, p190)
            if p190 or v_u_7:GetAttribute("IsPlayerChatting") then
                return
            elseif v_u_7:GetAttribute("IsSpectating") then
                local v191 = p189.Position
                if v_u_18.ViewportSize.X / 2 > v191.X then
                    v_u_1.Previous()
                else
                    v_u_1.Next()
                end
            else
                return
            end
        end)
    end
end
return v_u_1