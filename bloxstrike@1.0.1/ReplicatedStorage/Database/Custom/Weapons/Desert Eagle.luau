local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Database.Components.Common.RecoilPatterns)
require(v1.Database.Custom.Types)
local v3 = table.freeze
local v4 = {
    ["HasSuppressor"] = false,
    ["Automatic"] = false,
    ["Droppable"] = true,
    ["HasScope"] = false,
    ["Slot"] = "Secondary",
    ["WallbangMultiplier"] = 0.8,
    ["Class"] = "Weapon",
    ["ShootingOptions"] = "Default",
    ["Team"] = "Both",
    ["AimingOptions"] = "None",
    ["Type"] = "Pistol",
    ["MuzzleType"] = "Pistol",
    ["ReverseIcon"] = "rbxassetid://101910609893699",
    ["Icon"] = "rbxassetid://122477921917392",
    ["Cost"] = 700,
    ["BulletsPerShot"] = 1,
    ["FireRate"] = 0.225,
    ["Range"] = 1200,
    ["RangeModifier"] = 0.81,
    ["ArmorPenetration"] = 0.932,
    ["Penetration"] = 0.5,
    ["Spread"] = {
        ["Range"] = NumberRange.new(1, 13.5),
        ["PerShot"] = 12.5,
        ["RecoverySpeed"] = 6.25,
        ["MovementMultiplier"] = 2.2
    },
    ["Recoil"] = {
        ["Pattern"] = v2["Desert Eagle"],
        ["RecoverySpeed"] = 2.5,
        ["CameraScale"] = 0.8,
        ["Damper"] = 0.7,
        ["Speed"] = 18,
        ["Scale"] = 1.6
    },
    ["WalkSpeed"] = 18.584,
    ["RagdollMultiplier"] = 42,
    ["DamagePerPart"] = {
        ["Torso"] = 75,
        ["Head"] = 250,
        ["Arms"] = 60,
        ["Legs"] = 45
    },
    ["ReloadAnimationCount"] = 1,
    ["Capacity"] = 35,
    ["Rounds"] = 7,
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations["Desert Eagle"].CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations["Desert Eagle"].CameraAnimations,
    ["ShowCrosshair"] = true
}
return v3(v4)