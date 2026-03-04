local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
require(script:WaitForChild("Types"))
local v_u_4 = require(v2.Shared.Janitor)
local v_u_5 = require(v2.Shared.Spring)
function v_u_1.UpdateState(p6, p7)
    if p6.Highlight and p6.Highlight.Parent then
        if p6.IsEnabled ~= p7 then
            p6.Highlight.Enabled = p7
            p6.IsEnabled = p7
        end
    end
end
function v_u_1.Construct(p8)
    p8.Highlight.OutlineTransparency = p8.Properties.OutlineTransparency
    p8.Highlight.FillTransparency = p8.Properties.FillTransparency
    p8.Highlight.OutlineColor = p8.Properties.OutlineColor
    p8.Highlight.DepthMode = p8.Properties.DepthMode
    p8.Highlight.FillColor = p8.Properties.FillColor
end
local function v_u_14(p9, p10)
    local v11 = p9:FindFirstChildOfClass("Humanoid")
    if v11 then
        return v11
    end
    local v12 = tick()
    while p9.Parent do
        task.wait(0.1)
        local v13 = p9:FindFirstChildOfClass("Humanoid")
        if v13 then
            return v13
        end
        if p10 and p10 <= tick() - v12 then
            return nil
        end
    end
    return nil
end
function v_u_1.new(p15, p16)
    local v17 = v_u_1
    local v_u_18 = setmetatable({}, v17)
    v_u_18.Janitor = v_u_4.new()
    v_u_18.CurrentTransparency = v_u_5.new(0.95, 1.5, 0.6)
    v_u_18.Properties = p16
    v_u_18.Character = p15
    v_u_18.Highlight = v_u_18.Janitor:Add(Instance.new("Highlight", p15))
    v_u_18.Highlight.Enabled = false
    v_u_18.IsEnabled = false
    v_u_18.OutlineOnly = false
    v_u_18:Construct()
    local v19 = v_u_14(p15)
    if v19 then
        v_u_18.Janitor:Add(v19.Died:Connect(function()
            v_u_18:Destroy()
        end))
    end
    v_u_18.Janitor:Add(v_u_3.Heartbeat:Connect(function(p20)
        if v_u_18.Highlight and v_u_18.Highlight.Parent then
            local v21 = v_u_18.CurrentTransparency:getPosition()
            v_u_18.CurrentTransparency:update(p20)
            if v21 >= 0.8 then
                v_u_18.CurrentTransparency:setGoal(0.6)
            elseif v21 <= 0.6 then
                v_u_18.CurrentTransparency:setGoal(0.8)
            end
            if v_u_18.OutlineOnly then
                v_u_18.Highlight.FillColor = v_u_18.Properties.OutlineColor:Lerp(Color3.new(1, 1, 1), 0.2)
                v_u_18.Highlight.FillTransparency = 0.9
            else
                v_u_18.Highlight.FillColor = v_u_18.Properties.FillColor
                v_u_18.Highlight.FillTransparency = v21
            end
        else
            return
        end
    end))
    return v_u_18
end
function v_u_1.Destroy(p22)
    p22.Janitor:Destroy()
end
return v_u_1