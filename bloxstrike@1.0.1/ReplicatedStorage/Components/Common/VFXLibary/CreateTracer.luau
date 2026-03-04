local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("Debris")
local v_u_4 = v1:WaitForChild("Assets"):WaitForChild("Tracers")
local v_u_5 = workspace:WaitForChild("Debris")
local v_u_6 = {
    ["StudsPerSecond"] = 1000,
    ["FadeInDistance"] = 50,
    ["SpawnDistance"] = 5,
    ["Width"] = 0.2
}
return function(_, p7, p8)
    if p7 then
        local v9 = v_u_4:FindFirstChild("Default")
        assert(v9, "Default is not apart of Assets.Miscellaneous")
        local v10 = v9:Clone()
        v10.CollisionGroup = "Debris"
        v10.CanCollide = false
        v10.CanQuery = false
        v10.CanTouch = false
        v10.Anchored = true
        v10.CFrame = CFrame.new(p7 + p8 * v_u_6.SpawnDistance)
        v10.Parent = v_u_5
        local v_u_11 = v_u_2:Create(v10, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            ["CFrame"] = CFrame.new(p7 + p8 * v_u_6.StudsPerSecond)
        })
        task.defer(function()
            v_u_11:Play()
        end)
        local v12 = TweenInfo.new(v_u_6.FadeInDistance / v_u_6.StudsPerSecond, Enum.EasingStyle.Linear)
        v10.BottomAttachment.Position = Vector3.new(0, 0, 0)
        v10.RightAttachment.Position = Vector3.new(0, 0, 0)
        v10.LeftAttachment.Position = Vector3.new(0, 0, 0)
        v10.TopAttachment.Position = Vector3.new(0, 0, 0)
        local v13 = v_u_2
        local v14 = v10.TopAttachment
        local v15 = {}
        local v16 = v_u_6.Width / 2
        v15.Position = Vector3.new(0, v16, 0)
        v13:Create(v14, v12, v15):Play()
        local v17 = v_u_2
        local v18 = v10.BottomAttachment
        local v19 = {}
        local v20 = -v_u_6.Width / 2
        v19.Position = Vector3.new(0, v20, 0)
        v17:Create(v18, v12, v19):Play()
        local v21 = v_u_2
        local v22 = v10.LeftAttachment
        local v23 = {}
        local v24 = -v_u_6.Width / 2
        v23.Position = Vector3.new(v24, 0, 0)
        v21:Create(v22, v12, v23):Play()
        local v25 = v_u_2
        local v26 = v10.RightAttachment
        local v27 = {}
        local v28 = v_u_6.Width / 2
        v27.Position = Vector3.new(v28, 0, 0)
        v25:Create(v26, v12, v27):Play()
        v_u_3:AddItem(v10, 2)
    end
end