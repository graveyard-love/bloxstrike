local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2.Packages.Observers)
local v_u_4 = require(v2.Shared.Janitor)
local v5 = v2.Assets.Other
local v_u_6 = v5.Defuser
local v_u_7 = v5.DefuseA1
local v_u_8 = v5.DefuseA2
local v_u_9 = v5.DefuseB1
local v_u_10 = v5.DefuseB2
local v_u_11 = CFrame.new(0, -0.2, -0.5) * CFrame.Angles(0, 3.141592653589793, 0)
local v_u_12 = {}
v_u_12.__index = v_u_12
local function v_u_20(p13, p14, p15)
    local v16 = p13:Clone()
    local v17 = v16:FindFirstChild("Attachment")
    local v18 = p14.Parent
    v16.CFrame = v18.CFrame * p14.CFrame * v17.CFrame:Inverse()
    v16.Parent = workspace
    local v19 = Instance.new("WeldConstraint")
    v19.Part0 = v18
    v19.Part1 = v16
    v19.Parent = v16
    p15:Add(v16)
    return v17
end
function v_u_12.new(p21, p_u_22)
    local v23 = v_u_12
    local v24 = setmetatable({}, v23)
    v24.Janitor = v_u_4.new()
    local v_u_25 = nil
    local v_u_26 = nil
    local v_u_27 = nil
    v24.Janitor:Add(v_u_3.observeAttribute(p21, "IsDefusingBomb", function(p28)
        if p28 == true then
            if v_u_25 then
                local v29 = v_u_26
                local v30 = v_u_27
                local v_u_31 = v_u_25
                if v29 then
                    v29.Attachment0 = nil
                    v29.Attachment1 = nil
                end
                if v30 then
                    v30.Attachment0 = nil
                    v30.Attachment1 = nil
                end
                if v_u_31 then
                    task.defer(function()
                        pcall(function()
                            v_u_31:Destroy()
                        end)
                    end)
                end
            end
            v_u_26 = nil
            v_u_27 = nil
            v_u_25 = v_u_4.new()
            local v32 = p_u_22:FindFirstChild("LeftHand")
            local v33 = v_u_1:GetTagged("Bomb")[1]
            if not (v32 and v33) then
                local v_u_34 = v_u_25
                task.defer(function()
                    pcall(function()
                        v_u_34:Destroy()
                    end)
                end)
                v_u_25 = nil
                return function() end
            end
            local v35 = v_u_6:Clone()
            local v36 = v35.Handle
            v35.Parent = p_u_22
            v36.CFrame = v32.CFrame * v_u_11
            v35.PrimaryPart = v36
            local v37 = Instance.new("WeldConstraint")
            v37.Part0 = v32
            v37.Part1 = v36
            v37.Parent = v36
            v_u_25:Add(v35)
            local v38 = v36:FindFirstChild("AttachmentA")
            local v39 = v36:FindFirstChild("AttachmentB")
            local v40 = v33.Weapon.Body
            local v41 = v40:FindFirstChild("AttachmentA")
            local v42 = v40:FindFirstChild("AttachmentB")
            local v43 = v_u_20(v_u_7, v38, v_u_25)
            local v44 = v_u_20(v_u_8, v41, v_u_25)
            local v45 = v_u_20(v_u_9, v39, v_u_25)
            local v46 = v_u_20(v_u_10, v42, v_u_25)
            local v47 = v43.Parent:FindFirstChildWhichIsA("Beam")
            if v47 then
                v47.Attachment0 = v43
                v47.Attachment1 = v44
                v47.Enabled = true
                v_u_26 = v47
            end
            local v48 = v45.Parent:FindFirstChildWhichIsA("Beam")
            if v48 then
                v48.Attachment0 = v45
                v48.Attachment1 = v46
                v48.Enabled = true
                v_u_27 = v48
            end
        else
            local v49 = v_u_26
            local v50 = v_u_27
            local v_u_51 = v_u_25
            if v49 then
                v49.Attachment0 = nil
                v49.Attachment1 = nil
            end
            if v50 then
                v50.Attachment0 = nil
                v50.Attachment1 = nil
            end
            if v_u_51 then
                task.defer(function()
                    pcall(function()
                        v_u_51:Destroy()
                    end)
                end)
            end
            v_u_26 = nil
            v_u_27 = nil
            v_u_25 = nil
        end
        return function()
            local v52 = v_u_26
            local v53 = v_u_27
            local v_u_54 = v_u_25
            if v52 then
                v52.Attachment0 = nil
                v52.Attachment1 = nil
            end
            if v53 then
                v53.Attachment0 = nil
                v53.Attachment1 = nil
            end
            if v_u_54 then
                task.defer(function()
                    pcall(function()
                        v_u_54:Destroy()
                    end)
                end)
            end
            v_u_26 = nil
            v_u_27 = nil
            v_u_25 = nil
        end
    end))
    return v24
end
function v_u_12.Destroy(p55)
    p55.Janitor:Destroy()
end
return v_u_12