local v1 = game:GetService("ReplicatedStorage")
require(v1.Database.Custom.Types)
local v2 = table.freeze
local v3 = {
    ["Droppable"] = true,
    ["Team"] = "Both",
    ["Type"] = "Equipment",
    ["Class"] = "Grenade",
    ["Slot"] = "Grenade",
    ["ReverseIcon"] = "rbxassetid://111110976385167",
    ["Icon"] = "rbxassetid://111110976385167",
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
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations["HE Grenade"].CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations["HE Grenade"].CameraAnimations,
    ["ShowCrosshair"] = true
}
return v2(v3)