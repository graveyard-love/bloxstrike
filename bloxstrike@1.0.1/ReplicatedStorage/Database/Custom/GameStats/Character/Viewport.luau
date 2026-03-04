local v1 = game:GetService("ReplicatedStorage")
local function v5(p2)
    local v3 = {}
    for _, v4 in p2:GetChildren() do
        if v4:IsA("Animation") then
            v3[v4.Name] = v4
        end
    end
    return v3
end
local v6 = table.freeze
local v7 = {
    ["VIEWPORT_CHARACTER_OFFSET"] = CFrame.new(0, 0.025, 0.4)
}
local v8 = {
    ["CT"] = {
        ["CameraOffset"] = CFrame.new(0, 0.2, -8) * CFrame.Angles(0, -3.141592653589793, 0),
        ["IdleAnimation"] = "rbxassetid://137360078752983",
        ["CharacterOffset"] = CFrame.new(0, 0.025, 0.4),
        ["Character"] = "IDF"
    },
    ["T"] = {
        ["CameraOffset"] = CFrame.new(0, 0.2, -8) * CFrame.Angles(0, -3.141592653589793, 0),
        ["IdleAnimation"] = "rbxassetid://99540873384647",
        ["CharacterOffset"] = CFrame.new(0, 0.025, 0.4),
        ["Character"] = "Anarchist"
    }
}
v7.VIEWPORT_CHARACTER_CONFIG = v8
v7.ANIMATION_MAPPING = {
    ["Grenade"] = v5(v1.Assets.UI.Loadout.Animations.Grenade),
    ["Sniper"] = v5(v1.Assets.UI.Loadout.Animations.Sniper),
    ["Pistol"] = v5(v1.Assets.UI.Loadout.Animations.Pistol),
    ["Heavy"] = v5(v1.Assets.UI.Loadout.Animations.Heavy),
    ["Rifle"] = v5(v1.Assets.UI.Loadout.Animations.Rifle),
    ["Melee"] = v5(v1.Assets.UI.Loadout.Animations.Melee),
    ["LMG"] = v5(v1.Assets.UI.Loadout.Animations.LMG),
    ["SMG"] = v5(v1.Assets.UI.Loadout.Animations.SMG)
}
return v6(v7)