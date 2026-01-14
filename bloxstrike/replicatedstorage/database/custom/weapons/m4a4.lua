-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v1 = require(v_replicatedstorage.Database.Components.Common.RecoilPatterns)
require(v_replicatedstorage.Database.Custom.Types)
local v2 = {
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
	["BulletsPerShot"] = 1,
	["FireRate"] = 0.09,
	["Range"] = 1200,
	["RangeModifier"] = 0.98,
	["ArmorPenetration"] = 0.7,
	["Penetration"] = 0.5,
	["Spread"] = {
		["Range"] = NumberRange.new(0.25, 3.5),
		["JumpShotMinimum"] = 15,
		["PerShot"] = 0.32,
		["RecoverySpeed"] = 3.75,
		["MovementMultiplier"] = 1.4
	},
	["Recoil"] = {
		["Pattern"] = v1.M4A4,
		["RecoverySpeed"] = 6,
		["CameraScale"] = 0.3,
		["Damper"] = 1,
		["Speed"] = 26,
		["Scale"] = 2.3
	},
	["WalkSpeed"] = 18.18,
	["RagdollMultiplier"] = 45,
	["DamagePerPart"] = {
		["Torso"] = 40,
		["Head"] = 131,
		["Arms"] = 32,
		["Legs"] = 19
	},
	["ReloadAnimationCount"] = 1,
	["Capacity"] = 90,
	["Rounds"] = 30,
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.M4A4.CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.M4A4.CameraAnimations,
	["ShowCrosshair"] = true
}
return table.freeze(v2)