local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Database.Components.Common.RecoilPatterns)
require(v1.Database.Custom.Types)
local v3 = table.freeze
local v4 = {
    ["HasSuppressor"] = false,
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
    ["ReverseIcon"] = "rbxassetid://105120092581738",
    ["Icon"] = "rbxassetid://93053662997899",
    ["Cost"] = 2900,
    ["InventoryIconData"] = {
        ["Position"] = UDim2.fromScale(0.5, 0.43),
        ["ScaleType"] = Enum.ScaleType.Crop,
        ["Size"] = UDim2.fromScale(1, 1)
    },
    ["BulletsPerShot"] = 1,
    ["FireRate"] = 0.09,
    ["Range"] = 1200,
    ["RangeModifier"] = 0.98,
    ["ArmorPenetration"] = 0.7,
    ["Penetration"] = 0.5,
    ["Spread"] = {
        ["Range"] = NumberRange.new(0.2, 3),
        ["JumpShotMinimum"] = 15,
        ["PerShot"] = 0.3,
        ["RecoverySpeed"] = 4.5,
        ["MovementMultiplier"] = 1.4
    },
    ["Recoil"] = {
        ["Pattern"] = v2.M4A4,
        ["RecoverySpeed"] = 6,
        ["CameraScale"] = 0.3,
        ["Damper"] = 1,
        ["Speed"] = 26,
        ["Scale"] = 2.3
    },
    ["WalkSpeed"] = 18.18,
    ["RagdollMultiplier"] = 45,
    ["DamagePerPart"] = {
        ["Torso"] = 42,
        ["Head"] = 131,
        ["Arms"] = 34,
        ["Legs"] = 20
    },
    ["ReloadAnimationCount"] = 1,
    ["Capacity"] = 90,
    ["Rounds"] = 30,
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations.M4A4.CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations.M4A4.CameraAnimations,
    ["ShowCrosshair"] = true
}
return v3(v4)