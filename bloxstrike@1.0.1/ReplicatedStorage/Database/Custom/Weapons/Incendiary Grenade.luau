local v1 = game:GetService("ReplicatedStorage")
require(v1.Database.Custom.Types)
local v2 = table.freeze
local v3 = {
    ["Droppable"] = true,
    ["Team"] = "Counter-Terrorists",
    ["Type"] = "Equipment",
    ["Class"] = "Grenade",
    ["Slot"] = "Grenade",
    ["ReverseIcon"] = "rbxassetid://81255981095065",
    ["Icon"] = "rbxassetid://81255981095065",
    ["Cost"] = 500,
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
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations["Incendiary Grenade"].CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations["Incendiary Grenade"].CameraAnimations,
    ["ShowCrosshair"] = true
}
return v2(v3)