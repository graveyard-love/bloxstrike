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
	["WallbangMultiplier"] = 0.6,
	["Class"] = "Weapon",
	["ShootingOptions"] = "Default",
	["Team"] = "Counter-Terrorists",
	["AimingOptions"] = "None",
	["Type"] = "SMG",
	["MuzzleType"] = "SMG",
	["ReverseIcon"] = "rbxassetid://98859371551950",
	["Icon"] = "rbxassetid://135384625641866",
	["Cost"] = 1250,
	["BulletsPerShot"] = 1,
	["FireRate"] = 0.07,
	["Range"] = 1200,
	["RangeModifier"] = 0.87,
	["ArmorPenetration"] = 0.575,
	["Penetration"] = 0.25,
	["Spread"] = {
		["Range"] = NumberRange.new(0.25, 2.25),
		["JumpShotMinimum"] = 10,
		["PerShot"] = 0.32,
		["RecoverySpeed"] = 4.25,
		["MovementMultiplier"] = 0.5
	},
	["Recoil"] = {
		["Pattern"] = v1.MP9,
		["RecoverySpeed"] = 6,
		["CameraScale"] = 0.55,
		["Damper"] = 1,
		["Speed"] = 26,
		["Scale"] = 2.3
	},
	["WalkSpeed"] = 19.392,
	["RagdollMultiplier"] = 55,
	["DamagePerPart"] = {
		["Torso"] = 32,
		["Head"] = 104,
		["Arms"] = 26,
		["Legs"] = 19
	},
	["ReloadAnimationCount"] = 1,
	["Capacity"] = 120,
	["Rounds"] = 30,
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.MP9.CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.MP9.CameraAnimations,
	["ShowCrosshair"] = true
}
return table.freeze(v2)