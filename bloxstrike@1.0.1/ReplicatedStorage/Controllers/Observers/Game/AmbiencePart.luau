local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("SoundService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Workspace")
local v5 = require(v1.Packages.Observers)
local v_u_6 = require(v1.Shared.Janitor)
local v_u_7 = {}
local v_u_8 = nil
local function v_u_27(p9)
    local v10 = v_u_4.CurrentCamera
    if v10 then
        v10 = v10.CFrame.Position
    end
    for v11, v12 in pairs(v_u_7) do
        if v11:IsDescendantOf(v_u_4) then
            if v10 then
                v12.StepAccumulator = v12.StepAccumulator + p9
                if v12.StepAccumulator >= 0.06666666666666667 then
                    local v13 = v12.StepAccumulator
                    v12.StepAccumulator = 0
                    local v14 = v13 * 3
                    local v15 = math.min(1, v14)
                    local v16 = v11.CFrame:PointToObjectSpace(v10)
                    local v17 = v11.Size / 2
                    local v18 = v16.X
                    local v19
                    if math.abs(v18) <= v17.X then
                        local v20 = v16.Y
                        if math.abs(v20) <= v17.Y then
                            local v21 = v16.Z
                            v19 = math.abs(v21) <= v17.Z
                        else
                            v19 = false
                        end
                    else
                        v19 = false
                    end
                    for _, v22 in ipairs(v12.SoundDataList) do
                        local v23 = v19 and (v22.MaximumVolume or 0) or 0
                        local v24 = v22.GlobalSound.Volume
                        local v25 = v23 - v24
                        if math.abs(v25) <= 0.002 then
                            if v24 ~= v23 then
                                v22.GlobalSound.Volume = v23
                            end
                            v22.CurrentVolume = v23
                        else
                            local v26 = v24 + v25 * v15
                            v22.GlobalSound.Volume = v26
                            v22.CurrentVolume = v26
                        end
                    end
                end
            end
        else
            v_u_7[v11] = nil
        end
    end
    if next(v_u_7) == nil and v_u_8 then
        v_u_8:Disconnect()
        v_u_8 = nil
    end
end
return v5.observeTag("AmbiencePart", function(p_u_28)
    if not p_u_28:IsDescendantOf(workspace) then
        return function() end
    end
    local v29 = {}
    for _, v30 in p_u_28:GetChildren() do
        if v30:IsA("Sound") then
            table.insert(v29, v30)
        end
    end
    if #v29 <= 0 then
        return function() end
    end
    local v_u_31 = v_u_6.new()
    local v32 = {}
    for _, v33 in v29 do
        local v34 = v_u_31:Add(v33:Clone())
        v34.RollOffMode = Enum.RollOffMode.Inverse
        v34.RollOffMaxDistance = 10000
        v34.RollOffMinDistance = 10000
        v34.Parent = v_u_2
        v34.PlayOnRemove = false
        v34.Volume = 0
        v34:Play()
        local v35 = {
            ["MaximumVolume"] = v33.Volume > 0 and v33.Volume or 1,
            ["GlobalSound"] = v34,
            ["CurrentVolume"] = 0
        }
        table.insert(v32, v35)
    end
    v_u_7[p_u_28] = {
        ["Part"] = p_u_28,
        ["SoundDataList"] = v32,
        ["StepAccumulator"] = 0
    }
    if not v_u_8 then
        v_u_8 = v_u_3.Heartbeat:Connect(v_u_27)
    end
    v_u_31:Add(function()
        v_u_7[p_u_28] = nil
        if next(v_u_7) == nil and v_u_8 then
            v_u_8:Disconnect()
            v_u_8 = nil
        end
    end)
    return function()
        v_u_31:Cleanup()
    end
end)