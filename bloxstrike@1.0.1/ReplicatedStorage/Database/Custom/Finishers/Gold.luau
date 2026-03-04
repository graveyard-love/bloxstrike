local v1 = game:GetService("ReplicatedStorage")
require(v1.Classes.Ragdoll.Types)
local v2 = require(v1.Classes.Sound)
local v_u_3 = require(v1.Classes.Ragdoll)
local v_u_4 = v2.new("Finishers")
local function v_u_7(p5, _)
    v_u_4:play({
        ["Parent"] = p5.CharacterModel,
        ["Name"] = "Gold"
    })
    if p5.CharacterModel:FindFirstChild("CharacterArmor") then
        p5.CharacterModel.CharacterArmor:Destroy()
    end
    for _, v6 in ipairs(p5.CharacterModel:GetDescendants()) do
        if v6:IsA("Shirt") or v6:IsA("Pants") then
            v6:Destroy()
        elseif v6:IsA("BasePart") then
            v6.Color = Color3.fromRGB(255, 170, 0)
            v6.Material = Enum.Material.Metal
        end
    end
end
return {
    ["Replication"] = "All",
    ["Finisher"] = function(p8, p9)
        local v_u_10 = v_u_3.new(p8, p9)
        v_u_7(v_u_10, p9)
        return {
            ["OnDestroy"] = v_u_10.OnDestroy,
            ["Destroy"] = function()
                v_u_10:Destroy()
            end
        }
    end
}