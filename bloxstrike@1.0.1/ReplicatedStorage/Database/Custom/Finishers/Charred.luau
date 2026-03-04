local v1 = game:GetService("ReplicatedStorage")
require(v1.Classes.Ragdoll.Types)
local v_u_2 = require(v1.Classes.Ragdoll)
local v_u_3 = Instance.new("Fire", nil)
v_u_3.Color = Color3.fromRGB(235, 135, 65)
v_u_3.Heat = 12
v_u_3.Size = 10
local function v_u_6(p4, _)
    p4.Janitor:Add(v_u_3:Clone()).Parent = p4.CharacterModel.PrimaryPart
    if p4.CharacterModel:FindFirstChild("CharacterArmor") then
        p4.CharacterModel.CharacterArmor:Destroy()
    end
    for _, v5 in ipairs(p4.CharacterModel:GetDescendants()) do
        if v5:IsA("Shirt") or v5:IsA("Pants") then
            v5:Destroy()
        elseif v5:IsA("BasePart") then
            v5.Material = Enum.Material.CorrodedMetal
            v5.Color = Color3.fromRGB(60, 30, 5)
        end
    end
end
return {
    ["Replication"] = "All",
    ["Finisher"] = function(p7, p8)
        local v_u_9 = v_u_2.new(p7, p8)
        v_u_6(v_u_9, p8)
        return {
            ["OnDestroy"] = v_u_9.OnDestroy,
            ["Destroy"] = function()
                v_u_9:Destroy()
            end
        }
    end
}