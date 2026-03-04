local v_u_1 = require(script.Parent.Janitor)
local v2 = require(script.Parent.Enum)
require(script.Parent.Signal)
local v_u_3 = require(script.Tracker)
local v_u_4 = require(script.CollectiveWorldModel)
local v_u_5 = v2.enums
local v_u_6 = game:GetService("Players")
local v_u_7 = {}
local v_u_8 = 0
local v_u_9 = {}
local v_u_10 = {}
local v_u_11 = {}
local v_u_12 = {}
local v_u_13 = {}
local v_u_14 = {}
local v_u_15 = 0
local v16 = game:GetService("RunService")
local v_u_17 = v16.Heartbeat
local v_u_18 = {}
local v_u_19 = v16:IsClient()
if v_u_19 then
    v_u_19 = v_u_6.LocalPlayer
end
local v_u_20 = {}
local v_u_21 = {
    ["player"] = v_u_3.new("player"),
    ["item"] = v_u_3.new("item")
}
v_u_20.trackers = v_u_21
local v_u_32 = {
    ["player"] = function(p22)
        return v_u_20._getZonesAndItems("player", v_u_7, v_u_8, true, p22)
    end,
    ["localPlayer"] = function(p23)
        local v24 = {}
        local v25 = v_u_19.Character
        if not v25 then
            return v24
        end
        local v26 = v_u_20.getTouchingZones(v25, true, p23, v_u_21.player)
        for _, v27 in pairs(v26) do
            if v27.activeTriggers.localPlayer then
                local v28 = v_u_19
                local v29 = v24[v27]
                if not v29 then
                    v29 = {}
                    v24[v27] = v29
                end
                local v30 = v28:IsA("Player")
                if v30 then
                    v30 = v28.Character
                end
                v29[v28] = v30 or true
            end
        end
        return v24
    end,
    ["item"] = function(p31)
        return v_u_20._getZonesAndItems("item", v_u_7, v_u_8, true, p31)
    end
}
function v_u_20._registerZone(p33)
    v_u_10[p33] = true
    local v34 = p33.janitor:add(v_u_1.new(), "destroy")
    p33._registeredJanitor = v34
    v34:add(p33.updated:Connect(function()
        v_u_20._updateZoneDetails()
    end), "Disconnect")
    v_u_20._updateZoneDetails()
end
function v_u_20._deregisterZone(p35)
    v_u_10[p35] = nil
    p35._registeredJanitor:destroy()
    p35._registeredJanitor = nil
    v_u_20._updateZoneDetails()
end
function v_u_20._registerConnection(p36, p37)
    local v38 = p36.activeTriggers
    local v39 = 0
    for _, _ in pairs(v38) do
        v39 = v39 + 1
    end
    v_u_15 = v_u_15 + 1
    if v39 == 0 then
        v_u_7[p36] = true
        v_u_20._updateZoneDetails()
    end
    local v40 = v_u_9[p37]
    v_u_9[p37] = v40 and v40 + 1 or 1
    p36.activeTriggers[p37] = true
    if p36.touchedConnectionActions[p37] then
        p36:_formTouchedConnection(p37)
    end
    if v_u_32[p37] then
        v_u_20._formHeartbeat(p37)
    end
end
function v_u_20.updateDetection(p41)
    for v42, v43 in pairs({
        ["enterDetection"] = "_currentEnterDetection",
        ["exitDetection"] = "_currentExitDetection"
    }) do
        local v44 = p41[v42]
        local v45 = v_u_3.getCombinedTotalVolumes()
        if v44 == v_u_5.Detection.Automatic then
            if v45 > 729000 then
                v44 = v_u_5.Detection.Centre
            else
                v44 = v_u_5.Detection.WholeBody
            end
        end
        p41[v43] = v44
    end
end
function v_u_20._formHeartbeat(p_u_46)
    if not v_u_18[p_u_46] then
        local v_u_47 = 0
        v_u_18[p_u_46] = v_u_17:Connect(function()
            local v48 = os.clock()
            if v_u_47 <= v48 then
                local v49 = nil
                local v50 = nil
                for v51, _ in pairs(v_u_7) do
                    if v51.activeTriggers[p_u_46] then
                        local v52 = v51.accuracy
                        if v49 ~= nil and v52 >= v49 then
                            v52 = v49
                        end
                        v_u_20.updateDetection(v51)
                        local v53 = v51._currentEnterDetection
                        if v50 == nil or v53 < v50 then
                            v50 = v53
                            v49 = v52
                        else
                            v49 = v52
                        end
                    end
                end
                local v54 = v_u_32[p_u_46](v50)
                local v55 = {}
                local v56 = {}
                for v57, v58 in pairs(v54) do
                    local v59 = v57.settingsGroupName
                    if v59 then
                        v59 = v_u_20.getGroup(v57.settingsGroupName)
                    end
                    if v59 and v59.onlyEnterOnceExitedAll == true then
                        for v60, _ in pairs(v58) do
                            local v61 = v55[v57.settingsGroupName]
                            if not v61 then
                                v61 = {}
                                v55[v57.settingsGroupName] = v61
                            end
                            v61[v60] = v57
                        end
                        v56[v57] = v58
                    end
                end
                for v62, v63 in pairs(v56) do
                    local v64 = v55[v62.settingsGroupName]
                    if v64 then
                        for v65, _ in pairs(v63) do
                            local v66 = v64[v65]
                            if v66 and v66 ~= v62 then
                                v63[v65] = nil
                            end
                        end
                    end
                end
                local v67 = {
                    {},
                    {}
                }
                for v68, _ in pairs(v_u_7) do
                    if v68.activeTriggers[p_u_46] then
                        local v69 = v68.accuracy
                        local v70 = v54[v68] or {}
                        local v71 = false
                        for _, _ in pairs(v70) do
                            v71 = true
                            break
                        end
                        if v71 then
                            if v49 >= v69 then
                                v69 = v49
                            end
                        else
                            v69 = v49
                        end
                        local v72 = v68:_updateOccupants(p_u_46, v70)
                        v67[1][v68] = v72.exited
                        v67[2][v68] = v72.entered
                        v49 = v69
                    end
                end
                local v73 = { "Exited", "Entered" }
                for v74, v75 in pairs(v67) do
                    local v76 = p_u_46 .. v73[v74]
                    for v77, v78 in pairs(v75) do
                        local v79 = v77[v76]
                        if v79 then
                            for _, v80 in pairs(v78) do
                                v79:Fire(v80)
                            end
                        end
                    end
                end
                v_u_47 = v48 + v_u_5.Accuracy.getProperty(v49)
            end
        end)
    end
end
function v_u_20._deregisterConnection(p81, p82)
    v_u_15 = v_u_15 - 1
    if v_u_9[p82] == 1 then
        v_u_9[p82] = nil
        local v83 = v_u_18[p82]
        if v83 then
            v_u_18[p82] = nil
            v83:Disconnect()
        end
    else
        local v84 = v_u_9
        v84[p82] = v84[p82] - 1
    end
    p81.activeTriggers[p82] = nil
    local v85 = p81.activeTriggers
    local v86 = 0
    for _, _ in pairs(v85) do
        v86 = v86 + 1
    end
    if v86 == 0 then
        v_u_7[p81] = nil
        v_u_20._updateZoneDetails()
    end
    if p81.touchedConnectionActions[p82] then
        p81:_disconnectTouchedConnection(p82)
    end
end
function v_u_20._updateZoneDetails()
    v_u_11 = {}
    v_u_12 = {}
    v_u_13 = {}
    v_u_14 = {}
    v_u_8 = 0
    for v87, _ in pairs(v_u_10) do
        local v88 = v_u_7[v87]
        if v88 then
            v_u_8 = v_u_8 + v87.volume
        end
        for _, v89 in pairs(v87.zoneParts) do
            if v88 then
                local v90 = v_u_11
                table.insert(v90, v89)
                v_u_12[v89] = v87
            end
            local v91 = v_u_13
            table.insert(v91, v89)
            v_u_14[v89] = v87
        end
    end
end
function v_u_20._getZonesAndItems(p92, p93, p94, p95, p96)
    if not p94 then
        for v97, _ in pairs(p93) do
            p94 = p94 + v97.volume
        end
    end
    local v98 = {}
    local v99 = v_u_21[p92]
    if v99.totalVolume < p94 then
        for _, v100 in pairs(v99.items) do
            local v101 = v_u_20.getTouchingZones(v100, p95, p96, v99)
            for _, v102 in pairs(v101) do
                if not p95 or v102.activeTriggers[p92] then
                    local v103
                    if p92 == "player" then
                        v103 = v_u_6:GetPlayerFromCharacter(v100)
                    else
                        v103 = v100
                    end
                    if v103 then
                        local v104 = v98[v102]
                        if not v104 then
                            v104 = {}
                            v98[v102] = v104
                        end
                        local v105 = v103:IsA("Player")
                        if v105 then
                            v105 = v103.Character
                        end
                        v104[v103] = v105 or true
                    end
                end
            end
        end
        return v98
    else
        for v106, _ in pairs(p93) do
            if not p95 or v106.activeTriggers[p92] then
                local v107 = v_u_4:GetPartBoundsInBox(v106.region.CFrame, v106.region.Size, v99.whitelistParams)
                local v108 = {}
                for _, v109 in pairs(v107) do
                    local v110 = v99.partToItem[v109]
                    if not v108[v110] then
                        v108[v110] = true
                    end
                end
                for v111, _ in pairs(v108) do
                    if p92 == "player" then
                        local v112 = v_u_6:GetPlayerFromCharacter(v111)
                        if v106:findPlayer(v112) then
                            local v113 = v98[v106]
                            if not v113 then
                                v113 = {}
                                v98[v106] = v113
                            end
                            local v114 = v112:IsA("Player")
                            if v114 then
                                v114 = v112.Character
                            end
                            v113[v112] = v114 or true
                        end
                    elseif v106:findItem(v111) then
                        local v115 = v98[v106]
                        if not v115 then
                            v115 = {}
                            v98[v106] = v115
                        end
                        local v116 = v111:IsA("Player")
                        if v116 then
                            v116 = v111.Character
                        end
                        v115[v111] = v116 or true
                    end
                end
            end
        end
        return v98
    end
end
function v_u_20.getZones()
    local v117 = {}
    for v118, _ in pairs(v_u_10) do
        table.insert(v117, v118)
    end
    return v117
end
function v_u_20.getTouchingZones(p119, p120, p121, p122)
    local v123
    if p122 then
        v123 = p122.exitDetections[p119]
        p122.exitDetections[p119] = nil
    else
        v123 = nil
    end
    local v124 = v123 or p121
    local v125 = nil
    local v126 = nil
    local v127 = p119:IsA("BasePart")
    local v128 = not v127
    local v129 = {}
    if v127 then
        v125 = p119.Size
        v126 = p119.CFrame
        table.insert(v129, p119)
    elseif v124 == v_u_5.Detection.WholeBody then
        v125, v126 = v_u_3.getCharacterSize(p119)
        v129 = p119:GetChildren()
    else
        local v130 = p119:FindFirstChild("HumanoidRootPart")
        if v130 then
            v125 = v130.Size
            v126 = v130.CFrame
            table.insert(v129, v130)
        end
    end
    if not (v125 and v126) then
        return {}
    end
    local v131 = p120 and v_u_11 or v_u_13
    local v132 = p120 and v_u_12 or v_u_14
    local v133 = OverlapParams.new()
    v133.FilterType = Enum.RaycastFilterType.Whitelist
    v133.MaxParts = #v131
    v133.FilterDescendantsInstances = v131
    local v134 = v_u_4:GetPartBoundsInBox(v126, v125, v133)
    local v135 = {}
    local v136 = {}
    local v137 = {}
    for _, v138 in pairs(v134) do
        local v139 = v132[v138]
        if v139 and v139.allZonePartsAreBlocks then
            v135[v139] = true
            v136[v138] = v139
        else
            table.insert(v137, v138)
        end
    end
    local v140 = #v137
    local v141 = 0
    if v140 > 0 then
        local v142 = OverlapParams.new()
        v142.FilterType = Enum.RaycastFilterType.Whitelist
        v142.MaxParts = v140
        v142.FilterDescendantsInstances = v137
        for _, v143 in pairs(v129) do
            local v144 = false
            if v143:IsA("BasePart") and not (v128 and v_u_3.bodyPartsToIgnore[v143.Name]) then
                local v145 = v_u_4:GetPartsInPart(v143, v142)
                for _, v146 in pairs(v145) do
                    if not v136[v146] then
                        local v147 = v132[v146]
                        if v147 then
                            v135[v147] = true
                            v136[v146] = v147
                            v141 = v141 + 1
                        end
                        if v141 == v140 then
                            v144 = true
                            break
                        end
                    end
                end
                if v144 then
                    break
                end
            end
        end
    end
    local v148 = nil
    local v149 = {}
    for v150, _ in pairs(v135) do
        if v148 == nil or v150._currentExitDetection < v148 then
            v148 = v150._currentExitDetection
        end
        table.insert(v149, v150)
    end
    if v148 and p122 then
        p122.exitDetections[p119] = v148
    end
    return v149, v136
end
local v_u_151 = {}
function v_u_20.setGroup(p152, p153)
    local v154 = v_u_151[p152]
    if not v154 then
        v154 = {}
        v_u_151[p152] = v154
    end
    v154.onlyEnterOnceExitedAll = true
    v154._name = p152
    v154._memberZones = {}
    if typeof(p153) == "table" then
        for v155, v156 in pairs(p153) do
            v154[v155] = v156
        end
    end
    return v154
end
function v_u_20.getGroup(p157)
    return v_u_151[p157]
end
local v_u_158 = nil
local v_u_159 = string.format("ZonePlus%sContainer", v16:IsClient() and "Client" or "Server")
function v_u_20.getWorkspaceContainer()
    local v160 = v_u_158 or workspace:FindFirstChild(v_u_159)
    if not v160 then
        v160 = Instance.new("Folder")
        v160.Name = v_u_159
        v160.Parent = workspace
        v_u_158 = v160
    end
    return v160
end
return v_u_20