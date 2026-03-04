local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("ReplicatedFirst")
local v_u_3 = game:GetService("ContentProvider")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("RunService")
local v_u_6 = game:GetService("Players").LocalPlayer
local v_u_7 = require(v_u_1:WaitForChild("Shared"):WaitForChild("Janitor"))
local v8 = v_u_6:WaitForChild("PlayerGui")
v8.ScreenOrientation = Enum.ScreenOrientation.LandscapeSensor
local v_u_9 = script:WaitForChild("Loader")
local v_u_10 = "Loading Profile"
local v_u_11 = 0
local v_u_12 = 0
local v_u_13 = false
local v_u_14 = 0
local v_u_15 = Instance.new("Frame")
v_u_15.Name = "InputBlocker"
v_u_15.Size = UDim2.new(1, 0, 1, 0)
v_u_15.Position = UDim2.new(0, 0, 0, 0)
v_u_15.BackgroundTransparency = 1
v_u_15.Active = true
v_u_15.ZIndex = 6767
v_u_15.Parent = v_u_9
v2:RemoveDefaultLoadingScreen()
v_u_9.Parent = v8
local function v_u_17(p16)
    repeat
        task.wait()
    until p16()
end
local function v_u_20(p_u_18)
    if not v_u_13 then
        v_u_13 = true
        for _, v19 in ipairs(v_u_9:GetDescendants()) do
            if v19:IsA("TextLabel") and (v19.Visible and v19.TextTransparency > 0) then
                v_u_4:Create(v19, TweenInfo.new(0.95), {
                    ["TextTransparency"] = 1
                }):Play()
            elseif v19:IsA("ImageLabel") and (v19.Visible and v19.ImageTransparency > 0) then
                v_u_4:Create(v19, TweenInfo.new(0.95), {
                    ["ImageTransparency"] = 1
                }):Play()
            elseif v19:IsA("Frame") and (v19.Visible and v19.BackgroundTransparency > 0) then
                v_u_4:Create(v19, TweenInfo.new(0.95), {
                    ["BackgroundTransparency"] = 1
                }):Play()
            end
        end
        task.delay(1, function()
            p_u_18:Destroy()
        end)
    end
end
task.spawn(function()
    v_u_3:PreloadAsync(v_u_9:GetDescendants())
end)
task.spawn(function()
    local v_u_21 = v_u_7.new()
    v_u_21:Add(v_u_15)
    v_u_21:Add(v_u_9)
    local v_u_22 = tick()
    local v_u_23 = tick()
    local v_u_24 = 0
    v_u_21:Add((v_u_5.Heartbeat:Connect(function(p25)
        local v26 = 25
        local v27 = tick()
        if v_u_12 > 0 and v_u_10 == "Loading Assets" then
            local v28 = v_u_11
            local v29 = v_u_12
            local v30 = math.min(v28, v29)
            local v31 = v27 - v_u_23
            v_u_9.LoadingScreen.Title.Text = ("Loading Assets (%*/%*)"):format(v30, v_u_12)
            v_u_9.LoadingScreen.Title.TextTransparency = 1 - v30 / v_u_12
            v_u_9.LoadingScreen.Icon.ImageTransparency = 1 - v30 / v_u_12
            if v31 > 0 then
                local v32 = 25 + (v_u_11 - v_u_24) / v31 * 2
                v26 = math.min(v32, 95)
            end
            v_u_24 = v_u_11
            v_u_23 = v27
        else
            if v27 - v_u_22 >= 0.35 then
                v_u_14 = (v_u_14 + 1) % 3
                v_u_22 = v27
            end
            v_u_9.LoadingScreen.Title.Text = "Loading Profile" .. string.rep(".", v_u_14 + 1)
            v_u_9.LoadingScreen.Title.TextTransparency = 0
        end
        v_u_9.LoadingScreen.Extra.Progress.Rotation = v_u_9.LoadingScreen.Extra.Progress.Rotation + p25 * v26
    end)))
    v_u_17(function()
        return v_u_6:GetAttribute("DataLoaded")
    end)
    task.delay(4, function()
        if not v_u_13 then
            v_u_20(v_u_21)
        end
    end)
    task.spawn(function()
        local v33 = v_u_1:WaitForChild("Assets"):GetDescendants()
        v_u_10 = "Loading Assets"
        v_u_12 = #v33
        v_u_3:PreloadAsync(v33, function()
            v_u_11 = v_u_11 + 1
        end)
    end)
end)