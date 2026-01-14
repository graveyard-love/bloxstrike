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
	["Team"] = "Both",
	["AimingOptions"] = "None",
	["Type"] = "SMG",
	["MuzzleType"] = "SMG",
	["ReverseIcon"] = "rbxassetid://82427629864307",
	["Icon"] = "rbxassetid://82724138944322",
	["Cost"] = 2350,
	["BulletsPerShot"] = 1,
	["FireRate"] = 0.07,
	["Range"] = 1200,
	["RangeModifier"] = 0.87,
	["ArmorPenetration"] = 0.69,
	["Penetration"] = 0.25,
	["Spread"] = {
		["Range"] = NumberRange.new(1, 1.5),
		["JumpShotMinimum"] = 10,
		["PerShot"] = 0.25,
		["RecoverySpeed"] = 5,
		["MovementMultiplier"] = 0.4
	},
	["Recoil"] = {
		["Pattern"] = v1.P90,
		["RecoverySpeed"] = 6,
		["CameraScale"] = 0.55,
		["Damper"] = 1,
		["Speed"] = 26,
		["Scale"] = 2.3
	},
	["WalkSpeed"] = 18.584,
	["RagdollMultiplier"] = 55,
	["DamagePerPart"] = {
		["Torso"] = 32,
		["Head"] = 103,
		["Arms"] = 25,
		["Legs"] = 19
	},
	["ReloadAnimationCount"] = 1,
	["Capacity"] = 100,
	["Rounds"] = 50,
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.P90.CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.P90.CameraAnimations,
	["ShowCrosshair"] = true
}
return table.freeze(v2)