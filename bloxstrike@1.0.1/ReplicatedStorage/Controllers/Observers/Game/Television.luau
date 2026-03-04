local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("RunService")
require(script:WaitForChild("Types"))
local v_u_4 = require(v1.Packages.Observers)
local function v_u_9(p5)
    local v6 = p5:FindFirstChild("Screen")
    if v6 then
        for _, v7 in ipairs(v6:GetChildren()) do
            if v7.Name == "Noise" then
                local v8 = math.random()
                v7.Transparency = math.clamp(v8, 0.2, 0.7)
                v7.Color3 = Color3.fromRGB(192 + math.random(-10, 10), 216 + math.random(-10, 10), 255 + math.random(-10, 10))
            end
        end
    end
end
local function v_u_14(p10)
    local v11 = p10:FindFirstChild("Screen")
    if v11 then
        v_u_2:Create(v11, TweenInfo.new(2.15), {
            ["Color"] = Color3.fromRGB(0, 0, 0)
        }):Play()
        local v12 = v11.ScreenLight.PointLight
        for _ = 1, 8 do
            v12.Enabled = not v12.Enabled
            task.wait(math.random(1, 4) / 10)
        end
        v12.Enabled = false
        for _, v13 in ipairs(v11:GetChildren()) do
            if v13.Name == "Noise" then
                v13.Transparency = 1
            end
        end
    end
end
return v_u_4.observeTag("Television", function(p_u_15)
    local v_u_16 = 0
    if p_u_15:IsDescendantOf(workspace) then
        local v_u_18 = v_u_3.Heartbeat:Connect(function(p17)
            v_u_16 = v_u_16 + p17
            if v_u_16 >= 0.016666666666666666 then
                v_u_16 = v_u_16 - 0.016666666666666666
                if p_u_15 and p_u_15:IsDescendantOf(workspace) then
                    v_u_9(p_u_15)
                end
            end
        end)
        local v_u_19 = v_u_4.observeAttribute(p_u_15, "Broken", function(_)
            v_u_14(p_u_15)
            if v_u_18 and v_u_18.Connected then
                v_u_18:Disconnect()
            end
        end)
        return function()
            v_u_19()
            if v_u_18 and v_u_18.Connected then
                v_u_18:Disconnect()
            end
        end
    end
end)