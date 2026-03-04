local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
game:GetService("Players")
local v_u_3 = game:GetService("Debris")
local v_u_4 = workspace:WaitForChild("Debris")
require(v_u_1.Components.Common.GetRayIgnore)
local v5 = RaycastParams.new()
v5.FilterType = Enum.RaycastFilterType.Exclude
v5.IgnoreWater = true
local v_u_6 = {
    "rbxassetid://8635071092",
    "rbxassetid://8634747192",
    "rbxassetid://15067037717",
    "rbxassetid://18779968078"
}
local function _(p7, p8)
    local v9 = v_u_1.Assets.Other.BloodSplatter:Clone()
    v9.CFrame = p7
    v9.CollisionGroup = "Debris"
    v9.CanCollide = false
    v9.CanQuery = false
    v9.CanTouch = false
    v9.Anchored = true
    v9.Size = p8
    v9.Parent = v_u_4
    for _, v10 in ipairs(v9:GetDescendants()) do
        if v10:IsA("Decal") then
            v10.Texture = v_u_6[math.random(1, #v_u_6)]
            v10.Color3 = Color3.fromRGB(126, 16, 24)
            v_u_2:Create(v10, TweenInfo.new(15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["Color3"] = Color3.fromRGB(70, 10, 15),
                ["Transparency"] = 1
            }):Play()
        end
    end
    v_u_3:AddItem(v9, 15)
    return v9
end
return function(_, _) end