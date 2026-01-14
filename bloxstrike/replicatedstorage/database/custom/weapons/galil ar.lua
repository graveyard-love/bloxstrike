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
	["Team"] = "Terrorists",
	["AimingOptions"] = "None",
	["Type"] = "Rifle",
	["MuzzleType"] = "Rifle",
	["ReverseIcon"] = "rbxassetid://134169816848329",
	["Icon"] = "rbxassetid://75166557697975",
	["Cost"] = 1800,
	["BulletsPerShot"] = 1,
	["FireRate"] = 0.09,
	["Range"] = 1200,
	["RangeModifier"] = 0.98,
	["ArmorPenetration"] = 0.775,
	["Penetration"] = 0.5,
	["Spread"] = {
		["Range"] = NumberRange.new(0.25, 2.25),
		["JumpShotMinimum"] = 15,
		["PerShot"] = 0.32,
		["RecoverySpeed"] = 3.5,
		["MovementMultiplier"] = 1.4
	},
	["Recoil"] = {
		["Pattern"] = v1["Galil AR"],
		["RecoverySpeed"] = 6,
		["CameraScale"] = 0.3,
		["Damper"] = 1,
		["Speed"] = 26,
		["Scale"] = 2.3
	},
	["WalkSpeed"] = 17.372,
	["RagdollMultiplier"] = 45,
	["DamagePerPart"] = {
		["Torso"] = 37,
		["Head"] = 120,
		["Arms"] = 30,
		["Legs"] = 22
	},
	["ReloadAnimationCount"] = 1,
	["Capacity"] = 90,
	["Rounds"] = 35,
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations["Galil AR"].CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations["Galil AR"].CameraAnimations,
	["ShowCrosshair"] = true
}
return table.freeze(v2)