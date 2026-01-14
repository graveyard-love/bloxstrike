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
	["ReverseIcon"] = "rbxassetid://135022102978537",
	["Icon"] = "rbxassetid://115344320193773",
	["Cost"] = 2000,
	["BulletsPerShot"] = 6,
	["FireRate"] = 0.35,
	["Range"] = 120,
	["RangeModifier"] = 0.7,
	["ArmorPenetration"] = 0.8,
	["Penetration"] = 0.1,
	["Spread"] = {
		["Range"] = NumberRange.new(10, 15),
		["JumpShotMinimum"] = 12,
		["PerShot"] = 0.85,
		["RecoverySpeed"] = 4.25,
		["MovementMultiplier"] = 0.3
	},
	["Recoil"] = {
		["Pattern"] = v1.XM1014,
		["RecoverySpeed"] = 6,
		["CameraScale"] = 1,
		["Damper"] = 1,
		["Speed"] = 26,
		["Scale"] = 3.3
	},
	["WalkSpeed"] = 17.372,
	["RagdollMultiplier"] = 75,
	["DamagePerPart"] = {
		["Torso"] = 25,
		["Head"] = 80,
		["Arms"] = 20,
		["Legs"] = 15
	},
	["ReloadAnimationCount"] = 7,
	["Capacity"] = 32,
	["Rounds"] = 7,
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.XM1014.CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.XM1014.CameraAnimations,
	["ShowCrosshair"] = true
}
return table.freeze(v2)