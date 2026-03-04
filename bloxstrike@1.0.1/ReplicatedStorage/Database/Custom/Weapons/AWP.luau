local v1 = game:GetService("ReplicatedStorage")
require(v1.Database.Custom.Types)
local v2 = table.freeze
local v3 = {
    ["HasSuppressor"] = false,
    ["Automatic"] = false,
    ["Droppable"] = true,
    ["HasScope"] = true,
    ["Slot"] = "Primary",
    ["WallbangMultiplier"] = 0.98,
    ["Class"] = "Weapon",
    ["ShootingOptions"] = "Default",
    ["Team"] = "Both",
    ["AimingOptions"] = "SniperScope",
    ["Type"] = "Rifle",
    ["MuzzleType"] = "Sniper",
    ["ReverseIcon"] = "rbxassetid://78589610778527",
    ["Icon"] = "rbxassetid://79794264811775",
    ["Cost"] = 4750,
    ["InventoryIconData"] = {
        ["ScaleType"] = Enum.ScaleType.Crop,
        ["Size"] = UDim2.fromScale(1, 1)
    },
    ["BulletsPerShot"] = 1,
    ["FireRate"] = 1.46,
    ["Range"] = 1200,
    ["RangeModifier"] = 0.99,
    ["ArmorPenetration"] = 0.975,
    ["Penetration"] = 1.5,
    ["Spread"] = {
        ["Range"] = NumberRange.new(0, 20),
        ["PerShot"] = 0,
        ["RecoverySpeed"] = 5,
        ["MovementMultiplier"] = 3
    },
    ["WalkSpeed"] = 16.16,
    ["RagdollMultiplier"] = 60,
    ["DamagePerPart"] = {
        ["Torso"] = 143,
        ["Head"] = 459,
        ["Arms"] = 115,
        ["Legs"] = 85
    },
    ["ReloadAnimationCount"] = 1,
    ["Capacity"] = 30,
    ["Rounds"] = 5,
    ["CharacterAnimations"] = v1.Assets.WeaponAnimations.AWP.CharacterAnimations,
    ["CameraAnimations"] = v1.Assets.WeaponAnimations.AWP.CameraAnimations,
    ["ShowCrosshair"] = false
}
return v2(v3)