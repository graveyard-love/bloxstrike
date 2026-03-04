local v1 = game:GetService("ReplicatedStorage")
require(script:WaitForChild("Types"))
local v2 = require(v1.Packages.Observers)
local v_u_3 = Instance.new("Animation", nil)
v_u_3.AnimationId = "rbxassetid://103823379066850"
v_u_3.Name = "FLAG_IDLE"
return v2.observeTag("Flag", function(p4)
    p4:WaitForChild("csFlag"):WaitForChild("AnimationController"):WaitForChild("Animator")
    if not p4:IsDescendantOf(workspace) then
        return function() end
    end
    local v_u_5 = p4.csFlag.AnimationController.Animator:LoadAnimation(v_u_3)
    v_u_5:Play()
    return function()
        v_u_5:Destroy()
    end
end)