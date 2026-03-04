local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
require(script:WaitForChild("Types"))
local v3 = require(v1.Packages.Observers)
local v_u_4 = require(v1.Shared.Janitor)
local function v_u_14(p5, p6)
    if not (p6 and (p6.Parent and p6:IsDescendantOf(workspace))) then
        return
    end
    local v7 = p6:WaitForChild("PointA", 5)
    local v8 = p6:WaitForChild("PointB", 5)
    if not (v7 and v8) then
        warn((("[VertigoCar] Model \"%*\" is missing PointA or PointB attachments"):format(p6.Name)))
        return
    end
    if not (p6 and (p6.Parent and p6:IsDescendantOf(workspace))) then
        return
    end
    local v9 = v7.WorldPosition
    local v10 = v8.WorldPosition
    local v11 = (v10 - v9).Magnitude
    if v11 <= 0 then
        return
    end
    local v12 = v11 / 42
    local v13 = v_u_2:Create(p6, TweenInfo.new(v12, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        ["Position"] = v10
    })
    p5:Add(v13, "Cancel")
    while p6 and (p6.Parent and p6:IsDescendantOf(workspace)) do
        p6.Position = v9
        if not (p6 and (p6.Parent and p6:IsDescendantOf(workspace))) then
            break
        end
        v13:Play()
        v13.Completed:Wait()
        if not (p6 and (p6.Parent and p6:IsDescendantOf(workspace))) then
            break
        end
    end
end
return v3.observeTag("VertigoCar", function(p_u_15)
    p_u_15.Anchored = true
    if not p_u_15:IsDescendantOf(workspace) then
        return function() end
    end
    local v_u_16 = v_u_4.new()
    v_u_16:Add(p_u_15)
    v_u_16:Add(task.spawn(function()
        v_u_14(v_u_16, p_u_15)
    end))
    return function()
        v_u_16:Destroy()
    end
end)