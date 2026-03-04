local v1 = game:GetService("Players")
local v_u_2 = game:GetService("RunService")
local v_u_3 = v_u_2.Heartbeat
local v_u_4 = v_u_2:IsClient()
if v_u_4 then
    v_u_4 = v1.LocalPlayer
end
game:GetService("ReplicatedStorage")
local v_u_5 = game:GetService("HttpService")
local v_u_6 = require(script.Enum).enums
local v_u_7 = require(script.Janitor)
local v_u_8 = require(script.Signal)
local v9 = require(script.ZonePlusReference)
local v10 = v9.getObject()
local v11 = script.ZoneController
local v_u_12 = v11.Tracker
local v_u_13 = v11.CollectiveWorldModel
local v_u_14 = require(v11)
local v15 = game:GetService("RunService"):IsClient() and "Client" or "Server"
local v16
if v10 then
    v16 = v10:FindFirstChild(v15)
else
    v16 = v10
end
if v16 then
    return require(v10.Value)
end
local v_u_17 = {}
v_u_17.__index = v_u_17
if not v16 then
    v9.addToReplicatedStorage()
end
v_u_17.enum = v_u_6
function v_u_17.new(p18)
    local v_u_19 = {}
    local v20 = v_u_17
    setmetatable(v_u_19, v20)
    local v21 = typeof(p18)
    if v21 ~= "table" and v21 ~= "Instance" then
        error("The zone container must be a model, folder, basepart or table!")
    end
    v_u_19.accuracy = v_u_6.Accuracy.High
    v_u_19.autoUpdate = true
    v_u_19.respectUpdateQueue = true
    local v22 = v_u_7.new()
    v_u_19.janitor = v22
    v_u_19._updateConnections = v22:add(v_u_7.new(), "destroy")
    v_u_19.container = p18
    v_u_19.zoneParts = {}
    v_u_19.overlapParams = {}
    v_u_19.region = nil
    v_u_19.volume = nil
    v_u_19.boundMin = nil
    v_u_19.boundMax = nil
    v_u_19.recommendedMaxParts = nil
    v_u_19.zoneId = v_u_5:GenerateGUID()
    v_u_19.activeTriggers = {}
    v_u_19.occupants = {}
    v_u_19.trackingTouchedTriggers = {}
    v_u_19.enterDetection = v_u_6.Detection.Centre
    v_u_19.exitDetection = v_u_6.Detection.Centre
    v_u_19._currentEnterDetection = nil
    v_u_19._currentExitDetection = nil
    v_u_19.totalPartVolume = 0
    v_u_19.allZonePartsAreBlocks = true
    v_u_19.trackedItems = {}
    v_u_19.settingsGroupName = nil
    v_u_19.worldModel = workspace
    v_u_19.onItemDetails = {}
    v_u_19.itemsToUntrack = {}
    v_u_14.updateDetection(v_u_19)
    v_u_19.updated = v22:add(v_u_8.new(), "destroy")
    local v23 = {
        "player",
        "part",
        "localPlayer",
        "item"
    }
    local v24 = { "entered", "exited" }
    for _, v_u_25 in pairs(v23) do
        local v_u_26 = 0
        local v_u_27 = 0
        for _, v28 in pairs(v24) do
            local v29 = v22:add(v_u_8.new(true), "destroy")
            local v_u_30 = v28:sub(1, 1):upper() .. v28:sub(2)
            v_u_19[v_u_25 .. v_u_30] = v29
            v29.connectionsChanged:Connect(function(p31)
                if v_u_25 == "localPlayer" and (not v_u_4 and p31 == 1) then
                    error(("Can only connect to \'localPlayer%s\' on the client!"):format(v_u_30))
                end
                v_u_26 = v_u_27
                v_u_27 = v_u_27 + p31
                if v_u_26 == 0 and v_u_27 > 0 then
                    v_u_14._registerConnection(v_u_19, v_u_25, v_u_30)
                elseif v_u_26 > 0 and v_u_27 == 0 then
                    v_u_14._deregisterConnection(v_u_19, v_u_25)
                end
            end)
        end
    end
    v_u_17.touchedConnectionActions = {}
    for _, v32 in pairs(v23) do
        local v_u_33 = v_u_19[("_%sTouchedZone"):format(v32)]
        if v_u_33 then
            v_u_19.trackingTouchedTriggers[v32] = {}
            v_u_17.touchedConnectionActions[v32] = function(p34)
                v_u_33(v_u_19, p34)
            end
        end
    end
    v_u_19:_update()
    v_u_14._registerZone(v_u_19)
    v22:add(function()
        v_u_14._deregisterZone(v_u_19)
    end, true)
    return v_u_19
end
function v_u_17.fromRegion(p35, p36)
    local v_u_37 = Instance.new("Model")
    local function v_u_43(p38, p39)
        if p39.X > 2024 or (p39.Y > 2024 or p39.Z > 2024) then
            local v40 = p39 * 0.25
            local v41 = p39 * 0.5
            v_u_43(p38 * CFrame.new(-v40.X, -v40.Y, -v40.Z), v41)
            v_u_43(p38 * CFrame.new(-v40.X, -v40.Y, v40.Z), v41)
            v_u_43(p38 * CFrame.new(-v40.X, v40.Y, -v40.Z), v41)
            v_u_43(p38 * CFrame.new(-v40.X, v40.Y, v40.Z), v41)
            v_u_43(p38 * CFrame.new(v40.X, -v40.Y, -v40.Z), v41)
            v_u_43(p38 * CFrame.new(v40.X, -v40.Y, v40.Z), v41)
            v_u_43(p38 * CFrame.new(v40.X, v40.Y, -v40.Z), v41)
            v_u_43(p38 * CFrame.new(v40.X, v40.Y, v40.Z), v41)
        else
            local v42 = Instance.new("Part")
            v42.CFrame = p38
            v42.Size = p39
            v42.Anchored = true
            v42.Parent = v_u_37
        end
    end
    v_u_43(p35, p36)
    local v44 = v_u_17.new(v_u_37)
    v44:relocate()
    return v44
end
function v_u_17._calculateRegion(_, p45, p46)
    local v47 = {
        ["Min"] = {},
        ["Max"] = {}
    }
    for v_u_48, v49 in pairs(v47) do
        v49.Values = {}
        function v49.parseCheck(p50, p51)
            if v_u_48 == "Min" then
                return p50 <= p51
            end
            if v_u_48 == "Max" then
                return p51 <= p50
            end
        end
        function v49.parse(p52, p53)
            for v54, v55 in pairs(p53) do
                local v56 = p52.Values[v54] or v55
                if p52.parseCheck(v55, v56) then
                    p52.Values[v54] = v55
                end
            end
        end
    end
    for _, v57 in pairs(p45) do
        local v58 = v57.Size * 0.5
        local v59 = {
            v57.CFrame * CFrame.new(-v58.X, -v58.Y, -v58.Z),
            v57.CFrame * CFrame.new(-v58.X, -v58.Y, v58.Z),
            v57.CFrame * CFrame.new(-v58.X, v58.Y, -v58.Z),
            v57.CFrame * CFrame.new(-v58.X, v58.Y, v58.Z),
            v57.CFrame * CFrame.new(v58.X, -v58.Y, -v58.Z),
            v57.CFrame * CFrame.new(v58.X, -v58.Y, v58.Z),
            v57.CFrame * CFrame.new(v58.X, v58.Y, -v58.Z),
            v57.CFrame * CFrame.new(v58.X, v58.Y, v58.Z)
        }
        for _, v60 in pairs(v59) do
            local v61, v62, v63 = v60:GetComponents()
            local v64 = { v61, v62, v63 }
            v47.Min:parse(v64)
            v47.Max:parse(v64)
        end
    end
    local v65 = {}
    local v66 = {}
    for v67, v68 in pairs(v47) do
        for _, v72 in pairs(v68.Values) do
            local v70 = v67 == "Min" and v66 and v66 or v65
            if not p46 then
                local v71 = (v72 + (v67 == "Min" and -2 or 2) + 2) / 4
                local v72 = math.floor(v71) * 4
            end
            table.insert(v70, v72)
        end
    end
    local v73 = unpack
    local v74 = Vector3.new(v73(v66))
    local v75 = unpack
    local v76 = Vector3.new(v75(v65))
    return Region3.new(v74, v76), v74, v76
end
function v_u_17._displayBounds(p77)
    if not p77.displayBoundParts then
        p77.displayBoundParts = true
        local v78 = {
            ["BoundMin"] = p77.boundMin,
            ["BoundMax"] = p77.boundMax
        }
        for v79, v80 in pairs(v78) do
            local v81 = Instance.new("Part")
            v81.Anchored = true
            v81.CanCollide = false
            v81.Transparency = 0.5
            v81.Size = Vector3.new(1, 1, 1)
            v81.Color = Color3.fromRGB(255, 0, 0)
            v81.CFrame = CFrame.new(v80)
            v81.Name = v79
            v81.Parent = workspace
            p77.janitor:add(v81, "Destroy")
        end
    end
end
function v_u_17._update(p_u_82)
    local v83 = p_u_82.container
    local v84 = {}
    local v_u_85 = 0
    p_u_82._updateConnections:clean()
    local v86 = typeof(v83)
    local v87 = {}
    if v86 == "table" then
        for _, v88 in pairs(v83) do
            if v88:IsA("BasePart") then
                table.insert(v84, v88)
            end
        end
    elseif v86 == "Instance" then
        if v83:IsA("BasePart") then
            table.insert(v84, v83)
        else
            table.insert(v87, v83)
            for _, v89 in pairs(v83:GetDescendants()) do
                if v89:IsA("BasePart") then
                    table.insert(v84, v89)
                else
                    table.insert(v87, v89)
                end
            end
        end
    end
    p_u_82.zoneParts = v84
    p_u_82.overlapParams = {}
    local v90 = true
    for _, v_u_91 in pairs(v84) do
        local _, v92 = pcall(function()
            return v_u_91.Shape.Name
        end)
        if v92 ~= "Block" then
            v90 = false
        end
    end
    p_u_82.allZonePartsAreBlocks = v90
    local v93 = OverlapParams.new()
    v93.FilterType = Enum.RaycastFilterType.Include
    v93.MaxParts = #v84
    v93.FilterDescendantsInstances = v84
    p_u_82.overlapParams.zonePartsWhitelist = v93
    local v94 = OverlapParams.new()
    v94.FilterType = Enum.RaycastFilterType.Exclude
    v94.FilterDescendantsInstances = v84
    p_u_82.overlapParams.zonePartsIgnorelist = v94
    local function v97()
        if p_u_82.autoUpdate then
            local v_u_95 = os.clock()
            if p_u_82.respectUpdateQueue then
                v_u_85 = v_u_85 + 1
                v_u_95 = v_u_95 + 0.1
            end
            local v_u_96 = nil
            v_u_96 = v_u_2.Heartbeat:Connect(function()
                if v_u_95 <= os.clock() then
                    v_u_96:Disconnect()
                    if p_u_82.respectUpdateQueue then
                        v_u_85 = v_u_85 - 1
                    end
                    if v_u_85 == 0 and p_u_82.zoneId then
                        p_u_82:_update()
                    end
                end
            end)
        end
    end
    local v98 = { "Size", "Position" }
    for _, v_u_99 in pairs(v84) do
        for _, v100 in pairs(v98) do
            p_u_82._updateConnections:add(v_u_99:GetPropertyChangedSignal(v100):Connect(v97), "Disconnect")
        end
        local v101 = v_u_99.CollisionGroup
        if v101 ~= "Default" and v101 ~= "Debris" then
            error("Zone parts must belong to the \'Default\' or \'Debris\' CollisionGroup.")
        end
        p_u_82._updateConnections:add(v_u_99:GetPropertyChangedSignal("CollisionGroupId"):Connect(function()
            local v102 = v_u_99.CollisionGroup
            if v102 ~= "Default" and v102 ~= "Debris" then
                error("Zone parts must belong to the \'Default\' or \'Debris\' CollisionGroup.")
            end
        end), "Disconnect")
    end
    local v103 = { "ChildAdded", "ChildRemoved" }
    for _, _ in pairs(v87) do
        for _, v104 in pairs(v103) do
            p_u_82._updateConnections:add(p_u_82.container[v104]:Connect(function(p105)
                if p105:IsA("BasePart") and p_u_82.autoUpdate then
                    local v_u_106 = os.clock()
                    if p_u_82.respectUpdateQueue then
                        v_u_85 = v_u_85 + 1
                        v_u_106 = v_u_106 + 0.1
                    end
                    local v_u_107 = nil
                    v_u_107 = v_u_2.Heartbeat:Connect(function()
                        if v_u_106 <= os.clock() then
                            v_u_107:Disconnect()
                            if p_u_82.respectUpdateQueue then
                                v_u_85 = v_u_85 - 1
                            end
                            if v_u_85 == 0 and p_u_82.zoneId then
                                p_u_82:_update()
                            end
                        end
                    end)
                end
            end), "Disconnect")
        end
    end
    local v108, v109, v110 = p_u_82:_calculateRegion(v84)
    local v111, _, _ = p_u_82:_calculateRegion(v84, true)
    p_u_82.region = v108
    p_u_82.exactRegion = v111
    p_u_82.boundMin = v109
    p_u_82.boundMax = v110
    local v112 = v108.Size
    p_u_82.volume = v112.X * v112.Y * v112.Z
    p_u_82:_updateTouchedConnections()
    p_u_82.updated:Fire()
end
function v_u_17._updateOccupants(p113, p114, p115)
    local v116 = p113.occupants[p114]
    if not v116 then
        v116 = {}
        p113.occupants[p114] = v116
    end
    local v117 = {}
    for v118, v119 in pairs(v116) do
        local v120 = p115[v118]
        if v120 == nil or v120 ~= v119 then
            v116[v118] = nil
            if not v117.exited then
                v117.exited = {}
            end
            local v121 = v117.exited
            table.insert(v121, v118)
        end
    end
    for v122, _ in pairs(p115) do
        if v116[v122] == nil then
            v116[v122] = v122:IsA("Player") and (v122.Character or true) or true
            if not v117.entered then
                v117.entered = {}
            end
            local v123 = v117.entered
            table.insert(v123, v122)
        end
    end
    return v117
end
function v_u_17._formTouchedConnection(p124, p125)
    local v126 = "_touchedJanitor" .. p125
    local v127 = p124[v126]
    if v127 then
        v127:clean()
    else
        p124[v126] = p124.janitor:add(v_u_7.new(), "destroy")
    end
    p124:_updateTouchedConnection(p125)
end
function v_u_17._updateTouchedConnection(p128, p129)
    local v130 = p128["_touchedJanitor" .. p129]
    if v130 then
        for _, v131 in pairs(p128.zoneParts) do
            v130:add(v131.Touched:Connect(p128.touchedConnectionActions[p129], p128), "Disconnect")
        end
    end
end
function v_u_17._updateTouchedConnections(p132)
    for v133, _ in pairs(p132.touchedConnectionActions) do
        local v134 = p132["_touchedJanitor" .. v133]
        if v134 then
            v134:cleanup()
            p132:_updateTouchedConnection(v133)
        end
    end
end
function v_u_17._disconnectTouchedConnection(p135, p136)
    local v137 = "_touchedJanitor" .. p136
    local v138 = p135[v137]
    if v138 then
        v138:cleanup()
        p135[v137] = nil
    end
end
function v_u_17._partTouchedZone(p_u_139, p_u_140)
    local v_u_141 = p_u_139.trackingTouchedTriggers.part
    if not v_u_141[p_u_140] then
        local v_u_142 = 0
        local v_u_143 = false
        local v_u_144 = p_u_140.Position
        local v_u_145 = os.clock()
        local v_u_146 = p_u_139.janitor:add(v_u_7.new(), "destroy")
        v_u_141[p_u_140] = v_u_146
        if not ({
            ["Seat"] = true,
            ["VehicleSeat"] = true
        })[p_u_140.ClassName] and ({
            ["HumanoidRootPart"] = true
        })[p_u_140.Name] then
            p_u_140.CanTouch = false
        end
        local v147 = p_u_140.Size.X * p_u_140.Size.Y * p_u_140.Size.Z * 100000
        local v_u_148 = math.round(v147) * 0.00001
        p_u_139.totalPartVolume = p_u_139.totalPartVolume + v_u_148
        v_u_146:add(v_u_3:Connect(function()
            local v149 = os.clock()
            if v_u_142 <= v149 then
                local v150 = v_u_6.Accuracy.getProperty(p_u_139.accuracy)
                v_u_142 = v149 + v150
                local v151 = p_u_139:findPoint(p_u_140.CFrame) or p_u_139:findPart(p_u_140)
                if v_u_143 then
                    if not v151 then
                        v_u_143 = false
                        v_u_144 = p_u_140.Position
                        v_u_145 = os.clock()
                        p_u_139.partExited:Fire(p_u_140)
                    end
                else
                    if v151 then
                        v_u_143 = true
                        p_u_139.partEntered:Fire(p_u_140)
                        return
                    end
                    if (p_u_140.Position - v_u_144).Magnitude > 1.5 and v150 <= v149 - v_u_145 then
                        v_u_146:cleanup()
                        return
                    end
                end
            end
        end), "Disconnect")
        v_u_146:add(function()
            v_u_141[p_u_140] = nil
            p_u_140.CanTouch = true
            local v152 = p_u_139
            local v153 = (p_u_139.totalPartVolume - v_u_148) * 100000
            v152.totalPartVolume = math.round(v153) * 0.00001
        end, true)
    end
end
local v_u_157 = {
    ["Ball"] = function(p154)
        return "GetPartBoundsInRadius", { p154.Position, p154.Size.X }
    end,
    ["Block"] = function(p155)
        return "GetPartBoundsInBox", { p155.CFrame, p155.Size }
    end,
    ["Other"] = function(p156)
        return "GetPartsInPart", { p156 }
    end
}
function v_u_17._getRegionConstructor(p158, p_u_159, p160)
    local v161, v162 = pcall(function()
        return p_u_159.Shape.Name
    end)
    local v163 = nil
    local v164 = nil
    if v161 and p158.allZonePartsAreBlocks then
        local v165 = v_u_157[v162]
        if v165 then
            v163, v164 = v165(p_u_159)
        end
    end
    if not v163 then
        v163, v164 = v_u_157.Other(p_u_159)
    end
    if p160 then
        table.insert(v164, p160)
    end
    return v163, v164
end
function v_u_17.findLocalPlayer(p166)
    if not v_u_4 then
        error("Can only call \'findLocalPlayer\' on the client!")
    end
    return p166:findPlayer(v_u_4)
end
function v_u_17._find(p167, p168, p169)
    v_u_14.updateDetection(p167)
    local v170 = v_u_14.trackers[p168]
    local v171 = v_u_14.getTouchingZones(p169, false, p167._currentEnterDetection, v170)
    for _, v172 in pairs(v171) do
        if v172 == p167 then
            return true
        end
    end
    return false
end
function v_u_17.findPlayer(p173, p174)
    local v175 = p174.Character
    if v175 then
        v175 = v175:FindFirstChildOfClass("Humanoid")
    end
    if v175 then
        return p173:_find("player", p174.Character)
    else
        return false
    end
end
function v_u_17.findItem(p176, p177)
    return p176:_find("item", p177)
end
function v_u_17.findPart(p178, p179)
    local v180, v181 = p178:_getRegionConstructor(p179, p178.overlapParams.zonePartsWhitelist)
    local v182 = p178.worldModel[v180](p178.worldModel, unpack(v181))
    if #v182 > 0 then
        return true, v182
    else
        return false
    end
end
function v_u_17.getCheckerPart(p183)
    local v184 = p183.checkerPart
    if not v184 then
        v184 = p183.janitor:add(Instance.new("Part"), "Destroy")
        v184.Size = Vector3.new(0.1, 0.1, 0.1)
        v184.Name = "ZonePlusCheckerPart"
        v184.Anchored = true
        v184.Transparency = 1
        v184.CanCollide = false
        p183.checkerPart = v184
    end
    local v185 = p183.worldModel
    if v185 == workspace then
        v185 = v_u_14.getWorkspaceContainer()
    end
    if v184.Parent ~= v185 then
        v184.Parent = v185
    end
    return v184
end
function v_u_17.findPoint(p186, p187)
    if typeof(p187) == "Vector3" then
        p187 = CFrame.new(p187)
    end
    local v188 = p186:getCheckerPart()
    v188.CFrame = p187
    local v189, v190 = p186:_getRegionConstructor(v188, p186.overlapParams.zonePartsWhitelist)
    local v191 = p186.worldModel[v189](p186.worldModel, unpack(v190))
    if #v191 > 0 then
        return true, v191
    else
        return false
    end
end
function v_u_17._getAll(p192, p193)
    v_u_14.updateDetection(p192)
    local v194 = {}
    local v195 = v_u_14._getZonesAndItems(p193, {
        ["self"] = true
    }, p192.volume, false, p192._currentEnterDetection)[p192]
    if v195 then
        for v196, _ in pairs(v195) do
            table.insert(v194, v196)
        end
    end
    return v194
end
function v_u_17.getPlayers(p197)
    return p197:_getAll("player")
end
function v_u_17.getItems(p198)
    return p198:_getAll("item")
end
function v_u_17.getParts(p199)
    local v200 = {}
    if p199.activeTriggers.part then
        local v201 = p199.trackingTouchedTriggers.part
        for v202, _ in pairs(v201) do
            table.insert(v200, v202)
        end
        return v200
    else
        local v203 = p199.worldModel:GetPartBoundsInBox(p199.region.CFrame, p199.region.Size, p199.overlapParams.zonePartsIgnorelist)
        for _, v204 in pairs(v203) do
            if p199:findPart(v204) then
                table.insert(v200, v204)
            end
        end
        return v200
    end
end
function v_u_17.getRandomPoint(p205)
    local v206 = p205.exactRegion
    local v207 = v206.Size
    local v208 = v206.CFrame
    local v209 = Random.new()
    local v210 = nil
    repeat
        local v211 = v208 * CFrame.new(v209:NextNumber(-v207.X / 2, v207.X / 2), v209:NextNumber(-v207.Y / 2, v207.Y / 2), v209:NextNumber(-v207.Z / 2, v207.Z / 2))
        local v212, v213 = p205:findPoint(v211)
        v210 = v212 and true or v210
    until v210
    return v211.Position, v213
end
function v_u_17.setAccuracy(p214, p215)
    local v216 = tonumber(p215)
    if v216 then
        if not v_u_6.Accuracy.getName(v216) then
            error(("%s is an invalid enumId!"):format(v216))
        end
    else
        v216 = v_u_6.Accuracy[p215]
        if not v216 then
            error(("\'%s\' is an invalid enumName!"):format(p215))
        end
    end
    p214.accuracy = v216
end
function v_u_17.setDetection(p217, p218)
    local v219 = tonumber(p218)
    if v219 then
        if not v_u_6.Detection.getName(v219) then
            error(("%s is an invalid enumId!"):format(v219))
        end
    else
        v219 = v_u_6.Detection[p218]
        if not v219 then
            error(("\'%s\' is an invalid enumName!"):format(p218))
        end
    end
    p217.enterDetection = v219
    p217.exitDetection = v219
end
function v_u_17.trackItem(p_u_220, p_u_221)
    local v222 = p_u_221:IsA("BasePart")
    local v223
    if v222 then
        v223 = false
    else
        v223 = p_u_221:FindFirstChildOfClass("Humanoid")
        if v223 then
            v223 = p_u_221:FindFirstChild("HumanoidRootPart")
        end
    end
    assert(v222 or v223, "Only BaseParts or Characters/NPCs can be tracked!")
    if not p_u_220.trackedItems[p_u_221] then
        if p_u_220.itemsToUntrack[p_u_221] then
            p_u_220.itemsToUntrack[p_u_221] = nil
        end
        local v224 = p_u_220.janitor:add(v_u_7.new(), "destroy")
        local v225 = {
            ["janitor"] = v224,
            ["item"] = p_u_221,
            ["isBasePart"] = v222,
            ["isCharacter"] = v223
        }
        p_u_220.trackedItems[p_u_221] = v225
        v224:add(p_u_221.AncestryChanged:Connect(function()
            if not p_u_221:IsDescendantOf(game) then
                p_u_220:untrackItem(p_u_221)
            end
        end), "Disconnect")
        require(v_u_12).itemAdded:Fire(v225)
    end
end
function v_u_17.untrackItem(p226, p227)
    local v228 = p226.trackedItems[p227]
    if v228 then
        v228.janitor:destroy()
    end
    p226.trackedItems[p227] = nil
    require(v_u_12).itemRemoved:Fire(v228)
end
function v_u_17.bindToGroup(p229, p230)
    p229:unbindFromGroup()
    (v_u_14.getGroup(p230) or v_u_14.setGroup(p230))._memberZones[p229.zoneId] = p229
    p229.settingsGroupName = p230
end
function v_u_17.unbindFromGroup(p231)
    if p231.settingsGroupName then
        local v232 = v_u_14.getGroup(p231.settingsGroupName)
        if v232 then
            v232._memberZones[p231.zoneId] = nil
        end
        p231.settingsGroupName = nil
    end
end
function v_u_17.relocate(p233)
    if not p233.hasRelocated then
        local v234 = require(v_u_13).setupWorldModel(p233)
        p233.worldModel = v234
        p233.hasRelocated = true
        local v235 = p233.container
        if typeof(v235) == "table" then
            v235 = Instance.new("Folder")
            for _, v236 in pairs(p233.zoneParts) do
                v236.Parent = v235
            end
        end
        p233.relocationContainer = p233.janitor:add(v235, "Destroy", "RelocationContainer")
        v235.Parent = v234
    end
end
function v_u_17._onItemCallback(p_u_237, p238, p239, p_u_240, p_u_241)
    local v242 = p_u_237.onItemDetails[p_u_240]
    if not v242 then
        v242 = {}
        p_u_237.onItemDetails[p_u_240] = v242
    end
    if #v242 == 0 then
        p_u_237.itemsToUntrack[p_u_240] = true
    end
    table.insert(v242, p_u_240)
    p_u_237:trackItem(p_u_240)
    if p_u_237:findItem(p_u_240) == p239 then
        p_u_241()
        if p_u_237.itemsToUntrack[p_u_240] then
            p_u_237.itemsToUntrack[p_u_240] = nil
            p_u_237:untrackItem(p_u_240)
            return
        end
    else
        local v_u_243 = nil
        v_u_243 = p_u_237[p238]:Connect(function(p244)
            if v_u_243 and p244 == p_u_240 then
                v_u_243:Disconnect()
                v_u_243 = nil
                p_u_241()
                if p_u_237.itemsToUntrack[p_u_240] then
                    p_u_237.itemsToUntrack[p_u_240] = nil
                    p_u_237:untrackItem(p_u_240)
                end
            end
        end)
    end
end
function v_u_17.onItemEnter(p245, ...)
    p245:_onItemCallback("itemEntered", true, ...)
end
function v_u_17.onItemExit(p246, ...)
    p246:_onItemCallback("itemExited", false, ...)
end
function v_u_17.destroy(p247)
    p247:unbindFromGroup()
    p247.janitor:destroy()
end
v_u_17.Destroy = v_u_17.destroy
return v_u_17