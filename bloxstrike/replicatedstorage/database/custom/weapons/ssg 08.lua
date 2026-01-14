-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_replicatedstorage.Database.Custom.Types)
local v1 = {
	["HasSuppressor"] = false,
	["Automatic"] = false,
	["Droppable"] = true,
	["HasScope"] = true,
	["Slot"] = "Primary",
	["WallbangMultiplier"] = 0.98,
	["Class"] = "Weapon",
	["ShootingOptions"] = "Default",
	["Team"] = "Both",
	["AimingOptions"] = "SniperScope",
	["Type"] = "Rifle",
	["MuzzleType"] = "Sniper",
	["ReverseIcon"] = "rbxassetid://82274511356856",
	["Icon"] = "rbxassetid://112132914334737",
	["Cost"] = 1700,
	["BulletsPerShot"] = 1,
	["FireRate"] = 1.25,
	["Range"] = 1200,
	["RangeModifier"] = 0.98,
	["ArmorPenetration"] = 0.85,
	["Penetration"] = 1.5,
	["Spread"] = {
		["Range"] = NumberRange.new(0, 20),
		["PerShot"] = 0,
		["RecoverySpeed"] = 5,
		["MovementMultiplier"] = 2
	},
	["WalkSpeed"] = 18.584,
	["RagdollMultiplier"] = 60,
	["DamagePerPart"] = {
		["Torso"] = 99,
		["Head"] = 315,
		["Arms"] = 79,
		["Legs"] = 47
	},
	["ReloadAnimationCount"] = 1,
	["Capacity"] = 90,
	["Rounds"] = 10,
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations["SSG 08"].CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations["SSG 08"].CameraAnimations,
	["ShowCrosshair"] = false
}
return table.freeze(v1)