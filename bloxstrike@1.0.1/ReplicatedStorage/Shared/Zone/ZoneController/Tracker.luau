local v_u_1 = game:GetService("Players")
local _ = game:GetService("RunService").Heartbeat
local v2 = require(script.Parent.Parent.Signal)
local v_u_3 = require(script.Parent.Parent.Janitor)
local v_u_4 = {}
v_u_4.__index = v_u_4
local v_u_5 = {}
v_u_4.trackers = v_u_5
v_u_4.itemAdded = v2.new()
v_u_4.itemRemoved = v2.new()
v_u_4.bodyPartsToIgnore = {
    ["UpperTorso"] = true,
    ["LowerTorso"] = true,
    ["Torso"] = true,
    ["LeftHand"] = true,
    ["RightHand"] = true,
    ["LeftFoot"] = true,
    ["RightFoot"] = true
}
function v_u_4.getCombinedTotalVolumes()
    local v6 = 0
    for v7, _ in pairs(v_u_5) do
        v6 = v6 + v7.totalVolume
    end
    return v6
end
function v_u_4.getCharacterSize(p8)
    local v9
    if p8 then
        v9 = p8:FindFirstChild("Head")
    else
        v9 = p8
    end
    if p8 then
        p8 = p8:FindFirstChild("HumanoidRootPart")
    end
    if not (p8 and v9) then
        return nil
    end
    if not v9:IsA("BasePart") then
        v9 = p8
    end
    local v10 = v9.Size.Y
    local v11 = p8.Size
    return v11 * Vector3.new(2, 2, 1) + Vector3.new(0, v10, 0), p8.CFrame * CFrame.new(0, v10 / 2 - v11.Y / 2, 0)
end
function v_u_4.new(p12)
    local v_u_13 = {}
    local v14 = v_u_4
    setmetatable(v_u_13, v14)
    v_u_13.name = p12
    v_u_13.totalVolume = 0
    v_u_13.parts = {}
    v_u_13.partToItem = {}
    v_u_13.items = {}
    v_u_13.whitelistParams = nil
    v_u_13.characters = {}
    v_u_13.baseParts = {}
    v_u_13.exitDetections = {}
    v_u_13.janitor = v_u_3.new()
    if p12 == "player" then
        local function v_u_18()
            local v15 = {}
            for _, v16 in pairs(v_u_1:GetPlayers()) do
                local v17 = v16.Character
                if v17 then
                    v15[v17] = true
                end
            end
            v_u_13.characters = v15
        end
        local function v26(p19)
            local function v24(p20)
                local v21 = p20:FindFirstChildOfClass("Humanoid")
                if not v21 then
                    local v22 = tick()
                    repeat
                        task.wait(0.1)
                        v21 = p20:FindFirstChildOfClass("Humanoid")
                    until v21 or tick() - v22 > 3
                end
                if v21 then
                    v_u_18()
                    v_u_13:update()
                    for _, v23 in pairs(v21:GetChildren()) do
                        if v23:IsA("NumberValue") then
                            v23.Changed:Connect(function()
                                v_u_13:update()
                            end)
                        end
                    end
                end
            end
            if p19.Character then
                v24(p19.Character)
            end
            p19.CharacterAdded:Connect(v24)
            p19.CharacterRemoving:Connect(function(p25)
                v_u_13.exitDetections[p25] = nil
            end)
        end
        v_u_1.PlayerAdded:Connect(v26)
        for _, v27 in pairs(v_u_1:GetPlayers()) do
            v26(v27)
        end
        v_u_1.PlayerRemoving:Connect(function(_)
            v_u_18()
            v_u_13:update()
        end)
    elseif p12 == "item" then
        v_u_4.itemAdded:Connect(function(p28)
            if p28.isCharacter then
                v_u_13.characters[p28.item] = true
            elseif p28.isBasePart then
                v_u_13.baseParts[p28.item] = true
            end
            v_u_13:update()
        end)
        v_u_4.itemRemoved:Connect(function(p29)
            v_u_13.exitDetections[p29.item] = nil
            if p29.isCharacter then
                v_u_13.characters[p29.item] = nil
            elseif p29.isBasePart then
                v_u_13.baseParts[p29.item] = nil
            end
            v_u_13:update()
        end)
    end
    v_u_5[v_u_13] = true
    task.defer(v_u_13.update, v_u_13)
    return v_u_13
end
function v_u_4._preventMultiFrameUpdates(p_u_30, p_u_31, ...)
    p_u_30._preventMultiDetails = p_u_30._preventMultiDetails or {}
    local v_u_32 = p_u_30._preventMultiDetails[p_u_31]
    if not v_u_32 then
        v_u_32 = {
            ["calling"] = false,
            ["callsThisFrame"] = 0,
            ["updatedThisFrame"] = false
        }
        p_u_30._preventMultiDetails[p_u_31] = v_u_32
    end
    v_u_32.callsThisFrame = v_u_32.callsThisFrame + 1
    if v_u_32.callsThisFrame ~= 1 then
        return true
    end
    local v_u_33 = table.pack(...)
    task.defer(function()
        local v34 = v_u_32.callsThisFrame
        v_u_32.callsThisFrame = 0
        if v34 > 1 then
            local v35 = v_u_33
            p_u_30[p_u_31](p_u_30, unpack(v35))
        end
    end)
    return false
end
function v_u_4.update(p_u_36)
    if not p_u_36:_preventMultiFrameUpdates("update") then
        p_u_36.totalVolume = 0
        p_u_36.parts = {}
        p_u_36.partToItem = {}
        p_u_36.items = {}
        for v_u_37, _ in pairs(p_u_36.characters) do
            local v38 = v_u_4.getCharacterSize(v_u_37)
            if v38 then
                local v39 = v38.X * v38.Y * v38.Z
                p_u_36.totalVolume = p_u_36.totalVolume + v39
                local v40 = p_u_36.janitor:add(v_u_3.new(), "destroy", "trackCharacterParts-" .. p_u_36.name)
                local v_u_41 = v40
                for _, v_u_42 in pairs(v_u_37:GetChildren()) do
                    if v_u_42:IsA("BasePart") and not v_u_4.bodyPartsToIgnore[v_u_42.Name] then
                        p_u_36.partToItem[v_u_42] = v_u_37
                        local v43 = p_u_36.parts
                        table.insert(v43, v_u_42)
                        v_u_41:add(v_u_42.AncestryChanged:Connect(function()
                            if not v_u_42:IsDescendantOf(game) and (v_u_42.Parent == nil and v_u_41 ~= nil) then
                                v_u_41:destroy()
                                v_u_41 = nil
                                p_u_36:update()
                            end
                        end), "Disconnect")
                    end
                end
                v_u_41:add(v_u_37.AncestryChanged:Connect(function()
                    if not v_u_37:IsDescendantOf(game) and (v_u_37.Parent == nil and v_u_41 ~= nil) then
                        v_u_41:destroy()
                        v_u_41 = nil
                        p_u_36:update()
                    end
                end), "Disconnect")
                local v44 = p_u_36.items
                table.insert(v44, v_u_37)
            end
        end
        for v45, _ in pairs(p_u_36.baseParts) do
            local v46 = v45.Size
            local v47 = v46.X * v46.Y * v46.Z
            p_u_36.totalVolume = p_u_36.totalVolume + v47
            p_u_36.partToItem[v45] = v45
            local v48 = p_u_36.parts
            table.insert(v48, v45)
            local v49 = p_u_36.items
            table.insert(v49, v45)
        end
        p_u_36.whitelistParams = OverlapParams.new()
        p_u_36.whitelistParams.FilterType = Enum.RaycastFilterType.Whitelist
        p_u_36.whitelistParams.MaxParts = #p_u_36.parts
        p_u_36.whitelistParams.FilterDescendantsInstances = p_u_36.parts
    end
end
return v_u_4