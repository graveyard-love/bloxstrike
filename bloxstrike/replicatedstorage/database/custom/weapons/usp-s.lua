-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v1 = require(v_replicatedstorage.Database.Components.Common.RecoilPatterns)
require(v_replicatedstorage.Database.Custom.Types)
local v2 = {
	["HasSuppressor"] = true,
	["Automatic"] = false,
	["Droppable"] = true,
	["HasScope"] = false,
	["Slot"] = "Secondary",
	["WallbangMultiplier"] = 0.4,
	["Class"] = "Weapon",
	["ShootingOptions"] = "Default",
	["Team"] = "Counter-Terrorists",
	["AimingOptions"] = "None",
	["Type"] = "Pistol",
	["MuzzleType"] = "Pistol",
	["ReverseIcon"] = "rbxassetid://93152953016540",
	["Icon"] = "rbxassetid://131658947857971",
	["Cost"] = 200,
	["BulletsPerShot"] = 1,
	["FireRate"] = 0.17,
	["Range"] = 1200,
	["RangeModifier"] = 0.91,
	["ArmorPenetration"] = 0.505,
	["Penetration"] = 0,
	["Spread"] = {
		["Range"] = NumberRange.new(0.5, 5),
		["PerShot"] = 1.3,
		["RecoverySpeed"] = 3,
		["MovementMultiplier"] = 0.18
	},
	["Recoil"] = {
		["Pattern"] = v1["USP-S"],
		["RecoverySpeed"] = 3.5,
		["CameraScale"] = 0.5,
		["Damper"] = 1,
		["Speed"] = 25,
		["Scale"] = 1
	},
	["WalkSpeed"] = 19.392,
	["RagdollMultiplier"] = 40,
	["DamagePerPart"] = {
		["Torso"] = 43,
		["Head"] = 140,
		["Arms"] = 34,
		["Legs"] = 26
	},
	["ReloadAnimationCount"] = 1,
	["Capacity"] = 24,
	["Rounds"] = 12,
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations["USP-S"].CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations["USP-S"].CameraAnimations,
	["ShowCrosshair"] = true
}
return table.freeze(v2)