local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
require(script:WaitForChild("Types"))
local v_u_3 = require(v1.Packages.Observers)
local v_u_4 = require(v1.Classes.Sound)
local function v_u_7(p5, p6)
    v_u_4.new("Miscellaneous"):playOneTime({
        ["Parent"] = p5.Handle,
        ["Name"] = "Open Garage"
    })
    return v_u_2:Create(p5.Handle, TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Position"] = p6 + Vector3.new(0, 10, 0)
    })
end
local function v_u_10(p8, p9)
    v_u_4.new("Miscellaneous"):playOneTime({
        ["Parent"] = p8.Handle,
        ["Name"] = "Close Garage"
    })
    return v_u_2:Create(p8.Handle, TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Position"] = p9
    })
end
return v_u_3.observeTag("Garage", function(p_u_11)
    p_u_11:WaitForChild("Handle")
    if p_u_11:IsDescendantOf(workspace) then
        local v_u_12 = p_u_11.Handle.Position
        local v_u_13 = nil
        return v_u_3.observeAttribute(p_u_11, "CurrentState", function(p14)
            if v_u_13 then
                v_u_13:Cancel()
                v_u_13 = nil
            end
            if not p14 then
                local v15 = v_u_10(p_u_11, v_u_12)
                v_u_13 = v15
                v15:Play()
                return function()
                    if p_u_11:IsDescendantOf(workspace) then
                        v_u_10(p_u_11, v_u_12)
                    end
                end
            end
            local v16 = v_u_7(p_u_11, v_u_12)
            v_u_13 = v16
            v16:Play()
        end)
    end
end)