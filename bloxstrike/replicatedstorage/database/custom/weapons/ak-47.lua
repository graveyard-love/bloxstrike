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
	["WallbangMultiplier"] = 0.75,
	["Class"] = "Weapon",
	["ShootingOptions"] = "Default",
	["Team"] = "Terrorists",
	["AimingOptions"] = "None",
	["Type"] = "Rifle",
	["MuzzleType"] = "Rifle",
	["ReverseIcon"] = "rbxassetid://140617178427585",
	["Icon"] = "rbxassetid://83097083839889",
	["Cost"] = 2700,
	["BulletsPerShot"] = 1,
	["FireRate"] = 0.1,
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
		["Pattern"] = v1["AK-47"],
		["RecoverySpeed"] = 6,
		["CameraScale"] = 0.3,
		["Damper"] = 1,
		["Speed"] = 26,
		["Scale"] = 2.3
	},
	["WalkSpeed"] = 17.372,
	["RagdollMultiplier"] = 45,
	["DamagePerPart"] = {
		["Torso"] = 44,
		["Head"] = 143,
		["Arms"] = 35,
		["Legs"] = 21
	},
	["ReloadAnimationCount"] = 1,
	["Capacity"] = 90,
	["Rounds"] = 30,
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations["AK-47"].CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations["AK-47"].CameraAnimations,
	["ShowCrosshair"] = true
}
return table.freeze(v2)