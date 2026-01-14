-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_replicatedstorage.Database.Custom.Types)
local v1 = {
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
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.AWP.CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.AWP.CameraAnimations,
	["ShowCrosshair"] = false
}
return table.freeze(v1)