-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_replicatedstorage.Database.Custom.Types)
local v1 = {
	["Droppable"] = true,
	["Team"] = "Both",
	["Type"] = "Equipment",
	["Class"] = "Grenade",
	["Slot"] = "Grenade",
	["ReverseIcon"] = "rbxassetid://81385239843859",
	["Icon"] = "rbxassetid://81385239843859",
	["Cost"] = 50,
	["Range"] = 60,
	["ArmorPenetration"] = 0.99,
	["WalkSpeed"] = 20.2,
	["RagdollMultiplier"] = 85,
	["DamagePerPart"] = {
		["Torso"] = 41,
		["Head"] = 48,
		["Arms"] = 31,
		["Legs"] = 28
	},
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations["Decoy Grenade"].CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations["Decoy Grenade"].CameraAnimations,
	["ShowCrosshair"] = true
}
return table.freeze(v1)