-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v1 = require(v_replicatedstorage.Database.Components.Common.RecoilPatterns)
require(v_replicatedstorage.Database.Custom.Types)
local v2 = {
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
		["Pattern"] = v1.Nova,
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
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.Nova.CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.Nova.CameraAnimations,
	["ShowCrosshair"] = true
}
return table.freeze(v2)