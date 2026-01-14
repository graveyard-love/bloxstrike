-- Decompiled with Bunni.lol Decompiler

local v_replicatedstorage = game:GetService("ReplicatedStorage")
require(v_replicatedstorage.Database.Custom.Types)
local v1 = {
	["Droppable"] = false,
	["Automatic"] = true,
	["Team"] = "Both",
	["Type"] = "Equipment",
	["Class"] = "Melee",
	["Slot"] = "Melee",
	["ReverseIcon"] = "rbxassetid://71818508657433",
	["Icon"] = "rbxassetid://91965772008164",
	["FireRate"] = 0.36,
	["Range"] = 3,
	["ArmorPenetration"] = 0.9,
	["WalkSpeed"] = 20.2,
	["RagdollMultiplier"] = 35,
	["DamagePerPart"] = {
		["Torso"] = 41,
		["Head"] = 48,
		["Arms"] = 31,
		["Legs"] = 28
	},
	["CharacterAnimations"] = v_replicatedstorage.Assets.WeaponAnimations["Gut Knife"].CharacterAnimations,
	["CameraAnimations"] = v_replicatedstorage.Assets.WeaponAnimations["Gut Knife"].CameraAnimations,
	["ShowCrosshair"] = true
}
return table.freeze(v1)