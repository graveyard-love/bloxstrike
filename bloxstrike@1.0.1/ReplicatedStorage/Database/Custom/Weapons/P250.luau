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
    ["WallbangMultiplier"] = 0.35,
    ["Class"] = "Weapon",
    ["ShootingOptions"] = "Default",
    ["Team"] = "Both",
    ["AimingOptions"] = "None",
    ["Type"] = "Pistol",
    ["MuzzleType"] = "Pistol",
    ["ReverseIcon"] = "rbxassetid://116440682239559",
    ["Icon"] = "rbxassetid://73666032770570",
    ["Cost"] = 300,
    ["InventoryIconData"] = {
        ["Position"] = UDim2.fromScale(0.5, 0.48),
        ["ScaleType"] = Enum.ScaleType.Fit,
        ["Size"] = UDim2.fromScale(0.95, 0.95)
    },
    ["BulletsPerShot"] = 1,
    ["FireRate"] = 0.15,
    ["Range"] = 1200,
    ["RangeModifier"] = 0.9,
    ["ArmorPenetration"] = 0.64,
    ["Penetration"] = 0,
    ["Spread"] = {
        ["Range"] = NumberRange.new(1.5, 14.15),
        ["PerShot"] = 4.2,
        ["RecoverySpeed"] = 3.5,
        ["MovementMultiplier"] = 0.2
    },
    ["Recoil"] = {
        ["Pattern"] = v2.P250,
        ["RecoverySpeed"] = 4,
        ["CameraScale"] = 0.4,
        ["Damper"] = 1,
        ["Speed"] = 23,
        ["Scale"] = 0.9
    },
    ["WalkSpeed"] = 19.392,
    ["RagdollMultiplier"] = 35,
    ["DamagePerPart"] = {
        ["Torso"] = 47,
        ["Head"] = 151,
        ["Arms"] = 38,
        ["Legs"] = 28
    },
    ["ReloadAnimationCount"] = 1,
    ["Capacity"] = 26,
    ["Rounds"] = 13,
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations.P250.CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations.P250.CameraAnimations,
    ["ShowCrosshair"] = true
}
return v3(v4)