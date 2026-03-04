local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Database.Components.Common.RecoilPatterns)
require(v1.Database.Custom.Types)
local v3 = table.freeze
local v4 = {
    ["HasSuppressor"] = false,
    ["Automatic"] = false,
    ["Droppable"] = false,
    ["HasScope"] = false,
    ["Slot"] = "Secondary",
    ["WallbangMultiplier"] = 0,
    ["Class"] = "Weapon",
    ["ShootingOptions"] = "Default",
    ["Team"] = "Terrorists",
    ["AimingOptions"] = "None",
    ["Type"] = "Pistol",
    ["MuzzleType"] = "Pistol",
    ["ReverseIcon"] = "rbxassetid://89081920349483",
    ["Icon"] = "rbxassetid://119232881698906",
    ["Cost"] = 69000,
    ["BulletsPerShot"] = 1,
    ["FireRate"] = 0.12,
    ["Range"] = 100,
    ["RangeModifier"] = 0.79,
    ["ArmorPenetration"] = 0,
    ["Penetration"] = 0,
    ["Spread"] = {
        ["Range"] = NumberRange.new(1, 9.5),
        ["JumpShotMinimum"] = 100,
        ["PerShot"] = 5,
        ["RecoverySpeed"] = 2.5,
        ["MovementMultiplier"] = 0.1
    },
    ["Recoil"] = {
        ["Pattern"] = v2["Tec-9"],
        ["RecoverySpeed"] = 4,
        ["CameraScale"] = 0.4,
        ["Damper"] = 0.5,
        ["Speed"] = 10,
        ["Scale"] = 5
    },
    ["WalkSpeed"] = 5,
    ["RagdollMultiplier"] = 35,
    ["DamagePerPart"] = {
        ["Torso"] = 5,
        ["Head"] = 4,
        ["Arms"] = 3,
        ["Legs"] = 2
    },
    ["ReloadAnimationCount"] = 1,
    ["Capacity"] = 2,
    ["Rounds"] = 1,
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations["Tec-9"].CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations["Tec-9"].CameraAnimations,
    ["ShowCrosshair"] = true
}
return v3(v4)