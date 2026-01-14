-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_replicatedstorage.Database.Custom.Types)
local v1 = {
	["Droppable"] = true,
	["Team"] = "Both",
	["Type"] = "Equipment",
	["Class"] = "Grenade",
	["Slot"] = "Grenade",
	["ReverseIcon"] = "rbxassetid://132038996524430",
	["Icon"] = "rbxassetid://132038996524430",
	["Cost"] = 200,
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
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.Flashbang.CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations.Flashbang.CameraAnimations,
	["ShowCrosshair"] = true
}
return table.freeze(v1)