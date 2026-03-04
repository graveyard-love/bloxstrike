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
    ["WallbangMultiplier"] = 0.4,
    ["Class"] = "Weapon",
    ["ShootingOptions"] = "Dual",
    ["Team"] = "Both",
    ["AimingOptions"] = "None",
    ["Type"] = "Pistol",
    ["MuzzleType"] = "Pistol",
    ["ReverseIcon"] = "rbxassetid://110860310038065",
    ["Icon"] = "rbxassetid://111854065134079",
    ["Cost"] = 300,
    ["BulletsPerShot"] = 1,
    ["FireRate"] = 0.12,
    ["Range"] = 1200,
    ["RangeModifier"] = 0.85,
    ["ArmorPenetration"] = 0.575,
    ["Penetration"] = 0,
    ["Spread"] = {
        ["Range"] = NumberRange.new(1, 5.25),
        ["JumpShotMinimum"] = 45,
        ["PerShot"] = 2.125,
        ["RecoverySpeed"] = 3,
        ["MovementMultiplier"] = 0.2
    },
    ["Recoil"] = {
        ["Pattern"] = v2["Dual Berettas"],
        ["RecoverySpeed"] = 4,
        ["CameraScale"] = 0.4,
        ["Damper"] = 1,
        ["Speed"] = 23,
        ["Scale"] = 2.3
    },
    ["WalkSpeed"] = 19.392,
    ["RagdollMultiplier"] = 35,
    ["DamagePerPart"] = {
        ["Torso"] = 47,
        ["Head"] = 152,
        ["Arms"] = 38,
        ["Legs"] = 28
    },
    ["ReloadAnimationCount"] = 1,
    ["Capacity"] = 120,
    ["Rounds"] = 30,
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations["Dual Berettas"].CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations["Dual Berettas"].CameraAnimations,
    ["ShowCrosshair"] = true
}
return v3(v4)