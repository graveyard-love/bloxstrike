local v1 = game:GetService("ReplicatedStorage")
require(v1.Database.Custom.Types)
local v2 = table.freeze
local v3 = {
    ["Droppable"] = true,
    ["Team"] = "Terrorists",
    ["Type"] = "Equipment",
    ["Class"] = "Grenade",
    ["Slot"] = "Grenade",
    ["ReverseIcon"] = "rbxassetid://95390644612614",
    ["Icon"] = "rbxassetid://95390644612614",
    ["Cost"] = 400,
    ["Range"] = 60,
    ["ArmorPenetration"] = 0.99,
    ["WalkSpeed"] = 20.2,
    ["RagdollMultiplier"] = 85,
    ["DamagePerPart"] = {
        ["Torso"] = 41,
        ["Head"] = 48,
        ["Arms"] = 31,
        ["Legs"] = 28
    },
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations.Molotov.CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations.Molotov.CameraAnimations,
    ["ShowCrosshair"] = true
}
return v2(v3)