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
	["ShootingOptions"] = "Burst",
	["Team"] = "Counter-Terrorists",
	["AimingOptions"] = "None",
	["Type"] = "Rifle",
	["MuzzleType"] = "Rifle",
	["ReverseIcon"] = "rbxassetid://133348453326383",
	["Icon"] = "rbxassetid://125469152582044",
	["Cost"] = 1950,
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
		["Pattern"] = v1.FAMAS,
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
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.FAMAS.CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.FAMAS.CameraAnimations,
	["ShowCrosshair"] = true
}
return table.freeze(v2)