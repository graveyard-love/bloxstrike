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
	["Team"] = "Counter-Terrorists",
	["AimingOptions"] = "None",
	["Type"] = "Pistol",
	["MuzzleType"] = "Pistol",
	["ReverseIcon"] = "rbxassetid://137381638975973",
	["Icon"] = "rbxassetid://90570942481875",
	["Cost"] = 500,
	["BulletsPerShot"] = 1,
	["FireRate"] = 0.15,
	["Range"] = 1200,
	["RangeModifier"] = 0.85,
	["ArmorPenetration"] = 0.85,
	["Penetration"] = 0,
	["Spread"] = {
		["Range"] = NumberRange.new(0.5, 5.5),
		["PerShot"] = 2,
		["RecoverySpeed"] = 3,
		["MovementMultiplier"] = 0.2
	},
	["Recoil"] = {
		["Pattern"] = v1["Five-SeveN"],
		["RecoverySpeed"] = 4,
		["CameraScale"] = 0.4,
		["Damper"] = 1,
		["Speed"] = 23,
		["Scale"] = 0.9
	},
	["WalkSpeed"] = 20.2,
	["RagdollMultiplier"] = 35,
	["DamagePerPart"] = {
		["Torso"] = 39,
		["Head"] = 120,
		["Arms"] = 30,
		["Legs"] = 23
	},
	["ReloadAnimationCount"] = 1,
	["Capacity"] = 100,
	["Rounds"] = 20,
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations["Five-SeveN"].CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations["Five-SeveN"].CameraAnimations,
	["ShowCrosshair"] = true
}
return table.freeze(v2)