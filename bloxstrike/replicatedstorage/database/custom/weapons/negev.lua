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
	["Type"] = "Heavy",
	["MuzzleType"] = "MachineGun",
	["ReverseIcon"] = "rbxassetid://75806785943496",
	["Icon"] = "rbxassetid://134163874921903",
	["Cost"] = 1700,
	["BulletsPerShot"] = 1,
	["FireRate"] = 0.075,
	["Range"] = 1200,
	["RangeModifier"] = 0.93,
	["ArmorPenetration"] = 0.75,
	["Penetration"] = 0.5,
	["Spread"] = {
		["Range"] = NumberRange.new(0.5, 5.5),
		["JumpShotMinimum"] = 15,
		["PerShot"] = 2.5,
		["RecoverySpeed"] = 4,
		["MovementMultiplier"] = 3
	},
	["Recoil"] = {
		["Pattern"] = v1.Negev,
		["RecoverySpeed"] = 6,
		["CameraScale"] = 0.55,
		["Damper"] = 1,
		["Speed"] = 26,
		["Scale"] = 2.7
	},
	["WalkSpeed"] = 12.12,
	["RagdollMultiplier"] = 65,
	["DamagePerPart"] = {
		["Torso"] = 36,
		["Head"] = 115,
		["Arms"] = 30,
		["Legs"] = 24
	},
	["ReloadAnimationCount"] = 1,
	["Capacity"] = 300,
	["Rounds"] = 150,
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.Negev.CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.Negev.CameraAnimations,
	["ShowCrosshair"] = true
}
return table.freeze(v2)