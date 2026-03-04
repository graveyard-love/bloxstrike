local v1 = game:GetService("ReplicatedStorage")
require(script:WaitForChild("Types"))
local v2 = require(v1.Packages.Observers)
local v_u_3 = Instance.new("Animation")
v_u_3.AnimationId = "rbxassetid://82806563298602"
return v2.observeTag("Ceiling Fan", function(p4)
    p4:WaitForChild("AnimationController"):WaitForChild("Animator")
    if p4:IsDescendantOf(workspace) then
        local v_u_5 = p4.AnimationController.Animator:LoadAnimation(v_u_3)
        v_u_5:Play()
        return function()
            v_u_5:Destroy()
        end
    end
end)