local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Observers)
local v_u_3 = require(v1.Shared.Janitor)
local v_u_4 = require(v1.Classes.Sound)
local v_u_5 = Instance.new("Animation", nil)
v_u_5.AnimationId = "rbxassetid://130065050998927"
v_u_5.Name = "HOSTAGE_IDLE"
local v_u_6 = Instance.new("Animation", nil)
v_u_6.AnimationId = "rbxassetid://84183418979817"
v_u_6.Name = "HOSTAGE_CARRYING"
local function v_u_11(p7)
    local v8 = p7:FindFirstChildOfClass("Humanoid")
    if not v8 then
        return nil
    end
    local v9 = v8:WaitForChild("Animator")
    local v10 = p7:GetAttribute("State") == "Carrying" and v9:LoadAnimation(v_u_6) or (p7:GetAttribute("State") == "Idle" and v9:LoadAnimation(v_u_5) or nil)
    if v10 then
        v10:Play()
    end
    return v10
end
return v2.observeTag("Hostage", function(p_u_12)
    local v13 = p_u_12:WaitForChild("HumanoidRootPart", 10)
    local v14 = p_u_12:FindFirstChildOfClass("Humanoid")
    if not v14 then
        local v15 = tick()
        repeat
            task.wait(0.1)
            v14 = p_u_12:FindFirstChildOfClass("Humanoid")
        until v14 or tick() - v15 > 10
    end
    local v16 = p_u_12:WaitForChild("Head", 10) or (v14 or v13)
    if v16 then
        if not p_u_12:IsDescendantOf(workspace) then
            return function() end
        end
        local v_u_17 = v_u_3.new()
        local v_u_18 = v_u_4.new("Hostage")
        local v_u_19 = nil
        v_u_18:playOneTime({
            ["Name"] = "Hostage Idle",
            ["Parent"] = v16
        })
        v_u_17:Add(p_u_12:GetAttributeChangedSignal("State"):Connect(function()
            if v_u_19 then
                v_u_19:Stop()
                v_u_19 = nil
            end
            v_u_19 = v_u_11(p_u_12)
        end))
        v_u_19 = v_u_11(p_u_12)
        v_u_17:Add(function()
            v_u_18:destroy()
        end)
        return function()
            v_u_17:Destroy()
        end
    end
end)