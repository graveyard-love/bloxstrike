local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Database.Components.Common.RecoilPatterns)
require(v1.Database.Custom.Types)
local v3 = table.freeze
local v4 = {
    ["HasSuppressor"] = true,
    ["Automatic"] = true,
    ["Droppable"] = true,
    ["HasScope"] = false,
    ["Slot"] = "Primary",
    ["WallbangMultiplier"] = 0.7,
    ["Class"] = "Weapon",
    ["ShootingOptions"] = "Default",
    ["Team"] = "Counter-Terrorists",
    ["AimingOptions"] = "None",
    ["Type"] = "Rifle",
    ["MuzzleType"] = "Rifle",
    ["ReverseIcon"] = "rbxassetid://94835087575570",
    ["Icon"] = "rbxassetid://113144230602399",
    ["Cost"] = 2900,
    ["InventoryIconData"] = {
        ["ScaleType"] = Enum.ScaleType.Crop,
        ["Size"] = UDim2.fromScale(1, 1)
    },
    ["BulletsPerShot"] = 1,
    ["FireRate"] = 0.1,
    ["Range"] = 1200,
    ["RangeModifier"] = 0.94,
    ["ArmorPenetration"] = 0.75,
    ["Penetration"] = 0.4,
    ["Spread"] = {
        ["Range"] = NumberRange.new(0.2, 2),
        ["JumpShotMinimum"] = 15,
        ["PerShot"] = 0.3,
        ["RecoverySpeed"] = 5,
        ["MovementMultiplier"] = 1.4
    },
    ["Recoil"] = {
        ["Pattern"] = v2["M4A1-S"],
        ["RecoverySpeed"] = 6,
        ["CameraScale"] = 0.5,
        ["Damper"] = 1,
        ["Speed"] = 25,
        ["Scale"] = 2.5
    },
    ["WalkSpeed"] = 18.18,
    ["RagdollMultiplier"] = 45,
    ["DamagePerPart"] = {
        ["Torso"] = 38,
        ["Head"] = 133,
        ["Arms"] = 30,
        ["Legs"] = 18
    },
    ["ReloadAnimationCount"] = 1,
    ["Capacity"] = 80,
    ["Rounds"] = 20,
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations["M4A1-S"].CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations["M4A1-S"].CameraAnimations,
    ["ShowCrosshair"] = true
}
return v3(v4)