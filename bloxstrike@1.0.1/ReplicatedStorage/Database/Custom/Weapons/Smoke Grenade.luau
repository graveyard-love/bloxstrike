local v1 = game:GetService("ReplicatedStorage")
require(v1.Database.Custom.Types)
local v2 = table.freeze
local v3 = {
    ["Droppable"] = true,
    ["Team"] = "Terrorists",
    ["Type"] = "Equipment",
    ["Class"] = "Grenade",
    ["Slot"] = "Grenade",
    ["ReverseIcon"] = "rbxassetid://137305344844339",
    ["Icon"] = "rbxassetid://137305344844339",
    ["Cost"] = 300,
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
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations["Smoke Grenade"].CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations["Smoke Grenade"].CameraAnimations,
    ["ShowCrosshair"] = true
}
return v2(v3)