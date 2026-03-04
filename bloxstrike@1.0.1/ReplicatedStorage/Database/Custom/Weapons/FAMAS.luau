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
    ["WallbangMultiplier"] = 0.6,
    ["Class"] = "Weapon",
    ["ShootingOptions"] = "Burst",
    ["Team"] = "Counter-Terrorists",
    ["AimingOptions"] = "None",
    ["Type"] = "Rifle",
    ["MuzzleType"] = "Rifle",
    ["ReverseIcon"] = "rbxassetid://133348453326383",
    ["Icon"] = "rbxassetid://125469152582044",
    ["Cost"] = 1950,
    ["InventoryIconData"] = {
        ["ScaleType"] = Enum.ScaleType.Crop,
        ["Size"] = UDim2.fromScale(1, 1)
    },
    ["BulletsPerShot"] = 1,
    ["FireRate"] = 0.1,
    ["Range"] = 1200,
    ["RangeModifier"] = 0.98,
    ["ArmorPenetration"] = 0.7,
    ["Penetration"] = 0.5,
    ["Spread"] = {
        ["Range"] = NumberRange.new(0.25, 4),
        ["JumpShotMinimum"] = 15,
        ["PerShot"] = 0.32,
        ["RecoverySpeed"] = 3.5,
        ["MovementMultiplier"] = 0.4
    },
    ["Recoil"] = {
        ["Pattern"] = v2.FAMAS,
        ["RecoverySpeed"] = 6,
        ["CameraScale"] = 0.3,
        ["Damper"] = 1,
        ["Speed"] = 26,
        ["Scale"] = 2.3
    },
    ["WalkSpeed"] = 17.776,
    ["RagdollMultiplier"] = 45,
    ["DamagePerPart"] = {
        ["Torso"] = 37,
        ["Head"] = 120,
        ["Arms"] = 30,
        ["Legs"] = 22
    },
    ["ReloadAnimationCount"] = 1,
    ["Capacity"] = 90,
    ["Rounds"] = 25,
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations.FAMAS.CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations.FAMAS.CameraAnimations,
    ["ShowCrosshair"] = true
}
return v3(v4)