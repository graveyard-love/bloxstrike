-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
local v1 = require(v_replicatedstorage.Database.Components.Common.RecoilPatterns)
require(v_replicatedstorage.Database.Custom.Types)
local v2 = {
	["HasSuppressor"] = false,
	["Automatic"] = true,
	["Droppable"] = true,
	["HasScope"] = true,
	["Slot"] = "Primary",
	["WallbangMultiplier"] = 0.7,
	["Class"] = "Weapon",
	["ShootingOptions"] = "Default",
	["Team"] = "Counter-Terrorists",
	["AimingOptions"] = "AutomaticScope",
	["Type"] = "Rifle",
	["MuzzleType"] = "Rifle",
	["ReverseIcon"] = "rbxassetid://125463512677698",
	["Icon"] = "rbxassetid://119885531832389",
	["Cost"] = 3300,
	["BulletsPerShot"] = 1,
	["FireRate"] = 0.1,
	["Range"] = 1200,
	["RangeModifier"] = 0.98,
	["ArmorPenetration"] = 0.9,
	["Penetration"] = 0.45,
	["Spread"] = {
		["Range"] = NumberRange.new(0.05, 2),
		["PerShot"] = 0.7,
		["RecoverySpeed"] = 5.5,
		["MovementMultiplier"] = 1.4
	},
	["Recoil"] = {
		["Pattern"] = v1.AUG,
		["RecoverySpeed"] = 7,
		["CameraScale"] = 0.5,
		["Damper"] = 1,
		["Speed"] = 25,
		["Scale"] = 1.7
	},
	["WalkSpeed"] = 17.776,
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
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.AUG.CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.AUG.CameraAnimations,
	["ShowCrosshair"] = true
}
return table.freeze(v2)