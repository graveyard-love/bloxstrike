local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Database.Components.Common.RecoilPatterns)
require(v1.Database.Custom.Types)
local v3 = table.freeze
local v4 = {
    ["HasSuppressor"] = false,
    ["Automatic"] = false,
    ["Droppable"] = true,
    ["HasScope"] = false,
    ["Slot"] = "Primary",
    ["WallbangMultiplier"] = 0.5,
    ["Class"] = "Weapon",
    ["ShootingOptions"] = "Default",
    ["Team"] = "Both",
    ["AimingOptions"] = "None",
    ["Type"] = "Heavy",
    ["MuzzleType"] = "ShotGun",
    ["ReverseIcon"] = "rbxassetid://84241192314676",
    ["Icon"] = "rbxassetid://127273982496076",
    ["Cost"] = 1050,
    ["InventoryIconData"] = {
        ["ScaleType"] = Enum.ScaleType.Crop,
        ["Size"] = UDim2.fromScale(1, 1)
    },
    ["BulletsPerShot"] = 9,
    ["FireRate"] = 0.88,
    ["Range"] = 120,
    ["RangeModifier"] = 0.7,
    ["ArmorPenetration"] = 0.5,
    ["Penetration"] = 0.1,
    ["Spread"] = {
        ["Range"] = NumberRange.new(10, 15),
        ["JumpShotMinimum"] = 15,
        ["PerShot"] = 5,
        ["RecoverySpeed"] = 4.25,
        ["MovementMultiplier"] = 0.3
    },
    ["Recoil"] = {
        ["Pattern"] = v2.Nova,
        ["RecoverySpeed"] = 6,
        ["CameraScale"] = 1,
        ["Damper"] = 1,
        ["Speed"] = 26,
        ["Scale"] = 3.3
    },
    ["WalkSpeed"] = 17.776,
    ["RagdollMultiplier"] = 75,
    ["DamagePerPart"] = {
        ["Torso"] = 32,
        ["Head"] = 106,
        ["Arms"] = 26,
        ["Legs"] = 19
    },
    ["ReloadAnimationCount"] = 8,
    ["Capacity"] = 32,
    ["Rounds"] = 8,
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations.Nova.CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations.Nova.CameraAnimations,
    ["ShowCrosshair"] = true
}
return v3(v4)