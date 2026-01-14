-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v1 = require(v_replicatedstorage.Database.Components.Common.RecoilPatterns)
require(v_replicatedstorage.Database.Custom.Types)
local v2 = {
	["HasSuppressor"] = false,
	["Automatic"] = false,
	["Droppable"] = true,
	["HasScope"] = false,
	["Slot"] = "Secondary",
	["WallbangMultiplier"] = 0.35,
	["Class"] = "Weapon",
	["ShootingOptions"] = "Default",
	["Team"] = "Terrorists",
	["AimingOptions"] = "None",
	["Type"] = "Pistol",
	["MuzzleType"] = "Pistol",
	["ReverseIcon"] = "rbxassetid://89081920349483",
	["Icon"] = "rbxassetid://119232881698906",
	["Cost"] = 500,
	["BulletsPerShot"] = 1,
	["FireRate"] = 0.12,
	["Range"] = 1200,
	["RangeModifier"] = 0.79,
	["ArmorPenetration"] = 0.9,
	["Penetration"] = 0,
	["Spread"] = {
		["Range"] = NumberRange.new(1, 9.5),
		["JumpShotMinimum"] = 60,
		["PerShot"] = 4.25,
		["RecoverySpeed"] = 5,
		["MovementMultiplier"] = 0.2
	},
	["Recoil"] = {
		["Pattern"] = v1["Tec-9"],
		["RecoverySpeed"] = 4,
		["CameraScale"] = 0.4,
		["Damper"] = 1,
		["Speed"] = 23,
		["Scale"] = 0.9
	},
	["WalkSpeed"] = 19.392,
	["RagdollMultiplier"] = 35,
	["DamagePerPart"] = {
		["Torso"] = 37,
		["Head"] = 119,
		["Arms"] = 30,
		["Legs"] = 22
	},
	["ReloadAnimationCount"] = 1,
	["Capacity"] = 90,
	["Rounds"] = 18,
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations["Tec-9"].CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations["Tec-9"].CameraAnimations,
	["ShowCrosshair"] = true
}
return table.freeze(v2)